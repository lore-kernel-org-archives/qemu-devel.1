Received: from eggs.gnu.org ([2001:4830:134:3::10]:60473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqG-0002H5-RN
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqF-0004QW-A0
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:16 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:56010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iqF-0004QA-1K
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:15 -0400
Received: by mail-pf0-x22e.google.com with SMTP id 17so7135521pfn.12
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:45 -0700
Message-Id: <20171010005600.28735-9-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 08/23] tcg: remove addr argument from
 lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

It is unlikely that we will ever want to call this helper passing
an argument other than the current PC. So just remove the argument,
and use the pc we already get from cpu_get_tb_cpu_state.

This change paves the way to having a common "tb_lookup" function.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h    |  2 +-
 tcg/tcg-op.h               |  4 ++--
 accel/tcg/tcg-runtime.c    | 20 ++++++++++----------
 target/alpha/translate.c   |  2 +-
 target/arm/translate-a64.c |  4 ++--
 target/arm/translate.c     |  5 +----
 target/hppa/translate.c    |  6 +++---
 target/i386/translate.c    | 17 +++++------------
 target/mips/translate.c    |  4 ++--
 target/s390x/translate.c   |  2 +-
 target/sh4/translate.c     |  4 ++--
 tcg/tcg-op.c               |  4 ++--
 12 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index c41d38a557..1df17d0ba9 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -24,7 +24,7 @@ DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
-DEF_HELPER_FLAGS_2(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env, tl)
+DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env)
 
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 5d3278f243..18d01b2f43 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -797,7 +797,7 @@ static inline void tcg_gen_exit_tb(uintptr_t val)
 void tcg_gen_goto_tb(unsigned idx);
 
 /**
- * tcg_gen_lookup_and_goto_ptr() - look up a TB and jump to it if valid
+ * tcg_gen_lookup_and_goto_ptr() - look up the current TB, jump to it if valid
  * @addr: Guest address of the target TB
  *
  * If the TB is not valid, jump to the epilogue.
@@ -805,7 +805,7 @@ void tcg_gen_goto_tb(unsigned idx);
  * This operation is optional. If the TCG backend does not implement goto_ptr,
  * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the argument.
  */
-void tcg_gen_lookup_and_goto_ptr(TCGv addr);
+void tcg_gen_lookup_and_goto_ptr(void);
 
 #if TARGET_LONG_BITS == 32
 #define tcg_temp_new() tcg_temp_new_i32()
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index aafb171294..b75394aba8 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -144,33 +144,33 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
     return ctpop64(arg);
 }
 
-void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
+void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     TranslationBlock *tb;
     target_ulong cs_base, pc;
-    uint32_t flags, addr_hash;
+    uint32_t flags, hash;
 
-    addr_hash = tb_jmp_cache_hash_func(addr);
-    tb = atomic_rcu_read(&cpu->tb_jmp_cache[addr_hash]);
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
+    hash = tb_jmp_cache_hash_func(pc);
+    tb = atomic_rcu_read(&cpu->tb_jmp_cache[hash]);
 
     if (unlikely(!(tb
-                   && tb->pc == addr
+                   && tb->pc == pc
                    && tb->cs_base == cs_base
                    && tb->flags == flags
                    && tb->trace_vcpu_dstate == *cpu->trace_dstate))) {
-        tb = tb_htable_lookup(cpu, addr, cs_base, flags);
+        tb = tb_htable_lookup(cpu, pc, cs_base, flags);
         if (!tb) {
             return tcg_ctx.code_gen_epilogue;
         }
-        atomic_set(&cpu->tb_jmp_cache[addr_hash], tb);
+        atomic_set(&cpu->tb_jmp_cache[hash], tb);
     }
 
-    qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
+    qemu_log_mask_and_addr(CPU_LOG_EXEC, pc,
                            "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
-                           tb->tc_ptr, cpu->cpu_index, addr,
-                           lookup_symbol(addr));
+                           tb->tc_ptr, cpu->cpu_index, pc,
+                           lookup_symbol(pc));
     return tb->tc_ptr;
 }
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 5a92c4accb..f32c95b9a1 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -3029,7 +3029,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
         if (!use_exit_tb(ctx)) {
-            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            tcg_gen_lookup_and_goto_ptr();
             break;
         }
         /* FALLTHRU */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 899ffb96fc..a39b9d3633 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -379,7 +379,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
         } else if (s->base.singlestep_enabled) {
             gen_exception_internal(EXCP_DEBUG);
         } else {
-            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            tcg_gen_lookup_and_goto_ptr();
             s->base.is_jmp = DISAS_NORETURN;
         }
     }
@@ -11363,7 +11363,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_a64_set_pc_im(dc->pc);
             /* fall through */
         case DISAS_JUMP:
-            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            tcg_gen_lookup_and_goto_ptr();
             break;
         case DISAS_EXIT:
             tcg_gen_exit_tb(0);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ab1a12a1b8..fdc46cc525 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4173,10 +4173,7 @@ static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
 
 static void gen_goto_ptr(void)
 {
-    TCGv addr = tcg_temp_new();
-    tcg_gen_extu_i32_tl(addr, cpu_R[15]);
-    tcg_gen_lookup_and_goto_ptr(addr);
-    tcg_temp_free(addr);
+    tcg_gen_lookup_and_goto_ptr();
 }
 
 /* This will end the TB but doesn't guarantee we'll return to
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b6e2652341..26242f4b3c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -505,7 +505,7 @@ static void gen_goto_tb(DisasContext *ctx, int which,
         if (ctx->base.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG);
         } else {
-            tcg_gen_lookup_and_goto_ptr(cpu_iaoq_f);
+            tcg_gen_lookup_and_goto_ptr();
         }
     }
 }
@@ -1515,7 +1515,7 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv dest,
         if (link != 0) {
             tcg_gen_movi_tl(cpu_gr[link], ctx->iaoq_n);
         }
-        tcg_gen_lookup_and_goto_ptr(cpu_iaoq_f);
+        tcg_gen_lookup_and_goto_ptr();
         return nullify_end(ctx, DISAS_NEXT);
     } else {
         cond_prep(&ctx->null_cond);
@@ -3873,7 +3873,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         if (ctx->base.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG);
         } else {
-            tcg_gen_lookup_and_goto_ptr(cpu_iaoq_f);
+            tcg_gen_lookup_and_goto_ptr();
         }
         break;
     default:
diff --git a/target/i386/translate.c b/target/i386/translate.c
index a8986f4c1a..a74e7bb177 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2511,7 +2511,7 @@ static void gen_bnd_jmp(DisasContext *s)
    If RECHECK_TF, emit a rechecking helper for #DB, ignoring the state of
    S->TF.  This is used by the syscall/sysret insns.  */
 static void
-do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
+do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
 {
     gen_update_cc_op(s);
 
@@ -2532,12 +2532,8 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
         tcg_gen_exit_tb(0);
     } else if (s->tf) {
         gen_helper_single_step(cpu_env);
-    } else if (!TCGV_IS_UNUSED(jr)) {
-        TCGv vaddr = tcg_temp_new();
-
-        tcg_gen_add_tl(vaddr, jr, cpu_seg_base[R_CS]);
-        tcg_gen_lookup_and_goto_ptr(vaddr);
-        tcg_temp_free(vaddr);
+    } else if (jr) {
+        tcg_gen_lookup_and_goto_ptr();
     } else {
         tcg_gen_exit_tb(0);
     }
@@ -2547,10 +2543,7 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
 static inline void
 gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
 {
-    TCGv unused;
-
-    TCGV_UNUSED(unused);
-    do_gen_eob_worker(s, inhibit, recheck_tf, unused);
+    do_gen_eob_worker(s, inhibit, recheck_tf, false);
 }
 
 /* End of block.
@@ -2569,7 +2562,7 @@ static void gen_eob(DisasContext *s)
 /* Jump to register */
 static void gen_jr(DisasContext *s, TCGv dest)
 {
-    do_gen_eob_worker(s, false, false, dest);
+    do_gen_eob_worker(s, false, false, true);
 }
 
 /* generate a jump to eip. No segment change must happen before as a
diff --git a/target/mips/translate.c b/target/mips/translate.c
index d16d879df7..ac05f3aa09 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4303,7 +4303,7 @@ static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
             save_cpu_state(ctx, 0);
             gen_helper_raise_exception_debug(cpu_env);
         }
-        tcg_gen_lookup_and_goto_ptr(cpu_PC);
+        tcg_gen_lookup_and_goto_ptr();
     }
 }
 
@@ -10883,7 +10883,7 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
                 save_cpu_state(ctx, 0);
                 gen_helper_raise_exception_debug(cpu_env);
             }
-            tcg_gen_lookup_and_goto_ptr(cpu_PC);
+            tcg_gen_lookup_and_goto_ptr();
             break;
         default:
             fprintf(stderr, "unknown branch 0x%x\n", proc_hflags);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 9ef95141f9..165d2cac3e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5949,7 +5949,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         } else if (use_exit_tb(&dc) || status == EXIT_PC_STALE_NOCHAIN) {
             tcg_gen_exit_tb(0);
         } else {
-            tcg_gen_lookup_and_goto_ptr(psw_addr);
+            tcg_gen_lookup_and_goto_ptr();
         }
         break;
     default:
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 10191073b2..8db9fba26e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -261,7 +261,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
         } else if (use_exit_tb(ctx)) {
             tcg_gen_exit_tb(0);
         } else {
-            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            tcg_gen_lookup_and_goto_ptr();
         }
     }
 }
@@ -278,7 +278,7 @@ static void gen_jump(DisasContext * ctx)
         } else if (use_exit_tb(ctx)) {
             tcg_gen_exit_tb(0);
         } else {
-            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            tcg_gen_lookup_and_goto_ptr();
         }
     } else {
 	gen_goto_tb(ctx, 0, ctx->delayed_pc);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 688d91755b..d3c0e4799e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2588,11 +2588,11 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_gen_op1i(INDEX_op_goto_tb, idx);
 }
 
-void tcg_gen_lookup_and_goto_ptr(TCGv addr)
+void tcg_gen_lookup_and_goto_ptr(void)
 {
     if (TCG_TARGET_HAS_goto_ptr && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
         TCGv_ptr ptr = tcg_temp_new_ptr();
-        gen_helper_lookup_tb_ptr(ptr, tcg_ctx.tcg_env, addr);
+        gen_helper_lookup_tb_ptr(ptr, tcg_ctx.tcg_env);
         tcg_gen_op1i(INDEX_op_goto_ptr, GET_TCGV_PTR(ptr));
         tcg_temp_free_ptr(ptr);
     } else {
-- 
2.13.6
