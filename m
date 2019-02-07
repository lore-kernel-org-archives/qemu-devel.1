Received: from eggs.gnu.org ([209.51.188.92]:41171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYt-0000RL-Tv
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYr-0007l5-SM
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:11 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1groYr-0007Np-K2
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:09 -0500
Received: by mail-wr1-x42a.google.com with SMTP id a16so997547wrv.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:37:54 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  7 Feb 2019 18:37:35 +0000
Message-Id: <20190207183744.5054-8-alex.bennee@linaro.org>
In-Reply-To: <20190207183744.5054-1-alex.bennee@linaro.org>
References: <20190207183744.5054-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/16] docker: add debian-buster-arm64-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We can't build QEMU with this but we can use this image to build newer
arm64 testcases which need more up to date tools.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                 |  1 +
 .../debian-buster-arm64-cross.docker          | 15 +++++++++
 tests/docker/dockerfiles/debian10.docker      | 31 +++++++++++++++++++
 tests/tcg/aarch64/Makefile.include            |  2 +-
 4 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 tests/docker/dockerfiles/debian-buster-arm64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian10.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 7032c68895..83d43c50e4 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -90,6 +90,7 @@ docker-image-debian-amd64: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
+docker-image-debian-buster-arm64-cross: docker-image-debian10
 docker-image-debian-mips-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
 docker-image-debian-mips64el-cross: docker-image-debian9
diff --git a/tests/docker/dockerfiles/debian-buster-arm64-cross.docker b/tests/docker/dockerfiles/debian-buster-arm64-cross.docker
new file mode 100644
index 0000000000..33ada13806
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-buster-arm64-cross.docker
@@ -0,0 +1,15 @@
+#
+# Docker arm64 cross-compiler target
+#
+# This docker target builds on the Debian's Buster base image. There
+# are no QEMU pre-requistes so this image can only be used to build
+# test cases.
+#
+FROM qemu:debian10
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture arm64
+RUN apt update
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        crossbuild-essential-arm64
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
new file mode 100644
index 0000000000..aeeb151b52
--- /dev/null
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -0,0 +1,31 @@
+#
+# Docker multiarch cross-compiler target
+#
+# This docker target is builds on Debian cross compiler targets to build distro
+# with a selection of cross compilers for building test binaries.
+#
+# On its own you can't build much but the docker-foo-cross targets
+# build on top of the base debian image.
+#
+FROM debian:buster-slim
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+
+# Install common build utilities
+RUN apt update
+RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt install -y --no-install-recommends \
+        bison \
+        build-essential \
+        ca-certificates \
+        clang \
+        flex \
+        gettext \
+        git \
+        pkg-config \
+        psmisc \
+        python \
+        texinfo \
+        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
diff --git a/tests/tcg/aarch64/Makefile.include b/tests/tcg/aarch64/Makefile.include
index de32c91235..5d4e4c6f99 100644
--- a/tests/tcg/aarch64/Makefile.include
+++ b/tests/tcg/aarch64/Makefile.include
@@ -3,6 +3,6 @@
 # We don't have any bigendian build tools so we only use this for AArch64
 
 ifeq ($(TARGET_NAME),aarch64)
-DOCKER_IMAGE=debian-arm64-cross
+DOCKER_IMAGE=debian-buster-arm64-cross
 DOCKER_CROSS_COMPILER=aarch64-linux-gnu-gcc
 endif
-- 
2.20.1
