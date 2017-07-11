Received: from eggs.gnu.org ([2001:4830:134:3::10]:53906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZm-0001PT-Iq
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZi-0004QH-2y
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:02 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:35711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZh-0004QB-V3
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:58 -0400
Received: by mail-qt0-x22a.google.com with SMTP id b40so88710376qtb.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:10:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:59 -0300
Message-Id: <20170711031000.24844-18-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 17/18] shippable: add powerpc target
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml                                     |  2 ++
 tests/docker/Makefile.include                      |  3 ++
 .../docker/dockerfiles/debian-powerpc-cross.docker | 40 ++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker

diff --git a/.shippable.yml b/.shippable.yml
index 7a89341cea..4c8a85941f 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -18,6 +18,8 @@ env:
     # mips64el-softmmu disabled due to libfdt problem
     - IMAGE=debian-mipsel-cross
       TARGET_LIST=mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
+    - IMAGE=debian-powerpc-cross
+      TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index d2a81b0d71..a6babf4f1d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -55,11 +55,14 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
 		"BUILD","$*")
 
+docker-image-debian-powerpc-cross: EXTRA_FILES:=tests/docker/dockerfiles/debian-apt-fake.sh
+
 # Enforce dependancies for composite images
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
+docker-image-debian-powerpc-cross: docker-image-debian8
 docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-amd64-cross: docker-image-debian9
diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
new file mode 100644
index 0000000000..a5dd46b4ac
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
@@ -0,0 +1,40 @@
+#
+# Docker powerpc cross-compiler target
+#
+# This docker target builds on the debian Jessie base image.
+#
+FROM qemu:debian8
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture powerpc
+RUN apt-get update
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        crossbuild-essential-powerpc
+
+# <kludge> to fix "following packages have unmet dependencies" ...
+ADD debian-apt-fake.sh /usr/local/bin/apt-fake
+RUN apt-get install -y --no-install-recommends \
+        equivs \
+        pkg-config
+RUN apt-fake install \
+        pkg-config:powerpc=0.28-1.1-fake && \
+    ln -s pkg-config /usr/bin/powerpc-linux-gnu-pkg-config
+ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
+# </kludge>
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc-linux-gnu-
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
2.13.2
