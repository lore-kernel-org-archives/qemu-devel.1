Received: from eggs.gnu.org ([2001:4830:134:3::10]:39552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabl-0003pb-06
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabj-0002rK-T9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIabj-0002qc-LX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:15 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabi-0001R2-Ou
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:07:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 15:07:00 +0100
Message-Id: <20180515140707.15957-10-peter.maydell@linaro.org>
In-Reply-To: <20180515140707.15957-1-peter.maydell@linaro.org>
References: <20180515140707.15957-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/16] target/arm: Implement FP data-processing
 (2 source) for fp16
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

We missed all of the scalar fp16 binary operations.

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180512003217.9105-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 78f12daaf6..66607668ce 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5299,6 +5299,61 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
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
@@ -5331,6 +5386,16 @@ static void disas_fp_2src(DisasContext *s, uint32_t insn)
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
2.17.0
