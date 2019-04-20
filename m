Received: from eggs.gnu.org ([209.51.188.92]:40337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWx-0000IU-QH
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWo-0008J6-VH
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:20 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWo-0008HN-IQ
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:14 -0400
Received: by mail-pf1-x443.google.com with SMTP id y13so3457200pfm.11
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:20 -1000
Message-Id: <20190420073442.7488-17-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 16/38] tcg: Specify optional vector
 requirements with a list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Replace the single opcode in .opc with a null-terminated
array in .opt_opc.  We still require that all opcodes be
used with the same .vece.

Validate the contents of this list with CONFIG_DEBUG_TCG.
All tcg_gen_*_vec functions will check any list active
during .fniv expansion.  Swap the active list in and out
as we expand other opcodes, or take control away from the
front-end function.

Convert all existing vector aware front ends.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.h                   |  24 +-
 tcg/tcg.h                           |  18 ++
 target/arm/translate-sve.c          |   9 +-
 target/arm/translate.c              | 127 +++++++----
 target/ppc/translate/vmx-impl.inc.c |   7 +-
 tcg/tcg-op-gvec.c                   | 341 ++++++++++++++++++----------
 tcg/tcg-op-vec.c                    |  18 ++
 7 files changed, 365 insertions(+), 179 deletions(-)

diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index aaeb6e5d8b..a0e0902f6c 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -91,8 +91,8 @@ typedef struct {
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec);
     /* Expand out-of-line helper w/descriptor.  */
     gen_helper_gvec_2 *fno;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The data argument to the out-of-line helper.  */
     int32_t data;
     /* The vector element size, if applicable.  */
@@ -112,8 +112,8 @@ typedef struct {
     gen_helper_gvec_2 *fno;
     /* Expand out-of-line helper w/descriptor, data as argument.  */
     gen_helper_gvec_2i *fnoi;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The vector element size, if applicable.  */
     uint8_t vece;
     /* Prefer i64 to v64.  */
@@ -131,8 +131,8 @@ typedef struct {
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
     /* Expand out-of-line helper w/descriptor.  */
     gen_helper_gvec_2i *fno;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The data argument to the out-of-line helper.  */
     uint32_t data;
     /* The vector element size, if applicable.  */
@@ -152,8 +152,8 @@ typedef struct {
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
     /* Expand out-of-line helper w/descriptor.  */
     gen_helper_gvec_3 *fno;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The data argument to the out-of-line helper.  */
     int32_t data;
     /* The vector element size, if applicable.  */
@@ -175,8 +175,8 @@ typedef struct {
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, int64_t);
     /* Expand out-of-line helper w/descriptor, data in descriptor.  */
     gen_helper_gvec_3 *fno;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The vector element size, if applicable.  */
     uint8_t vece;
     /* Prefer i64 to v64.  */
@@ -194,8 +194,8 @@ typedef struct {
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, TCGv_vec);
     /* Expand out-of-line helper w/descriptor.  */
     gen_helper_gvec_4 *fno;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The data argument to the out-of-line helper.  */
     int32_t data;
     /* The vector element size, if applicable.  */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 7b1c15b40b..48d4d2e03e 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -694,6 +694,7 @@ struct TCGContext {
     QSIMPLEQ_HEAD(, TCGLabel) labels;
     int temps_in_use;
     int goto_tb_issue_mask;
+    const TCGOpcode *vecop_list;
 #endif
 
     /* Code generation.  Note that we specifically do not use tcg_insn_unit
@@ -1493,4 +1494,21 @@ void helper_atomic_sto_le_mmu(CPUArchState *env, target_ulong addr, Int128 val,
 void helper_atomic_sto_be_mmu(CPUArchState *env, target_ulong addr, Int128 val,
                               TCGMemOpIdx oi, uintptr_t retaddr);
 
+#ifdef CONFIG_DEBUG_TCG
+void tcg_assert_listed_vecop(TCGOpcode);
+#else
+static inline void tcg_assert_listed_vecop(TCGOpcode op) { }
+#endif
+
+static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
+{
+#ifdef CONFIG_DEBUG_TCG
+    const TCGOpcode *o = tcg_ctx->vecop_list;
+    tcg_ctx->vecop_list = n;
+    return o;
+#else
+    return NULL;
+#endif
+}
+
 #endif /* TCG_H */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 245cd82621..0682c0d32b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3302,29 +3302,30 @@ static bool trans_SUB_zzi(DisasContext *s, arg_rri_esz *a)
 
 static bool trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_sub_vec, 0 };
     static const GVecGen2s op[4] = {
         { .fni8 = tcg_gen_vec_sub8_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_sve_subri_b,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8,
           .scalar_first = true },
         { .fni8 = tcg_gen_vec_sub16_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_sve_subri_h,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16,
           .scalar_first = true },
         { .fni4 = tcg_gen_sub_i32,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_sve_subri_s,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32,
           .scalar_first = true },
         { .fni8 = tcg_gen_sub_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_sve_subri_d,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64,
           .scalar_first = true }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 13e2dc6562..83a008e945 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5772,27 +5772,31 @@ static void gen_ssra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
     tcg_gen_add_vec(vece, d, d, a);
 }
 
+static const TCGOpcode vecop_list_ssra[] = {
+    INDEX_op_sari_vec, INDEX_op_add_vec, 0
+};
+
 const GVecGen2i ssra_op[4] = {
     { .fni8 = gen_ssra8_i64,
       .fniv = gen_ssra_vec,
       .load_dest = true,
-      .opc = INDEX_op_sari_vec,
+      .opt_opc = vecop_list_ssra,
       .vece = MO_8 },
     { .fni8 = gen_ssra16_i64,
       .fniv = gen_ssra_vec,
       .load_dest = true,
-      .opc = INDEX_op_sari_vec,
+      .opt_opc = vecop_list_ssra,
       .vece = MO_16 },
     { .fni4 = gen_ssra32_i32,
       .fniv = gen_ssra_vec,
       .load_dest = true,
-      .opc = INDEX_op_sari_vec,
+      .opt_opc = vecop_list_ssra,
       .vece = MO_32 },
     { .fni8 = gen_ssra64_i64,
       .fniv = gen_ssra_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .opt_opc = vecop_list_ssra,
       .load_dest = true,
-      .opc = INDEX_op_sari_vec,
       .vece = MO_64 },
 };
 
@@ -5826,27 +5830,31 @@ static void gen_usra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
     tcg_gen_add_vec(vece, d, d, a);
 }
 
+static const TCGOpcode vecop_list_usra[] = {
+    INDEX_op_shri_vec, INDEX_op_add_vec, 0
+};
+
 const GVecGen2i usra_op[4] = {
     { .fni8 = gen_usra8_i64,
       .fniv = gen_usra_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_usra,
       .vece = MO_8, },
     { .fni8 = gen_usra16_i64,
       .fniv = gen_usra_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_usra,
       .vece = MO_16, },
     { .fni4 = gen_usra32_i32,
       .fniv = gen_usra_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_usra,
       .vece = MO_32, },
     { .fni8 = gen_usra64_i64,
       .fniv = gen_usra_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_usra,
       .vece = MO_64, },
 };
 
@@ -5904,27 +5912,29 @@ static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
     }
 }
 
+static const TCGOpcode vecop_list_sri[] = { INDEX_op_shri_vec, 0 };
+
 const GVecGen2i sri_op[4] = {
     { .fni8 = gen_shr8_ins_i64,
       .fniv = gen_shr_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_sri,
       .vece = MO_8 },
     { .fni8 = gen_shr16_ins_i64,
       .fniv = gen_shr_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_sri,
       .vece = MO_16 },
     { .fni4 = gen_shr32_ins_i32,
       .fniv = gen_shr_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_sri,
       .vece = MO_32 },
     { .fni8 = gen_shr64_ins_i64,
       .fniv = gen_shr_ins_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_sri,
       .vece = MO_64 },
 };
 
@@ -5980,27 +5990,29 @@ static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
     }
 }
 
+static const TCGOpcode vecop_list_sli[] = { INDEX_op_shli_vec, 0 };
+
 const GVecGen2i sli_op[4] = {
     { .fni8 = gen_shl8_ins_i64,
       .fniv = gen_shl_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shli_vec,
+      .opt_opc = vecop_list_sli,
       .vece = MO_8 },
     { .fni8 = gen_shl16_ins_i64,
       .fniv = gen_shl_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shli_vec,
+      .opt_opc = vecop_list_sli,
       .vece = MO_16 },
     { .fni4 = gen_shl32_ins_i32,
       .fniv = gen_shl_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shli_vec,
+      .opt_opc = vecop_list_sli,
       .vece = MO_32 },
     { .fni8 = gen_shl64_ins_i64,
       .fniv = gen_shl_ins_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
       .load_dest = true,
-      .opc = INDEX_op_shli_vec,
+      .opt_opc = vecop_list_sli,
       .vece = MO_64 },
 };
 
@@ -6067,51 +6079,60 @@ static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
 /* Note that while NEON does not support VMLA and VMLS as 64-bit ops,
  * these tables are shared with AArch64 which does support them.
  */
+
+static const TCGOpcode vecop_list_mla[] = {
+    INDEX_op_mul_vec, INDEX_op_add_vec, 0
+};
+
+static const TCGOpcode vecop_list_mls[] = {
+    INDEX_op_mul_vec, INDEX_op_sub_vec, 0
+};
+
 const GVecGen3 mla_op[4] = {
     { .fni4 = gen_mla8_i32,
       .fniv = gen_mla_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mla,
       .vece = MO_8 },
     { .fni4 = gen_mla16_i32,
       .fniv = gen_mla_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mla,
       .vece = MO_16 },
     { .fni4 = gen_mla32_i32,
       .fniv = gen_mla_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mla,
       .vece = MO_32 },
     { .fni8 = gen_mla64_i64,
       .fniv = gen_mla_vec,
-      .opc = INDEX_op_mul_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
       .load_dest = true,
+      .opt_opc = vecop_list_mla,
       .vece = MO_64 },
 };
 
 const GVecGen3 mls_op[4] = {
     { .fni4 = gen_mls8_i32,
       .fniv = gen_mls_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mls,
       .vece = MO_8 },
     { .fni4 = gen_mls16_i32,
       .fniv = gen_mls_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mls,
       .vece = MO_16 },
     { .fni4 = gen_mls32_i32,
       .fniv = gen_mls_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mls,
       .vece = MO_32 },
     { .fni8 = gen_mls64_i64,
       .fniv = gen_mls_vec,
-      .opc = INDEX_op_mul_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
       .load_dest = true,
+      .opt_opc = vecop_list_mls,
       .vece = MO_64 },
 };
 
@@ -6137,23 +6158,25 @@ static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
     tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
 }
 
+static const TCGOpcode vecop_list_cmtst[] = { INDEX_op_cmp_vec, 0 };
+
 const GVecGen3 cmtst_op[4] = {
     { .fni4 = gen_helper_neon_tst_u8,
       .fniv = gen_cmtst_vec,
-      .opc = INDEX_op_cmp_vec,
+      .opt_opc = vecop_list_cmtst,
       .vece = MO_8 },
     { .fni4 = gen_helper_neon_tst_u16,
       .fniv = gen_cmtst_vec,
-      .opc = INDEX_op_cmp_vec,
+      .opt_opc = vecop_list_cmtst,
       .vece = MO_16 },
     { .fni4 = gen_cmtst_i32,
       .fniv = gen_cmtst_vec,
-      .opc = INDEX_op_cmp_vec,
+      .opt_opc = vecop_list_cmtst,
       .vece = MO_32 },
     { .fni8 = gen_cmtst_i64,
       .fniv = gen_cmtst_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .opc = INDEX_op_cmp_vec,
+      .opt_opc = vecop_list_cmtst,
       .vece = MO_64 },
 };
 
@@ -6168,26 +6191,30 @@ static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
+static const TCGOpcode vecop_list_uqadd[] = {
+    INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+};
+
 const GVecGen4 uqadd_op[4] = {
     { .fniv = gen_uqadd_vec,
       .fno = gen_helper_gvec_uqadd_b,
-      .opc = INDEX_op_usadd_vec,
       .write_aofs = true,
+      .opt_opc = vecop_list_uqadd,
       .vece = MO_8 },
     { .fniv = gen_uqadd_vec,
       .fno = gen_helper_gvec_uqadd_h,
-      .opc = INDEX_op_usadd_vec,
       .write_aofs = true,
+      .opt_opc = vecop_list_uqadd,
       .vece = MO_16 },
     { .fniv = gen_uqadd_vec,
       .fno = gen_helper_gvec_uqadd_s,
-      .opc = INDEX_op_usadd_vec,
       .write_aofs = true,
+      .opt_opc = vecop_list_uqadd,
       .vece = MO_32 },
     { .fniv = gen_uqadd_vec,
       .fno = gen_helper_gvec_uqadd_d,
-      .opc = INDEX_op_usadd_vec,
       .write_aofs = true,
+      .opt_opc = vecop_list_uqadd,
       .vece = MO_64 },
 };
 
@@ -6202,25 +6229,29 @@ static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
+static const TCGOpcode vecop_list_sqadd[] = {
+    INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+};
+
 const GVecGen4 sqadd_op[4] = {
     { .fniv = gen_sqadd_vec,
       .fno = gen_helper_gvec_sqadd_b,
-      .opc = INDEX_op_ssadd_vec,
+      .opt_opc = vecop_list_sqadd,
       .write_aofs = true,
       .vece = MO_8 },
     { .fniv = gen_sqadd_vec,
       .fno = gen_helper_gvec_sqadd_h,
-      .opc = INDEX_op_ssadd_vec,
+      .opt_opc = vecop_list_sqadd,
       .write_aofs = true,
       .vece = MO_16 },
     { .fniv = gen_sqadd_vec,
       .fno = gen_helper_gvec_sqadd_s,
-      .opc = INDEX_op_ssadd_vec,
+      .opt_opc = vecop_list_sqadd,
       .write_aofs = true,
       .vece = MO_32 },
     { .fniv = gen_sqadd_vec,
       .fno = gen_helper_gvec_sqadd_d,
-      .opc = INDEX_op_ssadd_vec,
+      .opt_opc = vecop_list_sqadd,
       .write_aofs = true,
       .vece = MO_64 },
 };
@@ -6236,25 +6267,29 @@ static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
+static const TCGOpcode vecop_list_uqsub[] = {
+    INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+};
+
 const GVecGen4 uqsub_op[4] = {
     { .fniv = gen_uqsub_vec,
       .fno = gen_helper_gvec_uqsub_b,
-      .opc = INDEX_op_ussub_vec,
+      .opt_opc = vecop_list_uqsub,
       .write_aofs = true,
       .vece = MO_8 },
     { .fniv = gen_uqsub_vec,
       .fno = gen_helper_gvec_uqsub_h,
-      .opc = INDEX_op_ussub_vec,
+      .opt_opc = vecop_list_uqsub,
       .write_aofs = true,
       .vece = MO_16 },
     { .fniv = gen_uqsub_vec,
       .fno = gen_helper_gvec_uqsub_s,
-      .opc = INDEX_op_ussub_vec,
+      .opt_opc = vecop_list_uqsub,
       .write_aofs = true,
       .vece = MO_32 },
     { .fniv = gen_uqsub_vec,
       .fno = gen_helper_gvec_uqsub_d,
-      .opc = INDEX_op_ussub_vec,
+      .opt_opc = vecop_list_uqsub,
       .write_aofs = true,
       .vece = MO_64 },
 };
@@ -6270,25 +6305,29 @@ static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
+static const TCGOpcode vecop_list_sqsub[] = {
+    INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+};
+
 const GVecGen4 sqsub_op[4] = {
     { .fniv = gen_sqsub_vec,
       .fno = gen_helper_gvec_sqsub_b,
-      .opc = INDEX_op_sssub_vec,
+      .opt_opc = vecop_list_sqsub,
       .write_aofs = true,
       .vece = MO_8 },
     { .fniv = gen_sqsub_vec,
       .fno = gen_helper_gvec_sqsub_h,
-      .opc = INDEX_op_sssub_vec,
+      .opt_opc = vecop_list_sqsub,
       .write_aofs = true,
       .vece = MO_16 },
     { .fniv = gen_sqsub_vec,
       .fno = gen_helper_gvec_sqsub_s,
-      .opc = INDEX_op_sssub_vec,
+      .opt_opc = vecop_list_sqsub,
       .write_aofs = true,
       .vece = MO_32 },
     { .fniv = gen_sqsub_vec,
       .fno = gen_helper_gvec_sqsub_d,
-      .opc = INDEX_op_sssub_vec,
+      .opt_opc = vecop_list_sqsub,
       .write_aofs = true,
       .vece = MO_64 },
 };
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index eb10c533ca..c83e605a00 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -562,10 +562,15 @@ static void glue(glue(gen_, NAME), _vec)(unsigned vece, TCGv_vec t,     \
 }                                                                       \
 static void glue(gen_, NAME)(DisasContext *ctx)                         \
 {                                                                       \
+    static const TCGOpcode vecop_list[] = {                             \
+        glue(glue(INDEX_op_, NORM), _vec),                              \
+        glue(glue(INDEX_op_, SAT), _vec),                               \
+        INDEX_op_cmp_vec, 0                                             \
+    };                                                                  \
     static const GVecGen4 g = {                                         \
         .fniv = glue(glue(gen_, NAME), _vec),                           \
         .fno = glue(gen_helper_, NAME),                                 \
-        .opc = glue(glue(INDEX_op_, SAT), _vec),                        \
+        .opt_opc = vecop_list,                                          \
         .write_aofs = true,                                             \
         .vece = VECE,                                                   \
     };                                                                  \
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 3eb9126f50..40858a83e0 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -26,6 +26,76 @@
 
 #define MAX_UNROLL  4
 
+/*
+ * Vector optional opcode tracking.
+ * Except for the basic logical operations (and, or, xor), and
+ * data movement (mov, ld, st, dupi), many vector opcodes are
+ * optional and may not be supported on the host.  Thank Intel
+ * for the irregularity in their instruction set.
+ *
+ * The gvec expanders allow custom vector operations to be composed,
+ * generally via the .fniv callback in the GVecGen* structures.  At
+ * the same time, in deciding whether to use this hook we need to
+ * know if the host supports the required operations.  This is
+ * presented as an array of opcodes, terminated by 0.  Each opcode
+ * is assumed to be expanded with the given VECE.
+ *
+ * For debugging, we want to validate this array.  Therefore, when
+ * tcg_ctx->vec_opt_opc is non-NULL, the tcg_gen_*_vec expanders
+ * will validate that their opcode is present in the list.
+ */
+#ifdef CONFIG_DEBUG_TCG
+void tcg_assert_listed_vecop(TCGOpcode op)
+{
+    const TCGOpcode *p = tcg_ctx->vecop_list;
+    if (p) {
+        for (; *p; ++p) {
+            if (*p == op) {
+                return;
+            }
+        }
+        g_assert_not_reached();
+    }
+}
+
+static const TCGOpcode vecop_list_empty[1];
+#else
+#define vecop_list_empty NULL
+#endif
+
+static bool tcg_can_emit_vecop_list(const TCGOpcode *list,
+                                    TCGType type, unsigned vece)
+{
+    if (list == NULL) {
+        return true;
+    }
+
+    for (; *list; ++list) {
+        TCGOpcode opc = *list;
+
+        if (tcg_can_emit_vec_op(opc, type, vece)) {
+            continue;
+        }
+
+        /*
+         * The opcode list is created by front ends based on what they
+         * actually invoke.  We must mirror the logic in tcg-op-vec.c
+         * for generic expansions using other opcodes.
+         */
+        switch (opc) {
+        case INDEX_op_neg_vec:
+            if (tcg_can_emit_vec_op(INDEX_op_sub_vec, type, vece)) {
+                continue;
+            }
+            break;
+        default:
+            break;
+        }
+        return false;
+    }
+    return true;
+}
+
 /* Verify vector size and alignment rules.  OFS should be the OR of all
    of the operand offsets so that we can check them all at once.  */
 static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
@@ -360,31 +430,29 @@ static void gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
  * on elements of size VECE in the selected type.  Do not select V64 if
  * PREFER_I64 is true.  Return 0 if no vector type is selected.
  */
-static TCGType choose_vector_type(TCGOpcode op, unsigned vece, uint32_t size,
-                                  bool prefer_i64)
+static TCGType choose_vector_type(const TCGOpcode *list, unsigned vece,
+                                  uint32_t size, bool prefer_i64)
 {
     if (TCG_TARGET_HAS_v256 && check_size_impl(size, 32)) {
-        if (op == 0) {
-            return TCG_TYPE_V256;
-        }
-        /* Recall that ARM SVE allows vector sizes that are not a
+        /*
+         * Recall that ARM SVE allows vector sizes that are not a
          * power of 2, but always a multiple of 16.  The intent is
          * that e.g. size == 80 would be expanded with 2x32 + 1x16.
          * It is hard to imagine a case in which v256 is supported
          * but v128 is not, but check anyway.
          */
-        if (tcg_can_emit_vec_op(op, TCG_TYPE_V256, vece)
+        if (tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece)
             && (size % 32 == 0
-                || tcg_can_emit_vec_op(op, TCG_TYPE_V128, vece))) {
+                || tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) {
             return TCG_TYPE_V256;
         }
     }
     if (TCG_TARGET_HAS_v128 && check_size_impl(size, 16)
-        && (op == 0 || tcg_can_emit_vec_op(op, TCG_TYPE_V128, vece))) {
+        && tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece)) {
         return TCG_TYPE_V128;
     }
     if (TCG_TARGET_HAS_v64 && !prefer_i64 && check_size_impl(size, 8)
-        && (op == 0 || tcg_can_emit_vec_op(op, TCG_TYPE_V64, vece))) {
+        && tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)) {
         return TCG_TYPE_V64;
     }
     return 0;
@@ -452,7 +520,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
     /* Implement inline with a vector type, if possible.
      * Prefer integer when 64-bit host and no variable dup.
      */
-    type = choose_vector_type(0, vece, oprsz,
+    type = choose_vector_type(NULL, vece, oprsz,
                               (TCG_TARGET_REG_BITS == 64 && in_32 == NULL
                                && (in_64 == NULL || vece == MO_64)));
     if (type != 0) {
@@ -987,6 +1055,8 @@ static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)
 {
+    const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
     TCGType type;
     uint32_t some;
 
@@ -995,7 +1065,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     switch (type) {
     case TCG_TYPE_V256:
@@ -1028,13 +1098,14 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
         } else {
             assert(g->fno != NULL);
             tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
@@ -1045,6 +1116,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, int64_t c, const GVecGen2i *g)
 {
+    const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
     TCGType type;
     uint32_t some;
 
@@ -1053,7 +1126,7 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     switch (type) {
     case TCG_TYPE_V256:
@@ -1095,13 +1168,14 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                                     maxsz, c, g->fnoi);
                 tcg_temp_free_i64(tcg_c);
             }
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
@@ -1119,9 +1193,11 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     if (type != 0) {
+        const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
         TCGv_vec t_vec = tcg_temp_new_vec(type);
         uint32_t some;
 
@@ -1159,6 +1235,7 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
             g_assert_not_reached();
         }
         tcg_temp_free_vec(t_vec);
+        tcg_swap_vecop_list(hold_list);
     } else if (g->fni8 && check_size_impl(oprsz, 8)) {
         TCGv_i64 t64 = tcg_temp_new_i64();
 
@@ -1186,6 +1263,8 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
 {
+    const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
     TCGType type;
     uint32_t some;
 
@@ -1194,7 +1273,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     switch (type) {
     case TCG_TYPE_V256:
@@ -1232,13 +1311,14 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
             assert(g->fno != NULL);
             tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz,
                                maxsz, g->data, g->fno);
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
@@ -1250,6 +1330,8 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                      uint32_t oprsz, uint32_t maxsz, int64_t c,
                      const GVecGen3i *g)
 {
+    const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
     TCGType type;
     uint32_t some;
 
@@ -1258,7 +1340,7 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     switch (type) {
     case TCG_TYPE_V256:
@@ -1296,13 +1378,14 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
         } else {
             assert(g->fno != NULL);
             tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, c, g->fno);
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
@@ -1313,6 +1396,8 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)
 {
+    const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
     TCGType type;
     uint32_t some;
 
@@ -1321,7 +1406,7 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     switch (type) {
     case TCG_TYPE_V256:
@@ -1362,13 +1447,14 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
             assert(g->fno != NULL);
             tcg_gen_gvec_4_ool(dofs, aofs, bofs, cofs,
                                oprsz, maxsz, g->data, g->fno);
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
@@ -1423,7 +1509,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
                           uint32_t oprsz, uint32_t maxsz)
 {
     if (vece <= MO_64) {
-        TCGType type = choose_vector_type(0, vece, oprsz, 0);
+        TCGType type = choose_vector_type(NULL, vece, oprsz, 0);
         if (type != 0) {
             TCGv_vec t_vec = tcg_temp_new_vec(type);
             tcg_gen_dup_mem_vec(vece, t_vec, cpu_env, aofs);
@@ -1573,6 +1659,8 @@ void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t2);
 }
 
+static const TCGOpcode vecop_list_add[] = { INDEX_op_add_vec, 0 };
+
 void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
@@ -1580,22 +1668,22 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
         { .fni8 = tcg_gen_vec_add8_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_add8,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_add16_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_add16,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_16 },
         { .fni4 = tcg_gen_add_i32,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_add32,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_32 },
         { .fni8 = tcg_gen_add_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_add64,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1611,22 +1699,22 @@ void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
         { .fni8 = tcg_gen_vec_add8_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_adds8,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_add16_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_adds16,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_16 },
         { .fni4 = tcg_gen_add_i32,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_adds32,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_32 },
         { .fni8 = tcg_gen_add_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_adds64,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1643,6 +1731,8 @@ void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_temp_free_i64(tmp);
 }
 
+static const TCGOpcode vecop_list_sub[] = { INDEX_op_sub_vec, 0 };
+
 void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
                        TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
 {
@@ -1650,22 +1740,22 @@ void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
         { .fni8 = tcg_gen_vec_sub8_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_subs8,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_sub16_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_subs16,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_16 },
         { .fni4 = tcg_gen_sub_i32,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_subs32,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_32 },
         { .fni8 = tcg_gen_sub_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_subs64,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1729,22 +1819,22 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
         { .fni8 = tcg_gen_vec_sub8_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_sub8,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_sub16_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_sub16,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_16 },
         { .fni4 = tcg_gen_sub_i32,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_sub32,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_32 },
         { .fni8 = tcg_gen_sub_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_sub64,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1753,27 +1843,29 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
+static const TCGOpcode vecop_list_mul[] = { INDEX_op_mul_vec, 0 };
+
 void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_mul8,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_8 },
         { .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_mul16,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_16 },
         { .fni4 = tcg_gen_mul_i32,
           .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_mul32,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_32 },
         { .fni8 = tcg_gen_mul_i64,
           .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_mul64,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1788,21 +1880,21 @@ void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, uint32_t aofs,
     static const GVecGen2s g[4] = {
         { .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_muls8,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_8 },
         { .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_muls16,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_16 },
         { .fni4 = tcg_gen_mul_i32,
           .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_muls32,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_32 },
         { .fni8 = tcg_gen_mul_i64,
           .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_muls64,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1822,22 +1914,23 @@ void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_ssadd_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_ssadd_vec,
           .fno = gen_helper_gvec_ssadd8,
-          .opc = INDEX_op_ssadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_ssadd_vec,
           .fno = gen_helper_gvec_ssadd16,
-          .opc = INDEX_op_ssadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fniv = tcg_gen_ssadd_vec,
           .fno = gen_helper_gvec_ssadd32,
-          .opc = INDEX_op_ssadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fniv = tcg_gen_ssadd_vec,
           .fno = gen_helper_gvec_ssadd64,
-          .opc = INDEX_op_ssadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 },
     };
     tcg_debug_assert(vece <= MO_64);
@@ -1847,22 +1940,23 @@ void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_sssub_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_sssub_vec,
           .fno = gen_helper_gvec_sssub8,
-          .opc = INDEX_op_sssub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_sssub_vec,
           .fno = gen_helper_gvec_sssub16,
-          .opc = INDEX_op_sssub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fniv = tcg_gen_sssub_vec,
           .fno = gen_helper_gvec_sssub32,
-          .opc = INDEX_op_sssub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fniv = tcg_gen_sssub_vec,
           .fno = gen_helper_gvec_sssub64,
-          .opc = INDEX_op_sssub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 },
     };
     tcg_debug_assert(vece <= MO_64);
@@ -1888,24 +1982,25 @@ static void tcg_gen_usadd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_usadd_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_usadd_vec,
           .fno = gen_helper_gvec_usadd8,
-          .opc = INDEX_op_usadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_usadd_vec,
           .fno = gen_helper_gvec_usadd16,
-          .opc = INDEX_op_usadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_usadd_i32,
           .fniv = tcg_gen_usadd_vec,
           .fno = gen_helper_gvec_usadd32,
-          .opc = INDEX_op_usadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_usadd_i64,
           .fniv = tcg_gen_usadd_vec,
           .fno = gen_helper_gvec_usadd64,
-          .opc = INDEX_op_usadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -1931,24 +2026,25 @@ static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_ussub_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_ussub_vec,
           .fno = gen_helper_gvec_ussub8,
-          .opc = INDEX_op_ussub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_ussub_vec,
           .fno = gen_helper_gvec_ussub16,
-          .opc = INDEX_op_ussub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_ussub_i32,
           .fniv = tcg_gen_ussub_vec,
           .fno = gen_helper_gvec_ussub32,
-          .opc = INDEX_op_ussub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_ussub_i64,
           .fniv = tcg_gen_ussub_vec,
           .fno = gen_helper_gvec_ussub64,
-          .opc = INDEX_op_ussub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -1958,24 +2054,25 @@ void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_smin_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_smin_vec,
           .fno = gen_helper_gvec_smin8,
-          .opc = INDEX_op_smin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_smin_vec,
           .fno = gen_helper_gvec_smin16,
-          .opc = INDEX_op_smin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_smin_i32,
           .fniv = tcg_gen_smin_vec,
           .fno = gen_helper_gvec_smin32,
-          .opc = INDEX_op_smin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_smin_i64,
           .fniv = tcg_gen_smin_vec,
           .fno = gen_helper_gvec_smin64,
-          .opc = INDEX_op_smin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -1985,24 +2082,25 @@ void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_umin_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_umin_vec,
           .fno = gen_helper_gvec_umin8,
-          .opc = INDEX_op_umin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_umin_vec,
           .fno = gen_helper_gvec_umin16,
-          .opc = INDEX_op_umin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_umin_i32,
           .fniv = tcg_gen_umin_vec,
           .fno = gen_helper_gvec_umin32,
-          .opc = INDEX_op_umin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_umin_i64,
           .fniv = tcg_gen_umin_vec,
           .fno = gen_helper_gvec_umin64,
-          .opc = INDEX_op_umin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -2012,24 +2110,25 @@ void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_smax_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_smax_vec,
           .fno = gen_helper_gvec_smax8,
-          .opc = INDEX_op_smax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_smax_vec,
           .fno = gen_helper_gvec_smax16,
-          .opc = INDEX_op_smax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_smax_i32,
           .fniv = tcg_gen_smax_vec,
           .fno = gen_helper_gvec_smax32,
-          .opc = INDEX_op_smax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_smax_i64,
           .fniv = tcg_gen_smax_vec,
           .fno = gen_helper_gvec_smax64,
-          .opc = INDEX_op_smax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -2039,24 +2138,25 @@ void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_umax_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_umax_vec,
           .fno = gen_helper_gvec_umax8,
-          .opc = INDEX_op_umax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_umax_vec,
           .fno = gen_helper_gvec_umax16,
-          .opc = INDEX_op_umax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_umax_i32,
           .fniv = tcg_gen_umax_vec,
           .fno = gen_helper_gvec_umax32,
-          .opc = INDEX_op_umax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_umax_i64,
           .fniv = tcg_gen_umax_vec,
           .fno = gen_helper_gvec_umax64,
-          .opc = INDEX_op_umax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -2110,26 +2210,27 @@ void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 b)
 void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_neg_vec, 0 };
     static const GVecGen2 g[4] = {
         { .fni8 = tcg_gen_vec_neg8_i64,
           .fniv = tcg_gen_neg_vec,
           .fno = gen_helper_gvec_neg8,
-          .opc = INDEX_op_neg_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_neg16_i64,
           .fniv = tcg_gen_neg_vec,
           .fno = gen_helper_gvec_neg16,
-          .opc = INDEX_op_neg_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_neg_i32,
           .fniv = tcg_gen_neg_vec,
           .fno = gen_helper_gvec_neg32,
-          .opc = INDEX_op_neg_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_neg_i64,
           .fniv = tcg_gen_neg_vec,
           .fno = gen_helper_gvec_neg64,
-          .opc = INDEX_op_neg_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2145,7 +2246,6 @@ void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_and_i64,
         .fniv = tcg_gen_and_vec,
         .fno = gen_helper_gvec_and,
-        .opc = INDEX_op_and_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
 
@@ -2163,7 +2263,6 @@ void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_or_i64,
         .fniv = tcg_gen_or_vec,
         .fno = gen_helper_gvec_or,
-        .opc = INDEX_op_or_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
 
@@ -2181,7 +2280,6 @@ void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_xor_i64,
         .fniv = tcg_gen_xor_vec,
         .fno = gen_helper_gvec_xor,
-        .opc = INDEX_op_xor_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
 
@@ -2199,7 +2297,6 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_andc_i64,
         .fniv = tcg_gen_andc_vec,
         .fno = gen_helper_gvec_andc,
-        .opc = INDEX_op_andc_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
 
@@ -2217,7 +2314,6 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_orc_i64,
         .fniv = tcg_gen_orc_vec,
         .fno = gen_helper_gvec_orc,
-        .opc = INDEX_op_orc_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
 
@@ -2283,7 +2379,6 @@ static const GVecGen2s gop_ands = {
     .fni8 = tcg_gen_and_i64,
     .fniv = tcg_gen_and_vec,
     .fno = gen_helper_gvec_ands,
-    .opc = INDEX_op_and_vec,
     .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     .vece = MO_64
 };
@@ -2309,7 +2404,6 @@ static const GVecGen2s gop_xors = {
     .fni8 = tcg_gen_xor_i64,
     .fniv = tcg_gen_xor_vec,
     .fno = gen_helper_gvec_xors,
-    .opc = INDEX_op_xor_vec,
     .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     .vece = MO_64
 };
@@ -2335,7 +2429,6 @@ static const GVecGen2s gop_ors = {
     .fni8 = tcg_gen_or_i64,
     .fniv = tcg_gen_or_vec,
     .fno = gen_helper_gvec_ors,
-    .opc = INDEX_op_or_vec,
     .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     .vece = MO_64
 };
@@ -2374,26 +2467,27 @@ void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_shli_vec, 0 };
     static const GVecGen2i g[4] = {
         { .fni8 = tcg_gen_vec_shl8i_i64,
           .fniv = tcg_gen_shli_vec,
           .fno = gen_helper_gvec_shl8i,
-          .opc = INDEX_op_shli_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_shl16i_i64,
           .fniv = tcg_gen_shli_vec,
           .fno = gen_helper_gvec_shl16i,
-          .opc = INDEX_op_shli_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_shli_i32,
           .fniv = tcg_gen_shli_vec,
           .fno = gen_helper_gvec_shl32i,
-          .opc = INDEX_op_shli_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_shli_i64,
           .fniv = tcg_gen_shli_vec,
           .fno = gen_helper_gvec_shl64i,
-          .opc = INDEX_op_shli_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2424,26 +2518,27 @@ void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_shri_vec, 0 };
     static const GVecGen2i g[4] = {
         { .fni8 = tcg_gen_vec_shr8i_i64,
           .fniv = tcg_gen_shri_vec,
           .fno = gen_helper_gvec_shr8i,
-          .opc = INDEX_op_shri_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_shr16i_i64,
           .fniv = tcg_gen_shri_vec,
           .fno = gen_helper_gvec_shr16i,
-          .opc = INDEX_op_shri_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_shri_i32,
           .fniv = tcg_gen_shri_vec,
           .fno = gen_helper_gvec_shr32i,
-          .opc = INDEX_op_shri_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_shri_i64,
           .fniv = tcg_gen_shri_vec,
           .fno = gen_helper_gvec_shr64i,
-          .opc = INDEX_op_shri_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2488,26 +2583,27 @@ void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_sari_vec, 0 };
     static const GVecGen2i g[4] = {
         { .fni8 = tcg_gen_vec_sar8i_i64,
           .fniv = tcg_gen_sari_vec,
           .fno = gen_helper_gvec_sar8i,
-          .opc = INDEX_op_sari_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_sar16i_i64,
           .fniv = tcg_gen_sari_vec,
           .fno = gen_helper_gvec_sar16i,
-          .opc = INDEX_op_sari_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_sari_i32,
           .fniv = tcg_gen_sari_vec,
           .fno = gen_helper_gvec_sar32i,
-          .opc = INDEX_op_sari_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_sari_i64,
           .fniv = tcg_gen_sari_vec,
           .fno = gen_helper_gvec_sar64i,
-          .opc = INDEX_op_sari_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2524,24 +2620,25 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_shlv_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_shlv_vec,
           .fno = gen_helper_gvec_shl8v,
-          .opc = INDEX_op_shlv_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_shlv_vec,
           .fno = gen_helper_gvec_shl16v,
-          .opc = INDEX_op_shlv_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_shl_i32,
           .fniv = tcg_gen_shlv_vec,
           .fno = gen_helper_gvec_shl32v,
-          .opc = INDEX_op_shlv_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_shl_i64,
           .fniv = tcg_gen_shlv_vec,
           .fno = gen_helper_gvec_shl64v,
-          .opc = INDEX_op_shlv_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2553,24 +2650,25 @@ void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_shrv_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_shrv_vec,
           .fno = gen_helper_gvec_shr8v,
-          .opc = INDEX_op_shrv_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_shrv_vec,
           .fno = gen_helper_gvec_shr16v,
-          .opc = INDEX_op_shrv_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_shr_i32,
           .fniv = tcg_gen_shrv_vec,
           .fno = gen_helper_gvec_shr32v,
-          .opc = INDEX_op_shrv_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_shr_i64,
           .fniv = tcg_gen_shrv_vec,
           .fno = gen_helper_gvec_shr64v,
-          .opc = INDEX_op_shrv_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2582,24 +2680,25 @@ void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_sarv_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_sarv_vec,
           .fno = gen_helper_gvec_sar8v,
-          .opc = INDEX_op_sarv_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_sarv_vec,
           .fno = gen_helper_gvec_sar16v,
-          .opc = INDEX_op_sarv_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_sar_i32,
           .fniv = tcg_gen_sarv_vec,
           .fno = gen_helper_gvec_sar32v,
-          .opc = INDEX_op_sarv_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_sar_i64,
           .fniv = tcg_gen_sarv_vec,
           .fno = gen_helper_gvec_sar64v,
-          .opc = INDEX_op_sarv_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2667,6 +2766,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
                       uint32_t aofs, uint32_t bofs,
                       uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode cmp_list[] = { INDEX_op_cmp_vec, 0 };
     static gen_helper_gvec_3 * const eq_fn[4] = {
         gen_helper_gvec_eq8, gen_helper_gvec_eq16,
         gen_helper_gvec_eq32, gen_helper_gvec_eq64
@@ -2699,6 +2799,8 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
         [TCG_COND_LTU] = ltu_fn,
         [TCG_COND_LEU] = leu_fn,
     };
+
+    const TCGOpcode *hold_list;
     TCGType type;
     uint32_t some;
 
@@ -2711,10 +2813,12 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
         return;
     }
 
-    /* Implement inline with a vector type, if possible.
+    /*
+     * Implement inline with a vector type, if possible.
      * Prefer integer when 64-bit host and 64-bit comparison.
      */
-    type = choose_vector_type(INDEX_op_cmp_vec, vece, oprsz,
+    hold_list = tcg_swap_vecop_list(cmp_list);
+    type = choose_vector_type(cmp_list, vece, oprsz,
                               TCG_TARGET_REG_BITS == 64 && vece == MO_64);
     switch (type) {
     case TCG_TYPE_V256:
@@ -2756,13 +2860,14 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
                 assert(fn != NULL);
             }
             tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, fn[vece]);
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 6601cb8a8f..8d80e37f72 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -307,11 +307,14 @@ static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
     int can;
 
     tcg_debug_assert(at->base_type >= type);
+    tcg_assert_listed_vecop(opc);
     can = tcg_can_emit_vec_op(opc, type, vece);
     if (can > 0) {
         vec_gen_2(opc, type, vece, ri, ai);
     } else if (can < 0) {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_expand_vec_op(opc, type, vece, ri, ai);
+        tcg_swap_vecop_list(hold_list);
     } else {
         return false;
     }
@@ -329,11 +332,17 @@ void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
+    const TCGOpcode *hold_list;
+
+    tcg_assert_listed_vecop(INDEX_op_neg_vec);
+    hold_list = tcg_swap_vecop_list(NULL);
+
     if (!TCG_TARGET_HAS_neg_vec || !do_op2(vece, r, a, INDEX_op_neg_vec)) {
         TCGv_vec t = tcg_const_zeros_vec_matching(r);
         tcg_gen_sub_vec(vece, r, t, a);
         tcg_temp_free_vec(t);
     }
+    tcg_swap_vecop_list(hold_list);
 }
 
 static void do_shifti(TCGOpcode opc, unsigned vece,
@@ -348,6 +357,7 @@ static void do_shifti(TCGOpcode opc, unsigned vece,
 
     tcg_debug_assert(at->base_type == type);
     tcg_debug_assert(i >= 0 && i < (8 << vece));
+    tcg_assert_listed_vecop(opc);
 
     if (i == 0) {
         tcg_gen_mov_vec(r, a);
@@ -361,8 +371,10 @@ static void do_shifti(TCGOpcode opc, unsigned vece,
         /* We leave the choice of expansion via scalar or vector shift
            to the target.  Often, but not always, dupi can feed a vector
            shift easier than a scalar.  */
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_debug_assert(can < 0);
         tcg_expand_vec_op(opc, type, vece, ri, ai, i);
+        tcg_swap_vecop_list(hold_list);
     }
 }
 
@@ -395,12 +407,15 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
 
     tcg_debug_assert(at->base_type >= type);
     tcg_debug_assert(bt->base_type >= type);
+    tcg_assert_listed_vecop(INDEX_op_cmp_vec);
     can = tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece);
     if (can > 0) {
         vec_gen_4(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
     } else {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_debug_assert(can < 0);
         tcg_expand_vec_op(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
+        tcg_swap_vecop_list(hold_list);
     }
 }
 
@@ -418,12 +433,15 @@ static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
 
     tcg_debug_assert(at->base_type >= type);
     tcg_debug_assert(bt->base_type >= type);
+    tcg_assert_listed_vecop(opc);
     can = tcg_can_emit_vec_op(opc, type, vece);
     if (can > 0) {
         vec_gen_3(opc, type, vece, ri, ai, bi);
     } else {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_debug_assert(can < 0);
         tcg_expand_vec_op(opc, type, vece, ri, ai, bi);
+        tcg_swap_vecop_list(hold_list);
     }
 }
 
-- 
2.17.1
