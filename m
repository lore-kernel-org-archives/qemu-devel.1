Received: from eggs.gnu.org ([2001:4830:134:3::10]:34401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSI-0001ch-Gd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSD-0005TU-ND
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:38 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSD-0005TC-JM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:33 -0400
Received: by mail-qk0-x243.google.com with SMTP id q66so734375qki.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:33:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:53 -0300
Message-Id: <20170718003159.10200-26-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 25/31] docker: add debian/mips[eb] images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

change image mips little -> big endian

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                      |  2 +-
 tests/docker/dockerfiles/debian-mips-cross.docker  | 29 ++++++++++++++++++++++
 .../docker/dockerfiles/debian-mipsel-cross.docker  |  9 ++++---
 3 files changed, 36 insertions(+), 4 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-mips-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 202efe9ee6..e0807c0917 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -62,7 +62,7 @@ docker-image-debian-amd64: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
-docker-image-debian-mipsel-cross: docker-image-debian9
+docker-image-debian-mips-cross: docker-image-debian9
 docker-image-debian-powerpc-cross: docker-image-debian8
 docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
diff --git a/tests/docker/dockerfiles/debian-mips-cross.docker b/tests/docker/dockerfiles/debian-mips-cross.docker
new file mode 100644
index 0000000000..550f43281b
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-mips-cross.docker
@@ -0,0 +1,29 @@
+#
+# Docker mips cross-compiler target
+#
+# This docker target builds on the debian Stretch base image.
+#
+FROM qemu:debian9
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture mips
+RUN apt-get update
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        gcc-mips-linux-gnu
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a mips qemu
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips-linux-gnu-
+
+# Install extra libraries to increase code coverage
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libbz2-dev:mips \
+        liblzo2-dev:mips \
+        librdmacm-dev:mips \
+        libsnappy-dev:mips
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index eb279c5044..6378bd41e7 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -4,6 +4,7 @@
 # This docker target builds on the debian Stretch base image.
 #
 FROM qemu:debian9
+
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
 # Add the foreign architecture we want and install dependencies
@@ -11,13 +12,15 @@ RUN dpkg --add-architecture mipsel
 RUN apt-get update
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        crossbuild-essential-mipsel
+        gcc-mipsel-linux-gnu
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a mipsel qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
 
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt-get build-dep -yy -a mipsel qemu
+# Install extra libraries to increase code coverage
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         libbz2-dev:mipsel \
-- 
2.13.2
