Received: from eggs.gnu.org ([2001:4830:134:3::10]:59063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHISX-0005xO-JI
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHISV-00086u-I8
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:32:25 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHISV-00086e-CJ
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:32:23 -0400
Received: by mail-pl0-x242.google.com with SMTP id v24-v6so4142822plo.3
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:32:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:32:07 -0700
Message-Id: <20180512003217.9105-2-richard.henderson@linaro.org>
In-Reply-To: <20180512003217.9105-1-richard.henderson@linaro.org>
References: <20180512003217.9105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 01/11] target/arm: Implement FMOV (general)
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

Adding the fp16 moves to/from general registers.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4d1b220cc6..5b8cf75e9f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5700,6 +5700,15 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
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
@@ -5717,6 +5726,12 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
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
@@ -5756,6 +5771,12 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
         case 0xa: /* 64 bit */
         case 0xd: /* 64 bit to top half of quad */
             break;
+        case 0x6: /* 16-bit float, 32-bit int */
+        case 0xe: /* 16-bit float, 64-bit int */
+            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+                break;
+            }
+            /* fallthru */
         default:
             /* all other sf/type/rmode combinations are invalid */
             unallocated_encoding(s);
-- 
2.17.0
