Received: from eggs.gnu.org ([2001:4830:134:3::10]:52436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugu-0002cd-1L
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugr-0005bn-8N
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:23 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTugr-0005aN-1A
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:21 -0400
Received: by mail-wr0-x244.google.com with SMTP id l10-v6so10991728wrn.2
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:47:20 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:33 +0100
Message-Id: <20180615194705.28019-23-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 22/54] tests/tcg: move ARM specific tests
 into subdir
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

These only need to be built for ARM guests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - do VPATH manipulation in tests/tcg/arm/Makefile.target
  - merge with fix hello-arm test
v4
  - update MAINTAINERS
---
 MAINTAINERS                           |  1 +
 tests/tcg/README                      |  9 ---------
 tests/tcg/arm/Makefile.target         | 13 +++++++++++++
 tests/tcg/arm/README                  | 11 +++++++++++
 tests/tcg/{ => arm}/hello-arm.c       |  0
 tests/tcg/{ => arm}/test-arm-iwmmxt.s |  0
 6 files changed, 25 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/README
 rename tests/tcg/{ => arm}/hello-arm.c (100%)
 rename tests/tcg/{ => arm}/test-arm-iwmmxt.s (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57c828644f..75a163f557 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -135,6 +135,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: target/arm/
+F: tests/tcg/arm/
 F: hw/arm/
 F: hw/cpu/a*mpcore.c
 F: include/hw/cpu/a*mpcore.h
diff --git a/tests/tcg/README b/tests/tcg/README
index 469504c4cb..625f2326e6 100644
--- a/tests/tcg/README
+++ b/tests/tcg/README
@@ -5,15 +5,6 @@ or they are architecture specific.
 
 
 
-ARM
-===
-
-hello-arm
----------
-
-test-arm-iwmmxt
----------------
-
 MIPS
 ====
 
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
new file mode 100644
index 0000000000..bc6962ecc6
--- /dev/null
+++ b/tests/tcg/arm/Makefile.target
@@ -0,0 +1,13 @@
+# -*- Mode: makefile -*-
+#
+# ARM - included from tests/tcg/Makefile.target
+#
+
+ARM_SRC=$(SRC_PATH)/tests/tcg/arm
+
+# Set search path for all sources
+VPATH 		+= $(ARM_SRC)
+
+
+hello-arm: CFLAGS+=-marm -ffreestanding
+hello-arm: LDFLAGS+=-nostdlib
diff --git a/tests/tcg/arm/README b/tests/tcg/arm/README
new file mode 100644
index 0000000000..e6307116e2
--- /dev/null
+++ b/tests/tcg/arm/README
@@ -0,0 +1,11 @@
+These are ARM specific guest programs
+
+hello-arm
+---------
+
+A very simple inline assembly, write syscall based hello world
+
+test-arm-iwmmxt
+---------------
+
+A simple test case for older iwmmxt extended ARMs
diff --git a/tests/tcg/hello-arm.c b/tests/tcg/arm/hello-arm.c
similarity index 100%
rename from tests/tcg/hello-arm.c
rename to tests/tcg/arm/hello-arm.c
diff --git a/tests/tcg/test-arm-iwmmxt.s b/tests/tcg/arm/test-arm-iwmmxt.s
similarity index 100%
rename from tests/tcg/test-arm-iwmmxt.s
rename to tests/tcg/arm/test-arm-iwmmxt.s
-- 
2.17.1
