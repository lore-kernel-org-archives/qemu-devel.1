Received: from eggs.gnu.org ([2001:4830:134:3::10]:47431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf1-0004sZ-Ju
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBev-00050G-8b
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:11 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBeu-0004zx-SF
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:05 -0500
Received: by mail-pg0-x242.google.com with SMTP id o13so15997829pgs.2
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:27 -0800
Message-Id: <20180204041136.17525-16-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 15/24] fpu: Implement add/sub/mul/div with
 soft-fp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

Port the implementation of these 4 routines to the code imported
from glibc.  This allows the trivial addition of float16 support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile.target          |    4 +
 fpu/sfp-machine.h        |  222 ++++++++++
 fpu/soft-fp-specialize.h |  131 ++++++
 include/fpu/softfloat.h  |    6 +
 fpu/float128.c           |   35 ++
 fpu/float16.c            |   43 ++
 fpu/float32.c            |   35 ++
 fpu/float64.c            |   35 ++
 fpu/floatxx.inc.c        |   98 +++++
 fpu/softfloat.c          | 1075 ----------------------------------------------
 10 files changed, 609 insertions(+), 1075 deletions(-)
 create mode 100644 fpu/sfp-machine.h
 create mode 100644 fpu/soft-fp-specialize.h
 create mode 100644 fpu/float128.c
 create mode 100644 fpu/float16.c
 create mode 100644 fpu/float32.c
 create mode 100644 fpu/float64.c
 create mode 100644 fpu/floatxx.inc.c

diff --git a/Makefile.target b/Makefile.target
index f9a9da7e7c..b904085f77 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -98,6 +98,10 @@ obj-$(CONFIG_TCG) += tcg/tcg-common.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
+obj-y += fpu/float16.o
+obj-y += fpu/float32.o
+obj-y += fpu/float64.o
+obj-y += fpu/float128.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
diff --git a/fpu/sfp-machine.h b/fpu/sfp-machine.h
new file mode 100644
index 0000000000..e02af72ba6
--- /dev/null
+++ b/fpu/sfp-machine.h
@@ -0,0 +1,222 @@
+/*
+ * QEMU configuration for soft-fp.h
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/* ??? Should notice 32-bit host.  */
+#define _FP_W_TYPE_SIZE         64
+#define _FP_W_TYPE              uint64_t
+#define _FP_WS_TYPE             int64_t
+#define _FP_I_TYPE              int
+
+#if defined(TARGET_SPARC) || defined(TARGET_M68K)
+#define TARGET_NANFRAC_BITS     -1
+#elif defined(TARGET_MIPS)
+#define TARGET_NANFRAC_BITS     (-(_FP_W_TYPE)status->snan_bit_is_one)
+#else
+#define TARGET_NANFRAC_BITS     0
+#endif
+
+#if defined(TARGET_X86) || defined(TARGET_TILEGX)
+#define TARGET_NANFRAC_SIGN     1
+#else
+#define TARGET_NANFRAC_SIGN     0
+#endif
+
+#define _FP_NANFRAC(fs)                               \
+    (status->snan_bit_is_one                          \
+     ? TARGET_NANFRAC_BITS & (_FP_QNANBIT_##fs - 1)   \
+     : TARGET_NANFRAC_BITS | _FP_QNANBIT_##fs)
+
+#define _FP_NANFRAC_H      _FP_NANFRAC(H)
+#define _FP_NANFRAC_S      _FP_NANFRAC(S)
+#define _FP_NANFRAC_D      _FP_NANFRAC(D)
+#define _FP_NANFRAC_Q      _FP_NANFRAC(Q), TARGET_NANFRAC_BITS
+
+#define _FP_NANSIGN_H      TARGET_NANFRAC_SIGN
+#define _FP_NANSIGN_S      TARGET_NANFRAC_SIGN
+#define _FP_NANSIGN_D      TARGET_NANFRAC_SIGN
+#define _FP_NANSIGN_Q      TARGET_NANFRAC_SIGN
+
+#define _FP_QNANNEGATEDP   (status->snan_bit_is_one)
+
+/* We check default_nan_mode in _FP_CHOOSENAN; we do not need to
+ * duplicate that check in _FP_KEEPNANFRACP.
+ */
+#define _FP_KEEPNANFRACP   1
+
+/* The usage withing the bulk of op-common.h only invokes _FP_CHOOSENAN
+ * when presented with two NaNs.  However, for our own usage within
+ * floatxx.inc.c it is handy to be able to continue to invoke with
+ * non-NaN operands; check for that.
+ */
+#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)                              \
+    do {                                                                \
+        int x_nan = 0, y_nan = 0;                                       \
+        if (X##_e == _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc(X)) {      \
+            x_nan = _FP_FRAC_SNANP(fs, X) * 2 - 1;                      \
+        }                                                               \
+        if (Y##_e == _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc(Y)) {      \
+            y_nan = _FP_FRAC_SNANP(fs, Y) * 2 - 1;                      \
+        }                                                               \
+        switch (pick_nan(x_nan, y_nan,                                  \
+                         _FP_FRAC_EQ_##wc(X, Y) ? X##_s < Y##_s         \
+                         : _FP_FRAC_GT_##wc(X, Y), status)) {           \
+        case 0:                                                         \
+            R##_s = X##_s;                                              \
+            _FP_FRAC_COPY_##wc(R, X);                                   \
+            break;                                                      \
+        case 1:                                                         \
+            R##_s = Y##_s;                                              \
+            _FP_FRAC_COPY_##wc(R, Y);                                   \
+            break;                                                      \
+        default:                                                        \
+            R##_s = _FP_NANSIGN_##fs;                                   \
+            _FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);                     \
+        }                                                               \
+        R##_e = _FP_EXPMAX_##fs;                                        \
+        R##_c = FP_CLS_NAN;                                             \
+    } while (0)
+
+#define FP_ROUNDMODE            (status->float_rounding_mode)
+
+#define FP_RND_NEAREST          float_round_nearest_even
+#define FP_RND_ZERO             float_round_to_zero
+#define FP_RND_PINF             float_round_up
+#define FP_RND_MINF             float_round_down
+#define FP_RND_TIESAWAY         float_round_ties_away
+#define FP_RND_ODD              float_round_to_odd
+
+#define FP_EX_INVALID           float_flag_invalid
+#define FP_EX_OVERFLOW          float_flag_overflow
+#define FP_EX_UNDERFLOW         float_flag_underflow
+#define FP_EX_DIVZERO           float_flag_divbyzero
+#define FP_EX_INEXACT           float_flag_inexact
+
+#define _FP_TININESS_AFTER_ROUNDING \
+    (status->float_detect_tininess == float_tininess_after_rounding)
+
+#define FP_DENORM_ZERO          (status->flush_inputs_to_zero)
+
+#define FP_HANDLE_EXCEPTIONS    (status->float_exception_flags |= _fex)
+
+/* We do not need all of longlong.h.  Provide the few needed.
+ *
+ * If we did use longlong.h, we would have to abide by the
+ * UWtype defined by that header, which would mean adjusting
+ * for 32-bit hosts, rather than using uint64_t unconditionally.
+ */
+
+#include "qemu/int128.h"
+
+/* Double-word addition, in this case 128-bit values.  */
+#define add_ssaaaa(rh, rl, ah, al, bh, bl) \
+    do {                                                  \
+        Int128 rr = int128_add(int128_make128(al, ah),    \
+                               int128_make128(bl, bh));   \
+        (rh) = int128_gethi(rr);                          \
+        (rl) = int128_getlo(rr);                          \
+    } while (0)
+
+/* Double-word subtraction, in this case 128-bit values.  */
+#define sub_ddmmss(rh, rl, ah, al, bh, bl) \
+    do {                                                  \
+        Int128 rr = int128_sub(int128_make128(al, ah),    \
+                               int128_make128(bl, bh));   \
+        (rh) = int128_gethi(rr);                          \
+        (rl) = int128_getlo(rr);                          \
+    } while (0)
+
+/* Widening multiplication, in this case 64 * 64 -> 128-bit values.  */
+static inline Int128 umul_ppmm_impl(uint64_t a, uint64_t b)
+{
+#ifdef CONFIG_INT128
+    return (__uint128_t)a * b;
+#else
+    uint64_t al = (uint32_t)a, ah = a >> 32;
+    uint64_t bl = (uint32_t)b, bh = b >> 32;
+    uint64_t p0, p1, p2, p3;
+    uint64_t lo, mid, hi;
+
+    p0 = al * bl;
+    p1 = ah * bl;
+    p2 = al * bh;
+    p3 = ah * bh;
+
+    mid = (p0 >> 32) + (uint32_t)p1 + (uint32_t)p2;
+    lo = (uint32_t)p0 + (mid << 32);
+    hi = p3 + (mid >> 32) + (p1 >> 32) + (p2 >> 32);
+
+    return int128_make128(lo, hi);
+#endif
+}
+
+#define umul_ppmm(ph, pl, m0, m1) \
+    do {                                      \
+        Int128 pp = umul_ppmm_impl(m0, m1);   \
+        (ph) = int128_gethi(pp);              \
+        (pl) = int128_getlo(pp);              \
+    } while (0)
+
+/* Wide division, in this case 128 / 64 -> 64-bit values.
+ * The numerator (n1:n0) and denominator (d) operands must
+ * be normalized such that the quotient (*pq) will fit.
+ */
+static inline void udiv_qrnnd_impl(uint64_t *pq, uint64_t *pr, uint64_t n1,
+                                   uint64_t n0, uint64_t d)
+{
+    uint64_t d0, d1, q0, q1, r1, r0, m;
+
+    d0 = (uint32_t)d;
+    d1 = d >> 32;
+
+    r1 = n1 % d1;
+    q1 = n1 / d1;
+    m = q1 * d0;
+    r1 = (r1 << 32) | (n0 >> 32);
+    if (r1 < m) {
+        q1 -= 1;
+        r1 += d;
+        if (r1 >= d) {
+            if (r1 < m) {
+                q1 -= 1;
+                r1 += d;
+            }
+        }
+    }
+    r1 -= m;
+
+    r0 = r1 % d1;
+    q0 = r1 / d1;
+    m = q0 * d0;
+    r0 = (r0 << 32) | (uint32_t)n0;
+    if (r0 < m) {
+        q0 -= 1;
+        r0 += d;
+        if (r0 >= d) {
+            if (r0 < m) {
+                q0 -= 1;
+                r0 += d;
+            }
+        }
+    }
+    r0 -= m;
+
+    *pq = (q1 << 32) | q0;
+    *pr = r0;
+}
+
+#define udiv_qrnnd(q, r, n1, n0, d) \
+    udiv_qrnnd_impl(&(q), &(r), (n1), (n0), (d))
diff --git a/fpu/soft-fp-specialize.h b/fpu/soft-fp-specialize.h
new file mode 100644
index 0000000000..869f5a0195
--- /dev/null
+++ b/fpu/soft-fp-specialize.h
@@ -0,0 +1,131 @@
+/*
+ * Target-specific specialization for soft-fp.h.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+
+/*
+ * Select which NaN to propagate for a two-input operation.
+ * IEEE754 doesn't specify all the details of this, so the
+ * algorithm is target-specific.
+ *
+ * A_NAN and B_NAN are positive if their respective operands are SNaN,
+ * negative if they are QNaN, or 0 if they are not a NaN at all.
+ * The return value is 0 to select NaN A, 1 for NaN B, or 2 to build
+ * a new default QNaN.
+ *
+ * Note that signalling NaNs are always squashed to quiet NaNs
+ * by the caller before returning them.
+ *
+ * A_LARGER is only valid if both A and B are NaNs of some kind,
+ * and is true if A has the larger significand, or if both A and B
+ * have the same significand but A is positive but B is negative.
+ * It is only needed for the x87 tie-break rule.
+ */
+static inline int pick_nan(int a_nan, int b_nan, bool a_larger,
+                           float_status *status)
+{
+    if (status->default_nan_mode) {
+        return 2;
+    }
+#if defined(TARGET_ARM) || defined(TARGET_HPPA)
+    /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take
+     * the first of:
+     *  1. A if it is signaling
+     *  2. B if it is signaling
+     *  3. A (quiet)
+     *  4. B (quiet)
+     * A signaling NaN is always quietened before returning it.
+     */
+    if (a_nan > 0) {
+        return 0;
+    } else if (b_nan > 0) {
+        return 1;
+    } else if (a_nan < 0) {
+        return 0;
+    } else {
+        return 1;
+    }
+#elif defined(TARGET_MIPS)
+    /* According to MIPS specifications, if one of the two operands is
+     * a sNaN, a new qNaN has to be generated.  For qNaN inputs the
+     * specifications says: "When possible, this QNaN result is one of
+     * the operand QNaN values." In practice it seems that most
+     * implementations choose the first operand if both operands are qNaN.
+     * In short this gives the following rules:
+     *  1. A if it is signaling
+     *  2. B if it is signaling
+     *  3. A (quiet)
+     *  4. B (quiet)
+     */
+    if (a_nan > 0 || b_nan > 0) {
+        return 2;
+    } else if (a_nan < 0) {
+        return 0;
+    } else {
+        return 1;
+    }
+#elif defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
+    /* PowerPC propagation rules:
+     *  1. A if it sNaN or qNaN
+     *  2. B if it sNaN or qNaN
+     * A signaling NaN is always silenced before returning it.
+     */
+    /* M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
+     * 3.4 FLOATING-POINT INSTRUCTION DETAILS
+     * If either operand, but not both operands, of an operation is a
+     * nonsignaling NaN, then that NaN is returned as the result. If both
+     * operands are nonsignaling NaNs, then the destination operand
+     * nonsignaling NaN is returned as the result.
+     * If either operand to an operation is a signaling NaN (SNaN), then the
+     * SNaN bit is set in the FPSR EXC byte. If the SNaN exception enable bit
+     * is set in the FPCR ENABLE byte, then the exception is taken and the
+     * destination is not modified. If the SNaN exception enable bit is not
+     * set, setting the SNaN bit in the operand to a one converts the SNaN to
+     * a nonsignaling NaN. The operation then continues as described in the
+     * preceding paragraph for nonsignaling NaNs.
+     */
+    if (a_nan) {
+        return 0;
+    } else {
+        return 1;
+    }
+#else
+    /* This implements x87 NaN propagation rules:
+     * SNaN + QNaN => return the QNaN
+     * two SNaNs => return the one with the larger significand, silenced
+     * two QNaNs => return the one with the larger significand
+     * SNaN and a non-NaN => return the SNaN, silenced
+     * QNaN and a non-NaN => return the QNaN
+     *
+     * If we get down to comparing significands and they are the same,
+     * return the NaN with the positive sign bit (if any).
+     */
+    /* ??? This is x87 specific and should not be the
+       default implementation.  */
+    if (a_nan > 0) {
+        if (b_nan <= 0) {
+            return b_nan < 0;
+        }
+    } else if (a_nan < 0) {
+        if (b_nan >= 0) {
+            return 0;
+        }
+    } else {
+        return 1;
+    }
+    return a_larger ^ 1;
+#endif
+}
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 23824a3000..85e4a74f1b 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -236,6 +236,12 @@ float64 float16_to_float64(float16 a, flag ieee, float_status *status);
 /*----------------------------------------------------------------------------
 | Software half-precision operations.
 *----------------------------------------------------------------------------*/
+
+float16 float16_add(float16, float16, float_status *status);
+float16 float16_sub(float16, float16, float_status *status);
+float16 float16_mul(float16, float16, float_status *status);
+float16 float16_div(float16, float16, float_status *status);
+
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
 float16 float16_maybe_silence_nan(float16, float_status *status);
diff --git a/fpu/float128.c b/fpu/float128.c
new file mode 100644
index 0000000000..550b98a682
--- /dev/null
+++ b/fpu/float128.c
@@ -0,0 +1,35 @@
+/*
+ * Software floating point for size float64
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "fpu/softfloat.h"
+#include "soft-fp.h"
+#include "soft-fp-specialize.h"
+#include "quad.h"
+
+#define FLOATXX  float128
+#define FS       Q
+#define WC       2
+
+#define _FP_MUL_MEAT_Q(R, X, Y) \
+    _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_Q, R, X, Y, umul_ppmm)
+#define _FP_MUL_MEAT_DW_Q(R, X, Y) \
+    _FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_Q, R, X, Y, umul_ppmm)
+#define _FP_DIV_MEAT_Q(R, X, Y) \
+    _FP_DIV_MEAT_2_udiv(Q, R, X, Y)
+
+#include "floatxx.inc.c"
diff --git a/fpu/float16.c b/fpu/float16.c
new file mode 100644
index 0000000000..f24f52afde
--- /dev/null
+++ b/fpu/float16.c
@@ -0,0 +1,43 @@
+/*
+ * Software floating point for size float16
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "fpu/softfloat.h"
+#include "soft-fp.h"
+#include "soft-fp-specialize.h"
+#include "half.h"
+
+/* No point in using a 64-bit type for float16.  */
+#undef _FP_W_TYPE_SIZE
+#undef _FP_W_TYPE
+#undef _FP_WS_TYPE
+#define _FP_W_TYPE_SIZE    32
+#define _FP_W_TYPE         uint32_t
+#define _FP_WS_TYPE        int32_t
+
+#define FLOATXX  float16
+#define FS       H
+#define WC       1
+
+#define _FP_MUL_MEAT_H(R, X, Y) \
+    _FP_MUL_MEAT_1_imm(_FP_WFRACBITS_H, R, X, Y)
+#define _FP_MUL_MEAT_DW_H(R, X, Y) \
+    _FP_MUL_MEAT_DW_1_imm(_FP_WFRACBITS_H, R, X, Y)
+#define _FP_DIV_MEAT_H(R, X, Y) \
+    _FP_DIV_MEAT_1_imm(H, R, X, Y, _FP_DIV_HELP_imm)
+
+#include "floatxx.inc.c"
diff --git a/fpu/float32.c b/fpu/float32.c
new file mode 100644
index 0000000000..60d8758c80
--- /dev/null
+++ b/fpu/float32.c
@@ -0,0 +1,35 @@
+/*
+ * Software floating point for size float32
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "fpu/softfloat.h"
+#include "soft-fp.h"
+#include "soft-fp-specialize.h"
+#include "single.h"
+
+#define FLOATXX  float32
+#define FS       S
+#define WC       1
+
+#define _FP_MUL_MEAT_S(R, X, Y) \
+    _FP_MUL_MEAT_1_imm(_FP_WFRACBITS_S, R, X, Y)
+#define _FP_MUL_MEAT_DW_S(R, X, Y) \
+    _FP_MUL_MEAT_DW_1_imm(_FP_WFRACBITS_S, R, X, Y)
+#define _FP_DIV_MEAT_S(R, X, Y) \
+    _FP_DIV_MEAT_1_imm(S, R, X, Y, _FP_DIV_HELP_imm)
+
+#include "floatxx.inc.c"
diff --git a/fpu/float64.c b/fpu/float64.c
new file mode 100644
index 0000000000..d838d83223
--- /dev/null
+++ b/fpu/float64.c
@@ -0,0 +1,35 @@
+/*
+ * Software floating point for size float64
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "fpu/softfloat.h"
+#include "soft-fp.h"
+#include "soft-fp-specialize.h"
+#include "double.h"
+
+#define FLOATXX  float64
+#define FS       D
+#define WC       1
+
+#define _FP_MUL_MEAT_D(R, X, Y) \
+    _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_D, R, X, Y, umul_ppmm)
+#define _FP_MUL_MEAT_DW_D(R, X, Y) \
+    _FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_D, R, X, Y, umul_ppmm)
+#define _FP_DIV_MEAT_D(R, X, Y) \
+    _FP_DIV_MEAT_1_udiv_norm(D, R, X, Y)
+
+#include "floatxx.inc.c"
diff --git a/fpu/floatxx.inc.c b/fpu/floatxx.inc.c
new file mode 100644
index 0000000000..aca5ed3097
--- /dev/null
+++ b/fpu/floatxx.inc.c
@@ -0,0 +1,98 @@
+/*
+ * Software floating point for a given type.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/* Before including this file, define:
+ *   FLOATXX   the floating-point type
+ *   FS        the type letter (e.g. S, D, Q)
+ *   WC        the word count required
+ * and include all of the relevant files.
+ */
+
+#define _FP_ISNAN(fs, wc, X) \
+    (X##_e == _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc (X))
+#define FP_ISNAN(fs, wc, X) \
+    _FP_ISNAN(fs, wc, X)
+#define FP_ADD_INTERNAL(fs, wc, R, A, B, OP) \
+    _FP_ADD_INTERNAL(fs, wc, R, A, B, '-')
+
+static FLOATXX addsub_internal(FLOATXX a, FLOATXX b, float_status *status,
+                               bool subtract)
+{
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(A);
+    glue(FP_DECL_, FS)(B);
+    glue(FP_DECL_, FS)(R);
+    FLOATXX r;
+
+    FP_INIT_ROUNDMODE;
+    glue(FP_UNPACK_SEMIRAW_, FS)(A, a);
+    glue(FP_UNPACK_SEMIRAW_, FS)(B, b);
+
+    B_s ^= (subtract & !FP_ISNAN(FS, WC, B));
+    FP_ADD_INTERNAL(FS, WC, R, A, B, '+');
+
+    glue(FP_PACK_SEMIRAW_, FS)(r, R);
+    FP_HANDLE_EXCEPTIONS;
+
+    return r;
+}
+
+FLOATXX glue(FLOATXX,_add)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return addsub_internal(a, b, status, false);
+}
+
+FLOATXX glue(FLOATXX,_sub)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return addsub_internal(a, b, status, true);
+}
+
+FLOATXX glue(FLOATXX,_mul)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(A);
+    glue(FP_DECL_, FS)(B);
+    glue(FP_DECL_, FS)(R);
+    FLOATXX r;
+
+    FP_INIT_ROUNDMODE;
+    glue(FP_UNPACK_, FS)(A, a);
+    glue(FP_UNPACK_, FS)(B, b);
+    glue(FP_MUL_, FS)(R, A, B);
+    glue(FP_PACK_, FS)(r, R);
+    FP_HANDLE_EXCEPTIONS;
+
+    return r;
+}
+
+FLOATXX glue(FLOATXX,_div)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(A);
+    glue(FP_DECL_, FS)(B);
+    glue(FP_DECL_, FS)(R);
+    FLOATXX r;
+
+    FP_INIT_ROUNDMODE;
+    glue(FP_UNPACK_, FS)(A, a);
+    glue(FP_UNPACK_, FS)(B, b);
+    glue(FP_DIV_, FS)(R, A, B);
+    glue(FP_PACK_, FS)(r, R);
+    FP_HANDLE_EXCEPTIONS;
+
+    return r;
+}
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3a4ab1355f..7cadf8ef1e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2009,355 +2009,6 @@ float32 float32_round_to_int(float32 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of adding the absolute values of the single-precision
-| floating-point values `a' and `b'.  If `zSign' is 1, the sum is negated
-| before being returned.  `zSign' is ignored if the result is a NaN.
-| The addition is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float32 addFloat32Sigs(float32 a, float32 b, flag zSign,
-                              float_status *status)
-{
-    int aExp, bExp, zExp;
-    uint32_t aSig, bSig, zSig;
-    int expDiff;
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    bSig = extractFloat32Frac( b );
-    bExp = extractFloat32Exp( b );
-    expDiff = aExp - bExp;
-    aSig <<= 6;
-    bSig <<= 6;
-    if ( 0 < expDiff ) {
-        if ( aExp == 0xFF ) {
-            if (aSig) {
-                return propagateFloat32NaN(a, b, status);
-            }
-            return a;
-        }
-        if ( bExp == 0 ) {
-            --expDiff;
-        }
-        else {
-            bSig |= 0x20000000;
-        }
-        shift32RightJamming( bSig, expDiff, &bSig );
-        zExp = aExp;
-    }
-    else if ( expDiff < 0 ) {
-        if ( bExp == 0xFF ) {
-            if (bSig) {
-                return propagateFloat32NaN(a, b, status);
-            }
-            return packFloat32( zSign, 0xFF, 0 );
-        }
-        if ( aExp == 0 ) {
-            ++expDiff;
-        }
-        else {
-            aSig |= 0x20000000;
-        }
-        shift32RightJamming( aSig, - expDiff, &aSig );
-        zExp = bExp;
-    }
-    else {
-        if ( aExp == 0xFF ) {
-            if (aSig | bSig) {
-                return propagateFloat32NaN(a, b, status);
-            }
-            return a;
-        }
-        if ( aExp == 0 ) {
-            if (status->flush_to_zero) {
-                if (aSig | bSig) {
-                    float_raise(float_flag_output_denormal, status);
-                }
-                return packFloat32(zSign, 0, 0);
-            }
-            return packFloat32( zSign, 0, ( aSig + bSig )>>6 );
-        }
-        zSig = 0x40000000 + aSig + bSig;
-        zExp = aExp;
-        goto roundAndPack;
-    }
-    aSig |= 0x20000000;
-    zSig = ( aSig + bSig )<<1;
-    --zExp;
-    if ( (int32_t) zSig < 0 ) {
-        zSig = aSig + bSig;
-        ++zExp;
-    }
- roundAndPack:
-    return roundAndPackFloat32(zSign, zExp, zSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the absolute values of the single-
-| precision floating-point values `a' and `b'.  If `zSign' is 1, the
-| difference is negated before being returned.  `zSign' is ignored if the
-| result is a NaN.  The subtraction is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float32 subFloat32Sigs(float32 a, float32 b, flag zSign,
-                              float_status *status)
-{
-    int aExp, bExp, zExp;
-    uint32_t aSig, bSig, zSig;
-    int expDiff;
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    bSig = extractFloat32Frac( b );
-    bExp = extractFloat32Exp( b );
-    expDiff = aExp - bExp;
-    aSig <<= 7;
-    bSig <<= 7;
-    if ( 0 < expDiff ) goto aExpBigger;
-    if ( expDiff < 0 ) goto bExpBigger;
-    if ( aExp == 0xFF ) {
-        if (aSig | bSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        float_raise(float_flag_invalid, status);
-        return float32_default_nan(status);
-    }
-    if ( aExp == 0 ) {
-        aExp = 1;
-        bExp = 1;
-    }
-    if ( bSig < aSig ) goto aBigger;
-    if ( aSig < bSig ) goto bBigger;
-    return packFloat32(status->float_rounding_mode == float_round_down, 0, 0);
- bExpBigger:
-    if ( bExp == 0xFF ) {
-        if (bSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        return packFloat32( zSign ^ 1, 0xFF, 0 );
-    }
-    if ( aExp == 0 ) {
-        ++expDiff;
-    }
-    else {
-        aSig |= 0x40000000;
-    }
-    shift32RightJamming( aSig, - expDiff, &aSig );
-    bSig |= 0x40000000;
- bBigger:
-    zSig = bSig - aSig;
-    zExp = bExp;
-    zSign ^= 1;
-    goto normalizeRoundAndPack;
- aExpBigger:
-    if ( aExp == 0xFF ) {
-        if (aSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        return a;
-    }
-    if ( bExp == 0 ) {
-        --expDiff;
-    }
-    else {
-        bSig |= 0x40000000;
-    }
-    shift32RightJamming( bSig, expDiff, &bSig );
-    aSig |= 0x40000000;
- aBigger:
-    zSig = aSig - bSig;
-    zExp = aExp;
- normalizeRoundAndPack:
-    --zExp;
-    return normalizeRoundAndPackFloat32(zSign, zExp, zSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of adding the single-precision floating-point values `a'
-| and `b'.  The operation is performed according to the IEC/IEEE Standard for
-| Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_add(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    aSign = extractFloat32Sign( a );
-    bSign = extractFloat32Sign( b );
-    if ( aSign == bSign ) {
-        return addFloat32Sigs(a, b, aSign, status);
-    }
-    else {
-        return subFloat32Sigs(a, b, aSign, status);
-    }
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the single-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_sub(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    aSign = extractFloat32Sign( a );
-    bSign = extractFloat32Sign( b );
-    if ( aSign == bSign ) {
-        return subFloat32Sigs(a, b, aSign, status);
-    }
-    else {
-        return addFloat32Sigs(a, b, aSign, status);
-    }
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of multiplying the single-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_mul(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign, zSign;
-    int aExp, bExp, zExp;
-    uint32_t aSig, bSig;
-    uint64_t zSig64;
-    uint32_t zSig;
-
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    bSig = extractFloat32Frac( b );
-    bExp = extractFloat32Exp( b );
-    bSign = extractFloat32Sign( b );
-    zSign = aSign ^ bSign;
-    if ( aExp == 0xFF ) {
-        if ( aSig || ( ( bExp == 0xFF ) && bSig ) ) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        if ( ( bExp | bSig ) == 0 ) {
-            float_raise(float_flag_invalid, status);
-            return float32_default_nan(status);
-        }
-        return packFloat32( zSign, 0xFF, 0 );
-    }
-    if ( bExp == 0xFF ) {
-        if (bSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        if ( ( aExp | aSig ) == 0 ) {
-            float_raise(float_flag_invalid, status);
-            return float32_default_nan(status);
-        }
-        return packFloat32( zSign, 0xFF, 0 );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat32( zSign, 0, 0 );
-        normalizeFloat32Subnormal( aSig, &aExp, &aSig );
-    }
-    if ( bExp == 0 ) {
-        if ( bSig == 0 ) return packFloat32( zSign, 0, 0 );
-        normalizeFloat32Subnormal( bSig, &bExp, &bSig );
-    }
-    zExp = aExp + bExp - 0x7F;
-    aSig = ( aSig | 0x00800000 )<<7;
-    bSig = ( bSig | 0x00800000 )<<8;
-    shift64RightJamming( ( (uint64_t) aSig ) * bSig, 32, &zSig64 );
-    zSig = zSig64;
-    if ( 0 <= (int32_t) ( zSig<<1 ) ) {
-        zSig <<= 1;
-        --zExp;
-    }
-    return roundAndPackFloat32(zSign, zExp, zSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of dividing the single-precision floating-point value `a'
-| by the corresponding value `b'.  The operation is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float32 float32_div(float32 a, float32 b, float_status *status)
-{
-    flag aSign, bSign, zSign;
-    int aExp, bExp, zExp;
-    uint32_t aSig, bSig, zSig;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    bSig = extractFloat32Frac( b );
-    bExp = extractFloat32Exp( b );
-    bSign = extractFloat32Sign( b );
-    zSign = aSign ^ bSign;
-    if ( aExp == 0xFF ) {
-        if (aSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        if ( bExp == 0xFF ) {
-            if (bSig) {
-                return propagateFloat32NaN(a, b, status);
-            }
-            float_raise(float_flag_invalid, status);
-            return float32_default_nan(status);
-        }
-        return packFloat32( zSign, 0xFF, 0 );
-    }
-    if ( bExp == 0xFF ) {
-        if (bSig) {
-            return propagateFloat32NaN(a, b, status);
-        }
-        return packFloat32( zSign, 0, 0 );
-    }
-    if ( bExp == 0 ) {
-        if ( bSig == 0 ) {
-            if ( ( aExp | aSig ) == 0 ) {
-                float_raise(float_flag_invalid, status);
-                return float32_default_nan(status);
-            }
-            float_raise(float_flag_divbyzero, status);
-            return packFloat32( zSign, 0xFF, 0 );
-        }
-        normalizeFloat32Subnormal( bSig, &bExp, &bSig );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat32( zSign, 0, 0 );
-        normalizeFloat32Subnormal( aSig, &aExp, &aSig );
-    }
-    zExp = aExp - bExp + 0x7D;
-    aSig = ( aSig | 0x00800000 )<<7;
-    bSig = ( bSig | 0x00800000 )<<8;
-    if ( bSig <= ( aSig + aSig ) ) {
-        aSig >>= 1;
-        ++zExp;
-    }
-    zSig = ( ( (uint64_t) aSig )<<32 ) / bSig;
-    if ( ( zSig & 0x3F ) == 0 ) {
-        zSig |= ( (uint64_t) bSig * zSig != ( (uint64_t) aSig )<<32 );
-    }
-    return roundAndPackFloat32(zSign, zExp, zSig, status);
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the remainder of the single-precision floating-point value `a'
 | with respect to the corresponding value `b'.  The operation is performed
@@ -3819,361 +3470,6 @@ float64 float64_trunc_to_int(float64 a, float_status *status)
     return res;
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of adding the absolute values of the double-precision
-| floating-point values `a' and `b'.  If `zSign' is 1, the sum is negated
-| before being returned.  `zSign' is ignored if the result is a NaN.
-| The addition is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float64 addFloat64Sigs(float64 a, float64 b, flag zSign,
-                              float_status *status)
-{
-    int aExp, bExp, zExp;
-    uint64_t aSig, bSig, zSig;
-    int expDiff;
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    bSig = extractFloat64Frac( b );
-    bExp = extractFloat64Exp( b );
-    expDiff = aExp - bExp;
-    aSig <<= 9;
-    bSig <<= 9;
-    if ( 0 < expDiff ) {
-        if ( aExp == 0x7FF ) {
-            if (aSig) {
-                return propagateFloat64NaN(a, b, status);
-            }
-            return a;
-        }
-        if ( bExp == 0 ) {
-            --expDiff;
-        }
-        else {
-            bSig |= LIT64( 0x2000000000000000 );
-        }
-        shift64RightJamming( bSig, expDiff, &bSig );
-        zExp = aExp;
-    }
-    else if ( expDiff < 0 ) {
-        if ( bExp == 0x7FF ) {
-            if (bSig) {
-                return propagateFloat64NaN(a, b, status);
-            }
-            return packFloat64( zSign, 0x7FF, 0 );
-        }
-        if ( aExp == 0 ) {
-            ++expDiff;
-        }
-        else {
-            aSig |= LIT64( 0x2000000000000000 );
-        }
-        shift64RightJamming( aSig, - expDiff, &aSig );
-        zExp = bExp;
-    }
-    else {
-        if ( aExp == 0x7FF ) {
-            if (aSig | bSig) {
-                return propagateFloat64NaN(a, b, status);
-            }
-            return a;
-        }
-        if ( aExp == 0 ) {
-            if (status->flush_to_zero) {
-                if (aSig | bSig) {
-                    float_raise(float_flag_output_denormal, status);
-                }
-                return packFloat64(zSign, 0, 0);
-            }
-            return packFloat64( zSign, 0, ( aSig + bSig )>>9 );
-        }
-        zSig = LIT64( 0x4000000000000000 ) + aSig + bSig;
-        zExp = aExp;
-        goto roundAndPack;
-    }
-    aSig |= LIT64( 0x2000000000000000 );
-    zSig = ( aSig + bSig )<<1;
-    --zExp;
-    if ( (int64_t) zSig < 0 ) {
-        zSig = aSig + bSig;
-        ++zExp;
-    }
- roundAndPack:
-    return roundAndPackFloat64(zSign, zExp, zSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the absolute values of the double-
-| precision floating-point values `a' and `b'.  If `zSign' is 1, the
-| difference is negated before being returned.  `zSign' is ignored if the
-| result is a NaN.  The subtraction is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float64 subFloat64Sigs(float64 a, float64 b, flag zSign,
-                              float_status *status)
-{
-    int aExp, bExp, zExp;
-    uint64_t aSig, bSig, zSig;
-    int expDiff;
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    bSig = extractFloat64Frac( b );
-    bExp = extractFloat64Exp( b );
-    expDiff = aExp - bExp;
-    aSig <<= 10;
-    bSig <<= 10;
-    if ( 0 < expDiff ) goto aExpBigger;
-    if ( expDiff < 0 ) goto bExpBigger;
-    if ( aExp == 0x7FF ) {
-        if (aSig | bSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        float_raise(float_flag_invalid, status);
-        return float64_default_nan(status);
-    }
-    if ( aExp == 0 ) {
-        aExp = 1;
-        bExp = 1;
-    }
-    if ( bSig < aSig ) goto aBigger;
-    if ( aSig < bSig ) goto bBigger;
-    return packFloat64(status->float_rounding_mode == float_round_down, 0, 0);
- bExpBigger:
-    if ( bExp == 0x7FF ) {
-        if (bSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        return packFloat64( zSign ^ 1, 0x7FF, 0 );
-    }
-    if ( aExp == 0 ) {
-        ++expDiff;
-    }
-    else {
-        aSig |= LIT64( 0x4000000000000000 );
-    }
-    shift64RightJamming( aSig, - expDiff, &aSig );
-    bSig |= LIT64( 0x4000000000000000 );
- bBigger:
-    zSig = bSig - aSig;
-    zExp = bExp;
-    zSign ^= 1;
-    goto normalizeRoundAndPack;
- aExpBigger:
-    if ( aExp == 0x7FF ) {
-        if (aSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        return a;
-    }
-    if ( bExp == 0 ) {
-        --expDiff;
-    }
-    else {
-        bSig |= LIT64( 0x4000000000000000 );
-    }
-    shift64RightJamming( bSig, expDiff, &bSig );
-    aSig |= LIT64( 0x4000000000000000 );
- aBigger:
-    zSig = aSig - bSig;
-    zExp = aExp;
- normalizeRoundAndPack:
-    --zExp;
-    return normalizeRoundAndPackFloat64(zSign, zExp, zSig, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of adding the double-precision floating-point values `a'
-| and `b'.  The operation is performed according to the IEC/IEEE Standard for
-| Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_add(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    if ( aSign == bSign ) {
-        return addFloat64Sigs(a, b, aSign, status);
-    }
-    else {
-        return subFloat64Sigs(a, b, aSign, status);
-    }
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the double-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_sub(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    if ( aSign == bSign ) {
-        return subFloat64Sigs(a, b, aSign, status);
-    }
-    else {
-        return addFloat64Sigs(a, b, aSign, status);
-    }
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of multiplying the double-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_mul(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign, zSign;
-    int aExp, bExp, zExp;
-    uint64_t aSig, bSig, zSig0, zSig1;
-
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    bSig = extractFloat64Frac( b );
-    bExp = extractFloat64Exp( b );
-    bSign = extractFloat64Sign( b );
-    zSign = aSign ^ bSign;
-    if ( aExp == 0x7FF ) {
-        if ( aSig || ( ( bExp == 0x7FF ) && bSig ) ) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        if ( ( bExp | bSig ) == 0 ) {
-            float_raise(float_flag_invalid, status);
-            return float64_default_nan(status);
-        }
-        return packFloat64( zSign, 0x7FF, 0 );
-    }
-    if ( bExp == 0x7FF ) {
-        if (bSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        if ( ( aExp | aSig ) == 0 ) {
-            float_raise(float_flag_invalid, status);
-            return float64_default_nan(status);
-        }
-        return packFloat64( zSign, 0x7FF, 0 );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat64( zSign, 0, 0 );
-        normalizeFloat64Subnormal( aSig, &aExp, &aSig );
-    }
-    if ( bExp == 0 ) {
-        if ( bSig == 0 ) return packFloat64( zSign, 0, 0 );
-        normalizeFloat64Subnormal( bSig, &bExp, &bSig );
-    }
-    zExp = aExp + bExp - 0x3FF;
-    aSig = ( aSig | LIT64( 0x0010000000000000 ) )<<10;
-    bSig = ( bSig | LIT64( 0x0010000000000000 ) )<<11;
-    mul64To128( aSig, bSig, &zSig0, &zSig1 );
-    zSig0 |= ( zSig1 != 0 );
-    if ( 0 <= (int64_t) ( zSig0<<1 ) ) {
-        zSig0 <<= 1;
-        --zExp;
-    }
-    return roundAndPackFloat64(zSign, zExp, zSig0, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of dividing the double-precision floating-point value `a'
-| by the corresponding value `b'.  The operation is performed according to
-| the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float64 float64_div(float64 a, float64 b, float_status *status)
-{
-    flag aSign, bSign, zSign;
-    int aExp, bExp, zExp;
-    uint64_t aSig, bSig, zSig;
-    uint64_t rem0, rem1;
-    uint64_t term0, term1;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    aSig = extractFloat64Frac( a );
-    aExp = extractFloat64Exp( a );
-    aSign = extractFloat64Sign( a );
-    bSig = extractFloat64Frac( b );
-    bExp = extractFloat64Exp( b );
-    bSign = extractFloat64Sign( b );
-    zSign = aSign ^ bSign;
-    if ( aExp == 0x7FF ) {
-        if (aSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        if ( bExp == 0x7FF ) {
-            if (bSig) {
-                return propagateFloat64NaN(a, b, status);
-            }
-            float_raise(float_flag_invalid, status);
-            return float64_default_nan(status);
-        }
-        return packFloat64( zSign, 0x7FF, 0 );
-    }
-    if ( bExp == 0x7FF ) {
-        if (bSig) {
-            return propagateFloat64NaN(a, b, status);
-        }
-        return packFloat64( zSign, 0, 0 );
-    }
-    if ( bExp == 0 ) {
-        if ( bSig == 0 ) {
-            if ( ( aExp | aSig ) == 0 ) {
-                float_raise(float_flag_invalid, status);
-                return float64_default_nan(status);
-            }
-            float_raise(float_flag_divbyzero, status);
-            return packFloat64( zSign, 0x7FF, 0 );
-        }
-        normalizeFloat64Subnormal( bSig, &bExp, &bSig );
-    }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloat64( zSign, 0, 0 );
-        normalizeFloat64Subnormal( aSig, &aExp, &aSig );
-    }
-    zExp = aExp - bExp + 0x3FD;
-    aSig = ( aSig | LIT64( 0x0010000000000000 ) )<<10;
-    bSig = ( bSig | LIT64( 0x0010000000000000 ) )<<11;
-    if ( bSig <= ( aSig + aSig ) ) {
-        aSig >>= 1;
-        ++zExp;
-    }
-    zSig = estimateDiv128To64( aSig, 0, bSig );
-    if ( ( zSig & 0x1FF ) <= 2 ) {
-        mul64To128( bSig, zSig, &term0, &term1 );
-        sub128( aSig, 0, term0, term1, &rem0, &rem1 );
-        while ( (int64_t) rem0 < 0 ) {
-            --zSig;
-            add128( rem0, rem1, 0, bSig, &rem0, &rem1 );
-        }
-        zSig |= ( rem1 != 0 );
-    }
-    return roundAndPackFloat64(zSign, zExp, zSig, status);
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the remainder of the double-precision floating-point value `a'
 | with respect to the corresponding value `b'.  The operation is performed
@@ -6486,377 +5782,6 @@ float128 float128_round_to_int(float128 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of adding the absolute values of the quadruple-precision
-| floating-point values `a' and `b'.  If `zSign' is 1, the sum is negated
-| before being returned.  `zSign' is ignored if the result is a NaN.
-| The addition is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float128 addFloat128Sigs(float128 a, float128 b, flag zSign,
-                                float_status *status)
-{
-    int32_t aExp, bExp, zExp;
-    uint64_t aSig0, aSig1, bSig0, bSig1, zSig0, zSig1, zSig2;
-    int32_t expDiff;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    bSig1 = extractFloat128Frac1( b );
-    bSig0 = extractFloat128Frac0( b );
-    bExp = extractFloat128Exp( b );
-    expDiff = aExp - bExp;
-    if ( 0 < expDiff ) {
-        if ( aExp == 0x7FFF ) {
-            if (aSig0 | aSig1) {
-                return propagateFloat128NaN(a, b, status);
-            }
-            return a;
-        }
-        if ( bExp == 0 ) {
-            --expDiff;
-        }
-        else {
-            bSig0 |= LIT64( 0x0001000000000000 );
-        }
-        shift128ExtraRightJamming(
-            bSig0, bSig1, 0, expDiff, &bSig0, &bSig1, &zSig2 );
-        zExp = aExp;
-    }
-    else if ( expDiff < 0 ) {
-        if ( bExp == 0x7FFF ) {
-            if (bSig0 | bSig1) {
-                return propagateFloat128NaN(a, b, status);
-            }
-            return packFloat128( zSign, 0x7FFF, 0, 0 );
-        }
-        if ( aExp == 0 ) {
-            ++expDiff;
-        }
-        else {
-            aSig0 |= LIT64( 0x0001000000000000 );
-        }
-        shift128ExtraRightJamming(
-            aSig0, aSig1, 0, - expDiff, &aSig0, &aSig1, &zSig2 );
-        zExp = bExp;
-    }
-    else {
-        if ( aExp == 0x7FFF ) {
-            if ( aSig0 | aSig1 | bSig0 | bSig1 ) {
-                return propagateFloat128NaN(a, b, status);
-            }
-            return a;
-        }
-        add128( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
-        if ( aExp == 0 ) {
-            if (status->flush_to_zero) {
-                if (zSig0 | zSig1) {
-                    float_raise(float_flag_output_denormal, status);
-                }
-                return packFloat128(zSign, 0, 0, 0);
-            }
-            return packFloat128( zSign, 0, zSig0, zSig1 );
-        }
-        zSig2 = 0;
-        zSig0 |= LIT64( 0x0002000000000000 );
-        zExp = aExp;
-        goto shiftRight1;
-    }
-    aSig0 |= LIT64( 0x0001000000000000 );
-    add128( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
-    --zExp;
-    if ( zSig0 < LIT64( 0x0002000000000000 ) ) goto roundAndPack;
-    ++zExp;
- shiftRight1:
-    shift128ExtraRightJamming(
-        zSig0, zSig1, zSig2, 1, &zSig0, &zSig1, &zSig2 );
- roundAndPack:
-    return roundAndPackFloat128(zSign, zExp, zSig0, zSig1, zSig2, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the absolute values of the quadruple-
-| precision floating-point values `a' and `b'.  If `zSign' is 1, the
-| difference is negated before being returned.  `zSign' is ignored if the
-| result is a NaN.  The subtraction is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float128 subFloat128Sigs(float128 a, float128 b, flag zSign,
-                                float_status *status)
-{
-    int32_t aExp, bExp, zExp;
-    uint64_t aSig0, aSig1, bSig0, bSig1, zSig0, zSig1;
-    int32_t expDiff;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    bSig1 = extractFloat128Frac1( b );
-    bSig0 = extractFloat128Frac0( b );
-    bExp = extractFloat128Exp( b );
-    expDiff = aExp - bExp;
-    shortShift128Left( aSig0, aSig1, 14, &aSig0, &aSig1 );
-    shortShift128Left( bSig0, bSig1, 14, &bSig0, &bSig1 );
-    if ( 0 < expDiff ) goto aExpBigger;
-    if ( expDiff < 0 ) goto bExpBigger;
-    if ( aExp == 0x7FFF ) {
-        if ( aSig0 | aSig1 | bSig0 | bSig1 ) {
-            return propagateFloat128NaN(a, b, status);
-        }
-        float_raise(float_flag_invalid, status);
-        return float128_default_nan(status);
-    }
-    if ( aExp == 0 ) {
-        aExp = 1;
-        bExp = 1;
-    }
-    if ( bSig0 < aSig0 ) goto aBigger;
-    if ( aSig0 < bSig0 ) goto bBigger;
-    if ( bSig1 < aSig1 ) goto aBigger;
-    if ( aSig1 < bSig1 ) goto bBigger;
-    return packFloat128(status->float_rounding_mode == float_round_down,
-                        0, 0, 0);
- bExpBigger:
-    if ( bExp == 0x7FFF ) {
-        if (bSig0 | bSig1) {
-            return propagateFloat128NaN(a, b, status);
-        }
-        return packFloat128( zSign ^ 1, 0x7FFF, 0, 0 );
-    }
-    if ( aExp == 0 ) {
-        ++expDiff;
-    }
-    else {
-        aSig0 |= LIT64( 0x4000000000000000 );
-    }
-    shift128RightJamming( aSig0, aSig1, - expDiff, &aSig0, &aSig1 );
-    bSig0 |= LIT64( 0x4000000000000000 );
- bBigger:
-    sub128( bSig0, bSig1, aSig0, aSig1, &zSig0, &zSig1 );
-    zExp = bExp;
-    zSign ^= 1;
-    goto normalizeRoundAndPack;
- aExpBigger:
-    if ( aExp == 0x7FFF ) {
-        if (aSig0 | aSig1) {
-            return propagateFloat128NaN(a, b, status);
-        }
-        return a;
-    }
-    if ( bExp == 0 ) {
-        --expDiff;
-    }
-    else {
-        bSig0 |= LIT64( 0x4000000000000000 );
-    }
-    shift128RightJamming( bSig0, bSig1, expDiff, &bSig0, &bSig1 );
-    aSig0 |= LIT64( 0x4000000000000000 );
- aBigger:
-    sub128( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
-    zExp = aExp;
- normalizeRoundAndPack:
-    --zExp;
-    return normalizeRoundAndPackFloat128(zSign, zExp - 14, zSig0, zSig1,
-                                         status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of adding the quadruple-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 float128_add(float128 a, float128 b, float_status *status)
-{
-    flag aSign, bSign;
-
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign == bSign ) {
-        return addFloat128Sigs(a, b, aSign, status);
-    }
-    else {
-        return subFloat128Sigs(a, b, aSign, status);
-    }
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the quadruple-precision floating-point
-| values `a' and `b'.  The operation is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 float128_sub(float128 a, float128 b, float_status *status)
-{
-    flag aSign, bSign;
-
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign == bSign ) {
-        return subFloat128Sigs(a, b, aSign, status);
-    }
-    else {
-        return addFloat128Sigs(a, b, aSign, status);
-    }
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of multiplying the quadruple-precision floating-point
-| values `a' and `b'.  The operation is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 float128_mul(float128 a, float128 b, float_status *status)
-{
-    flag aSign, bSign, zSign;
-    int32_t aExp, bExp, zExp;
-    uint64_t aSig0, aSig1, bSig0, bSig1, zSig0, zSig1, zSig2, zSig3;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    aSign = extractFloat128Sign( a );
-    bSig1 = extractFloat128Frac1( b );
-    bSig0 = extractFloat128Frac0( b );
-    bExp = extractFloat128Exp( b );
-    bSign = extractFloat128Sign( b );
-    zSign = aSign ^ bSign;
-    if ( aExp == 0x7FFF ) {
-        if (    ( aSig0 | aSig1 )
-             || ( ( bExp == 0x7FFF ) && ( bSig0 | bSig1 ) ) ) {
-            return propagateFloat128NaN(a, b, status);
-        }
-        if ( ( bExp | bSig0 | bSig1 ) == 0 ) goto invalid;
-        return packFloat128( zSign, 0x7FFF, 0, 0 );
-    }
-    if ( bExp == 0x7FFF ) {
-        if (bSig0 | bSig1) {
-            return propagateFloat128NaN(a, b, status);
-        }
-        if ( ( aExp | aSig0 | aSig1 ) == 0 ) {
- invalid:
-            float_raise(float_flag_invalid, status);
-            return float128_default_nan(status);
-        }
-        return packFloat128( zSign, 0x7FFF, 0, 0 );
-    }
-    if ( aExp == 0 ) {
-        if ( ( aSig0 | aSig1 ) == 0 ) return packFloat128( zSign, 0, 0, 0 );
-        normalizeFloat128Subnormal( aSig0, aSig1, &aExp, &aSig0, &aSig1 );
-    }
-    if ( bExp == 0 ) {
-        if ( ( bSig0 | bSig1 ) == 0 ) return packFloat128( zSign, 0, 0, 0 );
-        normalizeFloat128Subnormal( bSig0, bSig1, &bExp, &bSig0, &bSig1 );
-    }
-    zExp = aExp + bExp - 0x4000;
-    aSig0 |= LIT64( 0x0001000000000000 );
-    shortShift128Left( bSig0, bSig1, 16, &bSig0, &bSig1 );
-    mul128To256( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1, &zSig2, &zSig3 );
-    add128( zSig0, zSig1, aSig0, aSig1, &zSig0, &zSig1 );
-    zSig2 |= ( zSig3 != 0 );
-    if ( LIT64( 0x0002000000000000 ) <= zSig0 ) {
-        shift128ExtraRightJamming(
-            zSig0, zSig1, zSig2, 1, &zSig0, &zSig1, &zSig2 );
-        ++zExp;
-    }
-    return roundAndPackFloat128(zSign, zExp, zSig0, zSig1, zSig2, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of dividing the quadruple-precision floating-point value
-| `a' by the corresponding value `b'.  The operation is performed according to
-| the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 float128_div(float128 a, float128 b, float_status *status)
-{
-    flag aSign, bSign, zSign;
-    int32_t aExp, bExp, zExp;
-    uint64_t aSig0, aSig1, bSig0, bSig1, zSig0, zSig1, zSig2;
-    uint64_t rem0, rem1, rem2, rem3, term0, term1, term2, term3;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    aSign = extractFloat128Sign( a );
-    bSig1 = extractFloat128Frac1( b );
-    bSig0 = extractFloat128Frac0( b );
-    bExp = extractFloat128Exp( b );
-    bSign = extractFloat128Sign( b );
-    zSign = aSign ^ bSign;
-    if ( aExp == 0x7FFF ) {
-        if (aSig0 | aSig1) {
-            return propagateFloat128NaN(a, b, status);
-        }
-        if ( bExp == 0x7FFF ) {
-            if (bSig0 | bSig1) {
-                return propagateFloat128NaN(a, b, status);
-            }
-            goto invalid;
-        }
-        return packFloat128( zSign, 0x7FFF, 0, 0 );
-    }
-    if ( bExp == 0x7FFF ) {
-        if (bSig0 | bSig1) {
-            return propagateFloat128NaN(a, b, status);
-        }
-        return packFloat128( zSign, 0, 0, 0 );
-    }
-    if ( bExp == 0 ) {
-        if ( ( bSig0 | bSig1 ) == 0 ) {
-            if ( ( aExp | aSig0 | aSig1 ) == 0 ) {
- invalid:
-                float_raise(float_flag_invalid, status);
-                return float128_default_nan(status);
-            }
-            float_raise(float_flag_divbyzero, status);
-            return packFloat128( zSign, 0x7FFF, 0, 0 );
-        }
-        normalizeFloat128Subnormal( bSig0, bSig1, &bExp, &bSig0, &bSig1 );
-    }
-    if ( aExp == 0 ) {
-        if ( ( aSig0 | aSig1 ) == 0 ) return packFloat128( zSign, 0, 0, 0 );
-        normalizeFloat128Subnormal( aSig0, aSig1, &aExp, &aSig0, &aSig1 );
-    }
-    zExp = aExp - bExp + 0x3FFD;
-    shortShift128Left(
-        aSig0 | LIT64( 0x0001000000000000 ), aSig1, 15, &aSig0, &aSig1 );
-    shortShift128Left(
-        bSig0 | LIT64( 0x0001000000000000 ), bSig1, 15, &bSig0, &bSig1 );
-    if ( le128( bSig0, bSig1, aSig0, aSig1 ) ) {
-        shift128Right( aSig0, aSig1, 1, &aSig0, &aSig1 );
-        ++zExp;
-    }
-    zSig0 = estimateDiv128To64( aSig0, aSig1, bSig0 );
-    mul128By64To192( bSig0, bSig1, zSig0, &term0, &term1, &term2 );
-    sub192( aSig0, aSig1, 0, term0, term1, term2, &rem0, &rem1, &rem2 );
-    while ( (int64_t) rem0 < 0 ) {
-        --zSig0;
-        add192( rem0, rem1, rem2, 0, bSig0, bSig1, &rem0, &rem1, &rem2 );
-    }
-    zSig1 = estimateDiv128To64( rem1, rem2, bSig0 );
-    if ( ( zSig1 & 0x3FFF ) <= 4 ) {
-        mul128By64To192( bSig0, bSig1, zSig1, &term1, &term2, &term3 );
-        sub192( rem1, rem2, 0, term1, term2, term3, &rem1, &rem2, &rem3 );
-        while ( (int64_t) rem1 < 0 ) {
-            --zSig1;
-            add192( rem1, rem2, rem3, 0, bSig0, bSig1, &rem1, &rem2, &rem3 );
-        }
-        zSig1 |= ( ( rem1 | rem2 | rem3 ) != 0 );
-    }
-    shift128ExtraRightJamming( zSig0, zSig1, 0, 15, &zSig0, &zSig1, &zSig2 );
-    return roundAndPackFloat128(zSign, zExp, zSig0, zSig1, zSig2, status);
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the remainder of the quadruple-precision floating-point value `a'
 | with respect to the corresponding value `b'.  The operation is performed
-- 
2.14.3
