Received: from eggs.gnu.org ([2001:4830:134:3::10]:46666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0W-0007gd-Sy
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0V-0003FU-TP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:36 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:32851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0V-0003F5-Mq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:35 -0400
Received: by mail-wr0-x234.google.com with SMTP id a10so23441737wrd.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:52 +0100
Message-Id: <20170718104513.23947-12-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/32] docker: add debian/ppc64el based on
 Stretch
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
index db66b6f802..553465ef6d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -60,6 +60,7 @@ docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
+docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
 
 # Expand all the pre-requistes for each docker image and test combination
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
new file mode 100644
index 0000000000..f44a35880a
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -0,0 +1,25 @@
+#
+# Docker ppc64el cross-compiler target
+#
+# This docker target builds on the debian Stretch base image.
+#
+FROM qemu:debian9
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture ppc64el && \
+    apt update
+RUN apt install -yy crossbuild-essential-ppc64el
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a ppc64el qemu
+
+# Specify the cross prefix for this image (see tests/docker/common.rc)
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc64le-linux-gnu-
+
+# Install extra libraries to increase code coverage
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libbz2-dev:ppc64el \
+        liblzo2-dev:ppc64el \
+        librdmacm-dev:ppc64el \
+        libsnappy-dev:ppc64el
-- 
2.13.0
