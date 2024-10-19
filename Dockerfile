FROM eclipse-temurin:8 AS builder

WORKDIR /app

RUN apt update && apt install -y git
RUN curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar --o dist --rev 1.8.8



FROM eclipse-temurin:8 AS runner

WORKDIR /app

COPY --from=builder /app/dist/spigot-1.8.8.jar .
COPY ./plugins ./plugins

CMD ["java", "-Dcom.mojang.eula.agree=true", "-jar", "spigot-1.8.8.jar", "--max-players", "40", "--world-dir", "./world", "nogui"]