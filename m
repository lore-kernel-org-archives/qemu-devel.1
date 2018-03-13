Received: from eggs.gnu.org ([2001:4830:134:3::10]:54581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evmLb-00031q-46
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evmLW-0002zT-At
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:19 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evmLV-0002yK-Ar
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:13 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 16:59:18 +0100
Message-Id: <20180313155918.23591-12-laurent@vivier.eu>
In-Reply-To: <20180313155918.23591-1-laurent@vivier.eu>
References: <20180313155918.23591-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 11/11] target/m68k: implement fcosh
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

Using a local m68k  floatx80_cosh()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180312202728.23790-12-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |  5 +++
 target/m68k/helper.h     |  1 +
 target/m68k/softfloat.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |  1 +
 target/m68k/translate.c  |  3 ++
 5 files changed, 91 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 4c969dfe00..6eeffdf9bb 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -648,3 +648,8 @@ void HELPER(fsinh)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_sinh(val->d, &env->fp_status);
 }
+
+void HELPER(fcosh)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_cosh(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index acdca1af03..feee7be626 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -85,6 +85,7 @@ DEF_HELPER_3(facos, void, env, fp, fp)
 DEF_HELPER_3(fatanh, void, env, fp, fp)
 DEF_HELPER_3(ftanh, void, env, fp, fp)
 DEF_HELPER_3(fsinh, void, env, fp, fp)
+DEF_HELPER_3(fcosh, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 1528bfd147..dffb371c71 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -2822,3 +2822,84 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
         return a;
     }
 }
+
+/*----------------------------------------------------------------------------
+ | Hyperbolic cosine
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_cosh(floatx80 a, float_status *status)
+{
+    int32_t aExp;
+    uint64_t aSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact;
+    floatx80 fp0, fp1;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a, status);
+        }
+        return packFloatx80(0, floatx80_infinity.high,
+                            floatx80_infinity.low);
+    }
+
+    if (aExp == 0 && aSig == 0) {
+        return packFloatx80(0, one_exp, one_sig);
+    }
+
+    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_prec = status->floatx80_rounding_precision;
+    status->float_rounding_mode = float_round_nearest_even;
+    status->floatx80_rounding_precision = 80;
+
+    compact = floatx80_make_compact(aExp, aSig);
+
+    if (compact > 0x400CB167) {
+        if (compact > 0x400CB2B3) {
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+            return roundAndPackFloatx80(status->floatx80_rounding_precision, 0,
+                                        0x8000, one_sig, 0, status);
+        } else {
+            fp0 = packFloatx80(0, aExp, aSig);
+            fp0 = floatx80_sub(fp0, float64_to_floatx80(
+                               make_float64(0x40C62D38D3D64634), status),
+                               status);
+            fp0 = floatx80_sub(fp0, float64_to_floatx80(
+                               make_float64(0x3D6F90AEB1E75CC7), status),
+                               status);
+            fp0 = floatx80_etox(fp0, status);
+            fp1 = packFloatx80(0, 0x7FFB, one_sig);
+
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_mul(fp0, fp1, status);
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        }
+    }
+
+    fp0 = packFloatx80(0, aExp, aSig); /* |X| */
+    fp0 = floatx80_etox(fp0, status); /* EXP(|X|) */
+    fp0 = floatx80_mul(fp0, float32_to_floatx80(make_float32(0x3F000000),
+                       status), status); /* (1/2)*EXP(|X|) */
+    fp1 = float32_to_floatx80(make_float32(0x3E800000), status); /* 1/4 */
+    fp1 = floatx80_div(fp1, fp0, status); /* 1/(2*EXP(|X|)) */
+
+    status->float_rounding_mode = user_rnd_mode;
+    status->floatx80_rounding_precision = user_rnd_prec;
+
+    a = floatx80_add(fp0, fp1, status);
+
+    float_raise(float_flag_inexact, status);
+
+    return a;
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index f033abf9ea..602661d5a8 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -44,4 +44,5 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status);
 floatx80 floatx80_etoxm1(floatx80 a, float_status *status);
 floatx80 floatx80_tanh(floatx80 a, float_status *status);
 floatx80 floatx80_sinh(floatx80 a, float_status *status);
+floatx80 floatx80_cosh(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 7d83aaf91d..cef6f663ad 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5105,6 +5105,9 @@ DISAS_INSN(fpu)
     case 0x5c: /* fdabs */
         gen_helper_fdabs(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x19: /* fcosh */
+        gen_helper_fcosh(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x1a: /* fneg */
         gen_helper_fneg(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
