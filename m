Received: from eggs.gnu.org ([2001:4830:134:3::10]:35259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoO-0006gV-FG
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoN-0006TP-BR
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:52 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:55776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIoN-0006SM-34
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:51 -0400
Received: by mail-wm0-x22c.google.com with SMTP id v16-v6so1146979wmh.5
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:44:50 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:16 +0100
Message-Id: <20180619154435.18898-38-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/56] tests/tcg: enable building for sh4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As before, using Debian SID compilers. While the compiler can be
coerced into generating big-endian code it seems the linker can't deal
with it so we only enable the building for little endian SH4.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v5
   - add Makefile.target with EXTRA_RUNS for mmap tests

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 59dd8e314d..a2dd307a8e 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -73,6 +73,7 @@ docker-image-debian-sid: NOCACHE=1
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-debian-m68k-cross: docker-image-debian-sid
+docker-image-debian-sh4-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
diff --git a/tests/docker/dockerfiles/debian-sh4-cross.docker b/tests/docker/dockerfiles/debian-sh4-cross.docker
new file mode 100644
index 0000000000..88a2423094
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-sh4-cross.docker
@@ -0,0 +1,12 @@
+#
+# Docker cross-compiler target
+#
+# This docker target builds on the debian sid base image which
+# contains cross compilers for Debian "ports" targets.
+#
+FROM qemu:debian-sid
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        gcc-sh4-linux-gnu \
+        libc6-dev-sh4-cross
diff --git a/tests/tcg/sh4/Makefile.include b/tests/tcg/sh4/Makefile.include
new file mode 100644
index 0000000000..ad21594d9d
--- /dev/null
+++ b/tests/tcg/sh4/Makefile.include
@@ -0,0 +1,4 @@
+ifneq ($(TARGET_NAME), sh4eb)
+DOCKER_IMAGE=debian-sh4-cross
+DOCKER_CROSS_COMPILER=sh4-linux-gnu-gcc
+endif
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
new file mode 100644
index 0000000000..9d18d44612
--- /dev/null
+++ b/tests/tcg/sh4/Makefile.target
@@ -0,0 +1,7 @@
+# -*- Mode: makefile -*-
+#
+# SuperH specific tweaks
+#
+
+# On sh Linux supports 4k, 8k, 16k and 64k pages (but only 4k currently works)
+EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192 run-test-mmap-16384 run-test-mmap-65536
-- 
2.17.1
