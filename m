Received: from eggs.gnu.org ([2001:4830:134:3::10]:58932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euIyq-0000w4-PD
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euIym-0007Bs-Mf
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:44 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:36887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euIyl-0007Ai-VU
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:40 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  9 Mar 2018 15:26:24 +0100
Message-Id: <20180309142630.2170-3-laurent@vivier.eu>
In-Reply-To: <20180309142630.2170-1-laurent@vivier.eu>
References: <20180309142630.2170-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 2/8] target/m68k: implement flognp1
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

Using a local m68k floatx80_lognp1()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180305203910.10391-3-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c            |   5 +
 target/m68k/helper.h                |   1 +
 target/m68k/softfloat.c             | 216 ++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h             |   1 +
 target/m68k/softfloat_fpsp_tables.h | 154 +++++++++++++++++++++++++
 target/m68k/translate.c             |   3 +
 6 files changed, 380 insertions(+)
 create mode 100755 target/m68k/softfloat_fpsp_tables.h

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index cdb9b50462..614064612e 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -557,3 +557,8 @@ void HELPER(fscale)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 {
     res->d = floatx80_scale(val1->d, val0->d, &env->fp_status);
 }
+
+void HELPER(flognp1)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_lognp1(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index c348dced3a..f7e6fc8c40 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -68,6 +68,7 @@ DEF_HELPER_4(frem, void, env, fp, fp, fp)
 DEF_HELPER_3(fgetexp, void, env, fp, fp)
 DEF_HELPER_3(fgetman, void, env, fp, fp)
 DEF_HELPER_4(fscale, void, env, fp, fp, fp)
+DEF_HELPER_3(flognp1, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 55eb7a260a..834db12964 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "softfloat.h"
 #include "fpu/softfloat-macros.h"
+#include "softfloat_fpsp_tables.h"
 
 static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
 {
@@ -274,3 +275,218 @@ floatx80 floatx80_move(floatx80 a, float_status *status)
     return roundAndPackFloatx80(status->floatx80_rounding_precision, aSign,
                                 aExp, aSig, 0, status);
 }
+
+/*----------------------------------------------------------------------------
+| Algorithms for transcendental functions supported by MC68881 and MC68882
+| mathematical coprocessors. The functions are derived from FPSP library.
+*----------------------------------------------------------------------------*/
+
+#define one_exp     0x3FFF
+#define one_sig     LIT64(0x8000000000000000)
+
+/*----------------------------------------------------------------------------
+ | Function for compactifying extended double-precision floating point values.
+ *----------------------------------------------------------------------------*/
+
+static int32_t floatx80_make_compact(int32_t aExp, uint64_t aSig)
+{
+    return (aExp << 16) | (aSig >> 48);
+}
+
+/*----------------------------------------------------------------------------
+ | Log base e of x plus 1
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_lognp1(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig, fSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact, j, k;
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
+        if (aSign) {
+            float_raise(float_flag_invalid, status);
+            return floatx80_default_nan(status);
+        }
+        return packFloatx80(0, floatx80_infinity.high, floatx80_infinity.low);
+    }
+
+    if (aExp == 0 && aSig == 0) {
+        return packFloatx80(aSign, 0, 0);
+    }
+
+    if (aSign && aExp >= one_exp) {
+        if (aExp == one_exp && aSig == one_sig) {
+            float_raise(float_flag_divbyzero, status);
+            packFloatx80(aSign, floatx80_infinity.high, floatx80_infinity.low);
+        }
+        float_raise(float_flag_invalid, status);
+        return floatx80_default_nan(status);
+    }
+
+    if (aExp < 0x3f99 || (aExp == 0x3f99 && aSig == one_sig)) {
+        /* <= min threshold */
+        float_raise(float_flag_inexact, status);
+        return floatx80_move(a, status);
+    }
+
+    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_prec = status->floatx80_rounding_precision;
+    status->float_rounding_mode = float_round_nearest_even;
+    status->floatx80_rounding_precision = 80;
+
+    compact = floatx80_make_compact(aExp, aSig);
+
+    fp0 = a; /* Z */
+    fp1 = a;
+
+    fp0 = floatx80_add(fp0, float32_to_floatx80(make_float32(0x3F800000),
+                       status), status); /* X = (1+Z) */
+
+    aExp = extractFloatx80Exp(fp0);
+    aSig = extractFloatx80Frac(fp0);
+
+    compact = floatx80_make_compact(aExp, aSig);
+
+    if (compact < 0x3FFE8000 || compact > 0x3FFFC000) {
+        /* |X| < 1/2 or |X| > 3/2 */
+        k = aExp - 0x3FFF;
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
+    lp1cont1:
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
+    } else if (compact < 0x3FFEF07D || compact > 0x3FFF8841) {
+        /* |X| < 1/16 or |X| > -1/16 */
+        /* LP1CARE */
+        fSig = (aSig & LIT64(0xFE00000000000000)) | LIT64(0x0100000000000000);
+        f = packFloatx80(0, 0x3FFF, fSig); /* F */
+        j = (fSig >> 56) & 0x7E; /* DISPLACEMENT FOR 1/F */
+
+        if (compact >= 0x3FFF8000) { /* 1+Z >= 1 */
+            /* KISZERO */
+            fp0 = floatx80_sub(float32_to_floatx80(make_float32(0x3F800000),
+                               status), f, status); /* 1-F */
+            fp0 = floatx80_add(fp0, fp1, status); /* FP0 IS Y-F = (1-F)+Z */
+            fp1 = packFloatx80(0, 0, 0); /* K = 0 */
+        } else {
+            /* KISNEG */
+            fp0 = floatx80_sub(float32_to_floatx80(make_float32(0x40000000),
+                               status), f, status); /* 2-F */
+            fp1 = floatx80_add(fp1, fp1, status); /* 2Z */
+            fp0 = floatx80_add(fp0, fp1, status); /* FP0 IS Y-F = (2-F)+2Z */
+            fp1 = packFloatx80(1, one_exp, one_sig); /* K = -1 */
+        }
+        goto lp1cont1;
+    } else {
+        /* LP1ONE16 */
+        fp1 = floatx80_add(fp1, fp1, status); /* FP1 IS 2Z */
+        fp0 = floatx80_add(fp0, float32_to_floatx80(make_float32(0x3F800000),
+                           status), status); /* FP0 IS 1+X */
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
+        fp1 = floatx80_add(fp1, fp2,
+                           status); /* B1+W*(B3+W*B5) + V*(B2+W*B4) */
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
index 18561b870d..4d74eaf862 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -27,4 +27,5 @@ floatx80 floatx80_getman(floatx80 a, float_status *status);
 floatx80 floatx80_getexp(floatx80 a, float_status *status);
 floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status);
 floatx80 floatx80_move(floatx80 a, float_status *status);
+floatx80 floatx80_lognp1(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/softfloat_fpsp_tables.h b/target/m68k/softfloat_fpsp_tables.h
new file mode 100755
index 0000000000..a87179e11e
--- /dev/null
+++ b/target/m68k/softfloat_fpsp_tables.h
@@ -0,0 +1,154 @@
+/*
+ * Ported from a work by Andreas Grabher for Previous, NeXT Computer Emulator,
+ * derived from NetBSD M68040 FPSP functions,
+ * derived from release 2a of the SoftFloat IEC/IEEE Floating-point Arithmetic
+ * Package. Those parts of the code (and some later contributions) are
+ * provided under that license, as detailed below.
+ * It has subsequently been modified by contributors to the QEMU Project,
+ * so some portions are provided under:
+ *  the SoftFloat-2a license
+ *  the BSD license
+ *  GPL-v2-or-later
+ *
+ * Any future contributions to this file will be taken to be licensed under
+ * the Softfloat-2a license unless specifically indicated otherwise.
+ */
+
+/* Portions of this work are licensed under the terms of the GNU GPL,
+ * version 2 or later. See the COPYING file in the top-level directory.
+ */
+
+#ifndef TARGET_M68K_SOFTFLOAT_FPSP_TABLES_H
+#define TARGET_M68K_SOFTFLOAT_FPSP_TABLES_H
+
+static const floatx80 log_tbl[128] = {
+    make_floatx80_init(0x3FFE, 0xFE03F80FE03F80FE),
+    make_floatx80_init(0x3FF7, 0xFF015358833C47E2),
+    make_floatx80_init(0x3FFE, 0xFA232CF252138AC0),
+    make_floatx80_init(0x3FF9, 0xBDC8D83EAD88D549),
+    make_floatx80_init(0x3FFE, 0xF6603D980F6603DA),
+    make_floatx80_init(0x3FFA, 0x9CF43DCFF5EAFD48),
+    make_floatx80_init(0x3FFE, 0xF2B9D6480F2B9D65),
+    make_floatx80_init(0x3FFA, 0xDA16EB88CB8DF614),
+    make_floatx80_init(0x3FFE, 0xEF2EB71FC4345238),
+    make_floatx80_init(0x3FFB, 0x8B29B7751BD70743),
+    make_floatx80_init(0x3FFE, 0xEBBDB2A5C1619C8C),
+    make_floatx80_init(0x3FFB, 0xA8D839F830C1FB49),
+    make_floatx80_init(0x3FFE, 0xE865AC7B7603A197),
+    make_floatx80_init(0x3FFB, 0xC61A2EB18CD907AD),
+    make_floatx80_init(0x3FFE, 0xE525982AF70C880E),
+    make_floatx80_init(0x3FFB, 0xE2F2A47ADE3A18AF),
+    make_floatx80_init(0x3FFE, 0xE1FC780E1FC780E2),
+    make_floatx80_init(0x3FFB, 0xFF64898EDF55D551),
+    make_floatx80_init(0x3FFE, 0xDEE95C4CA037BA57),
+    make_floatx80_init(0x3FFC, 0x8DB956A97B3D0148),
+    make_floatx80_init(0x3FFE, 0xDBEB61EED19C5958),
+    make_floatx80_init(0x3FFC, 0x9B8FE100F47BA1DE),
+    make_floatx80_init(0x3FFE, 0xD901B2036406C80E),
+    make_floatx80_init(0x3FFC, 0xA9372F1D0DA1BD17),
+    make_floatx80_init(0x3FFE, 0xD62B80D62B80D62C),
+    make_floatx80_init(0x3FFC, 0xB6B07F38CE90E46B),
+    make_floatx80_init(0x3FFE, 0xD3680D3680D3680D),
+    make_floatx80_init(0x3FFC, 0xC3FD032906488481),
+    make_floatx80_init(0x3FFE, 0xD0B69FCBD2580D0B),
+    make_floatx80_init(0x3FFC, 0xD11DE0FF15AB18CA),
+    make_floatx80_init(0x3FFE, 0xCE168A7725080CE1),
+    make_floatx80_init(0x3FFC, 0xDE1433A16C66B150),
+    make_floatx80_init(0x3FFE, 0xCB8727C065C393E0),
+    make_floatx80_init(0x3FFC, 0xEAE10B5A7DDC8ADD),
+    make_floatx80_init(0x3FFE, 0xC907DA4E871146AD),
+    make_floatx80_init(0x3FFC, 0xF7856E5EE2C9B291),
+    make_floatx80_init(0x3FFE, 0xC6980C6980C6980C),
+    make_floatx80_init(0x3FFD, 0x82012CA5A68206D7),
+    make_floatx80_init(0x3FFE, 0xC4372F855D824CA6),
+    make_floatx80_init(0x3FFD, 0x882C5FCD7256A8C5),
+    make_floatx80_init(0x3FFE, 0xC1E4BBD595F6E947),
+    make_floatx80_init(0x3FFD, 0x8E44C60B4CCFD7DE),
+    make_floatx80_init(0x3FFE, 0xBFA02FE80BFA02FF),
+    make_floatx80_init(0x3FFD, 0x944AD09EF4351AF6),
+    make_floatx80_init(0x3FFE, 0xBD69104707661AA3),
+    make_floatx80_init(0x3FFD, 0x9A3EECD4C3EAA6B2),
+    make_floatx80_init(0x3FFE, 0xBB3EE721A54D880C),
+    make_floatx80_init(0x3FFD, 0xA0218434353F1DE8),
+    make_floatx80_init(0x3FFE, 0xB92143FA36F5E02E),
+    make_floatx80_init(0x3FFD, 0xA5F2FCABBBC506DA),
+    make_floatx80_init(0x3FFE, 0xB70FBB5A19BE3659),
+    make_floatx80_init(0x3FFD, 0xABB3B8BA2AD362A5),
+    make_floatx80_init(0x3FFE, 0xB509E68A9B94821F),
+    make_floatx80_init(0x3FFD, 0xB1641795CE3CA97B),
+    make_floatx80_init(0x3FFE, 0xB30F63528917C80B),
+    make_floatx80_init(0x3FFD, 0xB70475515D0F1C61),
+    make_floatx80_init(0x3FFE, 0xB11FD3B80B11FD3C),
+    make_floatx80_init(0x3FFD, 0xBC952AFEEA3D13E1),
+    make_floatx80_init(0x3FFE, 0xAF3ADDC680AF3ADE),
+    make_floatx80_init(0x3FFD, 0xC2168ED0F458BA4A),
+    make_floatx80_init(0x3FFE, 0xAD602B580AD602B6),
+    make_floatx80_init(0x3FFD, 0xC788F439B3163BF1),
+    make_floatx80_init(0x3FFE, 0xAB8F69E28359CD11),
+    make_floatx80_init(0x3FFD, 0xCCECAC08BF04565D),
+    make_floatx80_init(0x3FFE, 0xA9C84A47A07F5638),
+    make_floatx80_init(0x3FFD, 0xD24204872DD85160),
+    make_floatx80_init(0x3FFE, 0xA80A80A80A80A80B),
+    make_floatx80_init(0x3FFD, 0xD78949923BC3588A),
+    make_floatx80_init(0x3FFE, 0xA655C4392D7B73A8),
+    make_floatx80_init(0x3FFD, 0xDCC2C4B49887DACC),
+    make_floatx80_init(0x3FFE, 0xA4A9CF1D96833751),
+    make_floatx80_init(0x3FFD, 0xE1EEBD3E6D6A6B9E),
+    make_floatx80_init(0x3FFE, 0xA3065E3FAE7CD0E0),
+    make_floatx80_init(0x3FFD, 0xE70D785C2F9F5BDC),
+    make_floatx80_init(0x3FFE, 0xA16B312EA8FC377D),
+    make_floatx80_init(0x3FFD, 0xEC1F392C5179F283),
+    make_floatx80_init(0x3FFE, 0x9FD809FD809FD80A),
+    make_floatx80_init(0x3FFD, 0xF12440D3E36130E6),
+    make_floatx80_init(0x3FFE, 0x9E4CAD23DD5F3A20),
+    make_floatx80_init(0x3FFD, 0xF61CCE92346600BB),
+    make_floatx80_init(0x3FFE, 0x9CC8E160C3FB19B9),
+    make_floatx80_init(0x3FFD, 0xFB091FD38145630A),
+    make_floatx80_init(0x3FFE, 0x9B4C6F9EF03A3CAA),
+    make_floatx80_init(0x3FFD, 0xFFE97042BFA4C2AD),
+    make_floatx80_init(0x3FFE, 0x99D722DABDE58F06),
+    make_floatx80_init(0x3FFE, 0x825EFCED49369330),
+    make_floatx80_init(0x3FFE, 0x9868C809868C8098),
+    make_floatx80_init(0x3FFE, 0x84C37A7AB9A905C9),
+    make_floatx80_init(0x3FFE, 0x97012E025C04B809),
+    make_floatx80_init(0x3FFE, 0x87224C2E8E645FB7),
+    make_floatx80_init(0x3FFE, 0x95A02568095A0257),
+    make_floatx80_init(0x3FFE, 0x897B8CAC9F7DE298),
+    make_floatx80_init(0x3FFE, 0x9445809445809446),
+    make_floatx80_init(0x3FFE, 0x8BCF55DEC4CD05FE),
+    make_floatx80_init(0x3FFE, 0x92F113840497889C),
+    make_floatx80_init(0x3FFE, 0x8E1DC0FB89E125E5),
+    make_floatx80_init(0x3FFE, 0x91A2B3C4D5E6F809),
+    make_floatx80_init(0x3FFE, 0x9066E68C955B6C9B),
+    make_floatx80_init(0x3FFE, 0x905A38633E06C43B),
+    make_floatx80_init(0x3FFE, 0x92AADE74C7BE59E0),
+    make_floatx80_init(0x3FFE, 0x8F1779D9FDC3A219),
+    make_floatx80_init(0x3FFE, 0x94E9BFF615845643),
+    make_floatx80_init(0x3FFE, 0x8DDA520237694809),
+    make_floatx80_init(0x3FFE, 0x9723A1B720134203),
+    make_floatx80_init(0x3FFE, 0x8CA29C046514E023),
+    make_floatx80_init(0x3FFE, 0x995899C890EB8990),
+    make_floatx80_init(0x3FFE, 0x8B70344A139BC75A),
+    make_floatx80_init(0x3FFE, 0x9B88BDAA3A3DAE2F),
+    make_floatx80_init(0x3FFE, 0x8A42F8705669DB46),
+    make_floatx80_init(0x3FFE, 0x9DB4224FFFE1157C),
+    make_floatx80_init(0x3FFE, 0x891AC73AE9819B50),
+    make_floatx80_init(0x3FFE, 0x9FDADC268B7A12DA),
+    make_floatx80_init(0x3FFE, 0x87F78087F78087F8),
+    make_floatx80_init(0x3FFE, 0xA1FCFF17CE733BD4),
+    make_floatx80_init(0x3FFE, 0x86D905447A34ACC6),
+    make_floatx80_init(0x3FFE, 0xA41A9E8F5446FB9F),
+    make_floatx80_init(0x3FFE, 0x85BF37612CEE3C9B),
+    make_floatx80_init(0x3FFE, 0xA633CD7E6771CD8B),
+    make_floatx80_init(0x3FFE, 0x84A9F9C8084A9F9D),
+    make_floatx80_init(0x3FFE, 0xA8489E600B435A5E),
+    make_floatx80_init(0x3FFE, 0x839930523FBE3368),
+    make_floatx80_init(0x3FFE, 0xAA59233CCCA4BD49),
+    make_floatx80_init(0x3FFE, 0x828CBFBEB9A020A3),
+    make_floatx80_init(0x3FFE, 0xAC656DAE6BCC4985),
+    make_floatx80_init(0x3FFE, 0x81848DA8FAF0D277),
+    make_floatx80_init(0x3FFE, 0xAE6D8EE360BB2468),
+    make_floatx80_init(0x3FFE, 0x8080808080808081),
+    make_floatx80_init(0x3FFE, 0xB07197A23C46C654)
+};
+#endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index dbb24f8d84..2c3d20154a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5054,6 +5054,9 @@ DISAS_INSN(fpu)
     case 0x45: /* fdsqrt */
         gen_helper_fdsqrt(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x06: /* flognp1 */
+        gen_helper_flognp1(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x18: /* fabs */
         gen_helper_fabs(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
