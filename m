Received: from eggs.gnu.org ([2001:4830:134:3::10]:45014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU3d-0005nY-Su
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU3a-00076X-J3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:33 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evU3a-00073I-8f
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:30 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Mar 2018 21:27:27 +0100
Message-Id: <20180312202728.23790-11-laurent@vivier.eu>
In-Reply-To: <20180312202728.23790-1-laurent@vivier.eu>
References: <20180312202728.23790-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 10/11] target/m68k: implement fsinh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>

Using a local m68k floatx80_sinh()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |  5 +++
 target/m68k/helper.h     |  1 +
 target/m68k/softfloat.c  | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |  1 +
 target/m68k/translate.c  |  3 ++
 5 files changed, 99 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 7d68879f34..4c969dfe00 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -643,3 +643,8 @@ void HELPER(ftanh)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_tanh(val->d, &env->fp_status);
 }
+
+void HELPER(fsinh)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_sinh(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index f100141367..acdca1af03 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -84,6 +84,7 @@ DEF_HELPER_3(fasin, void, env, fp, fp)
 DEF_HELPER_3(facos, void, env, fp, fp)
 DEF_HELPER_3(fatanh, void, env, fp, fp)
 DEF_HELPER_3(ftanh, void, env, fp, fp)
+DEF_HELPER_3(fsinh, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 4ce5783f03..1528bfd147 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -2733,3 +2733,92 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
         return a;
     }
 }
+
+/*----------------------------------------------------------------------------
+ | Hyperbolic sine
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_sinh(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact;
+    floatx80 fp0, fp1, fp2;
+    float32 fact;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a, status);
+        }
+        return packFloatx80(aSign, floatx80_infinity.high,
+                            floatx80_infinity.low);
+    }
+
+    if (aExp == 0 && aSig == 0) {
+        return packFloatx80(aSign, 0, 0);
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
+        /* SINHBIG */
+        if (compact > 0x400CB2B3) {
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                                        aSign, 0x8000, aSig, 0, status);
+        } else {
+            fp0 = floatx80_abs(a); /* Y = |X| */
+            fp0 = floatx80_sub(fp0, float64_to_floatx80(
+                               make_float64(0x40C62D38D3D64634), status),
+                               status); /* (|X|-16381LOG2_LEAD) */
+            fp0 = floatx80_sub(fp0, float64_to_floatx80(
+                               make_float64(0x3D6F90AEB1E75CC7), status),
+                               status); /* |X| - 16381 LOG2, ACCURATE */
+            fp0 = floatx80_etox(fp0, status);
+            fp2 = packFloatx80(aSign, 0x7FFB, one_sig);
+
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_mul(fp0, fp2, status);
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        }
+    } else { /* |X| < 16380 LOG2 */
+        fp0 = floatx80_abs(a); /* Y = |X| */
+        fp0 = floatx80_etoxm1(fp0, status); /* FP0 IS Z = EXPM1(Y) */
+        fp1 = floatx80_add(fp0, float32_to_floatx80(make_float32(0x3F800000),
+                           status), status); /* 1+Z */
+        fp2 = fp0;
+        fp0 = floatx80_div(fp0, fp1, status); /* Z/(1+Z) */
+        fp0 = floatx80_add(fp0, fp2, status);
+
+        fact = packFloat32(aSign, 0x7E, 0);
+
+        status->float_rounding_mode = user_rnd_mode;
+        status->floatx80_rounding_precision = user_rnd_prec;
+
+        a = floatx80_mul(fp0, float32_to_floatx80(fact, status), status);
+
+        float_raise(float_flag_inexact, status);
+
+        return a;
+    }
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 4cdb5a49ca..f033abf9ea 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -43,4 +43,5 @@ floatx80 floatx80_acos(floatx80 a, float_status *status);
 floatx80 floatx80_atanh(floatx80 a, float_status *status);
 floatx80 floatx80_etoxm1(floatx80 a, float_status *status);
 floatx80 floatx80_tanh(floatx80 a, float_status *status);
+floatx80 floatx80_sinh(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0caae904b5..7d83aaf91d 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5042,6 +5042,9 @@ DISAS_INSN(fpu)
     case 1: /* fint */
         gen_helper_firound(cpu_env, cpu_dest, cpu_src);
         break;
+    case 2: /* fsinh */
+        gen_helper_fsinh(cpu_env, cpu_dest, cpu_src);
+        break;
     case 3: /* fintrz */
         gen_helper_fitrunc(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
