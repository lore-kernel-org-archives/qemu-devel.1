Received: from eggs.gnu.org ([209.51.188.92]:58246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griG5-0007LS-Rj
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griFz-0001Rz-WB
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:18 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griFz-0001RZ-Ko
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:15 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so11234532wrv.3
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:53:49 +0000
Message-Id: <20190207115400.647-9-richard.henderson@linaro.org>
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/19] target/hppa: Convert indexed memory insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, svens@stackframe.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 169 +++++++++------------------------------
 target/hppa/insns.decode |  24 ++++++
 2 files changed, 60 insertions(+), 133 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6c7d301904..822d93fb23 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -296,6 +296,13 @@ static int expand_sr3x(int val)
     return ~val;
 }
 
+/* Convert the M:A bits within a memory insn to the tri-state value
+   we use for the final M.  */
+static int ma_to_m(int val)
+{
+    return val & 2 ? (val & 1 ? -1 : 1) : 0;
+}
+
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
 
@@ -1562,7 +1569,7 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
 #define do_store_reg  do_store_32
 #endif
 
-static void do_load(DisasContext *ctx, unsigned rt, unsigned rb,
+static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
                     unsigned rx, int scale, target_sreg disp,
                     unsigned sp, int modify, TCGMemOp mop)
 {
@@ -1580,7 +1587,7 @@ static void do_load(DisasContext *ctx, unsigned rt, unsigned rb,
     do_load_reg(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
     save_gpr(ctx, rt, dest);
 
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
 static void do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
@@ -1623,13 +1630,13 @@ static void do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_end(ctx);
 }
 
-static void do_store(DisasContext *ctx, unsigned rt, unsigned rb,
+static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
                      target_sreg disp, unsigned sp,
                      int modify, TCGMemOp mop)
 {
     nullify_over(ctx);
     do_store_reg(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
-    nullify_end(ctx);
+    return nullify_end(ctx);
 }
 
 static void do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
@@ -2831,119 +2838,57 @@ static bool trans_cmpiclr(DisasContext *ctx, uint32_t insn)
     return nullify_end(ctx);
 }
 
-static bool trans_ld_idx_i(DisasContext *ctx, uint32_t insn,
-                           const DisasInsn *di)
+static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned m = extract32(insn, 5, 1);
-    unsigned sz = extract32(insn, 6, 2);
-    unsigned a = extract32(insn, 13, 1);
-    unsigned sp = extract32(insn, 14, 2);
-    int disp = low_sextract(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-    int modify = (m ? (a ? -1 : 1) : 0);
-    TCGMemOp mop = MO_TE | sz;
-
-    do_load(ctx, rt, rb, 0, 0, disp, sp, modify, mop);
-    return true;
+    return do_load(ctx, a->t, a->b, a->x, a->scale ? a->size : 0,
+                   a->disp, a->sp, a->m, a->size | MO_TE);
 }
 
-static bool trans_ld_idx_x(DisasContext *ctx, uint32_t insn,
-                           const DisasInsn *di)
+static bool trans_st(DisasContext *ctx, arg_ldst *a)
 {
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned m = extract32(insn, 5, 1);
-    unsigned sz = extract32(insn, 6, 2);
-    unsigned u = extract32(insn, 13, 1);
-    unsigned sp = extract32(insn, 14, 2);
-    unsigned rx = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-    TCGMemOp mop = MO_TE | sz;
-
-    do_load(ctx, rt, rb, rx, u ? sz : 0, 0, sp, m, mop);
-    return true;
+    assert(a->x == 0 && a->scale == 0);
+    return do_store(ctx, a->t, a->b, a->disp, a->sp, a->m, a->size | MO_TE);
 }
 
-static bool trans_st_idx_i(DisasContext *ctx, uint32_t insn,
-                           const DisasInsn *di)
+static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 {
-    int disp = low_sextract(insn, 0, 5);
-    unsigned m = extract32(insn, 5, 1);
-    unsigned sz = extract32(insn, 6, 2);
-    unsigned a = extract32(insn, 13, 1);
-    unsigned sp = extract32(insn, 14, 2);
-    unsigned rr = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-    int modify = (m ? (a ? -1 : 1) : 0);
-    TCGMemOp mop = MO_TE | sz;
-
-    do_store(ctx, rr, rb, disp, sp, modify, mop);
-    return true;
-}
-
-static bool trans_ldcw(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
-{
-    unsigned rt = extract32(insn, 0, 5);
-    unsigned m = extract32(insn, 5, 1);
-    unsigned i = extract32(insn, 12, 1);
-    unsigned au = extract32(insn, 13, 1);
-    unsigned sp = extract32(insn, 14, 2);
-    unsigned rx = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
-    TCGMemOp mop = MO_TEUL | MO_ALIGN_16;
+    TCGMemOp mop = MO_TEUL | MO_ALIGN_16 | a->size;
     TCGv_reg zero, dest, ofs;
     TCGv_tl addr;
-    int modify, disp = 0, scale = 0;
 
     nullify_over(ctx);
 
-    if (i) {
-        modify = (m ? (au ? -1 : 1) : 0);
-        disp = low_sextract(rx, 0, 5);
-        rx = 0;
-    } else {
-        modify = m;
-        if (au) {
-            scale = mop & MO_SIZE;
-        }
-    }
-    if (modify) {
+    if (a->m) {
         /* Base register modification.  Make sure if RT == RB,
            we see the result of the load.  */
         dest = get_temp(ctx);
     } else {
-        dest = dest_gpr(ctx, rt);
+        dest = dest_gpr(ctx, a->t);
     }
 
-    form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
-             ctx->mmu_idx == MMU_PHYS_IDX);
+    form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
+             a->disp, a->sp, a->m, ctx->mmu_idx == MMU_PHYS_IDX);
     zero = tcg_const_reg(0);
     tcg_gen_atomic_xchg_reg(dest, addr, zero, ctx->mmu_idx, mop);
-    if (modify) {
-        save_gpr(ctx, rb, ofs);
+    if (a->m) {
+        save_gpr(ctx, a->b, ofs);
     }
-    save_gpr(ctx, rt, dest);
+    save_gpr(ctx, a->t, dest);
 
     return nullify_end(ctx);
 }
 
-static bool trans_stby(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_stby(DisasContext *ctx, arg_stby *a)
 {
-    target_sreg disp = low_sextract(insn, 0, 5);
-    unsigned m = extract32(insn, 5, 1);
-    unsigned a = extract32(insn, 13, 1);
-    unsigned sp = extract32(insn, 14, 2);
-    unsigned rt = extract32(insn, 16, 5);
-    unsigned rb = extract32(insn, 21, 5);
     TCGv_reg ofs, val;
     TCGv_tl addr;
 
     nullify_over(ctx);
 
-    form_gva(ctx, &addr, &ofs, rb, 0, 0, disp, sp, m,
+    form_gva(ctx, &addr, &ofs, a->b, 0, 0, a->disp, a->sp, a->m,
              ctx->mmu_idx == MMU_PHYS_IDX);
-    val = load_gpr(ctx, rt);
-    if (a) {
+    val = load_gpr(ctx, a->r);
+    if (a->a) {
         if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
             gen_helper_stby_e_parallel(cpu_env, addr, val);
         } else {
@@ -2956,75 +2901,36 @@ static bool trans_stby(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
             gen_helper_stby_b(cpu_env, addr, val);
         }
     }
-
-    if (m) {
+    if (a->m) {
         tcg_gen_andi_reg(ofs, ofs, ~3);
-        save_gpr(ctx, rb, ofs);
+        save_gpr(ctx, a->b, ofs);
     }
 
     return nullify_end(ctx);
 }
 
-#ifndef CONFIG_USER_ONLY
-static bool trans_ldwa_idx_i(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static bool trans_lda(DisasContext *ctx, arg_ldst *a)
 {
     int hold_mmu_idx = ctx->mmu_idx;
 
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-
-    /* ??? needs fixing for hppa64 -- ldda does not follow the same
-       format wrt the sub-opcode in bits 6:9.  */
     ctx->mmu_idx = MMU_PHYS_IDX;
-    trans_ld_idx_i(ctx, insn, di);
+    trans_ld(ctx, a);
     ctx->mmu_idx = hold_mmu_idx;
     return true;
 }
 
-static bool trans_ldwa_idx_x(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
+static bool trans_sta(DisasContext *ctx, arg_ldst *a)
 {
     int hold_mmu_idx = ctx->mmu_idx;
 
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-
-    /* ??? needs fixing for hppa64 -- ldda does not follow the same
-       format wrt the sub-opcode in bits 6:9.  */
     ctx->mmu_idx = MMU_PHYS_IDX;
-    trans_ld_idx_x(ctx, insn, di);
+    trans_st(ctx, a);
     ctx->mmu_idx = hold_mmu_idx;
     return true;
 }
 
-static bool trans_stwa_idx_i(DisasContext *ctx, uint32_t insn,
-                             const DisasInsn *di)
-{
-    int hold_mmu_idx = ctx->mmu_idx;
-
-    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-
-    /* ??? needs fixing for hppa64 -- ldda does not follow the same
-       format wrt the sub-opcode in bits 6:9.  */
-    ctx->mmu_idx = MMU_PHYS_IDX;
-    trans_st_idx_i(ctx, insn, di);
-    ctx->mmu_idx = hold_mmu_idx;
-    return true;
-}
-#endif
-
-static const DisasInsn table_index_mem[] = {
-    { 0x0c001000u, 0xfc001300, trans_ld_idx_i }, /* LD[BHWD], im */
-    { 0x0c000000u, 0xfc001300, trans_ld_idx_x }, /* LD[BHWD], rx */
-    { 0x0c001200u, 0xfc001300, trans_st_idx_i }, /* ST[BHWD] */
-    { 0x0c0001c0u, 0xfc0003c0, trans_ldcw },
-    { 0x0c001300u, 0xfc0013c0, trans_stby },
-#ifndef CONFIG_USER_ONLY
-    { 0x0c000180u, 0xfc00d3c0, trans_ldwa_idx_x }, /* LDWA, rx */
-    { 0x0c001180u, 0xfc00d3c0, trans_ldwa_idx_i }, /* LDWA, im */
-    { 0x0c001380u, 0xfc00d3c0, trans_stwa_idx_i }, /* STWA, im */
-#endif
-};
-
 static bool trans_ldil(DisasContext *ctx, uint32_t insn)
 {
     unsigned rt = extract32(insn, 21, 5);
@@ -4470,9 +4376,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
 
     opc = extract32(insn, 26, 6);
     switch (opc) {
-    case 0x03:
-        translate_table(ctx, insn, table_index_mem);
-        return;
     case 0x06:
         trans_fmpyadd(ctx, insn, false);
         return;
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index a576bb1d4d..38f5fb6be2 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -26,6 +26,10 @@
 
 %sm_imm         16:10 !function=expand_sm_imm
 
+%im5_0          0:s1 1:4
+%im5_16         16:s1 17:4
+%ma_to_m        5:1 13:1 !function=ma_to_m
+
 ####
 # Argument set definitions
 ####
@@ -129,3 +133,23 @@ sub_tc          000010 ..... ..... .... 010011 0 .....  @rrr_cf
 sub_tsv_tc      000010 ..... ..... .... 110011 0 .....  @rrr_cf
 sub_b           000010 ..... ..... .... 010100 0 .....  @rrr_cf
 sub_b_tsv       000010 ..... ..... .... 110100 0 .....  @rrr_cf
+
+####
+# Index Mem
+####
+
+@ldstx          ...... b:5 x:5 sp:2 scale:1 ....... m:1 t:5     &ldst disp=0
+@ldim5          ...... b:5 ..... sp:2 ......... t:5     \
+                &ldst disp=%im5_16 x=0 scale=0 m=%ma_to_m
+@stim5          ...... b:5 t:5 sp:2 ......... .....     \
+                &ldst disp=%im5_0 x=0 scale=0 m=%ma_to_m
+
+ld              000011 ..... ..... .. . 1 -- 00 size:2 ......   @ldim5
+ld              000011 ..... ..... .. . 0 -- 00 size:2 ......   @ldstx
+st              000011 ..... ..... .. . 1 -- 10 size:2 ......   @stim5
+ldc             000011 ..... ..... .. . 1 -- 0111      ......   @ldim5 size=2
+ldc             000011 ..... ..... .. . 0 -- 0111      ......   @ldstx size=2
+lda             000011 ..... ..... .. . 1 -- 0110      ......   @ldim5 size=2
+lda             000011 ..... ..... .. . 0 -- 0110      ......   @ldstx size=2
+sta             000011 ..... ..... .. . 1 -- 1110      ......   @stim5 size=2
+stby            000011 b:5 r:5 sp:2 a:1 1 -- 1100 m:1   .....   disp=%im5_0
-- 
2.17.2
