Received: from eggs.gnu.org ([2001:4830:134:3::10]:38921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvM-0004Ai-0j
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvA-0001h3-KY
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:03 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIv7-0001cu-DH
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:52 -0400
Received: by mail-wm0-x244.google.com with SMTP id r125-v6so1376201wmg.2
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:51:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:20 +0100
Message-Id: <20180619154435.18898-42-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 41/56] docker: move debian-powerpc-cross to sid
 based build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The original Jessie based cross builder hasn't worked for a while. The
state of the libraries is still perilous for cross-building QEMU but
we can use it for building TCG tests.

The debian-apt-fake.sh script can also be dropped as it is no longer
used.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index a680743ae8..87f449264f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -47,8 +47,6 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
 		"BUILD","$*")
 
-docker-image-debian-powerpc-cross: EXTRA_FILES:=$(SRC_PATH)/tests/docker/dockerfiles/debian-apt-fake.sh
-
 # Enforce dependencies for composite images
 docker-image-debian: docker-image-debian9
 docker-image-debian8-mxe: docker-image-debian8
@@ -59,7 +57,6 @@ docker-image-debian-arm64-cross: docker-image-debian9
 docker-image-debian-mips-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
 docker-image-debian-mips64el-cross: docker-image-debian9
-docker-image-debian-powerpc-cross: docker-image-debian8
 docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian8-mxe
@@ -77,6 +74,7 @@ docker-image-debian-sh4-cross: docker-image-debian-sid
 docker-image-debian-sparc64-cross: docker-image-debian-sid
 docker-image-debian-mips64-cross: docker-image-debian-sid
 docker-image-debian-riscv64-cross: docker-image-debian-sid
+docker-image-debian-powerpc-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
diff --git a/tests/docker/dockerfiles/debian-apt-fake.sh b/tests/docker/dockerfiles/debian-apt-fake.sh
deleted file mode 100755
index 2ec0fdf47a..0000000000
--- a/tests/docker/dockerfiles/debian-apt-fake.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#! /bin/sh
-#
-# Generate fake debian package to resolve unimportant unmet dependencies held
-# by upstream multiarch broken packages.
-#
-# Copyright (c) 2017 Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# This work is licensed under the terms of the GNU GPL, version 2
-# or (at your option) any later version. See the COPYING file in
-# the top-level directory.
-
-test $1 = "install" && shift 1
-
-fake_install()
-{
-    echo "Generating fake $2 $1 $3 ..."
-    (cd /var/cache/apt/archives
-        (cat << 'EOF'
-Section: misc
-Priority: optional
-Standards-Version: 3.9.2
-
-Package: NAME
-Version: VERSION
-Maintainer: qemu-devel@nongnu.org
-Architecture: any
-Multi-Arch: same
-Description: fake NAME
-EOF
-        ) | sed s/NAME/$2/g | sed s/VERSION/$3/g > $2.control
-        equivs-build -a $1 $2.control 1>/dev/null 2>/dev/null
-        dpkg -i --force-overwrite $2_$3_$1.deb
-    )
-}
-
-try_install()
-{
-    name=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\1/")
-    arch=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\2/")
-    vers=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\3/")
-    apt-get install -q -yy $1 || fake_install $arch $name $vers
-}
-
-for package in $*; do
-    try_install $package
-done
diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
index a5dd46b4ac..5e62ca0df1 100644
--- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
+++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
@@ -1,40 +1,13 @@
 #
 # Docker powerpc cross-compiler target
 #
-# This docker target builds on the debian Jessie base image.
+# This docker target builds on the debian sid base image which
+# contains cross compilers for Debian "ports" targets. The original
+# Jessie based no longer builds.
 #
-FROM qemu:debian8
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+FROM qemu:debian-sid
 
-# Add the foreign architecture we want and install dependencies
-RUN dpkg --add-architecture powerpc
-RUN apt-get update
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        crossbuild-essential-powerpc
-
-# <kludge> to fix "following packages have unmet dependencies" ...
-ADD debian-apt-fake.sh /usr/local/bin/apt-fake
-RUN apt-get install -y --no-install-recommends \
-        equivs \
-        pkg-config
-RUN apt-fake install \
-        pkg-config:powerpc=0.28-1.1-fake && \
-    ln -s pkg-config /usr/bin/powerpc-linux-gnu-pkg-config
-ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
-# </kludge>
-
-# Specify the cross prefix for this image (see tests/docker/common.rc)
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc-linux-gnu-
-
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt-get build-dep -yy -a powerpc qemu
-RUN DEBIAN_FRONTEND=noninteractive \
-    apt-get install -y --no-install-recommends \
-        glusterfs-common:powerpc \
-        libbz2-dev:powerpc \
-        liblzo2-dev:powerpc \
-        libncursesw5-dev:powerpc \
-        libnfs-dev:powerpc \
-        librdmacm-dev:powerpc \
-        libsnappy-dev:powerpc
+        gcc-powerpc-linux-gnu \
+        libc6-dev-powerpc-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/dockerfiles/debian8.docker
index 1bcf2e3d2f..52945631cd 100644
--- a/tests/docker/dockerfiles/debian8.docker
+++ b/tests/docker/dockerfiles/debian8.docker
@@ -32,6 +32,3 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         pkg-config \
         python-minimal
 
-# Setup Emdebian [emdebian-archive-keyring]
-RUN echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/emdebian.list && \
-    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
-- 
2.17.1
