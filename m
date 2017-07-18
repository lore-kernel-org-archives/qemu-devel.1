Received: from eggs.gnu.org ([2001:4830:134:3::10]:34418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSK-0001d0-84
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSI-0005VQ-Pq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:40 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSI-0005VB-Le
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:38 -0400
Received: by mail-qt0-x243.google.com with SMTP id l55so711116qtl.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:33:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:55 -0300
Message-Id: <20170718003159.10200-28-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 27/31] docker: add debian/mips64el image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                      |  1 +
 .../dockerfiles/debian-mips64el-cross.docker       | 30 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-mips64el-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index e0807c0917..5a8283674a 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -63,6 +63,7 @@ docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
 docker-image-debian-mips-cross: docker-image-debian9
+docker-image-debian-mips64el-cross: docker-image-debian9
 docker-image-debian-powerpc-cross: docker-image-debian8
 docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
new file mode 100644
index 0000000000..fd2aafeb01
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -0,0 +1,30 @@
+#
+# Docker mips64el cross-compiler target
+#
+# This docker target builds on the debian Stretch base image.
+#
+
+FROM qemu:debian9
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture mips64el && \
+    apt-get update
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        gcc-mips64el-linux-gnuabi64
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a mips64el qemu
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
+
+# Install extra libraries to increase code coverage
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libbz2-dev:mips64el \
+        liblzo2-dev:mips64el \
+        librdmacm-dev:mips64el \
+        libsnappy-dev:mips64el
-- 
2.13.2
