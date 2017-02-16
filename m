Received: from eggs.gnu.org ([2001:4830:134:3::10]:48426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ceLH4-0007pN-UY
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ceLH1-0001E3-Nw
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:35:02 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ceLH1-0001DS-Ep
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:34:59 -0500
Received: by mail-wm0-x22f.google.com with SMTP id v186so65234112wmd.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 04:34:59 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 16 Feb 2017 12:34:54 +0000
Message-Id: <20170216123456.28621-3-alex.bennee@linaro.org>
In-Reply-To: <20170216123456.28621-1-alex.bennee@linaro.org>
References: <20170216123456.28621-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 2/4] new: debian docker targets for
 cross-compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This provides a basic Debian install with access to the emdebian cross
compilers. The debian-armhf-cross and debian-arm64-cross targets build
on the basic Debian image to allow cross compiling to those targets.

A new environment variable (QEMU_CONFIGURE_OPTS) is set as part of the
docker container and passed to the build to specify the
--cross-prefix. The user still calls the build in the usual way, for
example:

  make docker-test-build@debian-arm64-cross \
    TARGET_LIST="aarch64-softmmu,aarch64-linux-user"

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add clang (keep shippable happy)
  - rm adduser code (done direct now)
  - add aptitude (useful for debugging package clashes)
v3
  - split into debian, debian-armhf-cross and debian-aarch64-cross
v4
  - Add QEMU_CONFIGURE_OPTS
---
 tests/docker/Makefile.include                      |  4 ++++
 tests/docker/common.rc                             |  2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker | 15 +++++++++++++
 tests/docker/dockerfiles/debian-armhf-cross.docker | 15 +++++++++++++
 tests/docker/dockerfiles/debian.docker             | 25 ++++++++++++++++++++++
 5 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 tests/docker/dockerfiles/debian-arm64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-armhf-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 4778b27ca8..84bdcc944a 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -54,6 +54,10 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
 		"BUILD","$*")
 
+# Enforce dependancies for composite images
+docker-image-debian-armhf-cross: docker-image-debian
+docker-image-debian-arm64-cross: docker-image-debian
+
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 21657e87c6..6865689bb5 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -29,7 +29,7 @@ build_qemu()
     config_opts="--enable-werror \
                  ${TARGET_LIST:+--target-list=${TARGET_LIST}} \
                  --prefix=$PWD/install \
-                 $EXTRA_CONFIGURE_OPTS \
+                 $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS \
                  $@"
     echo "Configure options:"
     echo $config_opts
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
new file mode 100644
index 0000000000..ce90da943f
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -0,0 +1,15 @@
+#
+# Docker arm64 cross-compiler target
+#
+# This docker target builds on the base debian image.
+#
+FROM qemu:debian
+
+# Add the foreign architecture we want and install dependacies
+RUN dpkg --add-architecture arm64
+RUN apt update
+RUN apt install -yy crossbuild-essential-arm64
+RUN apt-get build-dep -yy -a arm64 qemu
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
new file mode 100644
index 0000000000..e0f81a556d
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -0,0 +1,15 @@
+#
+# Docker armhf cross-compiler target
+#
+# This docker target builds on the base debian image.
+#
+FROM qemu:debian
+
+# Add the foreign architecture we want and install dependacies
+RUN dpkg --add-architecture armhf
+RUN apt update
+RUN apt install -yy crossbuild-essential-armhf
+RUN apt-get build-dep -yy -a armhf qemu
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
new file mode 100644
index 0000000000..52bd79938e
--- /dev/null
+++ b/tests/docker/dockerfiles/debian.docker
@@ -0,0 +1,25 @@
+#
+# Docker multiarch cross-compiler target
+#
+# This docker target is builds on Debian and Emdebian's cross compiler targets
+# to build distro with a selection of cross compilers for building test binaries.
+#
+# On its own you can't build much but the docker-foo-cross targets
+# build on top of the base debian image.
+#
+FROM debian:stable-slim
+
+# Setup some basic tools we need
+RUN apt update
+RUN apt install -yy curl aptitude
+
+# Setup Emdebian
+RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
+RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
+
+# Install common build utilities
+RUN apt update
+RUN apt install -yy build-essential clang
-- 
2.11.0
