FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS build

WORKDIR /app

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nodejs && \
    yes | apt-get install wget && \
    yes | wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && apt-get upgrade -y && \
    apt-get install apt-transport-https && \
    apt-get update && \
    yes | apt-get install dotnet-sdk-3.1
    

COPY . /app

CMD dotnet restore && \
    dotnet publish -c Release -o out && \
    dotnet clean && \
    dotnet build && \
    dotnet run

ENTRYPOINT [ "dotnet", "watch", "run", "--no-restore", "--urls", "http://0.0.0.0:5000"]

EXPOSE 5000
EXPOSE 5001
