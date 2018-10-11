Received: from eggs.gnu.org ([2001:4830:134:3::10]:45132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwn-0006py-OW
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwk-0005q6-Ek
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:41 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwj-0004v0-Lg
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:38 -0400
Received: by mail-pl1-x643.google.com with SMTP id f18-v6so4805266plr.1
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:59 -0700
Message-Id: <20181011205206.3552-14-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 13/20] target/arm: Use gvec for VSRA
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

Move ssra_op and usra_op expanders from translate-a64.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |   2 +
 target/arm/translate-a64.c | 106 ----------------------------
 target/arm/translate.c     | 139 ++++++++++++++++++++++++++++++++++---
 3 files changed, 130 insertions(+), 117 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 7cc2685104..8487b349ef 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -195,6 +195,8 @@ static inline TCGv_i32 get_ahp_flag(void)
 extern const GVecGen3 bsl_op;
 extern const GVecGen3 bit_op;
 extern const GVecGen3 bif_op;
+extern const GVecGen2i ssra_op[4];
+extern const GVecGen2i usra_op[4];
 
 #define FORWARD_FEATURE(NAME) \
     static inline bool aa32_dc_feature_##NAME(DisasContext *dc) \
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a115546a6a..1a9ae6d5f4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9392,66 +9392,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-static void gen_ssra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_vec_sar8i_i64(a, a, shift);
-    tcg_gen_vec_add8_i64(d, d, a);
-}
-
-static void gen_ssra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_vec_sar16i_i64(a, a, shift);
-    tcg_gen_vec_add16_i64(d, d, a);
-}
-
-static void gen_ssra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
-{
-    tcg_gen_sari_i32(a, a, shift);
-    tcg_gen_add_i32(d, d, a);
-}
-
-static void gen_ssra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_sari_i64(a, a, shift);
-    tcg_gen_add_i64(d, d, a);
-}
-
-static void gen_ssra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    tcg_gen_sari_vec(vece, a, a, sh);
-    tcg_gen_add_vec(vece, d, d, a);
-}
-
-static void gen_usra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_vec_shr8i_i64(a, a, shift);
-    tcg_gen_vec_add8_i64(d, d, a);
-}
-
-static void gen_usra16_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_vec_shr16i_i64(a, a, shift);
-    tcg_gen_vec_add16_i64(d, d, a);
-}
-
-static void gen_usra32_i32(TCGv_i32 d, TCGv_i32 a, int32_t shift)
-{
-    tcg_gen_shri_i32(a, a, shift);
-    tcg_gen_add_i32(d, d, a);
-}
-
-static void gen_usra64_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
-{
-    tcg_gen_shri_i64(a, a, shift);
-    tcg_gen_add_i64(d, d, a);
-}
-
-static void gen_usra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
-{
-    tcg_gen_shri_vec(vece, a, a, sh);
-    tcg_gen_add_vec(vece, d, d, a);
-}
-
 static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
     uint64_t mask = dup_const(MO_8, 0xff >> shift);
@@ -9507,52 +9447,6 @@ static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
                                  int immh, int immb, int opcode, int rn, int rd)
 {
-    static const GVecGen2i ssra_op[4] = {
-        { .fni8 = gen_ssra8_i64,
-          .fniv = gen_ssra_vec,
-          .load_dest = true,
-          .opc = INDEX_op_sari_vec,
-          .vece = MO_8 },
-        { .fni8 = gen_ssra16_i64,
-          .fniv = gen_ssra_vec,
-          .load_dest = true,
-          .opc = INDEX_op_sari_vec,
-          .vece = MO_16 },
-        { .fni4 = gen_ssra32_i32,
-          .fniv = gen_ssra_vec,
-          .load_dest = true,
-          .opc = INDEX_op_sari_vec,
-          .vece = MO_32 },
-        { .fni8 = gen_ssra64_i64,
-          .fniv = gen_ssra_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .opc = INDEX_op_sari_vec,
-          .vece = MO_64 },
-    };
-    static const GVecGen2i usra_op[4] = {
-        { .fni8 = gen_usra8_i64,
-          .fniv = gen_usra_vec,
-          .load_dest = true,
-          .opc = INDEX_op_shri_vec,
-          .vece = MO_8, },
-        { .fni8 = gen_usra16_i64,
-          .fniv = gen_usra_vec,
-          .load_dest = true,
-          .opc = INDEX_op_shri_vec,
-          .vece = MO_16, },
-        { .fni4 = gen_usra32_i32,
-          .fniv = gen_usra_vec,
-          .load_dest = true,
-          .opc = INDEX_op_shri_vec,
-          .vece = MO_32, },
-        { .fni8 = gen_usra64_i64,
-          .fniv = gen_usra_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .opc = INDEX_op_shri_vec,
-          .vece = MO_64, },
-    };
     static const GVecGen2i sri_op[4] = {
         { .fni8 = gen_shr8_ins_i64,
           .fniv = gen_shr_ins_vec,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a16f323d52..da95851370 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5770,6 +5770,113 @@ const GVecGen3 bif_op = {
     .load_dest = true
 };
 
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
+const GVecGen2i ssra_op[4] = {
+    { .fni8 = gen_ssra8_i64,
+      .fniv = gen_ssra_vec,
+      .load_dest = true,
+      .opc = INDEX_op_sari_vec,
+      .vece = MO_8 },
+    { .fni8 = gen_ssra16_i64,
+      .fniv = gen_ssra_vec,
+      .load_dest = true,
+      .opc = INDEX_op_sari_vec,
+      .vece = MO_16 },
+    { .fni4 = gen_ssra32_i32,
+      .fniv = gen_ssra_vec,
+      .load_dest = true,
+      .opc = INDEX_op_sari_vec,
+      .vece = MO_32 },
+    { .fni8 = gen_ssra64_i64,
+      .fniv = gen_ssra_vec,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .load_dest = true,
+      .opc = INDEX_op_sari_vec,
+      .vece = MO_64 },
+};
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
+const GVecGen2i usra_op[4] = {
+    { .fni8 = gen_usra8_i64,
+      .fniv = gen_usra_vec,
+      .load_dest = true,
+      .opc = INDEX_op_shri_vec,
+      .vece = MO_8, },
+    { .fni8 = gen_usra16_i64,
+      .fniv = gen_usra_vec,
+      .load_dest = true,
+      .opc = INDEX_op_shri_vec,
+      .vece = MO_16, },
+    { .fni4 = gen_usra32_i32,
+      .fniv = gen_usra_vec,
+      .load_dest = true,
+      .opc = INDEX_op_shri_vec,
+      .vece = MO_32, },
+    { .fni8 = gen_usra64_i64,
+      .fniv = gen_usra_vec,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .load_dest = true,
+      .opc = INDEX_op_shri_vec,
+      .vece = MO_64, },
+};
 
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
@@ -6408,6 +6515,25 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     return 0;
 
+                case 1:  /* VSRA */
+                    /* Right shift comes here negative.  */
+                    shift = -shift;
+                    /* Shifts larger than the element size are architecturally
+                     * valid.  Unsigned results in all zeros; signed results
+                     * in all sign bits.
+                     */
+                    if (!u) {
+                        tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size, vec_size,
+                                        MIN(shift, (8 << size) - 1),
+                                        &ssra_op[size]);
+                    } else if (shift >= 8 << size) {
+                        /* rd += 0 */
+                    } else {
+                        tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size, vec_size,
+                                        shift, &usra_op[size]);
+                    }
+                    return 0;
+
                 case 5: /* VSHL, VSLI */
                     if (!u) { /* VSHL */
                         /* Shifts larger than the element size are
@@ -6440,12 +6566,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         neon_load_reg64(cpu_V0, rm + pass);
                         tcg_gen_movi_i64(cpu_V1, imm);
                         switch (op) {
-                        case 1:  /* VSRA */
-                            if (u)
-                                gen_helper_neon_shl_u64(cpu_V0, cpu_V0, cpu_V1);
-                            else
-                                gen_helper_neon_shl_s64(cpu_V0, cpu_V0, cpu_V1);
-                            break;
                         case 2: /* VRSHR */
                         case 3: /* VRSRA */
                             if (u)
@@ -6473,7 +6593,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         default:
                             g_assert_not_reached();
                         }
-                        if (op == 1 || op == 3) {
+                        if (op == 3) {
                             /* Accumulate.  */
                             neon_load_reg64(cpu_V1, rd + pass);
                             tcg_gen_add_i64(cpu_V0, cpu_V0, cpu_V1);
@@ -6500,9 +6620,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         tmp2 = tcg_temp_new_i32();
                         tcg_gen_movi_i32(tmp2, imm);
                         switch (op) {
-                        case 1:  /* VSRA */
-                            GEN_NEON_INTEGER_OP(shl);
-                            break;
                         case 2: /* VRSHR */
                         case 3: /* VRSRA */
                             GEN_NEON_INTEGER_OP(rshl);
@@ -6542,7 +6659,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         }
                         tcg_temp_free_i32(tmp2);
 
-                        if (op == 1 || op == 3) {
+                        if (op == 3) {
                             /* Accumulate.  */
                             tmp2 = neon_load_reg(rd, pass);
                             gen_neon_add(size, tmp, tmp2);
-- 
2.17.1
