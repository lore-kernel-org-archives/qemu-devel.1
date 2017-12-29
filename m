Received: from eggs.gnu.org ([2001:4830:134:3::10]:50756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDH-00033D-1k
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDE-0004hM-Qk
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:15 -0500
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:39296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDE-0004gm-Ht
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:12 -0500
Received: by mail-pl0-x22f.google.com with SMTP id bi12so22517809plb.6
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:24 -0800
Message-Id: <20171229063145.29167-18-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/38] target/hppa: Implement IASQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Any one TB will have only one space value.  If we change
spaces, we change TBs.  Thus BE and BEV must exit the TB
immediately.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  48 +++++++++++++++++++++--
 target/hppa/cpu.c        |  11 +++++-
 target/hppa/helper.c     |   3 +-
 target/hppa/int_helper.c |  16 ++++++--
 target/hppa/op_helper.c  |   2 +
 target/hppa/translate.c  | 100 +++++++++++++++++++++++++++++++++++++----------
 6 files changed, 151 insertions(+), 29 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index babad0d2c1..0ae4a1c399 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -186,6 +186,8 @@ struct CPUHPPAState {
 
     target_ureg iaoq_f;      /* front */
     target_ureg iaoq_b;      /* back, aka next instruction */
+    uint64_t iasq_f;
+    uint64_t iasq_b;
 
     uint32_t fr0_shadow;     /* flags, c, ca/cq, rm, d, enables */
     float_status fp_status;
@@ -240,24 +242,64 @@ void hppa_translate_init(void);
 
 void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
-/* Since PSW_V will never need to be in tb->flags, reuse it.
+static inline target_ulong hppa_form_gva_psw(target_ureg psw, uint64_t spc,
+                                             target_ureg off)
+{
+#ifdef CONFIG_USER_ONLY
+    return off;
+#else
+    off &= (psw & PSW_W ? 0x3fffffffffffffffull : 0xffffffffull);
+    return spc | off;
+#endif
+}
+
+static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
+                                         target_ureg off)
+{
+    return hppa_form_gva_psw(env->psw, spc, off);
+}
+
+/* Since PSW_V and PSW_CB will never need to be in tb->flags, reuse them.
  * TB_FLAG_NONSEQ indicates that the two instructions in the insn queue
  * are non-sequential.
  */
-#define TB_FLAG_NONSEQ  PSW_V
+#define TB_FLAG_NONSEQ      PSW_V
+#define TB_FLAG_PRIV_SHIFT  8
 
 static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, target_ulong *pc,
                                         target_ulong *cs_base,
                                         uint32_t *pflags)
 {
     bool nonseq = env->iaoq_b != env->iaoq_f + 4;
+    int priv;
 
+    /* TB lookup assumes that PC contains the complete virtual address.
+       If we leave space+offset separate, we'll get ITLB misses to an
+       incomplete virtual address.  This also means that we must separate
+       out current cpu priviledge from the low bits of IAOQ_F.  */
+#ifdef CONFIG_USER_ONLY
     *pc = env->iaoq_f;
     *cs_base = 0;
+    priv = MMU_USER_IDX;
+#else
+    priv = env->iaoq_f & 3;
+    if (env->psw & PSW_C) {
+        /* Executing from virtual addresses.  */
+        *pc = hppa_form_gva_psw(env->psw, env->iasq_f, env->iaoq_f & -4);
+        *cs_base = env->iasq_f;
+        nonseq |= env->iasq_b != env->iasq_f;
+    } else {
+        /* Executing from physical addresses.  */
+        *pc = env->iaoq_f & -4;
+        *cs_base = 0;
+    }
+#endif
+
     /* ??? E, T, H, L, B, P bits need to be here, when implemented.  */
     *pflags = (env->psw & (PSW_W | PSW_C | PSW_D))
             | env->psw_n * PSW_N
-            | nonseq * TB_FLAG_NONSEQ;
+            | nonseq * TB_FLAG_NONSEQ
+            | (priv << TB_FLAG_PRIV_SHIFT);
 }
 
 target_ureg cpu_hppa_get_psw(CPUHPPAState *env);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 715233c59a..fbda7956bc 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -36,11 +36,18 @@ static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 static void hppa_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
+    target_ulong iasq_f;
+    target_ureg iaoq_f;
 
-    cpu->env.iaoq_f = tb->pc;
+    /* Recover the IAOQ value from the GVA + PRIV.  */
+    iasq_f = tb->cs_base;
+    iaoq_f = (tb->pc & ~iasq_f) + ((tb->flags >> TB_FLAG_PRIV_SHIFT) & 3);
     if (!(tb->flags & TB_FLAG_NONSEQ)) {
-        cpu->env.iaoq_b = tb->pc + 4;
+        cpu->env.iasq_b = iasq_f;
+        cpu->env.iaoq_b = iaoq_f + 4;
     }
+    cpu->env.iasq_f = iasq_f;
+    cpu->env.iaoq_f = iaoq_f;
     cpu->env.psw_n = (tb->flags & PSW_N) != 0;
 }
 
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index cab50c6ddd..2688479351 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -78,7 +78,8 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f,
     int i;
 
     cpu_fprintf(f, "IA_F " TARGET_FMT_lx " IA_B " TARGET_FMT_lx "\n",
-                (target_ulong)env->iaoq_f, (target_ulong)env->iaoq_b);
+                hppa_form_gva_psw(psw, env->iasq_f, env->iaoq_f),
+                hppa_form_gva_psw(psw, env->iasq_b, env->iaoq_b));
 
     psw_c[0]  = (psw & PSW_W ? 'W' : '-');
     psw_c[1]  = (psw & PSW_E ? 'E' : '-');
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 34413c30e1..297aa62c24 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -32,6 +32,8 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     int i = cs->exception_index;
     target_ureg iaoq_f = env->iaoq_f;
     target_ureg iaoq_b = env->iaoq_b;
+    uint64_t iasq_f = env->iasq_f;
+    uint64_t iasq_b = env->iasq_b;
 
 #ifndef CONFIG_USER_ONLY
     target_ureg old_psw;
@@ -44,6 +46,8 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     cpu_hppa_put_psw(env, PSW_W | (i == EXCP_HPMC ? PSW_M : 0));
 
     /* step 3 */
+    env->cr[CR_IIASQ] = iasq_f >> 32;
+    env->cr_back[0] = iasq_b >> 32;
     env->cr[CR_IIAOQ] = iaoq_f;
     env->cr_back[1] = iaoq_b;
 
@@ -78,6 +82,9 @@ void hppa_cpu_do_interrupt(CPUState *cs)
             hwaddr paddr;
 
             paddr = vaddr = iaoq_f & -4;
+            if (old_psw & PSW_C) {
+                vaddr = hppa_form_gva_psw(old_psw, iasq_f, iaoq_f & -4);
+            }
             env->cr[CR_IIR] = ldl_phys(cs->as, paddr);
         }
         break;
@@ -101,6 +108,8 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     /* step 7 */
     env->iaoq_f = env->cr[CR_IVA] + 32 * i;
     env->iaoq_b = env->iaoq_f + 4;
+    env->iasq_f = 0;
+    env->iasq_b = 0;
 #endif
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
@@ -151,10 +160,11 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         qemu_log("INT %6d: %s @ " TARGET_FMT_lx "," TARGET_FMT_lx
                  " -> " TREG_FMT_lx " " TARGET_FMT_lx "\n",
                  ++count, name,
-                 (target_ulong)iaoq_f,
-                 (target_ulong)iaoq_b,
+                 hppa_form_gva(env, iasq_f, iaoq_f),
+                 hppa_form_gva(env, iasq_b, iaoq_b),
                  env->iaoq_f,
-                 (target_ulong)env->cr[CR_IOR]);
+                 hppa_form_gva(env, (uint64_t)env->cr[CR_ISR] << 32,
+                               env->cr[CR_IOR]));
     }
     cs->exception_index = -1;
 }
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 3f5dcbbca0..1963b2439b 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -622,6 +622,8 @@ void HELPER(rfi)(CPUHPPAState *env)
     if (env->psw & (PSW_I | PSW_R | PSW_Q)) {
         helper_excp(env, EXCP_ILL);
     }
+    env->iasq_f = (uint64_t)env->cr[CR_IIASQ] << 32;
+    env->iasq_b = (uint64_t)env->cr_back[0] << 32;
     env->iaoq_f = env->cr[CR_IIAOQ];
     env->iaoq_b = env->cr_back[1];
     cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 918b444895..d928bfe335 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -322,6 +322,8 @@ static TCGv_reg cpu_gr[32];
 static TCGv_i64 cpu_sr[4];
 static TCGv_reg cpu_iaoq_f;
 static TCGv_reg cpu_iaoq_b;
+static TCGv_i64 cpu_iasq_f;
+static TCGv_i64 cpu_iasq_b;
 static TCGv_reg cpu_sar;
 static TCGv_reg cpu_psw_n;
 static TCGv_reg cpu_psw_v;
@@ -377,6 +379,13 @@ void hppa_translate_init(void)
         const GlobalVar *v = &vars[i];
         *v->var = tcg_global_mem_new(cpu_env, v->ofs, v->name);
     }
+
+    cpu_iasq_f = tcg_global_mem_new_i64(cpu_env,
+                                        offsetof(CPUHPPAState, iasq_f),
+                                        "iasq_f");
+    cpu_iasq_b = tcg_global_mem_new_i64(cpu_env,
+                                        offsetof(CPUHPPAState, iasq_b),
+                                        "iasq_b");
 }
 
 static DisasCond cond_make_f(void)
@@ -1751,6 +1760,11 @@ static DisasJumpType do_cbranch(DisasContext *ctx, target_sreg disp, bool is_n,
             ctx->null_lab = NULL;
         }
         nullify_set(ctx, n);
+        if (ctx->iaoq_n == -1) {
+            /* The temporary iaoq_n_var died at the branch above.
+               Regenerate it here instead of saving it.  */
+            tcg_gen_addi_reg(ctx->iaoq_n_var, cpu_iaoq_b, 4);
+        }
         gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
     }
 
@@ -3474,26 +3488,55 @@ static DisasJumpType trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
     target_sreg disp = assemble_17(insn);
     TCGv_reg tmp;
 
-    /* unsigned s = low_uextract(insn, 13, 3); */
+#ifdef CONFIG_USER_ONLY
     /* ??? It seems like there should be a good way of using
        "be disp(sr2, r0)", the canonical gateway entry mechanism
        to our advantage.  But that appears to be inconvenient to
        manage along side branch delay slots.  Therefore we handle
        entry into the gateway page via absolute address.  */
-
-#ifdef CONFIG_USER_ONLY
     /* Since we don't implement spaces, just branch.  Do notice the special
        case of "be disp(*,r0)" using a direct branch to disp, so that we can
        goto_tb to the TB containing the syscall.  */
     if (b == 0) {
         return do_dbranch(ctx, disp, is_l ? 31 : 0, n);
     }
+#else
+    int sp = assemble_sr3(insn);
+    nullify_over(ctx);
 #endif
 
     tmp = get_temp(ctx);
     tcg_gen_addi_reg(tmp, load_gpr(ctx, b), disp);
     tmp = do_ibranch_priv(ctx, tmp);
+
+#ifdef CONFIG_USER_ONLY
     return do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
+#else
+    TCGv_i64 new_spc = tcg_temp_new_i64();
+
+    load_spr(ctx, new_spc, sp);
+    if (is_l) {
+        copy_iaoq_entry(cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
+        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_f);
+    }
+    if (n && use_nullify_skip(ctx)) {
+        tcg_gen_mov_reg(cpu_iaoq_f, tmp);
+        tcg_gen_addi_reg(cpu_iaoq_b, cpu_iaoq_f, 4);
+        tcg_gen_mov_i64(cpu_iasq_f, new_spc);
+        tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
+    } else {
+        copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+        if (ctx->iaoq_b == -1) {
+            tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
+        }
+        tcg_gen_mov_reg(cpu_iaoq_b, tmp);
+        tcg_gen_mov_i64(cpu_iasq_b, new_spc);
+        nullify_set(ctx, n);
+    }
+    tcg_temp_free_i64(new_spc);
+    tcg_gen_lookup_and_goto_ptr();
+    return nullify_end(ctx, DISAS_NORETURN);
+#endif
 }
 
 static DisasJumpType trans_bl(DisasContext *ctx, uint32_t insn,
@@ -3556,8 +3599,26 @@ static DisasJumpType trans_bve(DisasContext *ctx, uint32_t insn,
     unsigned link = extract32(insn, 13, 1) ? 2 : 0;
     TCGv_reg dest;
 
+#ifdef CONFIG_USER_ONLY
     dest = do_ibranch_priv(ctx, load_gpr(ctx, rb));
     return do_ibranch(ctx, dest, link, n);
+#else
+    nullify_over(ctx);
+    dest = do_ibranch_priv(ctx, load_gpr(ctx, rb));
+
+    copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+    if (ctx->iaoq_b == -1) {
+        tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
+    }
+    copy_iaoq_entry(cpu_iaoq_b, -1, dest);
+    tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
+    if (link) {
+        copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+    }
+    nullify_set(ctx, n);
+    tcg_gen_lookup_and_goto_ptr();
+    return nullify_end(ctx, DISAS_NORETURN);
+#endif
 }
 
 static const DisasInsn table_branch[] = {
@@ -4264,15 +4325,17 @@ static int hppa_tr_init_disas_context(DisasContextBase *dcbase,
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = MMU_USER_IDX;
     ctx->mmu_idx = MMU_USER_IDX;
+    ctx->iaoq_f = ctx->base.pc_first;
 #else
-    ctx->privilege = ctx->base.pc_first & 3;
+    ctx->privilege = (ctx->base.tb->flags >> TB_FLAG_PRIV_SHIFT) & 3;
     ctx->mmu_idx = (ctx->base.tb->flags & PSW_D
                     ? ctx->privilege : MMU_PHYS_IDX);
+    /* Recover the IAOQ value from the GVA + PRIV.  */
+    ctx->iaoq_f = (ctx->base.pc_first & ~ctx->base.tb->cs_base)
+                + ctx->privilege;
 #endif
-    ctx->iaoq_f = ctx->base.pc_first;
     ctx->iaoq_b = (ctx->base.tb->flags & TB_FLAG_NONSEQ
                    ? -1 : ctx->iaoq_f + 4);
-    ctx->base.pc_first &= -4;
 
     ctx->iaoq_n = -1;
     ctx->iaoq_n_var = NULL;
@@ -4316,7 +4379,7 @@ static bool hppa_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     ctx->base.is_jmp = gen_excp(ctx, EXCP_DEBUG);
-    ctx->base.pc_next = (ctx->iaoq_f & -4) + 4;
+    ctx->base.pc_next += 4;
     return true;
 }
 
@@ -4329,7 +4392,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
     /* Execute one insn.  */
 #ifdef CONFIG_USER_ONLY
-    if (ctx->iaoq_f < TARGET_PAGE_SIZE) {
+    if (ctx->base.pc_next < TARGET_PAGE_SIZE) {
         ret = do_page_zero(ctx);
         assert(ret != DISAS_NEXT);
     } else
@@ -4337,7 +4400,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     {
         /* Always fetch the insn, even if nullified, so that we check
            the page permissions for execute.  */
-        uint32_t insn = cpu_ldl_code(env, ctx->iaoq_f & -4);
+        uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
@@ -4373,13 +4436,10 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     ctx->ntempl = 0;
 
     /* Advance the insn queue.  */
-    /* ??? The non-linear instruction restriction is purely due to
-       the debugging dump.  Otherwise we *could* follow unconditional
-       branches within the same page.  */
     if (ret == DISAS_NEXT && ctx->iaoq_b != ctx->iaoq_f + 4) {
-        if (ctx->null_cond.c == TCG_COND_NEVER
-            || ctx->null_cond.c == TCG_COND_ALWAYS) {
-            nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
+        if (ctx->iaoq_b != -1 && ctx->iaoq_n != -1
+            && use_goto_tb(ctx, ctx->iaoq_b)) {
+            nullify_save(ctx);
             gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
             ret = DISAS_NORETURN;
         } else {
@@ -4389,6 +4449,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     ctx->iaoq_f = ctx->iaoq_b;
     ctx->iaoq_b = ctx->iaoq_n;
     ctx->base.is_jmp = ret;
+    ctx->base.pc_next += 4;
 
     if (ret == DISAS_NORETURN || ret == DISAS_IAQ_N_UPDATED) {
         return;
@@ -4396,6 +4457,9 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     if (ctx->iaoq_f == -1) {
         tcg_gen_mov_reg(cpu_iaoq_f, cpu_iaoq_b);
         copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+#ifndef CONFIG_USER_ONLY
+        tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
+#endif
         nullify_save(ctx);
         ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
     } else if (ctx->iaoq_b == -1) {
@@ -4432,15 +4496,11 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     default:
         g_assert_not_reached();
     }
-
-    /* We don't actually use this during normal translation,
-       but we should interact with the generic main loop.  */
-    ctx->base.pc_next = ctx->base.pc_first + 4 * ctx->base.num_insns;
 }
 
 static void hppa_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
 {
-    target_ureg pc = dcbase->pc_first;
+    target_ulong pc = dcbase->pc_first;
 
 #ifdef CONFIG_USER_ONLY
     switch (pc) {
-- 
2.14.3
