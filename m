Received: from eggs.gnu.org ([2001:4830:134:3::10]:60459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qV-0001DJ-Uh
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qJ-0005qa-Pm
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37951)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qJ-0005or-BT
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:08:58 -0400
Message-Id: <1500520169-23367-13-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 12/43] tcg: convert tb->cflags reads to
 tb_cflags(tb)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Convert all existing readers of tb->cflags to tb_cflags, so that we
use atomic_read and therefore avoid undefined behaviour in C11.

Note that the remaining setters/getters of the field are protected
by tb_lock, and therefore do not need conversion.

Luckily all readers access the field via 'tb->cflags' (so no foo.cflags,
bar->cflags in the code base), which makes the conversion easily
scriptable:
FILES=$(git grep 'tb->cflags' target include/exec/gen-icount.h | \
	cut -f 1 -d':' | sort | uniq)
perl -pi -e 's/([^>])tb->cflags/$1tb_cflags(tb)/g' $FILES
perl -pi -e 's/([a-z]*)->tb->cflags/tb_cflags($1->tb)/g' $FILES

Then manually fixed the few errors that checkpatch reported.

Compile-tested for all targets.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/gen-icount.h     |  8 +++----
 target/alpha/translate.c      | 12 +++++-----
 target/arm/translate-a64.c    | 13 +++++-----
 target/arm/translate.c        | 10 ++++----
 target/cris/translate.c       |  6 ++---
 target/hppa/translate.c       |  8 +++----
 target/i386/translate.c       | 55 ++++++++++++++++++++++---------------------
 target/lm32/translate.c       | 14 +++++------
 target/m68k/translate.c       |  6 ++---
 target/microblaze/translate.c |  6 ++---
 target/mips/translate.c       | 26 ++++++++++----------
 target/moxie/translate.c      |  2 +-
 target/nios2/translate.c      |  6 ++---
 target/openrisc/translate.c   |  6 ++---
 target/ppc/translate.c        |  6 ++---
 target/ppc/translate_init.c   | 32 ++++++++++++-------------
 target/s390x/translate.c      |  8 +++----
 target/sh4/translate.c        |  6 ++---
 target/sparc/translate.c      |  6 ++---
 target/tilegx/translate.c     |  2 +-
 target/tricore/translate.c    |  2 +-
 target/unicore32/translate.c  |  6 ++---
 target/xtensa/translate.c     | 28 +++++++++++-----------
 23 files changed, 138 insertions(+), 136 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 9b3cb14..48b566c 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -13,7 +13,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     TCGv_i32 count, imm;
 
     exitreq_label = gen_new_label();
-    if (tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(tb) & CF_USE_ICOUNT) {
         count = tcg_temp_local_new_i32();
     } else {
         count = tcg_temp_new_i32();
@@ -22,7 +22,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     tcg_gen_ld_i32(count, tcg_ctx.tcg_env,
                    -ENV_OFFSET + offsetof(CPUState, icount_decr.u32));
 
-    if (tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(tb) & CF_USE_ICOUNT) {
         imm = tcg_temp_new_i32();
         /* We emit a movi with a dummy immediate argument. Keep the insn index
          * of the movi so that we later (when we know the actual insn count)
@@ -36,7 +36,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
 
     tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
 
-    if (tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(tb) & CF_USE_ICOUNT) {
         tcg_gen_st16_i32(count, tcg_ctx.tcg_env,
                          -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.low));
     }
@@ -46,7 +46,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
 
 static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 {
-    if (tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(tb) & CF_USE_ICOUNT) {
         /* Update the num_insn immediate parameter now that we know
          * the actual insn count.  */
         tcg_set_insn_param(icount_start_insn_idx, 1, num_insns);
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 9e98312..f97a8e5 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -484,9 +484,9 @@ static bool in_superpage(DisasContext *ctx, int64_t addr)
 
 static bool use_exit_tb(DisasContext *ctx)
 {
-    return ((ctx->tb->cflags & CF_LAST_IO)
+    return (tb_cflags(ctx->tb) & CF_LAST_IO)
             || ctx->singlestep_enabled
-            || singlestep);
+            || singlestep;
 }
 
 static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
@@ -2430,7 +2430,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
         case 0xC000:
             /* RPCC */
             va = dest_gpr(ctx, ra);
-            if (ctx->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
                 gen_io_start();
                 gen_helper_load_pcc(va, cpu_env);
                 gen_io_end();
@@ -2998,7 +2998,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
     TCGV_UNUSED_I64(ctx.lit);
 
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -3028,7 +3028,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
             ctx.pc += 4;
             break;
         }
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
         insn = cpu_ldl_code(env, ctx.pc);
@@ -3053,7 +3053,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
         }
     } while (ret == NO_EXIT);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 818d7eb..685f1b0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -348,7 +348,8 @@ static inline bool use_goto_tb(DisasContext *s, int n, uint64_t dest)
     /* No direct tb linking with singlestep (either QEMU's or the ARM
      * debug architecture kind) or deterministic io
      */
-    if (s->singlestep_enabled || s->ss_active || (s->tb->cflags & CF_LAST_IO)) {
+    if (s->singlestep_enabled || s->ss_active ||
+        (tb_cflags(s->tb) & CF_LAST_IO)) {
         return false;
     }
 
@@ -1559,7 +1560,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         break;
     }
 
-    if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+    if ((tb_cflags(s->tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         gen_io_start();
     }
 
@@ -1590,7 +1591,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         }
     }
 
-    if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+    if ((tb_cflags(s->tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
         gen_io_end();
         s->is_jmp = DISAS_UPDATE;
@@ -11258,7 +11259,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -11299,7 +11300,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
             }
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -11340,7 +11341,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
              dc->pc < next_page_start &&
              num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 964b627..ccfb428 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7655,7 +7655,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             break;
         }
 
-        if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+        if ((tb_cflags(s->tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             gen_io_start();
         }
 
@@ -7746,7 +7746,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             }
         }
 
-        if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+        if ((tb_cflags(s->tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             /* I/O operations must end the TB here (whether read or write) */
             gen_io_end();
             gen_lookup_tb(s);
@@ -11876,7 +11876,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
     cpu_M0 = tcg_temp_new_i64();
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -11971,7 +11971,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
             }
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -12041,7 +12041,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
              !end_of_page &&
              num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         if (dc->condjmp) {
             /* FIXME:  This can theoretically happen with self-modifying
                code.  */
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0ee05ca..1703d91 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3137,7 +3137,7 @@ void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *tb)
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -3167,7 +3167,7 @@ void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *tb)
         /* Pretty disas.  */
         LOG_DIS("%8.8x:\t", dc->pc);
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
         dc->clear_x = 1;
@@ -3240,7 +3240,7 @@ void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *tb)
 
     npc = dc->pc;
 
-        if (tb->cflags & CF_LAST_IO)
+        if (tb_cflags(tb) & CF_LAST_IO)
             gen_io_end();
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp == DISAS_NEXT
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 91053e2..1effe82 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -487,7 +487,7 @@ static ExitStatus gen_illegal(DisasContext *ctx)
 static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
     /* Suppress goto_tb in the case of single-steping and IO.  */
-    if ((ctx->tb->cflags & CF_LAST_IO) || ctx->singlestep_enabled) {
+    if ((tb_cflags(ctx->tb) & CF_LAST_IO) || ctx->singlestep_enabled) {
         return false;
     }
     return true;
@@ -3762,7 +3762,7 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
     /* Compute the maximum number of insns to execute, as bounded by
        (1) icount, (2) single-stepping, (3) branch delay slots, or
        (4) the number of insns remaining on the current page.  */
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -3792,7 +3792,7 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
             ret = gen_excp(&ctx, EXCP_DEBUG);
             break;
         }
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -3868,7 +3868,7 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
         }
     } while (ret == NO_EXIT);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 291c577..f046ffa 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1119,7 +1119,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
 
 static inline void gen_ins(DisasContext *s, TCGMemOp ot)
 {
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_string_movl_A0_EDI(s);
@@ -1134,14 +1134,14 @@ static inline void gen_ins(DisasContext *s, TCGMemOp ot)
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_EDI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
 
 static inline void gen_outs(DisasContext *s, TCGMemOp ot)
 {
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_string_movl_A0_ESI(s);
@@ -1154,7 +1154,7 @@ static inline void gen_outs(DisasContext *s, TCGMemOp ot)
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_ESI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
@@ -6299,7 +6299,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_repz_ins(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_ins(s, ot);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
                 gen_jmp(s, s->pc - s->cs_base);
             }
         }
@@ -6314,7 +6314,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_repz_outs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_outs(s, ot);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
                 gen_jmp(s, s->pc - s->cs_base);
             }
         }
@@ -6330,14 +6330,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         tcg_gen_movi_tl(cpu_T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_movi_i32(cpu_tmp2_i32, val);
         gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6351,14 +6351,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                      svm_is_rep(prefixes));
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
 
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_movi_i32(cpu_tmp2_i32, val);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
         gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6369,14 +6369,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         tcg_gen_ext16u_tl(cpu_T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6389,14 +6389,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                      svm_is_rep(prefixes));
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
 
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
         gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -7104,11 +7104,11 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
     case 0x131: /* rdtsc */
         gen_update_cc_op(s);
         gen_jmp_im(pc_start - s->cs_base);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         gen_helper_rdtsc(cpu_env);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -7563,11 +7563,11 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             }
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
                 gen_io_start();
             }
             gen_helper_rdtscp(cpu_env);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
                 gen_io_end();
                 gen_jmp(s, s->pc - s->cs_base);
             }
@@ -7932,24 +7932,24 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                 gen_update_cc_op(s);
                 gen_jmp_im(pc_start - s->cs_base);
                 if (b & 2) {
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
                         gen_io_start();
                     }
                     gen_op_mov_v_reg(ot, cpu_T0, rm);
                     gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
                                          cpu_T0);
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
                         gen_io_end();
                     }
                     gen_jmp_im(s->pc - s->cs_base);
                     gen_eob(s);
                 } else {
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
                         gen_io_start();
                     }
                     gen_helper_read_crN(cpu_T0, cpu_env, tcg_const_i32(reg));
                     gen_op_mov_reg_v(ot, rm, cpu_T0);
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (tb_cflags(s->tb) & CF_USE_ICOUNT) {
                         gen_io_end();
                     }
                 }
@@ -8431,7 +8431,7 @@ void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
        record/replay modes and there will always be an
        additional step for ecx=0 when icount is enabled.
      */
-    dc->repz_opt = !dc->jmp_opt && !(tb->cflags & CF_USE_ICOUNT);
+    dc->repz_opt = !dc->jmp_opt && !(tb_cflags(tb) & CF_USE_ICOUNT);
 #if 0
     /* check addseg logic */
     if (!dc->addseg && (dc->vm86 || !dc->pe || !dc->code32))
@@ -8454,7 +8454,7 @@ void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
     dc->is_jmp = DISAS_NEXT;
     pc_ptr = pc_start;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -8479,7 +8479,7 @@ void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
             pc_ptr += 1;
             goto done_generating;
         }
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -8504,7 +8504,7 @@ void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
            If current instruction already crossed the bound - it's ok,
            because an exception hasn't stopped this code.
          */
-        if ((tb->cflags & CF_USE_ICOUNT)
+        if ((tb_cflags(tb) & CF_USE_ICOUNT)
             && ((pc_ptr & TARGET_PAGE_MASK)
                 != ((pc_ptr + TARGET_MAX_INSN_SIZE - 1) & TARGET_PAGE_MASK)
                 || (pc_ptr & ~TARGET_PAGE_MASK) == 0)) {
@@ -8526,8 +8526,9 @@ void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
             break;
         }
     }
-    if (tb->cflags & CF_LAST_IO)
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
+    }
 done_generating:
     gen_tb_end(tb, num_insns);
 
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 692882f..3597c61 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -874,24 +874,24 @@ static void dec_wcsr(DisasContext *dc)
         break;
     case CSR_IM:
         /* mark as an io operation because it could cause an interrupt */
-        if (dc->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
         gen_helper_wcsr_im(cpu_env, cpu_R[dc->r1]);
         tcg_gen_movi_tl(cpu_pc, dc->pc + 4);
-        if (dc->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
             gen_io_end();
         }
         dc->is_jmp = DISAS_UPDATE;
         break;
     case CSR_IP:
         /* mark as an io operation because it could cause an interrupt */
-        if (dc->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
         gen_helper_wcsr_ip(cpu_env, cpu_R[dc->r1]);
         tcg_gen_movi_tl(cpu_pc, dc->pc + 4);
-        if (dc->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
             gen_io_end();
         }
         dc->is_jmp = DISAS_UPDATE;
@@ -1072,7 +1072,7 @@ void gen_intermediate_code(CPULM32State *env, struct TranslationBlock *tb)
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -1100,7 +1100,7 @@ void gen_intermediate_code(CPULM32State *env, struct TranslationBlock *tb)
         /* Pretty disas.  */
         LOG_DIS("%8.8x:\t", dc->pc);
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -1113,7 +1113,7 @@ void gen_intermediate_code(CPULM32State *env, struct TranslationBlock *tb)
          && (dc->pc < next_page_start)
          && num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 3a519b7..188520b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5544,7 +5544,7 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
     dc->done_mac = 0;
     dc->writeback_mask = 0;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -5570,7 +5570,7 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
             break;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -5582,7 +5582,7 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
              (pc_offset) < (TARGET_PAGE_SIZE - 32) &&
              num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO)
+    if (tb_cflags(tb) & CF_LAST_IO)
         gen_io_end();
     if (unlikely(cs->singlestep_enabled)) {
         /* Make sure the pc is updated, and raise a debug exception.  */
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index cb65d1e..4cd184e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1660,7 +1660,7 @@ void gen_intermediate_code(CPUMBState *env, struct TranslationBlock *tb)
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -1695,7 +1695,7 @@ void gen_intermediate_code(CPUMBState *env, struct TranslationBlock *tb)
         /* Pretty disas.  */
         LOG_DIS("%8.8x:\t", dc->pc);
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -1757,7 +1757,7 @@ void gen_intermediate_code(CPUMBState *env, struct TranslationBlock *tb)
             npc = dc->jmp_pc;
     }
 
-    if (tb->cflags & CF_LAST_IO)
+    if (tb_cflags(tb) & CF_LAST_IO)
         gen_io_end();
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp == DISAS_NEXT
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 28c9fbd..f839a2b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5238,11 +5238,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             /* Mark as an IO operation because we read the time.  */
-            if (ctx->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
                 gen_io_start();
 	    }
             gen_helper_mfc0_count(arg, cpu_env);
-            if (ctx->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
                 gen_io_end();
             }
             /* Break the TB to be able to take timer interrupts immediately
@@ -5642,7 +5642,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     if (sel != 0)
         check_insn(ctx, ISA_MIPS32);
 
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
 
@@ -6291,7 +6291,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     trace_mips_translate_c0("mtc0", rn, reg, sel);
 
     /* For simplicity assume that all writes can cause interrupts.  */
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         ctx->bstate = BS_STOP;
     }
@@ -6551,11 +6551,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             /* Mark as an IO operation because we read the time.  */
-            if (ctx->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
                 gen_io_start();
             }
             gen_helper_mfc0_count(arg, cpu_env);
-            if (ctx->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
                 gen_io_end();
             }
             /* Break the TB to be able to take timer interrupts immediately
@@ -6942,7 +6942,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     if (sel != 0)
         check_insn(ctx, ISA_MIPS64);
 
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
 
@@ -7259,11 +7259,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             save_cpu_state(ctx, 1);
             /* Mark as an IO operation because we may trigger a software
                interrupt.  */
-            if (ctx->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
                 gen_io_start();
             }
             gen_helper_mtc0_cause(cpu_env, arg);
-            if (ctx->tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
                 gen_io_end();
             }
             /* Stop translation as we may have triggered an intetrupt */
@@ -7589,7 +7589,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     trace_mips_translate_c0("dmtc0", rn, reg, sel);
 
     /* For simplicity assume that all writes can cause interrupts.  */
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         ctx->bstate = BS_STOP;
     }
@@ -19937,7 +19937,7 @@ void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *tb)
     ctx.default_tcg_memop_mask = (ctx.insn_flags & ISA_MIPS32R6) ?
                                  MO_UNALN : MO_ALIGN;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -19963,7 +19963,7 @@ void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *tb)
             goto done_generating;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -20024,7 +20024,7 @@ void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *tb)
         if (singlestep)
             break;
     }
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
     if (cs->singlestep_enabled && ctx.bstate != BS_BRANCH) {
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 0660b44..f61aa2d 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -838,7 +838,7 @@ void gen_intermediate_code(CPUMoxieState *env, struct TranslationBlock *tb)
     ctx.singlestep_enabled = 0;
     ctx.bstate = BS_NONE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 2f3c2e5..e74e070 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -822,7 +822,7 @@ void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
         max_insns = 1;
     } else {
         int page_insns = (TARGET_PAGE_SIZE - (tb->pc & TARGET_PAGE_MASK)) / 4;
-        max_insns = tb->cflags & CF_COUNT_MASK;
+        max_insns = tb_cflags(tb) & CF_COUNT_MASK;
         if (max_insns == 0) {
             max_insns = CF_COUNT_MASK;
         }
@@ -849,7 +849,7 @@ void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
             break;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -866,7 +866,7 @@ void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
              !tcg_op_buf_full() &&
              num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index e49518e..347790c 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1540,7 +1540,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
 
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -1583,7 +1583,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
             break;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
         disas_openrisc_insn(dc, cpu);
@@ -1606,7 +1606,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
              && (dc->pc < next_page_start)
              && num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c0cd64d..e146aa3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7275,7 +7275,7 @@ void gen_intermediate_code(CPUPPCState *env, struct TranslationBlock *tb)
     msr_se = 1;
 #endif
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -7303,7 +7303,7 @@ void gen_intermediate_code(CPUPPCState *env, struct TranslationBlock *tb)
         LOG_DISAS("----------------\n");
         LOG_DISAS("nip=" TARGET_FMT_lx " super=%d ir=%d\n",
                   ctx.nip, ctx.mem_idx, (int)msr_ir);
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO))
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO))
             gen_io_start();
         if (unlikely(need_byteswap(&ctx))) {
             ctx.opcode = bswap32(cpu_ldl_code(env, ctx.nip));
@@ -7384,7 +7384,7 @@ void gen_intermediate_code(CPUPPCState *env, struct TranslationBlock *tb)
             exit(1);
         }
     }
-    if (tb->cflags & CF_LAST_IO)
+    if (tb_cflags(tb) & CF_LAST_IO)
         gen_io_end();
     if (ctx.exception == POWERPC_EXCP_NONE) {
         gen_goto_tb(&ctx, 0, ctx.nip);
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index b325c2c..2e902fc 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -175,11 +175,11 @@ static void spr_write_ureg(DisasContext *ctx, int sprn, int gprn)
 #if !defined(CONFIG_USER_ONLY)
 static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 {
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_load_decr(cpu_gpr[gprn], cpu_env);
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -187,11 +187,11 @@ static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 
 static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
 {
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_store_decr(cpu_env, cpu_gpr[gprn]);
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -202,11 +202,11 @@ static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
 /* Time base */
 static void spr_read_tbl(DisasContext *ctx, int gprn, int sprn)
 {
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_load_tbl(cpu_gpr[gprn], cpu_env);
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -214,11 +214,11 @@ static void spr_read_tbl(DisasContext *ctx, int gprn, int sprn)
 
 static void spr_read_tbu(DisasContext *ctx, int gprn, int sprn)
 {
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_load_tbu(cpu_gpr[gprn], cpu_env);
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -239,11 +239,11 @@ static void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
 #if !defined(CONFIG_USER_ONLY)
 static void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 {
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_store_tbl(cpu_env, cpu_gpr[gprn]);
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -251,11 +251,11 @@ static void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 
 static void spr_write_tbu(DisasContext *ctx, int sprn, int gprn)
 {
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_store_tbu(cpu_env, cpu_gpr[gprn]);
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -283,11 +283,11 @@ static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
 /* HDECR */
 static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 {
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_load_hdecr(cpu_gpr[gprn], cpu_env);
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
@@ -295,11 +295,11 @@ static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 
 static void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
 {
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_store_hdecr(cpu_env, cpu_gpr[gprn]);
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_stop_exception(ctx);
     }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index be1a04d..0d5d623 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -612,7 +612,7 @@ static void gen_op_calc_cc(DisasContext *s)
 static bool use_exit_tb(DisasContext *s)
 {
     return (s->singlestep_enabled ||
-            (s->tb->cflags & CF_LAST_IO) ||
+            (tb_cflags(s->tb) & CF_LAST_IO) ||
             (s->tb->flags & FLAG_MASK_PER));
 }
 
@@ -5880,7 +5880,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
 
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -5905,7 +5905,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
             break;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -5924,7 +5924,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
         }
     } while (status == NO_EXIT);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 2a206af..9fcaefd 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2256,7 +2256,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
                  (ctx.tbflags & (1 << SR_RB))) * 0x10;
     ctx.fbank = ctx.tbflags & FPSCR_FR ? 0x10 : 0;
 
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -2300,7 +2300,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
             break;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -2308,7 +2308,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
 	decode_opc(&ctx);
 	ctx.pc += 2;
     }
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index aa6734d..39d8494 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5781,7 +5781,7 @@ void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
 #endif
 
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -5810,7 +5810,7 @@ void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
             goto exit_gen_loop;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -5837,7 +5837,7 @@ void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
              num_insns < max_insns);
 
  exit_gen_loop:
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
     if (!dc->is_br) {
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index ff2ef7b..33be670 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2379,7 +2379,7 @@ void gen_intermediate_code(CPUTLGState *env, struct TranslationBlock *tb)
     uint64_t pc_start = tb->pc;
     uint64_t next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     int num_insns = 0;
-    int max_insns = tb->cflags & CF_COUNT_MASK;
+    int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
 
     dc->pc = pc_start;
     dc->mmuidx = 0;
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ddd2dd0..3d8448c 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8791,7 +8791,7 @@ void gen_intermediate_code(CPUTriCoreState *env, struct TranslationBlock *tb)
     int num_insns, max_insns;
 
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 666a201..4cede72 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1896,7 +1896,7 @@ void gen_intermediate_code(CPUUniCore32State *env, TranslationBlock *tb)
     cpu_F1d = tcg_temp_new_i64();
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -1929,7 +1929,7 @@ void gen_intermediate_code(CPUUniCore32State *env, TranslationBlock *tb)
             goto done_generating;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -1954,7 +1954,7 @@ void gen_intermediate_code(CPUUniCore32State *env, TranslationBlock *tb)
              dc->pc < next_page_start &&
              num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         if (dc->condjmp) {
             /* FIXME:  This can theoretically happen with self-modifying
                code.  */
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 2630024..3ded61b 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -513,12 +513,12 @@ static bool gen_check_sr(DisasContext *dc, uint32_t sr, unsigned access)
 
 static bool gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
-    if (dc->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_update_ccount(cpu_env);
     tcg_gen_mov_i32(d, cpu_SR[sr]);
-    if (dc->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         return true;
     }
@@ -698,11 +698,11 @@ static bool gen_wsr_cpenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 
 static void gen_check_interrupts(DisasContext *dc)
 {
-    if (dc->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_check_interrupts(cpu_env);
-    if (dc->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
@@ -756,11 +756,11 @@ static bool gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 
 static bool gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
-    if (dc->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_wsr_ccount(cpu_env, v);
-    if (dc->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_jumpi_check_loop_end(dc, 0);
         return true;
@@ -797,11 +797,11 @@ static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 
         tcg_gen_mov_i32(cpu_SR[sr], v);
         tcg_gen_andi_i32(cpu_SR[INTSET], cpu_SR[INTSET], ~int_bit);
-        if (dc->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
         gen_helper_update_ccompare(cpu_env, tmp);
-        if (dc->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jumpi_check_loop_end(dc, 0);
             ret = true;
@@ -896,11 +896,11 @@ static void gen_waiti(DisasContext *dc, uint32_t imm4)
     TCGv_i32 pc = tcg_const_i32(dc->next_pc);
     TCGv_i32 intlevel = tcg_const_i32(imm4);
 
-    if (dc->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_waiti(cpu_env, pc, intlevel);
-    if (dc->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
     tcg_temp_free(pc);
@@ -3123,7 +3123,7 @@ void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
     CPUState *cs = CPU(cpu);
     DisasContext dc;
     int insn_count = 0;
-    int max_insns = tb->cflags & CF_COUNT_MASK;
+    int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     uint32_t pc_start = tb->pc;
     uint32_t next_page_start =
         (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
@@ -3159,7 +3159,7 @@ void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
 
     gen_tb_start(tb);
 
-    if ((tb->cflags & CF_USE_ICOUNT) &&
+    if ((tb_cflags(tb) & CF_USE_ICOUNT) &&
         (tb->flags & XTENSA_TBFLAG_YIELD)) {
         tcg_gen_insn_start(dc.pc);
         ++insn_count;
@@ -3191,7 +3191,7 @@ void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
             break;
         }
 
-        if (insn_count == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (insn_count == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -3232,7 +3232,7 @@ done:
         tcg_temp_free(dc.next_icount);
     }
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
-- 
2.7.4
