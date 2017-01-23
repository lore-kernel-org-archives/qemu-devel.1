Received: from eggs.gnu.org ([2001:4830:134:3::10]:46783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUDE-0007yY-Ut
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUDC-0004y7-BX
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:28 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUDC-0004xz-4v
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:26 -0500
Received: by mail-qt0-x242.google.com with SMTP id f4so14078180qte.2
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:26 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:46 -0800
Message-Id: <20170123021748.13170-25-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 24/26] target-hppa: Implement loads and stores
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/helper.h    |   3 +
 target/hppa/op_helper.c |  78 ++++++
 target/hppa/translate.c | 618 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 699 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index ecff17c..88db719 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -2,4 +2,7 @@ DEF_HELPER_2(excp, noreturn, env, int)
 DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(tcond, TCG_CALL_NO_WG, void, env, tl)
 
+DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tl)
+
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index f36ce74..0aa5fb9 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
 
 void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
 {
@@ -54,6 +55,83 @@ void HELPER(tcond)(CPUHPPAState *env, target_ulong cond)
     }
 }
 
+static void atomic_store_3(CPUHPPAState *env, target_ulong addr, uint32_t val,
+                           uint32_t mask, uintptr_t ra)
+{
+    uint32_t old, new, cmp;
+
+#ifdef CONFIG_USER_ONLY
+    uint32_t *haddr = g2h(addr - 1);
+    old = *haddr;
+    while (1) {
+        new = (old & ~mask) | (val & mask);
+        cmp = atomic_cmpxchg(haddr, old, new);
+        if (cmp == old) {
+            return;
+        }
+        old = cmp;
+    }
+#else
+#error "Not implemented."
+#endif
+}
+
+void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ulong val)
+{
+    uintptr_t ra = GETPC();
+
+    switch (addr & 3) {
+    case 3:
+        cpu_stb_data_ra(env, addr, val, ra);
+        break;
+    case 2:
+        cpu_stw_data_ra(env, addr, val, ra);
+        break;
+    case 1:
+        /* The 3 byte store must appear atomic.  */
+        if (parallel_cpus) {
+            atomic_store_3(env, addr, val, 0x00ffffffu, ra);
+        } else {
+            cpu_stb_data_ra(env, addr, val >> 16, ra);
+            cpu_stw_data_ra(env, addr + 1, val, ra);
+        }
+        break;
+    default:
+        cpu_stl_data_ra(env, addr, val, ra);
+        break;
+    }
+}
+
+void HELPER(stby_e)(CPUHPPAState *env, target_ulong addr, target_ulong val)
+{
+    uintptr_t ra = GETPC();
+
+    switch (addr & 3) {
+    case 3:
+        /* The 3 byte store must appear atomic.  */
+        if (parallel_cpus) {
+            atomic_store_3(env, addr - 3, val, 0xffffff00u, ra);
+        } else {
+            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
+            cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
+        }
+        break;
+    case 2:
+        cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+        break;
+    case 1:
+        cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
+        break;
+    default:
+        /* Nothing is stored, but protection is checked and the
+           cacheline is marked dirty.  */
+#ifndef CONFIG_USER_ONLY
+        probe_write(env, addr, cpu_mmu_index(env, 0), ra);
+#endif
+        break;
+    }
+}
+
 void HELPER(loaded_fr0)(CPUHPPAState *env)
 {
     uint32_t shadow = env->fr[0] >> 32;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 093a65e..1973777 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -278,6 +278,45 @@ static void save_gpr(DisasContext *ctx, unsigned reg, TCGv t)
     }
 }
 
+#ifdef HOST_WORDS_BIGENDIAN
+# define HI_OFS  0
+# define LO_OFS  4
+#else
+# define HI_OFS  4
+# define LO_OFS  0
+#endif
+
+static TCGv_i32 load_frw_i32(unsigned rt)
+{
+    TCGv_i32 ret = tcg_temp_new_i32();
+    tcg_gen_ld_i32(ret, cpu_env,
+                   offsetof(CPUHPPAState, fr[rt & 31])
+                   + (rt & 32 ? LO_OFS : HI_OFS));
+    return ret;
+}
+
+static void save_frw_i32(unsigned rt, TCGv_i32 val)
+{
+    tcg_gen_st_i32(val, cpu_env,
+                   offsetof(CPUHPPAState, fr[rt & 31])
+                   + (rt & 32 ? LO_OFS : HI_OFS));
+}
+
+#undef HI_OFS
+#undef LO_OFS
+
+static TCGv_i64 load_frd(unsigned rt)
+{
+    TCGv_i64 ret = tcg_temp_new_i64();
+    tcg_gen_ld_i64(ret, cpu_env, offsetof(CPUHPPAState, fr[rt]));
+    return ret;
+}
+
+static void save_frd(unsigned rt, TCGv_i64 val)
+{
+    tcg_gen_st_i64(val, cpu_env, offsetof(CPUHPPAState, fr[rt]));
+}
+
 /* Skip over the implementation of an insn that has been nullified.
    Use this when the insn is too complex for a conditional move.  */
 static void nullify_over(DisasContext *ctx)
@@ -471,6 +510,16 @@ static target_long assemble_16(uint32_t insn)
     return low_sextract(insn, 0, 14);
 }
 
+static target_long assemble_16a(uint32_t insn)
+{
+    /* Take the name from PA2.0, which produces a 14-bit shifted number
+       only with wide mode; otherwise a 12-bit shifted number.  Since we
+       don't implement wide mode, this is always the 12-bit number.  */
+    target_ulong x = -(target_ulong)(insn & 1);
+    x = (x << 11) | extract32(insn, 2, 11);
+    return x << 2;
+}
+
 static target_long assemble_17(uint32_t insn)
 {
     target_ulong x = -(target_ulong)(insn & 1);
@@ -941,6 +990,234 @@ static ExitStatus do_unit(DisasContext *ctx, unsigned rt, TCGv in1,
     return NO_EXIT;
 }
 
+/* Emit a memory load.  The modify parameter should be
+ * < 0 for pre-modify,
+ * > 0 for post-modify,
+ * = 0 for no base register update.
+ */
+static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
+                       unsigned rx, int scale, target_long disp,
+                       int modify, TCGMemOp mop)
+{
+    TCGv addr, base;
+
+    /* Caller uses nullify_over/nullify_end.  */
+    assert(ctx->null_cond.c == TCG_COND_NEVER);
+
+    addr = tcg_temp_new();
+    base = load_gpr(ctx, rb);
+
+    /* Note that RX is mutually exclusive with DISP.  */
+    if (rx) {
+        tcg_gen_shli_tl(addr, cpu_gr[rx], scale);
+        tcg_gen_add_tl(addr, addr, base);
+    } else {
+        tcg_gen_addi_tl(addr, base, disp);
+    }
+
+    if (modify == 0) {
+        tcg_gen_qemu_ld_i32(dest, addr, MMU_USER_IDX, mop);
+    } else {
+        tcg_gen_qemu_ld_i32(dest, (modify < 0 ? addr : base),
+                            MMU_USER_IDX, mop);
+        save_gpr(ctx, rb, addr);
+    }
+    tcg_temp_free(addr);
+}
+
+static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
+                       unsigned rx, int scale, target_long disp,
+                       int modify, TCGMemOp mop)
+{
+    TCGv addr, base;
+
+    /* Caller uses nullify_over/nullify_end.  */
+    assert(ctx->null_cond.c == TCG_COND_NEVER);
+
+    addr = tcg_temp_new();
+    base = load_gpr(ctx, rb);
+
+    /* Note that RX is mutually exclusive with DISP.  */
+    if (rx) {
+        tcg_gen_shli_tl(addr, cpu_gr[rx], scale);
+        tcg_gen_add_tl(addr, addr, base);
+    } else {
+        tcg_gen_addi_tl(addr, base, disp);
+    }
+
+    if (modify == 0) {
+        tcg_gen_qemu_ld_i64(dest, addr, MMU_USER_IDX, mop);
+    } else {
+        tcg_gen_qemu_ld_i64(dest, (modify < 0 ? addr : base),
+                            MMU_USER_IDX, mop);
+        save_gpr(ctx, rb, addr);
+    }
+    tcg_temp_free(addr);
+}
+
+static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
+                        unsigned rx, int scale, target_long disp,
+                        int modify, TCGMemOp mop)
+{
+    TCGv addr, base;
+
+    /* Caller uses nullify_over/nullify_end.  */
+    assert(ctx->null_cond.c == TCG_COND_NEVER);
+
+    addr = tcg_temp_new();
+    base = load_gpr(ctx, rb);
+
+    /* Note that RX is mutually exclusive with DISP.  */
+    if (rx) {
+        tcg_gen_shli_tl(addr, cpu_gr[rx], scale);
+        tcg_gen_add_tl(addr, addr, base);
+    } else {
+        tcg_gen_addi_tl(addr, base, disp);
+    }
+
+    tcg_gen_qemu_st_i32(src, (modify <= 0 ? addr : base), MMU_USER_IDX, mop);
+
+    if (modify != 0) {
+        save_gpr(ctx, rb, addr);
+    }
+    tcg_temp_free(addr);
+}
+
+static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
+                        unsigned rx, int scale, target_long disp,
+                        int modify, TCGMemOp mop)
+{
+    TCGv addr, base;
+
+    /* Caller uses nullify_over/nullify_end.  */
+    assert(ctx->null_cond.c == TCG_COND_NEVER);
+
+    addr = tcg_temp_new();
+    base = load_gpr(ctx, rb);
+
+    /* Note that RX is mutually exclusive with DISP.  */
+    if (rx) {
+        tcg_gen_shli_tl(addr, cpu_gr[rx], scale);
+        tcg_gen_add_tl(addr, addr, base);
+    } else {
+        tcg_gen_addi_tl(addr, base, disp);
+    }
+
+    tcg_gen_qemu_st_i64(src, (modify <= 0 ? addr : base), MMU_USER_IDX, mop);
+
+    if (modify != 0) {
+        save_gpr(ctx, rb, addr);
+    }
+    tcg_temp_free(addr);
+}
+
+#if TARGET_LONG_BITS == 64
+#define do_load_tl  do_load_64
+#define do_store_tl do_store_64
+#else
+#define do_load_tl  do_load_32
+#define do_store_tl do_store_32
+#endif
+
+static ExitStatus do_load(DisasContext *ctx, unsigned rt, unsigned rb,
+                          unsigned rx, int scale, target_long disp,
+                          int modify, TCGMemOp mop)
+{
+    TCGv dest;
+
+    nullify_over(ctx);
+
+    if (modify == 0) {
+        /* No base register update.  */
+        dest = dest_gpr(ctx, rt);
+    } else {
+        /* Make sure if RT == RB, we see the result of the load.  */
+        dest = get_temp(ctx);
+    }
+    do_load_tl(ctx, dest, rb, rx, scale, disp, modify, mop);
+    save_gpr(ctx, rt, dest);
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
+                            unsigned rx, int scale, target_long disp,
+                            int modify)
+{
+    TCGv_i32 tmp;
+
+    nullify_over(ctx);
+
+    tmp = tcg_temp_new_i32();
+    do_load_32(ctx, tmp, rb, rx, scale, disp, modify, MO_TEUL);
+    save_frw_i32(rt, tmp);
+    tcg_temp_free_i32(tmp);
+
+    if (rt == 0) {
+        gen_helper_loaded_fr0(cpu_env);
+    }
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
+                            unsigned rx, int scale, target_long disp,
+                            int modify)
+{
+    TCGv_i64 tmp;
+
+    nullify_over(ctx);
+
+    tmp = tcg_temp_new_i64();
+    do_load_64(ctx, tmp, rb, rx, scale, disp, modify, MO_TEQ);
+    save_frd(rt, tmp);
+    tcg_temp_free_i64(tmp);
+
+    if (rt == 0) {
+        gen_helper_loaded_fr0(cpu_env);
+    }
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus do_store(DisasContext *ctx, unsigned rt, unsigned rb,
+                           target_long disp, int modify, TCGMemOp mop)
+{
+    nullify_over(ctx);
+    do_store_tl(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, modify, mop);
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
+                             unsigned rx, int scale, target_long disp,
+                             int modify)
+{
+    TCGv_i32 tmp;
+
+    nullify_over(ctx);
+
+    tmp = load_frw_i32(rt);
+    do_store_32(ctx, tmp, rb, rx, scale, disp, modify, MO_TEUL);
+    tcg_temp_free_i32(tmp);
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
+                             unsigned rx, int scale, target_long disp,
+                             int modify)
+{
+    TCGv_i64 tmp;
+
+    nullify_over(ctx);
+
+    tmp = load_frd(rt);
+    do_store_64(ctx, tmp, rb, rx, scale, disp, modify, MO_TEQ);
+    tcg_temp_free_i64(tmp);
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
 /* Emit an unconditional branch to a direct target, which may or may not
    have already had nullification handled.  */
 static ExitStatus do_dbranch(DisasContext *ctx, target_ulong dest,
@@ -1547,6 +1824,149 @@ static ExitStatus trans_cmpiclr(DisasContext *ctx, uint32_t insn)
     return nullify_end(ctx, ret);
 }
 
+static ExitStatus trans_ld_idx_i(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned m = extract32(insn, 5, 1);
+    unsigned sz = extract32(insn, 6, 2);
+    unsigned a = extract32(insn, 13, 1);
+    int disp = low_sextract(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    int modify = (m ? (a ? -1 : 1) : 0);
+    TCGMemOp mop = MO_TE | sz;
+
+    return do_load(ctx, rt, rb, 0, 0, disp, modify, mop);
+}
+
+static ExitStatus trans_ld_idx_x(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned m = extract32(insn, 5, 1);
+    unsigned sz = extract32(insn, 6, 2);
+    unsigned u = extract32(insn, 13, 1);
+    unsigned rx = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    TCGMemOp mop = MO_TE | sz;
+
+    return do_load(ctx, rt, rb, rx, u ? sz : 0, 0, m, mop);
+}
+
+static ExitStatus trans_st_idx_i(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
+{
+    int disp = low_sextract(insn, 0, 5);
+    unsigned m = extract32(insn, 5, 1);
+    unsigned sz = extract32(insn, 6, 2);
+    unsigned a = extract32(insn, 13, 1);
+    unsigned rr = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    int modify = (m ? (a ? -1 : 1) : 0);
+    TCGMemOp mop = MO_TE | sz;
+
+    return do_store(ctx, rr, rb, disp, modify, mop);
+}
+
+static ExitStatus trans_ldcw(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned m = extract32(insn, 5, 1);
+    unsigned i = extract32(insn, 12, 1);
+    unsigned au = extract32(insn, 13, 1);
+    unsigned rx = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    TCGMemOp mop = MO_TEUL | MO_ALIGN_16;
+    TCGv zero, addr, base, dest;
+    int modify, disp = 0, scale = 0;
+
+    nullify_over(ctx);
+
+    /* ??? Share more code with do_load and do_load_{32,64}.  */
+
+    if (i) {
+        modify = (m ? (au ? -1 : 1) : 0);
+        disp = low_sextract(rx, 0, 5);
+        rx = 0;
+    } else {
+        modify = m;
+        if (au) {
+            scale = mop & MO_SIZE;
+        }
+    }
+    if (modify) {
+        /* Base register modification.  Make sure if RT == RB, we see
+           the result of the load.  */
+        dest = get_temp(ctx);
+    } else {
+        dest = dest_gpr(ctx, rt);
+    }
+
+    addr = tcg_temp_new();
+    base = load_gpr(ctx, rb);
+    if (rx) {
+        tcg_gen_shli_tl(addr, cpu_gr[rx], scale);
+        tcg_gen_add_tl(addr, addr, base);
+    } else {
+        tcg_gen_addi_tl(addr, base, disp);
+    }
+
+    zero = tcg_const_tl(0);
+    tcg_gen_atomic_xchg_tl(dest, (modify <= 0 ? addr : base),
+                           zero, MMU_USER_IDX, mop);
+    if (modify) {
+        save_gpr(ctx, rb, addr);
+    }
+    save_gpr(ctx, rt, dest);
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static ExitStatus trans_stby(DisasContext *ctx, uint32_t insn,
+                             const DisasInsn *di)
+{
+    target_long disp = low_sextract(insn, 0, 5);
+    unsigned m = extract32(insn, 5, 1);
+    unsigned a = extract32(insn, 13, 1);
+    unsigned rt = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    TCGv addr, val;
+
+    nullify_over(ctx);
+
+    addr = tcg_temp_new();
+    if (m || disp == 0) {
+        tcg_gen_mov_tl(addr, load_gpr(ctx, rb));
+    } else {
+        tcg_gen_addi_tl(addr, load_gpr(ctx, rb), disp);
+    }
+    val = load_gpr(ctx, rt);
+
+    if (a) {
+        gen_helper_stby_e(cpu_env, addr, val);
+    } else {
+        gen_helper_stby_b(cpu_env, addr, val);
+    }
+
+    if (m) {
+        tcg_gen_addi_tl(addr, addr, disp);
+        tcg_gen_andi_tl(addr, addr, ~3);
+        save_gpr(ctx, rb, addr);
+    }
+    tcg_temp_free(addr);
+
+    return nullify_end(ctx, NO_EXIT);
+}
+
+static const DisasInsn table_index_mem[] = {
+    { 0x0c001000u, 0xfc001300, trans_ld_idx_i }, /* LD[BHWD], im */
+    { 0x0c000000u, 0xfc001300, trans_ld_idx_x }, /* LD[BHWD], rx */
+    { 0x0c001200u, 0xfc001300, trans_st_idx_i }, /* ST[BHWD] */
+    { 0x0c0001c0u, 0xfc0003c0, trans_ldcw },
+    { 0x0c001300u, 0xfc0013c0, trans_stby },
+};
+
 static ExitStatus trans_ldil(DisasContext *ctx, uint32_t insn)
 {
     unsigned rt = extract32(insn, 21, 5);
@@ -1594,6 +2014,160 @@ static ExitStatus trans_ldo(DisasContext *ctx, uint32_t insn)
     return NO_EXIT;
 }
 
+static ExitStatus trans_load(DisasContext *ctx, uint32_t insn,
+                             bool is_mod, TCGMemOp mop)
+{
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned rt = extract32(insn, 16, 5);
+    target_long i = assemble_16(insn);
+
+    return do_load(ctx, rt, rb, 0, 0, i, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
+}
+
+static ExitStatus trans_load_w(DisasContext *ctx, uint32_t insn)
+{
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned rt = extract32(insn, 16, 5);
+    target_long i = assemble_16a(insn);
+    unsigned ext2 = extract32(insn, 1, 2);
+
+    switch (ext2) {
+    case 0:
+    case 1:
+        /* FLDW without modification.  */
+        return do_floadw(ctx, ext2 * 32 + rt, rb, 0, 0, i, 0);
+    case 2:
+        /* LDW with modification.  Note that the sign of I selects
+           post-dec vs pre-inc.  */
+        return do_load(ctx, rt, rb, 0, 0, i, (i < 0 ? 1 : -1), MO_TEUL);
+    default:
+        return gen_illegal(ctx);
+    }
+}
+
+static ExitStatus trans_fload_mod(DisasContext *ctx, uint32_t insn)
+{
+    target_long i = assemble_16a(insn);
+    unsigned t1 = extract32(insn, 1, 1);
+    unsigned a = extract32(insn, 2, 1);
+    unsigned t0 = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+
+    /* FLDW with modification.  */
+    return do_floadw(ctx, t1 * 32 + t0, rb, 0, 0, i, (a ? -1 : 1));
+}
+
+static ExitStatus trans_store(DisasContext *ctx, uint32_t insn,
+                              bool is_mod, TCGMemOp mop)
+{
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned rt = extract32(insn, 16, 5);
+    target_long i = assemble_16(insn);
+
+    return do_store(ctx, rt, rb, i, is_mod ? (i < 0 ? -1 : 1) : 0, mop);
+}
+
+static ExitStatus trans_store_w(DisasContext *ctx, uint32_t insn)
+{
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned rt = extract32(insn, 16, 5);
+    target_long i = assemble_16a(insn);
+    unsigned ext2 = extract32(insn, 1, 2);
+
+    switch (ext2) {
+    case 0:
+    case 1:
+        /* FSTW without modification.  */
+        return do_fstorew(ctx, ext2 * 32 + rt, rb, 0, 0, i, 0);
+    case 2:
+        /* LDW with modification.  */
+        return do_store(ctx, rt, rb, i, (i < 0 ? 1 : -1), MO_TEUL);
+    default:
+        return gen_illegal(ctx);
+    }
+}
+
+static ExitStatus trans_fstore_mod(DisasContext *ctx, uint32_t insn)
+{
+    target_long i = assemble_16a(insn);
+    unsigned t1 = extract32(insn, 1, 1);
+    unsigned a = extract32(insn, 2, 1);
+    unsigned t0 = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+
+    /* FSTW with modification.  */
+    return do_fstorew(ctx, t1 * 32 + t0, rb, 0, 0, i, (a ? -1 : 1));
+}
+
+static ExitStatus trans_copr_w(DisasContext *ctx, uint32_t insn)
+{
+    unsigned t0 = extract32(insn, 0, 5);
+    unsigned m = extract32(insn, 5, 1);
+    unsigned t1 = extract32(insn, 6, 1);
+    unsigned ext3 = extract32(insn, 7, 3);
+    /* unsigned cc = extract32(insn, 10, 2); */
+    unsigned i = extract32(insn, 12, 1);
+    unsigned ua = extract32(insn, 13, 1);
+    unsigned rx = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    unsigned rt = t1 * 32 + t0;
+    int modify = (m ? (ua ? -1 : 1) : 0);
+    int disp, scale;
+
+    if (i == 0) {
+        scale = (ua ? 2 : 0);
+        disp = 0;
+        modify = m;
+    } else {
+        disp = low_sextract(rx, 0, 5);
+        scale = 0;
+        rx = 0;
+        modify = (m ? (ua ? -1 : 1) : 0);
+    }
+
+    switch (ext3) {
+    case 0: /* FLDW */
+        return do_floadw(ctx, rt, rb, rx, scale, disp, modify);
+    case 4: /* FSTW */
+        return do_fstorew(ctx, rt, rb, rx, scale, disp, modify);
+    }
+    return gen_illegal(ctx);
+}
+
+static ExitStatus trans_copr_dw(DisasContext *ctx, uint32_t insn)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    unsigned m = extract32(insn, 5, 1);
+    unsigned ext4 = extract32(insn, 6, 4);
+    /* unsigned cc = extract32(insn, 10, 2); */
+    unsigned i = extract32(insn, 12, 1);
+    unsigned ua = extract32(insn, 13, 1);
+    unsigned rx = extract32(insn, 16, 5);
+    unsigned rb = extract32(insn, 21, 5);
+    int modify = (m ? (ua ? -1 : 1) : 0);
+    int disp, scale;
+
+    if (i == 0) {
+        scale = (ua ? 3 : 0);
+        disp = 0;
+        modify = m;
+    } else {
+        disp = low_sextract(rx, 0, 5);
+        scale = 0;
+        rx = 0;
+        modify = (m ? (ua ? -1 : 1) : 0);
+    }
+
+    switch (ext4) {
+    case 0: /* FLDD */
+        return do_floadd(ctx, rt, rb, rx, scale, disp, modify);
+    case 8: /* FSTD */
+        return do_fstored(ctx, rt, rb, rx, scale, disp, modify);
+    default:
+        return gen_illegal(ctx);
+    }
+}
+
 static ExitStatus trans_cmpb(DisasContext *ctx, uint32_t insn,
                              bool is_true, bool is_imm, bool is_dw)
 {
@@ -2139,12 +2713,44 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     switch (opc) {
     case 0x02:
         return translate_table(ctx, insn, table_arith_log);
+    case 0x03:
+        return translate_table(ctx, insn, table_index_mem);
     case 0x08:
         return trans_ldil(ctx, insn);
+    case 0x09:
+        return trans_copr_w(ctx, insn);
     case 0x0A:
         return trans_addil(ctx, insn);
+    case 0x0B:
+        return trans_copr_dw(ctx, insn);
     case 0x0D:
         return trans_ldo(ctx, insn);
+
+    case 0x10:
+        return trans_load(ctx, insn, false, MO_UB);
+    case 0x11:
+        return trans_load(ctx, insn, false, MO_TEUW);
+    case 0x12:
+        return trans_load(ctx, insn, false, MO_TEUL);
+    case 0x13:
+        return trans_load(ctx, insn, true, MO_TEUL);
+    case 0x16:
+        return trans_fload_mod(ctx, insn);
+    case 0x17:
+        return trans_load_w(ctx, insn);
+    case 0x18:
+        return trans_store(ctx, insn, false, MO_UB);
+    case 0x19:
+        return trans_store(ctx, insn, false, MO_TEUW);
+    case 0x1A:
+        return trans_store(ctx, insn, false, MO_TEUL);
+    case 0x1B:
+        return trans_store(ctx, insn, true, MO_TEUL);
+    case 0x1E:
+        return trans_fstore_mod(ctx, insn);
+    case 0x1F:
+        return trans_store_w(ctx, insn);
+
     case 0x20:
         return trans_cmpb(ctx, insn, true, false, false);
     case 0x21:
@@ -2172,6 +2778,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         return trans_addi(ctx, insn);
     case 0x2F:
         return trans_cmpb(ctx, insn, false, false, true);
+
     case 0x30:
     case 0x31:
         return trans_bb(ctx, insn);
@@ -2189,6 +2796,17 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         return trans_be(ctx, insn, true);
     case 0x3A:
         return translate_table(ctx, insn, table_branch);
+
+    case 0x04: /* spopn */
+    case 0x05: /* diag */
+    case 0x0F: /* product specific */
+        break;
+
+    case 0x07: /* unassigned */
+    case 0x15: /* unassigned */
+    case 0x1D: /* unassigned */
+    case 0x37: /* unassigned */
+    case 0x3F: /* unassigned */
     default:
         break;
     }
-- 
2.9.3
