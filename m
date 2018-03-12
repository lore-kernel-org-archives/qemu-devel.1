Received: from eggs.gnu.org ([2001:4830:134:3::10]:44867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU3L-0005T3-W4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU3I-0005pN-M9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:15 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58591)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evU3I-0005jD-9g
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:12 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Mar 2018 21:27:20 +0100
Message-Id: <20180312202728.23790-4-laurent@vivier.eu>
In-Reply-To: <20180312202728.23790-1-laurent@vivier.eu>
References: <20180312202728.23790-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 03/11] target/m68k: implement fcos
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

Using a local m68k floatx80_cos()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c |   5 +
 target/m68k/helper.h     |   1 +
 target/m68k/softfloat.c  | 244 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h  |   1 +
 target/m68k/translate.c  |   3 +
 5 files changed, 254 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index a6cfb4db1a..71df19c685 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -602,3 +602,8 @@ void HELPER(fsin)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_sin(val->d, &env->fp_status);
 }
+
+void HELPER(fcos)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_cos(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 6d8bfaab64..767baf75a3 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -77,6 +77,7 @@ DEF_HELPER_3(ftwotox, void, env, fp, fp)
 DEF_HELPER_3(ftentox, void, env, fp, fp)
 DEF_HELPER_3(ftan, void, env, fp, fp)
 DEF_HELPER_3(fsin, void, env, fp, fp)
+DEF_HELPER_3(fcos, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 6fb9665336..a3a12a0bcb 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -1723,3 +1723,247 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
         }
     }
 }
+
+/*----------------------------------------------------------------------------
+ | Cosine
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_cos(floatx80 a, float_status *status)
+{
+    flag aSign, xSign;
+    int32_t aExp, xExp;
+    uint64_t aSig, xSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact, l, n, j;
+    floatx80 fp0, fp1, fp2, fp3, fp4, fp5, x, invtwopi, twopi1, twopi2;
+    float32 posneg1, twoto63;
+    flag adjn, endflag;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a, status);
+        }
+        float_raise(float_flag_invalid, status);
+        return floatx80_default_nan(status);
+    }
+
+    if (aExp == 0 && aSig == 0) {
+        return packFloatx80(0, one_exp, one_sig);
+    }
+
+    adjn = 1;
+
+    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_prec = status->floatx80_rounding_precision;
+    status->float_rounding_mode = float_round_nearest_even;
+    status->floatx80_rounding_precision = 80;
+
+    compact = floatx80_make_compact(aExp, aSig);
+
+    fp0 = a;
+
+    if (compact < 0x3FD78000 || compact > 0x4004BC7E) {
+        /* 2^(-40) > |X| > 15 PI */
+        if (compact > 0x3FFF8000) { /* |X| >= 15 PI */
+            /* REDUCEX */
+            fp1 = packFloatx80(0, 0, 0);
+            if (compact == 0x7FFEFFFF) {
+                twopi1 = packFloatx80(aSign ^ 1, 0x7FFE,
+                                      LIT64(0xC90FDAA200000000));
+                twopi2 = packFloatx80(aSign ^ 1, 0x7FDC,
+                                      LIT64(0x85A308D300000000));
+                fp0 = floatx80_add(fp0, twopi1, status);
+                fp1 = fp0;
+                fp0 = floatx80_add(fp0, twopi2, status);
+                fp1 = floatx80_sub(fp1, fp0, status);
+                fp1 = floatx80_add(fp1, twopi2, status);
+            }
+        loop:
+            xSign = extractFloatx80Sign(fp0);
+            xExp = extractFloatx80Exp(fp0);
+            xExp -= 0x3FFF;
+            if (xExp <= 28) {
+                l = 0;
+                endflag = 1;
+            } else {
+                l = xExp - 27;
+                endflag = 0;
+            }
+            invtwopi = packFloatx80(0, 0x3FFE - l,
+                                    LIT64(0xA2F9836E4E44152A)); /* INVTWOPI */
+            twopi1 = packFloatx80(0, 0x3FFF + l, LIT64(0xC90FDAA200000000));
+            twopi2 = packFloatx80(0, 0x3FDD + l, LIT64(0x85A308D300000000));
+
+            /* SIGN(INARG)*2^63 IN SGL */
+            twoto63 = packFloat32(xSign, 0xBE, 0);
+
+            fp2 = floatx80_mul(fp0, invtwopi, status);
+            fp2 = floatx80_add(fp2, float32_to_floatx80(twoto63, status),
+                               status); /* THE FRACT PART OF FP2 IS ROUNDED */
+            fp2 = floatx80_sub(fp2, float32_to_floatx80(twoto63, status),
+                               status); /* FP2 is N */
+            fp4 = floatx80_mul(twopi1, fp2, status); /* W = N*P1 */
+            fp5 = floatx80_mul(twopi2, fp2, status); /* w = N*P2 */
+            fp3 = floatx80_add(fp4, fp5, status); /* FP3 is P */
+            fp4 = floatx80_sub(fp4, fp3, status); /* W-P */
+            fp0 = floatx80_sub(fp0, fp3, status); /* FP0 is A := R - P */
+            fp4 = floatx80_add(fp4, fp5, status); /* FP4 is p = (W-P)+w */
+            fp3 = fp0; /* FP3 is A */
+            fp1 = floatx80_sub(fp1, fp4, status); /* FP1 is a := r - p */
+            fp0 = floatx80_add(fp0, fp1, status); /* FP0 is R := A+a */
+
+            if (endflag > 0) {
+                n = floatx80_to_int32(fp2, status);
+                goto sincont;
+            }
+            fp3 = floatx80_sub(fp3, fp0, status); /* A-R */
+            fp1 = floatx80_add(fp1, fp3, status); /* FP1 is r := (A-R)+a */
+            goto loop;
+        } else {
+            /* SINSM */
+            fp0 = float32_to_floatx80(make_float32(0x3F800000), status); /* 1 */
+
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            if (adjn) {
+                /* COSTINY */
+                a = floatx80_sub(fp0, float32_to_floatx80(
+                                 make_float32(0x00800000), status),
+                                 status);
+            } else {
+                /* SINTINY */
+                a = floatx80_move(a, status);
+            }
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        }
+    } else {
+        fp1 = floatx80_mul(fp0, float64_to_floatx80(
+                           make_float64(0x3FE45F306DC9C883), status),
+                           status); /* X*2/PI */
+
+        n = floatx80_to_int32(fp1, status);
+        j = 32 + n;
+
+        fp0 = floatx80_sub(fp0, pi_tbl[j], status); /* X-Y1 */
+        fp0 = floatx80_sub(fp0, float32_to_floatx80(pi_tbl2[j], status),
+                           status); /* FP0 IS R = (X-Y1)-Y2 */
+
+    sincont:
+        if ((n + adjn) & 1) {
+            /* COSPOLY */
+            fp0 = floatx80_mul(fp0, fp0, status); /* FP0 IS S */
+            fp1 = floatx80_mul(fp0, fp0, status); /* FP1 IS T */
+            fp2 = float64_to_floatx80(make_float64(0x3D2AC4D0D6011EE3),
+                                      status); /* B8 */
+            fp3 = float64_to_floatx80(make_float64(0xBDA9396F9F45AC19),
+                                      status); /* B7 */
+
+            xSign = extractFloatx80Sign(fp0); /* X IS S */
+            xExp = extractFloatx80Exp(fp0);
+            xSig = extractFloatx80Frac(fp0);
+
+            if (((n + adjn) >> 1) & 1) {
+                xSign ^= 1;
+                posneg1 = make_float32(0xBF800000); /* -1 */
+            } else {
+                xSign ^= 0;
+                posneg1 = make_float32(0x3F800000); /* 1 */
+            } /* X IS NOW R'= SGN*R */
+
+            fp2 = floatx80_mul(fp2, fp1, status); /* TB8 */
+            fp3 = floatx80_mul(fp3, fp1, status); /* TB7 */
+            fp2 = floatx80_add(fp2, float64_to_floatx80(
+                               make_float64(0x3E21EED90612C972), status),
+                               status); /* B6+TB8 */
+            fp3 = floatx80_add(fp3, float64_to_floatx80(
+                               make_float64(0xBE927E4FB79D9FCF), status),
+                               status); /* B5+TB7 */
+            fp2 = floatx80_mul(fp2, fp1, status); /* T(B6+TB8) */
+            fp3 = floatx80_mul(fp3, fp1, status); /* T(B5+TB7) */
+            fp2 = floatx80_add(fp2, float64_to_floatx80(
+                               make_float64(0x3EFA01A01A01D423), status),
+                               status); /* B4+T(B6+TB8) */
+            fp4 = packFloatx80(1, 0x3FF5, LIT64(0xB60B60B60B61D438));
+            fp3 = floatx80_add(fp3, fp4, status); /* B3+T(B5+TB7) */
+            fp2 = floatx80_mul(fp2, fp1, status); /* T(B4+T(B6+TB8)) */
+            fp1 = floatx80_mul(fp1, fp3, status); /* T(B3+T(B5+TB7)) */
+            fp4 = packFloatx80(0, 0x3FFA, LIT64(0xAAAAAAAAAAAAAB5E));
+            fp2 = floatx80_add(fp2, fp4, status); /* B2+T(B4+T(B6+TB8)) */
+            fp1 = floatx80_add(fp1, float32_to_floatx80(
+                               make_float32(0xBF000000), status),
+                               status); /* B1+T(B3+T(B5+TB7)) */
+            fp0 = floatx80_mul(fp0, fp2, status); /* S(B2+T(B4+T(B6+TB8))) */
+            fp0 = floatx80_add(fp0, fp1, status);
+                              /* [B1+T(B3+T(B5+TB7))]+[S(B2+T(B4+T(B6+TB8)))] */
+
+            x = packFloatx80(xSign, xExp, xSig);
+            fp0 = floatx80_mul(fp0, x, status);
+
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_add(fp0, float32_to_floatx80(posneg1, status), status);
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        } else {
+            /* SINPOLY */
+            xSign = extractFloatx80Sign(fp0); /* X IS R */
+            xExp = extractFloatx80Exp(fp0);
+            xSig = extractFloatx80Frac(fp0);
+
+            xSign ^= ((n + adjn) >> 1) & 1; /* X IS NOW R'= SGN*R */
+
+            fp0 = floatx80_mul(fp0, fp0, status); /* FP0 IS S */
+            fp1 = floatx80_mul(fp0, fp0, status); /* FP1 IS T */
+            fp3 = float64_to_floatx80(make_float64(0xBD6AAA77CCC994F5),
+                                      status); /* A7 */
+            fp2 = float64_to_floatx80(make_float64(0x3DE612097AAE8DA1),
+                                      status); /* A6 */
+            fp3 = floatx80_mul(fp3, fp1, status); /* T*A7 */
+            fp2 = floatx80_mul(fp2, fp1, status); /* T*A6 */
+            fp3 = floatx80_add(fp3, float64_to_floatx80(
+                               make_float64(0xBE5AE6452A118AE4), status),
+                               status); /* A5+T*A7 */
+            fp2 = floatx80_add(fp2, float64_to_floatx80(
+                               make_float64(0x3EC71DE3A5341531), status),
+                               status); /* A4+T*A6 */
+            fp3 = floatx80_mul(fp3, fp1, status); /* T(A5+TA7) */
+            fp2 = floatx80_mul(fp2, fp1, status); /* T(A4+TA6) */
+            fp3 = floatx80_add(fp3, float64_to_floatx80(
+                               make_float64(0xBF2A01A01A018B59), status),
+                               status); /* A3+T(A5+TA7) */
+            fp4 = packFloatx80(0, 0x3FF8, LIT64(0x88888888888859AF));
+            fp2 = floatx80_add(fp2, fp4, status); /* A2+T(A4+TA6) */
+            fp1 = floatx80_mul(fp1, fp3, status); /* T(A3+T(A5+TA7)) */
+            fp2 = floatx80_mul(fp2, fp0, status); /* S(A2+T(A4+TA6)) */
+            fp4 = packFloatx80(1, 0x3FFC, LIT64(0xAAAAAAAAAAAAAA99));
+            fp1 = floatx80_add(fp1, fp4, status); /* A1+T(A3+T(A5+TA7)) */
+            fp1 = floatx80_add(fp1, fp2, status);
+                                    /* [A1+T(A3+T(A5+TA7))]+[S(A2+T(A4+TA6))] */
+
+            x = packFloatx80(xSign, xExp, xSig);
+            fp0 = floatx80_mul(fp0, x, status); /* R'*S */
+            fp0 = floatx80_mul(fp0, fp1, status); /* SIN(R')-R' */
+
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_add(fp0, x, status);
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        }
+    }
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index e8ccf69ba8..4fd5b2c609 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -36,4 +36,5 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status);
 floatx80 floatx80_tentox(floatx80 a, float_status *status);
 floatx80 floatx80_tan(floatx80 a, float_status *status);
 floatx80 floatx80_sin(floatx80 a, float_status *status);
+floatx80 floatx80_cos(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 05ab75e43f..f47388da4b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5099,6 +5099,9 @@ DISAS_INSN(fpu)
     case 0x5e: /* fdneg */
         gen_helper_fdneg(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x1d: /* fcos */
+        gen_helper_fcos(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x1e: /* fgetexp */
         gen_helper_fgetexp(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
