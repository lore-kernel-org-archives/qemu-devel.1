Received: from eggs.gnu.org ([2001:4830:134:3::10]:43284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU5-00085m-V6
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU4-0000Vn-Rv
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:37 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU4-0000VD-Io
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:36 -0500
Received: by mail-wr1-x444.google.com with SMTP id q18so10897773wrx.9
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:36 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:22 +0000
Message-Id: <20181210152829.29271-7-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 06/13] tests/docker: add
 debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Xtensa cpu supported:
- dc232b
- dc233c
- csp

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles/debian-xtensa-cross.docker    | 31 +++++++++++++++++++
 tests/tcg/xtensa/Makefile.include             |  7 +++++
 2 files changed, 38 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-xtensa-cross.docker
 create mode 100644 tests/tcg/xtensa/Makefile.include

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
new file mode 100644
index 0000000000..afd2ab9163
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -0,0 +1,31 @@
+#
+# Docker cross-compiler target
+#
+# This docker target builds on the debian stretch base image,
+# using a prebuilt toolchains for Xtensa cores from:
+# https://github.com/foss-xtensa/toolchain/releases
+#
+FROM debian:stretch-slim
+
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        bison \
+        build-essential \
+        ca-certificates \
+        curl \
+        flex \
+        gettext \
+        git \
+        python-minimal
+
+ENV CPU_LIST csp dc232b dc233c
+ENV TOOLCHAIN_RELEASE 2018.02
+
+RUN for cpu in $CPU_LIST; do \
+        curl -#SL http://github.com/foss-xtensa/toolchain/releases/download/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
+        | tar -xzC /opt; \
+    done
+
+ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-csp-elf/bin
diff --git a/tests/tcg/xtensa/Makefile.include b/tests/tcg/xtensa/Makefile.include
new file mode 100644
index 0000000000..1454e7e821
--- /dev/null
+++ b/tests/tcg/xtensa/Makefile.include
@@ -0,0 +1,7 @@
+# Makefile.include for xtensa targets
+
+DOCKER_IMAGE=debian-xtensa-cross
+
+# default to the dc232b cpu
+DOCKER_CROSS_COMPILER=/opt/2018.02/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-gcc
+DOCKER_CROSS_LINKER=/opt/2018.02/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-ld
-- 
2.17.1
