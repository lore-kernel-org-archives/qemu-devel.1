Received: from eggs.gnu.org ([2001:4830:134:3::10]:34264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGS6-0001L0-3z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGS3-0005OE-AI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:26 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGS3-0005O5-5X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:23 -0400
Received: by mail-qt0-x242.google.com with SMTP id j25so739899qtf.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:33:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:49 -0300
Message-Id: <20170718003159.10200-22-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 21/31] docker: add qemu:debian-jessie based
 on outdated jessie release
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian8.docker | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian8.docker

diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/dockerfiles/debian8.docker
new file mode 100644
index 0000000000..3d09b4b462
--- /dev/null
+++ b/tests/docker/dockerfiles/debian8.docker
@@ -0,0 +1,36 @@
+#
+# Docker multiarch cross-compiler target
+#
+# This docker target is builds on Debian and Emdebian's cross compiler targets
+# to build distro with a selection of cross compilers for building test binaries.
+#
+# On its own you can't build much but the docker-foo-cross targets
+# build on top of the base debian image.
+#
+FROM debian:jessie-slim
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+
+# Setup some basic tools we need
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        bison \
+        binutils-multiarch \
+        build-essential \
+        ca-certificates \
+        clang \
+        curl \
+        flex \
+        git \
+        gnupg \
+        pkg-config \
+        python-minimal
+
+# Setup Emdebian [emdebian-archive-keyring]
+RUN echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/emdebian.list && \
+    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
-- 
2.13.2
