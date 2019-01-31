Received: from eggs.gnu.org ([209.51.188.92]:51602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gpKV5-0000cg-Tj
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gpKL2-0002xC-18
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:57:37 -0500
Received: from ssl.serverraum.org ([2a01:4f8:151:8464::1:2]:55781)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1gpKL1-0002p7-Mv
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:57:35 -0500
From: Michael Walle <michael@walle.cc>
Date: Thu, 31 Jan 2019 22:56:09 +0100
Message-Id: <20190131215611.29341-2-michael@walle.cc>
In-Reply-To: <20190131215611.29341-1-michael@walle.cc>
References: <20190131215611.29341-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 1/3] tests/docker: add debian-lm32-cross
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Walle <michael@walle.cc>

Unfortunately, there is no debian package for the lm32 toolchain. To
keep the build times short, only build the binutils from scratch.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 tests/docker/Makefile.include                     |  5 ++--
 tests/docker/dockerfiles/debian-lm32-cross.docker | 31 +++++++++++++++++=
++++++
 2 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-lm32-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 0b9c8828e1..055bfc594d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -90,6 +90,7 @@ docker-image-debian-amd64: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
+docker-image-debian-lm32-cross: docker-image-debian9
 docker-image-debian-mips-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
 docker-image-debian-mips64el-cross: docker-image-debian9
@@ -114,8 +115,8 @@ docker-image-tricore-cross: docker-image-debian9
 # These images may be good enough for building tests but not for test bu=
ilds
 DOCKER_PARTIAL_IMAGES +=3D debian-alpha-cross debian-hppa-cross debian-m=
68k-cross debian-sh4-cross
 DOCKER_PARTIAL_IMAGES +=3D debian-sparc64-cross debian-mips64-cross debi=
an-riscv64-cross
-DOCKER_PARTIAL_IMAGES +=3D debian-tricore-cross debian-powerpc-cross fed=
ora-i386-cross
-DOCKER_PARTIAL_IMAGES +=3D fedora-cris-cross
+DOCKER_PARTIAL_IMAGES +=3D debian-tricore-cross debian-powerpc-cross deb=
ian-lm32-cross
+DOCKER_PARTIAL_IMAGES +=3D fedora-i386-cross fedora-cris-cross
=20
 # Rules for building linux-user powered images
 #
diff --git a/tests/docker/dockerfiles/debian-lm32-cross.docker b/tests/do=
cker/dockerfiles/debian-lm32-cross.docker
new file mode 100644
index 0000000000..1114d8ac6d
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-lm32-cross.docker
@@ -0,0 +1,31 @@
+#
+# Docker LatticeMico32 cross-compiler target
+#
+# This docker target builds on the debian Stretch base image.
+#
+# Copyright (c) 2019 Michael Walle
+# Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+FROM qemu:debian9
+
+MAINTAINER Michael Walle <michael@walle.cc>
+
+RUN apt-get update && \
+    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
+RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        wget
+
+ENV BINUTILS_VERSION 2.31
+
+RUN wget http://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.=
xz && \
+    tar -xJf binutils-$BINUTILS_VERSION.tar.xz -C /usr/src && \
+    cd /usr/src/binutils-$BINUTILS_VERSION && \
+    ./configure --prefix=3D/usr --disable-nls --target=3Dlm32-elf && \
+    make && make install && \
+    rm -rf /usr/src/binutils-$BINUTILS_VERSION
+
+# This image isn't designed for building QEMU but building tests
+ENV QEMU_CONFIGURE_OPTS --disable-system --disable-user
--=20
2.11.0
