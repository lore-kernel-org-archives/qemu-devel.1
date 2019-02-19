Received: from eggs.gnu.org ([209.51.188.92]:49678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvye4-0005fz-2G
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvye3-0007GE-Fv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:44 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvye3-0007EX-8s
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:43 -0500
Received: by mail-lj1-x242.google.com with SMTP id s5-v6so16324221ljd.12
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:43 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:11 -0800
Message-Id: <20190219061111.10231-24-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 23/23] tests/tcg/xtensa: add FPU2000
 coprocessor tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/Makefile           |  1 +
 tests/tcg/xtensa/test_fp_cpenable.S | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_fp_cpenable.S

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index 2b323adb8d46..2bd4491769d1 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -42,6 +42,7 @@ TESTCASES += test_flix.tst
 TESTCASES += test_fp0_arith.tst
 TESTCASES += test_fp0_conv.tst
 TESTCASES += test_fp1.tst
+TESTCASES += test_fp_cpenable.tst
 TESTCASES += test_interrupt.tst
 TESTCASES += test_loop.tst
 TESTCASES += test_lsc.tst
diff --git a/tests/tcg/xtensa/test_fp_cpenable.S b/tests/tcg/xtensa/test_fp_cpenable.S
new file mode 100644
index 000000000000..882bb2f3ceb1
--- /dev/null
+++ b/tests/tcg/xtensa/test_fp_cpenable.S
@@ -0,0 +1,27 @@
+#include "macros.inc"
+
+test_suite fp_cpenable
+
+#if XCHAL_HAVE_FP
+
+test rur
+    set_vector kernel, 2f
+    movi    a2, 0
+    wsr     a2, cpenable
+    isync
+1:
+    rur     a2, fsr
+    //wfr     f0, a2
+    test_fail
+2:
+    movi    a2, 1b
+    rsr     a3, epc1
+    assert  eq, a2, a3
+    movi    a2, 32
+    rsr     a3, exccause
+    assert  eq, a2, a3
+test_end
+
+#endif
+
+test_suite_end
-- 
2.11.0
