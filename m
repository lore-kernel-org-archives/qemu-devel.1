Received: from eggs.gnu.org ([2001:4830:134:3::10]:38180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euJSk-0003LH-U7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euJSi-000306-Qn
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:57:39 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:38927)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euJSi-0002zM-DD
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:57:36 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  9 Mar 2018 15:57:15 +0100
Message-Id: <20180309145717.9603-7-laurent@vivier.eu>
In-Reply-To: <20180309145717.9603-1-laurent@vivier.eu>
References: <20180309145717.9603-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 6/8] target/m68k: implement fetox
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

Using a local m68k floatx80_etox()
[copied from previous:
Written by Andreas Grabher for Previous, NeXT Computer Emulator.]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180305203910.10391-7-laurent@vivier.eu>
---
 target/m68k/fpu_helper.c            |   5 +
 target/m68k/helper.h                |   1 +
 target/m68k/softfloat.c             | 183 ++++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h             |   1 +
 target/m68k/softfloat_fpsp_tables.h | 134 ++++++++++++++++++++++++++
 target/m68k/translate.c             |   3 +
 6 files changed, 327 insertions(+)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 97a4501126..154666cbb5 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -577,3 +577,8 @@ void HELPER(flog2)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_log2(val->d, &env->fp_status);
 }
+
+void HELPER(fetox)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_etox(val->d, &env->fp_status);
+}
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 15f63b353f..70aeb2da7c 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -72,6 +72,7 @@ DEF_HELPER_3(flognp1, void, env, fp, fp)
 DEF_HELPER_3(flogn, void, env, fp, fp)
 DEF_HELPER_3(flog10, void, env, fp, fp)
 DEF_HELPER_3(flog2, void, env, fp, fp)
+DEF_HELPER_3(fetox, void, env, fp, fp)
 
 DEF_HELPER_3(mac_move, void, env, i32, i32)
 DEF_HELPER_3(macmulf, i64, env, i32, i32)
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 9fa6d6fd05..e58eb91738 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -782,3 +782,186 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
 
     return a;
 }
+
+/*----------------------------------------------------------------------------
+ | e to x
+ *----------------------------------------------------------------------------*/
+
+floatx80 floatx80_etox(floatx80 a, float_status *status)
+{
+    flag aSign;
+    int32_t aExp;
+    uint64_t aSig;
+
+    int8_t user_rnd_mode, user_rnd_prec;
+
+    int32_t compact, n, j, k, m, m1;
+    floatx80 fp0, fp1, fp2, fp3, l2, scale, adjscale;
+    flag adjflag;
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
+    adjflag = 0;
+
+    if (aExp >= 0x3FBE) { /* |X| >= 2^(-65) */
+        compact = floatx80_make_compact(aExp, aSig);
+
+        if (compact < 0x400CB167) { /* |X| < 16380 log2 */
+            fp0 = a;
+            fp1 = a;
+            fp0 = floatx80_mul(fp0, float32_to_floatx80(
+                               make_float32(0x42B8AA3B), status),
+                               status); /* 64/log2 * X */
+            adjflag = 0;
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
+            m += 0x3FFF; /* biased exponent of 2^(M) */
+
+        expcont1:
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
+            fp2 = float32_to_floatx80(make_float32(0x3AB60B70),
+                                      status); /* A5 */
+            fp2 = floatx80_mul(fp2, fp1, status); /* fp2 is S*A5 */
+            fp3 = floatx80_mul(float32_to_floatx80(make_float32(0x3C088895),
+                               status), fp1,
+                               status); /* fp3 is S*A4 */
+            fp2 = floatx80_add(fp2, float64_to_floatx80(make_float64(
+                               0x3FA5555555554431), status),
+                               status); /* fp2 is A3+S*A5 */
+            fp3 = floatx80_add(fp3, float64_to_floatx80(make_float64(
+                               0x3FC5555555554018), status),
+                               status); /* fp3 is A2+S*A4 */
+            fp2 = floatx80_mul(fp2, fp1, status); /* fp2 is S*(A3+S*A5) */
+            fp3 = floatx80_mul(fp3, fp1, status); /* fp3 is S*(A2+S*A4) */
+            fp2 = floatx80_add(fp2, float32_to_floatx80(
+                               make_float32(0x3F000000), status),
+                               status); /* fp2 is A1+S*(A3+S*A5) */
+            fp3 = floatx80_mul(fp3, fp0, status); /* fp3 IS R*S*(A2+S*A4) */
+            fp2 = floatx80_mul(fp2, fp1,
+                               status); /* fp2 IS S*(A1+S*(A3+S*A5)) */
+            fp0 = floatx80_add(fp0, fp3, status); /* fp0 IS R+R*S*(A2+S*A4) */
+            fp0 = floatx80_add(fp0, fp2, status); /* fp0 IS EXP(R) - 1 */
+
+            fp1 = exp_tbl[j];
+            fp0 = floatx80_mul(fp0, fp1, status); /* 2^(J/64)*(Exp(R)-1) */
+            fp0 = floatx80_add(fp0, float32_to_floatx80(exp_tbl2[j], status),
+                               status); /* accurate 2^(J/64) */
+            fp0 = floatx80_add(fp0, fp1,
+                               status); /* 2^(J/64) + 2^(J/64)*(Exp(R)-1) */
+
+            scale = packFloatx80(0, m, one_sig);
+            if (adjflag) {
+                adjscale = packFloatx80(0, m1, one_sig);
+                fp0 = floatx80_mul(fp0, adjscale, status);
+            }
+
+            status->float_rounding_mode = user_rnd_mode;
+            status->floatx80_rounding_precision = user_rnd_prec;
+
+            a = floatx80_mul(fp0, scale, status);
+
+            float_raise(float_flag_inexact, status);
+
+            return a;
+        } else { /* |X| >= 16380 log2 */
+            if (compact > 0x400CB27C) { /* |X| >= 16480 log2 */
+                status->float_rounding_mode = user_rnd_mode;
+                status->floatx80_rounding_precision = user_rnd_prec;
+                if (aSign) {
+                    a = roundAndPackFloatx80(
+                                           status->floatx80_rounding_precision,
+                                           0, -0x1000, aSig, 0, status);
+                } else {
+                    a = roundAndPackFloatx80(
+                                           status->floatx80_rounding_precision,
+                                           0, 0x8000, aSig, 0, status);
+                }
+                float_raise(float_flag_inexact, status);
+
+                return a;
+            } else {
+                fp0 = a;
+                fp1 = a;
+                fp0 = floatx80_mul(fp0, float32_to_floatx80(
+                                   make_float32(0x42B8AA3B), status),
+                                   status); /* 64/log2 * X */
+                adjflag = 1;
+                n = floatx80_to_int32(fp0, status); /* int(64/log2*X) */
+                fp0 = int32_to_floatx80(n, status);
+
+                j = n & 0x3F; /* J = N mod 64 */
+                /* NOTE: this is really arithmetic right shift by 6 */
+                k = n / 64;
+                if (n < 0 && j) {
+                    /* arithmetic right shift is division and
+                     * round towards minus infinity
+                     */
+                    k--;
+                }
+                /* NOTE: this is really arithmetic right shift by 1 */
+                m1 = k / 2;
+                if (k < 0 && (k & 1)) {
+                    /* arithmetic right shift is division and
+                     * round towards minus infinity
+                     */
+                    m1--;
+                }
+                m = k - m1;
+                m1 += 0x3FFF; /* biased exponent of 2^(M1) */
+                m += 0x3FFF; /* biased exponent of 2^(M) */
+
+                goto expcont1;
+            }
+        }
+    } else { /* |X| < 2^(-65) */
+        status->float_rounding_mode = user_rnd_mode;
+        status->floatx80_rounding_precision = user_rnd_prec;
+
+        a = floatx80_add(a, float32_to_floatx80(make_float32(0x3F800000),
+                         status), status); /* 1 + X */
+
+        float_raise(float_flag_inexact, status);
+
+        return a;
+    }
+}
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index c0b77cf01b..250f0d926f 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -31,4 +31,5 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status);
 floatx80 floatx80_logn(floatx80 a, float_status *status);
 floatx80 floatx80_log10(floatx80 a, float_status *status);
 floatx80 floatx80_log2(floatx80 a, float_status *status);
+floatx80 floatx80_etox(floatx80 a, float_status *status);
 #endif
diff --git a/target/m68k/softfloat_fpsp_tables.h b/target/m68k/softfloat_fpsp_tables.h
index a87179e11e..b2b63e5ced 100644
--- a/target/m68k/softfloat_fpsp_tables.h
+++ b/target/m68k/softfloat_fpsp_tables.h
@@ -151,4 +151,138 @@ static const floatx80 log_tbl[128] = {
     make_floatx80_init(0x3FFE, 0x8080808080808081),
     make_floatx80_init(0x3FFE, 0xB07197A23C46C654)
 };
+
+static const floatx80 exp_tbl[64] = {
+    make_floatx80_init(0x3FFF, 0x8000000000000000),
+    make_floatx80_init(0x3FFF, 0x8164D1F3BC030774),
+    make_floatx80_init(0x3FFF, 0x82CD8698AC2BA1D8),
+    make_floatx80_init(0x3FFF, 0x843A28C3ACDE4048),
+    make_floatx80_init(0x3FFF, 0x85AAC367CC487B14),
+    make_floatx80_init(0x3FFF, 0x871F61969E8D1010),
+    make_floatx80_init(0x3FFF, 0x88980E8092DA8528),
+    make_floatx80_init(0x3FFF, 0x8A14D575496EFD9C),
+    make_floatx80_init(0x3FFF, 0x8B95C1E3EA8BD6E8),
+    make_floatx80_init(0x3FFF, 0x8D1ADF5B7E5BA9E4),
+    make_floatx80_init(0x3FFF, 0x8EA4398B45CD53C0),
+    make_floatx80_init(0x3FFF, 0x9031DC431466B1DC),
+    make_floatx80_init(0x3FFF, 0x91C3D373AB11C338),
+    make_floatx80_init(0x3FFF, 0x935A2B2F13E6E92C),
+    make_floatx80_init(0x3FFF, 0x94F4EFA8FEF70960),
+    make_floatx80_init(0x3FFF, 0x96942D3720185A00),
+    make_floatx80_init(0x3FFF, 0x9837F0518DB8A970),
+    make_floatx80_init(0x3FFF, 0x99E0459320B7FA64),
+    make_floatx80_init(0x3FFF, 0x9B8D39B9D54E5538),
+    make_floatx80_init(0x3FFF, 0x9D3ED9A72CFFB750),
+    make_floatx80_init(0x3FFF, 0x9EF5326091A111AC),
+    make_floatx80_init(0x3FFF, 0xA0B0510FB9714FC4),
+    make_floatx80_init(0x3FFF, 0xA27043030C496818),
+    make_floatx80_init(0x3FFF, 0xA43515AE09E680A0),
+    make_floatx80_init(0x3FFF, 0xA5FED6A9B15138EC),
+    make_floatx80_init(0x3FFF, 0xA7CD93B4E9653568),
+    make_floatx80_init(0x3FFF, 0xA9A15AB4EA7C0EF8),
+    make_floatx80_init(0x3FFF, 0xAB7A39B5A93ED338),
+    make_floatx80_init(0x3FFF, 0xAD583EEA42A14AC8),
+    make_floatx80_init(0x3FFF, 0xAF3B78AD690A4374),
+    make_floatx80_init(0x3FFF, 0xB123F581D2AC2590),
+    make_floatx80_init(0x3FFF, 0xB311C412A9112488),
+    make_floatx80_init(0x3FFF, 0xB504F333F9DE6484),
+    make_floatx80_init(0x3FFF, 0xB6FD91E328D17790),
+    make_floatx80_init(0x3FFF, 0xB8FBAF4762FB9EE8),
+    make_floatx80_init(0x3FFF, 0xBAFF5AB2133E45FC),
+    make_floatx80_init(0x3FFF, 0xBD08A39F580C36C0),
+    make_floatx80_init(0x3FFF, 0xBF1799B67A731084),
+    make_floatx80_init(0x3FFF, 0xC12C4CCA66709458),
+    make_floatx80_init(0x3FFF, 0xC346CCDA24976408),
+    make_floatx80_init(0x3FFF, 0xC5672A115506DADC),
+    make_floatx80_init(0x3FFF, 0xC78D74C8ABB9B15C),
+    make_floatx80_init(0x3FFF, 0xC9B9BD866E2F27A4),
+    make_floatx80_init(0x3FFF, 0xCBEC14FEF2727C5C),
+    make_floatx80_init(0x3FFF, 0xCE248C151F8480E4),
+    make_floatx80_init(0x3FFF, 0xD06333DAEF2B2594),
+    make_floatx80_init(0x3FFF, 0xD2A81D91F12AE45C),
+    make_floatx80_init(0x3FFF, 0xD4F35AABCFEDFA20),
+    make_floatx80_init(0x3FFF, 0xD744FCCAD69D6AF4),
+    make_floatx80_init(0x3FFF, 0xD99D15C278AFD7B4),
+    make_floatx80_init(0x3FFF, 0xDBFBB797DAF23754),
+    make_floatx80_init(0x3FFF, 0xDE60F4825E0E9124),
+    make_floatx80_init(0x3FFF, 0xE0CCDEEC2A94E110),
+    make_floatx80_init(0x3FFF, 0xE33F8972BE8A5A50),
+    make_floatx80_init(0x3FFF, 0xE5B906E77C8348A8),
+    make_floatx80_init(0x3FFF, 0xE8396A503C4BDC68),
+    make_floatx80_init(0x3FFF, 0xEAC0C6E7DD243930),
+    make_floatx80_init(0x3FFF, 0xED4F301ED9942B84),
+    make_floatx80_init(0x3FFF, 0xEFE4B99BDCDAF5CC),
+    make_floatx80_init(0x3FFF, 0xF281773C59FFB138),
+    make_floatx80_init(0x3FFF, 0xF5257D152486CC2C),
+    make_floatx80_init(0x3FFF, 0xF7D0DF730AD13BB8),
+    make_floatx80_init(0x3FFF, 0xFA83B2DB722A033C),
+    make_floatx80_init(0x3FFF, 0xFD3E0C0CF486C174)
+};
+
+static const float32 exp_tbl2[64] = {
+    const_float32(0x00000000),
+    const_float32(0x9F841A9B),
+    const_float32(0x9FC1D5B9),
+    const_float32(0xA0728369),
+    const_float32(0x1FC5C95C),
+    const_float32(0x1EE85C9F),
+    const_float32(0x9FA20729),
+    const_float32(0xA07BF9AF),
+    const_float32(0xA0020DCF),
+    const_float32(0x205A63DA),
+    const_float32(0x1EB70051),
+    const_float32(0x1F6EB029),
+    const_float32(0xA0781494),
+    const_float32(0x9EB319B0),
+    const_float32(0x2017457D),
+    const_float32(0x1F11D537),
+    const_float32(0x9FB952DD),
+    const_float32(0x1FE43087),
+    const_float32(0x1FA2A818),
+    const_float32(0x1FDE494D),
+    const_float32(0x20504890),
+    const_float32(0xA073691C),
+    const_float32(0x1F9B7A05),
+    const_float32(0xA0797126),
+    const_float32(0xA071A140),
+    const_float32(0x204F62DA),
+    const_float32(0x1F283C4A),
+    const_float32(0x9F9A7FDC),
+    const_float32(0xA05B3FAC),
+    const_float32(0x1FDF2610),
+    const_float32(0x9F705F90),
+    const_float32(0x201F678A),
+    const_float32(0x1F32FB13),
+    const_float32(0x20038B30),
+    const_float32(0x200DC3CC),
+    const_float32(0x9F8B2AE6),
+    const_float32(0xA02BBF70),
+    const_float32(0xA00BF518),
+    const_float32(0xA041DD41),
+    const_float32(0x9FDF137B),
+    const_float32(0x201F1568),
+    const_float32(0x1FC13A2E),
+    const_float32(0xA03F8F03),
+    const_float32(0x1FF4907D),
+    const_float32(0x9E6E53E4),
+    const_float32(0x1FD6D45C),
+    const_float32(0xA076EDB9),
+    const_float32(0x9FA6DE21),
+    const_float32(0x1EE69A2F),
+    const_float32(0x207F439F),
+    const_float32(0x201EC207),
+    const_float32(0x9E8BE175),
+    const_float32(0x20032C4B),
+    const_float32(0x2004DFF5),
+    const_float32(0x1E72F47A),
+    const_float32(0x1F722F22),
+    const_float32(0xA017E945),
+    const_float32(0x1F401A5B),
+    const_float32(0x9FB9A9E3),
+    const_float32(0x20744C05),
+    const_float32(0x1F773A19),
+    const_float32(0x1FFE90D5),
+    const_float32(0xA041ED22),
+    const_float32(0x1F853F3A),
+};
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 189b23d38d..4774310ded 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5057,6 +5057,9 @@ DISAS_INSN(fpu)
     case 0x06: /* flognp1 */
         gen_helper_flognp1(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x10: /* fetox */
+        gen_helper_fetox(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x14: /* flogn */
         gen_helper_flogn(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.14.3
