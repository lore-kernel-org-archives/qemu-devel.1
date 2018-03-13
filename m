Received: from eggs.gnu.org ([2001:4830:134:3::10]:54562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evmLZ-0002yl-C4
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evmLT-0002xe-Fr
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:17 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evmLT-0002wW-5t
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:11 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 16:59:15 +0100
Message-Id: <20180313155918.23591-9-laurent@vivier.eu>
In-Reply-To: <20180313155918.23591-1-laurent@vivier.eu>
References: <20180313155918.23591-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 08/11] target/m68k: implement fatanh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Using a local m68k floatx80_atanh()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180312202728.23790-9-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |  5 ++++
 target/m68k/helper.h     |  1 +
 target/m68k/softfloat.c  | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |  1 +
 target/m68k/translate.c  |  3 +++
 5 files changed, 75 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 18ad6999cb..38b663e1d2 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -633,3 +633,8 @@ void HELPER(facos)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_acos(val->d, &env->fp_status);
 }
+
+void HELPER(fatanh)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_atanh(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 83247a8143..092baec3d5 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -82,6 +82,7 @@ DEF_HELPER_4(fsincos, void, env, fp, fp, fp)
 DEF_HELPER_3(fatan, void, env, fp, fp)
 DEF_HELPER_3(fasin, void, env, fp, fp)
 DEF_HELPER_3(facos, void, env, fp, fp)
+DEF_HELPER_3(fatanh, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 3d66f6946f..5ce8413e96 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -2302,3 +2302,68 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
 
     return a;
 }
+
+/*----------------------------------------------------------------------------
+ | Hyperbolic arc tangent
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_atanh(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact;
+    floatx80 fp0, fp1, fp2, one;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF && (uint64_t) (aSig << 1)) {
+        return propagateFloatx80NaNOneArg(a, status);
+    }
+
+    if (aExp == 0 && aSig == 0) {
+        return packFloatx80(aSign, 0, 0);
+    }
+
+    compact = floatx80_make_compact(aExp, aSig);
+
+    if (compact >= 0x3FFF8000) { /* |X| >= 1 */
+        if (aExp == one_exp && aSig == one_sig) { /* |X| == 1 */
+            float_raise(float_flag_divbyzero, status);
+            return packFloatx80(aSign, floatx80_infinity.high,
+                                floatx80_infinity.low);
+        } else { /* |X| > 1 */
+            float_raise(float_flag_invalid, status);
+            return floatx80_default_nan(status);
+        }
+    } /* |X| < 1 */
+
+    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_prec = status->floatx80_rounding_precision;
+    status->float_rounding_mode = float_round_nearest_even;
+    status->floatx80_rounding_precision = 80;
+
+    one = packFloatx80(0, one_exp, one_sig);
+    fp2 = packFloatx80(aSign, 0x3FFE, one_sig); /* SIGN(X) * (1/2) */
+    fp0 = packFloatx80(0, aExp, aSig); /* Y = |X| */
+    fp1 = packFloatx80(1, aExp, aSig); /* -Y */
+    fp0 = floatx80_add(fp0, fp0, status); /* 2Y */
+    fp1 = floatx80_add(fp1, one, status); /* 1-Y */
+    fp0 = floatx80_div(fp0, fp1, status); /* Z = 2Y/(1-Y) */
+    fp0 = floatx80_lognp1(fp0, status); /* LOG1P(Z) */
+
+    status->float_rounding_mode = user_rnd_mode;
+    status->floatx80_rounding_precision = user_rnd_prec;
+
+    a = floatx80_mul(fp0, fp2,
+                     status); /* ATANH(X) = SIGN(X) * (1/2) * LOG1P(Z) */
+
+    float_raise(float_flag_inexact, status);
+
+    return a;
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 1140491c81..e9943aed20 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -40,4 +40,5 @@ floatx80 floatx80_cos(floatx80 a, float_status *status);
 floatx80 floatx80_atan(floatx80 a, float_status *status);
 floatx80 floatx80_asin(floatx80 a, float_status *status);
 floatx80 floatx80_acos(floatx80 a, float_status *status);
+floatx80 floatx80_atanh(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5fad76c785..2f7caa0ca0 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5063,6 +5063,9 @@ DISAS_INSN(fpu)
     case 0x0c: /* fasin */
         gen_helper_fasin(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x0d: /* fatanh */
+        gen_helper_fatanh(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x0e: /* fsin */
         gen_helper_fsin(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
