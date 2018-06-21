Received: from eggs.gnu.org ([2001:4830:134:3::10]:56787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtI9-0004wh-HC
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtI8-0003Mp-Fa
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:01 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVtI8-0003ME-91
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:00 -0400
Received: by mail-wr0-x241.google.com with SMTP id w7-v6so1853728wrn.6
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:42:00 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:32 +0100
Message-Id: <20180621062605.941-25-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 24/57] tests/tcg: enable building for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

This allows us to use the docker cross compiler image to build these
tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
