Received: from eggs.gnu.org ([2001:4830:134:3::10]:54504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3W-0003UV-ID
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3V-0006wp-0V
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:18 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejq3U-0006vU-Ly
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:16 -0500
Received: by mail-wm0-x241.google.com with SMTP id r71so10969507wmd.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:32:16 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:56 +0000
Message-Id: <20180208173157.24705-32-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 31/32] arm/translate-a64: implement
 simd_scalar_three_reg_same_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

This covers the encoding group:

  Advanced SIMD scalar three same FP16

As all the helpers are already there it is simply a case of calling the
existing helpers in the scalar context.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - checkpatch fixes
---
 target/arm/translate-a64.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b094399fb4..92adf43a89 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7764,6 +7764,99 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_rd);
 }
 
+/* AdvSIMD scalar three same FP16
+ *  31 30  29 28       24 23  22 21 20  16 15 14 13    11 10  9  5 4  0
+ * +-----+---+-----------+---+-----+------+-----+--------+---+----+----+
+ * | 0 1 | U | 1 1 1 1 0 | a | 1 0 |  Rm  | 0 0 | opcode | 1 | Rn | Rd |
+ * +-----+---+-----------+---+-----+------+-----+--------+---+----+----+
+ * v: 0101 1110 0100 0000 0000 0100 0000 0000 => 5e400400
+ * m: 1101 1111 0110 0000 1100 0100 0000 0000 => df60c400
+ */
+static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s, uint32_t insn)
+{
+    int rd = extract32(insn, 0, 5);
+    int rn = extract32(insn, 5, 5);
+    int opcode = extract32(insn, 11, 3);
+    int rm = extract32(insn, 16, 5);
+    bool u = extract32(insn, 29, 1);
+    bool a = extract32(insn, 23, 1);
+    int fpopcode = opcode | (a << 3) |  (u << 4);
+    TCGv_ptr fpst;
+    TCGv_i32 tcg_op1;
+    TCGv_i32 tcg_op2;
+    TCGv_i32 tcg_res;
+
+    switch (fpopcode) {
+    case 0x03: /* FMULX */
+    case 0x04: /* FCMEQ (reg) */
+    case 0x07: /* FRECPS */
+    case 0x0f: /* FRSQRTS */
+    case 0x14: /* FCMGE (reg) */
+    case 0x15: /* FACGE */
+    case 0x1a: /* FABD */
+    case 0x1c: /* FCMGT (reg) */
+    case 0x1d: /* FACGT */
+        break;
+    default:
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (!fp_access_check(s)) {
+        return;
+    }
+
+    fpst = get_fpstatus_ptr(true);
+
+    tcg_op1 = tcg_temp_new_i32();
+    tcg_op2 = tcg_temp_new_i32();
+    tcg_res = tcg_temp_new_i32();
+
+    read_vec_element_i32(s, tcg_op1, rn, 0, MO_16);
+    read_vec_element_i32(s, tcg_op2, rm, 0, MO_16);
+
+    switch (fpopcode) {
+    case 0x03: /* FMULX */
+        gen_helper_advsimd_mulxh(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x04: /* FCMEQ (reg) */
+        gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x07: /* FRECPS */
+        gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x0f: /* FRSQRTS */
+        gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x14: /* FCMGE (reg) */
+        gen_helper_advsimd_cge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x15: /* FACGE */
+        gen_helper_advsimd_acge_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x1a: /* FABD */
+        gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
+        gen_helper_advsimd_absh(tcg_res, tcg_res);
+        break;
+    case 0x1c: /* FCMGT (reg) */
+        gen_helper_advsimd_cgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    case 0x1d: /* FACGT */
+        gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    write_fp_sreg(s, rd, tcg_res);
+
+
+    tcg_temp_free_i32(tcg_res);
+    tcg_temp_free_i32(tcg_op1);
+    tcg_temp_free_i32(tcg_op2);
+    tcg_temp_free_ptr(fpst);
+}
+
 static void handle_2misc_64(DisasContext *s, int opcode, bool u,
                             TCGv_i64 tcg_rd, TCGv_i64 tcg_rn,
                             TCGv_i32 tcg_rmode, TCGv_ptr tcg_fpstatus)
@@ -9991,6 +10084,8 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_minh(tcg_res[pass], tcg_op1, tcg_op2, fpst);
                 break;
             default:
+                fprintf(stderr, "%s: insn %#04x, fpop %#2x @ %#" PRIx64 "\n",
+                        __func__, insn, fpopcode, s->pc);
                 g_assert_not_reached();
             }
         }
@@ -11868,6 +11963,7 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e280800, 0xff3e0c00, disas_crypto_two_reg_sha },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
+    { 0x5e400400, 0xdf60c400, disas_simd_scalar_three_reg_same_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.15.1
