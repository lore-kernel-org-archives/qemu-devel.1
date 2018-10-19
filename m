Received: from eggs.gnu.org ([2001:4830:134:3::10]:48064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY78-0002Z2-HD
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY77-0003vb-An
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY77-0002Jh-1F
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:05 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6H-0006nz-Bp
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:27 +0100
Message-Id: <20181019165735.22511-38-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/45] target/arm: Use gvec for
 NEON_3R_VTST_VCEQ, NEON_3R_VCGT, NEON_3R_VCGE
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

Move cmtst_op expanders from translate-a64.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181011205206.3552-17-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h     |  2 +
 target/arm/translate-a64.c | 38 ------------------
 target/arm/translate.c     | 81 +++++++++++++++++++++++++++-----------
 3 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 1b4703dc6e7..1550aa8bc7f 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -198,10 +198,12 @@ extern const GVecGen3 bit_op;
 extern const GVecGen3 bif_op;
 extern const GVecGen3 mla_op[4];
 extern const GVecGen3 mls_op[4];
+extern const GVecGen3 cmtst_op[4];
 extern const GVecGen2i ssra_op[4];
 extern const GVecGen2i usra_op[4];
 extern const GVecGen2i sri_op[4];
 extern const GVecGen2i sli_op[4];
+void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fd4d8072da2..a41f180a97d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -8031,28 +8031,6 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-/* CMTST : test is "if (X & Y != 0)". */
-static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    tcg_gen_and_i32(d, a, b);
-    tcg_gen_setcondi_i32(TCG_COND_NE, d, d, 0);
-    tcg_gen_neg_i32(d, d);
-}
-
-static void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    tcg_gen_and_i64(d, a, b);
-    tcg_gen_setcondi_i64(TCG_COND_NE, d, d, 0);
-    tcg_gen_neg_i64(d, d);
-}
-
-static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-{
-    tcg_gen_and_vec(vece, d, a, b);
-    tcg_gen_dupi_vec(vece, a, 0);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
-}
-
 static void handle_3same_64(DisasContext *s, int opcode, bool u,
                             TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 tcg_rm)
 {
@@ -10413,22 +10391,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
 /* Integer op subgroup of C3.6.16. */
 static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 {
-    static const GVecGen3 cmtst_op[4] = {
-        { .fni4 = gen_helper_neon_tst_u8,
-          .fniv = gen_cmtst_vec,
-          .vece = MO_8 },
-        { .fni4 = gen_helper_neon_tst_u16,
-          .fniv = gen_cmtst_vec,
-          .vece = MO_16 },
-        { .fni4 = gen_cmtst_i32,
-          .fniv = gen_cmtst_vec,
-          .vece = MO_32 },
-        { .fni8 = gen_cmtst_i64,
-          .fniv = gen_cmtst_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .vece = MO_64 },
-    };
-
     int is_q = extract32(insn, 30, 1);
     int u = extract32(insn, 29, 1);
     int size = extract32(insn, 22, 2);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d4eb66fadd6..e6b06910369 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6143,6 +6143,44 @@ const GVecGen3 mls_op[4] = {
       .vece = MO_64 },
 };
 
+/* CMTST : test is "if (X & Y != 0)". */
+static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_and_i32(d, a, b);
+    tcg_gen_setcondi_i32(TCG_COND_NE, d, d, 0);
+    tcg_gen_neg_i32(d, d);
+}
+
+void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_and_i64(d, a, b);
+    tcg_gen_setcondi_i64(TCG_COND_NE, d, d, 0);
+    tcg_gen_neg_i64(d, d);
+}
+
+static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    tcg_gen_and_vec(vece, d, a, b);
+    tcg_gen_dupi_vec(vece, a, 0);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
+}
+
+const GVecGen3 cmtst_op[4] = {
+    { .fni4 = gen_helper_neon_tst_u8,
+      .fniv = gen_cmtst_vec,
+      .vece = MO_8 },
+    { .fni4 = gen_helper_neon_tst_u16,
+      .fniv = gen_cmtst_vec,
+      .vece = MO_16 },
+    { .fni4 = gen_cmtst_i32,
+      .fniv = gen_cmtst_vec,
+      .vece = MO_32 },
+    { .fni8 = gen_cmtst_i64,
+      .fniv = gen_cmtst_vec,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .vece = MO_64 },
+};
+
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
    We process data in a mixture of 32-bit and 64-bit chunks.
@@ -6349,6 +6387,26 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
                            u ? &mls_op[size] : &mla_op[size]);
             return 0;
+
+        case NEON_3R_VTST_VCEQ:
+            if (u) { /* VCEQ */
+                tcg_gen_gvec_cmp(TCG_COND_EQ, size, rd_ofs, rn_ofs, rm_ofs,
+                                 vec_size, vec_size);
+            } else { /* VTST */
+                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
+                               vec_size, vec_size, &cmtst_op[size]);
+            }
+            return 0;
+
+        case NEON_3R_VCGT:
+            tcg_gen_gvec_cmp(u ? TCG_COND_GTU : TCG_COND_GT, size,
+                             rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
+            return 0;
+
+        case NEON_3R_VCGE:
+            tcg_gen_gvec_cmp(u ? TCG_COND_GEU : TCG_COND_GE, size,
+                             rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
+            return 0;
         }
 
         if (size == 3) {
@@ -6502,12 +6560,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQSUB:
             GEN_NEON_INTEGER_OP_ENV(qsub);
             break;
-        case NEON_3R_VCGT:
-            GEN_NEON_INTEGER_OP(cgt);
-            break;
-        case NEON_3R_VCGE:
-            GEN_NEON_INTEGER_OP(cge);
-            break;
         case NEON_3R_VSHL:
             GEN_NEON_INTEGER_OP(shl);
             break;
@@ -6535,23 +6587,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rd, pass);
             gen_neon_add(size, tmp, tmp2);
             break;
-        case NEON_3R_VTST_VCEQ:
-            if (!u) { /* VTST */
-                switch (size) {
-                case 0: gen_helper_neon_tst_u8(tmp, tmp, tmp2); break;
-                case 1: gen_helper_neon_tst_u16(tmp, tmp, tmp2); break;
-                case 2: gen_helper_neon_tst_u32(tmp, tmp, tmp2); break;
-                default: abort();
-                }
-            } else { /* VCEQ */
-                switch (size) {
-                case 0: gen_helper_neon_ceq_u8(tmp, tmp, tmp2); break;
-                case 1: gen_helper_neon_ceq_u16(tmp, tmp, tmp2); break;
-                case 2: gen_helper_neon_ceq_u32(tmp, tmp, tmp2); break;
-                default: abort();
-                }
-            }
-            break;
         case NEON_3R_VMUL:
             /* VMUL.P8; other cases already eliminated.  */
             gen_helper_neon_mul_p8(tmp, tmp, tmp2);
-- 
2.19.1
