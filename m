Received: from eggs.gnu.org ([209.51.188.92]:49660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvye2-0005cX-Gv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvye1-0007EL-HG
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:42 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:37955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvye1-0007E5-9X
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:41 -0500
Received: by mail-lj1-x243.google.com with SMTP id j19so15592599ljg.5
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:41 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:10 -0800
Message-Id: <20190219061111.10231-23-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 22/23] tests/tcg/xtensa: add FP1 group tests
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

Test comparisons and conditional move operations.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/Makefile   |   1 +
 tests/tcg/xtensa/test_fp1.S | 141 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_fp1.S

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index b1d9953f6704..2b323adb8d46 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -41,6 +41,7 @@ TESTCASES += test_fail.tst
 TESTCASES += test_flix.tst
 TESTCASES += test_fp0_arith.tst
 TESTCASES += test_fp0_conv.tst
+TESTCASES += test_fp1.tst
 TESTCASES += test_interrupt.tst
 TESTCASES += test_loop.tst
 TESTCASES += test_lsc.tst
diff --git a/tests/tcg/xtensa/test_fp1.S b/tests/tcg/xtensa/test_fp1.S
new file mode 100644
index 000000000000..6e182e5964bd
--- /dev/null
+++ b/tests/tcg/xtensa/test_fp1.S
@@ -0,0 +1,141 @@
+#include "macros.inc"
+
+test_suite fp1
+
+#if XCHAL_HAVE_FP
+
+.macro movfp fr, v
+    movi    a2, \v
+    wfr     \fr, a2
+.endm
+
+.macro test_ord_ex op, br, fr0, fr1, v0, v1, r
+    movi    a2, 0
+    wur     a2, fsr
+    movfp   \fr0, \v0
+    movfp   \fr1, \v1
+    \op     \br, \fr0, \fr1
+    movi    a2, 0
+    movi    a3, 1
+    movt    a2, a3, \br
+    assert  eqi, a2, \r
+    rur     a2, fsr
+    assert  eqi, a2, 0
+.endm
+
+.macro test_ord op, br, fr0, fr1, v0, v1, r
+    movi    a2, 0
+    wur     a2, fcr
+    test_ord_ex \op, \br, \fr0, \fr1, \v0, \v1, \r
+    movi    a2, 0x7c
+    wur     a2, fcr
+    test_ord_ex \op, \br, \fr0, \fr1, \v0, \v1, \r
+.endm
+
+.macro test_ord_all op, aa, ab, ba, aPI, PIa, aN, Na, II, IN, NI
+    test_ord \op  b0,  f0,  f1, 0x3f800000, 0x3f800000, \aa
+    test_ord \op  b1,  f2,  f3, 0x3f800000, 0x3fc00000, \ab
+    test_ord \op  b2,  f4,  f5, 0x3fc00000, 0x3f800000, \ba
+    test_ord \op  b3,  f6,  f7, 0x3f800000, 0x7f800000, \aPI
+    test_ord \op  b4,  f8,  f9, 0x7f800000, 0x3f800000, \PIa
+    test_ord \op  b5, f10, f11, 0x3f800000, 0xffc00001, \aN
+    test_ord \op  b6, f12, f13, 0x3f800000, 0xff800001, \aN
+    test_ord \op  b7, f14, f15, 0x3f800000, 0x7f800001, \aN
+    test_ord \op  b8,  f0,  f1, 0x3f800000, 0x7fc00000, \aN
+    test_ord \op  b9,  f2,  f3, 0xffc00001, 0x3f800000, \Na
+    test_ord \op b10,  f4,  f5, 0xff800001, 0x3f800000, \Na
+    test_ord \op b11,  f6,  f7, 0x7f800001, 0x3f800000, \Na
+    test_ord \op b12,  f8,  f9, 0x7fc00000, 0x3f800000, \Na
+    test_ord \op b13, f10, f11, 0x7f800000, 0x7f800000, \II
+    test_ord \op b14, f12, f13, 0x7f800000, 0x7fc00000, \IN
+    test_ord \op b15, f14, f15, 0x7fc00000, 0x7f800000, \NI
+.endm
+
+test un_s
+    movi    a2, 1
+    wsr     a2, cpenable
+    test_ord_all un.s, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1
+test_end
+
+test oeq_s
+    test_ord_all oeq.s, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0
+test_end
+
+test ueq_s
+    test_ord_all ueq.s, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1
+test_end
+
+test olt_s
+    test_ord_all olt.s, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0
+test_end
+
+test ult_s
+    test_ord_all ult.s, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1
+test_end
+
+test ole_s
+    test_ord_all ole.s, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0
+test_end
+
+test ule_s
+    test_ord_all ule.s, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1
+test_end
+
+.macro test_cond op, fr0, fr1, cr, v0, v1, r
+    movfp   \fr0, \v0
+    movfp   \fr1, \v1
+    \op     \fr0, \fr1, \cr
+    rfr     a2, \fr0
+    movi    a3, \r
+    assert  eq, a2, a3
+.endm
+
+test moveqz_s
+    movi    a3, 0
+    test_cond moveqz.s, f0, f1, a3, 0, 0x3f800000, 0x3f800000
+    movi    a3, 1
+    test_cond moveqz.s, f0, f1, a3, 0, 0x3f800000, 0
+test_end
+
+test movnez_s
+    movi    a3, 0
+    test_cond movnez.s, f0, f1, a3, 0, 0x3f800000, 0
+    movi    a3, 1
+    test_cond movnez.s, f0, f1, a3, 0, 0x3f800000, 0x3f800000
+test_end
+
+test movltz_s
+    movi    a3, -1
+    test_cond movltz.s, f0, f1, a3, 0, 0x3f800000, 0x3f800000
+    movi    a3, 0
+    test_cond movltz.s, f0, f1, a3, 0, 0x3f800000, 0
+    movi    a3, 1
+    test_cond movltz.s, f0, f1, a3, 0, 0x3f800000, 0
+test_end
+
+test movgez_s
+    movi    a3, -1
+    test_cond movgez.s, f0, f1, a3, 0, 0x3f800000, 0
+    movi    a3, 0
+    test_cond movgez.s, f0, f1, a3, 0, 0x3f800000, 0x3f800000
+    movi    a3, 1
+    test_cond movgez.s, f0, f1, a3, 0, 0x3f800000, 0x3f800000
+test_end
+
+test movf_s
+    olt.s   b0, f0, f0
+    test_cond movf.s, f0, f1, b0, 0, 0x3f800000, 0x3f800000
+    ueq.s   b0, f0, f0
+    test_cond movf.s, f0, f1, b0, 0, 0x3f800000, 0
+test_end
+
+test movt_s
+    ueq.s   b0, f0, f0
+    test_cond movt.s, f0, f1, b0, 0, 0x3f800000, 0x3f800000
+    olt.s   b0, f0, f0
+    test_cond movt.s, f0, f1, b0, 0, 0x3f800000, 0
+test_end
+
+#endif
+
+test_suite_end
-- 
2.11.0
