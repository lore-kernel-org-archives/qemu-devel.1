Received: from eggs.gnu.org ([2001:4830:134:3::10]:43206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKq-00043L-I0
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKp-0005Sc-CL
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:36 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:30 -0500
Message-Id: <20180723201748.25573-82-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 81/99] target/arm: Implement FP data-processing
 (3 source) for fp16
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

We missed all of the scalar fp16 fma operations.

Cc: qemu-stable@nongnu.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180512003217.9105-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 95f9864fde6078e2d2c036a07cc4fe44f199be96)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5260849f03..9880a5d047 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5234,6 +5234,44 @@ static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
     tcg_temp_free_i64(tcg_res);
 }
 
+/* Floating-point data-processing (3 source) - half precision */
+static void handle_fp_3src_half(DisasContext *s, bool o0, bool o1,
+                                int rd, int rn, int rm, int ra)
+{
+    TCGv_i32 tcg_op1, tcg_op2, tcg_op3;
+    TCGv_i32 tcg_res = tcg_temp_new_i32();
+    TCGv_ptr fpst = get_fpstatus_ptr(true);
+
+    tcg_op1 = read_fp_hreg(s, rn);
+    tcg_op2 = read_fp_hreg(s, rm);
+    tcg_op3 = read_fp_hreg(s, ra);
+
+    /* These are fused multiply-add, and must be done as one
+     * floating point operation with no rounding between the
+     * multiplication and addition steps.
+     * NB that doing the negations here as separate steps is
+     * correct : an input NaN should come out with its sign bit
+     * flipped if it is a negated-input.
+     */
+    if (o1 == true) {
+        tcg_gen_xori_i32(tcg_op3, tcg_op3, 0x8000);
+    }
+
+    if (o0 != o1) {
+        tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
+    }
+
+    gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_op3, fpst);
+
+    write_fp_sreg(s, rd, tcg_res);
+
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tcg_op1);
+    tcg_temp_free_i32(tcg_op2);
+    tcg_temp_free_i32(tcg_op3);
+    tcg_temp_free_i32(tcg_res);
+}
+
 /* Floating point data-processing (3 source)
  *   31  30  29 28       24 23  22  21  20  16  15  14  10 9    5 4    0
  * +---+---+---+-----------+------+----+------+----+------+------+------+
@@ -5263,6 +5301,16 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
         }
         handle_fp_3src_double(s, o0, o1, rd, rn, rm, ra);
         break;
+    case 3:
+        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            unallocated_encoding(s);
+            return;
+        }
+        if (!fp_access_check(s)) {
+            return;
+        }
+        handle_fp_3src_half(s, o0, o1, rd, rn, rm, ra);
+        break;
     default:
         unallocated_encoding(s);
     }
-- 
2.17.1
