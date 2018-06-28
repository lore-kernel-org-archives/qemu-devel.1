Received: from eggs.gnu.org ([2001:4830:134:3::10]:52587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa53-0007WT-T0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa50-0004vB-N3
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:37 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:40426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa50-0004uG-Hs
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:34 -0400
Received: by mail-qk0-x234.google.com with SMTP id b129-v6so3345095qke.7
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:47:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 13:46:42 -0300
Message-Id: <20180628164643.9668-8-f4bug@amsat.org>
In-Reply-To: <20180628164643.9668-1-f4bug@amsat.org>
References: <20180628164643.9668-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/8] docker: Cross build QEMU on ppc32 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Thomas Huth <huth@tuxfamily.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Since 08f56d8c9c the powerpc-cross image is no more based on Emdebian
but on the Sid release.

This patch restore the ability to cross build QEMU on powerpc, which
is interesting since it is a 32-bit host.

The ugly apt-fake script is, however, still required.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                 |  2 +
 tests/docker/dockerfiles/debian-apt-fake.sh   | 46 +++++++++++++++++++
 .../dockerfiles/debian-powerpc-cross.docker   | 43 +++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 301ee68ae6..d73d60cfbb 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -58,6 +58,8 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		"BUILD","$*")
 endif
 
+docker-image-debian-powerpc-cross: EXTRA_FILES:=$(SRC_PATH)/tests/docker/dockerfiles/debian-apt-fake.sh
+
 # Enforce dependencies for composite images
 docker-image-debian: docker-image-debian9
 docker-image-debian8-mxe: docker-image-debian8
diff --git a/tests/docker/dockerfiles/debian-apt-fake.sh b/tests/docker/dockerfiles/debian-apt-fake.sh
new file mode 100755
index 0000000000..2ec0fdf47a
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-apt-fake.sh
@@ -0,0 +1,46 @@
+#! /bin/sh
+#
+# Generate fake debian package to resolve unimportant unmet dependencies held
+# by upstream multiarch broken packages.
+#
+# Copyright (c) 2017 Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or (at your option) any later version. See the COPYING file in
+# the top-level directory.
+
+test $1 = "install" && shift 1
+
+fake_install()
+{
+    echo "Generating fake $2 $1 $3 ..."
+    (cd /var/cache/apt/archives
+        (cat << 'EOF'
+Section: misc
+Priority: optional
+Standards-Version: 3.9.2
+
+Package: NAME
+Version: VERSION
+Maintainer: qemu-devel@nongnu.org
+Architecture: any
+Multi-Arch: same
+Description: fake NAME
+EOF
+        ) | sed s/NAME/$2/g | sed s/VERSION/$3/g > $2.control
+        equivs-build -a $1 $2.control 1>/dev/null 2>/dev/null
+        dpkg -i --force-overwrite $2_$3_$1.deb
+    )
+}
+
+try_install()
+{
+    name=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\1/")
+    arch=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\2/")
+    vers=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\3/")
+    apt-get install -q -yy $1 || fake_install $arch $name $vers
+}
+
+for package in $*; do
+    try_install $package
+done
diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
index 5e62ca0df1..4ccd17d9d5 100644
--- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
+++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
@@ -11,3 +11,46 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         gcc-powerpc-linux-gnu \
         libc6-dev-powerpc-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
+
+# Setup some basic tools we need
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        bison \
+        binutils-multiarch \
+        build-essential \
+        ca-certificates \
+        curl \
+        flex \
+        gettext \
+        git \
+        gnupg \
+        pkg-config \
+        python-minimal
+
+RUN dpkg --add-architecture powerpc && \
+    apt-get update
+
+ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc-linux-gnu-
+
+# <kludge> to fix "following packages have unmet dependencies" ...
+ADD debian-apt-fake.sh /usr/local/bin/apt-fake
+RUN apt-get install -y --no-install-recommends \
+        equivs
+RUN apt-fake install \
+        glusterfs-common:powerpc=4.0.2-fake
+# </kludge>
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a powerpc qemu
+RUN DEBIAN_FRONTEND=noninteractive \
+    apt-get install -y --no-install-recommends \
+        glusterfs-common:powerpc \
+        libbz2-dev:powerpc \
+        liblzo2-dev:powerpc \
+        libncursesw5-dev:powerpc \
+        libnfs-dev:powerpc \
+        librdmacm-dev:powerpc \
+        libsnappy-dev:powerpc
-- 
2.18.0
