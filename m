Received: from eggs.gnu.org ([2001:4830:134:3::10]:45141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwo-0006qQ-8R
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwl-0005wG-Jk
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:42 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwl-00055K-17
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:39 -0400
Received: by mail-pg1-x542.google.com with SMTP id a5-v6so4715096pgv.13
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:52:00 -0700
Message-Id: <20181011205206.3552-15-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 14/20] target/arm: Use gvec for VSRI, VSLI
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

Move shi_op and sli_op expanders from translate-a64.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |   2 +
 target/arm/translate-a64.c | 152 +----------------------
 target/arm/translate.c     | 244 ++++++++++++++++++++++++++-----------
 3 files changed, 179 insertions(+), 219 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 8487b349ef..ef44f0a5e5 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -197,6 +197,8 @@ extern const GVecGen3 bit_op;
 extern const GVecGen3 bif_op;
 extern const GVecGen2i ssra_op[4];
 extern const GVecGen2i usra_op[4];
+extern const GVecGen2i sri_op[4];
+extern const GVecGen2i sli_op[4];
 
 #define FORWARD_FEATURE(NAME) \
     static inline bool aa32_dc_feature_##NAME(DisasContext *dc) \
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1a9ae6d5f4..f47c132e6c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9392,85 +9392,10 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    uint64_t mask = dup_const(MO_8, 0xff >> shift);
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(t, a, shift);
-    tcg_gen_andi_i64(t, t, mask);
-    tcg_gen_andi_i64(d, d, ~mask);
-    tcg_gen_or_i64(d, d, t);
-    tcg_temp_free_i64(t);
-}
-
-static void gen_shr16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    uint64_t mask = dup_const(MO_16, 0xffff >> shift);
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(t, a, shift);
-    tcg_gen_andi_i64(t, t, mask);
-    tcg_gen_andi_i64(d, d, ~mask);
-    tcg_gen_or_i64(d, d, t);
-    tcg_temp_free_i64(t);
-}
-
-static void gen_shr32_ins_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
-{
-    tcg_gen_shri_i32(a, a, shift);
-    tcg_gen_deposit_i32(d, d, a, 0, 32 - shift);
-}
-
-static void gen_shr64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_shri_i64(a, a, shift);
-    tcg_gen_deposit_i64(d, d, a, 0, 64 - shift);
-}
-
-static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    uint64_t mask = (2ull << ((8 << vece) - 1)) - 1;
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec m = tcg_temp_new_vec_matching(d);
-
-    tcg_gen_dupi_vec(vece, m, mask ^ (mask >> sh));
-    tcg_gen_shri_vec(vece, t, a, sh);
-    tcg_gen_and_vec(vece, d, d, m);
-    tcg_gen_or_vec(vece, d, d, t);
-
-    tcg_temp_free_vec(t);
-    tcg_temp_free_vec(m);
-}
-
 /* SSHR[RA]/USHR[RA] - Vector shift right (optional rounding/accumulate) */
 static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
                                  int immh, int immb, int opcode, int rn, int rd)
 {
-    static const GVecGen2i sri_op[4] = {
-        { .fni8 = gen_shr8_ins_i64,
-          .fniv = gen_shr_ins_vec,
-          .load_dest = true,
-          .opc = INDEX_op_shri_vec,
-          .vece = MO_8 },
-        { .fni8 = gen_shr16_ins_i64,
-          .fniv = gen_shr_ins_vec,
-          .load_dest = true,
-          .opc = INDEX_op_shri_vec,
-          .vece = MO_16 },
-        { .fni4 = gen_shr32_ins_i32,
-          .fniv = gen_shr_ins_vec,
-          .load_dest = true,
-          .opc = INDEX_op_shri_vec,
-          .vece = MO_32 },
-        { .fni8 = gen_shr64_ins_i64,
-          .fniv = gen_shr_ins_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .opc = INDEX_op_shri_vec,
-          .vece = MO_64 },
-    };
-
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = 2 * (8 << size) - immhb;
@@ -9566,85 +9491,10 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
     clear_vec_high(s, is_q, rd);
 }
 
-static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    uint64_t mask = dup_const(MO_8, 0xff << shift);
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shli_i64(t, a, shift);
-    tcg_gen_andi_i64(t, t, mask);
-    tcg_gen_andi_i64(d, d, ~mask);
-    tcg_gen_or_i64(d, d, t);
-    tcg_temp_free_i64(t);
-}
-
-static void gen_shl16_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    uint64_t mask = dup_const(MO_16, 0xffff << shift);
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    tcg_gen_shli_i64(t, a, shift);
-    tcg_gen_andi_i64(t, t, mask);
-    tcg_gen_andi_i64(d, d, ~mask);
-    tcg_gen_or_i64(d, d, t);
-    tcg_temp_free_i64(t);
-}
-
-static void gen_shl32_ins_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
-{
-    tcg_gen_deposit_i32(d, d, a, shift, 32 - shift);
-}
-
-static void gen_shl64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_deposit_i64(d, d, a, shift, 64 - shift);
-}
-
-static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    uint64_t mask = (1ull << sh) - 1;
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-    TCGv_vec m = tcg_temp_new_vec_matching(d);
-
-    tcg_gen_dupi_vec(vece, m, mask);
-    tcg_gen_shli_vec(vece, t, a, sh);
-    tcg_gen_and_vec(vece, d, d, m);
-    tcg_gen_or_vec(vece, d, d, t);
-
-    tcg_temp_free_vec(t);
-    tcg_temp_free_vec(m);
-}
-
 /* SHL/SLI - Vector shift left */
 static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
                                  int immh, int immb, int opcode, int rn, int rd)
 {
-    static const GVecGen2i shi_op[4] = {
-        { .fni8 = gen_shl8_ins_i64,
-          .fniv = gen_shl_ins_vec,
-          .opc = INDEX_op_shli_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .vece = MO_8 },
-        { .fni8 = gen_shl16_ins_i64,
-          .fniv = gen_shl_ins_vec,
-          .opc = INDEX_op_shli_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .vece = MO_16 },
-        { .fni4 = gen_shl32_ins_i32,
-          .fniv = gen_shl_ins_vec,
-          .opc = INDEX_op_shli_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .vece = MO_32 },
-        { .fni8 = gen_shl64_ins_i64,
-          .fniv = gen_shl_ins_vec,
-          .opc = INDEX_op_shli_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .vece = MO_64 },
-    };
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = immhb - (8 << size);
@@ -9664,7 +9514,7 @@ static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
     }
 
     if (insert) {
-        gen_gvec_op2i(s, is_q, rd, rn, shift, &shi_op[size]);
+        gen_gvec_op2i(s, is_q, rd, rn, shift, &sli_op[size]);
     } else {
         gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shli, size);
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index da95851370..104b49543d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5878,6 +5878,160 @@ const GVecGen2i usra_op[4] = {
       .vece = MO_64, },
 };
 
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
+    if (sh == 0) {
+        tcg_gen_mov_vec(d, a);
+    } else {
+        TCGv_vec t = tcg_temp_new_vec_matching(d);
+        TCGv_vec m = tcg_temp_new_vec_matching(d);
+
+        tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK((8 << vece) - sh, sh));
+        tcg_gen_shri_vec(vece, t, a, sh);
+        tcg_gen_and_vec(vece, d, d, m);
+        tcg_gen_or_vec(vece, d, d, t);
+
+        tcg_temp_free_vec(t);
+        tcg_temp_free_vec(m);
+    }
+}
+
+const GVecGen2i sri_op[4] = {
+    { .fni8 = gen_shr8_ins_i64,
+      .fniv = gen_shr_ins_vec,
+      .load_dest = true,
+      .opc = INDEX_op_shri_vec,
+      .vece = MO_8 },
+    { .fni8 = gen_shr16_ins_i64,
+      .fniv = gen_shr_ins_vec,
+      .load_dest = true,
+      .opc = INDEX_op_shri_vec,
+      .vece = MO_16 },
+    { .fni4 = gen_shr32_ins_i32,
+      .fniv = gen_shr_ins_vec,
+      .load_dest = true,
+      .opc = INDEX_op_shri_vec,
+      .vece = MO_32 },
+    { .fni8 = gen_shr64_ins_i64,
+      .fniv = gen_shr_ins_vec,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .load_dest = true,
+      .opc = INDEX_op_shri_vec,
+      .vece = MO_64 },
+};
+
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
+    if (sh == 0) {
+        tcg_gen_mov_vec(d, a);
+    } else {
+        TCGv_vec t = tcg_temp_new_vec_matching(d);
+        TCGv_vec m = tcg_temp_new_vec_matching(d);
+
+        tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK(0, sh));
+        tcg_gen_shli_vec(vece, t, a, sh);
+        tcg_gen_and_vec(vece, d, d, m);
+        tcg_gen_or_vec(vece, d, d, t);
+
+        tcg_temp_free_vec(t);
+        tcg_temp_free_vec(m);
+    }
+}
+
+const GVecGen2i sli_op[4] = {
+    { .fni8 = gen_shl8_ins_i64,
+      .fniv = gen_shl_ins_vec,
+      .load_dest = true,
+      .opc = INDEX_op_shli_vec,
+      .vece = MO_8 },
+    { .fni8 = gen_shl16_ins_i64,
+      .fniv = gen_shl_ins_vec,
+      .load_dest = true,
+      .opc = INDEX_op_shli_vec,
+      .vece = MO_16 },
+    { .fni4 = gen_shl32_ins_i32,
+      .fniv = gen_shl_ins_vec,
+      .load_dest = true,
+      .opc = INDEX_op_shli_vec,
+      .vece = MO_32 },
+    { .fni8 = gen_shl64_ins_i64,
+      .fniv = gen_shl_ins_vec,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .load_dest = true,
+      .opc = INDEX_op_shli_vec,
+      .vece = MO_64 },
+};
+
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
    We process data in a mixture of 32-bit and 64-bit chunks.
@@ -5895,7 +6049,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int pairwise;
     int u;
     int vec_size;
-    uint32_t imm, mask;
+    uint32_t imm;
     TCGv_i32 tmp, tmp2, tmp3, tmp4, tmp5;
     TCGv_ptr ptr1, ptr2, ptr3;
     TCGv_i64 tmp64;
@@ -6534,8 +6688,27 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     return 0;
 
+                case 4: /* VSRI */
+                    if (!u) {
+                        return 1;
+                    }
+                    /* Right shift comes here negative.  */
+                    shift = -shift;
+                    /* Shift out of range leaves destination unchanged.  */
+                    if (shift < 8 << size) {
+                        tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size, vec_size,
+                                        shift, &sri_op[size]);
+                    }
+                    return 0;
+
                 case 5: /* VSHL, VSLI */
-                    if (!u) { /* VSHL */
+                    if (u) { /* VSLI */
+                        /* Shift out of range leaves destination unchanged.  */
+                        if (shift < 8 << size) {
+                            tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size,
+                                            vec_size, shift, &sli_op[size]);
+                        }
+                    } else { /* VSHL */
                         /* Shifts larger than the element size are
                          * architecturally valid and results in zero.
                          */
@@ -6545,9 +6718,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
                                               vec_size, vec_size);
                         }
-                        return 0;
                     }
-                    break;
+                    return 0;
                 }
 
                 if (size == 3) {
@@ -6573,10 +6745,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             else
                                 gen_helper_neon_rshl_s64(cpu_V0, cpu_V0, cpu_V1);
                             break;
-                        case 4: /* VSRI */
-                        case 5: /* VSHL, VSLI */
-                            gen_helper_neon_shl_u64(cpu_V0, cpu_V0, cpu_V1);
-                            break;
                         case 6: /* VQSHLU */
                             gen_helper_neon_qshlu_s64(cpu_V0, cpu_env,
                                                       cpu_V0, cpu_V1);
@@ -6597,21 +6765,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             /* Accumulate.  */
                             neon_load_reg64(cpu_V1, rd + pass);
                             tcg_gen_add_i64(cpu_V0, cpu_V0, cpu_V1);
-                        } else if (op == 4 || (op == 5 && u)) {
-                            /* Insert */
-                            neon_load_reg64(cpu_V1, rd + pass);
-                            uint64_t mask;
-                            if (shift < -63 || shift > 63) {
-                                mask = 0;
-                            } else {
-                                if (op == 4) {
-                                    mask = 0xffffffffffffffffull >> -shift;
-                                } else {
-                                    mask = 0xffffffffffffffffull << shift;
-                                }
-                            }
-                            tcg_gen_andi_i64(cpu_V1, cpu_V1, ~mask);
-                            tcg_gen_or_i64(cpu_V0, cpu_V0, cpu_V1);
                         }
                         neon_store_reg64(cpu_V0, rd + pass);
                     } else { /* size < 3 */
@@ -6624,15 +6777,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         case 3: /* VRSRA */
                             GEN_NEON_INTEGER_OP(rshl);
                             break;
-                        case 4: /* VSRI */
-                        case 5: /* VSHL, VSLI */
-                            switch (size) {
-                            case 0: gen_helper_neon_shl_u8(tmp, tmp, tmp2); break;
-                            case 1: gen_helper_neon_shl_u16(tmp, tmp, tmp2); break;
-                            case 2: gen_helper_neon_shl_u32(tmp, tmp, tmp2); break;
-                            default: abort();
-                            }
-                            break;
                         case 6: /* VQSHLU */
                             switch (size) {
                             case 0:
@@ -6664,42 +6808,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             tmp2 = neon_load_reg(rd, pass);
                             gen_neon_add(size, tmp, tmp2);
                             tcg_temp_free_i32(tmp2);
-                        } else if (op == 4 || (op == 5 && u)) {
-                            /* Insert */
-                            switch (size) {
-                            case 0:
-                                if (op == 4)
-                                    mask = 0xff >> -shift;
-                                else
-                                    mask = (uint8_t)(0xff << shift);
-                                mask |= mask << 8;
-                                mask |= mask << 16;
-                                break;
-                            case 1:
-                                if (op == 4)
-                                    mask = 0xffff >> -shift;
-                                else
-                                    mask = (uint16_t)(0xffff << shift);
-                                mask |= mask << 16;
-                                break;
-                            case 2:
-                                if (shift < -31 || shift > 31) {
-                                    mask = 0;
-                                } else {
-                                    if (op == 4)
-                                        mask = 0xffffffffu >> -shift;
-                                    else
-                                        mask = 0xffffffffu << shift;
-                                }
-                                break;
-                            default:
-                                abort();
-                            }
-                            tmp2 = neon_load_reg(rd, pass);
-                            tcg_gen_andi_i32(tmp, tmp, mask);
-                            tcg_gen_andi_i32(tmp2, tmp2, ~mask);
-                            tcg_gen_or_i32(tmp, tmp, tmp2);
-                            tcg_temp_free_i32(tmp2);
                         }
                         neon_store_reg(rd, pass, tmp);
                     }
-- 
2.17.1
