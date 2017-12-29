Received: from eggs.gnu.org ([2001:4830:134:3::10]:42802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NK-0000lh-4H
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NG-0000D8-Cf
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:26 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:41029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eV0NG-0000B8-2H
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:22 -0500
Received: by mail-pl0-x243.google.com with SMTP id g2so23446735pli.8
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 11:31:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Dec 2017 11:31:08 -0800
Message-Id: <20171229193113.11753-4-richard.henderson@linaro.org>
In-Reply-To: <20171229193113.11753-1-richard.henderson@linaro.org>
References: <20171229193113.11753-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/8] tcg: Remove TCGV_UNUSED* and TCGV_IS_UNUSED*
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

These are now trivial sets and tests against NULL.  Unwrap.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h                 |  4 ---
 tcg/tcg.h                    |  9 -------
 target/alpha/translate.c     | 22 ++++++++--------
 target/arm/translate-a64.c   | 35 +++++++++++-------------
 target/arm/translate.c       | 29 ++++++++++----------
 target/cris/translate.c      |  2 +-
 target/hppa/translate.c      | 63 ++++++++++++++++++++++----------------------
 target/i386/translate.c      | 13 +++++----
 target/m68k/translate.c      | 14 +++++-----
 target/mips/translate.c      |  2 +-
 target/nios2/translate.c     |  6 ++---
 target/ppc/translate.c       |  2 +-
 target/s390x/translate.c     | 42 ++++++++++++++---------------
 target/sh4/translate.c       |  2 +-
 target/sparc/translate.c     |  2 +-
 target/tilegx/translate.c    | 10 +++----
 target/unicore32/translate.c |  4 +--
 tcg/tcg.c                    |  4 +--
 18 files changed, 122 insertions(+), 143 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 3129159907..ca07b32b65 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -807,8 +807,6 @@ void tcg_gen_lookup_and_goto_ptr(void);
 #define tcg_global_mem_new tcg_global_mem_new_i32
 #define tcg_temp_local_new() tcg_temp_local_new_i32()
 #define tcg_temp_free tcg_temp_free_i32
-#define TCGV_UNUSED(x) TCGV_UNUSED_I32(x)
-#define TCGV_IS_UNUSED(x) TCGV_IS_UNUSED_I32(x)
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
 #else
@@ -817,8 +815,6 @@ void tcg_gen_lookup_and_goto_ptr(void);
 #define tcg_global_mem_new tcg_global_mem_new_i64
 #define tcg_temp_local_new() tcg_temp_local_new_i64()
 #define tcg_temp_free tcg_temp_free_i64
-#define TCGV_UNUSED(x) TCGV_UNUSED_I64(x)
-#define TCGV_IS_UNUSED(x) TCGV_IS_UNUSED_I64(x)
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
 #endif
diff --git a/tcg/tcg.h b/tcg/tcg.h
index cb7b329876..c21194c858 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -428,15 +428,6 @@ typedef TCGv_ptr TCGv_env;
 #error Unhandled TARGET_LONG_BITS value
 #endif
 
-/* See the comment before tcgv_i32_temp.  */
-#define TCGV_UNUSED_I32(x) (x = (TCGv_i32)NULL)
-#define TCGV_UNUSED_I64(x) (x = (TCGv_i64)NULL)
-#define TCGV_UNUSED_PTR(x) (x = (TCGv_ptr)NULL)
-
-#define TCGV_IS_UNUSED_I32(x) ((x) == (TCGv_i32)NULL)
-#define TCGV_IS_UNUSED_I64(x) ((x) == (TCGv_i64)NULL)
-#define TCGV_IS_UNUSED_PTR(x) ((x) == (TCGv_ptr)NULL)
-
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
    implies TCG_CALL_NO_WRITE_GLOBALS. */
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 629f35ec8e..73a1b5e63e 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -156,7 +156,7 @@ void alpha_translate_init(void)
 
 static TCGv load_zero(DisasContext *ctx)
 {
-    if (TCGV_IS_UNUSED_I64(ctx->zero)) {
+    if (!ctx->zero) {
         ctx->zero = tcg_const_i64(0);
     }
     return ctx->zero;
@@ -164,7 +164,7 @@ static TCGv load_zero(DisasContext *ctx)
 
 static TCGv dest_sink(DisasContext *ctx)
 {
-    if (TCGV_IS_UNUSED_I64(ctx->sink)) {
+    if (!ctx->sink) {
         ctx->sink = tcg_temp_new();
     }
     return ctx->sink;
@@ -172,18 +172,18 @@ static TCGv dest_sink(DisasContext *ctx)
 
 static void free_context_temps(DisasContext *ctx)
 {
-    if (!TCGV_IS_UNUSED_I64(ctx->sink)) {
+    if (ctx->sink) {
         tcg_gen_discard_i64(ctx->sink);
         tcg_temp_free(ctx->sink);
-        TCGV_UNUSED_I64(ctx->sink);
+        ctx->sink = NULL;
     }
-    if (!TCGV_IS_UNUSED_I64(ctx->zero)) {
+    if (ctx->zero) {
         tcg_temp_free(ctx->zero);
-        TCGV_UNUSED_I64(ctx->zero);
+        ctx->zero = NULL;
     }
-    if (!TCGV_IS_UNUSED_I64(ctx->lit)) {
+    if (ctx->lit) {
         tcg_temp_free(ctx->lit);
-        TCGV_UNUSED_I64(ctx->lit);
+        ctx->lit = NULL;
     }
 }
 
@@ -2948,9 +2948,9 @@ static int alpha_tr_init_disas_context(DisasContextBase *dcbase,
     /* Similarly for flush-to-zero.  */
     ctx->tb_ftz = -1;
 
-    TCGV_UNUSED_I64(ctx->zero);
-    TCGV_UNUSED_I64(ctx->sink);
-    TCGV_UNUSED_I64(ctx->lit);
+    ctx->zero = NULL;
+    ctx->sink = NULL;
+    ctx->lit = NULL;
 
     /* Bound the number of insns to execute to those left on the page.  */
     if (in_superpage(ctx, ctx->base.pc_first)) {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 625ef2dfd2..460bab5987 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -405,10 +405,7 @@ static void unallocated_encoding(DisasContext *s)
 static void init_tmp_a64_array(DisasContext *s)
 {
 #ifdef CONFIG_DEBUG_TCG
-    int i;
-    for (i = 0; i < ARRAY_SIZE(s->tmp_a64); i++) {
-        TCGV_UNUSED_I64(s->tmp_a64[i]);
-    }
+    memset(s->tmp_a64, 0, sizeof(s->tmp_a64));
 #endif
     s->tmp_a64_count = 0;
 }
@@ -6276,7 +6273,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
             return;
         }
 
-        TCGV_UNUSED_PTR(fpst);
+        fpst = NULL;
         break;
     case 0xc: /* FMAXNMP */
     case 0xd: /* FADDP */
@@ -6371,7 +6368,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
         tcg_temp_free_i32(tcg_res);
     }
 
-    if (!TCGV_IS_UNUSED_PTR(fpst)) {
+    if (fpst) {
         tcg_temp_free_ptr(fpst);
     }
 }
@@ -6387,7 +6384,7 @@ static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
                                     bool is_u, int size, int shift)
 {
     bool extended_result = false;
-    bool round = !TCGV_IS_UNUSED_I64(tcg_rnd);
+    bool round = tcg_rnd != NULL;
     int ext_lshift = 0;
     TCGv_i64 tcg_src_hi;
 
@@ -6533,7 +6530,7 @@ static void handle_scalar_simd_shri(DisasContext *s,
         uint64_t round_const = 1ULL << (shift - 1);
         tcg_round = tcg_const_i64(round_const);
     } else {
-        TCGV_UNUSED_I64(tcg_round);
+        tcg_round = NULL;
     }
 
     tcg_rn = read_fp_dreg(s, rn);
@@ -6649,7 +6646,7 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
         uint64_t round_const = 1ULL << (shift - 1);
         tcg_round = tcg_const_i64(round_const);
     } else {
-        TCGV_UNUSED_I64(tcg_round);
+        tcg_round = NULL;
     }
 
     for (i = 0; i < elements; i++) {
@@ -8239,8 +8236,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
         tcg_fpstatus = get_fpstatus_ptr();
     } else {
-        TCGV_UNUSED_I32(tcg_rmode);
-        TCGV_UNUSED_PTR(tcg_fpstatus);
+        tcg_rmode = NULL;
+        tcg_fpstatus = NULL;
     }
 
     if (size == 3) {
@@ -8360,7 +8357,7 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         uint64_t round_const = 1ULL << (shift - 1);
         tcg_round = tcg_const_i64(round_const);
     } else {
-        TCGV_UNUSED_I64(tcg_round);
+        tcg_round = NULL;
     }
 
     for (i = 0; i < elements; i++) {
@@ -8502,7 +8499,7 @@ static void handle_vec_simd_shrn(DisasContext *s, bool is_q,
         uint64_t round_const = 1ULL << (shift - 1);
         tcg_round = tcg_const_i64(round_const);
     } else {
-        TCGV_UNUSED_I64(tcg_round);
+        tcg_round = NULL;
     }
 
     for (i = 0; i < elements; i++) {
@@ -9168,7 +9165,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
     if (opcode >= 0x58) {
         fpst = get_fpstatus_ptr();
     } else {
-        TCGV_UNUSED_PTR(fpst);
+        fpst = NULL;
     }
 
     if (!fp_access_check(s)) {
@@ -9305,7 +9302,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
         }
     }
 
-    if (!TCGV_IS_UNUSED_PTR(fpst)) {
+    if (fpst) {
         tcg_temp_free_ptr(fpst);
     }
 }
@@ -10226,13 +10223,13 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     if (need_fpstatus) {
         tcg_fpstatus = get_fpstatus_ptr();
     } else {
-        TCGV_UNUSED_PTR(tcg_fpstatus);
+        tcg_fpstatus = NULL;
     }
     if (need_rmode) {
         tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
         gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
     } else {
-        TCGV_UNUSED_I32(tcg_rmode);
+        tcg_rmode = NULL;
     }
 
     if (size == 3) {
@@ -10593,7 +10590,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     if (is_fp) {
         fpst = get_fpstatus_ptr();
     } else {
-        TCGV_UNUSED_PTR(fpst);
+        fpst = NULL;
     }
 
     if (size == 3) {
@@ -10917,7 +10914,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
     }
 
-    if (!TCGV_IS_UNUSED_PTR(fpst)) {
+    if (fpst) {
         tcg_temp_free_ptr(fpst);
     }
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e15192d5d6..46c25ae2c1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2169,8 +2169,8 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
             tmp3 = tcg_const_i32((insn & 1) << 5);
             break;
         default:
-            TCGV_UNUSED_I32(tmp2);
-            TCGV_UNUSED_I32(tmp3);
+            tmp2 = NULL;
+            tmp3 = NULL;
         }
         gen_helper_iwmmxt_insr(cpu_M0, cpu_M0, tmp, tmp2, tmp3);
         tcg_temp_free_i32(tmp3);
@@ -4939,7 +4939,7 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
                         }
                     } else /* size == 0 */ {
                         if (load) {
-                            TCGV_UNUSED_I32(tmp2);
+                            tmp2 = NULL;
                             for (n = 0; n < 4; n++) {
                                 tmp = tcg_temp_new_i32();
                                 gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
@@ -6643,11 +6643,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     tmp = neon_load_reg(rn, 1);
                     neon_store_scratch(2, tmp);
                 }
-                TCGV_UNUSED_I32(tmp3);
+                tmp3 = NULL;
                 for (pass = 0; pass < 2; pass++) {
                     if (src1_wide) {
                         neon_load_reg64(cpu_V0, rn + pass);
-                        TCGV_UNUSED_I32(tmp);
+                        tmp = NULL;
                     } else {
                         if (pass == 1 && rd == rn) {
                             tmp = neon_load_scratch(2);
@@ -6660,7 +6660,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     if (src2_wide) {
                         neon_load_reg64(cpu_V1, rm + pass);
-                        TCGV_UNUSED_I32(tmp2);
+                        tmp2 = NULL;
                     } else {
                         if (pass == 1 && rd == rm) {
                             tmp2 = neon_load_scratch(2);
@@ -7078,7 +7078,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     if (rm & 1) {
                         return 1;
                     }
-                    TCGV_UNUSED_I32(tmp2);
+                    tmp2 = NULL;
                     for (pass = 0; pass < 2; pass++) {
                         neon_load_reg64(cpu_V0, rm + pass);
                         tmp = tcg_temp_new_i32();
@@ -7217,7 +7217,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         if (neon_2rm_is_float_op(op)) {
                             tcg_gen_ld_f32(cpu_F0s, cpu_env,
                                            neon_reg_offset(rm, pass));
-                            TCGV_UNUSED_I32(tmp);
+                            tmp = NULL;
                         } else {
                             tmp = neon_load_reg(rm, pass);
                         }
@@ -8666,7 +8666,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             rn = (insn >> 16) & 0xf;
             tmp = load_reg(s, rn);
         } else {
-            TCGV_UNUSED_I32(tmp);
+            tmp = NULL;
         }
         rd = (insn >> 12) & 0xf;
         switch(op1) {
@@ -9505,7 +9505,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
 
                 /* compute total size */
                 loaded_base = 0;
-                TCGV_UNUSED_I32(loaded_var);
+                loaded_var = NULL;
                 n = 0;
                 for(i=0;i<16;i++) {
                     if (insn & (1 << i))
@@ -10074,7 +10074,7 @@ static int disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     tcg_gen_addi_i32(addr, addr, -offset);
                 }
 
-                TCGV_UNUSED_I32(loaded_var);
+                loaded_var = NULL;
                 for (i = 0; i < 16; i++) {
                     if ((insn & (1 << i)) == 0)
                         continue;
@@ -11355,7 +11355,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         } else if (op != 0xf) { /* mvn doesn't read its first operand */
             tmp = load_reg(s, rd);
         } else {
-            TCGV_UNUSED_I32(tmp);
+            tmp = NULL;
         }
 
         tmp2 = load_reg(s, rm);
@@ -11686,7 +11686,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                     tcg_gen_addi_i32(addr, addr, 4);
                 }
             }
-            TCGV_UNUSED_I32(tmp);
+            tmp = NULL;
             if (insn & (1 << 8)) {
                 if (insn & (1 << 11)) {
                     /* pop pc */
@@ -11831,8 +11831,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 12:
     {
         /* load/store multiple */
-        TCGv_i32 loaded_var;
-        TCGV_UNUSED_I32(loaded_var);
+        TCGv_i32 loaded_var = NULL;
         rn = (insn >> 8) & 0x7;
         addr = load_reg(s, rn);
         for (i = 0; i < 8; i++) {
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 2831419845..74822ed31f 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -2603,7 +2603,7 @@ static int dec_movem_mr(CPUCRISState *env, DisasContext *dc)
         tcg_gen_addi_tl(addr, cpu_R[dc->op1], i * 8);
         gen_load(dc, tmp32, addr, 4, 0);
     } else {
-        TCGV_UNUSED(tmp32);
+        tmp32 = NULL;
     }
     tcg_temp_free(addr);
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 53aa1f88c4..31d9a2a31b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -125,7 +125,7 @@ void hppa_translate_init(void)
 
     int i;
 
-    TCGV_UNUSED(cpu_gr[0]);
+    cpu_gr[0] = NULL;
     for (i = 1; i < 32; i++) {
         cpu_gr[i] = tcg_global_mem_new(cpu_env,
                                        offsetof(CPUHPPAState, gr[i]),
@@ -140,28 +140,31 @@ void hppa_translate_init(void)
 
 static DisasCond cond_make_f(void)
 {
-    DisasCond r = { .c = TCG_COND_NEVER };
-    TCGV_UNUSED(r.a0);
-    TCGV_UNUSED(r.a1);
-    return r;
+    return (DisasCond){
+        .c = TCG_COND_NEVER,
+        .a0 = NULL,
+        .a1 = NULL,
+    };
 }
 
 static DisasCond cond_make_n(void)
 {
-    DisasCond r = { .c = TCG_COND_NE, .a0_is_n = true, .a1_is_0 = true };
-    r.a0 = cpu_psw_n;
-    TCGV_UNUSED(r.a1);
-    return r;
+    return (DisasCond){
+        .c = TCG_COND_NE,
+        .a0 = cpu_psw_n,
+        .a0_is_n = true,
+        .a1 = NULL,
+        .a1_is_0 = true
+    };
 }
 
 static DisasCond cond_make_0(TCGCond c, TCGv a0)
 {
-    DisasCond r = { .c = c, .a1_is_0 = true };
+    DisasCond r = { .c = c, .a1 = NULL, .a1_is_0 = true };
 
     assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
     r.a0 = tcg_temp_new();
     tcg_gen_mov_tl(r.a0, a0);
-    TCGV_UNUSED(r.a1);
 
     return r;
 }
@@ -199,8 +202,8 @@ static void cond_free(DisasCond *cond)
         }
         cond->a0_is_n = false;
         cond->a1_is_0 = false;
-        TCGV_UNUSED(cond->a0);
-        TCGV_UNUSED(cond->a1);
+        cond->a0 = NULL;
+        cond->a1 = NULL;
         /* fallthru */
     case TCG_COND_ALWAYS:
         cond->c = TCG_COND_NEVER;
@@ -716,9 +719,8 @@ static DisasCond do_sed_cond(unsigned orig, TCGv res)
 static DisasCond do_unit_cond(unsigned cf, TCGv res, TCGv in1, TCGv in2)
 {
     DisasCond cond;
-    TCGv tmp, cb;
+    TCGv tmp, cb = NULL;
 
-    TCGV_UNUSED(cb);
     if (cf & 8) {
         /* Since we want to test lots of carry-out bits all at once, do not
          * do our normal thing and compute carry-in of bit B+1 since that
@@ -826,8 +828,8 @@ static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     DisasCond cond;
 
     dest = tcg_temp_new();
-    TCGV_UNUSED(cb);
-    TCGV_UNUSED(cb_msb);
+    cb = NULL;
+    cb_msb = NULL;
 
     if (shift) {
         tmp = get_temp(ctx);
@@ -856,7 +858,7 @@ static DisasJumpType do_add(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     }
 
     /* Compute signed overflow if required.  */
-    TCGV_UNUSED(sv);
+    sv = NULL;
     if (is_tsv || c == 6) {
         sv = do_add_sv(ctx, dest, in1, in2);
         if (is_tsv) {
@@ -919,7 +921,7 @@ static DisasJumpType do_sub(DisasContext *ctx, unsigned rt, TCGv in1, TCGv in2,
     tcg_temp_free(zero);
 
     /* Compute signed overflow if required.  */
-    TCGV_UNUSED(sv);
+    sv = NULL;
     if (is_tsv || c == 6) {
         sv = do_sub_sv(ctx, dest, in1, in2);
         if (is_tsv) {
@@ -965,7 +967,7 @@ static DisasJumpType do_cmpclr(DisasContext *ctx, unsigned rt, TCGv in1,
     tcg_gen_sub_tl(dest, in1, in2);
 
     /* Compute signed overflow if required.  */
-    TCGV_UNUSED(sv);
+    sv = NULL;
     if ((cf >> 1) == 6) {
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
@@ -2070,8 +2072,7 @@ static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
 
     /* Install the new nullification.  */
     if (cf) {
-        TCGv sv;
-        TCGV_UNUSED(sv);
+        TCGv sv = NULL;
         if (cf >> 1 == 6) {
             /* ??? The lshift is supposed to contribute to overflow.  */
             sv = do_add_sv(ctx, dest, add1, add2);
@@ -2542,7 +2543,7 @@ static DisasJumpType trans_cmpb(DisasContext *ctx, uint32_t insn,
 
     tcg_gen_sub_tl(dest, in1, in2);
 
-    TCGV_UNUSED(sv);
+    sv = NULL;
     if (c == 6) {
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
@@ -2571,8 +2572,8 @@ static DisasJumpType trans_addb(DisasContext *ctx, uint32_t insn,
     }
     in2 = load_gpr(ctx, r);
     dest = dest_gpr(ctx, r);
-    TCGV_UNUSED(sv);
-    TCGV_UNUSED(cb_msb);
+    sv = NULL;
+    cb_msb = NULL;
 
     switch (c) {
     default:
@@ -3732,18 +3733,16 @@ static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     TranslationBlock *tb = ctx->base.tb;
-    int i, bound;
+    int bound;
 
     ctx->cs = cs;
     ctx->iaoq_f = tb->pc;
     ctx->iaoq_b = tb->cs_base;
     ctx->iaoq_n = -1;
-    TCGV_UNUSED(ctx->iaoq_n_var);
+    ctx->iaoq_n_var = NULL;
 
     ctx->ntemps = 0;
-    for (i = 0; i < ARRAY_SIZE(ctx->temps); ++i) {
-        TCGV_UNUSED(ctx->temps[i]);
-    }
+    memset(ctx->temps, 0, sizeof(ctx->temps));
 
     bound = -(tb->pc | TARGET_PAGE_MASK) / 4;
     return MIN(max_insns, bound);
@@ -3804,7 +3803,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
             tcg_gen_addi_tl(ctx->iaoq_n_var, cpu_iaoq_b, 4);
         } else {
             ctx->iaoq_n = ctx->iaoq_b + 4;
-            TCGV_UNUSED(ctx->iaoq_n_var);
+            ctx->iaoq_n_var = NULL;
         }
 
         if (unlikely(ctx->null_cond.c == TCG_COND_ALWAYS)) {
@@ -3819,7 +3818,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     /* Free any temporaries allocated.  */
     for (i = 0, n = ctx->ntemps; i < n; ++i) {
         tcg_temp_free(ctx->temps[i]);
-        TCGV_UNUSED(ctx->temps[i]);
+        ctx->temps[i] = NULL;
     }
     ctx->ntemps = 0;
 
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 23d7eec964..0135415d92 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -689,7 +689,7 @@ static void gen_compute_eflags(DisasContext *s)
         return;
     }
 
-    TCGV_UNUSED(zero);
+    zero = NULL;
     dst = cpu_cc_dst;
     src1 = cpu_cc_src;
     src2 = cpu_cc_src2;
@@ -2050,9 +2050,8 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
 /* Compute the address, with a minimum number of TCG ops.  */
 static TCGv gen_lea_modrm_1(AddressParts a)
 {
-    TCGv ea;
+    TCGv ea = NULL;
 
-    TCGV_UNUSED(ea);
     if (a.index >= 0) {
         if (a.scale == 0) {
             ea = cpu_regs[a.index];
@@ -2067,7 +2066,7 @@ static TCGv gen_lea_modrm_1(AddressParts a)
     } else if (a.base >= 0) {
         ea = cpu_regs[a.base];
     }
-    if (TCGV_IS_UNUSED(ea)) {
+    if (!ea) {
         tcg_gen_movi_tl(cpu_A0, a.disp);
         ea = cpu_A0;
     } else if (a.disp != 0) {
@@ -3951,7 +3950,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
 
                     /* Re-use the carry-out from a previous round.  */
-                    TCGV_UNUSED(carry_in);
+                    carry_in = NULL;
                     carry_out = (b == 0x1f6 ? cpu_cc_dst : cpu_cc_src2);
                     switch (s->cc_op) {
                     case CC_OP_ADCX:
@@ -3979,7 +3978,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                         break;
                     }
                     /* If we can't reuse carry-out, get it out of EFLAGS.  */
-                    if (TCGV_IS_UNUSED(carry_in)) {
+                    if (!carry_in) {
                         if (s->cc_op != CC_OP_ADCX && s->cc_op != CC_OP_ADOX) {
                             gen_compute_eflags(s);
                         }
@@ -7673,7 +7672,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 tcg_gen_mov_tl(a0, cpu_A0);
             } else {
                 gen_op_mov_v_reg(ot, t0, rm);
-                TCGV_UNUSED(a0);
+                a0 = NULL;
             }
             gen_op_mov_v_reg(ot, t1, reg);
             tcg_gen_andi_tl(cpu_tmp0, t0, 3);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index bbda7399ec..09226eba81 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3948,8 +3948,8 @@ DISAS_INSN(bfop_reg)
     int ofs = extract32(ext, 6, 5);  /* big bit-endian */
     TCGv mask, tofs, tlen;
 
-    TCGV_UNUSED(tofs);
-    TCGV_UNUSED(tlen);
+    tofs = NULL;
+    tlen = NULL;
     if ((insn & 0x0f00) == 0x0d00) { /* bfffo */
         tofs = tcg_temp_new();
         tlen = tcg_temp_new();
@@ -3965,7 +3965,7 @@ DISAS_INSN(bfop_reg)
         }
         tcg_gen_andi_i32(QREG_CC_N, QREG_CC_N, ~maski);
         mask = tcg_const_i32(ror32(maski, ofs));
-        if (!TCGV_IS_UNUSED(tofs)) {
+        if (tofs) {
             tcg_gen_movi_i32(tofs, ofs);
             tcg_gen_movi_i32(tlen, len);
         }
@@ -3977,13 +3977,13 @@ DISAS_INSN(bfop_reg)
             tcg_gen_andi_i32(tmp, tmp, 31);
             mask = tcg_const_i32(0x7fffffffu);
             tcg_gen_shr_i32(mask, mask, tmp);
-            if (!TCGV_IS_UNUSED(tlen)) {
+            if (tlen) {
                 tcg_gen_addi_i32(tlen, tmp, 1);
             }
         } else {
             /* Immediate width */
             mask = tcg_const_i32(0x7fffffffu >> (len - 1));
-            if (!TCGV_IS_UNUSED(tlen)) {
+            if (tlen) {
                 tcg_gen_movi_i32(tlen, len);
             }
         }
@@ -3993,7 +3993,7 @@ DISAS_INSN(bfop_reg)
             tcg_gen_rotl_i32(QREG_CC_N, src, tmp);
             tcg_gen_andc_i32(QREG_CC_N, QREG_CC_N, mask);
             tcg_gen_rotr_i32(mask, mask, tmp);
-            if (!TCGV_IS_UNUSED(tofs)) {
+            if (tofs) {
                 tcg_gen_mov_i32(tofs, tmp);
             }
         } else {
@@ -4001,7 +4001,7 @@ DISAS_INSN(bfop_reg)
             tcg_gen_rotli_i32(QREG_CC_N, src, ofs);
             tcg_gen_andc_i32(QREG_CC_N, QREG_CC_N, mask);
             tcg_gen_rotri_i32(mask, mask, ofs);
-            if (!TCGV_IS_UNUSED(tofs)) {
+            if (tofs) {
                 tcg_gen_movi_i32(tofs, ofs);
             }
         }
diff --git a/target/mips/translate.c b/target/mips/translate.c
index b022f840c9..d05ee67e63 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20453,7 +20453,7 @@ void mips_tcg_init(void)
 {
     int i;
 
-    TCGV_UNUSED(cpu_gpr[0]);
+    cpu_gpr[0] = NULL;
     for (i = 1; i < 32; i++)
         cpu_gpr[i] = tcg_global_mem_new(cpu_env,
                                         offsetof(CPUMIPSState, active_tc.gpr[i]),
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 51a54ff760..cb8624e8d2 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -125,7 +125,7 @@ static uint8_t get_opxcode(uint32_t code)
 
 static TCGv load_zero(DisasContext *dc)
 {
-    if (TCGV_IS_UNUSED_I32(dc->zero)) {
+    if (!dc->zero) {
         dc->zero = tcg_const_i32(0);
     }
     return dc->zero;
@@ -755,12 +755,12 @@ static void handle_instruction(DisasContext *dc, CPUNios2State *env)
         goto illegal_op;
     }
 
-    TCGV_UNUSED_I32(dc->zero);
+    dc->zero = NULL;
 
     instr = &i_type_instructions[op];
     instr->handler(dc, code, instr->flags);
 
-    if (!TCGV_IS_UNUSED_I32(dc->zero)) {
+    if (dc->zero) {
         tcg_temp_free(dc->zero);
     }
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4075fc8589..0ef21cce33 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3495,7 +3495,7 @@ static void gen_bcond(DisasContext *ctx, int type)
         else
             tcg_gen_mov_tl(target, cpu_lr);
     } else {
-        TCGV_UNUSED(target);
+        target = NULL;
     }
     if (LK(ctx->opcode))
         gen_setlr(ctx, ctx->nip);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index eede2ed157..ac55886792 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -434,11 +434,9 @@ static void set_cc_static(DisasContext *s)
 /* calculates cc into cc_op */
 static void gen_op_calc_cc(DisasContext *s)
 {
-    TCGv_i32 local_cc_op;
-    TCGv_i64 dummy;
+    TCGv_i32 local_cc_op = NULL;
+    TCGv_i64 dummy = NULL;
 
-    TCGV_UNUSED_I32(local_cc_op);
-    TCGV_UNUSED_I64(dummy);
     switch (s->cc_op) {
     default:
         dummy = tcg_const_i64(0);
@@ -528,10 +526,10 @@ static void gen_op_calc_cc(DisasContext *s)
         tcg_abort();
     }
 
-    if (!TCGV_IS_UNUSED_I32(local_cc_op)) {
+    if (local_cc_op) {
         tcg_temp_free_i32(local_cc_op);
     }
-    if (!TCGV_IS_UNUSED_I64(dummy)) {
+    if (dummy) {
         tcg_temp_free_i64(dummy);
     }
 
@@ -1189,7 +1187,7 @@ static ExitStatus help_branch(DisasContext *s, DisasCompare *c,
             goto egress;
         }
     } else {
-        if (TCGV_IS_UNUSED_I64(cdest)) {
+        if (!cdest) {
             /* E.g. bcr %r0 -> no branch.  */
             ret = NO_EXIT;
             goto egress;
@@ -1451,7 +1449,7 @@ static ExitStatus op_ni(DisasContext *s, DisasOps *o)
 static ExitStatus op_bas(DisasContext *s, DisasOps *o)
 {
     tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->next_pc));
-    if (!TCGV_IS_UNUSED_I64(o->in2)) {
+    if (o->in2) {
         tcg_gen_mov_i64(psw_addr, o->in2);
         per_branch(s, false);
         return EXIT_PC_UPDATED;
@@ -3031,7 +3029,7 @@ static ExitStatus op_mov2(DisasContext *s, DisasOps *o)
 {
     o->out = o->in2;
     o->g_out = o->g_in2;
-    TCGV_UNUSED_I64(o->in2);
+    o->in2 = NULL;
     o->g_in2 = false;
     return NO_EXIT;
 }
@@ -3043,7 +3041,7 @@ static ExitStatus op_mov2e(DisasContext *s, DisasOps *o)
 
     o->out = o->in2;
     o->g_out = o->g_in2;
-    TCGV_UNUSED_I64(o->in2);
+    o->in2 = NULL;
     o->g_in2 = false;
 
     switch (s->tb->flags & FLAG_MASK_ASC) {
@@ -3077,8 +3075,8 @@ static ExitStatus op_movx(DisasContext *s, DisasOps *o)
     o->out2 = o->in2;
     o->g_out = o->g_in1;
     o->g_out2 = o->g_in2;
-    TCGV_UNUSED_I64(o->in1);
-    TCGV_UNUSED_I64(o->in2);
+    o->in1 = NULL;
+    o->in2 = NULL;
     o->g_in1 = o->g_in2 = false;
     return NO_EXIT;
 }
@@ -5945,11 +5943,11 @@ static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
     s->insn = insn;
     s->fields = &f;
     o.g_out = o.g_out2 = o.g_in1 = o.g_in2 = false;
-    TCGV_UNUSED_I64(o.out);
-    TCGV_UNUSED_I64(o.out2);
-    TCGV_UNUSED_I64(o.in1);
-    TCGV_UNUSED_I64(o.in2);
-    TCGV_UNUSED_I64(o.addr1);
+    o.out = NULL;
+    o.out2 = NULL;
+    o.in1 = NULL;
+    o.in2 = NULL;
+    o.addr1 = NULL;
 
     /* Implement the instruction.  */
     if (insn->help_in1) {
@@ -5972,19 +5970,19 @@ static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
     }
 
     /* Free any temporaries created by the helpers.  */
-    if (!TCGV_IS_UNUSED_I64(o.out) && !o.g_out) {
+    if (o.out && !o.g_out) {
         tcg_temp_free_i64(o.out);
     }
-    if (!TCGV_IS_UNUSED_I64(o.out2) && !o.g_out2) {
+    if (o.out2 && !o.g_out2) {
         tcg_temp_free_i64(o.out2);
     }
-    if (!TCGV_IS_UNUSED_I64(o.in1) && !o.g_in1) {
+    if (o.in1 && !o.g_in1) {
         tcg_temp_free_i64(o.in1);
     }
-    if (!TCGV_IS_UNUSED_I64(o.in2) && !o.g_in2) {
+    if (o.in2 && !o.g_in2) {
         tcg_temp_free_i64(o.in2);
     }
-    if (!TCGV_IS_UNUSED_I64(o.addr1)) {
+    if (o.addr1) {
         tcg_temp_free_i64(o.addr1);
     }
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 038663cc05..306afa283b 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1940,7 +1940,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     op_dst = op_src = op_opc = -1;
     mt_dst = -1;
     st_src = st_mop = -1;
-    TCGV_UNUSED(op_arg);
+    op_arg = NULL;
     i = 0;
 
 #define NEXT_INSN \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 849a02aebd..71e0853e43 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5922,7 +5922,7 @@ void sparc_tcg_init(void)
         *rtl[i].ptr = tcg_global_mem_new(cpu_env, rtl[i].off, rtl[i].name);
     }
 
-    TCGV_UNUSED(cpu_regs[0]);
+    cpu_regs[0] = NULL;
     for (i = 1; i < 8; ++i) {
         cpu_regs[i] = tcg_global_mem_new(cpu_env,
                                          offsetof(CPUSPARCState, gregs[i]),
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index d55549dabc..d63bf5bba3 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -143,7 +143,7 @@ static bool check_gr(DisasContext *dc, uint8_t reg)
 
 static TCGv load_zero(DisasContext *dc)
 {
-    if (TCGV_IS_UNUSED_I64(dc->zero)) {
+    if (!dc->zero) {
         dc->zero = tcg_const_i64(0);
     }
     return dc->zero;
@@ -2324,7 +2324,7 @@ static void translate_one_bundle(DisasContext *dc, uint64_t bundle)
     for (i = 0; i < ARRAY_SIZE(dc->wb); i++) {
         DisasContextTemp *wb = &dc->wb[i];
         wb->reg = TILEGX_R_NOREG;
-        TCGV_UNUSED_I64(wb->val);
+        wb->val = NULL;
     }
     dc->num_wb = 0;
 
@@ -2384,9 +2384,9 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     dc->exit_tb = false;
     dc->atomic_excp = TILEGX_EXCP_NONE;
     dc->jmp.cond = TCG_COND_NEVER;
-    TCGV_UNUSED_I64(dc->jmp.dest);
-    TCGV_UNUSED_I64(dc->jmp.val1);
-    TCGV_UNUSED_I64(dc->zero);
+    dc->jmp.dest = NULL;
+    dc->jmp.val1 = NULL;
+    dc->zero = NULL;
 
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
         qemu_log_lock();
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 384aa86027..5b51f2166d 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1230,7 +1230,7 @@ static void do_datap(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
     if (UCOP_OPCODES != 0x0f && UCOP_OPCODES != 0x0d) {
         tmp = load_reg(s, UCOP_REG_N);
     } else {
-        TCGV_UNUSED(tmp);
+        tmp = NULL;
     }
 
     switch (UCOP_OPCODES) {
@@ -1652,7 +1652,7 @@ static void do_ldst_m(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
 
     /* compute total size */
     loaded_base = 0;
-    TCGV_UNUSED(loaded_var);
+    loaded_var = NULL;
     n = 0;
     for (i = 0; i < 6; i++) {
         if (UCOP_SET(i)) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c22f1c4441..68bcd2267b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1358,8 +1358,8 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
     TCGv_i64 retl, reth;
     TCGTemp *split_args[MAX_OPC_PARAM];
 
-    TCGV_UNUSED_I64(retl);
-    TCGV_UNUSED_I64(reth);
+    retl = NULL;
+    reth = NULL;
     if (sizemask != 0) {
         for (i = real_args = 0; i < nargs; ++i) {
             int is_64bit = sizemask & (1 << (i+1)*2);
-- 
2.14.3
