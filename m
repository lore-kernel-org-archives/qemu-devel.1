Received: from eggs.gnu.org ([2001:4830:134:3::10]:54130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlaG-0001mW-Iu
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlaB-0004af-SY
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:32 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlaB-0004aX-Nt
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:27 -0400
Received: by mail-qk0-f196.google.com with SMTP id 16so15382878qkg.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:11:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:48 -0300
Message-Id: <20170711031000.24844-7-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 06/18] docker: add debian/ppc64el based on
 Stretch
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
---
 tests/docker/Makefile.include                      |  1 +
 .../docker/dockerfiles/debian-ppc64el-cross.docker | 24 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-ppc64el-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 238bb7276c..59b08b4aca 100644
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
index 0000000000..f34f09a8cd
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -0,0 +1,24 @@
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
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libbz2-dev:ppc64el \
+        liblzo2-dev:ppc64el \
+        librdmacm-dev:ppc64el \
+        libsnappy-dev:ppc64el
-- 
2.13.2
