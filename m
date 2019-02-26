Received: from eggs.gnu.org ([209.51.188.92]:52793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gydSu-0008C4-8n
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gydSt-0003Rc-B0
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:12 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gydSt-0003QP-4c
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:11 -0500
Received: by mail-wm1-x336.google.com with SMTP id m1so2569861wml.2
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 06:12:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 26 Feb 2019 14:12:01 +0000
Message-Id: <20190226141201.16999-8-alex.bennee@linaro.org>
In-Reply-To: <20190226141201.16999-1-alex.bennee@linaro.org>
References: <20190226141201.16999-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/7] tests/Makefile.include: test all rounding
 modes of softfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, david@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

We missed a bug in a recent patch as we were not testing all the
rounding modes for all operations. However enabling all rounding modes
for mulAdd does slow down the already slowest test and doesn't really
buy us much additional coverage so lets allow the default test flags
to be overridden.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

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
