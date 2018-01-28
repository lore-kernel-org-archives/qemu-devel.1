Received: from eggs.gnu.org ([2001:4830:134:3::10]:52089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwB6-0002m8-IV
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwB1-0008OC-Hs
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:00 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efwB1-0008Nk-7r
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:15:55 -0500
Received: by mail-pf0-x242.google.com with SMTP id k19so3261044pfj.5
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 15:15:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 15:14:59 -0800
Message-Id: <20180128231528.22719-15-richard.henderson@linaro.org>
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v4 14/43] target/hppa: Use space registers in
 data operations
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

This changes the system virtual address width to 64-bit and
incorporates the space registers into load/store operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  14 ++
 target/hppa/translate.c | 334 +++++++++++++++++++++++++++---------------------
 2 files changed, 201 insertions(+), 147 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index ef36826f54..49f95a0b77 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -23,10 +23,24 @@
 #include "qemu-common.h"
 #include "cpu-qom.h"
 
+#ifdef TARGET_HPPA64
+#define TARGET_LONG_BITS            64
+#define TARGET_VIRT_ADDR_SPACE_BITS 64
+#define TARGET_REGISTER_BITS        64
+#define TARGET_PHYS_ADDR_SPACE_BITS 64
+#elif defined(CONFIG_USER_ONLY)
 #define TARGET_LONG_BITS            32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #define TARGET_REGISTER_BITS        32
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
+#else
+/* In order to form the GVA from space:offset,
+   we need a 64-bit virtual address space.  */
+#define TARGET_LONG_BITS            64
+#define TARGET_VIRT_ADDR_SPACE_BITS 64
+#define TARGET_REGISTER_BITS        32
+#define TARGET_PHYS_ADDR_SPACE_BITS 32
+#endif
 
 #define CPUArchState struct CPUHPPAState
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 34b999fb2c..6be9e0c3ff 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -276,8 +276,9 @@ typedef struct DisasContext {
     target_ureg iaoq_n;
     TCGv_reg iaoq_n_var;
 
-    int ntemps;
-    TCGv_reg temps[8];
+    int ntempr, ntempl;
+    TCGv_reg tempr[4];
+    TCGv_tl  templ[4];
 
     DisasCond null_cond;
     TCGLabel *null_lab;
@@ -458,11 +459,20 @@ static void cond_free(DisasCond *cond)
 
 static TCGv_reg get_temp(DisasContext *ctx)
 {
-    unsigned i = ctx->ntemps++;
-    g_assert(i < ARRAY_SIZE(ctx->temps));
-    return ctx->temps[i] = tcg_temp_new();
+    unsigned i = ctx->ntempr++;
+    g_assert(i < ARRAY_SIZE(ctx->tempr));
+    return ctx->tempr[i] = tcg_temp_new();
 }
 
+#ifndef CONFIG_USER_ONLY
+static TCGv_tl get_temp_tl(DisasContext *ctx)
+{
+    unsigned i = ctx->ntempl++;
+    g_assert(i < ARRAY_SIZE(ctx->templ));
+    return ctx->templ[i] = tcg_temp_new_tl();
+}
+#endif
+
 static TCGv_reg load_const(DisasContext *ctx, target_sreg v)
 {
     TCGv_reg t = get_temp(ctx);
@@ -1324,6 +1334,70 @@ static DisasJumpType do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     return DISAS_NEXT;
 }
 
+#ifndef CONFIG_USER_ONLY
+/* Top 2 bits of the base register select sp[4-7].  */
+static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
+{
+    TCGv_ptr ptr;
+    TCGv_reg tmp;
+    TCGv_i64 spc;
+
+    if (sp != 0) {
+        return cpu_sr[sp];
+    }
+
+    ptr = tcg_temp_new_ptr();
+    tmp = tcg_temp_new();
+    spc = get_temp_tl(ctx);
+
+    tcg_gen_shri_reg(tmp, base, TARGET_REGISTER_BITS - 5);
+    tcg_gen_andi_reg(tmp, tmp, 030);
+    tcg_gen_trunc_reg_ptr(ptr, tmp);
+    tcg_temp_free(tmp);
+
+    tcg_gen_add_ptr(ptr, ptr, cpu_env);
+    tcg_gen_ld_i64(spc, ptr, offsetof(CPUHPPAState, sr[4]));
+    tcg_temp_free_ptr(ptr);
+
+    return spc;
+}
+#endif
+
+static void form_gva(DisasContext *ctx, TCGv_tl *pgva, TCGv_reg *pofs,
+                     unsigned rb, unsigned rx, int scale, target_sreg disp,
+                     unsigned sp, int modify, bool is_phys)
+{
+    TCGv_reg base = load_gpr(ctx, rb);
+    TCGv_reg ofs;
+
+    /* Note that RX is mutually exclusive with DISP.  */
+    if (rx) {
+        ofs = get_temp(ctx);
+        tcg_gen_shli_reg(ofs, cpu_gr[rx], scale);
+        tcg_gen_add_reg(ofs, ofs, base);
+    } else if (disp || modify) {
+        ofs = get_temp(ctx);
+        tcg_gen_addi_reg(ofs, base, disp);
+    } else {
+        ofs = base;
+    }
+
+    *pofs = ofs;
+#ifdef CONFIG_USER_ONLY
+    *pgva = (modify <= 0 ? ofs : base);
+#else
+    TCGv_tl addr = get_temp_tl(ctx);
+    tcg_gen_extu_reg_tl(addr, modify <= 0 ? ofs : base);
+    if (ctx->base.tb->flags & PSW_W) {
+        tcg_gen_andi_tl(addr, addr, 0x3fffffffffffffffull);
+    }
+    if (!is_phys) {
+        tcg_gen_or_tl(addr, addr, space_select(ctx, sp, base));
+    }
+    *pgva = addr;
+#endif
+}
+
 /* Emit a memory load.  The modify parameter should be
  * < 0 for pre-modify,
  * > 0 for post-modify,
@@ -1331,118 +1405,74 @@ static DisasJumpType do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
  */
 static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
                        unsigned rx, int scale, target_sreg disp,
-                       int modify, TCGMemOp mop)
+                       unsigned sp, int modify, TCGMemOp mop)
 {
-    TCGv_reg addr, base;
+    TCGv_reg ofs;
+    TCGv_tl addr;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
-    addr = tcg_temp_new();
-    base = load_gpr(ctx, rb);
-
-    /* Note that RX is mutually exclusive with DISP.  */
-    if (rx) {
-        tcg_gen_shli_reg(addr, cpu_gr[rx], scale);
-        tcg_gen_add_reg(addr, addr, base);
-    } else {
-        tcg_gen_addi_reg(addr, base, disp);
-    }
-
-    if (modify == 0) {
-        tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop);
-    } else {
-        tcg_gen_qemu_ld_i32(dest, (modify < 0 ? addr : base),
-                            ctx->mmu_idx, mop);
-        save_gpr(ctx, rb, addr);
+    form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
+             ctx->mmu_idx == MMU_PHYS_IDX);
+    tcg_gen_qemu_ld_reg(dest, addr, ctx->mmu_idx, mop);
+    if (modify) {
+        save_gpr(ctx, rb, ofs);
     }
-    tcg_temp_free(addr);
 }
 
 static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
                        unsigned rx, int scale, target_sreg disp,
-                       int modify, TCGMemOp mop)
+                       unsigned sp, int modify, TCGMemOp mop)
 {
-    TCGv_reg addr, base;
+    TCGv_reg ofs;
+    TCGv_tl addr;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
-    addr = tcg_temp_new();
-    base = load_gpr(ctx, rb);
-
-    /* Note that RX is mutually exclusive with DISP.  */
-    if (rx) {
-        tcg_gen_shli_reg(addr, cpu_gr[rx], scale);
-        tcg_gen_add_reg(addr, addr, base);
-    } else {
-        tcg_gen_addi_reg(addr, base, disp);
-    }
-
-    if (modify == 0) {
-        tcg_gen_qemu_ld_i64(dest, addr, ctx->mmu_idx, mop);
-    } else {
-        tcg_gen_qemu_ld_i64(dest, (modify < 0 ? addr : base),
-                            ctx->mmu_idx, mop);
-        save_gpr(ctx, rb, addr);
+    form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
+             ctx->mmu_idx == MMU_PHYS_IDX);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mmu_idx, mop);
+    if (modify) {
+        save_gpr(ctx, rb, ofs);
     }
-    tcg_temp_free(addr);
 }
 
 static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
                         unsigned rx, int scale, target_sreg disp,
-                        int modify, TCGMemOp mop)
+                        unsigned sp, int modify, TCGMemOp mop)
 {
-    TCGv_reg addr, base;
+    TCGv_reg ofs;
+    TCGv_tl addr;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
-    addr = tcg_temp_new();
-    base = load_gpr(ctx, rb);
-
-    /* Note that RX is mutually exclusive with DISP.  */
-    if (rx) {
-        tcg_gen_shli_reg(addr, cpu_gr[rx], scale);
-        tcg_gen_add_reg(addr, addr, base);
-    } else {
-        tcg_gen_addi_reg(addr, base, disp);
-    }
-
-    tcg_gen_qemu_st_i32(src, (modify <= 0 ? addr : base), ctx->mmu_idx, mop);
-
-    if (modify != 0) {
-        save_gpr(ctx, rb, addr);
+    form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
+             ctx->mmu_idx == MMU_PHYS_IDX);
+    tcg_gen_qemu_st_i32(src, addr, ctx->mmu_idx, mop);
+    if (modify) {
+        save_gpr(ctx, rb, ofs);
     }
-    tcg_temp_free(addr);
 }
 
 static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
                         unsigned rx, int scale, target_sreg disp,
-                        int modify, TCGMemOp mop)
+                        unsigned sp, int modify, TCGMemOp mop)
 {
-    TCGv_reg addr, base;
+    TCGv_reg ofs;
+    TCGv_tl addr;
 
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
-    addr = tcg_temp_new();
-    base = load_gpr(ctx, rb);
-
-    /* Note that RX is mutually exclusive with DISP.  */
-    if (rx) {
-        tcg_gen_shli_reg(addr, cpu_gr[rx], scale);
-        tcg_gen_add_reg(addr, addr, base);
-    } else {
-        tcg_gen_addi_reg(addr, base, disp);
-    }
-
-    tcg_gen_qemu_st_i64(src, (modify <= 0 ? addr : base), ctx->mmu_idx, mop);
-
-    if (modify != 0) {
-        save_gpr(ctx, rb, addr);
+    form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
+             ctx->mmu_idx == MMU_PHYS_IDX);
+    tcg_gen_qemu_st_i64(src, addr, ctx->mmu_idx, mop);
+    if (modify) {
+        save_gpr(ctx, rb, ofs);
     }
-    tcg_temp_free(addr);
 }
 
 #if TARGET_REGISTER_BITS == 64
@@ -1455,7 +1485,7 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
 
 static DisasJumpType do_load(DisasContext *ctx, unsigned rt, unsigned rb,
                              unsigned rx, int scale, target_sreg disp,
-                             int modify, TCGMemOp mop)
+                             unsigned sp, int modify, TCGMemOp mop)
 {
     TCGv_reg dest;
 
@@ -1468,7 +1498,7 @@ static DisasJumpType do_load(DisasContext *ctx, unsigned rt, unsigned rb,
         /* Make sure if RT == RB, we see the result of the load.  */
         dest = get_temp(ctx);
     }
-    do_load_reg(ctx, dest, rb, rx, scale, disp, modify, mop);
+    do_load_reg(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
     save_gpr(ctx, rt, dest);
 
     return nullify_end(ctx, DISAS_NEXT);
@@ -1476,14 +1506,14 @@ static DisasJumpType do_load(DisasContext *ctx, unsigned rt, unsigned rb,
 
 static DisasJumpType do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
                                unsigned rx, int scale, target_sreg disp,
-                               int modify)
+                               unsigned sp, int modify)
 {
     TCGv_i32 tmp;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i32();
-    do_load_32(ctx, tmp, rb, rx, scale, disp, modify, MO_TEUL);
+    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUL);
     save_frw_i32(rt, tmp);
     tcg_temp_free_i32(tmp);
 
@@ -1496,14 +1526,14 @@ static DisasJumpType do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
 
 static DisasJumpType do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
                                unsigned rx, int scale, target_sreg disp,
-                               int modify)
+                               unsigned sp, int modify)
 {
     TCGv_i64 tmp;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    do_load_64(ctx, tmp, rb, rx, scale, disp, modify, MO_TEQ);
+    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEQ);
     save_frd(rt, tmp);
     tcg_temp_free_i64(tmp);
 
@@ -1515,23 +1545,24 @@ static DisasJumpType do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
 }
 
 static DisasJumpType do_store(DisasContext *ctx, unsigned rt, unsigned rb,
-                              target_sreg disp, int modify, TCGMemOp mop)
+                              target_sreg disp, unsigned sp,
+                              int modify, TCGMemOp mop)
 {
     nullify_over(ctx);
-    do_store_reg(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, modify, mop);
+    do_store_reg(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
     return nullify_end(ctx, DISAS_NEXT);
 }
 
 static DisasJumpType do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
                                 unsigned rx, int scale, target_sreg disp,
-                                int modify)
+                                unsigned sp, int modify)
 {
     TCGv_i32 tmp;
 
     nullify_over(ctx);
 
     tmp = load_frw_i32(rt);
-    do_store_32(ctx, tmp, rb, rx, scale, disp, modify, MO_TEUL);
+    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUL);
     tcg_temp_free_i32(tmp);
 
     return nullify_end(ctx, DISAS_NEXT);
@@ -1539,14 +1570,14 @@ static DisasJumpType do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
 
 static DisasJumpType do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
                                 unsigned rx, int scale, target_sreg disp,
-                                int modify)
+                                unsigned sp, int modify)
 {
     TCGv_i64 tmp;
 
     nullify_over(ctx);
 
     tmp = load_frd(rt);
-    do_store_64(ctx, tmp, rb, rx, scale, disp, modify, MO_TEQ);
+    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEQ);
     tcg_temp_free_i64(tmp);
 
     return nullify_end(ctx, DISAS_NEXT);
@@ -2228,18 +2259,21 @@ static DisasJumpType trans_probe(DisasContext *ctx, uint32_t insn,
                                  const DisasInsn *di)
 {
     unsigned rt = extract32(insn, 0, 5);
+    unsigned sp = extract32(insn, 14, 2);
     unsigned rb = extract32(insn, 21, 5);
     unsigned is_write = extract32(insn, 6, 1);
-    TCGv_reg dest;
+    TCGv_reg dest, ofs;
+    TCGv_tl addr;
 
     nullify_over(ctx);
 
     /* ??? Do something with priv level operand.  */
     dest = dest_gpr(ctx, rt);
+    form_gva(ctx, &addr, &ofs, rb, 0, 0, 0, sp, 0, false);
     if (is_write) {
-        gen_helper_probe_w(dest, load_gpr(ctx, rb));
+        gen_helper_probe_w(dest, addr);
     } else {
-        gen_helper_probe_r(dest, load_gpr(ctx, rb));
+        gen_helper_probe_r(dest, addr);
     }
     save_gpr(ctx, rt, dest);
     return nullify_end(ctx, DISAS_NEXT);
@@ -2628,12 +2662,13 @@ static DisasJumpType trans_ld_idx_i(DisasContext *ctx, uint32_t insn,
     unsigned m = extract32(insn, 5, 1);
     unsigned sz = extract32(insn, 6, 2);
     unsigned a = extract32(insn, 13, 1);
+    unsigned sp = extract32(insn, 14, 2);
     int disp = low_sextract(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
     int modify = (m ? (a ? -1 : 1) : 0);
     TCGMemOp mop = MO_TE | sz;
 
-    return do_load(ctx, rt, rb, 0, 0, disp, modify, mop);
+    return do_load(ctx, rt, rb, 0, 0, disp, sp, modify, mop);
 }
 
 static DisasJumpType trans_ld_idx_x(DisasContext *ctx, uint32_t insn,
@@ -2643,11 +2678,12 @@ static DisasJumpType trans_ld_idx_x(DisasContext *ctx, uint32_t insn,
     unsigned m = extract32(insn, 5, 1);
     unsigned sz = extract32(insn, 6, 2);
     unsigned u = extract32(insn, 13, 1);
+    unsigned sp = extract32(insn, 14, 2);
     unsigned rx = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
     TCGMemOp mop = MO_TE | sz;
 
-    return do_load(ctx, rt, rb, rx, u ? sz : 0, 0, m, mop);
+    return do_load(ctx, rt, rb, rx, u ? sz : 0, 0, sp, m, mop);
 }
 
 static DisasJumpType trans_st_idx_i(DisasContext *ctx, uint32_t insn,
@@ -2657,12 +2693,13 @@ static DisasJumpType trans_st_idx_i(DisasContext *ctx, uint32_t insn,
     unsigned m = extract32(insn, 5, 1);
     unsigned sz = extract32(insn, 6, 2);
     unsigned a = extract32(insn, 13, 1);
+    unsigned sp = extract32(insn, 14, 2);
     unsigned rr = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
     int modify = (m ? (a ? -1 : 1) : 0);
     TCGMemOp mop = MO_TE | sz;
 
-    return do_store(ctx, rr, rb, disp, modify, mop);
+    return do_store(ctx, rr, rb, disp, sp, modify, mop);
 }
 
 static DisasJumpType trans_ldcw(DisasContext *ctx, uint32_t insn,
@@ -2672,16 +2709,16 @@ static DisasJumpType trans_ldcw(DisasContext *ctx, uint32_t insn,
     unsigned m = extract32(insn, 5, 1);
     unsigned i = extract32(insn, 12, 1);
     unsigned au = extract32(insn, 13, 1);
+    unsigned sp = extract32(insn, 14, 2);
     unsigned rx = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
     TCGMemOp mop = MO_TEUL | MO_ALIGN_16;
-    TCGv_reg zero, addr, base, dest;
+    TCGv_reg zero, dest, ofs;
+    TCGv_tl addr;
     int modify, disp = 0, scale = 0;
 
     nullify_over(ctx);
 
-    /* ??? Share more code with do_load and do_load_{32,64}.  */
-
     if (i) {
         modify = (m ? (au ? -1 : 1) : 0);
         disp = low_sextract(rx, 0, 5);
@@ -2693,27 +2730,19 @@ static DisasJumpType trans_ldcw(DisasContext *ctx, uint32_t insn,
         }
     }
     if (modify) {
-        /* Base register modification.  Make sure if RT == RB, we see
-           the result of the load.  */
+        /* Base register modification.  Make sure if RT == RB,
+           we see the result of the load.  */
         dest = get_temp(ctx);
     } else {
         dest = dest_gpr(ctx, rt);
     }
 
-    addr = tcg_temp_new();
-    base = load_gpr(ctx, rb);
-    if (rx) {
-        tcg_gen_shli_reg(addr, cpu_gr[rx], scale);
-        tcg_gen_add_reg(addr, addr, base);
-    } else {
-        tcg_gen_addi_reg(addr, base, disp);
-    }
-
+    form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
+             ctx->mmu_idx == MMU_PHYS_IDX);
     zero = tcg_const_reg(0);
-    tcg_gen_atomic_xchg_reg(dest, (modify <= 0 ? addr : base),
-                            zero, ctx->mmu_idx, mop);
+    tcg_gen_atomic_xchg_reg(dest, addr, zero, ctx->mmu_idx, mop);
     if (modify) {
-        save_gpr(ctx, rb, addr);
+        save_gpr(ctx, rb, ofs);
     }
     save_gpr(ctx, rt, dest);
 
@@ -2726,20 +2755,17 @@ static DisasJumpType trans_stby(DisasContext *ctx, uint32_t insn,
     target_sreg disp = low_sextract(insn, 0, 5);
     unsigned m = extract32(insn, 5, 1);
     unsigned a = extract32(insn, 13, 1);
+    unsigned sp = extract32(insn, 14, 2);
     unsigned rt = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
-    TCGv_reg addr, val;
+    TCGv_reg ofs, val;
+    TCGv_tl addr;
 
     nullify_over(ctx);
 
-    addr = tcg_temp_new();
-    if (m || disp == 0) {
-        tcg_gen_mov_reg(addr, load_gpr(ctx, rb));
-    } else {
-        tcg_gen_addi_reg(addr, load_gpr(ctx, rb), disp);
-    }
+    form_gva(ctx, &addr, &ofs, rb, 0, 0, disp, sp, m,
+             ctx->mmu_idx == MMU_PHYS_IDX);
     val = load_gpr(ctx, rt);
-
     if (a) {
         if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
             gen_helper_stby_e_parallel(cpu_env, addr, val);
@@ -2755,11 +2781,9 @@ static DisasJumpType trans_stby(DisasContext *ctx, uint32_t insn,
     }
 
     if (m) {
-        tcg_gen_addi_reg(addr, addr, disp);
-        tcg_gen_andi_reg(addr, addr, ~3);
-        save_gpr(ctx, rb, addr);
+        tcg_gen_andi_reg(ofs, ofs, ~3);
+        save_gpr(ctx, rb, ofs);
     }
-    tcg_temp_free(addr);
 
     return nullify_end(ctx, DISAS_NEXT);
 }
@@ -2824,15 +2848,18 @@ static DisasJumpType trans_load(DisasContext *ctx, uint32_t insn,
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
+    unsigned sp = extract32(insn, 14, 2);
     target_sreg i = assemble_16(insn);
 
-    return do_load(ctx, rt, rb, 0, 0, i, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
+    return do_load(ctx, rt, rb, 0, 0, i, sp,
+                   is_mod ? (i < 0 ? -1 : 1) : 0, mop);
 }
 
 static DisasJumpType trans_load_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
+    unsigned sp = extract32(insn, 14, 2);
     target_sreg i = assemble_16a(insn);
     unsigned ext2 = extract32(insn, 1, 2);
 
@@ -2840,11 +2867,11 @@ static DisasJumpType trans_load_w(DisasContext *ctx, uint32_t insn)
     case 0:
     case 1:
         /* FLDW without modification.  */
-        return do_floadw(ctx, ext2 * 32 + rt, rb, 0, 0, i, 0);
+        return do_floadw(ctx, ext2 * 32 + rt, rb, 0, 0, i, sp, 0);
     case 2:
         /* LDW with modification.  Note that the sign of I selects
            post-dec vs pre-inc.  */
-        return do_load(ctx, rt, rb, 0, 0, i, (i < 0 ? 1 : -1), MO_TEUL);
+        return do_load(ctx, rt, rb, 0, 0, i, sp, (i < 0 ? 1 : -1), MO_TEUL);
     default:
         return gen_illegal(ctx);
     }
@@ -2855,11 +2882,12 @@ static DisasJumpType trans_fload_mod(DisasContext *ctx, uint32_t insn)
     target_sreg i = assemble_16a(insn);
     unsigned t1 = extract32(insn, 1, 1);
     unsigned a = extract32(insn, 2, 1);
+    unsigned sp = extract32(insn, 14, 2);
     unsigned t0 = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
 
     /* FLDW with modification.  */
-    return do_floadw(ctx, t1 * 32 + t0, rb, 0, 0, i, (a ? -1 : 1));
+    return do_floadw(ctx, t1 * 32 + t0, rb, 0, 0, i, sp, (a ? -1 : 1));
 }
 
 static DisasJumpType trans_store(DisasContext *ctx, uint32_t insn,
@@ -2867,15 +2895,17 @@ static DisasJumpType trans_store(DisasContext *ctx, uint32_t insn,
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
+    unsigned sp = extract32(insn, 14, 2);
     target_sreg i = assemble_16(insn);
 
-    return do_store(ctx, rt, rb, i, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
+    return do_store(ctx, rt, rb, i, sp, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
 }
 
 static DisasJumpType trans_store_w(DisasContext *ctx, uint32_t insn)
 {
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = extract32(insn, 16, 5);
+    unsigned sp = extract32(insn, 14, 2);
     target_sreg i = assemble_16a(insn);
     unsigned ext2 = extract32(insn, 1, 2);
 
@@ -2883,10 +2913,10 @@ static DisasJumpType trans_store_w(DisasContext *ctx, uint32_t insn)
     case 0:
     case 1:
         /* FSTW without modification.  */
-        return do_fstorew(ctx, ext2 * 32 + rt, rb, 0, 0, i, 0);
+        return do_fstorew(ctx, ext2 * 32 + rt, rb, 0, 0, i, sp, 0);
     case 2:
         /* LDW with modification.  */
-        return do_store(ctx, rt, rb, i, (i < 0 ? 1 : -1), MO_TEUL);
+        return do_store(ctx, rt, rb, i, sp, (i < 0 ? 1 : -1), MO_TEUL);
     default:
         return gen_illegal(ctx);
     }
@@ -2897,11 +2927,12 @@ static DisasJumpType trans_fstore_mod(DisasContext *ctx, uint32_t insn)
     target_sreg i = assemble_16a(insn);
     unsigned t1 = extract32(insn, 1, 1);
     unsigned a = extract32(insn, 2, 1);
+    unsigned sp = extract32(insn, 14, 2);
     unsigned t0 = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
 
     /* FSTW with modification.  */
-    return do_fstorew(ctx, t1 * 32 + t0, rb, 0, 0, i, (a ? -1 : 1));
+    return do_fstorew(ctx, t1 * 32 + t0, rb, 0, 0, i, sp, (a ? -1 : 1));
 }
 
 static DisasJumpType trans_copr_w(DisasContext *ctx, uint32_t insn)
@@ -2913,6 +2944,7 @@ static DisasJumpType trans_copr_w(DisasContext *ctx, uint32_t insn)
     /* unsigned cc = extract32(insn, 10, 2); */
     unsigned i = extract32(insn, 12, 1);
     unsigned ua = extract32(insn, 13, 1);
+    unsigned sp = extract32(insn, 14, 2);
     unsigned rx = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
     unsigned rt = t1 * 32 + t0;
@@ -2932,9 +2964,9 @@ static DisasJumpType trans_copr_w(DisasContext *ctx, uint32_t insn)
 
     switch (ext3) {
     case 0: /* FLDW */
-        return do_floadw(ctx, rt, rb, rx, scale, disp, modify);
+        return do_floadw(ctx, rt, rb, rx, scale, disp, sp, modify);
     case 4: /* FSTW */
-        return do_fstorew(ctx, rt, rb, rx, scale, disp, modify);
+        return do_fstorew(ctx, rt, rb, rx, scale, disp, sp, modify);
     }
     return gen_illegal(ctx);
 }
@@ -2947,6 +2979,7 @@ static DisasJumpType trans_copr_dw(DisasContext *ctx, uint32_t insn)
     /* unsigned cc = extract32(insn, 10, 2); */
     unsigned i = extract32(insn, 12, 1);
     unsigned ua = extract32(insn, 13, 1);
+    unsigned sp = extract32(insn, 14, 2);
     unsigned rx = extract32(insn, 16, 5);
     unsigned rb = extract32(insn, 21, 5);
     int modify = (m ? (ua ? -1 : 1) : 0);
@@ -2965,9 +2998,9 @@ static DisasJumpType trans_copr_dw(DisasContext *ctx, uint32_t insn)
 
     switch (ext4) {
     case 0: /* FLDD */
-        return do_floadd(ctx, rt, rb, rx, scale, disp, modify);
+        return do_floadd(ctx, rt, rb, rx, scale, disp, sp, modify);
     case 8: /* FSTD */
-        return do_fstored(ctx, rt, rb, rx, scale, disp, modify);
+        return do_fstored(ctx, rt, rb, rx, scale, disp, sp, modify);
     default:
         return gen_illegal(ctx);
     }
@@ -4208,8 +4241,10 @@ static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
     bound = MIN(max_insns, bound);
 
-    ctx->ntemps = 0;
-    memset(ctx->temps, 0, sizeof(ctx->temps));
+    ctx->ntempr = 0;
+    ctx->ntempl = 0;
+    memset(ctx->tempr, 0, sizeof(ctx->tempr));
+    memset(ctx->templ, 0, sizeof(ctx->templ));
 
     return bound;
 }
@@ -4286,11 +4321,16 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 
     /* Free any temporaries allocated.  */
-    for (i = 0, n = ctx->ntemps; i < n; ++i) {
-        tcg_temp_free(ctx->temps[i]);
-        ctx->temps[i] = NULL;
+    for (i = 0, n = ctx->ntempr; i < n; ++i) {
+        tcg_temp_free(ctx->tempr[i]);
+        ctx->tempr[i] = NULL;
+    }
+    for (i = 0, n = ctx->ntempl; i < n; ++i) {
+        tcg_temp_free_tl(ctx->templ[i]);
+        ctx->templ[i] = NULL;
     }
-    ctx->ntemps = 0;
+    ctx->ntempr = 0;
+    ctx->ntempl = 0;
 
     /* Advance the insn queue.  Note that this check also detects
        a priority change within the instruction queue.  */
@@ -4400,7 +4440,7 @@ void restore_state_to_opc(CPUHPPAState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
     env->iaoq_f = data[0];
-    if (data[1] != -1) {
+    if (data[1] != (target_ureg)-1) {
         env->iaoq_b = data[1];
     }
     /* Since we were executing the instruction at IAOQ_F, and took some
-- 
2.14.3
