Received: from eggs.gnu.org ([2001:4830:134:3::10]:58867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02j-0000lk-9i
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02h-0007wv-PF
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:09 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fE02h-0007wT-JQ
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:07 -0400
Received: by mail-pg0-x244.google.com with SMTP id i194-v6so11634147pgd.0
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 15:16:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 15:15:47 -0700
Message-Id: <20180502221552.3873-10-richard.henderson@linaro.org>
In-Reply-To: <20180502221552.3873-1-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/14] target/arm: Implement FP
 data-processing (2 source) for fp16
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

We missed all of the scalar fp16 binary operations.

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8c63d5e743..d7a49ef2e4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5062,6 +5062,61 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
     tcg_temp_free_i64(tcg_res);
 }
 
+/* Floating-point data-processing (2 source) - half precision */
+static void handle_fp_2src_half(DisasContext *s, int opcode,
+                                int rd, int rn, int rm)
+{
+    TCGv_i32 tcg_op1;
+    TCGv_i32 tcg_op2;
+    TCGv_i32 tcg_res;
+    TCGv_ptr fpst;
+
+    tcg_res = tcg_temp_new_i32();
+    fpst = get_fpstatus_ptr(true);
+    tcg_op1 = read_fp_hreg(s, rn);
+    tcg_op2 = read_fp_hreg(s, rm);
+
+    switch (opcode) {
+    case 0x0: /* FMUL */
+        gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x1: /* FDIV */
+        gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x2: /* FADD */
+        gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x3: /* FSUB */
+        gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x4: /* FMAX */
+        gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x5: /* FMIN */
+        gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x6: /* FMAXNM */
+        gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x7: /* FMINNM */
+        gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x8: /* FNMUL */
+        gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
+        tcg_gen_xori_i32(tcg_res, tcg_res, 0x8000);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    write_fp_sreg(s, rd, tcg_res);
+
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tcg_op1);
+    tcg_temp_free_i32(tcg_op2);
+    tcg_temp_free_i32(tcg_res);
+}
+
 /* Floating point data-processing (2 source)
  *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+---+------+--------+-----+------+------+
@@ -5094,6 +5149,16 @@ static void disas_fp_2src(DisasContext *s, uint32_t insn)
         }
         handle_fp_2src_double(s, opcode, rd, rn, rm);
         break;
+    case 3:
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            unallocated_encoding(s);
+            return;
+        }
+        if (!fp_access_check(s)) {
+            return;
+        }
+        handle_fp_2src_half(s, opcode, rd, rn, rm);
+        break;
     default:
         unallocated_encoding(s);
     }
-- 
2.14.3
