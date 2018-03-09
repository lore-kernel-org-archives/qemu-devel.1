Received: from eggs.gnu.org ([2001:4830:134:3::10]:38152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euJSj-0003K3-KA
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euJSg-0002yZ-De
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:57:37 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euJSg-0002xD-32
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:57:34 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  9 Mar 2018 15:57:12 +0100
Message-Id: <20180309145717.9603-4-laurent@vivier.eu>
In-Reply-To: <20180309145717.9603-1-laurent@vivier.eu>
References: <20180309145717.9603-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 3/8] target/m68k: implement flogn
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

Using a local m68k floatx80_logn()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180305203910.10391-4-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |   5 ++
 target/m68k/helper.h     |   1 +
 target/m68k/softfloat.c  | 168 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |   1 +
 target/m68k/translate.c  |   3 +
 5 files changed, 178 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 614064612e..cc6d3dfa52 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -562,3 +562,8 @@ void HELPER(flognp1)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_lognp1(val->d, &env->fp_status);
 }
+
+void HELPER(flogn)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_logn(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index f7e6fc8c40..68e5f4c0a7 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -69,6 +69,7 @@ DEF_HELPER_3(fgetexp, void, env, fp, fp)
 DEF_HELPER_3(fgetman, void, env, fp, fp)
 DEF_HELPER_4(fscale, void, env, fp, fp, fp)
 DEF_HELPER_3(flognp1, void, env, fp, fp)
+DEF_HELPER_3(flogn, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 834db12964..180a17c39b 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -490,3 +490,171 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
         return a;
     }
 }
+
+/*----------------------------------------------------------------------------
+ | Log base e
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_logn(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig, fSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact, j, k, adjk;
+    floatx80 fp0, fp1, fp2, fp3, f, logof2, klog2, saveu;
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
+    adjk = 0;
+
+    if (aExp == 0) {
+        if (aSig == 0) { /* zero */
+            float_raise(float_flag_divbyzero, status);
+            return packFloatx80(1, floatx80_infinity.high,
+                                floatx80_infinity.low);
+        }
+        if ((aSig & one_sig) == 0) { /* denormal */
+            normalizeFloatx80Subnormal(aSig, &aExp, &aSig);
+            adjk = -100;
+            aExp += 100;
+            a = packFloatx80(aSign, aExp, aSig);
+        }
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
+    compact = floatx80_make_compact(aExp, aSig);
+
+    if (compact < 0x3FFEF07D || compact > 0x3FFF8841) {
+        /* |X| < 15/16 or |X| > 17/16 */
+        k = aExp - 0x3FFF;
+        k += adjk;
+        fp1 = int32_to_floatx80(k, status);
+
+        fSig = (aSig & LIT64(0xFE00000000000000)) | LIT64(0x0100000000000000);
+        j = (fSig >> 56) & 0x7E; /* DISPLACEMENT FOR 1/F */
+
+        f = packFloatx80(0, 0x3FFF, fSig); /* F */
+        fp0 = packFloatx80(0, 0x3FFF, aSig); /* Y */
+
+        fp0 = floatx80_sub(fp0, f, status); /* Y-F */
+
+        /* LP1CONT1 */
+        fp0 = floatx80_mul(fp0, log_tbl[j], status); /* FP0 IS U = (Y-F)/F */
+        logof2 = packFloatx80(0, 0x3FFE, LIT64(0xB17217F7D1CF79AC));
+        klog2 = floatx80_mul(fp1, logof2, status); /* FP1 IS K*LOG2 */
+        fp2 = floatx80_mul(fp0, fp0, status); /* FP2 IS V=U*U */
+
+        fp3 = fp2;
+        fp1 = fp2;
+
+        fp1 = floatx80_mul(fp1, float64_to_floatx80(
+                           make_float64(0x3FC2499AB5E4040B), status),
+                           status); /* V*A6 */
+        fp2 = floatx80_mul(fp2, float64_to_floatx80(
+                           make_float64(0xBFC555B5848CB7DB), status),
+                           status); /* V*A5 */
+        fp1 = floatx80_add(fp1, float64_to_floatx80(
+                           make_float64(0x3FC99999987D8730), status),
+                           status); /* A4+V*A6 */
+        fp2 = floatx80_add(fp2, float64_to_floatx80(
+                           make_float64(0xBFCFFFFFFF6F7E97), status),
+                           status); /* A3+V*A5 */
+        fp1 = floatx80_mul(fp1, fp3, status); /* V*(A4+V*A6) */
+        fp2 = floatx80_mul(fp2, fp3, status); /* V*(A3+V*A5) */
+        fp1 = floatx80_add(fp1, float64_to_floatx80(
+                           make_float64(0x3FD55555555555A4), status),
+                           status); /* A2+V*(A4+V*A6) */
+        fp2 = floatx80_add(fp2, float64_to_floatx80(
+                           make_float64(0xBFE0000000000008), status),
+                           status); /* A1+V*(A3+V*A5) */
+        fp1 = floatx80_mul(fp1, fp3, status); /* V*(A2+V*(A4+V*A6)) */
+        fp2 = floatx80_mul(fp2, fp3, status); /* V*(A1+V*(A3+V*A5)) */
+        fp1 = floatx80_mul(fp1, fp0, status); /* U*V*(A2+V*(A4+V*A6)) */
+        fp0 = floatx80_add(fp0, fp2, status); /* U+V*(A1+V*(A3+V*A5)) */
+
+        fp1 = floatx80_add(fp1, log_tbl[j + 1],
+                           status); /* LOG(F)+U*V*(A2+V*(A4+V*A6)) */
+        fp0 = floatx80_add(fp0, fp1, status); /* FP0 IS LOG(F) + LOG(1+U) */
+
+        status->float_rounding_mode = user_rnd_mode;
+        status->floatx80_rounding_precision = user_rnd_prec;
+
+        a = floatx80_add(fp0, klog2, status);
+
+        float_raise(float_flag_inexact, status);
+
+        return a;
+    } else { /* |X-1| >= 1/16 */
+        fp0 = a;
+        fp1 = a;
+        fp1 = floatx80_sub(fp1, float32_to_floatx80(make_float32(0x3F800000),
+                           status), status); /* FP1 IS X-1 */
+        fp0 = floatx80_add(fp0, float32_to_floatx80(make_float32(0x3F800000),
+                           status), status); /* FP0 IS X+1 */
+        fp1 = floatx80_add(fp1, fp1, status); /* FP1 IS 2(X-1) */
+
+        /* LP1CONT2 */
+        fp1 = floatx80_div(fp1, fp0, status); /* U */
+        saveu = fp1;
+        fp0 = floatx80_mul(fp1, fp1, status); /* FP0 IS V = U*U */
+        fp1 = floatx80_mul(fp0, fp0, status); /* FP1 IS W = V*V */
+
+        fp3 = float64_to_floatx80(make_float64(0x3F175496ADD7DAD6),
+                                  status); /* B5 */
+        fp2 = float64_to_floatx80(make_float64(0x3F3C71C2FE80C7E0),
+                                  status); /* B4 */
+        fp3 = floatx80_mul(fp3, fp1, status); /* W*B5 */
+        fp2 = floatx80_mul(fp2, fp1, status); /* W*B4 */
+        fp3 = floatx80_add(fp3, float64_to_floatx80(
+                           make_float64(0x3F624924928BCCFF), status),
+                           status); /* B3+W*B5 */
+        fp2 = floatx80_add(fp2, float64_to_floatx80(
+                           make_float64(0x3F899999999995EC), status),
+                           status); /* B2+W*B4 */
+        fp1 = floatx80_mul(fp1, fp3, status); /* W*(B3+W*B5) */
+        fp2 = floatx80_mul(fp2, fp0, status); /* V*(B2+W*B4) */
+        fp1 = floatx80_add(fp1, float64_to_floatx80(
+                           make_float64(0x3FB5555555555555), status),
+                           status); /* B1+W*(B3+W*B5) */
+
+        fp0 = floatx80_mul(fp0, saveu, status); /* FP0 IS U*V */
+        fp1 = floatx80_add(fp1, fp2, status); /* B1+W*(B3+W*B5) + V*(B2+W*B4) */
+        fp0 = floatx80_mul(fp0, fp1,
+                           status); /* U*V*([B1+W*(B3+W*B5)] + [V*(B2+W*B4)]) */
+
+        status->float_rounding_mode = user_rnd_mode;
+        status->floatx80_rounding_precision = user_rnd_prec;
+
+        a = floatx80_add(fp0, saveu, status);
+
+        /*if (!floatx80_is_zero(a)) { */
+            float_raise(float_flag_inexact, status);
+        /*} */
+
+        return a;
+    }
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 4d74eaf862..161bd6dff7 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -28,4 +28,5 @@ floatx80 floatx80_getexp(floatx80 a, float_status *status);
 floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status);
 floatx80 floatx80_move(floatx80 a, float_status *status);
 floatx80 floatx80_lognp1(floatx80 a, float_status *status);
+floatx80 floatx80_logn(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 2c3d20154a..705b9b0d5b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5057,6 +5057,9 @@ DISAS_INSN(fpu)
     case 0x06: /* flognp1 */
         gen_helper_flognp1(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x14: /* flogn */
+        gen_helper_flogn(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x18: /* fabs */
         gen_helper_fabs(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
