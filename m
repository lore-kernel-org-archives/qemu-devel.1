Received: from eggs.gnu.org ([2001:4830:134:3::10]:45262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhws-0006ud-Cf
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwn-000664-1f
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:46 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:42103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwm-0005Eq-Jc
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:40 -0400
Received: by mail-pg1-x52e.google.com with SMTP id i4-v6so4724847pgq.9
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:52:01 -0700
Message-Id: <20181011205206.3552-16-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 15/20] target/arm: Use gvec for NEON_3R_VML
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

Move mla_op and mls_op expanders from translate-a64.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |   2 +
 target/arm/translate-a64.c | 106 -----------------------------
 target/arm/translate.c     | 134 ++++++++++++++++++++++++++++++++-----
 3 files changed, 120 insertions(+), 122 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index ef44f0a5e5..d11d504301 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -195,6 +195,8 @@ static inline TCGv_i32 get_ahp_flag(void)
 extern const GVecGen3 bsl_op;
 extern const GVecGen3 bit_op;
 extern const GVecGen3 bif_op;
+extern const GVecGen3 mla_op[4];
+extern const GVecGen3 mls_op[4];
 extern const GVecGen2i ssra_op[4];
 extern const GVecGen2i usra_op[4];
 extern const GVecGen2i sri_op[4];
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f47c132e6c..94f7127c0e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10410,66 +10410,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     }
 }
 
-static void gen_mla8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    gen_helper_neon_mul_u8(a, a, b);
-    gen_helper_neon_add_u8(d, d, a);
-}
-
-static void gen_mla16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    gen_helper_neon_mul_u16(a, a, b);
-    gen_helper_neon_add_u16(d, d, a);
-}
-
-static void gen_mla32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    tcg_gen_mul_i32(a, a, b);
-    tcg_gen_add_i32(d, d, a);
-}
-
-static void gen_mla64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    tcg_gen_mul_i64(a, a, b);
-    tcg_gen_add_i64(d, d, a);
-}
-
-static void gen_mla_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-{
-    tcg_gen_mul_vec(vece, a, a, b);
-    tcg_gen_add_vec(vece, d, d, a);
-}
-
-static void gen_mls8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    gen_helper_neon_mul_u8(a, a, b);
-    gen_helper_neon_sub_u8(d, d, a);
-}
-
-static void gen_mls16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    gen_helper_neon_mul_u16(a, a, b);
-    gen_helper_neon_sub_u16(d, d, a);
-}
-
-static void gen_mls32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    tcg_gen_mul_i32(a, a, b);
-    tcg_gen_sub_i32(d, d, a);
-}
-
-static void gen_mls64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    tcg_gen_mul_i64(a, a, b);
-    tcg_gen_sub_i64(d, d, a);
-}
-
-static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-{
-    tcg_gen_mul_vec(vece, a, a, b);
-    tcg_gen_sub_vec(vece, d, d, a);
-}
-
 /* Integer op subgroup of C3.6.16. */
 static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 {
@@ -10488,52 +10428,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
-    static const GVecGen3 mla_op[4] = {
-        { .fni4 = gen_mla8_i32,
-          .fniv = gen_mla_vec,
-          .opc = INDEX_op_mul_vec,
-          .load_dest = true,
-          .vece = MO_8 },
-        { .fni4 = gen_mla16_i32,
-          .fniv = gen_mla_vec,
-          .opc = INDEX_op_mul_vec,
-          .load_dest = true,
-          .vece = MO_16 },
-        { .fni4 = gen_mla32_i32,
-          .fniv = gen_mla_vec,
-          .opc = INDEX_op_mul_vec,
-          .load_dest = true,
-          .vece = MO_32 },
-        { .fni8 = gen_mla64_i64,
-          .fniv = gen_mla_vec,
-          .opc = INDEX_op_mul_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .vece = MO_64 },
-    };
-    static const GVecGen3 mls_op[4] = {
-        { .fni4 = gen_mls8_i32,
-          .fniv = gen_mls_vec,
-          .opc = INDEX_op_mul_vec,
-          .load_dest = true,
-          .vece = MO_8 },
-        { .fni4 = gen_mls16_i32,
-          .fniv = gen_mls_vec,
-          .opc = INDEX_op_mul_vec,
-          .load_dest = true,
-          .vece = MO_16 },
-        { .fni4 = gen_mls32_i32,
-          .fniv = gen_mls_vec,
-          .opc = INDEX_op_mul_vec,
-          .load_dest = true,
-          .vece = MO_32 },
-        { .fni8 = gen_mls64_i64,
-          .fniv = gen_mls_vec,
-          .opc = INDEX_op_mul_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-          .load_dest = true,
-          .vece = MO_64 },
-    };
 
     int is_q = extract32(insn, 30, 1);
     int u = extract32(insn, 29, 1);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 104b49543d..5008a24ffd 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5468,7 +5468,7 @@ static void gen_neon_narrow_op(int op, int u, int size,
 #define NEON_3R_VABA 15
 #define NEON_3R_VADD_VSUB 16
 #define NEON_3R_VTST_VCEQ 17
-#define NEON_3R_VML 18 /* VMLA, VMLAL, VMLS, VMLSL */
+#define NEON_3R_VML 18 /* VMLA, VMLS */
 #define NEON_3R_VMUL 19
 #define NEON_3R_VPMAX 20
 #define NEON_3R_VPMIN 21
@@ -6032,6 +6032,117 @@ const GVecGen2i sli_op[4] = {
       .vece = MO_64 },
 };
 
+static void gen_mla8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u8(a, a, b);
+    gen_helper_neon_add_u8(d, d, a);
+}
+
+static void gen_mls8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u8(a, a, b);
+    gen_helper_neon_sub_u8(d, d, a);
+}
+
+static void gen_mla16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u16(a, a, b);
+    gen_helper_neon_add_u16(d, d, a);
+}
+
+static void gen_mls16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    gen_helper_neon_mul_u16(a, a, b);
+    gen_helper_neon_sub_u16(d, d, a);
+}
+
+static void gen_mla32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_mul_i32(a, a, b);
+    tcg_gen_add_i32(d, d, a);
+}
+
+static void gen_mls32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_mul_i32(a, a, b);
+    tcg_gen_sub_i32(d, d, a);
+}
+
+static void gen_mla64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_mul_i64(a, a, b);
+    tcg_gen_add_i64(d, d, a);
+}
+
+static void gen_mls64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_mul_i64(a, a, b);
+    tcg_gen_sub_i64(d, d, a);
+}
+
+static void gen_mla_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    tcg_gen_mul_vec(vece, a, a, b);
+    tcg_gen_add_vec(vece, d, d, a);
+}
+
+static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    tcg_gen_mul_vec(vece, a, a, b);
+    tcg_gen_sub_vec(vece, d, d, a);
+}
+
+/* Note that while NEON does not support VMLA and VMLS as 64-bit ops,
+ * these tables are shared with AArch64 which does support them.
+ */
+const GVecGen3 mla_op[4] = {
+    { .fni4 = gen_mla8_i32,
+      .fniv = gen_mla_vec,
+      .opc = INDEX_op_mul_vec,
+      .load_dest = true,
+      .vece = MO_8 },
+    { .fni4 = gen_mla16_i32,
+      .fniv = gen_mla_vec,
+      .opc = INDEX_op_mul_vec,
+      .load_dest = true,
+      .vece = MO_16 },
+    { .fni4 = gen_mla32_i32,
+      .fniv = gen_mla_vec,
+      .opc = INDEX_op_mul_vec,
+      .load_dest = true,
+      .vece = MO_32 },
+    { .fni8 = gen_mla64_i64,
+      .fniv = gen_mla_vec,
+      .opc = INDEX_op_mul_vec,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .load_dest = true,
+      .vece = MO_64 },
+};
+
+const GVecGen3 mls_op[4] = {
+    { .fni4 = gen_mls8_i32,
+      .fniv = gen_mls_vec,
+      .opc = INDEX_op_mul_vec,
+      .load_dest = true,
+      .vece = MO_8 },
+    { .fni4 = gen_mls16_i32,
+      .fniv = gen_mls_vec,
+      .opc = INDEX_op_mul_vec,
+      .load_dest = true,
+      .vece = MO_16 },
+    { .fni4 = gen_mls32_i32,
+      .fniv = gen_mls_vec,
+      .opc = INDEX_op_mul_vec,
+      .load_dest = true,
+      .vece = MO_32 },
+    { .fni8 = gen_mls64_i64,
+      .fniv = gen_mls_vec,
+      .opc = INDEX_op_mul_vec,
+      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .load_dest = true,
+      .vece = MO_64 },
+};
+
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
    We process data in a mixture of 32-bit and 64-bit chunks.
@@ -6233,7 +6344,13 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 return 0;
             }
             break;
+
+        case NEON_3R_VML: /* VMLA, VMLS */
+            tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
+                           u ? &mls_op[size] : &mla_op[size]);
+            return 0;
         }
+
         if (size == 3) {
             /* 64-bit element instructions. */
             for (pass = 0; pass < (q ? 2 : 1); pass++) {
@@ -6435,21 +6552,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
             }
             break;
-        case NEON_3R_VML: /* VMLA, VMLAL, VMLS,VMLSL */
-            switch (size) {
-            case 0: gen_helper_neon_mul_u8(tmp, tmp, tmp2); break;
-            case 1: gen_helper_neon_mul_u16(tmp, tmp, tmp2); break;
-            case 2: tcg_gen_mul_i32(tmp, tmp, tmp2); break;
-            default: abort();
-            }
-            tcg_temp_free_i32(tmp2);
-            tmp2 = neon_load_reg(rd, pass);
-            if (u) { /* VMLS */
-                gen_neon_rsb(size, tmp, tmp2);
-            } else { /* VMLA */
-                gen_neon_add(size, tmp, tmp2);
-            }
-            break;
         case NEON_3R_VMUL:
             /* VMUL.P8; other cases already eliminated.  */
             gen_helper_neon_mul_p8(tmp, tmp, tmp2);
-- 
2.17.1
