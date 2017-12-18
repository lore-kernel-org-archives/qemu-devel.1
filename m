Received: from eggs.gnu.org ([2001:4830:134:3::10]:37303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3d-0000Xd-Tn
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3Z-0001EI-Ri
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:29 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:40222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3Z-0001DN-J9
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:25 -0500
Received: by mail-pl0-x244.google.com with SMTP id 62so3753503pld.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:47 -0800
Message-Id: <20171218171758.16964-16-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 15/26] target/arm: Use vector infrastructure
 for aa64 compares
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 96 ++++++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 34 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c47faa5633..1ea7e37b03 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7115,6 +7115,28 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
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
@@ -7158,10 +7180,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
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
@@ -9684,6 +9703,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rd = extract32(insn, 0, 5);
     int pass;
     GVecGen3Fn *gvec_op;
+    TCGCond cond;
 
     switch (opcode) {
     case 0x13: /* MUL, PMUL */
@@ -9731,6 +9751,44 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 vec_full_reg_offset(s, rm),
                 is_q ? 16 : 8, vec_full_reg_size(s));
         return;
+    case 0x11:
+        if (u) { /* CMEQ */
+            cond = TCG_COND_EQ;
+            goto do_gvec_cmp;
+        } else { /* CMTST */
+            static const GVecGen3 cmtst_op[4] = {
+                { .fni4 = gen_helper_neon_tst_u8,
+                  .fniv = gen_cmtst_vec,
+                  .vece = MO_8 },
+                { .fni4 = gen_helper_neon_tst_u16,
+                  .fniv = gen_cmtst_vec,
+                  .vece = MO_16 },
+                { .fni4 = gen_cmtst_i32,
+                  .fniv = gen_cmtst_vec,
+                  .vece = MO_32 },
+                { .fni8 = gen_cmtst_i64,
+                  .fniv = gen_cmtst_vec,
+                  .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+                  .vece = MO_64 },
+            };
+            tcg_gen_gvec_3(vec_full_reg_offset(s, rd),
+                           vec_full_reg_offset(s, rn),
+                           vec_full_reg_offset(s, rm),
+                           is_q ? 16 : 8, vec_full_reg_size(s),
+                           &cmtst_op[size]);
+        }
+        return;
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
@@ -9813,26 +9871,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
@@ -9905,16 +9943,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
