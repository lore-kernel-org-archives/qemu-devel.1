Received: from eggs.gnu.org ([2001:4830:134:3::10]:48274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOtFN-00055Y-4z
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 19:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOtFI-0007pB-Pj
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 19:14:13 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOtFI-0007nd-DH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 19:14:08 -0400
Received: by mail-pf0-x242.google.com with SMTP id w129-v6so13174778pfd.3
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 16:14:08 -0700 (PDT)
Received: from cloudburst.twiddle.net (97-126-112-211.tukw.qwest.net.
	[97.126.112.211]) by smtp.gmail.com with ESMTPSA id
	x19-v6sm29357455pfi.5.2018.06.01.16.14.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 01 Jun 2018 16:14:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 16:14:03 -0700
Message-Id: <20180601231403.10525-2-richard.henderson@linaro.org>
In-Reply-To: <20180601231403.10525-1-richard.henderson@linaro.org>
References: <20180601231403.10525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/1] tcg: Pass tb and index to tcg_gen_exit_tb
 separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Do the cast to uintptr_t within the helper, so that the compiler
can type check the pointer argument.  We can also do some more
sanity checking of the index argument.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gen-icount.h     |  2 +-
 tcg/tcg-op.h                  | 17 +++++++++++++----
 tcg/tcg.h                     |  7 ++++---
 target/alpha/translate.c      | 12 ++++++------
 target/arm/translate-a64.c    |  6 +++---
 target/arm/translate.c        |  8 ++++----
 target/cris/translate.c       |  6 +++---
 target/hppa/translate.c       |  6 +++---
 target/i386/translate.c       |  8 ++++----
 target/lm32/translate.c       |  6 +++---
 target/m68k/translate.c       |  6 +++---
 target/microblaze/translate.c |  6 +++---
 target/mips/translate.c       |  4 ++--
 target/moxie/translate.c      | 14 +++++++-------
 target/nios2/translate.c      |  8 ++++----
 target/openrisc/translate.c   |  6 +++---
 target/ppc/translate.c        |  4 ++--
 target/riscv/translate.c      | 20 ++++++++++----------
 target/s390x/translate.c      | 10 +++++-----
 target/sh4/translate.c        |  8 ++++----
 target/sparc/translate.c      | 16 ++++++++--------
 target/tilegx/translate.c     |  4 ++--
 target/tricore/translate.c    | 20 ++++++++++----------
 target/unicore32/translate.c  |  6 +++---
 target/xtensa/translate.c     |  4 ++--
 tcg/tcg-op.c                  | 24 ++++++++++++++++++++++--
 26 files changed, 134 insertions(+), 104 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 54aaa61d65..24f7991781 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -52,7 +52,7 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
     }
 
     gen_set_label(tcg_ctx->exitreq_label);
-    tcg_gen_exit_tb((uintptr_t)tb + TB_EXIT_REQUESTED);
+    tcg_gen_exit_tb(tb, TB_EXIT_REQUESTED);
 }
 
 static inline void gen_io_start(void)
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 04eb3e9e17..7513c1eb7c 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -782,10 +782,19 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
 # error "Unhandled number of operands to insn_start"
 #endif
 
-static inline void tcg_gen_exit_tb(uintptr_t val)
-{
-    tcg_gen_op1i(INDEX_op_exit_tb, val);
-}
+/**
+ * tcg_gen_exit_tb() - output exit_tb TCG operation
+ * @tb: The TranslationBlock from which we are exiting
+ * @idx: Direct jump slot index, or exit request
+ *
+ * See tcg/README for more info about this TCG operation.
+ * See also tcg.h and the block comment above TB_EXIT_MASK.
+ *
+ * For a normal exit from the TB, back to the main loop, @tb should
+ * be NULL and @idx should be 0.  Otherwise, @tb should be valid and
+ * @idx should be one of the TB_EXIT_ values.
+ */
+void tcg_gen_exit_tb(TranslationBlock *tb, unsigned idx);
 
 /**
  * tcg_gen_goto_tb() - output goto_tb TCG operation
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 08f8bbfe54..509f4d65d2 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1239,9 +1239,10 @@ static inline unsigned get_mmuidx(TCGMemOpIdx oi)
  * to this default (which just calls the prologue.code emitted by
  * tcg_target_qemu_prologue()).
  */
-#define TB_EXIT_MASK 3
-#define TB_EXIT_IDX0 0
-#define TB_EXIT_IDX1 1
+#define TB_EXIT_MASK      3
+#define TB_EXIT_IDX0      0
+#define TB_EXIT_IDX1      1
+#define TB_EXIT_IDXMAX    1
 #define TB_EXIT_REQUESTED 3
 
 #ifdef HAVE_TCG_QEMU_TB_EXEC
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 15eca71d49..e5d62850c5 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -488,7 +488,7 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
     } else if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->base.tb);
+        tcg_gen_exit_tb(ctx->base.tb, 0);
         return DISAS_NORETURN;
     } else {
         tcg_gen_movi_i64(cpu_pc, dest);
@@ -507,12 +507,12 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
-        tcg_gen_exit_tb((uintptr_t)ctx->base.tb);
+        tcg_gen_exit_tb(ctx->base.tb, 0);
 
         gen_set_label(lab_true);
         tcg_gen_goto_tb(1);
         tcg_gen_movi_i64(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + 1);
+        tcg_gen_exit_tb(ctx->base.tb, 1);
 
         return DISAS_NORETURN;
     } else {
@@ -1273,7 +1273,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
         if (!use_exit_tb(ctx)) {
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(cpu_pc, entry);
-            tcg_gen_exit_tb((uintptr_t)ctx->base.tb);
+            tcg_gen_exit_tb(ctx->base.tb, 0);
             return DISAS_NORETURN;
         } else {
             tcg_gen_movi_i64(cpu_pc, entry);
@@ -3009,7 +3009,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         if (use_goto_tb(ctx, ctx->base.pc_next)) {
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
-            tcg_gen_exit_tb((uintptr_t)ctx->base.tb);
+            tcg_gen_exit_tb(ctx->base.tb, 0);
         }
         /* FALLTHRU */
     case DISAS_PC_STALE:
@@ -3025,7 +3025,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         if (ctx->base.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG, 0);
         } else {
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
         }
         break;
     default:
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b32332ce2c..8d8a4cecb0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -383,7 +383,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
     if (use_goto_tb(s, n, dest)) {
         tcg_gen_goto_tb(n);
         gen_a64_set_pc_im(dest);
-        tcg_gen_exit_tb((intptr_t)tb + n);
+        tcg_gen_exit_tb(tb, n);
         s->base.is_jmp = DISAS_NORETURN;
     } else {
         gen_a64_set_pc_im(dest);
@@ -13883,7 +13883,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_a64_set_pc_im(dc->pc);
             /* fall through */
         case DISAS_EXIT:
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_JUMP:
             tcg_gen_lookup_and_goto_ptr();
@@ -13912,7 +13912,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             /* The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts anyway.
              */
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         }
         }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 46a9725bfd..0ff5edf2ce 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -995,7 +995,7 @@ static inline void gen_bx_excret_final_code(DisasContext *s)
     if (is_singlestepping(s)) {
         gen_singlestep_exception(s);
     } else {
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
     gen_set_label(excret_label);
     /* Yes: this is an exception return.
@@ -4263,7 +4263,7 @@ static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
     if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(n);
         gen_set_pc_im(s, dest);
-        tcg_gen_exit_tb((uintptr_t)s->base.tb + n);
+        tcg_gen_exit_tb(s->base.tb, n);
     } else {
         gen_set_pc_im(s, dest);
         gen_goto_ptr();
@@ -12699,7 +12699,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             /* fall through */
         default:
             /* indicate that the hash table must be used to find the next TB */
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_NORETURN:
             /* nothing more to generate */
@@ -12714,7 +12714,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             /* The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts anyway.
              */
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         }
         case DISAS_WFE:
diff --git a/target/cris/translate.c b/target/cris/translate.c
index d2f05971ab..4ae1c04daf 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -540,10 +540,10 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
     if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(env_pc, dest);
-                tcg_gen_exit_tb((uintptr_t)dc->tb + n);
+        tcg_gen_exit_tb(dc->tb, n);
     } else {
         tcg_gen_movi_tl(env_pc, dest);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
@@ -3276,7 +3276,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         case DISAS_UPDATE:
             /* indicate that the hash table must be used
                    to find the next TB */
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_SWI:
         case DISAS_TB_JUMP:
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5320b217de..ce05d5619d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -779,7 +779,7 @@ static void gen_goto_tb(DisasContext *ctx, int which,
         tcg_gen_goto_tb(which);
         tcg_gen_movi_reg(cpu_iaoq_f, f);
         tcg_gen_movi_reg(cpu_iaoq_b, b);
-        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + which);
+        tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
         copy_iaoq_entry(cpu_iaoq_f, f, cpu_iaoq_b);
         copy_iaoq_entry(cpu_iaoq_b, b, ctx->iaoq_n_var);
@@ -2303,7 +2303,7 @@ static DisasJumpType trans_rfi(DisasContext *ctx, uint32_t insn,
     if (ctx->base.singlestep_enabled) {
         gen_excp_1(EXCP_DEBUG);
     } else {
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 
     /* Exit the TB to recognize new interrupts.  */
@@ -4844,7 +4844,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         if (ctx->base.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG);
         } else if (is_jmp == DISAS_IAQ_N_STALE_EXIT) {
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
         } else {
             tcg_gen_lookup_and_goto_ptr();
         }
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 7c21814676..697a918c11 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2193,7 +2193,7 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num, target_ulong eip)
         /* jump to same page: we can use a direct jump */
         tcg_gen_goto_tb(tb_num);
         gen_jmp_im(eip);
-        tcg_gen_exit_tb((uintptr_t)s->base.tb + tb_num);
+        tcg_gen_exit_tb(s->base.tb, tb_num);
         s->base.is_jmp = DISAS_NORETURN;
     } else {
         /* jump to another page */
@@ -2572,13 +2572,13 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
         gen_helper_debug(cpu_env);
     } else if (recheck_tf) {
         gen_helper_rechecking_single_step(cpu_env);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     } else if (s->tf) {
         gen_helper_single_step(cpu_env);
     } else if (jr) {
         tcg_gen_lookup_and_goto_ptr();
     } else {
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -7402,7 +7402,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_vmrun(cpu_env, tcg_const_i32(s->aflag - 1),
                              tcg_const_i32(s->pc - pc_start));
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             s->base.is_jmp = DISAS_NORETURN;
             break;
 
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index fdd206a860..b32feb7564 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -159,13 +159,13 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
     if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)dc->tb + n);
+        tcg_gen_exit_tb(dc->tb, n);
     } else {
         tcg_gen_movi_tl(cpu_pc, dest);
         if (dc->singlestep_enabled) {
             t_gen_raise_exception(dc, EXCP_DEBUG);
         }
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
@@ -1137,7 +1137,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         case DISAS_UPDATE:
             /* indicate that the hash table must be used
                to find the next TB */
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_TB_JUMP:
             /* nothing more to generate */
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 8959e4d0f0..37d6ffd853 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1491,10 +1491,10 @@ static void gen_jmp_tb(DisasContext *s, int n, uint32_t dest)
     } else if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_i32(QREG_PC, dest);
-        tcg_gen_exit_tb((uintptr_t)s->tb + n);
+        tcg_gen_exit_tb(s->tb, n);
     } else {
         gen_jmp_im(s, dest);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
     s->is_jmp = DISAS_TB_JUMP;
 }
@@ -6147,7 +6147,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         case DISAS_UPDATE:
             update_cc_op(dc);
             /* indicate that the hash table must be used to find the next TB */
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_TB_JUMP:
             /* nothing more to generate */
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b79600cba5..6c64946398 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -143,10 +143,10 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
     if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_i64(cpu_SR[SR_PC], dest);
-        tcg_gen_exit_tb((uintptr_t)dc->tb + n);
+        tcg_gen_exit_tb(dc->tb, n);
     } else {
         tcg_gen_movi_i64(cpu_SR[SR_PC], dest);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
@@ -1766,7 +1766,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             case DISAS_UPDATE:
                 /* indicate that the hash table must be used
                    to find the next TB */
-                tcg_gen_exit_tb(0);
+                tcg_gen_exit_tb(NULL, 0);
                 break;
             case DISAS_TB_JUMP:
                 /* nothing more to generate */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index e88f983ae7..e57d71e485 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4291,7 +4291,7 @@ static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(n);
         gen_save_pc(dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + n);
+        tcg_gen_exit_tb(ctx->base.tb, n);
     } else {
         gen_save_pc(dest);
         if (ctx->base.singlestep_enabled) {
@@ -20344,7 +20344,7 @@ static void mips_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             gen_goto_tb(ctx, 0, ctx->base.pc_next);
             break;
         case DISAS_EXIT:
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_NORETURN:
             break;
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 28b405f0e4..29da02bc05 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -132,13 +132,13 @@ static inline void gen_goto_tb(CPUMoxieState *env, DisasContext *ctx,
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->tb + n);
+        tcg_gen_exit_tb(ctx->tb, n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
         if (ctx->singlestep_enabled) {
             gen_helper_debug(cpu_env);
         }
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
@@ -328,7 +328,7 @@ static int decode_opc(MoxieCPU *cpu, DisasContext *ctx)
                 tcg_temp_free_i32(t1);
 
                 /* Jump... */
-                tcg_gen_exit_tb(0);
+                tcg_gen_exit_tb(NULL, 0);
 
                 ctx->bstate = BS_BRANCH;
             }
@@ -472,14 +472,14 @@ static int decode_opc(MoxieCPU *cpu, DisasContext *ctx)
                 tcg_gen_mov_i32(cpu_pc, REG(fnreg));
                 tcg_temp_free_i32(t1);
                 tcg_temp_free_i32(t2);
-                tcg_gen_exit_tb(0);
+                tcg_gen_exit_tb(NULL, 0);
                 ctx->bstate = BS_BRANCH;
             }
             break;
         case 0x1a: /* jmpa */
             {
                 tcg_gen_movi_i32(cpu_pc, cpu_ldl_code(env, ctx->pc+2));
-                tcg_gen_exit_tb(0);
+                tcg_gen_exit_tb(NULL, 0);
                 ctx->bstate = BS_BRANCH;
                 length = 6;
             }
@@ -584,7 +584,7 @@ static int decode_opc(MoxieCPU *cpu, DisasContext *ctx)
             {
                 int reg = (opcode >> 4) & 0xf;
                 tcg_gen_mov_i32(cpu_pc, REG(reg));
-                tcg_gen_exit_tb(0);
+                tcg_gen_exit_tb(NULL, 0);
                 ctx->bstate = BS_BRANCH;
             }
             break;
@@ -878,7 +878,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             gen_goto_tb(env, &ctx, 0, ctx.pc);
             break;
         case BS_EXCP:
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case BS_BRANCH:
         default:
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index cb8624e8d2..7fa03ed05a 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -171,10 +171,10 @@ static void gen_goto_tb(DisasContext *dc, int n, uint32_t dest)
     if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(dc->cpu_R[R_PC], dest);
-        tcg_gen_exit_tb((uintptr_t)tb + n);
+        tcg_gen_exit_tb(tb, n);
     } else {
         tcg_gen_movi_tl(dc->cpu_R[R_PC], dest);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
@@ -880,14 +880,14 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     case DISAS_NEXT:
         /* Save the current PC back into the CPU register */
         tcg_gen_movi_tl(cpu_R[R_PC], dc->pc);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
         break;
 
     default:
     case DISAS_JUMP:
     case DISAS_UPDATE:
         /* The jump will already have updated the PC register */
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
         break;
 
     case DISAS_TB_JUMP:
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index e7c96ca990..d69f8d0422 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -183,13 +183,13 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
     if (use_goto_tb(dc, dest)) {
         tcg_gen_movi_tl(cpu_pc, dest);
         tcg_gen_goto_tb(n);
-        tcg_gen_exit_tb((uintptr_t)dc->base.tb + n);
+        tcg_gen_exit_tb(dc->base.tb, n);
     } else {
         tcg_gen_movi_tl(cpu_pc, dest);
         if (dc->base.singlestep_enabled) {
             gen_exception(dc, EXCP_DEBUG);
         }
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
@@ -1473,7 +1473,7 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         case DISAS_UPDATE:
             /* indicate that the hash table must be used
                to find the next TB */
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         default:
             g_assert_not_reached();
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e30d99fcbc..b28e8b91d3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3422,7 +3422,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(cpu_nip, dest & ~3);
-        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + n);
+        tcg_gen_exit_tb(ctx->base.tb, n);
     } else {
         tcg_gen_movi_tl(cpu_nip, dest & ~3);
         if (unlikely(ctx->singlestep_enabled)) {
@@ -7410,7 +7410,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             gen_debug_exception(ctx);
         }
         /* Generate the return instruction */
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ee2bbc55b0..0b6be74f2d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -129,13 +129,13 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
         /* chaining is only allowed when the jump is to the same page */
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + n);
+        tcg_gen_exit_tb(ctx->base.tb, n);
     } else {
         tcg_gen_movi_tl(cpu_pc, dest);
         if (ctx->base.singlestep_enabled) {
             gen_exception_debug();
         } else {
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
         }
     }
 }
@@ -548,7 +548,7 @@ static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         if (rd != 0) {
             tcg_gen_movi_tl(cpu_gpr[rd], ctx->pc_succ_insn);
         }
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
 
         if (misaligned) {
             gen_set_label(misaligned);
@@ -1303,12 +1303,12 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         case 0x0: /* ECALL */
             /* always generates U-level ECALL, fixed in do_interrupt handler */
             generate_exception(ctx, RISCV_EXCP_U_ECALL);
-            tcg_gen_exit_tb(0); /* no chaining */
+            tcg_gen_exit_tb(NULL, 0); /* no chaining */
             ctx->base.is_jmp = DISAS_NORETURN;
             break;
         case 0x1: /* EBREAK */
             generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
-            tcg_gen_exit_tb(0); /* no chaining */
+            tcg_gen_exit_tb(NULL, 0); /* no chaining */
             ctx->base.is_jmp = DISAS_NORETURN;
             break;
 #ifndef CONFIG_USER_ONLY
@@ -1318,7 +1318,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         case 0x102: /* SRET */
             if (riscv_has_ext(env, RVS)) {
                 gen_helper_sret(cpu_pc, cpu_env, cpu_pc);
-                tcg_gen_exit_tb(0); /* no chaining */
+                tcg_gen_exit_tb(NULL, 0); /* no chaining */
                 ctx->base.is_jmp = DISAS_NORETURN;
             } else {
                 gen_exception_illegal(ctx);
@@ -1329,7 +1329,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             break;
         case 0x302: /* MRET */
             gen_helper_mret(cpu_pc, cpu_env, cpu_pc);
-            tcg_gen_exit_tb(0); /* no chaining */
+            tcg_gen_exit_tb(NULL, 0); /* no chaining */
             ctx->base.is_jmp = DISAS_NORETURN;
             break;
         case 0x7b2: /* DRET */
@@ -1378,7 +1378,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         gen_set_gpr(rd, dest);
         /* end tb since we may be changing priv modes, to get mmu_index right */
         tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
-        tcg_gen_exit_tb(0); /* no chaining */
+        tcg_gen_exit_tb(NULL, 0); /* no chaining */
         ctx->base.is_jmp = DISAS_NORETURN;
         break;
     }
@@ -1771,7 +1771,7 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
             /* FENCE_I is a no-op in QEMU,
              * however we need to end the translation block */
             tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             ctx->base.is_jmp = DISAS_NORETURN;
         } else {
             /* FENCE is a full memory barrier. */
@@ -1872,7 +1872,7 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         if (ctx->base.singlestep_enabled) {
             gen_exception_debug();
         } else {
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
         }
         break;
     case DISAS_NORETURN:
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 82309faa11..fdfec7feba 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1159,7 +1159,7 @@ static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
         per_breaking_event(s);
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(psw_addr, dest);
-        tcg_gen_exit_tb((uintptr_t)s->base.tb);
+        tcg_gen_exit_tb(s->base.tb, 0);
         return DISAS_GOTO_TB;
     } else {
         tcg_gen_movi_i64(psw_addr, dest);
@@ -1220,14 +1220,14 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
             /* Branch not taken.  */
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(psw_addr, s->pc_tmp);
-            tcg_gen_exit_tb((uintptr_t)s->base.tb + 0);
+            tcg_gen_exit_tb(s->base.tb, 0);
 
             /* Branch taken.  */
             gen_set_label(lab);
             per_breaking_event(s);
             tcg_gen_goto_tb(1);
             tcg_gen_movi_i64(psw_addr, dest);
-            tcg_gen_exit_tb((uintptr_t)s->base.tb + 1);
+            tcg_gen_exit_tb(s->base.tb, 1);
 
             ret = DISAS_GOTO_TB;
         } else {
@@ -1250,7 +1250,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
             update_cc_op(s);
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(psw_addr, s->pc_tmp);
-            tcg_gen_exit_tb((uintptr_t)s->base.tb + 0);
+            tcg_gen_exit_tb(s->base.tb, 0);
 
             gen_set_label(lab);
             if (is_imm) {
@@ -6240,7 +6240,7 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             gen_exception(EXCP_DEBUG);
         } else if (use_exit_tb(dc) ||
                    dc->base.is_jmp == DISAS_PC_STALE_NOCHAIN) {
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
         } else {
             tcg_gen_lookup_and_goto_ptr();
         }
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 58bdfeb4fb..c716b74a0f 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -242,13 +242,13 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + n);
+        tcg_gen_exit_tb(ctx->base.tb, n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
         if (ctx->base.singlestep_enabled) {
             gen_helper_debug(cpu_env);
         } else if (use_exit_tb(ctx)) {
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
         } else {
             tcg_gen_lookup_and_goto_ptr();
         }
@@ -266,7 +266,7 @@ static void gen_jump(DisasContext * ctx)
         if (ctx->base.singlestep_enabled) {
             gen_helper_debug(cpu_env);
         } else if (use_exit_tb(ctx)) {
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
         } else {
             tcg_gen_lookup_and_goto_ptr();
         }
@@ -2343,7 +2343,7 @@ static void sh4_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         if (ctx->base.singlestep_enabled) {
             gen_helper_debug(cpu_env);
         } else {
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
         }
         break;
     case DISAS_NEXT:
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 40b2eaad39..f3d430c1b2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -360,12 +360,12 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num,
         tcg_gen_goto_tb(tb_num);
         tcg_gen_movi_tl(cpu_pc, pc);
         tcg_gen_movi_tl(cpu_npc, npc);
-        tcg_gen_exit_tb((uintptr_t)s->base.tb + tb_num);
+        tcg_gen_exit_tb(s->base.tb, tb_num);
     } else {
         /* jump to another page: currently not optimized */
         tcg_gen_movi_tl(cpu_pc, pc);
         tcg_gen_movi_tl(cpu_npc, npc);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
@@ -4329,7 +4329,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 /* End TB to notice changed ASI.  */
                                 save_state(dc);
                                 gen_op_next_insn();
-                                tcg_gen_exit_tb(0);
+                                tcg_gen_exit_tb(NULL, 0);
                                 dc->base.is_jmp = DISAS_NORETURN;
                                 break;
                             case 0x6: /* V9 wrfprs */
@@ -4338,7 +4338,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 dc->fprs_dirty = 0;
                                 save_state(dc);
                                 gen_op_next_insn();
-                                tcg_gen_exit_tb(0);
+                                tcg_gen_exit_tb(NULL, 0);
                                 dc->base.is_jmp = DISAS_NORETURN;
                                 break;
                             case 0xf: /* V9 sir, nop if user */
@@ -4466,7 +4466,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                             dc->cc_op = CC_OP_FLAGS;
                             save_state(dc);
                             gen_op_next_insn();
-                            tcg_gen_exit_tb(0);
+                            tcg_gen_exit_tb(NULL, 0);
                             dc->base.is_jmp = DISAS_NORETURN;
 #endif
                         }
@@ -4622,7 +4622,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                                         hpstate));
                                 save_state(dc);
                                 gen_op_next_insn();
-                                tcg_gen_exit_tb(0);
+                                tcg_gen_exit_tb(NULL, 0);
                                 dc->base.is_jmp = DISAS_NORETURN;
                                 break;
                             case 1: // htstate
@@ -5793,7 +5793,7 @@ static bool sparc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
         save_state(dc);
     }
     gen_helper_debug(cpu_env);
-    tcg_gen_exit_tb(0);
+    tcg_gen_exit_tb(NULL, 0);
     dc->base.is_jmp = DISAS_NORETURN;
     /* update pc_next so that the current instruction is included in tb->size */
     dc->base.pc_next += 4;
@@ -5832,7 +5832,7 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
                 tcg_gen_movi_tl(cpu_pc, dc->pc);
             }
             save_npc(dc);
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
         }
     }
 }
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index 6c53c5e767..f201150fc7 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2362,7 +2362,7 @@ static void translate_one_bundle(DisasContext *dc, uint64_t bundle)
             tcg_temp_free_i64(next);
         }
         tcg_temp_free_i64(dc->jmp.dest);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
         dc->exit_tb = true;
     } else if (dc->atomic_excp != TILEGX_EXCP_NONE) {
         gen_exception(dc, dc->atomic_excp);
@@ -2419,7 +2419,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             || tcg_op_buf_full()) {
             /* Ending the TB due to TB size or page boundary.  Set PC.  */
             tcg_gen_movi_tl(cpu_pc, dc->pc);
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         }
     }
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index aef0d9cf06..b5ab40d4a2 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3253,13 +3253,13 @@ static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(n);
         gen_save_pc(dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->tb + n);
+        tcg_gen_exit_tb(ctx->tb, n);
     } else {
         gen_save_pc(dest);
         if (ctx->singlestep_enabled) {
             /* raise exception debug */
         }
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
@@ -3327,7 +3327,7 @@ static void gen_fret(DisasContext *ctx)
     tcg_gen_qemu_ld_tl(cpu_gpr_a[11], cpu_gpr_a[10], ctx->mem_idx, MO_LESL);
     tcg_gen_addi_tl(cpu_gpr_a[10], cpu_gpr_a[10], 4);
     tcg_gen_mov_tl(cpu_PC, temp);
-    tcg_gen_exit_tb(0);
+    tcg_gen_exit_tb(NULL, 0);
     ctx->bstate = BS_BRANCH;
 
     tcg_temp_free(temp);
@@ -3431,12 +3431,12 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
 /* SR-format jumps */
     case OPC1_16_SR_JI:
         tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], 0xfffffffe);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
         break;
     case OPC2_32_SYS_RET:
     case OPC2_16_SR_RET:
         gen_helper_ret(cpu_env);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
         break;
 /* B-format */
     case OPC1_32_B_CALLA:
@@ -3939,7 +3939,7 @@ static void decode_sr_system(CPUTriCoreState *env, DisasContext *ctx)
         break;
     case OPC2_16_SR_RFE:
         gen_helper_rfe(cpu_env);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
         ctx->bstate = BS_BRANCH;
         break;
     case OPC2_16_SR_DEBUG:
@@ -6578,7 +6578,7 @@ static void decode_rr_idirect(CPUTriCoreState *env, DisasContext *ctx)
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-    tcg_gen_exit_tb(0);
+    tcg_gen_exit_tb(NULL, 0);
     ctx->bstate = BS_BRANCH;
 }
 
@@ -8398,7 +8398,7 @@ static void decode_sys_interrupts(CPUTriCoreState *env, DisasContext *ctx)
         break;
     case OPC2_32_SYS_RFE:
         gen_helper_rfe(cpu_env);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
         ctx->bstate = BS_BRANCH;
         break;
     case OPC2_32_SYS_RFM:
@@ -8411,7 +8411,7 @@ static void decode_sys_interrupts(CPUTriCoreState *env, DisasContext *ctx)
             tcg_gen_brcondi_tl(TCG_COND_NE, tmp, 1, l1);
             gen_helper_rfm(cpu_env);
             gen_set_label(l1);
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             ctx->bstate = BS_BRANCH;
             tcg_temp_free(tmp);
         } else {
@@ -8845,7 +8845,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
         if (num_insns >= max_insns || tcg_op_buf_full()) {
             gen_save_pc(ctx.next_pc);
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         }
         ctx.pc = ctx.next_pc;
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 3cae111955..002569ff3b 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1106,10 +1106,10 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint32_t dest)
     if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(n);
         gen_set_pc_im(dest);
-        tcg_gen_exit_tb((uintptr_t)s->tb + n);
+        tcg_gen_exit_tb(s->tb, n);
     } else {
         gen_set_pc_im(dest);
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
@@ -2002,7 +2002,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         case DISAS_JUMP:
         case DISAS_UPDATE:
             /* indicate that the hash table must be used to find the next TB */
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_TB_JUMP:
             /* nothing more to generate */
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 720bc592e1..89db23852b 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -377,9 +377,9 @@ static void gen_jump_slot(DisasContext *dc, TCGv dest, int slot)
     } else {
         if (slot >= 0) {
             tcg_gen_goto_tb(slot);
-            tcg_gen_exit_tb((uintptr_t)dc->tb + slot);
+            tcg_gen_exit_tb(dc->tb, slot);
         } else {
-            tcg_gen_exit_tb(0);
+            tcg_gen_exit_tb(NULL, 0);
         }
     }
     dc->is_jmp = DISAS_UPDATE;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6a914654f5..daa416a143 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2574,10 +2574,30 @@ void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg)
 
 /* QEMU specific operations.  */
 
+void tcg_gen_exit_tb(TranslationBlock *tb, unsigned idx)
+{
+    uintptr_t val = (uintptr_t)tb + idx;
+
+    if (tb == NULL) {
+        tcg_debug_assert(idx == 0);
+    } else if (idx <= TB_EXIT_IDXMAX) {
+#ifdef CONFIG_DEBUG_TCG
+        /* This is an exit following a goto_tb.  Verify that we have
+           seen this numbered exit before, via tcg_gen_goto_tb.  */
+        tcg_debug_assert(tcg_ctx->goto_tb_issue_mask & (1 << idx));
+#endif
+    } else {
+        /* This is an exit via the exitreq label.  */
+        tcg_debug_assert(idx == TB_EXIT_REQUESTED);
+    }
+
+    tcg_gen_op1i(INDEX_op_exit_tb, val);
+}
+
 void tcg_gen_goto_tb(unsigned idx)
 {
     /* We only support two chained exits.  */
-    tcg_debug_assert(idx <= 1);
+    tcg_debug_assert(idx <= TB_EXIT_IDXMAX);
 #ifdef CONFIG_DEBUG_TCG
     /* Verify that we havn't seen this numbered exit before.  */
     tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
@@ -2594,7 +2614,7 @@ void tcg_gen_lookup_and_goto_ptr(void)
         tcg_gen_op1i(INDEX_op_goto_ptr, tcgv_ptr_arg(ptr));
         tcg_temp_free_ptr(ptr);
     } else {
-        tcg_gen_exit_tb(0);
+        tcg_gen_exit_tb(NULL, 0);
     }
 }
 
-- 
2.17.0
