Received: from eggs.gnu.org ([209.51.188.92]:43323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqWwc-00017n-Vd
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqWn2-0002gn-41
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:27:28 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqWmy-0002Xn-1W
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:27:26 -0500
Received: by mail-wm1-x344.google.com with SMTP id f188so11914287wmf.5
	for <qemu-devel@nongnu.org>; Sun, 03 Feb 2019 21:27:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 05:27:10 +0000
Message-Id: <20190204052712.30833-2-richard.henderson@linaro.org>
In-Reply-To: <20190204052712.30833-1-richard.henderson@linaro.org>
References: <20190204052712.30833-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] target/arm: Force result size into dp
 after operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Rather than a complex set of cases testing for writeback,
adjust DP after performing the operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 66cf28c8cb..eb25895876 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3970,6 +3970,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         tcg_gen_or_i32(tmp, tmp, tmp2);
                         tcg_temp_free_i32(tmp2);
                         gen_vfp_msr(tmp);
+                        dp = 0; /* always a single precision result */
                         break;
                     }
                     case 7: /* vcvtt.f16.f32, vcvtt.f16.f64 */
@@ -3993,20 +3994,25 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         tcg_gen_or_i32(tmp, tmp, tmp2);
                         tcg_temp_free_i32(tmp2);
                         gen_vfp_msr(tmp);
+                        dp = 0; /* always a single precision result */
                         break;
                     }
                     case 8: /* cmp */
                         gen_vfp_cmp(dp);
+                        dp = -1; /* no write back */
                         break;
                     case 9: /* cmpe */
                         gen_vfp_cmpe(dp);
+                        dp = -1; /* no write back */
                         break;
                     case 10: /* cmpz */
                         gen_vfp_cmp(dp);
+                        dp = -1; /* no write back */
                         break;
                     case 11: /* cmpez */
                         gen_vfp_F1_ld0(dp);
                         gen_vfp_cmpe(dp);
+                        dp = -1; /* no write back */
                         break;
                     case 12: /* vrintr */
                     {
@@ -4047,10 +4053,12 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         break;
                     }
                     case 15: /* single<->double conversion */
-                        if (dp)
+                        if (dp) {
                             gen_helper_vfp_fcvtsd(cpu_F0s, cpu_F0d, cpu_env);
-                        else
+                        } else {
                             gen_helper_vfp_fcvtds(cpu_F0d, cpu_F0s, cpu_env);
+                        }
+                        dp = !dp; /* result size is opposite */
                         break;
                     case 16: /* fuito */
                         gen_vfp_uito(dp, 0);
@@ -4084,15 +4092,19 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         break;
                     case 24: /* ftoui */
                         gen_vfp_toui(dp, 0);
+                        dp = 0; /* always an integer result */
                         break;
                     case 25: /* ftouiz */
                         gen_vfp_touiz(dp, 0);
+                        dp = 0; /* always an integer result */
                         break;
                     case 26: /* ftosi */
                         gen_vfp_tosi(dp, 0);
+                        dp = 0; /* always an integer result */
                         break;
                     case 27: /* ftosiz */
                         gen_vfp_tosiz(dp, 0);
+                        dp = 0; /* always an integer result */
                         break;
                     case 28: /* ftosh */
                         if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
@@ -4126,20 +4138,8 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     return 1;
                 }
 
-                /* Write back the result.  */
-                if (op == 15 && (rn >= 8 && rn <= 11)) {
-                    /* Comparison, do nothing.  */
-                } else if (op == 15 && dp && ((rn & 0x1c) == 0x18 ||
-                                              (rn & 0x1e) == 0x6)) {
-                    /* VCVT double to int: always integer result.
-                     * VCVT double to half precision is always a single
-                     * precision result.
-                     */
-                    gen_mov_vreg_F0(0, rd);
-                } else if (op == 15 && rn == 15) {
-                    /* conversion */
-                    gen_mov_vreg_F0(!dp, rd);
-                } else {
+                /* Write back the result, if any.  */
+                if (dp >= 0) {
                     gen_mov_vreg_F0(dp, rd);
                 }
 
-- 
2.17.2
