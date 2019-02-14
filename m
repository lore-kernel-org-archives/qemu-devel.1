Received: from eggs.gnu.org ([209.51.188.92]:53787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKq-0007i5-MN
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKp-0004eE-RI
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:12 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMKp-0004de-Ki
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:11 -0500
Received: by mail-wr1-x42c.google.com with SMTP id v16so7681111wrn.11
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:40 +0000
Message-Id: <20190214190603.25030-5-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/27] target/arm: Force result size into dp
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

From: Richard Henderson <richard.henderson@linaro.org>

Rather than a complex set of cases testing for writeback,
adjust DP after performing the operation.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190206052857.5077-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 66cf28c8cbe..eb258958768 100644
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
2.20.1
