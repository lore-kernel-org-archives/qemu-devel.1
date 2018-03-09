Received: from eggs.gnu.org ([2001:4830:134:3::10]:58956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euIyr-0000wT-Po
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euIyp-0007DZ-SC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:45 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:58847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euIyp-0007Ce-F0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:43 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  9 Mar 2018 15:26:29 +0100
Message-Id: <20180309142630.2170-8-laurent@vivier.eu>
In-Reply-To: <20180309142630.2170-1-laurent@vivier.eu>
References: <20180309142630.2170-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 7/8] target/m68k: implement ftwotox
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

Using a local m68k floatx80_twotox()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180305203910.10391-8-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c            |   5 ++
 target/m68k/helper.h                |   1 +
 target/m68k/softfloat.c             | 148 ++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h             |   1 +
 target/m68k/softfloat_fpsp_tables.h |  86 +++++++++++++++++++++
 target/m68k/translate.c             |   3 +
 6 files changed, 244 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 154666cbb5..f488a92ab2 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -582,3 +582,8 @@ void HELPER(fetox)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_etox(val->d, &env->fp_status);
 }
+
+void HELPER(ftwotox)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_twotox(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 70aeb2da7c..8caa82296d 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -73,6 +73,7 @@ DEF_HELPER_3(flogn, void, env, fp, fp)
 DEF_HELPER_3(flog10, void, env, fp, fp)
 DEF_HELPER_3(flog2, void, env, fp, fp)
 DEF_HELPER_3(fetox, void, env, fp, fp)
+DEF_HELPER_3(ftwotox, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index e58eb91738..cfff30d359 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -965,3 +965,151 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
         return a;
     }
 }
+
+/*----------------------------------------------------------------------------
+ | 2 to x
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_twotox(floatx80 a, float_status *status)
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
+    if (compact < 0x3FB98000 || compact > 0x400D80C0) {
+        /* |X| > 16480 or |X| < 2^(-70) */
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
+    } else { /* 2^(-70) <= |X| <= 16480 */
+        fp1 = fp0; /* X */
+        fp1 = floatx80_mul(fp1, float32_to_floatx80(
+                           make_float32(0x42800000), status),
+                           status); /* X * 64 */
+        n = floatx80_to_int32(fp1, status);
+        fp1 = int32_to_floatx80(n, status);
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
+        fp1 = floatx80_mul(fp1, float32_to_floatx80(
+                           make_float32(0x3C800000), status),
+                           status); /* (1/64)*N */
+        fp0 = floatx80_sub(fp0, fp1, status); /* X - (1/64)*INT(64 X) */
+        fp2 = packFloatx80(0, 0x3FFE, LIT64(0xB17217F7D1CF79AC)); /* LOG2 */
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
index 250f0d926f..964275d2a5 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -32,4 +32,5 @@ floatx80 floatx80_logn(floatx80 a, float_status *status);
 floatx80 floatx80_log10(floatx80 a, float_status *status);
 floatx80 floatx80_log2(floatx80 a, float_status *status);
 floatx80 floatx80_etox(floatx80 a, float_status *status);
+floatx80 floatx80_twotox(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/softfloat_fpsp_tables.h b/target/m68k/softfloat_fpsp_tables.h
index b2b63e5ced..dd76dc0373 100755
--- a/target/m68k/softfloat_fpsp_tables.h
+++ b/target/m68k/softfloat_fpsp_tables.h
@@ -285,4 +285,90 @@ static const float32 exp_tbl2[64] = {
     const_float32(0xA041ED22),
     const_float32(0x1F853F3A),
 };
+
+static const floatx80 exp2_tbl[64] = {
+    make_floatx80_init(0x3FFF, 0x8000000000000000),
+    make_floatx80_init(0x3FFF, 0x8164D1F3BC030773),
+    make_floatx80_init(0x3FFF, 0x82CD8698AC2BA1D7),
+    make_floatx80_init(0x3FFF, 0x843A28C3ACDE4046),
+    make_floatx80_init(0x3FFF, 0x85AAC367CC487B15),
+    make_floatx80_init(0x3FFF, 0x871F61969E8D1010),
+    make_floatx80_init(0x3FFF, 0x88980E8092DA8527),
+    make_floatx80_init(0x3FFF, 0x8A14D575496EFD9A),
+    make_floatx80_init(0x3FFF, 0x8B95C1E3EA8BD6E7),
+    make_floatx80_init(0x3FFF, 0x8D1ADF5B7E5BA9E6),
+    make_floatx80_init(0x3FFF, 0x8EA4398B45CD53C0),
+    make_floatx80_init(0x3FFF, 0x9031DC431466B1DC),
+    make_floatx80_init(0x3FFF, 0x91C3D373AB11C336),
+    make_floatx80_init(0x3FFF, 0x935A2B2F13E6E92C),
+    make_floatx80_init(0x3FFF, 0x94F4EFA8FEF70961),
+    make_floatx80_init(0x3FFF, 0x96942D3720185A00),
+    make_floatx80_init(0x3FFF, 0x9837F0518DB8A96F),
+    make_floatx80_init(0x3FFF, 0x99E0459320B7FA65),
+    make_floatx80_init(0x3FFF, 0x9B8D39B9D54E5539),
+    make_floatx80_init(0x3FFF, 0x9D3ED9A72CFFB751),
+    make_floatx80_init(0x3FFF, 0x9EF5326091A111AE),
+    make_floatx80_init(0x3FFF, 0xA0B0510FB9714FC2),
+    make_floatx80_init(0x3FFF, 0xA27043030C496819),
+    make_floatx80_init(0x3FFF, 0xA43515AE09E6809E),
+    make_floatx80_init(0x3FFF, 0xA5FED6A9B15138EA),
+    make_floatx80_init(0x3FFF, 0xA7CD93B4E965356A),
+    make_floatx80_init(0x3FFF, 0xA9A15AB4EA7C0EF8),
+    make_floatx80_init(0x3FFF, 0xAB7A39B5A93ED337),
+    make_floatx80_init(0x3FFF, 0xAD583EEA42A14AC6),
+    make_floatx80_init(0x3FFF, 0xAF3B78AD690A4375),
+    make_floatx80_init(0x3FFF, 0xB123F581D2AC2590),
+    make_floatx80_init(0x3FFF, 0xB311C412A9112489),
+    make_floatx80_init(0x3FFF, 0xB504F333F9DE6484),
+    make_floatx80_init(0x3FFF, 0xB6FD91E328D17791),
+    make_floatx80_init(0x3FFF, 0xB8FBAF4762FB9EE9),
+    make_floatx80_init(0x3FFF, 0xBAFF5AB2133E45FB),
+    make_floatx80_init(0x3FFF, 0xBD08A39F580C36BF),
+    make_floatx80_init(0x3FFF, 0xBF1799B67A731083),
+    make_floatx80_init(0x3FFF, 0xC12C4CCA66709456),
+    make_floatx80_init(0x3FFF, 0xC346CCDA24976407),
+    make_floatx80_init(0x3FFF, 0xC5672A115506DADD),
+    make_floatx80_init(0x3FFF, 0xC78D74C8ABB9B15D),
+    make_floatx80_init(0x3FFF, 0xC9B9BD866E2F27A3),
+    make_floatx80_init(0x3FFF, 0xCBEC14FEF2727C5D),
+    make_floatx80_init(0x3FFF, 0xCE248C151F8480E4),
+    make_floatx80_init(0x3FFF, 0xD06333DAEF2B2595),
+    make_floatx80_init(0x3FFF, 0xD2A81D91F12AE45A),
+    make_floatx80_init(0x3FFF, 0xD4F35AABCFEDFA1F),
+    make_floatx80_init(0x3FFF, 0xD744FCCAD69D6AF4),
+    make_floatx80_init(0x3FFF, 0xD99D15C278AFD7B6),
+    make_floatx80_init(0x3FFF, 0xDBFBB797DAF23755),
+    make_floatx80_init(0x3FFF, 0xDE60F4825E0E9124),
+    make_floatx80_init(0x3FFF, 0xE0CCDEEC2A94E111),
+    make_floatx80_init(0x3FFF, 0xE33F8972BE8A5A51),
+    make_floatx80_init(0x3FFF, 0xE5B906E77C8348A8),
+    make_floatx80_init(0x3FFF, 0xE8396A503C4BDC68),
+    make_floatx80_init(0x3FFF, 0xEAC0C6E7DD24392F),
+    make_floatx80_init(0x3FFF, 0xED4F301ED9942B84),
+    make_floatx80_init(0x3FFF, 0xEFE4B99BDCDAF5CB),
+    make_floatx80_init(0x3FFF, 0xF281773C59FFB13A),
+    make_floatx80_init(0x3FFF, 0xF5257D152486CC2C),
+    make_floatx80_init(0x3FFF, 0xF7D0DF730AD13BB9),
+    make_floatx80_init(0x3FFF, 0xFA83B2DB722A033A),
+    make_floatx80_init(0x3FFF, 0xFD3E0C0CF486C175)
+};
+
+static const uint32_t exp2_tbl2[64] = {
+    0x3F738000, 0x3FBEF7CA, 0x3FBDF8A9, 0x3FBCD7C9,
+    0xBFBDE8DA, 0x3FBDE85C, 0x3FBEBBF1, 0x3FBB80CA,
+    0xBFBA8373, 0xBFBE9670, 0x3FBDB700, 0x3FBEEEB0,
+    0x3FBBFD6D, 0xBFBDB319, 0x3FBDBA2B, 0x3FBE91D5,
+    0x3FBE8D5A, 0xBFBCDE7B, 0xBFBEBAAF, 0xBFBD86DA,
+    0xBFBEBEDD, 0x3FBCC96E, 0xBFBEC90B, 0x3FBBD1DB,
+    0x3FBCE5EB, 0xBFBEC274, 0x3FBEA83C, 0x3FBECB00,
+    0x3FBE9301, 0xBFBD8367, 0xBFBEF05F, 0x3FBDFB3C,
+    0x3FBEB2FB, 0x3FBAE2CB, 0x3FBCDC3C, 0x3FBEE9AA,
+    0xBFBEAEFD, 0xBFBCBF51, 0x3FBEF88A, 0x3FBD83B2,
+    0x3FBDF8AB, 0xBFBDFB17, 0xBFBEFE3C, 0xBFBBB6F8,
+    0xBFBCEE53, 0xBFBDA4AE, 0x3FBC9124, 0x3FBEB243,
+    0x3FBDE69A, 0xBFB8BC61, 0x3FBDF610, 0xBFBD8BE1,
+    0x3FBACB12, 0x3FBB9BFE, 0x3FBCF2F4, 0x3FBEF22F,
+    0xBFBDBF4A, 0x3FBEC01A, 0x3FBE8CAC, 0xBFBCBB3F,
+    0x3FBEF73A, 0xBFB8B795, 0x3FBEF84B, 0xBFBEF581
+};
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4774310ded..c65c82e258 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5060,6 +5060,9 @@ DISAS_INSN(fpu)
     case 0x10: /* fetox */
         gen_helper_fetox(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x11: /* ftwotox */
+        gen_helper_ftwotox(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x14: /* flogn */
         gen_helper_flogn(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
