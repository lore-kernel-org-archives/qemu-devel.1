Received: from eggs.gnu.org ([2001:4830:134:3::10]:39059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvR-0004E7-GE
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvG-0001pj-9u
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:09 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:39348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIvF-0001oB-R1
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:58 -0400
Received: by mail-wm0-x236.google.com with SMTP id p11-v6so1346770wmc.4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:51:57 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:19 +0100
Message-Id: <20180619154435.18898-41-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/56] tests/tcg: enable building for RISCV64
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

As before, using Debian SID compilers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 8fd4041716..a680743ae8 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -76,6 +76,7 @@ docker-image-debian-m68k-cross: docker-image-debian-sid
 docker-image-debian-sh4-cross: docker-image-debian-sid
 docker-image-debian-sparc64-cross: docker-image-debian-sid
 docker-image-debian-mips64-cross: docker-image-debian-sid
+docker-image-debian-riscv64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
new file mode 100644
index 0000000000..2b2e64cee6
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
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
+        gcc-riscv64-linux-gnu \
+        libc6-dev-riscv64-cross
diff --git a/tests/tcg/riscv/Makefile.include b/tests/tcg/riscv/Makefile.include
new file mode 100644
index 0000000000..d92ac6c89f
--- /dev/null
+++ b/tests/tcg/riscv/Makefile.include
@@ -0,0 +1,10 @@
+#
+# Makefile.include for all RISCV targets
+#
+# Debian only really cares about 64 bit going forward
+#
+
+ifeq ($(TARGET_NAME),riscv64)
+DOCKER_IMAGE=debian-riscv64-cross
+DOCKER_CROSS_COMPILER=riscv64-linux-gnu-gcc
+endif
-- 
2.17.1
