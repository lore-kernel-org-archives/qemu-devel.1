Received: from eggs.gnu.org ([2001:4830:134:3::10]:39364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Sg-0005dS-Uv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Sf-0005vn-Rm
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:57:27 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7Sf-0005vG-Lu
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:57:25 -0400
Received: by mail-wm0-x22b.google.com with SMTP id 70so22946705wmo.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:57:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:47 +0100
Message-Id: <20170717144848.11793-23-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 22/23] docker: add debian/powerpc based on
 Jessie
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
[AJB: split from merged patch]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                      |  3 ++
 .../docker/dockerfiles/debian-powerpc-cross.docker | 40 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 8d45551476..51496ba485 100644
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
 docker-image-debian-amd64: docker-image-debian9
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
2.13.0
