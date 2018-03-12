Received: from eggs.gnu.org ([2001:4830:134:3::10]:45004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU3b-0005kb-Bv
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evU3Y-00071n-V4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evU3Y-0006yA-H8
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:28:28 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Mar 2018 21:27:22 +0100
Message-Id: <20180312202728.23790-6-laurent@vivier.eu>
In-Reply-To: <20180312202728.23790-1-laurent@vivier.eu>
References: <20180312202728.23790-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 05/11] target/m68k: implement fatan
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

Using a local m68k floatx80_atan()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c            |   5 +
 target/m68k/helper.h                |   1 +
 target/m68k/softfloat.c             | 200 ++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h             |   1 +
 target/m68k/softfloat_fpsp_tables.h | 131 +++++++++++++++++++++++
 target/m68k/translate.c             |   3 +
 6 files changed, 341 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 36e34d42a8..47328490ee 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -618,3 +618,8 @@ void HELPER(fsincos)(CPUM68KState *env, FPReg *res0, FPReg *res1, FPReg *val)
     res1->d = floatx80_cos(a, &env->fp_status);
     res0->d = floatx80_sin(a, &env->fp_status);
 }
+
+void HELPER(fatan)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_atan(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index a168ffbaea..304569e997 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -79,6 +79,7 @@ DEF_HELPER_3(ftan, void, env, fp, fp)
 DEF_HELPER_3(fsin, void, env, fp, fp)
 DEF_HELPER_3(fcos, void, env, fp, fp)
 DEF_HELPER_4(fsincos, void, env, fp, fp, fp)
+DEF_HELPER_3(fatan, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index a3a12a0bcb..00ac9a1e0a 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -23,6 +23,9 @@
 #include "fpu/softfloat-macros.h"
 #include "softfloat_fpsp_tables.h"
 
+#define piby2_exp   0x3FFF
+#define pi_sig      LIT64(0xc90fdaa22168c235)
+
 static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
 {
     if (floatx80_is_signaling_nan(a, status)) {
@@ -1967,3 +1970,200 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
         }
     }
 }
+
+/*----------------------------------------------------------------------------
+ | Arc tangent
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_atan(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact, tbl_index;
+    floatx80 fp0, fp1, fp2, fp3, xsave;
+
+    aSig = extractFloatx80Frac(a);
+    aExp = extractFloatx80Exp(a);
+    aSign = extractFloatx80Sign(a);
+
+    if (aExp == 0x7FFF) {
+        if ((uint64_t) (aSig << 1)) {
+            return propagateFloatx80NaNOneArg(a, status);
+        }
+        a = packFloatx80(aSign, piby2_exp, pi_sig);
+        float_raise(float_flag_inexact, status);
+        return floatx80_move(a, status);
+    }
+
+    if (aExp == 0 && aSig == 0) {
+        return packFloatx80(aSign, 0, 0);
+    }
+
+    compact = floatx80_make_compact(aExp, aSig);
+
+    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_prec = status->floatx80_rounding_precision;
+    status->float_rounding_mode = float_round_nearest_even;
+    status->floatx80_rounding_precision = 80;
+
+    if (compact < 0x3FFB8000 || compact > 0x4002FFFF) {
+        /* |X| >= 16 or |X| < 1/16 */
+        if (compact > 0x3FFF8000) { /* |X| >= 16 */
+            if (compact > 0x40638000) { /* |X| > 2^(100) */
+                fp0 = packFloatx80(aSign, piby2_exp, pi_sig);
+                fp1 = packFloatx80(aSign, 0x0001, one_sig);
+
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+
+                a = floatx80_sub(fp0, fp1, status);
+
+                float_raise(float_flag_inexact, status);
+
+                return a;
+            } else {
+                fp0 = a;
+                fp1 = packFloatx80(1, one_exp, one_sig); /* -1 */
+                fp1 = floatx80_div(fp1, fp0, status); /* X' = -1/X */
+                xsave = fp1;
+                fp0 = floatx80_mul(fp1, fp1, status); /* Y = X'*X' */
+                fp1 = floatx80_mul(fp0, fp0, status); /* Z = Y*Y */
+                fp3 = float64_to_floatx80(make_float64(0xBFB70BF398539E6A),
+                                          status); /* C5 */
+                fp2 = float64_to_floatx80(make_float64(0x3FBC7187962D1D7D),
+                                          status); /* C4 */
+                fp3 = floatx80_mul(fp3, fp1, status); /* Z*C5 */
+                fp2 = floatx80_mul(fp2, fp1, status); /* Z*C4 */
+                fp3 = floatx80_add(fp3, float64_to_floatx80(
+                                   make_float64(0xBFC24924827107B8), status),
+                                   status); /* C3+Z*C5 */
+                fp2 = floatx80_add(fp2, float64_to_floatx80(
+                                   make_float64(0x3FC999999996263E), status),
+                                   status); /* C2+Z*C4 */
+                fp1 = floatx80_mul(fp1, fp3, status); /* Z*(C3+Z*C5) */
+                fp2 = floatx80_mul(fp2, fp0, status); /* Y*(C2+Z*C4) */
+                fp1 = floatx80_add(fp1, float64_to_floatx80(
+                                   make_float64(0xBFD5555555555536), status),
+                                   status); /* C1+Z*(C3+Z*C5) */
+                fp0 = floatx80_mul(fp0, xsave, status); /* X'*Y */
+                /* [Y*(C2+Z*C4)]+[C1+Z*(C3+Z*C5)] */
+                fp1 = floatx80_add(fp1, fp2, status);
+                /* X'*Y*([B1+Z*(B3+Z*B5)]+[Y*(B2+Z*(B4+Z*B6))]) ?? */
+                fp0 = floatx80_mul(fp0, fp1, status);
+                fp0 = floatx80_add(fp0, xsave, status);
+                fp1 = packFloatx80(aSign, piby2_exp, pi_sig);
+
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+
+                a = floatx80_add(fp0, fp1, status);
+
+                float_raise(float_flag_inexact, status);
+
+                return a;
+            }
+        } else { /* |X| < 1/16 */
+            if (compact < 0x3FD78000) { /* |X| < 2^(-40) */
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+
+                a = floatx80_move(a, status);
+
+                float_raise(float_flag_inexact, status);
+
+                return a;
+            } else {
+                fp0 = a;
+                xsave = a;
+                fp0 = floatx80_mul(fp0, fp0, status); /* Y = X*X */
+                fp1 = floatx80_mul(fp0, fp0, status); /* Z = Y*Y */
+                fp2 = float64_to_floatx80(make_float64(0x3FB344447F876989),
+                                          status); /* B6 */
+                fp3 = float64_to_floatx80(make_float64(0xBFB744EE7FAF45DB),
+                                          status); /* B5 */
+                fp2 = floatx80_mul(fp2, fp1, status); /* Z*B6 */
+                fp3 = floatx80_mul(fp3, fp1, status); /* Z*B5 */
+                fp2 = floatx80_add(fp2, float64_to_floatx80(
+                                   make_float64(0x3FBC71C646940220), status),
+                                   status); /* B4+Z*B6 */
+                fp3 = floatx80_add(fp3, float64_to_floatx80(
+                                   make_float64(0xBFC24924921872F9),
+                                   status), status); /* B3+Z*B5 */
+                fp2 = floatx80_mul(fp2, fp1, status); /* Z*(B4+Z*B6) */
+                fp1 = floatx80_mul(fp1, fp3, status); /* Z*(B3+Z*B5) */
+                fp2 = floatx80_add(fp2, float64_to_floatx80(
+                                   make_float64(0x3FC9999999998FA9), status),
+                                   status); /* B2+Z*(B4+Z*B6) */
+                fp1 = floatx80_add(fp1, float64_to_floatx80(
+                                   make_float64(0xBFD5555555555555), status),
+                                   status); /* B1+Z*(B3+Z*B5) */
+                fp2 = floatx80_mul(fp2, fp0, status); /* Y*(B2+Z*(B4+Z*B6)) */
+                fp0 = floatx80_mul(fp0, xsave, status); /* X*Y */
+                /* [B1+Z*(B3+Z*B5)]+[Y*(B2+Z*(B4+Z*B6))] */
+                fp1 = floatx80_add(fp1, fp2, status);
+                /* X*Y*([B1+Z*(B3+Z*B5)]+[Y*(B2+Z*(B4+Z*B6))]) */
+                fp0 = floatx80_mul(fp0, fp1, status);
+
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+
+                a = floatx80_add(fp0, xsave, status);
+
+                float_raise(float_flag_inexact, status);
+
+                return a;
+            }
+        }
+    } else {
+        aSig &= LIT64(0xF800000000000000);
+        aSig |= LIT64(0x0400000000000000);
+        xsave = packFloatx80(aSign, aExp, aSig); /* F */
+        fp0 = a;
+        fp1 = a; /* X */
+        fp2 = packFloatx80(0, one_exp, one_sig); /* 1 */
+        fp1 = floatx80_mul(fp1, xsave, status); /* X*F */
+        fp0 = floatx80_sub(fp0, xsave, status); /* X-F */
+        fp1 = floatx80_add(fp1, fp2, status); /* 1 + X*F */
+        fp0 = floatx80_div(fp0, fp1, status); /* U = (X-F)/(1+X*F) */
+
+        tbl_index = compact;
+
+        tbl_index &= 0x7FFF0000;
+        tbl_index -= 0x3FFB0000;
+        tbl_index >>= 1;
+        tbl_index += compact & 0x00007800;
+        tbl_index >>= 11;
+
+        fp3 = atan_tbl[tbl_index];
+
+        fp3.high |= aSign ? 0x8000 : 0; /* ATAN(F) */
+
+        fp1 = floatx80_mul(fp0, fp0, status); /* V = U*U */
+        fp2 = float64_to_floatx80(make_float64(0xBFF6687E314987D8),
+                                  status); /* A3 */
+        fp2 = floatx80_add(fp2, fp1, status); /* A3+V */
+        fp2 = floatx80_mul(fp2, fp1, status); /* V*(A3+V) */
+        fp1 = floatx80_mul(fp1, fp0, status); /* U*V */
+        fp2 = floatx80_add(fp2, float64_to_floatx80(
+                           make_float64(0x4002AC6934A26DB3), status),
+                           status); /* A2+V*(A3+V) */
+        fp1 = floatx80_mul(fp1, float64_to_floatx80(
+                           make_float64(0xBFC2476F4E1DA28E), status),
+                           status); /* A1+U*V */
+        fp1 = floatx80_mul(fp1, fp2, status); /* A1*U*V*(A2+V*(A3+V)) */
+        fp0 = floatx80_add(fp0, fp1, status); /* ATAN(U) */
+
+        status->float_rounding_mode = user_rnd_mode;
+        status->floatx80_rounding_precision = user_rnd_prec;
+
+        a = floatx80_add(fp0, fp3, status); /* ATAN(X) */
+
+        float_raise(float_flag_inexact, status);
+
+        return a;
+    }
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 4fd5b2c609..eec45f3ffe 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -37,4 +37,5 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status);
 floatx80 floatx80_tan(floatx80 a, float_status *status);
 floatx80 floatx80_sin(floatx80 a, float_status *status);
 floatx80 floatx80_cos(floatx80 a, float_status *status);
+floatx80 floatx80_atan(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/softfloat_fpsp_tables.h b/target/m68k/softfloat_fpsp_tables.h
index a9c86a5af2..3f1419ee6e 100644
--- a/target/m68k/softfloat_fpsp_tables.h
+++ b/target/m68k/softfloat_fpsp_tables.h
@@ -507,4 +507,135 @@ static const float32 pi_tbl2[65] = {
     const_float32(0x20D00000),
     const_float32(0xA1800000),
 };
+
+static const floatx80 atan_tbl[128] = {
+    make_floatx80_init(0x3FFB, 0x83D152C5060B7A51),
+    make_floatx80_init(0x3FFB, 0x8BC8544565498B8B),
+    make_floatx80_init(0x3FFB, 0x93BE406017626B0D),
+    make_floatx80_init(0x3FFB, 0x9BB3078D35AEC202),
+    make_floatx80_init(0x3FFB, 0xA3A69A525DDCE7DE),
+    make_floatx80_init(0x3FFB, 0xAB98E94362765619),
+    make_floatx80_init(0x3FFB, 0xB389E502F9C59862),
+    make_floatx80_init(0x3FFB, 0xBB797E436B09E6FB),
+    make_floatx80_init(0x3FFB, 0xC367A5C739E5F446),
+    make_floatx80_init(0x3FFB, 0xCB544C61CFF7D5C6),
+    make_floatx80_init(0x3FFB, 0xD33F62F82488533E),
+    make_floatx80_init(0x3FFB, 0xDB28DA8162404C77),
+    make_floatx80_init(0x3FFB, 0xE310A4078AD34F18),
+    make_floatx80_init(0x3FFB, 0xEAF6B0A8188EE1EB),
+    make_floatx80_init(0x3FFB, 0xF2DAF1949DBE79D5),
+    make_floatx80_init(0x3FFB, 0xFABD581361D47E3E),
+    make_floatx80_init(0x3FFC, 0x8346AC210959ECC4),
+    make_floatx80_init(0x3FFC, 0x8B232A08304282D8),
+    make_floatx80_init(0x3FFC, 0x92FB70B8D29AE2F9),
+    make_floatx80_init(0x3FFC, 0x9ACF476F5CCD1CB4),
+    make_floatx80_init(0x3FFC, 0xA29E76304954F23F),
+    make_floatx80_init(0x3FFC, 0xAA68C5D08AB85230),
+    make_floatx80_init(0x3FFC, 0xB22DFFFD9D539F83),
+    make_floatx80_init(0x3FFC, 0xB9EDEF453E900EA5),
+    make_floatx80_init(0x3FFC, 0xC1A85F1CC75E3EA5),
+    make_floatx80_init(0x3FFC, 0xC95D1BE828138DE6),
+    make_floatx80_init(0x3FFC, 0xD10BF300840D2DE4),
+    make_floatx80_init(0x3FFC, 0xD8B4B2BA6BC05E7A),
+    make_floatx80_init(0x3FFC, 0xE0572A6BB42335F6),
+    make_floatx80_init(0x3FFC, 0xE7F32A70EA9CAA8F),
+    make_floatx80_init(0x3FFC, 0xEF88843264ECEFAA),
+    make_floatx80_init(0x3FFC, 0xF7170A28ECC06666),
+    make_floatx80_init(0x3FFD, 0x812FD288332DAD32),
+    make_floatx80_init(0x3FFD, 0x88A8D1B1218E4D64),
+    make_floatx80_init(0x3FFD, 0x9012AB3F23E4AEE8),
+    make_floatx80_init(0x3FFD, 0x976CC3D411E7F1B9),
+    make_floatx80_init(0x3FFD, 0x9EB689493889A227),
+    make_floatx80_init(0x3FFD, 0xA5EF72C34487361B),
+    make_floatx80_init(0x3FFD, 0xAD1700BAF07A7227),
+    make_floatx80_init(0x3FFD, 0xB42CBCFAFD37EFB7),
+    make_floatx80_init(0x3FFD, 0xBB303A940BA80F89),
+    make_floatx80_init(0x3FFD, 0xC22115C6FCAEBBAF),
+    make_floatx80_init(0x3FFD, 0xC8FEF3E686331221),
+    make_floatx80_init(0x3FFD, 0xCFC98330B4000C70),
+    make_floatx80_init(0x3FFD, 0xD6807AA1102C5BF9),
+    make_floatx80_init(0x3FFD, 0xDD2399BC31252AA3),
+    make_floatx80_init(0x3FFD, 0xE3B2A8556B8FC517),
+    make_floatx80_init(0x3FFD, 0xEA2D764F64315989),
+    make_floatx80_init(0x3FFD, 0xF3BF5BF8BAD1A21D),
+    make_floatx80_init(0x3FFE, 0x801CE39E0D205C9A),
+    make_floatx80_init(0x3FFE, 0x8630A2DADA1ED066),
+    make_floatx80_init(0x3FFE, 0x8C1AD445F3E09B8C),
+    make_floatx80_init(0x3FFE, 0x91DB8F1664F350E2),
+    make_floatx80_init(0x3FFE, 0x97731420365E538C),
+    make_floatx80_init(0x3FFE, 0x9CE1C8E6A0B8CDBA),
+    make_floatx80_init(0x3FFE, 0xA22832DBCADAAE09),
+    make_floatx80_init(0x3FFE, 0xA746F2DDB7602294),
+    make_floatx80_init(0x3FFE, 0xAC3EC0FB997DD6A2),
+    make_floatx80_init(0x3FFE, 0xB110688AEBDC6F6A),
+    make_floatx80_init(0x3FFE, 0xB5BCC49059ECC4B0),
+    make_floatx80_init(0x3FFE, 0xBA44BC7DD470782F),
+    make_floatx80_init(0x3FFE, 0xBEA94144FD049AAC),
+    make_floatx80_init(0x3FFE, 0xC2EB4ABB661628B6),
+    make_floatx80_init(0x3FFE, 0xC70BD54CE602EE14),
+    make_floatx80_init(0x3FFE, 0xCD000549ADEC7159),
+    make_floatx80_init(0x3FFE, 0xD48457D2D8EA4EA3),
+    make_floatx80_init(0x3FFE, 0xDB948DA712DECE3B),
+    make_floatx80_init(0x3FFE, 0xE23855F969E8096A),
+    make_floatx80_init(0x3FFE, 0xE8771129C4353259),
+    make_floatx80_init(0x3FFE, 0xEE57C16E0D379C0D),
+    make_floatx80_init(0x3FFE, 0xF3E10211A87C3779),
+    make_floatx80_init(0x3FFE, 0xF919039D758B8D41),
+    make_floatx80_init(0x3FFE, 0xFE058B8F64935FB3),
+    make_floatx80_init(0x3FFF, 0x8155FB497B685D04),
+    make_floatx80_init(0x3FFF, 0x83889E3549D108E1),
+    make_floatx80_init(0x3FFF, 0x859CFA76511D724B),
+    make_floatx80_init(0x3FFF, 0x87952ECFFF8131E7),
+    make_floatx80_init(0x3FFF, 0x89732FD19557641B),
+    make_floatx80_init(0x3FFF, 0x8B38CAD101932A35),
+    make_floatx80_init(0x3FFF, 0x8CE7A8D8301EE6B5),
+    make_floatx80_init(0x3FFF, 0x8F46A39E2EAE5281),
+    make_floatx80_init(0x3FFF, 0x922DA7D791888487),
+    make_floatx80_init(0x3FFF, 0x94D19FCBDEDF5241),
+    make_floatx80_init(0x3FFF, 0x973AB94419D2A08B),
+    make_floatx80_init(0x3FFF, 0x996FF00E08E10B96),
+    make_floatx80_init(0x3FFF, 0x9B773F9512321DA7),
+    make_floatx80_init(0x3FFF, 0x9D55CC320F935624),
+    make_floatx80_init(0x3FFF, 0x9F100575006CC571),
+    make_floatx80_init(0x3FFF, 0xA0A9C290D97CC06C),
+    make_floatx80_init(0x3FFF, 0xA22659EBEBC0630A),
+    make_floatx80_init(0x3FFF, 0xA388B4AFF6EF0EC9),
+    make_floatx80_init(0x3FFF, 0xA4D35F1061D292C4),
+    make_floatx80_init(0x3FFF, 0xA60895DCFBE3187E),
+    make_floatx80_init(0x3FFF, 0xA72A51DC7367BEAC),
+    make_floatx80_init(0x3FFF, 0xA83A51530956168F),
+    make_floatx80_init(0x3FFF, 0xA93A20077539546E),
+    make_floatx80_init(0x3FFF, 0xAA9E7245023B2605),
+    make_floatx80_init(0x3FFF, 0xAC4C84BA6FE4D58F),
+    make_floatx80_init(0x3FFF, 0xADCE4A4A606B9712),
+    make_floatx80_init(0x3FFF, 0xAF2A2DCD8D263C9C),
+    make_floatx80_init(0x3FFF, 0xB0656F81F22265C7),
+    make_floatx80_init(0x3FFF, 0xB18465150F71496A),
+    make_floatx80_init(0x3FFF, 0xB28AAA156F9ADA35),
+    make_floatx80_init(0x3FFF, 0xB37B44FF3766B895),
+    make_floatx80_init(0x3FFF, 0xB458C3DCE9630433),
+    make_floatx80_init(0x3FFF, 0xB525529D562246BD),
+    make_floatx80_init(0x3FFF, 0xB5E2CCA95F9D88CC),
+    make_floatx80_init(0x3FFF, 0xB692CADA7ACA1ADA),
+    make_floatx80_init(0x3FFF, 0xB736AEA7A6925838),
+    make_floatx80_init(0x3FFF, 0xB7CFAB287E9F7B36),
+    make_floatx80_init(0x3FFF, 0xB85ECC66CB219835),
+    make_floatx80_init(0x3FFF, 0xB8E4FD5A20A593DA),
+    make_floatx80_init(0x3FFF, 0xB99F41F64AFF9BB5),
+    make_floatx80_init(0x3FFF, 0xBA7F1E17842BBE7B),
+    make_floatx80_init(0x3FFF, 0xBB4712857637E17D),
+    make_floatx80_init(0x3FFF, 0xBBFABE8A4788DF6F),
+    make_floatx80_init(0x3FFF, 0xBC9D0FAD2B689D79),
+    make_floatx80_init(0x3FFF, 0xBD306A39471ECD86),
+    make_floatx80_init(0x3FFF, 0xBDB6C731856AF18A),
+    make_floatx80_init(0x3FFF, 0xBE31CAC502E80D70),
+    make_floatx80_init(0x3FFF, 0xBEA2D55CE33194E2),
+    make_floatx80_init(0x3FFF, 0xBF0B10B7C03128F0),
+    make_floatx80_init(0x3FFF, 0xBF6B7A18DACB778D),
+    make_floatx80_init(0x3FFF, 0xBFC4EA4663FA18F6),
+    make_floatx80_init(0x3FFF, 0xC0181BDE8B89A454),
+    make_floatx80_init(0x3FFF, 0xC065B066CFBF6439),
+    make_floatx80_init(0x3FFF, 0xC0AE345F56340AE6),
+    make_floatx80_init(0x3FFF, 0xC0F222919CB9E6A7)
+};
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index a78edd8825..88015e7ed8 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5057,6 +5057,9 @@ DISAS_INSN(fpu)
     case 0x06: /* flognp1 */
         gen_helper_flognp1(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x0a: /* fatan */
+        gen_helper_fatan(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x0e: /* fsin */
         gen_helper_fsin(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
