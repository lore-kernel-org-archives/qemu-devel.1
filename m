Received: from eggs.gnu.org ([2001:4830:134:3::10]:44276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QO-0008Fk-8y
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QM-0000F9-Uk
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ch9QM-0000F3-N2
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:14 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Feb 2017 14:32:02 +0800
Message-Id: <20170224063205.2537-3-famz@redhat.com>
In-Reply-To: <20170224063205.2537-1-famz@redhat.com>
References: <20170224063205.2537-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] new: debian docker targets for
 cross-compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This provides a basic Debian install with access to the emdebian cross
compilers. The debian-armhf-cross and debian-arm64-cross targets build
on the basic Debian image to allow cross compiling to those targets.

A new environment variable (QEMU_CONFIGURE_OPTS) is set as part of the
docker container and passed to the build to specify the
--cross-prefix. The user still calls the build in the usual way, for
example:

  make docker-test-build@debian-arm64-cross \
    TARGET_LIST=3D"aarch64-softmmu,aarch64-linux-user"

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170220105139.21581-3-alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include                      |  4 ++++
 tests/docker/common.rc                             |  2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker | 15 +++++++++++++
 tests/docker/dockerfiles/debian-armhf-cross.docker | 15 +++++++++++++
 tests/docker/dockerfiles/debian.docker             | 25 ++++++++++++++++=
++++++
 5 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 tests/docker/dockerfiles/debian-arm64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-armhf-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 3b5ffec..03eda37 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -54,6 +54,10 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE)),\
 		"BUILD","$*")
=20
+# Enforce dependancies for composite images
+docker-image-debian-armhf-cross: docker-image-debian
+docker-image-debian-arm64-cross: docker-image-debian
+
 # Expand all the pre-requistes for each docker image and test combinatio=
n
 $(foreach i,$(DOCKER_IMAGES), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 21657e8..6865689 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -29,7 +29,7 @@ build_qemu()
     config_opts=3D"--enable-werror \
                  ${TARGET_LIST:+--target-list=3D${TARGET_LIST}} \
                  --prefix=3D$PWD/install \
-                 $EXTRA_CONFIGURE_OPTS \
+                 $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS \
                  $@"
     echo "Configure options:"
     echo $config_opts
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/d=
ocker/dockerfiles/debian-arm64-cross.docker
new file mode 100644
index 0000000..592b5d7
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
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture arm64
+RUN apt update
+RUN apt install -yy crossbuild-essential-arm64
+RUN apt-get build-dep -yy -a arm64 qemu
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Daarch64-linux-gnu-
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/d=
ocker/dockerfiles/debian-armhf-cross.docker
new file mode 100644
index 0000000..668d60a
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
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture armhf
+RUN apt update
+RUN apt install -yy crossbuild-essential-armhf
+RUN apt-get build-dep -yy -a armhf qemu
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Darm-linux-gnueabihf-
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/docker=
files/debian.docker
new file mode 100644
index 0000000..52bd799
--- /dev/null
+++ b/tests/docker/dockerfiles/debian.docker
@@ -0,0 +1,25 @@
+#
+# Docker multiarch cross-compiler target
+#
+# This docker target is builds on Debian and Emdebian's cross compiler t=
argets
+# to build distro with a selection of cross compilers for building test =
binaries.
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
+RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt=
/sources.list
+RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key=
 | apt-key add -
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources=
.list
+
+# Install common build utilities
+RUN apt update
+RUN apt install -yy build-essential clang
--=20
2.9.3
