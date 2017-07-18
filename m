Received: from eggs.gnu.org ([2001:4830:134:3::10]:46557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0N-0007XG-Ti
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0N-0003Aa-0Y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:28 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0M-0003AK-Py
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:26 -0400
Received: by mail-wr0-x230.google.com with SMTP id y43so23109647wrd.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:26 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:48 +0100
Message-Id: <20170718104513.23947-8-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/32] docker: debian/s390x no more in unstable,
 now available in Stretch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 72bb52ad7b..84dce49655 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -59,6 +59,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
+docker-image-debian-s390x-cross: docker-image-debian9
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index cfc354ce5d..667e428a4c 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -1,27 +1,27 @@
 #
 # Docker s390 cross-compiler target
 #
-# This docker target is based on stretch (testing) as the stable build
-# doesn't have the cross compiler available.
+# This docker target builds on the debian Stretch base image.
 #
-FROM debian:testing-slim
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
+FROM qemu:debian9
 
 # Add the s390x architecture
 RUN dpkg --add-architecture s390x
 
 # Grab the updated list of packages
 RUN apt update && apt dist-upgrade -yy
-RUN apt install -yy build-essential clang
-RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
-RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        gcc-multilib-s390x-linux-gnu
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a s390x qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
 
-RUN DEBIAN_FRONTEND=noninteractive \
+# Install extra libraries to increase code coverage
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         glusterfs-common:s390x \
         libbz2-dev:s390x \
-- 
2.13.0
