Received: from eggs.gnu.org ([2001:4830:134:3::10]:48537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZn-0001ZE-4M
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZk-0007Jf-PE
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:39 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZk-0007JQ-K8
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:36 -0400
Received: by mail-oi0-x242.google.com with SMTP id m17so18049285oik.2
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 20:30:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 21 May 2017 00:29:46 -0300
Message-Id: <20170521032956.27446-15-f4bug@amsat.org>
In-Reply-To: <20170521032956.27446-1-f4bug@amsat.org>
References: <20170521032956.27446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 14/24] docker: add mipsel build target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Riku Voipio <riku.voipio@iki.fi>, Vagrant Cascadian <vagrant@debian.org>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                      |  3 ++
 .../docker/dockerfiles/debian-mipsel-cross.docker  | 41 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 58bf249f02..111b8090b2 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -55,9 +55,12 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXTRA_FILES),--include-files $(EXTRA_FILES)),\
 		"BUILD","$*")
 
+docker-image-debian-mipsel-cross: EXTRA_FILES:=tests/docker/dockerfiles/debian-apt-fake.sh
+
 # Enforce dependancies for composite images
 docker-image-debian-armhf-cross: docker-image-debian
 docker-image-debian-arm64-cross: docker-image-debian
+docker-image-debian-mipsel-cross: docker-image-debian
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
new file mode 100644
index 0000000000..bda9fac9d9
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -0,0 +1,41 @@
+#
+# Docker mipsel cross-compiler target
+#
+# This docker target builds on the base debian image.
+#
+FROM qemu:debian
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture mipsel
+RUN apt-get update
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        crossbuild-essential-mipsel
+
+# <kludge> to fix "following packages have unmet dependencies" ...
+ADD debian-apt-fake.sh /usr/local/bin/apt-fake
+RUN apt-get install -y --no-install-recommends \
+        equivs \
+        pkg-config
+RUN apt-fake install \
+        pkgconf:mipsel=0.9.7-fake \
+        pkg-config:mipsel=0.28-1.1-fake && \
+    ln -s pkg-config /usr/bin/mipsel-linux-gnu-pkg-config
+ENV PKG_CONFIG_PATH /usr/lib/mipsel-linux-gnu/pkgconfig
+# </kludge>
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a mipsel qemu
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        glusterfs-common:mipsel \
+        libbz2-dev:mipsel \
+        liblzo2-dev:mipsel \
+        libncursesw5-dev:mipsel \
+        libnfs-dev:mipsel \
+        librdmacm-dev:mipsel \
+        libsnappy-dev:mipsel
-- 
2.11.0
