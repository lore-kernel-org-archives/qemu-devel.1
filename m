Received: from eggs.gnu.org ([2001:4830:134:3::10]:37474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3k-0000dR-Bi
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3e-0001KP-O9
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:36 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3e-0001JR-DS
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:30 -0500
Received: by mail-pl0-x243.google.com with SMTP id z5so5199466plo.10
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:50 -0800
Message-Id: <20171218171758.16964-19-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 18/26] target/arm: Use vector infrastructure
 for aa64 multiplies
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
 target/arm/translate-a64.c | 171 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 138 insertions(+), 33 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1ea7e37b03..c47d9caa49 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9691,6 +9691,66 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     }
 }
 
+static void gen_mla8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u8(a, a, b);
+    gen_helper_neon_add_u8(d, d, a);
+}
+
+static void gen_mla16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u16(a, a, b);
+    gen_helper_neon_add_u16(d, d, a);
+}
+
+static void gen_mla32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_mul_i32(a, a, b);
+    tcg_gen_add_i32(d, d, a);
+}
+
+static void gen_mla64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_mul_i64(a, a, b);
+    tcg_gen_add_i64(d, d, a);
+}
+
+static void gen_mla_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    tcg_gen_mul_vec(vece, a, a, b);
+    tcg_gen_add_vec(vece, d, d, a);
+}
+
+static void gen_mls8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u8(a, a, b);
+    gen_helper_neon_sub_u8(d, d, a);
+}
+
+static void gen_mls16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u16(a, a, b);
+    gen_helper_neon_sub_u16(d, d, a);
+}
+
+static void gen_mls32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_mul_i32(a, a, b);
+    tcg_gen_sub_i32(d, d, a);
+}
+
+static void gen_mls64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_mul_i64(a, a, b);
+    tcg_gen_sub_i64(d, d, a);
+}
+
+static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    tcg_gen_mul_vec(vece, a, a, b);
+    tcg_gen_sub_vec(vece, d, d, a);
+}
+
 /* Integer op subgroup of C3.6.16. */
 static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 {
@@ -9702,7 +9762,8 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     int pass;
-    GVecGen3Fn *gvec_op;
+    GVecGen3Fn *gvec_fn;
+    const GVecGen3 *gvec_op;
     TCGCond cond;
 
     switch (opcode) {
@@ -9745,12 +9806,70 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0x10: /* ADD, SUB */
-        gvec_op = u ? tcg_gen_gvec_sub : tcg_gen_gvec_add;
-        gvec_op(size, vec_full_reg_offset(s, rd),
+        gvec_fn = u ? tcg_gen_gvec_sub : tcg_gen_gvec_add;
+    do_gvec:
+        gvec_fn(size, vec_full_reg_offset(s, rd),
                 vec_full_reg_offset(s, rn),
                 vec_full_reg_offset(s, rm),
                 is_q ? 16 : 8, vec_full_reg_size(s));
         return;
+    case 0x13: /* MUL, PMUL */
+        if (!u) { /* MUL */
+            gvec_fn = tcg_gen_gvec_mul;
+            goto do_gvec;
+        }
+        break;
+    case 0x12: /* MLA, MLS */
+        {
+            static const GVecGen3 mla_op[4] = {
+                { .fni4 = gen_mla8_i32,
+                  .fniv = gen_mla_vec,
+                  .opc = INDEX_op_mul_vec,
+                  .load_dest = true,
+                  .vece = MO_8 },
+                { .fni4 = gen_mla16_i32,
+                  .fniv = gen_mla_vec,
+                  .opc = INDEX_op_mul_vec,
+                  .load_dest = true,
+                  .vece = MO_16 },
+                { .fni4 = gen_mla32_i32,
+                  .fniv = gen_mla_vec,
+                  .opc = INDEX_op_mul_vec,
+                  .load_dest = true,
+                  .vece = MO_32 },
+                { .fni8 = gen_mla64_i64,
+                  .fniv = gen_mla_vec,
+                  .opc = INDEX_op_mul_vec,
+                  .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+                  .load_dest = true,
+                  .vece = MO_64 },
+            };
+            static const GVecGen3 mls_op[4] = {
+                { .fni4 = gen_mls8_i32,
+                  .fniv = gen_mls_vec,
+                  .opc = INDEX_op_mul_vec,
+                  .load_dest = true,
+                  .vece = MO_8 },
+                { .fni4 = gen_mls16_i32,
+                  .fniv = gen_mls_vec,
+                  .opc = INDEX_op_mul_vec,
+                  .load_dest = true,
+                  .vece = MO_16 },
+                { .fni4 = gen_mls32_i32,
+                  .fniv = gen_mls_vec,
+                  .opc = INDEX_op_mul_vec,
+                  .load_dest = true,
+                  .vece = MO_32 },
+                { .fni8 = gen_mls64_i64,
+                  .fniv = gen_mls_vec,
+                  .opc = INDEX_op_mul_vec,
+                  .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+                  .load_dest = true,
+                  .vece = MO_64 },
+            };
+            gvec_op = (u ? &mls_op[size] : &mla_op[size]);
+        }
+        goto do_gvec_op;
     case 0x11:
         if (u) { /* CMEQ */
             cond = TCG_COND_EQ;
@@ -9771,12 +9890,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                   .prefer_i64 = TCG_TARGET_REG_BITS == 64,
                   .vece = MO_64 },
             };
-            tcg_gen_gvec_3(vec_full_reg_offset(s, rd),
-                           vec_full_reg_offset(s, rn),
-                           vec_full_reg_offset(s, rm),
-                           is_q ? 16 : 8, vec_full_reg_size(s),
-                           &cmtst_op[size]);
+            gvec_op = &cmtst_op[size];
         }
+    do_gvec_op:
+        tcg_gen_gvec_3(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       is_q ? 16 : 8, vec_full_reg_size(s), gvec_op);
         return;
     case 0x06: /* CMGT, CMHI */
         cond = u ? TCG_COND_GTU : TCG_COND_GT;
@@ -9944,23 +10064,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 break;
             }
             case 0x13: /* MUL, PMUL */
-                if (u) {
-                    /* PMUL */
-                    assert(size == 0);
-                    genfn = gen_helper_neon_mul_p8;
-                    break;
-                }
-                /* fall through : MUL */
-            case 0x12: /* MLA, MLS */
-            {
-                static NeonGenTwoOpFn * const fns[3] = {
-                    gen_helper_neon_mul_u8,
-                    gen_helper_neon_mul_u16,
-                    tcg_gen_mul_i32,
-                };
-                genfn = fns[size];
+                assert(u); /* PMUL */
+                assert(size == 0);
+                genfn = gen_helper_neon_mul_p8;
                 break;
-            }
             case 0x16: /* SQDMULH, SQRDMULH */
             {
                 static NeonGenTwoOpEnvFn * const fns[2][2] = {
@@ -9981,18 +10088,16 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn(tcg_res, tcg_op1, tcg_op2);
             }
 
-            if (opcode == 0xf || opcode == 0x12) {
-                /* SABA, UABA, MLA, MLS: accumulating ops */
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_add_u8, gen_helper_neon_sub_u8 },
-                    { gen_helper_neon_add_u16, gen_helper_neon_sub_u16 },
-                    { tcg_gen_add_i32, tcg_gen_sub_i32 },
+            if (opcode == 0xf) {
+                /* SABA, UABA: accumulating ops */
+                static NeonGenTwoOpFn * const fns[3] = {
+                    gen_helper_neon_add_u8,
+                    gen_helper_neon_add_u16,
+                    tcg_gen_add_i32,
                 };
-                bool is_sub = (opcode == 0x12 && u); /* MLS */
 
-                genfn = fns[size][is_sub];
                 read_vec_element_i32(s, tcg_op1, rd, pass, MO_32);
-                genfn(tcg_res, tcg_op1, tcg_res);
+                fns[size](tcg_res, tcg_op1, tcg_res);
             }
 
             write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-- 
2.14.3
