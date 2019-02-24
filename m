Received: from eggs.gnu.org ([209.51.188.92]:53506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxvVe-0001DG-DX
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 10:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxvVc-0007t1-IT
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 10:16:06 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gxvVc-0007r6-C1
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 10:16:04 -0500
Received: by mail-wr1-x442.google.com with SMTP id w6so3929806wrs.4
	for <qemu-devel@nongnu.org>; Sun, 24 Feb 2019 07:15:59 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Sun, 24 Feb 2019 15:15:53 +0000
Message-Id: <20190224151553.31344-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tests/Makefile.include: test all rounding
 modes of softfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We missed a bug in a recent patch as we were not testing all the
rounding modes for all operations. However enabling all rounding modes
for mulAdd does slow down the already slowest test and doesn't really
buy us much additional coverage so lets allow the default test flags
to be overridden.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 060f765b0e..f260014f02 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -898,12 +898,12 @@ $(FP_TEST_BIN):
 # The full test suite can take a bit of time, default to a quick run
 # "-l 2 -r all" can take more than a day for some operations and is best
 # run manually
-FP_TL=-l 1
+FP_TL=-l 1 -r all
 
-# $1 = tests, $2 = description
+# $1 = tests, $2 = description, $3 = test flags
 test-softfloat = $(call quiet-command, \
 			cd $(BUILD_DIR)/tests/fp && \
-			./fp-test -s $(FP_TL) $1 > $2.out 2>&1 || \
+			./fp-test -s $(if $3,$3,$(FP_TL)) $1 > $2.out 2>&1 || \
 			(cat $2.out && exit 1;), \
 			"FLOAT TEST", $2)
 
@@ -984,7 +984,7 @@ check-softfloat-compare: $(SF_COMPARE_RULES)
 check-softfloat-mulAdd: $(FP_TEST_BIN)
 	$(call test-softfloat, \
 		f16_mulAdd f32_mulAdd f64_mulAdd f128_mulAdd, \
-		mulAdd)
+		mulAdd,-l 1)
 
 # FIXME: extF80_rem (broken)
 check-softfloat-rem: $(FP_TEST_BIN)
-- 
2.20.1
