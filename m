Received: from eggs.gnu.org ([2001:4830:134:3::10]:45267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhws-0006ux-KO
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwm-00060d-8W
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:39342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwl-00043n-Ks
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:39 -0400
Received: by mail-pf1-x432.google.com with SMTP id c25-v6so5005451pfe.6
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:54 -0700
Message-Id: <20181011205206.3552-9-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/20] target/arm: Use gvec for NEON_3R_LOGIC
 insns
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

Move expanders for VBSL, VBIT, and VBIF from translate-a64.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |   6 +-
 target/arm/translate-a64.c |  61 --------------
 target/arm/translate.c     | 162 +++++++++++++++++++++++++++----------
 3 files changed, 123 insertions(+), 106 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index ad911de98c..7cc2685104 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -191,6 +191,11 @@ static inline TCGv_i32 get_ahp_flag(void)
     return ret;
 }
 
+/* Vector operations shared between ARM and AArch64.  */
+extern const GVecGen3 bsl_op;
+extern const GVecGen3 bit_op;
+extern const GVecGen3 bif_op;
+
 #define FORWARD_FEATURE(NAME) \
     static inline bool aa32_dc_feature_##NAME(DisasContext *dc) \
     { return aa32_feature_##NAME(dc->cpu); }
@@ -209,5 +214,4 @@ FORWARD_FEATURE(dp)
 FORWARD_FEATURE(fp16_arith)
 
 #undef FORWARD_FEATURE
-
 #endif /* TARGET_ARM_TRANSLATE_H */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2f4041462e..a115546a6a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10392,70 +10392,9 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-static void gen_bsl_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
-{
-    tcg_gen_xor_i64(rn, rn, rm);
-    tcg_gen_and_i64(rn, rn, rd);
-    tcg_gen_xor_i64(rd, rm, rn);
-}
-
-static void gen_bit_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
-{
-    tcg_gen_xor_i64(rn, rn, rd);
-    tcg_gen_and_i64(rn, rn, rm);
-    tcg_gen_xor_i64(rd, rd, rn);
-}
-
-static void gen_bif_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
-{
-    tcg_gen_xor_i64(rn, rn, rd);
-    tcg_gen_andc_i64(rn, rn, rm);
-    tcg_gen_xor_i64(rd, rd, rn);
-}
-
-static void gen_bsl_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
-{
-    tcg_gen_xor_vec(vece, rn, rn, rm);
-    tcg_gen_and_vec(vece, rn, rn, rd);
-    tcg_gen_xor_vec(vece, rd, rm, rn);
-}
-
-static void gen_bit_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
-{
-    tcg_gen_xor_vec(vece, rn, rn, rd);
-    tcg_gen_and_vec(vece, rn, rn, rm);
-    tcg_gen_xor_vec(vece, rd, rd, rn);
-}
-
-static void gen_bif_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
-{
-    tcg_gen_xor_vec(vece, rn, rn, rd);
-    tcg_gen_andc_vec(vece, rn, rn, rm);
-    tcg_gen_xor_vec(vece, rd, rd, rn);
-}
-
 /* Logic op (opcode == 3) subgroup of C3.6.16. */
 static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
 {
-    static const GVecGen3 bsl_op = {
-        .fni8 = gen_bsl_i64,
-        .fniv = gen_bsl_vec,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-        .load_dest = true
-    };
-    static const GVecGen3 bit_op = {
-        .fni8 = gen_bit_i64,
-        .fniv = gen_bit_vec,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-        .load_dest = true
-    };
-    static const GVecGen3 bif_op = {
-        .fni8 = gen_bif_i64,
-        .fniv = gen_bif_vec,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-        .load_dest = true
-    };
-
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int rm = extract32(insn, 16, 5);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 109689a286..4ab9f69b01 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5262,14 +5262,6 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     return 0;
 }
 
-/* Bitwise select.  dest = c ? t : f.  Clobbers T and F.  */
-static void gen_neon_bsl(TCGv_i32 dest, TCGv_i32 t, TCGv_i32 f, TCGv_i32 c)
-{
-    tcg_gen_and_i32(t, t, c);
-    tcg_gen_andc_i32(f, f, c);
-    tcg_gen_or_i32(dest, t, f);
-}
-
 static inline void gen_neon_narrow(int size, TCGv_i32 dest, TCGv_i64 src)
 {
     switch (size) {
@@ -5712,6 +5704,73 @@ static int do_v81_helper(DisasContext *s, gen_helper_gvec_3_ptr *fn,
     return 1;
 }
 
+/*
+ * Expanders for VBitOps_VBIF, VBIT, VBSL.
+ */
+static void gen_bsl_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_xor_i64(rn, rn, rm);
+    tcg_gen_and_i64(rn, rn, rd);
+    tcg_gen_xor_i64(rd, rm, rn);
+}
+
+static void gen_bit_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_xor_i64(rn, rn, rd);
+    tcg_gen_and_i64(rn, rn, rm);
+    tcg_gen_xor_i64(rd, rd, rn);
+}
+
+static void gen_bif_i64(TCGv_i64 rd, TCGv_i64 rn, TCGv_i64 rm)
+{
+    tcg_gen_xor_i64(rn, rn, rd);
+    tcg_gen_andc_i64(rn, rn, rm);
+    tcg_gen_xor_i64(rd, rd, rn);
+}
+
+static void gen_bsl_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
+{
+    tcg_gen_xor_vec(vece, rn, rn, rm);
+    tcg_gen_and_vec(vece, rn, rn, rd);
+    tcg_gen_xor_vec(vece, rd, rm, rn);
+}
+
+static void gen_bit_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
+{
+    tcg_gen_xor_vec(vece, rn, rn, rd);
+    tcg_gen_and_vec(vece, rn, rn, rm);
+    tcg_gen_xor_vec(vece, rd, rd, rn);
+}
+
+static void gen_bif_vec(unsigned vece, TCGv_vec rd, TCGv_vec rn, TCGv_vec rm)
+{
+    tcg_gen_xor_vec(vece, rn, rn, rd);
+    tcg_gen_andc_vec(vece, rn, rn, rm);
+    tcg_gen_xor_vec(vece, rd, rd, rn);
+}
+
+const GVecGen3 bsl_op = {
+    .fni8 = gen_bsl_i64,
+    .fniv = gen_bsl_vec,
+    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    .load_dest = true
+};
+
+const GVecGen3 bit_op = {
+    .fni8 = gen_bit_i64,
+    .fniv = gen_bit_vec,
+    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    .load_dest = true
+};
+
+const GVecGen3 bif_op = {
+    .fni8 = gen_bif_i64,
+    .fniv = gen_bif_vec,
+    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    .load_dest = true
+};
+
+
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
    We process data in a mixture of 32-bit and 64-bit chunks.
@@ -5721,13 +5780,14 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 {
     int op;
     int q;
-    int rd, rn, rm;
+    int rd, rn, rm, rd_ofs, rn_ofs, rm_ofs;
     int size;
     int shift;
     int pass;
     int count;
     int pairwise;
     int u;
+    int vec_size;
     uint32_t imm, mask;
     TCGv_i32 tmp, tmp2, tmp3, tmp4, tmp5;
     TCGv_ptr ptr1, ptr2, ptr3;
@@ -5751,6 +5811,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     VFP_DREG_N(rn, insn);
     VFP_DREG_M(rm, insn);
     size = (insn >> 20) & 3;
+    vec_size = q ? 16 : 8;
+    rd_ofs = neon_reg_offset(rd, 0);
+    rn_ofs = neon_reg_offset(rn, 0);
+    rm_ofs = neon_reg_offset(rm, 0);
+
     if ((insn & (1 << 23)) == 0) {
         /* Three register same length.  */
         op = ((insn >> 7) & 0x1e) | ((insn >> 4) & 1);
@@ -5841,8 +5906,51 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                      q, rd, rn, rm);
             }
             return 1;
+
+        case NEON_3R_LOGIC: /* Logic ops.  */
+            switch ((u << 2) | size) {
+            case 0: /* VAND */
+                tcg_gen_gvec_and(0, rd_ofs, rn_ofs, rm_ofs,
+                                 vec_size, vec_size);
+                break;
+            case 1: /* VBIC */
+                tcg_gen_gvec_andc(0, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+                break;
+            case 2:
+                if (rn == rm) {
+                    /* VMOV */
+                    tcg_gen_gvec_mov(0, rd_ofs, rn_ofs, vec_size, vec_size);
+                } else {
+                    /* VORR */
+                    tcg_gen_gvec_or(0, rd_ofs, rn_ofs, rm_ofs,
+                                    vec_size, vec_size);
+                }
+                break;
+            case 3: /* VORN */
+                tcg_gen_gvec_orc(0, rd_ofs, rn_ofs, rm_ofs,
+                                 vec_size, vec_size);
+                break;
+            case 4: /* VEOR */
+                tcg_gen_gvec_xor(0, rd_ofs, rn_ofs, rm_ofs,
+                                 vec_size, vec_size);
+                break;
+            case 5: /* VBSL */
+                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
+                               vec_size, vec_size, &bsl_op);
+                break;
+            case 6: /* VBIT */
+                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
+                               vec_size, vec_size, &bit_op);
+                break;
+            case 7: /* VBIF */
+                tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
+                               vec_size, vec_size, &bif_op);
+                break;
+            }
+            return 0;
         }
-        if (size == 3 && op != NEON_3R_LOGIC) {
+        if (size == 3) {
             /* 64-bit element instructions. */
             for (pass = 0; pass < (q ? 2 : 1); pass++) {
                 neon_load_reg64(cpu_V0, rn + pass);
@@ -6000,40 +6108,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VRHADD:
             GEN_NEON_INTEGER_OP(rhadd);
             break;
-        case NEON_3R_LOGIC: /* Logic ops.  */
-            switch ((u << 2) | size) {
-            case 0: /* VAND */
-                tcg_gen_and_i32(tmp, tmp, tmp2);
-                break;
-            case 1: /* BIC */
-                tcg_gen_andc_i32(tmp, tmp, tmp2);
-                break;
-            case 2: /* VORR */
-                tcg_gen_or_i32(tmp, tmp, tmp2);
-                break;
-            case 3: /* VORN */
-                tcg_gen_orc_i32(tmp, tmp, tmp2);
-                break;
-            case 4: /* VEOR */
-                tcg_gen_xor_i32(tmp, tmp, tmp2);
-                break;
-            case 5: /* VBSL */
-                tmp3 = neon_load_reg(rd, pass);
-                gen_neon_bsl(tmp, tmp, tmp2, tmp3);
-                tcg_temp_free_i32(tmp3);
-                break;
-            case 6: /* VBIT */
-                tmp3 = neon_load_reg(rd, pass);
-                gen_neon_bsl(tmp, tmp, tmp3, tmp2);
-                tcg_temp_free_i32(tmp3);
-                break;
-            case 7: /* VBIF */
-                tmp3 = neon_load_reg(rd, pass);
-                gen_neon_bsl(tmp, tmp3, tmp, tmp2);
-                tcg_temp_free_i32(tmp3);
-                break;
-            }
-            break;
         case NEON_3R_VHSUB:
             GEN_NEON_INTEGER_OP(hsub);
             break;
-- 
2.17.1
