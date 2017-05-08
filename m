Received: from eggs.gnu.org ([2001:4830:134:3::10]:36895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akc-0003je-7O
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akb-0007so-IJ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:26 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akb-0007sk-Dm
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:25 -0400
Received: by mail-qt0-x242.google.com with SMTP id l39so8242106qtb.1
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 21:58:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 01:57:02 -0300
Message-Id: <20170508045715.21770-11-f4bug@amsat.org>
In-Reply-To: <20170508045715.21770-1-f4bug@amsat.org>
References: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/23] docker: add mipsel build target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                      |  1 +
 .../docker/dockerfiles/debian-mipsel-cross.docker  | 23 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 03eda37bf4..ceff2c1654 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -57,6 +57,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 # Enforce dependancies for composite images
 docker-image-debian-armhf-cross: docker-image-debian
 docker-image-debian-arm64-cross: docker-image-debian
+docker-image-debian-mipsel-cross: docker-image-debian
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
new file mode 100644
index 0000000000..c569a2e1b4
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -0,0 +1,23 @@
+#
+# Docker mipsel cross-compiler target
+#
+# This docker target builds on the base debian image.
+#
+FROM qemu:debian
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture mipsel && \
+    apt-get update && \
+    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
+        crossbuild-essential-mipsel
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata apt-get build-dep -yy -a mipsel qemu && \
+    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
+        glusterfs-common:mipsel \
+        libncursesw5-dev:mipsel libnfs-dev:mipsel \
+        libbz2-dev:mipsel liblzo2-dev:mipsel \
+        libsnappy-dev:mipsel librdmacm-dev:mipsel
-- 
2.11.0
