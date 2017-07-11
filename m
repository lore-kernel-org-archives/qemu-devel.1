Received: from eggs.gnu.org ([2001:4830:134:3::10]:54314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlah-0002BN-9H
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlac-0004kS-V9
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:59 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlac-0004kE-Rk
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:54 -0400
Received: by mail-qt0-f193.google.com with SMTP id v31so15144337qtb.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:11:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:58 -0300
Message-Id: <20170711031000.24844-17-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 16/18] docker: add qemu:debian-jessie based
 on outdated jessie release
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
 tests/docker/dockerfiles/debian8.docker | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian8.docker

diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/dockerfiles/debian8.docker
new file mode 100644
index 0000000000..ea9083633a
--- /dev/null
+++ b/tests/docker/dockerfiles/debian8.docker
@@ -0,0 +1,31 @@
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
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# Setup some basic tools we need
+RUN apt update
+RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt install -y --no-install-recommends \
+        bison \
+        build-essential \
+        ca-certificates \
+        clang \
+        curl \
+        flex \
+        git \
+        pkg-config \
+        python-minimal
+
+# Duplicate deb line as deb-src, setup Emdebian
+RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list && \
+    echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
+    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
-- 
2.13.2
