Received: from eggs.gnu.org ([2001:4830:134:3::10]:36735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qzL-0000D6-Eo
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qzI-0006w8-7x
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:43 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qzI-0006vy-33
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:40 -0400
Received: by mail-qk0-x244.google.com with SMTP id y128so12142665qka.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 15:18:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 19:17:49 -0300
Message-Id: <20170508221759.15616-12-f4bug@amsat.org>
In-Reply-To: <20170508221759.15616-1-f4bug@amsat.org>
References: <20170508221759.15616-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/21] docker: add mipsel build target
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
 tests/docker/Makefile.include                      |  3 +++
 .../docker/dockerfiles/debian-mipsel-cross.docker  | 31 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index c99ce702ea..f34282a2cb 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -55,9 +55,12 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXTRA_FILE),--include-file=$(EXTRA_FILE)),\
 		"BUILD","$*")
 
+docker-image-debian-mipsel-cross: EXTRA_FILE:=tests/docker/dockerfiles/debian-apt-fake.sh
+
 # Enforce dependancies for composite images
 docker-image-debian-armhf-cross: docker-image-debian
 docker-image-debian-arm64-cross: docker-image-debian
+docker-image-debian-mipsel-cross: docker-image-debian
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
new file mode 100644
index 0000000000..e4e8d22a7c
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -0,0 +1,31 @@
+#
+# Docker mipsel cross-compiler target
+#
+# This docker target builds on the base debian image.
+#
+FROM qemu:debian
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture mipsel && \
+    apt-get update && \
+    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
+        crossbuild-essential-mipsel
+
+# <kludge> to fix "following packages have unmet dependencies" ...
+ADD debian-apt-fake.sh /usr/local/bin/apt-fake
+RUN apt-get install -y --no-install-recommends equivs pkg-config && \
+    apt-fake install pkgconf:mipsel=0.9.7-fake pkg-config:mipsel=0.28-1.1-fake && \
+    ln -s pkg-config /usr/bin/mipsel-linux-gnu-pkg-config
+ENV PKG_CONFIG_PATH /usr/lib/mipsel-linux-gnu/pkgconfig
+# </kludge>
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata apt-get build-dep -yy -a mipsel qemu && \
+    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
+        glusterfs-common:mipsel \
+        libncursesw5-dev:mipsel libnfs-dev:mipsel \
+        libbz2-dev:mipsel liblzo2-dev:mipsel \
+        libsnappy-dev:mipsel librdmacm-dev:mipsel
-- 
2.11.0
