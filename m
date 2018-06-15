Received: from eggs.gnu.org ([2001:4830:134:3::10]:52438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugu-0002cf-2L
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugs-0005eM-Vi
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:24 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTugs-0005dR-Ob
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:22 -0400
Received: by mail-wr0-x242.google.com with SMTP id e18-v6so10983565wrs.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:47:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:34 +0100
Message-Id: <20180615194705.28019-24-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 23/54] tests/tcg: enable building for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

This allows us to use the docker cross compiler image to build these
tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v5
  - add EXTRA_RUNS for mmap tests
---
 tests/tcg/arm/Makefile.include | 8 ++++++++
 tests/tcg/arm/Makefile.target  | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/arm/Makefile.include

diff --git a/tests/tcg/arm/Makefile.include b/tests/tcg/arm/Makefile.include
new file mode 100644
index 0000000000..8e7eac008f
--- /dev/null
+++ b/tests/tcg/arm/Makefile.include
@@ -0,0 +1,8 @@
+# Makefile.include for all ARM targets
+#
+# We don't have any bigendian build tools so we only use this for armhf
+
+ifeq ($(TARGET_NAME),arm)
+DOCKER_IMAGE=debian-armhf-cross
+DOCKER_CROSS_COMPILER=arm-linux-gnueabihf-gcc
+endif
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index bc6962ecc6..0312293dca 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -1,6 +1,6 @@
 # -*- Mode: makefile -*-
 #
-# ARM - included from tests/tcg/Makefile.target
+# ARM - included from tests/tcg/Makefile
 #
 
 ARM_SRC=$(SRC_PATH)/tests/tcg/arm
@@ -11,3 +11,6 @@ VPATH 		+= $(ARM_SRC)
 
 hello-arm: CFLAGS+=-marm -ffreestanding
 hello-arm: LDFLAGS+=-nostdlib
+
+# On ARM Linux only supports 4k pages
+EXTRA_RUNS+=run-test-mmap-4096
-- 
2.17.1
