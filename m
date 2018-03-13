Received: from eggs.gnu.org ([2001:4830:134:3::10]:54559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evmLZ-0002yB-8E
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evmLU-0002yR-DH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:48435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evmLT-0002xJ-Vc
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 16:59:16 +0100
Message-Id: <20180313155918.23591-10-laurent@vivier.eu>
In-Reply-To: <20180313155918.23591-1-laurent@vivier.eu>
References: <20180313155918.23591-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 09/11] target/m68k: implement ftanh
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

Using local m68k floatx80_tanh() and floatx80_etoxm1()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180312202728.23790-10-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |   5 +
 target/m68k/helper.h     |   1 +
 target/m68k/softfloat.c  | 366 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |   2 +
 target/m68k/translate.c  |   3 +
 5 files changed, 377 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 38b663e1d2..7d68879f34 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -638,3 +638,8 @@ void HELPER(fatanh)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_atanh(val->d, &env->fp_status);
 }
+
+void HELPER(ftanh)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_tanh(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 092baec3d5..f100141367 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -83,6 +83,7 @@ DEF_HELPER_3(fatan, void, env, fp, fp)
 DEF_HELPER_3(fasin, void, env, fp, fp)
 DEF_HELPER_3(facos, void, env, fp, fp)
 DEF_HELPER_3(fatanh, void, env, fp, fp)
+DEF_HELPER_3(ftanh, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 5ce8413e96..4ce5783f03 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -2367,3 +2367,369 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status)
 
     return a;
 }
+
+/*----------------------------------------------------------------------------
+ | e to x minus 1
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact, n, j, m, m1;
+    floatx80 fp0, fp1, fp2, fp3, l2, sc, onebysc;
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
+            return packFloatx80(aSign, one_exp, one_sig);
+        }
+        return packFloatx80(0, floatx80_infinity.high,
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
+    if (aExp >= 0x3FFD) { /* |X| >= 1/4 */
+        compact = floatx80_make_compact(aExp, aSig);
+
+        if (compact <= 0x4004C215) { /* |X| <= 70 log2 */
+            fp0 = a;
+            fp1 = a;
+            fp0 = floatx80_mul(fp0, float32_to_floatx80(
+                               make_float32(0x42B8AA3B), status),
+                               status); /* 64/log2 * X */
+            n = floatx80_to_int32(fp0, status); /* int(64/log2*X) */
+            fp0 = int32_to_floatx80(n, status);
+
+            j = n & 0x3F; /* J = N mod 64 */
+            m = n / 64; /* NOTE: this is really arithmetic right shift by 6 */
+            if (n < 0 && j) {
+                /* arithmetic right shift is division and
+                 * round towards minus infinity
+                 */
+                m--;
+            }
+            m1 = -m;
+            /*m += 0x3FFF; // biased exponent of 2^(M) */
+            /*m1 += 0x3FFF; // biased exponent of -2^(-M) */
+
+            fp2 = fp0; /* N */
+            fp0 = floatx80_mul(fp0, float32_to_floatx80(
+                               make_float32(0xBC317218), status),
+                               status); /* N * L1, L1 = lead(-log2/64) */
+            l2 = packFloatx80(0, 0x3FDC, LIT64(0x82E308654361C4C6));
+            fp2 = floatx80_mul(fp2, l2, status); /* N * L2, L1+L2 = -log2/64 */
+            fp0 = floatx80_add(fp0, fp1, status); /* X + N*L1 */
+            fp0 = floatx80_add(fp0, fp2, status); /* R */
+
+            fp1 = floatx80_mul(fp0, fp0, status); /* S = R*R */
+            fp2 = float32_to_floatx80(make_float32(0x3950097B),
+                                      status); /* A6 */
+            fp2 = floatx80_mul(fp2, fp1, status); /* fp2 is S*A6 */
+            fp3 = floatx80_mul(float32_to_floatx80(make_float32(0x3AB60B6A),
+                               status), fp1, status); /* fp3 is S*A5 */
+            fp2 = floatx80_add(fp2, float64_to_floatx80(
+                               make_float64(0x3F81111111174385), status),
+                               status); /* fp2 IS A4+S*A6 */
+            fp3 = floatx80_add(fp3, float64_to_floatx80(
+                               make_float64(0x3FA5555555554F5A), status),
+                               status); /* fp3 is A3+S*A5 */
+            fp2 = floatx80_mul(fp2, fp1, status); /* fp2 IS S*(A4+S*A6) */
+            fp3 = floatx80_mul(fp3, fp1, status); /* fp3 IS S*(A3+S*A5) */
+            fp2 = floatx80_add(fp2, float64_to_floatx80(
+                               make_float64(0x3FC5555555555555), status),
+                               status); /* fp2 IS A2+S*(A4+S*A6) */
+            fp3 = floatx80_add(fp3, float32_to_floatx80(
+                               make_float32(0x3F000000), status),
+                               status); /* fp3 IS A1+S*(A3+S*A5) */
+            fp2 = floatx80_mul(fp2, fp1,
+                               status); /* fp2 IS S*(A2+S*(A4+S*A6)) */
+            fp1 = floatx80_mul(fp1, fp3,
+                               status); /* fp1 IS S*(A1+S*(A3+S*A5)) */
+            fp2 = floatx80_mul(fp2, fp0,
+                               status); /* fp2 IS R*S*(A2+S*(A4+S*A6)) */
+            fp0 = floatx80_add(fp0, fp1,
+                               status); /* fp0 IS R+S*(A1+S*(A3+S*A5)) */
+            fp0 = floatx80_add(fp0, fp2, status); /* fp0 IS EXP(R) - 1 */
+
+            fp0 = floatx80_mul(fp0, exp_tbl[j],
+                               status); /* 2^(J/64)*(Exp(R)-1) */
+
+            if (m >= 64) {
+                fp1 = float32_to_floatx80(exp_tbl2[j], status);
+                onebysc = packFloatx80(1, m1 + 0x3FFF, one_sig); /* -2^(-M) */
+                fp1 = floatx80_add(fp1, onebysc, status);
+                fp0 = floatx80_add(fp0, fp1, status);
+                fp0 = floatx80_add(fp0, exp_tbl[j], status);
+            } else if (m < -3) {
+                fp0 = floatx80_add(fp0, float32_to_floatx80(exp_tbl2[j],
+                                   status), status);
+                fp0 = floatx80_add(fp0, exp_tbl[j], status);
+                onebysc = packFloatx80(1, m1 + 0x3FFF, one_sig); /* -2^(-M) */
+                fp0 = floatx80_add(fp0, onebysc, status);
+            } else { /* -3 <= m <= 63 */
+                fp1 = exp_tbl[j];
+                fp0 = floatx80_add(fp0, float32_to_floatx80(exp_tbl2[j],
+                                   status), status);
+                onebysc = packFloatx80(1, m1 + 0x3FFF, one_sig); /* -2^(-M) */
+                fp1 = floatx80_add(fp1, onebysc, status);
+                fp0 = floatx80_add(fp0, fp1, status);
+            }
+
+            sc = packFloatx80(0, m + 0x3FFF, one_sig);
+
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_mul(fp0, sc, status);
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        } else { /* |X| > 70 log2 */
+            if (aSign) {
+                fp0 = float32_to_floatx80(make_float32(0xBF800000),
+                      status); /* -1 */
+
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+
+                a = floatx80_add(fp0, float32_to_floatx80(
+                                 make_float32(0x00800000), status),
+                                 status); /* -1 + 2^(-126) */
+
+                float_raise(float_flag_inexact, status);
+
+                return a;
+            } else {
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+
+                return floatx80_etox(a, status);
+            }
+        }
+    } else { /* |X| < 1/4 */
+        if (aExp >= 0x3FBE) {
+            fp0 = a;
+            fp0 = floatx80_mul(fp0, fp0, status); /* S = X*X */
+            fp1 = float32_to_floatx80(make_float32(0x2F30CAA8),
+                                      status); /* B12 */
+            fp1 = floatx80_mul(fp1, fp0, status); /* S * B12 */
+            fp2 = float32_to_floatx80(make_float32(0x310F8290),
+                                      status); /* B11 */
+            fp1 = floatx80_add(fp1, float32_to_floatx80(
+                               make_float32(0x32D73220), status),
+                               status); /* B10 */
+            fp2 = floatx80_mul(fp2, fp0, status);
+            fp1 = floatx80_mul(fp1, fp0, status);
+            fp2 = floatx80_add(fp2, float32_to_floatx80(
+                               make_float32(0x3493F281), status),
+                               status); /* B9 */
+            fp1 = floatx80_add(fp1, float64_to_floatx80(
+                               make_float64(0x3EC71DE3A5774682), status),
+                               status); /* B8 */
+            fp2 = floatx80_mul(fp2, fp0, status);
+            fp1 = floatx80_mul(fp1, fp0, status);
+            fp2 = floatx80_add(fp2, float64_to_floatx80(
+                               make_float64(0x3EFA01A019D7CB68), status),
+                               status); /* B7 */
+            fp1 = floatx80_add(fp1, float64_to_floatx80(
+                               make_float64(0x3F2A01A01A019DF3), status),
+                               status); /* B6 */
+            fp2 = floatx80_mul(fp2, fp0, status);
+            fp1 = floatx80_mul(fp1, fp0, status);
+            fp2 = floatx80_add(fp2, float64_to_floatx80(
+                               make_float64(0x3F56C16C16C170E2), status),
+                               status); /* B5 */
+            fp1 = floatx80_add(fp1, float64_to_floatx80(
+                               make_float64(0x3F81111111111111), status),
+                               status); /* B4 */
+            fp2 = floatx80_mul(fp2, fp0, status);
+            fp1 = floatx80_mul(fp1, fp0, status);
+            fp2 = floatx80_add(fp2, float64_to_floatx80(
+                               make_float64(0x3FA5555555555555), status),
+                               status); /* B3 */
+            fp3 = packFloatx80(0, 0x3FFC, LIT64(0xAAAAAAAAAAAAAAAB));
+            fp1 = floatx80_add(fp1, fp3, status); /* B2 */
+            fp2 = floatx80_mul(fp2, fp0, status);
+            fp1 = floatx80_mul(fp1, fp0, status);
+
+            fp2 = floatx80_mul(fp2, fp0, status);
+            fp1 = floatx80_mul(fp1, a, status);
+
+            fp0 = floatx80_mul(fp0, float32_to_floatx80(
+                               make_float32(0x3F000000), status),
+                               status); /* S*B1 */
+            fp1 = floatx80_add(fp1, fp2, status); /* Q */
+            fp0 = floatx80_add(fp0, fp1, status); /* S*B1+Q */
+
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_add(fp0, a, status);
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        } else { /* |X| < 2^(-65) */
+            sc = packFloatx80(1, 1, one_sig);
+            fp0 = a;
+
+            if (aExp < 0x0033) { /* |X| < 2^(-16382) */
+                fp0 = floatx80_mul(fp0, float64_to_floatx80(
+                                   make_float64(0x48B0000000000000), status),
+                                   status);
+                fp0 = floatx80_add(fp0, sc, status);
+
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+
+                a = floatx80_mul(fp0, float64_to_floatx80(
+                                 make_float64(0x3730000000000000), status),
+                                 status);
+            } else {
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+
+                a = floatx80_add(fp0, sc, status);
+            }
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        }
+    }
+}
+
+/*----------------------------------------------------------------------------
+ | Hyperbolic tangent
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_tanh(floatx80 a, float_status *status)
+{
+    flag aSign, vSign;
+    int32_t aExp, vExp;
+    uint64_t aSig, vSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact;
+    floatx80 fp0, fp1;
+    uint32_t sign;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a, status);
+        }
+        return packFloatx80(aSign, one_exp, one_sig);
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
+    if (compact < 0x3FD78000 || compact > 0x3FFFDDCE) {
+        /* TANHBORS */
+        if (compact < 0x3FFF8000) {
+            /* TANHSM */
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_move(a, status);
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        } else {
+            if (compact > 0x40048AA1) {
+                /* TANHHUGE */
+                sign = 0x3F800000;
+                sign |= aSign ? 0x80000000 : 0x00000000;
+                fp0 = float32_to_floatx80(make_float32(sign), status);
+                sign &= 0x80000000;
+                sign ^= 0x80800000; /* -SIGN(X)*EPS */
+
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+
+                a = floatx80_add(fp0, float32_to_floatx80(make_float32(sign),
+                                 status), status);
+
+                float_raise(float_flag_inexact, status);
+
+                return a;
+            } else {
+                fp0 = packFloatx80(0, aExp + 1, aSig); /* Y = 2|X| */
+                fp0 = floatx80_etox(fp0, status); /* FP0 IS EXP(Y) */
+                fp0 = floatx80_add(fp0, float32_to_floatx80(
+                                   make_float32(0x3F800000),
+                                   status), status); /* EXP(Y)+1 */
+                sign = aSign ? 0x80000000 : 0x00000000;
+                fp1 = floatx80_div(float32_to_floatx80(make_float32(
+                                   sign ^ 0xC0000000), status), fp0,
+                                   status); /* -SIGN(X)*2 / [EXP(Y)+1] */
+                fp0 = float32_to_floatx80(make_float32(sign | 0x3F800000),
+                                          status); /* SIGN */
+
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+
+                a = floatx80_add(fp1, fp0, status);
+
+                float_raise(float_flag_inexact, status);
+
+                return a;
+            }
+        }
+    } else { /* 2**(-40) < |X| < (5/2)LOG2 */
+        fp0 = packFloatx80(0, aExp + 1, aSig); /* Y = 2|X| */
+        fp0 = floatx80_etoxm1(fp0, status); /* FP0 IS Z = EXPM1(Y) */
+        fp1 = floatx80_add(fp0, float32_to_floatx80(make_float32(0x40000000),
+                           status),
+                           status); /* Z+2 */
+
+        vSign = extractFloatx80Sign(fp1);
+        vExp = extractFloatx80Exp(fp1);
+        vSig = extractFloatx80Frac(fp1);
+
+        fp1 = packFloatx80(vSign ^ aSign, vExp, vSig);
+
+        status->float_rounding_mode = user_rnd_mode;
+        status->floatx80_rounding_precision = user_rnd_prec;
+
+        a = floatx80_div(fp0, fp1, status);
+
+        float_raise(float_flag_inexact, status);
+
+        return a;
+    }
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index e9943aed20..4cdb5a49ca 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -41,4 +41,6 @@ floatx80 floatx80_atan(floatx80 a, float_status *status);
 floatx80 floatx80_asin(floatx80 a, float_status *status);
 floatx80 floatx80_acos(floatx80 a, float_status *status);
 floatx80 floatx80_atanh(floatx80 a, float_status *status);
+floatx80 floatx80_etoxm1(floatx80 a, float_status *status);
+floatx80 floatx80_tanh(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 2f7caa0ca0..0caae904b5 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5057,6 +5057,9 @@ DISAS_INSN(fpu)
     case 0x06: /* flognp1 */
         gen_helper_flognp1(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x09: /* ftanh */
+        gen_helper_ftanh(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x0a: /* fatan */
         gen_helper_fatan(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
