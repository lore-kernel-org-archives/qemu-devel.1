Received: from eggs.gnu.org ([2001:4830:134:3::10]:39314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eswvI-00085y-17
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eswvE-0000Yh-UC
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:41:28 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eswvE-0000YE-KF
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:41:24 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  5 Mar 2018 21:39:07 +0100
Message-Id: <20180305203910.10391-6-laurent@vivier.eu>
In-Reply-To: <20180305203910.10391-1-laurent@vivier.eu>
References: <20180305203910.10391-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 5/8] target/m68k: implement flog2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Using a local m68k floatx80_log2()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |  5 ++++
 target/m68k/helper.h     |  1 +
 target/m68k/softfloat.c  | 67 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |  1 +
 target/m68k/translate.c  |  3 +++
 5 files changed, 77 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 2628534136..97a4501126 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -572,3 +572,8 @@ void HELPER(flog10)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_log10(val->d, &env->fp_status);
 }
+
+void HELPER(flog2)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_log2(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index d1f38f260f..15f63b353f 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -71,6 +71,7 @@ DEF_HELPER_4(fscale, void, env, fp, fp, fp)
 DEF_HELPER_3(flognp1, void, env, fp, fp)
 DEF_HELPER_3(flogn, void, env, fp, fp)
 DEF_HELPER_3(flog10, void, env, fp, fp)
+DEF_HELPER_3(flog2, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 22fd7f6341..9fa6d6fd05 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -715,3 +715,70 @@ floatx80 floatx80_log10(floatx80 a, float_status *status)
 
     return a;
 }
+
+/*----------------------------------------------------------------------------
+ | Log base 2
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_log2(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    floatx80 fp0, fp1;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            propagateFloatx80NaNOneArg(a, status);
+        }
+        if (aSign == 0) {
+            return packFloatx80(0, floatx80_infinity.high,
+                                floatx80_infinity.low);
+        }
+    }
+
+    if (aExp == 0) {
+        if (aSig == 0) {
+            float_raise(float_flag_divbyzero, status);
+            return packFloatx80(1, floatx80_infinity.high,
+                                floatx80_infinity.low);
+        }
+        normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
+    }
+
+    if (aSign) {
+        float_raise(float_flag_invalid, status);
+        return floatx80_default_nan(status);
+    }
+
+    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_prec = status->floatx80_rounding_precision;
+    status->float_rounding_mode = float_round_nearest_even;
+    status->floatx80_rounding_precision = 80;
+
+    if (aSig == one_sig) { /* X is 2^k */
+        status->float_rounding_mode = user_rnd_mode;
+        status->floatx80_rounding_precision = user_rnd_prec;
+
+        a = int32_to_floatx80(aExp - 0x3FFF, status);
+    } else {
+        fp0 = floatx80_logn(a, status);
+        fp1 = packFloatx80(0, 0x3FFF, LIT64(0xB8AA3B295C17F0BC)); /* INV_L2 */
+
+        status->float_rounding_mode = user_rnd_mode;
+        status->floatx80_rounding_precision = user_rnd_prec;
+
+        a = floatx80_mul(fp0, fp1, status); /* LOGN(X)*INV_L2 */
+    }
+
+    float_raise(float_flag_inexact, status);
+
+    return a;
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index ac29e76189..c0b77cf01b 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -30,4 +30,5 @@ floatx80 floatx80_move(floatx80 a, float_status *status);
 floatx80 floatx80_lognp1(floatx80 a, float_status *status);
 floatx80 floatx80_logn(floatx80 a, float_status *status);
 floatx80 floatx80_log10(floatx80 a, float_status *status);
+floatx80 floatx80_log2(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f1130df314..189b23d38d 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5063,6 +5063,9 @@ DISAS_INSN(fpu)
     case 0x15: /* flog10 */
         gen_helper_flog10(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x16: /* flog2 */
+        gen_helper_flog2(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x18: /* fabs */
         gen_helper_fabs(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
