Received: from eggs.gnu.org ([2001:4830:134:3::10]:44075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZymu-0005Ld-GK
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZymq-0007Ol-QC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:24 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:44276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZymq-0007OA-EP
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:20 -0500
Received: by mail-qk0-x243.google.com with SMTP id u76so8418731qku.11
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 04:50:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 Jan 2018 09:49:58 -0300
Message-Id: <20180112125000.27256-6-f4bug@amsat.org>
In-Reply-To: <20180112125000.27256-1-f4bug@amsat.org>
References: <20180112125000.27256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/7] docker: warn users to use ubuntu16.04 for
 the LTS Xenial image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

deprecate the generic 'ubuntu' image, but stay backward incompatible

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include               |  3 ++-
 tests/docker/dockerfiles/ubuntu.docker      | 26 ++++++++++----------------
 tests/docker/dockerfiles/ubuntu16.04.docker | 16 ++++++++++++++++
 3 files changed, 28 insertions(+), 17 deletions(-)
 create mode 100644 tests/docker/dockerfiles/ubuntu16.04.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index f0cd26c2b6..b9b862654c 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -4,7 +4,7 @@
 
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
-DOCKER_DEPRECATED_IMAGES := debian
+DOCKER_DEPRECATED_IMAGES := debian ubuntu
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
@@ -61,6 +61,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian8-mxe
 docker-image-debian-win64-cross: docker-image-debian8-mxe
+docker-image-ubuntu: docker-image-ubuntu16.04
 docker-image-travis: NOUSER=1
 
 # Expand all the pre-requistes for each docker image and test combination
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index 686d90ae8c..808ea2bf38 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -1,16 +1,10 @@
-FROM ubuntu:16.04
-RUN apt-get update
-ENV PACKAGES flex bison \
-    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \
-    libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
-    libspice-protocol-dev libnss3-dev libfdt-dev \
-    libgtk-3-dev libvte-2.91-dev libsdl1.2-dev libpng12-dev libpixman-1-dev \
-    libvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librdmacm-dev libibverbs-dev \
-    libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-dev libbrlapi-dev libcurl4-gnutls-dev \
-    libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev libepoxy-dev libdrm-dev libgbm-dev \
-    libjemalloc-dev libcacard-dev libusbredirhost-dev libnfs-dev libcap-dev libattr1-dev \
-    texinfo \
-    gettext git make ccache python-yaml gcc clang sparse
-RUN apt-get -y install $PACKAGES
-RUN dpkg -l $PACKAGES | sort > /packages.txt
-ENV FEATURES clang pyyaml
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This template is deprecated, it was previously based on Xenial on QEMU 2.11.
+#
+FROM qemu:ubuntu16.04
+
+RUN for n in $(seq 8); do echo; done && \
+    echo "\n\t\tThis image is deprecated." && echo && \
+    echo "\tUse 'FROM qemu:ubuntu16.04' to use the Ubuntu Xenial LTS image" && \
+    for n in $(seq 8); do echo; done
diff --git a/tests/docker/dockerfiles/ubuntu16.04.docker b/tests/docker/dockerfiles/ubuntu16.04.docker
new file mode 100644
index 0000000000..ce7c5d3d33
--- /dev/null
+++ b/tests/docker/dockerfiles/ubuntu16.04.docker
@@ -0,0 +1,16 @@
+FROM ubuntu:16.04
+RUN apt-get update
+ENV PACKAGES flex bison \
+    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \
+    libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
+    libspice-protocol-dev libnss3-dev libfdt-dev \
+    libgtk-3-dev libvte-2.91-dev libsdl1.2-dev libpng12-dev libpixman-1-dev \
+    libvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librdmacm-dev libibverbs-dev \
+    libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-dev libbrlapi-dev libcurl4-gnutls-dev \
+    libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev libepoxy-dev libdrm-dev libgbm-dev \
+    libjemalloc-dev libcacard-dev libusbredirhost-dev libnfs-dev libcap-dev libattr1-dev \
+    texinfo \
+    gettext git make ccache python-yaml gcc clang sparse
+RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install $PACKAGES
+RUN dpkg -l $PACKAGES | sort > /packages.txt
+ENV FEATURES clang pyyaml
-- 
2.15.1
