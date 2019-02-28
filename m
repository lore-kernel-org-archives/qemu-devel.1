Received: from eggs.gnu.org ([209.51.188.92]:42589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFV-0000RR-4v
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFU-0007H1-BI
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFU-0007Cw-2W
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:44 -0500
Received: by mail-wm1-x342.google.com with SMTP id e74so10415264wmg.3
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:43 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:26 +0000
Message-Id: <20190228202537.4638-6-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/16] tests/tcg/mips: fix hello-mips
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The compilation flags for proper building are in the source tree. We
also fix exit to 0 so the result is counted as a success.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/mips/Makefile.target | 11 ++++-------
 tests/tcg/mips/hello-mips.c    |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 086625f533..1a994d5525 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -8,15 +8,12 @@ MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
 # Set search path for all sources
 VPATH 		+= $(MIPS_SRC)
 
+# hello-mips is 32 bit only
+ifeq ($(findstring 64,$(TARGET_NAME)),)
 MIPS_TESTS=hello-mips
 
 TESTS += $(MIPS_TESTS)
 
-hello-mips: CFLAGS+=-ffreestanding
+hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -mabi=32
 hello-mips: LDFLAGS+=-nostdlib
-
-# For MIPS32 and 64 we have a bunch of extra tests in sub-directories
-# however they are intended for system tests.
-
-run-hello-mips: hello-mips
-	$(call skip-test, $<, "BROKEN")
+endif
diff --git a/tests/tcg/mips/hello-mips.c b/tests/tcg/mips/hello-mips.c
index c7052fdf2e..4e1cf501af 100644
--- a/tests/tcg/mips/hello-mips.c
+++ b/tests/tcg/mips/hello-mips.c
@@ -60,5 +60,5 @@ static inline int write(int fd, const char *buf, int len)
 void __start(void)
 {
     write (1, "Hello, World!\n", 14);
-    exit1 (42);
+    exit1(0);
 }
-- 
2.20.1
