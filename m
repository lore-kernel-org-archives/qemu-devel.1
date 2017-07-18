Received: from eggs.gnu.org ([2001:4830:134:3::10]:48654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7F-00059C-K9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7E-0006QM-QE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:33 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ7E-0006Q0-KY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:32 -0400
Received: by mail-wr0-x233.google.com with SMTP id 12so23474495wrb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:52:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:45:07 +0100
Message-Id: <20170718104513.23947-27-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/32] docker: add debian/mips64el image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
2.13.0
