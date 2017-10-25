Received: from eggs.gnu.org ([2001:4830:134:3::10]:45772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6i-0008TK-Qd
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6e-0008MX-C2
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:16 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:48719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6d-0008Ly-SO
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:12 -0400
Received: by mail-wm0-x244.google.com with SMTP id p75so610830wmg.3
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:09 +0200
Message-Id: <20171025093535.10175-26-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 25/51] tcg: convert tb->cflags reads to
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Convert all existing readers of tb->cflags to tb_cflags, so that we
use atomic_read and therefore avoid undefined behaviour in C11.

Note that the remaining setters/getters of the field are protected
by tb_lock, and therefore do not need conversion.

Luckily all readers access the field via 'tb->cflags' (so no foo.cflags,
bar->cflags in the code base), which makes the conversion easily
scriptable:

FILES=$(git grep 'tb->cflags' target include/exec/gen-icount.h \
	 accel/tcg/translator.c | cut -f1 -d':' | sort | uniq)

perl -pi -e 's/([^.>])tb->cflags/$1tb_cflags(tb)/g' $FILES
perl -pi -e 's/([a-z->.]*)(->|\.)tb->cflags/tb_cflags($1$2tb)/g' $FILES

Then manually fixed the few errors that checkpatch reported.

Compile-tested for all targets.

Suggested-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gen-icount.h     |  8 ++++----
 accel/tcg/translator.c        |  4 ++--
 target/alpha/translate.c      |  4 ++--
 target/arm/translate-a64.c    |  7 ++++---
 target/arm/translate.c        |  6 +++---
 target/cris/translate.c       |  6 +++---
 target/hppa/translate.c       |  2 +-
 target/i386/translate.c       | 48 +++++++++++++++++++++----------------------
 target/lm32/translate.c       | 14 ++++++-------
 target/m68k/translate.c       |  6 +++---
 target/microblaze/translate.c |  6 +++---
 target/mips/translate.c       | 26 +++++++++++------------
 target/moxie/translate.c      |  2 +-
 target/nios2/translate.c      |  6 +++---
 target/openrisc/translate.c   |  6 +++---
 target/ppc/translate.c        |  6 +++---
 target/ppc/translate_init.c   | 32 ++++++++++++++---------------
 target/s390x/translate.c      |  8 ++++----
 target/sh4/translate.c        |  6 +++---
 target/sparc/translate.c      |  6 +++---
 target/tilegx/translate.c     |  2 +-
 target/tricore/translate.c    |  2 +-
 target/unicore32/translate.c  |  6 +++---
 target/xtensa/translate.c     | 28 ++++++++++++-------------
 24 files changed, 124 insertions(+), 123 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 9b3cb14dfa..48b566c1c9 100644
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
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index afa3af478a..23c6602cd9 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -45,7 +45,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     db->singlestep_enabled = cpu->singlestep_enabled;
 
     /* Instruction counting */
-    max_insns = db->tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(db->tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -95,7 +95,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
            update db->pc_next and db->is_jmp to indicate what should be
            done next -- either exiting this loop or locate the start of
            the next instruction.  */
-        if (db->num_insns == max_insns && (db->tb->cflags & CF_LAST_IO)) {
+        if (db->num_insns == max_insns && (tb_cflags(db->tb) & CF_LAST_IO)) {
             /* Accept I/O on the last instruction.  */
             gen_io_start();
             ops->translate_insn(db, cpu);
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 3c8d1dc333..53b8c036e2 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -455,7 +455,7 @@ static bool in_superpage(DisasContext *ctx, int64_t addr)
 
 static bool use_exit_tb(DisasContext *ctx)
 {
-    return ((ctx->base.tb->cflags & CF_LAST_IO)
+    return ((tb_cflags(ctx->base.tb) & CF_LAST_IO)
             || ctx->base.singlestep_enabled
             || singlestep);
 }
@@ -2399,7 +2399,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         case 0xC000:
             /* RPCC */
             va = dest_gpr(ctx, ra);
-            if (ctx->base.tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
                 gen_helper_load_pcc(va, cpu_env);
                 gen_io_end();
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a39b9d3633..e9bee8c196 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -348,7 +348,8 @@ static inline bool use_goto_tb(DisasContext *s, int n, uint64_t dest)
     /* No direct tb linking with singlestep (either QEMU's or the ARM
      * debug architecture kind) or deterministic io
      */
-    if (s->base.singlestep_enabled || s->ss_active || (s->base.tb->cflags & CF_LAST_IO)) {
+    if (s->base.singlestep_enabled || s->ss_active ||
+        (tb_cflags(s->base.tb) & CF_LAST_IO)) {
         return false;
     }
 
@@ -1561,7 +1562,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         break;
     }
 
-    if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+    if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         gen_io_start();
     }
 
@@ -1592,7 +1593,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         }
     }
 
-    if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+    if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
         gen_io_end();
         s->base.is_jmp = DISAS_UPDATE;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4da1a4cbc6..dfa547b1db 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7704,7 +7704,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             break;
         }
 
-        if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+        if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             gen_io_start();
         }
 
@@ -7795,7 +7795,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             }
         }
 
-        if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+        if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             /* I/O operations must end the TB here (whether read or write) */
             gen_io_end();
             gen_lookup_tb(s);
@@ -12253,7 +12253,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    if (dc->base.tb->cflags & CF_LAST_IO && dc->condjmp) {
+    if (tb_cflags(dc->base.tb) & CF_LAST_IO && dc->condjmp) {
         /* FIXME: This can theoretically happen with self-modifying code. */
         cpu_abort(cpu, "IO on conditional branch instruction");
     }
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 55a9202777..6774acc7af 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3141,7 +3141,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -3171,7 +3171,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         /* Pretty disas.  */
         LOG_DIS("%8.8x:\t", dc->pc);
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
         dc->clear_x = 1;
@@ -3244,7 +3244,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     npc = dc->pc;
 
-        if (tb->cflags & CF_LAST_IO)
+        if (tb_cflags(tb) & CF_LAST_IO)
             gen_io_end();
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp == DISAS_NEXT
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 334ee74e4c..460b4d3154 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -469,7 +469,7 @@ static DisasJumpType gen_illegal(DisasContext *ctx)
 static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
     /* Suppress goto_tb in the case of single-steping and IO.  */
-    if ((ctx->base.tb->cflags & CF_LAST_IO) || ctx->base.singlestep_enabled) {
+    if ((tb_cflags(ctx->base.tb) & CF_LAST_IO) || ctx->base.singlestep_enabled) {
         return false;
     }
     return true;
diff --git a/target/i386/translate.c b/target/i386/translate.c
index da13fe4d11..2e2e0dbddc 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1118,7 +1118,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
 
 static inline void gen_ins(DisasContext *s, TCGMemOp ot)
 {
-    if (s->base.tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_string_movl_A0_EDI(s);
@@ -1133,14 +1133,14 @@ static inline void gen_ins(DisasContext *s, TCGMemOp ot)
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_EDI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
-    if (s->base.tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
 
 static inline void gen_outs(DisasContext *s, TCGMemOp ot)
 {
-    if (s->base.tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_string_movl_A0_ESI(s);
@@ -1153,7 +1153,7 @@ static inline void gen_outs(DisasContext *s, TCGMemOp ot)
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_ESI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
-    if (s->base.tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
@@ -6340,7 +6340,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_repz_ins(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_ins(s, ot);
-            if (s->base.tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                 gen_jmp(s, s->pc - s->cs_base);
             }
         }
@@ -6355,7 +6355,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_repz_outs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_outs(s, ot);
-            if (s->base.tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                 gen_jmp(s, s->pc - s->cs_base);
             }
         }
@@ -6371,14 +6371,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         tcg_gen_movi_tl(cpu_T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
-        if (s->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_movi_i32(cpu_tmp2_i32, val);
         gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6392,14 +6392,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                      svm_is_rep(prefixes));
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
 
-        if (s->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_movi_i32(cpu_tmp2_i32, val);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
         gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6410,14 +6410,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         tcg_gen_ext16u_tl(cpu_T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
-        if (s->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6430,14 +6430,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                      svm_is_rep(prefixes));
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
 
-        if (s->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
         gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -7143,11 +7143,11 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x131: /* rdtsc */
         gen_update_cc_op(s);
         gen_jmp_im(pc_start - s->cs_base);
-        if (s->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         gen_helper_rdtsc(cpu_env);
-        if (s->base.tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -7602,11 +7602,11 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
-            if (s->base.tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
             }
             gen_helper_rdtscp(cpu_env);
-            if (s->base.tb->cflags & CF_USE_ICOUNT) {
+            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                 gen_io_end();
                 gen_jmp(s, s->pc - s->cs_base);
             }
@@ -7971,24 +7971,24 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_update_cc_op(s);
                 gen_jmp_im(pc_start - s->cs_base);
                 if (b & 2) {
-                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
+                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                         gen_io_start();
                     }
                     gen_op_mov_v_reg(ot, cpu_T0, rm);
                     gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
                                          cpu_T0);
-                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
+                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                         gen_io_end();
                     }
                     gen_jmp_im(s->pc - s->cs_base);
                     gen_eob(s);
                 } else {
-                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
+                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                         gen_io_start();
                     }
                     gen_helper_read_crN(cpu_T0, cpu_env, tcg_const_i32(reg));
                     gen_op_mov_reg_v(ot, rm, cpu_T0);
-                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
+                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                         gen_io_end();
                     }
                 }
@@ -8452,7 +8452,7 @@ static int i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu,
        record/replay modes and there will always be an
        additional step for ecx=0 when icount is enabled.
      */
-    dc->repz_opt = !dc->jmp_opt && !(dc->base.tb->cflags & CF_USE_ICOUNT);
+    dc->repz_opt = !dc->jmp_opt && !(tb_cflags(dc->base.tb) & CF_USE_ICOUNT);
 #if 0
     /* check addseg logic */
     if (!dc->addseg && (dc->vm86 || !dc->pe || !dc->code32))
@@ -8518,7 +8518,7 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
            the flag and abort the translation to give the irqs a
            chance to happen */
         dc->base.is_jmp = DISAS_TOO_MANY;
-    } else if ((dc->base.tb->cflags & CF_USE_ICOUNT)
+    } else if ((tb_cflags(dc->base.tb) & CF_USE_ICOUNT)
                && ((dc->base.pc_next & TARGET_PAGE_MASK)
                    != ((dc->base.pc_next + TARGET_MAX_INSN_SIZE - 1)
                        & TARGET_PAGE_MASK)
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 65bc9c0bf6..d4a2e00165 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -880,24 +880,24 @@ static void dec_wcsr(DisasContext *dc)
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
@@ -1078,7 +1078,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -1106,7 +1106,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         /* Pretty disas.  */
         LOG_DIS("%8.8x:\t", dc->pc);
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -1119,7 +1119,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
          && (dc->pc < next_page_start)
          && num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 63b1552669..fdc26268d0 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5547,7 +5547,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     dc->done_mac = 0;
     dc->writeback_mask = 0;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -5573,7 +5573,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             break;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -5585,7 +5585,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
              (pc_offset) < (TARGET_PAGE_SIZE - 32) &&
              num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO)
+    if (tb_cflags(tb) & CF_LAST_IO)
         gen_io_end();
     if (unlikely(cs->singlestep_enabled)) {
         /* Make sure the pc is updated, and raise a debug exception.  */
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 067b0878d6..c70a2d6644 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1666,7 +1666,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -1701,7 +1701,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         /* Pretty disas.  */
         LOG_DIS("%8.8x:\t", dc->pc);
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -1763,7 +1763,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             npc = dc->jmp_pc;
     }
 
-    if (tb->cflags & CF_LAST_IO)
+    if (tb_cflags(tb) & CF_LAST_IO)
         gen_io_end();
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp == DISAS_NEXT
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ef07fa827e..aadffbec39 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5327,11 +5327,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -5734,7 +5734,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     if (sel != 0)
         check_insn(ctx, ISA_MIPS32);
 
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
 
@@ -6401,7 +6401,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     trace_mips_translate_c0("mtc0", rn, reg, sel);
 
     /* For simplicity assume that all writes can cause interrupts.  */
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         /* BS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.  */
@@ -6679,11 +6679,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -7072,7 +7072,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     if (sel != 0)
         check_insn(ctx, ISA_MIPS64);
 
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
 
@@ -7727,7 +7727,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     trace_mips_translate_c0("dmtc0", rn, reg, sel);
 
     /* For simplicity assume that all writes can cause interrupts.  */
-    if (ctx->tb->cflags & CF_USE_ICOUNT) {
+    if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
         gen_io_end();
         /* BS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.  */
@@ -10756,11 +10756,11 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         gen_store_gpr(t0, rt);
         break;
     case 2:
-        if (ctx->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
         gen_helper_rdhwr_cc(t0, cpu_env);
-        if (ctx->tb->cflags & CF_USE_ICOUNT) {
+        if (tb_cflags(ctx->tb) & CF_USE_ICOUNT) {
             gen_io_end();
         }
         gen_store_gpr(t0, rt);
@@ -20248,7 +20248,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     ctx.default_tcg_memop_mask = (ctx.insn_flags & ISA_MIPS32R6) ?
                                  MO_UNALN : MO_ALIGN;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -20274,7 +20274,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             goto done_generating;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -20335,7 +20335,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         if (singlestep)
             break;
     }
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
     if (cs->singlestep_enabled && ctx.bstate != BS_BRANCH) {
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index eaf5103920..3f1e609028 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -832,7 +832,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     ctx.singlestep_enabled = 0;
     ctx.bstate = BS_NONE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 54fbe898df..d33e365892 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -827,7 +827,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         max_insns = 1;
     } else {
         int page_insns = (TARGET_PAGE_SIZE - (tb->pc & TARGET_PAGE_MASK)) / 4;
-        max_insns = tb->cflags & CF_COUNT_MASK;
+        max_insns = tb_cflags(tb) & CF_COUNT_MASK;
         if (max_insns == 0) {
             max_insns = CF_COUNT_MASK;
         }
@@ -854,7 +854,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             break;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -871,7 +871,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
              !tcg_op_buf_full() &&
              num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 112db1ad0f..666d050650 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1546,7 +1546,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
 
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -1589,7 +1589,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             break;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
         disas_openrisc_insn(dc, cpu);
@@ -1612,7 +1612,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
              && (dc->pc < next_page_start)
              && num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b61f4f0bad..ac5b8ea9a5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7273,7 +7273,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     msr_se = 1;
 #endif
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -7301,7 +7301,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         LOG_DISAS("----------------\n");
         LOG_DISAS("nip=" TARGET_FMT_lx " super=%d ir=%d\n",
                   ctx.nip, ctx.mem_idx, (int)msr_ir);
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO))
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO))
             gen_io_start();
         if (unlikely(need_byteswap(&ctx))) {
             ctx.opcode = bswap32(cpu_ldl_code(env, ctx.nip));
@@ -7382,7 +7382,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             exit(1);
         }
     }
-    if (tb->cflags & CF_LAST_IO)
+    if (tb_cflags(tb) & CF_LAST_IO)
         gen_io_end();
     if (ctx.exception == POWERPC_EXCP_NONE) {
         gen_goto_tb(&ctx, 0, ctx.nip);
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 2cb58b855b..13436e4760 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -176,11 +176,11 @@ static void spr_write_ureg(DisasContext *ctx, int sprn, int gprn)
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
@@ -188,11 +188,11 @@ static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 
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
@@ -203,11 +203,11 @@ static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
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
@@ -215,11 +215,11 @@ static void spr_read_tbl(DisasContext *ctx, int gprn, int sprn)
 
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
@@ -240,11 +240,11 @@ static void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
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
@@ -252,11 +252,11 @@ static void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 
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
@@ -284,11 +284,11 @@ static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
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
@@ -296,11 +296,11 @@ static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 
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
index 6ecf764a98..d589fb2459 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -554,7 +554,7 @@ static void gen_op_calc_cc(DisasContext *s)
 static bool use_exit_tb(DisasContext *s)
 {
     return (s->singlestep_enabled ||
-            (s->tb->cflags & CF_LAST_IO) ||
+            (tb_cflags(s->tb) & CF_LAST_IO) ||
             (s->tb->flags & FLAG_MASK_PER));
 }
 
@@ -5883,7 +5883,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
 
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -5908,7 +5908,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             break;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -5927,7 +5927,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         }
     } while (status == NO_EXIT);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index b4e4fd3782..33176c9926 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2248,7 +2248,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                  (ctx.tbflags & (1 << SR_RB))) * 0x10;
     ctx.fbank = ctx.tbflags & FPSCR_FR ? 0x10 : 0;
 
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -2292,7 +2292,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             break;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -2300,7 +2300,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 	decode_opc(&ctx);
 	ctx.pc += 2;
     }
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 65939693d7..f2b5cdbf34 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5767,7 +5767,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
 #endif
 
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -5796,7 +5796,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
             goto exit_gen_loop;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -5823,7 +5823,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
              num_insns < max_insns);
 
  exit_gen_loop:
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
     if (!dc->is_br) {
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index ace2830a84..5cd84f6b25 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2378,7 +2378,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     uint64_t pc_start = tb->pc;
     uint64_t next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     int num_insns = 0;
-    int max_insns = tb->cflags & CF_COUNT_MASK;
+    int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
 
     dc->pc = pc_start;
     dc->mmuidx = 0;
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index b6cfbdfa9f..042c0e69bc 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8790,7 +8790,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     int num_insns, max_insns;
 
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 6c094d59d7..d717de0335 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1900,7 +1900,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     cpu_F1d = tcg_temp_new_i64();
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -1933,7 +1933,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             goto done_generating;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -1958,7 +1958,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
              dc->pc < next_page_start &&
              num_insns < max_insns);
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         if (dc->condjmp) {
             /* FIXME:  This can theoretically happen with self-modifying
                code.  */
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index d7bf07e8e6..f62319eddd 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -517,12 +517,12 @@ static bool gen_check_sr(DisasContext *dc, uint32_t sr, unsigned access)
 
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
@@ -702,11 +702,11 @@ static bool gen_wsr_cpenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 
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
@@ -760,11 +760,11 @@ static bool gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 
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
@@ -801,11 +801,11 @@ static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 
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
@@ -900,11 +900,11 @@ static void gen_waiti(DisasContext *dc, uint32_t imm4)
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
@@ -3126,7 +3126,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     CPUXtensaState *env = cs->env_ptr;
     DisasContext dc;
     int insn_count = 0;
-    int max_insns = tb->cflags & CF_COUNT_MASK;
+    int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     uint32_t pc_start = tb->pc;
     uint32_t next_page_start =
         (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
@@ -3162,7 +3162,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 
     gen_tb_start(tb);
 
-    if ((tb->cflags & CF_USE_ICOUNT) &&
+    if ((tb_cflags(tb) & CF_USE_ICOUNT) &&
         (tb->flags & XTENSA_TBFLAG_YIELD)) {
         tcg_gen_insn_start(dc.pc);
         ++insn_count;
@@ -3194,7 +3194,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             break;
         }
 
-        if (insn_count == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (insn_count == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
@@ -3235,7 +3235,7 @@ done:
         tcg_temp_free(dc.next_icount);
     }
 
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
-- 
2.13.6
