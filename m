Received: from eggs.gnu.org ([2001:4830:134:3::10]:53742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZB-0000z8-IR
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZA-000485-P8
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:25 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZA-00047x-KC
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:24 -0400
Received: by mail-qt0-x244.google.com with SMTP id m54so15129949qtb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:10:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:47 -0300
Message-Id: <20170711031000.24844-6-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 05/18] docker: add debian/armel based on
 Stretch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                      |  1 +
 tests/docker/dockerfiles/debian-armel-cross.docker | 24 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 1eb32eebfa..238bb7276c 100644
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
2.13.2
