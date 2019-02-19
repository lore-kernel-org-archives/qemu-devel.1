Received: from eggs.gnu.org ([209.51.188.92]:49604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydz-0005YL-1j
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-0007CK-Pq
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:39 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:40340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-0007Ao-F4
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:37 -0500
Received: by mail-lj1-x234.google.com with SMTP id w6so11593870ljd.7
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:36 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:08 -0800
Message-Id: <20190219061111.10231-21-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 20/23] tests/tcg/xtensa: add FP0 group
 arithmetic tests
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

Test arithmetic operations for normal, NaN and Inf arguments.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/Makefile         |   1 +
 tests/tcg/xtensa/macros.inc       |  17 ++++
 tests/tcg/xtensa/test_fp0_arith.S | 173 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_fp0_arith.S

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index c2bc278be5e7..eea269a36e7a 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -39,6 +39,7 @@ TESTCASES += test_clamps.tst
 TESTCASES += test_extui.tst
 TESTCASES += test_fail.tst
 TESTCASES += test_flix.tst
+TESTCASES += test_fp0_arith.tst
 TESTCASES += test_interrupt.tst
 TESTCASES += test_loop.tst
 TESTCASES += test_lsc.tst
diff --git a/tests/tcg/xtensa/macros.inc b/tests/tcg/xtensa/macros.inc
index 36536ed8a4bc..aa8f95bce879 100644
--- a/tests/tcg/xtensa/macros.inc
+++ b/tests/tcg/xtensa/macros.inc
@@ -98,6 +98,23 @@ test_\name:
     s32i    a3, a2, 0
 .endm
 
+.macro dump r
+#ifdef DEBUG
+.data
+.align 4
+1: .word 0
+.text
+    movi    a4, 1b
+    s32i    a2, a4, 0
+    movi    a2, 4
+    movi    a3, 1
+    movi    a5, 4
+    simcall
+    movi    a4, 1b
+    l32i    a2, a4, 0
+#endif
+.endm
+
 #define glue(a, b) _glue(a, b)
 #define _glue(a, b) a ## b
 
diff --git a/tests/tcg/xtensa/test_fp0_arith.S b/tests/tcg/xtensa/test_fp0_arith.S
new file mode 100644
index 000000000000..253d033a3398
--- /dev/null
+++ b/tests/tcg/xtensa/test_fp0_arith.S
@@ -0,0 +1,173 @@
+#include "macros.inc"
+
+test_suite fp0_arith
+
+#if XCHAL_HAVE_FP
+
+.macro movfp fr, v
+    movi    a2, \v
+    wfr     \fr, a2
+.endm
+
+.macro check_res fr, r
+    rfr     a2, \fr
+    dump    a2
+    movi    a3, \r
+    assert  eq, a2, a3
+    rur     a2, fsr
+    assert  eqi, a2, 0
+.endm
+
+.macro test_op2_rm op, fr0, fr1, fr2, v0, v1, r
+    movi    a2, 0
+    wur     a2, fsr
+    movfp   \fr0, \v0
+    movfp   \fr1, \v1
+    \op     \fr2, \fr0, \fr1
+    check_res \fr2, \r
+.endm
+
+.macro test_op3_rm op, fr0, fr1, fr2, fr3, v0, v1, v2, r
+    movi    a2, 0
+    wur     a2, fsr
+    movfp   \fr0, \v0
+    movfp   \fr1, \v1
+    movfp   \fr2, \v2
+    \op     \fr0, \fr1, \fr2
+    check_res \fr3, \r
+.endm
+
+.macro test_op2_ex op, fr0, fr1, fr2, v0, v1, rm, r
+    movi    a2, \rm
+    wur     a2, fcr
+    test_op2_rm \op, \fr0, \fr1, \fr2, \v0, \v1, \r
+    movi    a2, (\rm) | 0x7c
+    wur     a2, fcr
+    test_op2_rm \op, \fr0, \fr1, \fr2, \v0, \v1, \r
+.endm
+
+.macro test_op3_ex op, fr0, fr1, fr2, fr3, v0, v1, v2, rm, r
+    movi    a2, \rm
+    wur     a2, fcr
+    test_op3_rm \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, \r
+    movi    a2, (\rm) | 0x7c
+    wur     a2, fcr
+    test_op3_rm \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, \r
+.endm
+
+.macro test_op2 op, fr0, fr1, fr2, v0, v1, r0, r1, r2, r3
+    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 0, \r0
+    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 1, \r1
+    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 2, \r2
+    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 3, \r3
+.endm
+
+.macro test_op3 op, fr0, fr1, fr2, fr3, v0, v1, v2, r0, r1, r2, r3
+    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 0, \r0
+    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 1, \r1
+    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 2, \r2
+    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 3, \r3
+.endm
+
+.macro test_op2_cpe op
+    set_vector  kernel, 2f
+    movi    a2, 0
+    wsr     a2, cpenable
+1:
+    \op     f2, f0, f1
+    test_fail
+2:
+    rsr     a2, excvaddr
+    movi    a3, 1b
+    assert  eq, a2, a3
+    rsr     a2, exccause
+    movi    a3, 32
+    assert  eq, a2, a3
+
+    set_vector  kernel, 0
+    movi    a2, 1
+    wsr     a2, cpenable
+.endm
+
+test add_s
+    movi    a2, 1
+    wsr     a2, cpenable
+
+    test_op2 add.s, f0, f1, f2, 0x3fc00000, 0x34400000, \
+        0x3fc00002, 0x3fc00001, 0x3fc00002, 0x3fc00001
+    test_op2 add.s, f3, f4, f5, 0x3fc00000, 0x34a00000, \
+        0x3fc00002, 0x3fc00002, 0x3fc00003, 0x3fc00002
+
+    /* MAX_FLOAT + MAX_FLOAT = +inf/MAX_FLOAT  */
+    test_op2 add.s, f6, f7, f8, 0x7f7fffff, 0x7f7fffff, \
+        0x7f800000, 0x7f7fffff, 0x7f800000, 0x7f7fffff
+test_end
+
+test add_s_inf
+    /* 1 + +inf = +inf  */
+    test_op2 add.s, f6, f7, f8, 0x3fc00000, 0x7f800000, \
+        0x7f800000, 0x7f800000, 0x7f800000, 0x7f800000
+
+    /* +inf + -inf = default NaN */
+    test_op2 add.s, f0, f1, f2, 0x7f800000, 0xff800000, \
+        0x7fc00000, 0x7fc00000, 0x7fc00000, 0x7fc00000
+test_end
+
+test add_s_nan
+    /* 1 + NaN = NaN  */
+    test_op2 add.s, f9, f10, f11, 0x3fc00000, 0x7fc00001, \
+        0x7fc00001, 0x7fc00001, 0x7fc00001, 0x7fc00001
+    test_op2 add.s, f12, f13, f14, 0x3fc00000, 0x7f800001, \
+        0x7f800001, 0x7f800001, 0x7f800001, 0x7f800001
+
+    /* NaN1 + NaN2 = NaN1 */
+    test_op2 add.s, f15, f0, f1, 0x7f800001, 0x7fbfffff, \
+        0x7f800001, 0x7f800001, 0x7f800001, 0x7f800001
+    test_op2 add.s, f2, f3, f4, 0x7fbfffff, 0x7f800001, \
+        0x7fbfffff, 0x7fbfffff, 0x7fbfffff, 0x7fbfffff
+    test_op2 add.s, f5, f6, f7, 0x7fc00001, 0x7fbfffff, \
+        0x7fc00001, 0x7fc00001, 0x7fc00001, 0x7fc00001
+    test_op2 add.s, f8, f9, f10, 0x7fbfffff, 0x7fc00001, \
+        0x7fbfffff, 0x7fbfffff, 0x7fbfffff, 0x7fbfffff
+test_end
+
+test sub_s
+    test_op2 sub.s, f0, f1, f0, 0x3f800001, 0x33800000, \
+        0x3f800000, 0x3f800000, 0x3f800001, 0x3f800000
+    test_op2 sub.s, f0, f1, f1, 0x3f800002, 0x33800000, \
+        0x3f800002, 0x3f800001, 0x3f800002, 0x3f800001
+
+    /* norm - norm = denorm */
+    test_op2 sub.s, f6, f7, f8, 0x00800001, 0x00800000, \
+        0x00000001, 0x00000001, 0x00000001, 0x00000001
+test_end
+
+test mul_s
+    test_op2 mul.s, f0, f1, f2, 0x3f800001, 0x3f800001, \
+        0x3f800002, 0x3f800002, 0x3f800003, 0x3f800002
+
+    /* MAX_FLOAT/2 * MAX_FLOAT/2 = +inf/MAX_FLOAT  */
+    test_op2 mul.s, f6, f7, f8, 0x7f000000, 0x7f000000, \
+        0x7f800000, 0x7f7fffff, 0x7f800000, 0x7f7fffff
+    /* min norm * min norm = 0/denorm */
+    test_op2 mul.s, f6, f7, f8, 0x00800001, 0x00800000, \
+        0x00000000, 0x00000000, 0x00000001, 0x00000000
+
+    /* inf * 0 = default NaN */
+    test_op2 mul.s, f6, f7, f8, 0x7f800000, 0x00000000, \
+        0x7fc00000, 0x7fc00000, 0x7fc00000, 0x7fc00000
+test_end
+
+test madd_s
+    test_op3 madd.s, f0, f1, f2, f0, 0, 0x3f800001, 0x3f800001, \
+        0x3f800002, 0x3f800002, 0x3f800003, 0x3f800002
+test_end
+
+test msub_s
+    test_op3 msub.s, f0, f1, f2, f0, 0x3f800000, 0x3f800001, 0x3f800001, \
+        0xb4800000, 0xb4800000, 0xb4800000, 0xb4800001
+test_end
+
+#endif
+
+test_suite_end
-- 
2.11.0
