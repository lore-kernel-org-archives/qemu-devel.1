Received: from eggs.gnu.org ([2001:4830:134:3::10]:58996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euIyv-00011d-Lz
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euIyq-0007Dz-EK
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:49 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:58653)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euIyq-0007DD-4M
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:44 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  9 Mar 2018 15:26:30 +0100
Message-Id: <20180309142630.2170-9-laurent@vivier.eu>
In-Reply-To: <20180309142630.2170-1-laurent@vivier.eu>
References: <20180309142630.2170-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 8/8] target/m68k: implement ftentox
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

Using a local m68k floatx80_tentox()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180305203910.10391-9-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |   5 ++
 target/m68k/helper.h     |   1 +
 target/m68k/softfloat.c  | 153 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |   1 +
 target/m68k/translate.c  |   3 +
 5 files changed, 163 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index f488a92ab2..62cbb0dff1 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -587,3 +587,8 @@ void HELPER(ftwotox)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_twotox(val->d, &env->fp_status);
 }
+
+void HELPER(ftentox)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_tentox(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 8caa82296d..9a9734c196 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -74,6 +74,7 @@ DEF_HELPER_3(flog10, void, env, fp, fp)
 DEF_HELPER_3(flog2, void, env, fp, fp)
 DEF_HELPER_3(fetox, void, env, fp, fp)
 DEF_HELPER_3(ftwotox, void, env, fp, fp)
+DEF_HELPER_3(ftentox, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index cfff30d359..4bd5b9e6b7 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -1113,3 +1113,156 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
         return a;
     }
 }
+
+/*----------------------------------------------------------------------------
+ | 10 to x
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_tentox(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact, n, j, l, m, m1;
+    floatx80 fp0, fp1, fp2, fp3, adjfact, fact1, fact2;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a, status);
+        }
+        if (aSign) {
+            return packFloatx80(0, 0, 0);
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
+    fp0 = a;
+
+    compact = floatx80_make_compact(aExp, aSig);
+
+    if (compact < 0x3FB98000 || compact > 0x400B9B07) {
+        /* |X| > 16480 LOG2/LOG10 or |X| < 2^(-70) */
+        if (compact > 0x3FFF8000) { /* |X| > 16480 */
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            if (aSign) {
+                return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                                            0, -0x1000, aSig, 0, status);
+            } else {
+                return roundAndPackFloatx80(status->floatx80_rounding_precision,
+                                            0, 0x8000, aSig, 0, status);
+            }
+        } else { /* |X| < 2^(-70) */
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_add(fp0, float32_to_floatx80(
+                             make_float32(0x3F800000), status),
+                             status); /* 1 + X */
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        }
+    } else { /* 2^(-70) <= |X| <= 16480 LOG 2 / LOG 10 */
+        fp1 = fp0; /* X */
+        fp1 = floatx80_mul(fp1, float64_to_floatx80(
+                           make_float64(0x406A934F0979A371),
+                           status), status); /* X*64*LOG10/LOG2 */
+        n = floatx80_to_int32(fp1, status); /* N=INT(X*64*LOG10/LOG2) */
+        fp1 = int32_to_floatx80(n, status);
+
+        j = n & 0x3F;
+        l = n / 64; /* NOTE: this is really arithmetic right shift by 6 */
+        if (n < 0 && j) {
+            /* arithmetic right shift is division and
+             * round towards minus infinity
+             */
+            l--;
+        }
+        m = l / 2; /* NOTE: this is really arithmetic right shift by 1 */
+        if (l < 0 && (l & 1)) {
+            /* arithmetic right shift is division and
+             * round towards minus infinity
+             */
+            m--;
+        }
+        m1 = l - m;
+        m1 += 0x3FFF; /* ADJFACT IS 2^(M') */
+
+        adjfact = packFloatx80(0, m1, one_sig);
+        fact1 = exp2_tbl[j];
+        fact1.high += m;
+        fact2.high = exp2_tbl2[j] >> 16;
+        fact2.high += m;
+        fact2.low = (uint64_t)(exp2_tbl2[j] & 0xFFFF);
+        fact2.low <<= 48;
+
+        fp2 = fp1; /* N */
+        fp1 = floatx80_mul(fp1, float64_to_floatx80(
+                           make_float64(0x3F734413509F8000), status),
+                           status); /* N*(LOG2/64LOG10)_LEAD */
+        fp3 = packFloatx80(1, 0x3FCD, LIT64(0xC0219DC1DA994FD2));
+        fp2 = floatx80_mul(fp2, fp3, status); /* N*(LOG2/64LOG10)_TRAIL */
+        fp0 = floatx80_sub(fp0, fp1, status); /* X - N L_LEAD */
+        fp0 = floatx80_sub(fp0, fp2, status); /* X - N L_TRAIL */
+        fp2 = packFloatx80(0, 0x4000, LIT64(0x935D8DDDAAA8AC17)); /* LOG10 */
+        fp0 = floatx80_mul(fp0, fp2, status); /* R */
+
+        /* EXPR */
+        fp1 = floatx80_mul(fp0, fp0, status); /* S = R*R */
+        fp2 = float64_to_floatx80(make_float64(0x3F56C16D6F7BD0B2),
+                                  status); /* A5 */
+        fp3 = float64_to_floatx80(make_float64(0x3F811112302C712C),
+                                  status); /* A4 */
+        fp2 = floatx80_mul(fp2, fp1, status); /* S*A5 */
+        fp3 = floatx80_mul(fp3, fp1, status); /* S*A4 */
+        fp2 = floatx80_add(fp2, float64_to_floatx80(
+                           make_float64(0x3FA5555555554CC1), status),
+                           status); /* A3+S*A5 */
+        fp3 = floatx80_add(fp3, float64_to_floatx80(
+                           make_float64(0x3FC5555555554A54), status),
+                           status); /* A2+S*A4 */
+        fp2 = floatx80_mul(fp2, fp1, status); /* S*(A3+S*A5) */
+        fp3 = floatx80_mul(fp3, fp1, status); /* S*(A2+S*A4) */
+        fp2 = floatx80_add(fp2, float64_to_floatx80(
+                           make_float64(0x3FE0000000000000), status),
+                           status); /* A1+S*(A3+S*A5) */
+        fp3 = floatx80_mul(fp3, fp0, status); /* R*S*(A2+S*A4) */
+
+        fp2 = floatx80_mul(fp2, fp1, status); /* S*(A1+S*(A3+S*A5)) */
+        fp0 = floatx80_add(fp0, fp3, status); /* R+R*S*(A2+S*A4) */
+        fp0 = floatx80_add(fp0, fp2, status); /* EXP(R) - 1 */
+
+        fp0 = floatx80_mul(fp0, fact1, status);
+        fp0 = floatx80_add(fp0, fact2, status);
+        fp0 = floatx80_add(fp0, fact1, status);
+
+        status->float_rounding_mode = user_rnd_mode;
+        status->floatx80_rounding_precision = user_rnd_prec;
+
+        a = floatx80_mul(fp0, adjfact, status);
+
+        float_raise(float_flag_inexact, status);
+
+        return a;
+    }
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 964275d2a5..d28e49fe9f 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -33,4 +33,5 @@ floatx80 floatx80_log10(floatx80 a, float_status *status);
 floatx80 floatx80_log2(floatx80 a, float_status *status);
 floatx80 floatx80_etox(floatx80 a, float_status *status);
 floatx80 floatx80_twotox(floatx80 a, float_status *status);
+floatx80 floatx80_tentox(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index c65c82e258..6d5bde0777 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5063,6 +5063,9 @@ DISAS_INSN(fpu)
     case 0x11: /* ftwotox */
         gen_helper_ftwotox(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x12: /* ftentox */
+        gen_helper_ftentox(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x14: /* flogn */
         gen_helper_flogn(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
