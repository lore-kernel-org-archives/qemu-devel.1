Received: from eggs.gnu.org ([2001:4830:134:3::10]:34563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSV-0001n5-IF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSU-0005cM-G5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:51 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSU-0005cD-BI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:50 -0400
Received: by mail-qt0-x244.google.com with SMTP id l55so711410qtl.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:33:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:59 -0300
Message-Id: <20170718003159.10200-32-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 31/31] docker: add debian Ports base image
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
 tests/docker/dockerfiles/debian-ports.docker | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-ports.docker

diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docker/dockerfiles/debian-ports.docker
new file mode 100644
index 0000000000..907ebdef62
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-ports.docker
@@ -0,0 +1,34 @@
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
+        debian-ports-archive-keyring \
+        flex \
+        git \
+        pkg-config \
+        psmisc \
+        python \
+        texinfo \
+        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
-- 
2.13.2
