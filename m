Received: from eggs.gnu.org ([2001:4830:134:3::10]:37583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdP-0007V4-C9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdM-00055e-2p
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:11 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejYdL-00055K-QG
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:08 -0500
Received: by mail-pl0-x243.google.com with SMTP id 11-v6so975386plc.9
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 14:56:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  7 Feb 2018 14:55:36 -0800
Message-Id: <20180207225540.31698-17-richard.henderson@linaro.org>
In-Reply-To: <20180207225540.31698-1-richard.henderson@linaro.org>
References: <20180207225540.31698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/20] target/arm: Use vector infrastructure for
 aa64 compares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 93 +++++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 34 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5717e85def..2ac297fc14 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7209,6 +7209,28 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
+/* CMTST : test is "if (X & Y != 0)". */
+static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_and_i32(d, a, b);
+    tcg_gen_setcondi_i32(TCG_COND_NE, d, d, 0);
+    tcg_gen_neg_i32(d, d);
+}
+
+static void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
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
 static void handle_3same_64(DisasContext *s, int opcode, bool u,
                             TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 tcg_rm)
 {
@@ -7252,10 +7274,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
             cond = TCG_COND_EQ;
             goto do_cmop;
         }
-        /* CMTST : test is "if (X & Y != 0)". */
-        tcg_gen_and_i64(tcg_rd, tcg_rn, tcg_rm);
-        tcg_gen_setcondi_i64(TCG_COND_NE, tcg_rd, tcg_rd, 0);
-        tcg_gen_neg_i64(tcg_rd, tcg_rd);
+        gen_cmtst_i64(tcg_rd, tcg_rn, tcg_rm);
         break;
     case 0x8: /* SSHL, USHL */
         if (u) {
@@ -9733,6 +9752,22 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
 /* Integer op subgroup of C3.6.16. */
 static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 {
+    static const GVecGen3 cmtst_op[4] = {
+        { .fni4 = gen_helper_neon_tst_u8,
+          .fniv = gen_cmtst_vec,
+          .vece = MO_8 },
+        { .fni4 = gen_helper_neon_tst_u16,
+          .fniv = gen_cmtst_vec,
+          .vece = MO_16 },
+        { .fni4 = gen_cmtst_i32,
+          .fniv = gen_cmtst_vec,
+          .vece = MO_32 },
+        { .fni8 = gen_cmtst_i64,
+          .fniv = gen_cmtst_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
     int is_q = extract32(insn, 30, 1);
     int u = extract32(insn, 29, 1);
     int size = extract32(insn, 22, 2);
@@ -9741,6 +9776,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     int pass;
+    TCGCond cond;
 
     switch (opcode) {
     case 0x13: /* MUL, PMUL */
@@ -9788,6 +9824,25 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_add, size);
         }
         return;
+    case 0x11:
+        if (!u) { /* CMTST */
+            gen_gvec_op3(s, is_q, rd, rn, rm, &cmtst_op[size]);
+            return;
+        }
+        /* else CMEQ */
+        cond = TCG_COND_EQ;
+        goto do_gvec_cmp;
+    case 0x06: /* CMGT, CMHI */
+        cond = u ? TCG_COND_GTU : TCG_COND_GT;
+        goto do_gvec_cmp;
+    case 0x07: /* CMGE, CMHS */
+        cond = u ? TCG_COND_GEU : TCG_COND_GE;
+    do_gvec_cmp:
+        tcg_gen_gvec_cmp(cond, size, vec_full_reg_offset(s, rd),
+                         vec_full_reg_offset(s, rn),
+                         vec_full_reg_offset(s, rm),
+                         is_q ? 16 : 8, vec_full_reg_size(s));
+        return;
     }
 
     if (size == 3) {
@@ -9870,26 +9925,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genenvfn = fns[size][u];
                 break;
             }
-            case 0x6: /* CMGT, CMHI */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_cgt_s8, gen_helper_neon_cgt_u8 },
-                    { gen_helper_neon_cgt_s16, gen_helper_neon_cgt_u16 },
-                    { gen_helper_neon_cgt_s32, gen_helper_neon_cgt_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
-            case 0x7: /* CMGE, CMHS */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_cge_s8, gen_helper_neon_cge_u8 },
-                    { gen_helper_neon_cge_s16, gen_helper_neon_cge_u16 },
-                    { gen_helper_neon_cge_s32, gen_helper_neon_cge_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             case 0x8: /* SSHL, USHL */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
@@ -9962,16 +9997,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x11: /* CMTST, CMEQ */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_tst_u8, gen_helper_neon_ceq_u8 },
-                    { gen_helper_neon_tst_u16, gen_helper_neon_ceq_u16 },
-                    { gen_helper_neon_tst_u32, gen_helper_neon_ceq_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             case 0x13: /* MUL, PMUL */
                 if (u) {
                     /* PMUL */
-- 
2.14.3
