Received: from eggs.gnu.org ([2001:4830:134:3::10]:34789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epEph-0006Dv-ID
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epEpc-0005OP-P0
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:00:21 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:39923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1epEpc-0005MJ-6j
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:00:16 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Feb 2018 15:59:59 +0100
Message-Id: <20180223145959.18761-5-laurent@vivier.eu>
In-Reply-To: <20180223145959.18761-1-laurent@vivier.eu>
References: <20180223145959.18761-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 4/4] target/m68k: add fscale,
 fgetman and fgetexp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

Using local m68k floatx80_getman(), floatx80_getexp(), floatx80_scale()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |  15 +++++
 target/m68k/helper.h     |   3 +
 target/m68k/softfloat.c  | 144 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |   3 +
 target/m68k/translate.c  |   9 +++
 5 files changed, 174 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 8286228b81..cdb9b50462 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -542,3 +542,18 @@ void HELPER(frem)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 
     make_quotient(env, res->d);
 }
+
+void HELPER(fgetexp)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_getexp(val->d, &env->fp_status);
+}
+
+void HELPER(fgetman)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_getman(val->d, &env->fp_status);
+}
+
+void HELPER(fscale)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
+{
+    res->d = floatx80_scale(val1->d, val0->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 76a0590c9c..c348dced3a 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -65,6 +65,9 @@ DEF_HELPER_3(fmovemd_st_postinc, i32, env, i32, i32)
 DEF_HELPER_3(fmovemd_ld_postinc, i32, env, i32, i32)
 DEF_HELPER_4(fmod, void, env, fp, fp, fp)
 DEF_HELPER_4(frem, void, env, fp, fp, fp)
+DEF_HELPER_3(fgetexp, void, env, fp, fp)
+DEF_HELPER_3(fgetman, void, env, fp, fp)
+DEF_HELPER_4(fscale, void, env, fp, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 8c77757b4e..9cb141900c 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -22,6 +22,19 @@
 #include "softfloat.h"
 #include "fpu/softfloat-macros.h"
 
+static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
+{
+    if (floatx80_is_signaling_nan(a, status)) {
+        float_raise(float_flag_invalid, status);
+    }
+
+    if (status->default_nan_mode) {
+        return floatx80_default_nan(status);
+    }
+
+    return floatx80_maybe_silence_nan(a, status);
+}
+
 /*----------------------------------------------------------------------------
  | Returns the modulo remainder of the extended double-precision floating-point
  | value `a' with respect to the corresponding value `b'.
@@ -103,3 +116,134 @@ floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
         normalizeRoundAndPackFloatx80(
             80, zSign, bExp + expDiff, aSig0, aSig1, status);
 }
+
+/*----------------------------------------------------------------------------
+ | Returns the mantissa of the extended double-precision floating-point
+ | value `a'.
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_getman(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a , status);
+        }
+        float_raise(float_flag_invalid , status);
+        return floatx80_default_nan(status);
+    }
+
+    if (aExp == 0) {
+        if (aSig == 0) {
+            return packFloatx80(aSign, 0, 0);
+        }
+        normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
+    }
+
+    return roundAndPackFloatx80(status->floatx80_rounding_precision, aSign,
+                                0x3FFF, aSig, 0, status);
+}
+
+/*----------------------------------------------------------------------------
+ | Returns the exponent of the extended double-precision floating-point
+ | value `a' as an extended double-precision value.
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_getexp(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a , status);
+        }
+        float_raise(float_flag_invalid , status);
+        return floatx80_default_nan(status);
+    }
+
+    if (aExp == 0) {
+        if (aSig == 0) {
+            return packFloatx80(aSign, 0, 0);
+        }
+        normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
+    }
+
+    return int32_to_floatx80(aExp - 0x3FFF, status);
+}
+
+/*----------------------------------------------------------------------------
+ | Scales extended double-precision floating-point value in operand `a' by
+ | value `b'. The function truncates the value in the second operand 'b' to
+ | an integral value and adds that value to the exponent of the operand 'a'.
+ | The operation performed according to the IEC/IEEE Standard for Binary
+ | Floating-Point Arithmetic.
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
+{
+    flag aSign, bSign;
+    int32_t aExp, bExp, shiftCount;
+    uint64_t aSig, bSig;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+    bSig = extractFloatx80Frac(b);
+    bExp = extractFloatx80Exp(b);
+    bSign = extractFloatx80Sign(b);
+
+    if (bExp == 0x7FFF) {
+        if ((uint64_t) (bSig << 1) ||
+            ((aExp == 0x7FFF) && (uint64_t) (aSig << 1))) {
+            return propagateFloatx80NaN(a, b, status);
+        }
+        float_raise(float_flag_invalid , status);
+        return floatx80_default_nan(status);
+    }
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaN(a, b, status);
+        }
+        return packFloatx80(aSign, floatx80_infinity.high,
+                            floatx80_infinity.low);
+    }
+    if (aExp == 0) {
+        if (aSig == 0) {
+            return packFloatx80(aSign, 0, 0);
+        }
+        if (bExp < 0x3FFF) {
+            return a;
+        }
+        normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
+    }
+
+    if (bExp < 0x3FFF) {
+        return a;
+    }
+
+    if (0x400F < bExp) {
+        aExp = bSign ? -0x6001 : 0xE000;
+        return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                                    aSign, aExp, aSig, 0, status);
+    }
+
+    shiftCount = 0x403E - bExp;
+    bSig >>= shiftCount;
+    aExp = bSign ? (aExp - bSig) : (aExp + bSig);
+
+    return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                                aSign, aExp, aSig, 0, status);
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 8d8ca0fc45..78fbc0cd0c 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -23,4 +23,7 @@
 #include "fpu/softfloat.h"
 
 floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status);
+floatx80 floatx80_getman(floatx80 a, float_status *status);
+floatx80 floatx80_getexp(floatx80 a, float_status *status);
+floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f8db26fa8e..dbb24f8d84 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5072,6 +5072,12 @@ DISAS_INSN(fpu)
     case 0x5e: /* fdneg */
         gen_helper_fdneg(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x1e: /* fgetexp */
+        gen_helper_fgetexp(cpu_env, cpu_dest, cpu_src);
+        break;
+    case 0x1f: /* fgetman */
+        gen_helper_fgetman(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x20: /* fdiv */
         gen_helper_fdiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
@@ -5108,6 +5114,9 @@ DISAS_INSN(fpu)
     case 0x25: /* frem */
         gen_helper_frem(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
+    case 0x26: /* fscale */
+        gen_helper_fscale(cpu_env, cpu_dest, cpu_src, cpu_dest);
+        break;
     case 0x27: /* fsglmul */
         gen_helper_fsglmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
         break;
-- 
2.14.3
