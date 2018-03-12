Received: from eggs.gnu.org ([2001:4830:134:3::10]:44817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU3G-0005MY-0q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU3C-0005MX-Me
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:10 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evU3C-0005Gu-8L
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:06 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Mar 2018 21:27:18 +0100
Message-Id: <20180312202728.23790-2-laurent@vivier.eu>
In-Reply-To: <20180312202728.23790-1-laurent@vivier.eu>
References: <20180312202728.23790-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 01/11] target/m68k: implement ftan
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

Using a local m68k floatx80_tan()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c            |   5 +
 target/m68k/helper.h                |   1 +
 target/m68k/softfloat.c             | 210 ++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h             |   1 +
 target/m68k/softfloat_fpsp_tables.h | 136 +++++++++++++++++++++++
 target/m68k/translate.c             |   3 +
 6 files changed, 356 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 62cbb0dff1..c41115ea05 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -592,3 +592,8 @@ void HELPER(ftentox)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_tentox(val->d, &env->fp_status);
 }
+
+void HELPER(ftan)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_tan(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 9a9734c196..af9480fe49 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -75,6 +75,7 @@ DEF_HELPER_3(flog2, void, env, fp, fp)
 DEF_HELPER_3(fetox, void, env, fp, fp)
 DEF_HELPER_3(ftwotox, void, env, fp, fp)
 DEF_HELPER_3(ftentox, void, env, fp, fp)
+DEF_HELPER_3(ftan, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 4bd5b9e6b7..488dbc522b 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -1266,3 +1266,213 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
         return a;
     }
 }
+
+/*----------------------------------------------------------------------------
+ | Tangent
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_tan(floatx80 a, float_status *status)
+{
+    flag aSign, xSign;
+    int32_t aExp, xExp;
+    uint64_t aSig, xSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact, l, n, j;
+    floatx80 fp0, fp1, fp2, fp3, fp4, fp5, invtwopi, twopi1, twopi2;
+    float32 twoto63;
+    flag endflag;
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
+                goto tancont;
+            }
+            fp3 = floatx80_sub(fp3, fp0, status); /* A-R */
+            fp1 = floatx80_add(fp1, fp3, status); /* FP1 is r := (A-R)+a */
+            goto loop;
+        } else {
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_move(a, status);
+
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
+    tancont:
+        if (n & 1) {
+            /* NODD */
+            fp1 = fp0; /* R */
+            fp0 = floatx80_mul(fp0, fp0, status); /* S = R*R */
+            fp3 = float64_to_floatx80(make_float64(0x3EA0B759F50F8688),
+                                      status); /* Q4 */
+            fp2 = float64_to_floatx80(make_float64(0xBEF2BAA5A8924F04),
+                                      status); /* P3 */
+            fp3 = floatx80_mul(fp3, fp0, status); /* SQ4 */
+            fp2 = floatx80_mul(fp2, fp0, status); /* SP3 */
+            fp3 = floatx80_add(fp3, float64_to_floatx80(
+                               make_float64(0xBF346F59B39BA65F), status),
+                               status); /* Q3+SQ4 */
+            fp4 = packFloatx80(0, 0x3FF6, LIT64(0xE073D3FC199C4A00));
+            fp2 = floatx80_add(fp2, fp4, status); /* P2+SP3 */
+            fp3 = floatx80_mul(fp3, fp0, status); /* S(Q3+SQ4) */
+            fp2 = floatx80_mul(fp2, fp0, status); /* S(P2+SP3) */
+            fp4 = packFloatx80(0, 0x3FF9, LIT64(0xD23CD68415D95FA1));
+            fp3 = floatx80_add(fp3, fp4, status); /* Q2+S(Q3+SQ4) */
+            fp4 = packFloatx80(1, 0x3FFC, LIT64(0x8895A6C5FB423BCA));
+            fp2 = floatx80_add(fp2, fp4, status); /* P1+S(P2+SP3) */
+            fp3 = floatx80_mul(fp3, fp0, status); /* S(Q2+S(Q3+SQ4)) */
+            fp2 = floatx80_mul(fp2, fp0, status); /* S(P1+S(P2+SP3)) */
+            fp4 = packFloatx80(1, 0x3FFD, LIT64(0xEEF57E0DA84BC8CE));
+            fp3 = floatx80_add(fp3, fp4, status); /* Q1+S(Q2+S(Q3+SQ4)) */
+            fp2 = floatx80_mul(fp2, fp1, status); /* RS(P1+S(P2+SP3)) */
+            fp0 = floatx80_mul(fp0, fp3, status); /* S(Q1+S(Q2+S(Q3+SQ4))) */
+            fp1 = floatx80_add(fp1, fp2, status); /* R+RS(P1+S(P2+SP3)) */
+            fp0 = floatx80_add(fp0, float32_to_floatx80(
+                               make_float32(0x3F800000), status),
+                               status); /* 1+S(Q1+S(Q2+S(Q3+SQ4))) */
+
+            xSign = extractFloatx80Sign(fp1);
+            xExp = extractFloatx80Exp(fp1);
+            xSig = extractFloatx80Frac(fp1);
+            xSign ^= 1;
+            fp1 = packFloatx80(xSign, xExp, xSig);
+
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_div(fp0, fp1, status);
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        } else {
+            fp1 = floatx80_mul(fp0, fp0, status); /* S = R*R */
+            fp3 = float64_to_floatx80(make_float64(0x3EA0B759F50F8688),
+                                      status); /* Q4 */
+            fp2 = float64_to_floatx80(make_float64(0xBEF2BAA5A8924F04),
+                                      status); /* P3 */
+            fp3 = floatx80_mul(fp3, fp1, status); /* SQ4 */
+            fp2 = floatx80_mul(fp2, fp1, status); /* SP3 */
+            fp3 = floatx80_add(fp3, float64_to_floatx80(
+                               make_float64(0xBF346F59B39BA65F), status),
+                               status); /* Q3+SQ4 */
+            fp4 = packFloatx80(0, 0x3FF6, LIT64(0xE073D3FC199C4A00));
+            fp2 = floatx80_add(fp2, fp4, status); /* P2+SP3 */
+            fp3 = floatx80_mul(fp3, fp1, status); /* S(Q3+SQ4) */
+            fp2 = floatx80_mul(fp2, fp1, status); /* S(P2+SP3) */
+            fp4 = packFloatx80(0, 0x3FF9, LIT64(0xD23CD68415D95FA1));
+            fp3 = floatx80_add(fp3, fp4, status); /* Q2+S(Q3+SQ4) */
+            fp4 = packFloatx80(1, 0x3FFC, LIT64(0x8895A6C5FB423BCA));
+            fp2 = floatx80_add(fp2, fp4, status); /* P1+S(P2+SP3) */
+            fp3 = floatx80_mul(fp3, fp1, status); /* S(Q2+S(Q3+SQ4)) */
+            fp2 = floatx80_mul(fp2, fp1, status); /* S(P1+S(P2+SP3)) */
+            fp4 = packFloatx80(1, 0x3FFD, LIT64(0xEEF57E0DA84BC8CE));
+            fp3 = floatx80_add(fp3, fp4, status); /* Q1+S(Q2+S(Q3+SQ4)) */
+            fp2 = floatx80_mul(fp2, fp0, status); /* RS(P1+S(P2+SP3)) */
+            fp1 = floatx80_mul(fp1, fp3, status); /* S(Q1+S(Q2+S(Q3+SQ4))) */
+            fp0 = floatx80_add(fp0, fp2, status); /* R+RS(P1+S(P2+SP3)) */
+            fp1 = floatx80_add(fp1, float32_to_floatx80(
+                               make_float32(0x3F800000), status),
+                               status); /* 1+S(Q1+S(Q2+S(Q3+SQ4))) */
+
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_div(fp0, fp1, status);
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        }
+    }
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index d28e49fe9f..c5ac54d87b 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -34,4 +34,5 @@ floatx80 floatx80_log2(floatx80 a, float_status *status);
 floatx80 floatx80_etox(floatx80 a, float_status *status);
 floatx80 floatx80_twotox(floatx80 a, float_status *status);
 floatx80 floatx80_tentox(floatx80 a, float_status *status);
+floatx80 floatx80_tan(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/softfloat_fpsp_tables.h b/target/m68k/softfloat_fpsp_tables.h
index dd76dc0373..a9c86a5af2 100644
--- a/target/m68k/softfloat_fpsp_tables.h
+++ b/target/m68k/softfloat_fpsp_tables.h
@@ -371,4 +371,140 @@ static const uint32_t exp2_tbl2[64] = {
     0xBFBDBF4A, 0x3FBEC01A, 0x3FBE8CAC, 0xBFBCBB3F,
     0x3FBEF73A, 0xBFB8B795, 0x3FBEF84B, 0xBFBEF581
 };
+
+static const floatx80 pi_tbl[65] = {
+    make_floatx80_init(0xC004, 0xC90FDAA22168C235),
+    make_floatx80_init(0xC004, 0xC2C75BCD105D7C23),
+    make_floatx80_init(0xC004, 0xBC7EDCF7FF523611),
+    make_floatx80_init(0xC004, 0xB6365E22EE46F000),
+    make_floatx80_init(0xC004, 0xAFEDDF4DDD3BA9EE),
+    make_floatx80_init(0xC004, 0xA9A56078CC3063DD),
+    make_floatx80_init(0xC004, 0xA35CE1A3BB251DCB),
+    make_floatx80_init(0xC004, 0x9D1462CEAA19D7B9),
+    make_floatx80_init(0xC004, 0x96CBE3F9990E91A8),
+    make_floatx80_init(0xC004, 0x9083652488034B96),
+    make_floatx80_init(0xC004, 0x8A3AE64F76F80584),
+    make_floatx80_init(0xC004, 0x83F2677A65ECBF73),
+    make_floatx80_init(0xC003, 0xFB53D14AA9C2F2C2),
+    make_floatx80_init(0xC003, 0xEEC2D3A087AC669F),
+    make_floatx80_init(0xC003, 0xE231D5F66595DA7B),
+    make_floatx80_init(0xC003, 0xD5A0D84C437F4E58),
+    make_floatx80_init(0xC003, 0xC90FDAA22168C235),
+    make_floatx80_init(0xC003, 0xBC7EDCF7FF523611),
+    make_floatx80_init(0xC003, 0xAFEDDF4DDD3BA9EE),
+    make_floatx80_init(0xC003, 0xA35CE1A3BB251DCB),
+    make_floatx80_init(0xC003, 0x96CBE3F9990E91A8),
+    make_floatx80_init(0xC003, 0x8A3AE64F76F80584),
+    make_floatx80_init(0xC002, 0xFB53D14AA9C2F2C2),
+    make_floatx80_init(0xC002, 0xE231D5F66595DA7B),
+    make_floatx80_init(0xC002, 0xC90FDAA22168C235),
+    make_floatx80_init(0xC002, 0xAFEDDF4DDD3BA9EE),
+    make_floatx80_init(0xC002, 0x96CBE3F9990E91A8),
+    make_floatx80_init(0xC001, 0xFB53D14AA9C2F2C2),
+    make_floatx80_init(0xC001, 0xC90FDAA22168C235),
+    make_floatx80_init(0xC001, 0x96CBE3F9990E91A8),
+    make_floatx80_init(0xC000, 0xC90FDAA22168C235),
+    make_floatx80_init(0xBFFF, 0xC90FDAA22168C235),
+    make_floatx80_init(0x0000, 0x0000000000000000),
+    make_floatx80_init(0x3FFF, 0xC90FDAA22168C235),
+    make_floatx80_init(0x4000, 0xC90FDAA22168C235),
+    make_floatx80_init(0x4001, 0x96CBE3F9990E91A8),
+    make_floatx80_init(0x4001, 0xC90FDAA22168C235),
+    make_floatx80_init(0x4001, 0xFB53D14AA9C2F2C2),
+    make_floatx80_init(0x4002, 0x96CBE3F9990E91A8),
+    make_floatx80_init(0x4002, 0xAFEDDF4DDD3BA9EE),
+    make_floatx80_init(0x4002, 0xC90FDAA22168C235),
+    make_floatx80_init(0x4002, 0xE231D5F66595DA7B),
+    make_floatx80_init(0x4002, 0xFB53D14AA9C2F2C2),
+    make_floatx80_init(0x4003, 0x8A3AE64F76F80584),
+    make_floatx80_init(0x4003, 0x96CBE3F9990E91A8),
+    make_floatx80_init(0x4003, 0xA35CE1A3BB251DCB),
+    make_floatx80_init(0x4003, 0xAFEDDF4DDD3BA9EE),
+    make_floatx80_init(0x4003, 0xBC7EDCF7FF523611),
+    make_floatx80_init(0x4003, 0xC90FDAA22168C235),
+    make_floatx80_init(0x4003, 0xD5A0D84C437F4E58),
+    make_floatx80_init(0x4003, 0xE231D5F66595DA7B),
+    make_floatx80_init(0x4003, 0xEEC2D3A087AC669F),
+    make_floatx80_init(0x4003, 0xFB53D14AA9C2F2C2),
+    make_floatx80_init(0x4004, 0x83F2677A65ECBF73),
+    make_floatx80_init(0x4004, 0x8A3AE64F76F80584),
+    make_floatx80_init(0x4004, 0x9083652488034B96),
+    make_floatx80_init(0x4004, 0x96CBE3F9990E91A8),
+    make_floatx80_init(0x4004, 0x9D1462CEAA19D7B9),
+    make_floatx80_init(0x4004, 0xA35CE1A3BB251DCB),
+    make_floatx80_init(0x4004, 0xA9A56078CC3063DD),
+    make_floatx80_init(0x4004, 0xAFEDDF4DDD3BA9EE),
+    make_floatx80_init(0x4004, 0xB6365E22EE46F000),
+    make_floatx80_init(0x4004, 0xBC7EDCF7FF523611),
+    make_floatx80_init(0x4004, 0xC2C75BCD105D7C23),
+    make_floatx80_init(0x4004, 0xC90FDAA22168C235)
+};
+
+static const float32 pi_tbl2[65] = {
+    const_float32(0x21800000),
+    const_float32(0xA0D00000),
+    const_float32(0xA1E80000),
+    const_float32(0x21480000),
+    const_float32(0xA1200000),
+    const_float32(0x21FC0000),
+    const_float32(0x21100000),
+    const_float32(0xA1580000),
+    const_float32(0x21E00000),
+    const_float32(0x20B00000),
+    const_float32(0xA1880000),
+    const_float32(0x21C40000),
+    const_float32(0x20000000),
+    const_float32(0x21380000),
+    const_float32(0xA1300000),
+    const_float32(0x9FC00000),
+    const_float32(0x21000000),
+    const_float32(0xA1680000),
+    const_float32(0xA0A00000),
+    const_float32(0x20900000),
+    const_float32(0x21600000),
+    const_float32(0xA1080000),
+    const_float32(0x1F800000),
+    const_float32(0xA0B00000),
+    const_float32(0x20800000),
+    const_float32(0xA0200000),
+    const_float32(0x20E00000),
+    const_float32(0x1F000000),
+    const_float32(0x20000000),
+    const_float32(0x20600000),
+    const_float32(0x1F800000),
+    const_float32(0x1F000000),
+    const_float32(0x00000000),
+    const_float32(0x9F000000),
+    const_float32(0x9F800000),
+    const_float32(0xA0600000),
+    const_float32(0xA0000000),
+    const_float32(0x9F000000),
+    const_float32(0xA0E00000),
+    const_float32(0x20200000),
+    const_float32(0xA0800000),
+    const_float32(0x20B00000),
+    const_float32(0x9F800000),
+    const_float32(0x21080000),
+    const_float32(0xA1600000),
+    const_float32(0xA0900000),
+    const_float32(0x20A00000),
+    const_float32(0x21680000),
+    const_float32(0xA1000000),
+    const_float32(0x1FC00000),
+    const_float32(0x21300000),
+    const_float32(0xA1380000),
+    const_float32(0xA0000000),
+    const_float32(0xA1C40000),
+    const_float32(0x21880000),
+    const_float32(0xA0B00000),
+    const_float32(0xA1E00000),
+    const_float32(0x21580000),
+    const_float32(0xA1100000),
+    const_float32(0xA1FC0000),
+    const_float32(0x21200000),
+    const_float32(0xA1480000),
+    const_float32(0x21E80000),
+    const_float32(0x20D00000),
+    const_float32(0xA1800000),
+};
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6d5bde0777..af8cdc2580 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5057,6 +5057,9 @@ DISAS_INSN(fpu)
     case 0x06: /* flognp1 */
         gen_helper_flognp1(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x0f: /* ftan */
+        gen_helper_ftan(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x10: /* fetox */
         gen_helper_fetox(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
