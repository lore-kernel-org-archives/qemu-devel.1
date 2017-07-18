Received: from eggs.gnu.org ([2001:4830:134:3::10]:48703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7J-0005Ii-Fd
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7I-0006SE-Ic
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:37 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:32936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ7I-0006Rv-Bz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:36 -0400
Received: by mail-wr0-x22f.google.com with SMTP id a10so23705214wrd.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:52:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:45:11 +0100
Message-Id: <20170718104513.23947-31-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/32] docker: add debian Ports base image
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

diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docker/dockerfiles/debian-ports.docker
new file mode 100644
index 0000000000..fba224f760
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-ports.docker
@@ -0,0 +1,35 @@
+#
+# Docker multiarch cross-compiler target
+#
+# This docker target is builds on Debian Ports cross compiler targets
+# to build distro with a selection of cross compilers for building test binaries.
+#
+# On its own you can't build much but the docker-foo-cross targets
+# build on top of the base debian image.
+#
+FROM debian:unstable
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+RUN echo "deb [arch=amd64] http://deb.debian.org/debian unstable main" > /etc/apt/sources.list
+
+# Duplicate deb line as deb-src
+RUN cat /etc/apt/sources.list | sed -ne "s/^deb\ \(\[.*\]\ \)\?\(.*\)/deb-src \2/p" >> /etc/apt/sources.list
+
+# Setup some basic tools we need
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt-get install -yy eatmydata
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        bison \
+        build-essential \
+        ca-certificates \
+        clang \
+        debian-ports-archive-keyring \
+        flex \
+        git \
+        pkg-config \
+        psmisc \
+        python \
+        texinfo \
+        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
-- 
2.13.0
