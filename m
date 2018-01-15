Received: from eggs.gnu.org ([2001:4830:134:3::10]:44764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5rH-00041X-Nw
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5rG-00016f-HW
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:35:31 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:40517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5rG-00016U-2w
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:35:30 -0500
Received: by mail-qt0-x244.google.com with SMTP id u42so14364840qte.7
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 06:35:29 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 11:34:58 -0300
Message-Id: <20180115143500.22631-8-f4bug@amsat.org>
In-Reply-To: <20180115143500.22631-1-f4bug@amsat.org>
References: <20180115143500.22631-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 7/8] docker: warn users to use newer
 fedora25/fedora27 base image
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

deprecate the generic 'fedora' image, but stay backward incompatible

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include            |  3 ++-
 tests/docker/dockerfiles/fedora.docker   | 29 ++++++++++++-----------------
 tests/docker/dockerfiles/fedora25.docker | 18 ++++++++++++++++++
 3 files changed, 32 insertions(+), 18 deletions(-)
 create mode 100644 tests/docker/dockerfiles/fedora25.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 1adea40499..950ef51d35 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -4,7 +4,7 @@
 
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
-DOCKER_DEPRECATED_IMAGES := debian ubuntu
+DOCKER_DEPRECATED_IMAGES := debian fedora ubuntu
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
@@ -61,6 +61,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian8-mxe
 docker-image-debian-win64-cross: docker-image-debian8-mxe
+docker-image-fedora: docker-image-fedora25
 docker-image-ubuntu: docker-image-ubuntu16.04
 docker-image-travis: NOUSER=1
 
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 4b26c3aded..961534275f 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,18 +1,13 @@
-FROM fedora:latest
-ENV PACKAGES \
-    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
-    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
-    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
-    nettle-devel \
-    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
-    mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
-    mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
-    mingw32-bzip2 \
-    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config \
-    mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
-    mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
-    mingw64-bzip2
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This template is deprecated, it was previously based on Fedora 25 on QEMU 2.9.
+# Now than more recent releases are out, please use qemu:fedora25 as base for
+# Fedora 25.
+#
+FROM qemu:fedora25
 
-RUN dnf install -y $PACKAGES
-RUN rpm -q $PACKAGES | sort > /packages.txt
-ENV FEATURES mingw clang pyyaml
+RUN for n in $(seq 8); do echo; done && \
+    echo "\n\t\tThis image is deprecated." && echo && \
+    echo "\tUse 'FROM qemu:fedora27' to use the Fedora 27 image" && \
+    echo "\tor 'FROM qemu:fedora25' to use the old Fedora 25." && \
+    for n in $(seq 8); do echo; done
diff --git a/tests/docker/dockerfiles/fedora25.docker b/tests/docker/dockerfiles/fedora25.docker
new file mode 100644
index 0000000000..b53fe63b5c
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora25.docker
@@ -0,0 +1,18 @@
+FROM fedora:25
+ENV PACKAGES \
+    ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
+    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
+    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
+    nettle-devel \
+    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
+    mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
+    mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
+    mingw32-bzip2 \
+    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config \
+    mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
+    mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
+    mingw64-bzip2
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV FEATURES mingw clang pyyaml
-- 
2.15.1
