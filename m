Received: from eggs.gnu.org ([2001:4830:134:3::10]:43018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKc-0003oR-Dr
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKb-0005KA-GG
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:22 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:25 -0500
Message-Id: <20180723201748.25573-77-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 76/99] target/arm: Implement FMOV (general) for
 fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Adding the fp16 moves to/from general registers.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180512003217.9105-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 68130236e30a1ec64363f4915349feee181bfbc1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 639cd95772..b05f9bfe91 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5457,6 +5457,15 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
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
@@ -5474,6 +5483,12 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
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
@@ -5513,6 +5528,12 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
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
2.17.1
