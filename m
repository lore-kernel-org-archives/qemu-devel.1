Received: from eggs.gnu.org ([2001:4830:134:3::10]:39247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNh05-0003xh-GB
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNh00-0007pL-S4
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:57 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNh00-0007p0-LO
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:52 -0400
Received: by mail-wr0-x22d.google.com with SMTP id c11so82873896wrc.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:52:52 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:48:06 +0100
Message-Id: <20170621144814.15324-14-alex.bennee@linaro.org>
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/21] docker: add mipsel build target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
[AJB: remove apt-fake kludge]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 61cc0d14e2..037cb9e9e7 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -58,6 +58,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 # Enforce dependancies for composite images
 docker-image-debian-armhf-cross: docker-image-debian
 docker-image-debian-arm64-cross: docker-image-debian
+docker-image-debian-mipsel-cross: docker-image-debian
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
new file mode 100644
index 0000000000..2156bdb28d
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -0,0 +1,29 @@
+#
+# Docker mipsel cross-compiler target
+#
+# This docker target builds on the base debian image.
+#
+FROM qemu:debian
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture mipsel
+RUN apt-get update
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        crossbuild-essential-mipsel
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a mipsel qemu
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        glusterfs-common:mipsel \
+        libbz2-dev:mipsel \
+        liblzo2-dev:mipsel \
+        libncursesw5-dev:mipsel \
+        libnfs-dev:mipsel \
+        librdmacm-dev:mipsel \
+        libsnappy-dev:mipsel
-- 
2.13.0
