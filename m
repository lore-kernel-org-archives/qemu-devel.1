Received: from eggs.gnu.org ([2001:4830:134:3::10]:36921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Kc-000638-RD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KZ-0002Bm-9b
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:06 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7KZ-0002BD-2i
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:03 -0400
Received: by mail-wm0-x22f.google.com with SMTP id t70so17887333wmt.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:49:02 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:34 +0100
Message-Id: <20170717144848.11793-10-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 09/23] docker: add debian/armel based on
 Stretch
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                      |  1 +
 tests/docker/dockerfiles/debian-armel-cross.docker | 24 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 84dce49655..db66b6f802 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -56,6 +56,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		"BUILD","$*")
 
 # Enforce dependancies for composite images
+docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
new file mode 100644
index 0000000000..e3bd68f51e
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -0,0 +1,24 @@
+#
+# Docker armel cross-compiler target
+#
+# This docker target builds on the debian Stretch base image.
+#
+FROM qemu:debian9
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture armel && \
+    apt update
+RUN apt install -yy crossbuild-essential-armel
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a armel qemu
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabi-
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libbz2-dev:armel \
+        liblzo2-dev:armel \
+        librdmacm-dev:armel \
+        libsnappy-dev:armel
-- 
2.13.0
