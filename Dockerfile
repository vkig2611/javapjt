# Step 1: Use an official Maven image to build the application
FROM maven:3.8-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and src folder into the container
COPY pom.xml .
COPY src ./src

# Build the application (creates a .jar file in the target folder)
RUN mvn clean package

# Step 2: Use OpenJDK image to run the app
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/hello-world-1.0-SNAPSHOT.jar .

# Run the application
CMD ["java", "-jar", "hello-world-1.0-SNAPSHOT.jar"]

