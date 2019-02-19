Received: from eggs.gnu.org ([209.51.188.92]:49649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvye1-0005bE-AD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydz-0007Dp-PL
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:41 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydz-0007Ck-93
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:39 -0500
Received: by mail-lj1-x242.google.com with SMTP id w6so11593914ljd.7
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:39 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:09 -0800
Message-Id: <20190219061111.10231-22-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 21/23] tests/tcg/xtensa: add FP0 group
 conversion tests
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

Test conversions for normal, NaN and Inf arguments.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/Makefile        |   1 +
 tests/tcg/xtensa/test_fp0_conv.S | 304 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 305 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_fp0_conv.S

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index eea269a36e7a..b1d9953f6704 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -40,6 +40,7 @@ TESTCASES += test_extui.tst
 TESTCASES += test_fail.tst
 TESTCASES += test_flix.tst
 TESTCASES += test_fp0_arith.tst
+TESTCASES += test_fp0_conv.tst
 TESTCASES += test_interrupt.tst
 TESTCASES += test_loop.tst
 TESTCASES += test_lsc.tst
diff --git a/tests/tcg/xtensa/test_fp0_conv.S b/tests/tcg/xtensa/test_fp0_conv.S
new file mode 100644
index 000000000000..147e3d5062df
--- /dev/null
+++ b/tests/tcg/xtensa/test_fp0_conv.S
@@ -0,0 +1,304 @@
+#include "macros.inc"
+
+test_suite fp0_conv
+
+#if XCHAL_HAVE_FP
+
+.macro movfp fr, v
+    movi    a2, \v
+    wfr     \fr, a2
+.endm
+
+.macro test_ftoi_ex op, r0, fr0, v, c, r
+    movi    a2, 0
+    wur     a2, fsr
+    movfp   \fr0, \v
+    \op     \r0, \fr0, \c
+    dump    \r0
+    movi    a3, \r
+    assert  eq, \r0, a3
+    rur     a2, fsr
+    assert  eqi, a2, 0
+.endm
+
+.macro test_ftoi op, r0, fr0, v, c, r
+    movi    a2, 0
+    wur     a2, fcr
+    test_ftoi_ex \op, \r0, \fr0, \v, \c, \r
+    movi    a2, 0x7c
+    wur     a2, fcr
+    test_ftoi_ex \op, \r0, \fr0, \v, \c, \r
+.endm
+
+
+.macro test_itof_ex op, fr0, ar0, v, c, r
+    movi    a2, 0
+    wur     a2, fsr
+    movi    \ar0, \v
+    \op     \fr0, \ar0, \c
+
+    rfr     a2, \fr0
+    dump    a2
+    movi    a3, \r
+    assert  eq, a2, a3
+    rur     a2, fsr
+    assert  eqi, a2, 0
+.endm
+
+.macro test_itof_rm op, fr0, ar0, v, c, rm, r
+    movi    a2, \rm
+    wur     a2, fcr
+    test_itof_ex \op, \fr0, \ar0, \v, \c, \r
+    movi    a2, (\rm) | 0x7c
+    wur     a2, fcr
+    test_itof_ex \op, \fr0, \ar0, \v, \c, \r
+.endm
+
+.macro test_itof op, fr0, ar0, v, c, r0, r1, r2, r3
+    test_itof_rm \op, \fr0, \ar0, \v, \c, 0, \r0
+    test_itof_rm \op, \fr0, \ar0, \v, \c, 1, \r1
+    test_itof_rm \op, \fr0, \ar0, \v, \c, 2, \r2
+    test_itof_rm \op, \fr0, \ar0, \v, \c, 3, \r3
+.endm
+
+test round_s
+    movi    a2, 1
+    wsr     a2, cpenable
+
+    /* NaN */
+    test_ftoi round.s, a2, f0, 0xffc00001, 0, 0x7fffffff
+    test_ftoi round.s, a2, f0, 0xff800001, 0, 0x7fffffff
+
+    /* -inf */
+    test_ftoi round.s, a2, f0, 0xff800000, 0, 0x80000000
+
+    /* negative overflow */
+    test_ftoi round.s, a2, f0, 0xceffffff, 1, 0x80000000
+    test_ftoi round.s, a2, f0, 0xcf000000, 0, 0x80000000
+    test_ftoi round.s, a2, f0, 0xceffffff, 0, 0x80000080
+
+    /* negative */
+    test_ftoi round.s, a2, f0, 0xbfa00000, 1, -2 /* -1.25 * 2 */
+    test_ftoi round.s, a2, f0, 0xbfc00000, 0, -2 /* -1.5 */
+    test_ftoi round.s, a2, f0, 0xbf800000, 1, -2 /* -1 * 2 */
+    test_ftoi round.s, a2, f0, 0xbf800000, 0, -1 /* -1 */
+    test_ftoi round.s, a2, f0, 0xbf400000, 0, -1 /* -0.75 */
+    test_ftoi round.s, a2, f0, 0xbf000000, 0, 0  /* -0.5 */
+
+    /* positive */
+    test_ftoi round.s, a2, f0, 0x3f000000, 0, 0 /* 0.5 */
+    test_ftoi round.s, a2, f0, 0x3f400000, 0, 1 /* 0.75 */
+    test_ftoi round.s, a2, f0, 0x3f800000, 0, 1 /* 1 */
+    test_ftoi round.s, a2, f0, 0x3f800000, 1, 2 /* 1 * 2 */
+    test_ftoi round.s, a2, f0, 0x3fc00000, 0, 2 /* 1.5 */
+    test_ftoi round.s, a2, f0, 0x3fa00000, 1, 2 /* 1.25 * 2 */
+
+    /* positive overflow */
+    test_ftoi round.s, a2, f0, 0x4effffff, 0, 0x7fffff80
+    test_ftoi round.s, a2, f0, 0x4f000000, 0, 0x7fffffff
+    test_ftoi round.s, a2, f0, 0x4effffff, 1, 0x7fffffff
+
+    /* +inf */
+    test_ftoi round.s, a2, f0, 0x7f800000, 0, 0x7fffffff
+
+    /* NaN */
+    test_ftoi round.s, a2, f0, 0x7f800001, 0, 0x7fffffff
+    test_ftoi round.s, a2, f0, 0x7fc00000, 0, 0x7fffffff
+test_end
+
+test trunc_s
+    /* NaN */
+    test_ftoi trunc.s, a2, f0, 0xffc00001, 0, 0x7fffffff
+    test_ftoi trunc.s, a2, f0, 0xff800001, 0, 0x7fffffff
+
+    /* -inf */
+    test_ftoi trunc.s, a2, f0, 0xff800000, 0, 0x80000000
+
+    /* negative overflow */
+    test_ftoi trunc.s, a2, f0, 0xceffffff, 1, 0x80000000
+    test_ftoi trunc.s, a2, f0, 0xcf000000, 0, 0x80000000
+    test_ftoi trunc.s, a2, f0, 0xceffffff, 0, 0x80000080
+
+    /* negative */
+    test_ftoi trunc.s, a2, f0, 0xbfa00000, 1, -2 /* -1.25 * 2 */
+    test_ftoi trunc.s, a2, f0, 0xbfc00000, 0, -1 /* -1.5 */
+    test_ftoi trunc.s, a2, f0, 0xbf800000, 1, -2 /* -1 * 2 */
+    test_ftoi trunc.s, a2, f0, 0xbf800000, 0, -1 /* -1 */
+    test_ftoi trunc.s, a2, f0, 0xbf400000, 0, 0  /* -0.75 */
+    test_ftoi trunc.s, a2, f0, 0xbf000000, 0, 0  /* -0.5 */
+
+    /* positive */
+    test_ftoi trunc.s, a2, f0, 0x3f000000, 0, 0 /* 0.5 */
+    test_ftoi trunc.s, a2, f0, 0x3f400000, 0, 0 /* 0.75 */
+    test_ftoi trunc.s, a2, f0, 0x3f800000, 0, 1 /* 1 */
+    test_ftoi trunc.s, a2, f0, 0x3f800000, 1, 2 /* 1 * 2 */
+    test_ftoi trunc.s, a2, f0, 0x3fc00000, 0, 1 /* 1.5 */
+    test_ftoi trunc.s, a2, f0, 0x3fa00000, 1, 2 /* 1.25 * 2 */
+
+    /* positive overflow */
+    test_ftoi trunc.s, a2, f0, 0x4effffff, 0, 0x7fffff80
+    test_ftoi trunc.s, a2, f0, 0x4f000000, 0, 0x7fffffff
+    test_ftoi trunc.s, a2, f0, 0x4effffff, 1, 0x7fffffff
+
+    /* +inf */
+    test_ftoi trunc.s, a2, f0, 0x7f800000, 0, 0x7fffffff
+
+    /* NaN */
+    test_ftoi trunc.s, a2, f0, 0x7f800001, 0, 0x7fffffff
+    test_ftoi trunc.s, a2, f0, 0x7fc00000, 0, 0x7fffffff
+test_end
+
+test floor_s
+    /* NaN */
+    test_ftoi floor.s, a2, f0, 0xffc00001, 0, 0x7fffffff
+    test_ftoi floor.s, a2, f0, 0xff800001, 0, 0x7fffffff
+
+    /* -inf */
+    test_ftoi floor.s, a2, f0, 0xff800000, 0, 0x80000000
+
+    /* negative overflow */
+    test_ftoi floor.s, a2, f0, 0xceffffff, 1, 0x80000000
+    test_ftoi floor.s, a2, f0, 0xcf000000, 0, 0x80000000
+    test_ftoi floor.s, a2, f0, 0xceffffff, 0, 0x80000080
+
+    /* negative */
+    test_ftoi floor.s, a2, f0, 0xbfa00000, 1, -3 /* -1.25 * 2 */
+    test_ftoi floor.s, a2, f0, 0xbfc00000, 0, -2 /* -1.5 */
+    test_ftoi floor.s, a2, f0, 0xbf800000, 1, -2 /* -1 * 2 */
+    test_ftoi floor.s, a2, f0, 0xbf800000, 0, -1 /* -1 */
+    test_ftoi floor.s, a2, f0, 0xbf400000, 0, -1 /* -0.75 */
+    test_ftoi floor.s, a2, f0, 0xbf000000, 0, -1 /* -0.5 */
+
+    /* positive */
+    test_ftoi floor.s, a2, f0, 0x3f000000, 0, 0 /* 0.5 */
+    test_ftoi floor.s, a2, f0, 0x3f400000, 0, 0 /* 0.75 */
+    test_ftoi floor.s, a2, f0, 0x3f800000, 0, 1 /* 1 */
+    test_ftoi floor.s, a2, f0, 0x3f800000, 1, 2 /* 1 * 2 */
+    test_ftoi floor.s, a2, f0, 0x3fc00000, 0, 1 /* 1.5 */
+    test_ftoi floor.s, a2, f0, 0x3fa00000, 1, 2 /* 1.25 * 2 */
+
+    /* positive overflow */
+    test_ftoi floor.s, a2, f0, 0x4effffff, 0, 0x7fffff80
+    test_ftoi floor.s, a2, f0, 0x4f000000, 0, 0x7fffffff
+    test_ftoi floor.s, a2, f0, 0x4effffff, 1, 0x7fffffff
+
+    /* +inf */
+    test_ftoi floor.s, a2, f0, 0x7f800000, 0, 0x7fffffff
+
+    /* NaN */
+    test_ftoi floor.s, a2, f0, 0x7f800001, 0, 0x7fffffff
+    test_ftoi floor.s, a2, f0, 0x7fc00000, 0, 0x7fffffff
+test_end
+
+test ceil_s
+    /* NaN */
+    test_ftoi ceil.s, a2, f0, 0xffc00001, 0, 0x7fffffff
+    test_ftoi ceil.s, a2, f0, 0xff800001, 0, 0x7fffffff
+
+    /* -inf */
+    test_ftoi ceil.s, a2, f0, 0xff800000, 0, 0x80000000
+
+    /* negative overflow */
+    test_ftoi ceil.s, a2, f0, 0xceffffff, 1, 0x80000000
+    test_ftoi ceil.s, a2, f0, 0xcf000000, 0, 0x80000000
+    test_ftoi ceil.s, a2, f0, 0xceffffff, 0, 0x80000080
+
+    /* negative */
+    test_ftoi ceil.s, a2, f0, 0xbfa00000, 1, -2 /* -1.25 * 2 */
+    test_ftoi ceil.s, a2, f0, 0xbfc00000, 0, -1 /* -1.5 */
+    test_ftoi ceil.s, a2, f0, 0xbf800000, 1, -2 /* -1 * 2 */
+    test_ftoi ceil.s, a2, f0, 0xbf800000, 0, -1 /* -1 */
+    test_ftoi ceil.s, a2, f0, 0xbf400000, 0, 0  /* -0.75 */
+    test_ftoi ceil.s, a2, f0, 0xbf000000, 0, 0  /* -0.5 */
+
+    /* positive */
+    test_ftoi ceil.s, a2, f0, 0x3f000000, 0, 1 /* 0.5 */
+    test_ftoi ceil.s, a2, f0, 0x3f400000, 0, 1 /* 0.75 */
+    test_ftoi ceil.s, a2, f0, 0x3f800000, 0, 1 /* 1 */
+    test_ftoi ceil.s, a2, f0, 0x3f800000, 1, 2 /* 1 * 2 */
+    test_ftoi ceil.s, a2, f0, 0x3fc00000, 0, 2 /* 1.5 */
+    test_ftoi ceil.s, a2, f0, 0x3fa00000, 1, 3 /* 1.25 * 2 */
+
+    /* positive overflow */
+    test_ftoi ceil.s, a2, f0, 0x4effffff, 0, 0x7fffff80
+    test_ftoi ceil.s, a2, f0, 0x4f000000, 0, 0x7fffffff
+    test_ftoi ceil.s, a2, f0, 0x4effffff, 1, 0x7fffffff
+
+    /* +inf */
+    test_ftoi ceil.s, a2, f0, 0x7f800000, 0, 0x7fffffff
+
+    /* NaN */
+    test_ftoi ceil.s, a2, f0, 0x7f800001, 0, 0x7fffffff
+    test_ftoi ceil.s, a2, f0, 0x7fc00000, 0, 0x7fffffff
+test_end
+
+test utrunc_s
+    /* NaN */
+    test_ftoi utrunc.s, a2, f0, 0xffc00001, 0, 0xffffffff
+    test_ftoi utrunc.s, a2, f0, 0xff800001, 0, 0xffffffff
+
+    /* -inf */
+    test_ftoi utrunc.s, a2, f0, 0xff800000, 0, 0x80000000
+
+    /* negative overflow */
+    test_ftoi utrunc.s, a2, f0, 0xceffffff, 1, 0x80000000
+    test_ftoi utrunc.s, a2, f0, 0xcf000000, 0, 0x80000000
+    test_ftoi utrunc.s, a2, f0, 0xceffffff, 0, 0x80000080
+
+    /* negative */
+    test_ftoi utrunc.s, a2, f0, 0xbfa00000, 1, -2 /* -1.25 * 2 */
+    test_ftoi utrunc.s, a2, f0, 0xbfc00000, 0, -1 /* -1.5 */
+    test_ftoi utrunc.s, a2, f0, 0xbf800000, 1, -2 /* -1 * 2 */
+    test_ftoi utrunc.s, a2, f0, 0xbf800000, 0, -1 /* -1 */
+    test_ftoi utrunc.s, a2, f0, 0xbf400000, 0, 0  /* -0.75 */
+    test_ftoi utrunc.s, a2, f0, 0xbf000000, 0, 0  /* -0.5 */
+
+    /* positive */
+    test_ftoi utrunc.s, a2, f0, 0x3f000000, 0, 0 /* 0.5 */
+    test_ftoi utrunc.s, a2, f0, 0x3f400000, 0, 0 /* 0.75 */
+    test_ftoi utrunc.s, a2, f0, 0x3f800000, 0, 1 /* 1 */
+    test_ftoi utrunc.s, a2, f0, 0x3f800000, 1, 2 /* 1 * 2 */
+    test_ftoi utrunc.s, a2, f0, 0x3fc00000, 0, 1 /* 1.5 */
+    test_ftoi utrunc.s, a2, f0, 0x3fa00000, 1, 2 /* 1.25 * 2 */
+
+    /* positive overflow */
+    test_ftoi utrunc.s, a2, f0, 0x4effffff, 0, 0x7fffff80
+    test_ftoi utrunc.s, a2, f0, 0x4f000000, 0, 0x80000000
+    test_ftoi utrunc.s, a2, f0, 0x4effffff, 1, 0xffffff00
+    test_ftoi utrunc.s, a2, f0, 0x4f800000, 1, 0xffffffff
+
+    /* +inf */
+    test_ftoi utrunc.s, a2, f0, 0x7f800000, 0, 0xffffffff
+
+    /* NaN */
+    test_ftoi utrunc.s, a2, f0, 0x7f800001, 0, 0xffffffff
+    test_ftoi utrunc.s, a2, f0, 0x7fc00000, 0, 0xffffffff
+test_end
+
+test float_s
+    test_itof float.s, f0, a2, -1, 0, \
+        0xbf800000, 0xbf800000, 0xbf800000, 0xbf800000
+    test_itof float.s, f0, a2, 0, 0, 0, 0, 0, 0
+    test_itof float.s, f0, a2, 1, 1, \
+        0x3f000000, 0x3f000000, 0x3f000000, 0x3f000000
+    test_itof float.s, f0, a2, 1, 0, \
+        0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000
+    test_itof float.s, f0, a2, 0x7fffffff, 0, \
+        0x4f000000, 0x4effffff, 0x4f000000, 0x4effffff
+test_end
+
+test ufloat_s
+    test_itof ufloat.s, f0, a2, 0, 0, 0, 0, 0, 0
+    test_itof ufloat.s, f0, a2, 1, 1, \
+        0x3f000000, 0x3f000000, 0x3f000000, 0x3f000000
+    test_itof ufloat.s, f0, a2, 1, 0, \
+        0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000
+    test_itof ufloat.s, f0, a2, 0x7fffffff, 0, \
+        0x4f000000, 0x4effffff, 0x4f000000, 0x4effffff
+    test_itof ufloat.s, f0, a2, 0xffffffff, 0, \
+        0x4f800000, 0x4f7fffff, 0x4f800000, 0x4f7fffff
+test_end
+
+#endif
+
+test_suite_end
-- 
2.11.0
