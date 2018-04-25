Received: from eggs.gnu.org ([2001:4830:134:3::10]:55477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB99Y-00046m-2Q
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB99W-0007Wm-KN
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:23:24 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB99W-0007W1-DX
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:23:22 -0400
Received: by mail-pf0-x243.google.com with SMTP id a14so3243818pfi.1
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 18:23:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 24 Apr 2018 15:22:59 -1000
Message-Id: <20180425012300.14698-9-richard.henderson@linaro.org>
In-Reply-To: <20180425012300.14698-1-richard.henderson@linaro.org>
References: <20180425012300.14698-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 8/9] target/arm: Implement FP data-processing
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

We missed all of the scalar fp16 binary operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 794ede7222..11b90b7eb0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -532,6 +532,14 @@ static TCGv_i32 read_fp_sreg(DisasContext *s, int reg)
     return v;
 }
 
+static TCGv_i32 read_fp_hreg(DisasContext *s, int reg)
+{
+    TCGv_i32 v = tcg_temp_new_i32();
+
+    tcg_gen_ld16u_i32(v, cpu_env, fp_reg_offset(s, reg, MO_16));
+    return v;
+}
+
 /* Clear the bits above an N-bit vector, for N = (is_q ? 128 : 64).
  * If SVE is not enabled, then there are only 128 bits in the vector.
  */
@@ -4968,6 +4976,61 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
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
@@ -5000,6 +5063,16 @@ static void disas_fp_2src(DisasContext *s, uint32_t insn)
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
