Received: from eggs.gnu.org ([2001:4830:134:3::10]:58725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02d-0000em-MX
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02c-0007tR-MM
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:03 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fE02c-0007sv-HI
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:02 -0400
Received: by mail-pf0-x242.google.com with SMTP id z9so12955528pfe.6
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 15:16:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 15:15:43 -0700
Message-Id: <20180502221552.3873-6-richard.henderson@linaro.org>
In-Reply-To: <20180502221552.3873-1-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 05/14] target/arm: Implement FMOV (general)
 for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-stable@nongnu.org

Adding the fp16 moves to/from general registers.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c64c3ed99d..247a4f0cce 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5463,6 +5463,15 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
             tcg_gen_st_i64(tcg_rn, cpu_env, fp_reg_hi_offset(s, rd));
             clear_vec_high(s, true, rd);
             break;
+        case 3:
+            /* 16 bit */
+            tmp = tcg_temp_new_i64();
+            tcg_gen_ext16u_i64(tmp, tcg_rn);
+            write_fp_dreg(s, rd, tmp);
+            tcg_temp_free_i64(tmp);
+            break;
+        default:
+            g_assert_not_reached();
         }
     } else {
         TCGv_i64 tcg_rd = cpu_reg(s, rd);
@@ -5480,6 +5489,12 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
             /* 64 bits from top half */
             tcg_gen_ld_i64(tcg_rd, cpu_env, fp_reg_hi_offset(s, rn));
             break;
+        case 3:
+            /* 16 bit */
+            tcg_gen_ld16u_i64(tcg_rd, cpu_env, fp_reg_offset(s, rn, MO_16));
+            break;
+        default:
+            g_assert_not_reached();
         }
     }
 }
@@ -5519,10 +5534,15 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
         case 0xa: /* 64 bit */
         case 0xd: /* 64 bit to top half of quad */
             break;
+        case 0x6: /* 16-bit */
+            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+                break;
+            }
+            /* fallthru */
         default:
             /* all other sf/type/rmode combinations are invalid */
             unallocated_encoding(s);
-            break;
+            return;
         }
 
         if (!fp_access_check(s)) {
-- 
2.14.3
