Received: from eggs.gnu.org ([2001:4830:134:3::10]:37586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdP-0007V9-De
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdK-00054l-O7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:11 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:46280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejYdK-00054L-FM
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:06 -0500
Received: by mail-pg0-x241.google.com with SMTP id a11so894322pgu.13
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 14:56:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  7 Feb 2018 14:55:35 -0800
Message-Id: <20180207225540.31698-16-richard.henderson@linaro.org>
In-Reply-To: <20180207225540.31698-1-richard.henderson@linaro.org>
References: <20180207225540.31698-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 15/20] target/arm: Use vector infrastructure for
 aa64 constant shifts
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 419 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 346 insertions(+), 73 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 48088dbb29..5717e85def 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -87,6 +87,8 @@ typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
 
 /* Note that the gvec expanders operate on offsets + sizes.  */
 typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
+typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t, int64_t,
+                         uint32_t, uint32_t);
 typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 
@@ -640,6 +642,16 @@ static void gen_gvec_fn2(DisasContext *s, bool is_q, int rd, int rn,
             is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
+/* Expand a 2-operand + immediate AdvSIMD vector operation using
+ * an expander function.
+ */
+static void gen_gvec_fn2i(DisasContext *s, bool is_q, int rd, int rn,
+                          int64_t imm, GVecGen2iFn *gvec_fn, int vece)
+{
+    gvec_fn(vece, vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
+            imm, is_q ? 16 : 8, vec_full_reg_size(s));
+}
+
 /* Expand a 3-operand AdvSIMD vector operation using an expander function.  */
 static void gen_gvec_fn3(DisasContext *s, bool is_q, int rd, int rn, int rm,
                          GVecGen3Fn *gvec_fn, int vece)
@@ -648,6 +660,16 @@ static void gen_gvec_fn3(DisasContext *s, bool is_q, int rd, int rn, int rm,
             vec_full_reg_offset(s, rm), is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
+/* Expand a 2-operand + immediate AdvSIMD vector operation using
+ * an op descriptor.
+ */
+static void gen_gvec_op2i(DisasContext *s, bool is_q, int rd,
+                          int rn, int64_t imm, const GVecGen2i *gvec_op)
+{
+    tcg_gen_gvec_2i(vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
+                    is_q ? 16 : 8, vec_full_reg_size(s), imm, gvec_op);
+}
+
 /* Expand a 3-operand AdvSIMD vector operation using an op descriptor.  */
 static void gen_gvec_op3(DisasContext *s, bool is_q, int rd,
                          int rn, int rm, const GVecGen3 *gvec_op)
@@ -6512,32 +6534,6 @@ static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
     }
 }
 
-/* Common SHL/SLI - Shift left with an optional insert */
-static void handle_shli_with_ins(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
-                                 bool insert, int shift)
-{
-    if (insert) { /* SLI */
-        tcg_gen_deposit_i64(tcg_res, tcg_res, tcg_src, shift, 64 - shift);
-    } else { /* SHL */
-        tcg_gen_shli_i64(tcg_res, tcg_src, shift);
-    }
-}
-
-/* SRI: shift right with insert */
-static void handle_shri_with_ins(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
-                                 int size, int shift)
-{
-    int esize = 8 << size;
-
-    /* shift count same as element size is valid but does nothing;
-     * special case to avoid potential shift by 64.
-     */
-    if (shift != esize) {
-        tcg_gen_shri_i64(tcg_src, tcg_src, shift);
-        tcg_gen_deposit_i64(tcg_res, tcg_res, tcg_src, 0, esize - shift);
-    }
-}
-
 /* SSHR[RA]/USHR[RA] - Scalar shift right (optional rounding/accumulate) */
 static void handle_scalar_simd_shri(DisasContext *s,
                                     bool is_u, int immh, int immb,
@@ -6588,7 +6584,14 @@ static void handle_scalar_simd_shri(DisasContext *s,
     tcg_rd = (accumulate || insert) ? read_fp_dreg(s, rd) : tcg_temp_new_i64();
 
     if (insert) {
-        handle_shri_with_ins(tcg_rd, tcg_rn, size, shift);
+        /* shift count same as element size is valid but does nothing;
+         * special case to avoid potential shift by 64.
+         */
+        int esize = 8 << size;
+        if (shift != esize) {
+            tcg_gen_shri_i64(tcg_rn, tcg_rn, shift);
+            tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, 0, esize - shift);
+        }
     } else {
         handle_shri_with_rndacc(tcg_rd, tcg_rn, tcg_round,
                                 accumulate, is_u, size, shift);
@@ -6626,7 +6629,11 @@ static void handle_scalar_simd_shli(DisasContext *s, bool insert,
     tcg_rn = read_fp_dreg(s, rn);
     tcg_rd = insert ? read_fp_dreg(s, rd) : tcg_temp_new_i64();
 
-    handle_shli_with_ins(tcg_rd, tcg_rn, insert, shift);
+    if (insert) {
+        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, shift, 64 - shift);
+    } else {
+        tcg_gen_shli_i64(tcg_rd, tcg_rn, shift);
+    }
 
     write_fp_dreg(s, rd, tcg_rd);
 
@@ -8356,16 +8363,195 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
+static void gen_ssra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_sar8i_i64(a, a, shift);
+    tcg_gen_vec_add8_i64(d, d, a);
+}
+
+static void gen_ssra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_sar16i_i64(a, a, shift);
+    tcg_gen_vec_add16_i64(d, d, a);
+}
+
+static void gen_ssra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_sari_i32(a, a, shift);
+    tcg_gen_add_i32(d, d, a);
+}
+
+static void gen_ssra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_sari_i64(a, a, shift);
+    tcg_gen_add_i64(d, d, a);
+}
+
+static void gen_ssra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    tcg_gen_sari_vec(vece, a, a, sh);
+    tcg_gen_add_vec(vece, d, d, a);
+}
+
+static void gen_usra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_shr8i_i64(a, a, shift);
+    tcg_gen_vec_add8_i64(d, d, a);
+}
+
+static void gen_usra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_vec_shr16i_i64(a, a, shift);
+    tcg_gen_vec_add16_i64(d, d, a);
+}
+
+static void gen_usra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_shri_i32(a, a, shift);
+    tcg_gen_add_i32(d, d, a);
+}
+
+static void gen_usra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_shri_i64(a, a, shift);
+    tcg_gen_add_i64(d, d, a);
+}
+
+static void gen_usra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    tcg_gen_shri_vec(vece, a, a, sh);
+    tcg_gen_add_vec(vece, d, d, a);
+}
+
+static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = dup_const(MO_8, 0xff >> shift);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_shr16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = dup_const(MO_16, 0xffff >> shift);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_shr32_ins_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_shri_i32(a, a, shift);
+    tcg_gen_deposit_i32(d, d, a, 0, 32 - shift);
+}
+
+static void gen_shr64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_shri_i64(a, a, shift);
+    tcg_gen_deposit_i64(d, d, a, 0, 64 - shift);
+}
+
+static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    uint64_t mask = (2ull << ((8 << vece) - 1)) - 1;
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_dupi_vec(vece, m, mask ^ (mask >> sh));
+    tcg_gen_shri_vec(vece, t, a, sh);
+    tcg_gen_and_vec(vece, d, d, m);
+    tcg_gen_or_vec(vece, d, d, t);
+
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(m);
+}
+
 /* SSHR[RA]/USHR[RA] - Vector shift right (optional rounding/accumulate) */
 static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
                                  int immh, int immb, int opcode, int rn, int rd)
 {
+    static const GVecGen2i ssra_op[4] = {
+        { .fni8 = gen_ssra8_i64,
+          .fniv = gen_ssra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_8 },
+        { .fni8 = gen_ssra16_i64,
+          .fniv = gen_ssra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_16 },
+        { .fni4 = gen_ssra32_i32,
+          .fniv = gen_ssra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_32 },
+        { .fni8 = gen_ssra64_i64,
+          .fniv = gen_ssra_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opc = INDEX_op_sari_vec,
+          .vece = MO_64 },
+    };
+    static const GVecGen2i usra_op[4] = {
+        { .fni8 = gen_usra8_i64,
+          .fniv = gen_usra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_8, },
+        { .fni8 = gen_usra16_i64,
+          .fniv = gen_usra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_16, },
+        { .fni4 = gen_usra32_i32,
+          .fniv = gen_usra_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_32, },
+        { .fni8 = gen_usra64_i64,
+          .fniv = gen_usra_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_64, },
+    };
+    static const GVecGen2i sri_op[4] = {
+        { .fni8 = gen_shr8_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_8 },
+        { .fni8 = gen_shr16_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_16 },
+        { .fni4 = gen_shr32_ins_i32,
+          .fniv = gen_shr_ins_vec,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_32 },
+        { .fni8 = gen_shr64_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opc = INDEX_op_shri_vec,
+          .vece = MO_64 },
+    };
+
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = 2 * (8 << size) - immhb;
     bool accumulate = false;
-    bool round = false;
-    bool insert = false;
     int dsize = is_q ? 128 : 64;
     int esize = 8 << size;
     int elements = dsize/esize;
@@ -8373,6 +8559,7 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
     TCGv_i64 tcg_rn = new_tmp_a64(s);
     TCGv_i64 tcg_rd = new_tmp_a64(s);
     TCGv_i64 tcg_round;
+    uint64_t round_const;
     int i;
 
     if (extract32(immh, 3, 1) && !is_q) {
@@ -8391,64 +8578,159 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
 
     switch (opcode) {
     case 0x02: /* SSRA / USRA (accumulate) */
-        accumulate = true;
-        break;
+        if (is_u) {
+            /* Shift count same as element size produces zero to add.  */
+            if (shift == 8 << size) {
+                goto done;
+            }
+            gen_gvec_op2i(s, is_q, rd, rn, shift, &usra_op[size]);
+        } else {
+            /* Shift count same as element size produces all sign to add.  */
+            if (shift == 8 << size) {
+                shift -= 1;
+            }
+            gen_gvec_op2i(s, is_q, rd, rn, shift, &ssra_op[size]);
+        }
+        return;
+    case 0x08: /* SRI */
+        /* Shift count same as element size is valid but does nothing.  */
+        if (shift == 8 << size) {
+            goto done;
+        }
+        gen_gvec_op2i(s, is_q, rd, rn, shift, &sri_op[size]);
+        return;
+
+    case 0x00: /* SSHR / USHR */
+        if (is_u) {
+            if (shift == 8 << size) {
+                /* Shift count the same size as element size produces zero.  */
+                tcg_gen_gvec_dup8i(vec_full_reg_offset(s, rd),
+                                   is_q ? 16 : 8, vec_full_reg_size(s), 0);
+            } else {
+                gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shri, size);
+            }
+        } else {
+            /* Shift count the same size as element size produces all sign.  */
+            if (shift == 8 << size) {
+                shift -= 1;
+            }
+            gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_sari, size);
+        }
+        return;
+
     case 0x04: /* SRSHR / URSHR (rounding) */
-        round = true;
         break;
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        accumulate = round = true;
-        break;
-    case 0x08: /* SRI */
-        insert = true;
+        accumulate = true;
         break;
+    default:
+        g_assert_not_reached();
     }
 
-    if (round) {
-        uint64_t round_const = 1ULL << (shift - 1);
-        tcg_round = tcg_const_i64(round_const);
-    } else {
-        tcg_round = NULL;
-    }
+    round_const = 1ULL << (shift - 1);
+    tcg_round = tcg_const_i64(round_const);
 
     for (i = 0; i < elements; i++) {
         read_vec_element(s, tcg_rn, rn, i, memop);
-        if (accumulate || insert) {
+        if (accumulate) {
             read_vec_element(s, tcg_rd, rd, i, memop);
         }
 
-        if (insert) {
-            handle_shri_with_ins(tcg_rd, tcg_rn, size, shift);
-        } else {
-            handle_shri_with_rndacc(tcg_rd, tcg_rn, tcg_round,
-                                    accumulate, is_u, size, shift);
-        }
+        handle_shri_with_rndacc(tcg_rd, tcg_rn, tcg_round,
+                                accumulate, is_u, size, shift);
 
         write_vec_element(s, tcg_rd, rd, i, size);
     }
+    tcg_temp_free_i64(tcg_round);
 
+ done:
     if (!is_q) {
         clear_vec_high(s, rd);
     }
+}
 
-    if (round) {
-        tcg_temp_free_i64(tcg_round);
-    }
+static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = dup_const(MO_8, 0xff << shift);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shli_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_shl16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    uint64_t mask = dup_const(MO_16, 0xffff << shift);
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_shli_i64(t, a, shift);
+    tcg_gen_andi_i64(t, t, mask);
+    tcg_gen_andi_i64(d, d, ~mask);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_shl32_ins_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
+{
+    tcg_gen_deposit_i32(d, d, a, shift, 32 - shift);
+}
+
+static void gen_shl64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
+{
+    tcg_gen_deposit_i64(d, d, a, shift, 64 - shift);
+}
+
+static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
+{
+    uint64_t mask = (1ull << sh) - 1;
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_dupi_vec(vece, m, mask);
+    tcg_gen_shli_vec(vece, t, a, sh);
+    tcg_gen_and_vec(vece, d, d, m);
+    tcg_gen_or_vec(vece, d, d, t);
+
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(m);
 }
 
 /* SHL/SLI - Vector shift left */
 static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
-                                int immh, int immb, int opcode, int rn, int rd)
+                                 int immh, int immb, int opcode, int rn, int rd)
 {
+    static const GVecGen2i shi_op[4] = {
+        { .fni8 = gen_shl8_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .opc = INDEX_op_shli_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fni8 = gen_shl16_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .opc = INDEX_op_shli_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_shl32_ins_i32,
+          .fniv = gen_shl_ins_vec,
+          .opc = INDEX_op_shli_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_shl64_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .opc = INDEX_op_shli_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = immhb - (8 << size);
-    int dsize = is_q ? 128 : 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    TCGv_i64 tcg_rn = new_tmp_a64(s);
-    TCGv_i64 tcg_rd = new_tmp_a64(s);
-    int i;
 
     if (extract32(immh, 3, 1) && !is_q) {
         unallocated_encoding(s);
@@ -8464,19 +8746,10 @@ static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
         return;
     }
 
-    for (i = 0; i < elements; i++) {
-        read_vec_element(s, tcg_rn, rn, i, size);
-        if (insert) {
-            read_vec_element(s, tcg_rd, rd, i, size);
-        }
-
-        handle_shli_with_ins(tcg_rd, tcg_rn, insert, shift);
-
-        write_vec_element(s, tcg_rd, rd, i, size);
-    }
-
-    if (!is_q) {
-        clear_vec_high(s, rd);
+    if (insert) {
+        gen_gvec_op2i(s, is_q, rd, rn, shift, &shi_op[size]);
+    } else {
+        gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shli, size);
     }
 }
 
-- 
2.14.3
