Received: from eggs.gnu.org ([2001:4830:134:3::10]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eswul-0007fQ-WA
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eswui-0000O4-TJ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:40:56 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:47341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eswui-0000Nk-IL
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:40:52 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  5 Mar 2018 21:39:06 +0100
Message-Id: <20180305203910.10391-5-laurent@vivier.eu>
In-Reply-To: <20180305203910.10391-1-laurent@vivier.eu>
References: <20180305203910.10391-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 4/8] target/m68k: implement flog10
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

Using a local m68k floatx80_log10()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |  5 +++++
 target/m68k/helper.h     |  1 +
 target/m68k/softfloat.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |  1 +
 target/m68k/translate.c  |  3 +++
 5 files changed, 67 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index cc6d3dfa52..2628534136 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -567,3 +567,8 @@ void HELPER(flogn)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_logn(val->d, &env->fp_status);
 }
+
+void HELPER(flog10)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_log10(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 68e5f4c0a7..d1f38f260f 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -70,6 +70,7 @@ DEF_HELPER_3(fgetman, void, env, fp, fp)
 DEF_HELPER_4(fscale, void, env, fp, fp, fp)
 DEF_HELPER_3(flognp1, void, env, fp, fp)
 DEF_HELPER_3(flogn, void, env, fp, fp)
+DEF_HELPER_3(flog10, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 180a17c39b..22fd7f6341 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -658,3 +658,60 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
         return a;
     }
 }
+
+/*----------------------------------------------------------------------------
+ | Log base 10
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_log10(floatx80 a, float_status *status)
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
+    if (aExp == 0 && aSig == 0) {
+        float_raise(float_flag_divbyzero, status);
+        return packFloatx80(1, floatx80_infinity.high,
+                            floatx80_infinity.low);
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
+    fp0 = floatx80_logn(a, status);
+    fp1 = packFloatx80(0, 0x3FFD, LIT64(0xDE5BD8A937287195)); /* INV_L10 */
+
+    status->float_rounding_mode = user_rnd_mode;
+    status->floatx80_rounding_precision = user_rnd_prec;
+
+    a = floatx80_mul(fp0, fp1, status); /* LOGN(X)*INV_L10 */
+
+    float_raise(float_flag_inexact, status);
+
+    return a;
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 161bd6dff7..ac29e76189 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -29,4 +29,5 @@ floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status);
 floatx80 floatx80_move(floatx80 a, float_status *status);
 floatx80 floatx80_lognp1(floatx80 a, float_status *status);
 floatx80 floatx80_logn(floatx80 a, float_status *status);
+floatx80 floatx80_log10(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 705b9b0d5b..f1130df314 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5060,6 +5060,9 @@ DISAS_INSN(fpu)
     case 0x14: /* flogn */
         gen_helper_flogn(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x15: /* flog10 */
+        gen_helper_flog10(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x18: /* fabs */
         gen_helper_fabs(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
