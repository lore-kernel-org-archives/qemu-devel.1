Received: from eggs.gnu.org ([2001:4830:134:3::10]:54556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evmLZ-0002xg-6g
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evmLT-0002xA-0e
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:17 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evmLS-0002wD-Me
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:10 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 16:59:14 +0100
Message-Id: <20180313155918.23591-8-laurent@vivier.eu>
In-Reply-To: <20180313155918.23591-1-laurent@vivier.eu>
References: <20180313155918.23591-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 07/11] target/m68k: implement facos
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

Using a local m68k floatx80_acos()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180312202728.23790-8-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |  5 ++++
 target/m68k/helper.h     |  1 +
 target/m68k/softfloat.c  | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |  1 +
 target/m68k/translate.c  |  3 +++
 5 files changed, 80 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 972cc97d96..18ad6999cb 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -628,3 +628,8 @@ void HELPER(fasin)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_asin(val->d, &env->fp_status);
 }
+
+void HELPER(facos)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_acos(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index e1aca375e0..83247a8143 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -81,6 +81,7 @@ DEF_HELPER_3(fcos, void, env, fp, fp)
 DEF_HELPER_4(fsincos, void, env, fp, fp, fp)
 DEF_HELPER_3(fatan, void, env, fp, fp)
 DEF_HELPER_3(fasin, void, env, fp, fp)
+DEF_HELPER_3(facos, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 91f0435ac3..3d66f6946f 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -23,6 +23,7 @@
 #include "fpu/softfloat-macros.h"
 #include "softfloat_fpsp_tables.h"
 
+#define pi_exp      0x4000
 #define piby2_exp   0x3FFF
 #define pi_sig      LIT64(0xc90fdaa22168c235)
 
@@ -2232,3 +2233,72 @@ floatx80 floatx80_asin(floatx80 a, float_status *status)
 
     return a;
 }
+
+/*----------------------------------------------------------------------------
+ | Arc cosine
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_acos(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact;
+    floatx80 fp0, fp1, one;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF && (uint64_t) (aSig << 1)) {
+        return propagateFloatx80NaNOneArg(a, status);
+    }
+    if (aExp == 0 && aSig == 0) {
+        float_raise(float_flag_inexact, status);
+        return roundAndPackFloatx80(status->floatx80_rounding_precision, 0,
+                                    piby2_exp, pi_sig, 0, status);
+    }
+
+    compact = floatx80_make_compact(aExp, aSig);
+
+    if (compact >= 0x3FFF8000) { /* |X| >= 1 */
+        if (aExp == one_exp && aSig == one_sig) { /* |X| == 1 */
+            if (aSign) { /* X == -1 */
+                a = packFloatx80(0, pi_exp, pi_sig);
+                float_raise(float_flag_inexact, status);
+                return floatx80_move(a, status);
+            } else { /* X == +1 */
+                return packFloatx80(0, 0, 0);
+            }
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
+    fp0 = a;
+
+    fp1 = floatx80_add(one, fp0, status);   /* 1 + X */
+    fp0 = floatx80_sub(one, fp0, status);   /* 1 - X */
+    fp0 = floatx80_div(fp0, fp1, status);   /* (1-X)/(1+X) */
+    fp0 = floatx80_sqrt(fp0, status);       /* SQRT((1-X)/(1+X)) */
+    fp0 = floatx80_atan(fp0, status);       /* ATAN(SQRT((1-X)/(1+X))) */
+
+    status->float_rounding_mode = user_rnd_mode;
+    status->floatx80_rounding_precision = user_rnd_prec;
+
+    a = floatx80_add(fp0, fp0, status);     /* 2 * ATAN(SQRT((1-X)/(1+X))) */
+
+    float_raise(float_flag_inexact, status);
+
+    return a;
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index ca0eb674aa..1140491c81 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -39,4 +39,5 @@ floatx80 floatx80_sin(floatx80 a, float_status *status);
 floatx80 floatx80_cos(floatx80 a, float_status *status);
 floatx80 floatx80_atan(floatx80 a, float_status *status);
 floatx80 floatx80_asin(floatx80 a, float_status *status);
+floatx80 floatx80_acos(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d4169c4533..5fad76c785 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5105,6 +5105,9 @@ DISAS_INSN(fpu)
     case 0x5e: /* fdneg */
         gen_helper_fdneg(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x1c: /* facos */
+        gen_helper_facos(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x1d: /* fcos */
         gen_helper_fcos(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
