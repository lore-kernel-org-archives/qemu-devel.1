Received: from eggs.gnu.org ([209.51.188.92]:42537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFT-0000QU-CZ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFS-0007AA-JZ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:43 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFS-00078e-BE
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:42 -0500
Received: by mail-wm1-x341.google.com with SMTP id x7so10442235wmj.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:42 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:24 +0000
Message-Id: <20190228202537.4638-4-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 03/16] tests/tcg: add QEMU_OPT option for
 test runner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

This will allow tests to modify the QEMU invocation with for example
different -cpu stazas without having to define a whole new set of
runner types.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - default QEMU_OPTS to --monitor none for system emulation
---
 tests/tcg/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 55feab0f67..097e6374ea 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -54,10 +54,13 @@ LDFLAGS=
 # The QEMU for this TARGET
 ifdef CONFIG_USER_ONLY
 QEMU=../qemu-$(TARGET_NAME)
+QEMU_OPTS=
 else
 QEMU=../qemu-system-$(TARGET_NAME)
+QEMU_OPTS=--monitor none
 endif
 
+
 # If TCG debugging is enabled things are a lot slower
 ifeq ($(CONFIG_DEBUG_TCG),y)
 TIMEOUT=45
@@ -108,7 +111,7 @@ RUN_TESTS=$(patsubst %,run-%, $(TESTS))
 RUN_TESTS+=$(EXTRA_RUNS)
 
 run-%: %
-	$(call run-test, $<, $(QEMU) $<, "$< on $(TARGET_NAME)")
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<, "$< on $(TARGET_NAME)")
 
 .PHONY: run
 run: $(RUN_TESTS)
-- 
2.20.1
