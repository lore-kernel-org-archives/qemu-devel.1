Received: from eggs.gnu.org ([2001:4830:134:3::10]:44721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLdor-0000vq-Ea
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 19:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLdon-00027m-Qo
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 19:04:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 15 Jun 2017 19:04:39 -0400
Message-Id: <1497567879-13734-2-git-send-email-cota@braap.org>
In-Reply-To: <1497567879-13734-1-git-send-email-cota@braap.org>
References: <1497567879-13734-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/2] gen-icount: pass cpu_env as a parameter to
 gen_* inlines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>

We are relying on cpu_env being defined as a global, yet most
targets (i.e. all but arm/a64) have it defined as a local variable.
Luckily all of them use the same "cpu_env" name, but really
compilation shouldn't break if the name of that local variable
changed.

This patch fixes it by explicitly passing cpu_env to the gen_*
inlines that need it. This change also helps paving the way for
the upcoming "translation loop common to all targets" work.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/gen-icount.h     |  6 +++---
 target/alpha/translate.c      | 14 +++++++-------
 target/arm/translate-a64.c    | 10 +++++-----
 target/arm/translate.c        | 10 +++++-----
 target/cris/translate.c       |  6 +++---
 target/hppa/translate.c       |  6 +++---
 target/i386/translate.c       | 38 +++++++++++++++++++-------------------
 target/lm32/translate.c       | 14 +++++++-------
 target/m68k/translate.c       |  6 +++---
 target/microblaze/translate.c |  6 +++---
 target/mips/translate.c       | 26 +++++++++++++-------------
 target/moxie/translate.c      |  2 +-
 target/nios2/translate.c      |  6 +++---
 target/openrisc/translate.c   |  6 +++---
 target/ppc/translate.c        |  6 +++---
 target/ppc/translate_init.c   | 32 ++++++++++++++++----------------
 target/s390x/translate.c      |  6 +++---
 target/sh4/translate.c        |  6 +++---
 target/sparc/translate.c      |  6 +++---
 target/tilegx/translate.c     |  2 +-
 target/tricore/translate.c    |  2 +-
 target/unicore32/translate.c  |  6 +++---
 target/xtensa/translate.c     | 26 +++++++++++++-------------
 23 files changed, 124 insertions(+), 124 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 547c979..f4ad610 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -8,7 +8,7 @@
 static int icount_start_insn_idx;
 static TCGLabel *exitreq_label;
 
-static inline void gen_tb_start(TranslationBlock *tb)
+static inline void gen_tb_start(TranslationBlock *tb, TCGv_env cpu_env)
 {
     TCGv_i32 count, imm;
 
@@ -59,14 +59,14 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
     tcg_ctx.gen_op_buf[tcg_ctx.gen_op_buf[0].prev].next = 0;
 }
 
-static inline void gen_io_start(void)
+static inline void gen_io_start(TCGv_env cpu_env)
 {
     TCGv_i32 tmp = tcg_const_i32(1);
     tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
 
-static inline void gen_io_end(void)
+static inline void gen_io_end(TCGv_env cpu_env)
 {
     TCGv_i32 tmp = tcg_const_i32(0);
     tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 232af9e..7d3d1c6 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1339,9 +1339,9 @@ static ExitStatus gen_mfpr(DisasContext *ctx, TCGv va, int regno)
         helper = gen_helper_get_vmtime;
     do_helper:
         if (use_icount) {
-            gen_io_start();
+            gen_io_start(cpu_env);
             helper(va);
-            gen_io_end();
+            gen_io_start(cpu_env);
             return EXIT_PC_STALE;
         } else {
             helper(va);
@@ -2389,9 +2389,9 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
             /* RPCC */
             va = dest_gpr(ctx, ra);
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
+                gen_io_start(cpu_env);
                 gen_helper_load_pcc(va, cpu_env);
-                gen_io_end();
+                gen_io_start(cpu_env);
                 ret = EXIT_PC_STALE;
             } else {
                 gen_helper_load_pcc(va, cpu_env);
@@ -2967,7 +2967,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
         pc_mask = ~TARGET_PAGE_MASK;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(ctx.pc);
         num_insns++;
@@ -2982,7 +2982,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
             break;
         }
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         insn = cpu_ldl_code(env, ctx.pc);
 
@@ -3003,7 +3003,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
     } while (ret == NO_EXIT);
 
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 
     switch (ret) {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e55547d..3f2b761 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1560,7 +1560,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     }
 
     if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
 
     tcg_rt = cpu_reg(s, rt);
@@ -1592,7 +1592,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
 
     if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
-        gen_io_end();
+        gen_io_start(cpu_env);
         s->is_jmp = DISAS_UPDATE;
     } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
@@ -11265,7 +11265,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
 
     tcg_clear_temp_count();
 
@@ -11299,7 +11299,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
         }
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         if (dc->ss_active && !dc->pstate_ss) {
@@ -11340,7 +11340,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
              num_insns < max_insns);
 
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 
     if (unlikely(cs->singlestep_enabled || dc->ss_active)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0862f9e..402d948 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7654,7 +7654,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
         }
 
         if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         if (isread) {
@@ -7746,7 +7746,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 
         if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             /* I/O operations must end the TB here (whether read or write) */
-            gen_io_end();
+            gen_io_start(cpu_env);
             gen_lookup_tb(s);
         } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
             /* We default to ending the TB on a coprocessor register write,
@@ -11881,7 +11881,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
 
     tcg_clear_temp_count();
 
@@ -11969,7 +11969,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
         }
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         if (dc->ss_active && !dc->pstate_ss) {
@@ -12044,7 +12044,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
                code.  */
             cpu_abort(cs, "IO on conditional branch instruction");
         }
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 
     /* At this stage dc->condjmp will only be set when the skipped
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0ee05ca..610e026 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3145,7 +3145,7 @@ void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(dc->delayed_branch == 1
                            ? dc->ppc | 1 : dc->pc);
@@ -3168,7 +3168,7 @@ void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *tb)
         LOG_DIS("%8.8x:\t", dc->pc);
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         dc->clear_x = 1;
 
@@ -3241,7 +3241,7 @@ void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *tb)
     npc = dc->pc;
 
         if (tb->cflags & CF_LAST_IO)
-            gen_io_end();
+            gen_io_start(cpu_env);
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp == DISAS_NEXT
         && (dc->cpustate_changed || !dc->flagx_known
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e10abc5..a64ce46 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3773,7 +3773,7 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
     }
 
     num_insns = 0;
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
 
     /* Seed the nullification status from PSW[N], as shown in TB->FLAGS.  */
     ctx.null_cond = cond_make_f();
@@ -3793,7 +3793,7 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
             break;
         }
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         if (ctx.iaoq_f < TARGET_PAGE_SIZE) {
@@ -3869,7 +3869,7 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
     } while (ret == NO_EXIT);
 
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 
     switch (ret) {
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 674ec96..65c799d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1120,7 +1120,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
 static inline void gen_ins(DisasContext *s, TCGMemOp ot)
 {
     if (s->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_string_movl_A0_EDI(s);
     /* Note: we must do this dummy write first to be restartable in
@@ -1135,14 +1135,14 @@ static inline void gen_ins(DisasContext *s, TCGMemOp ot)
     gen_op_add_reg_T0(s->aflag, R_EDI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
     if (s->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 }
 
 static inline void gen_outs(DisasContext *s, TCGMemOp ot)
 {
     if (s->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
@@ -1155,7 +1155,7 @@ static inline void gen_outs(DisasContext *s, TCGMemOp ot)
     gen_op_add_reg_T0(s->aflag, R_ESI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
     if (s->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 }
 
@@ -6338,14 +6338,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
 	}
         tcg_gen_movi_i32(cpu_tmp2_i32, val);
         gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_start(cpu_env);
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6359,14 +6359,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
 
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
 	}
         tcg_gen_movi_i32(cpu_tmp2_i32, val);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
         gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_start(cpu_env);
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6377,14 +6377,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
 	}
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_start(cpu_env);
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6397,14 +6397,14 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
 
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
 	}
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
         gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_start(cpu_env);
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -7112,11 +7112,11 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_update_cc_op(s);
         gen_jmp_im(pc_start - s->cs_base);
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
 	}
         gen_helper_rdtsc(cpu_env);
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_start(cpu_env);
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -7571,11 +7571,11 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             if (s->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
+                gen_io_start(cpu_env);
             }
             gen_helper_rdtscp(cpu_env);
             if (s->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_end();
+                gen_io_start(cpu_env);
                 gen_jmp(s, s->pc - s->cs_base);
             }
             break;
@@ -8457,7 +8457,7 @@ void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     for(;;) {
         tcg_gen_insn_start(pc_ptr, dc->cc_op);
         num_insns++;
@@ -8475,7 +8475,7 @@ void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
             goto done_generating;
         }
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         pc_ptr = disas_insn(env, dc, pc_ptr);
@@ -8522,7 +8522,7 @@ void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
         }
     }
     if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
+        gen_io_start(cpu_env);
 done_generating:
     gen_tb_end(tb, num_insns);
 
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 692882f..b6fabb7 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -875,24 +875,24 @@ static void dec_wcsr(DisasContext *dc)
     case CSR_IM:
         /* mark as an io operation because it could cause an interrupt */
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         gen_helper_wcsr_im(cpu_env, cpu_R[dc->r1]);
         tcg_gen_movi_tl(cpu_pc, dc->pc + 4);
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_start(cpu_env);
         }
         dc->is_jmp = DISAS_UPDATE;
         break;
     case CSR_IP:
         /* mark as an io operation because it could cause an interrupt */
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         gen_helper_wcsr_ip(cpu_env, cpu_R[dc->r1]);
         tcg_gen_movi_tl(cpu_pc, dc->pc + 4);
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_start(cpu_env);
         }
         dc->is_jmp = DISAS_UPDATE;
         break;
@@ -1080,7 +1080,7 @@ void gen_intermediate_code(CPULM32State *env, struct TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(dc->pc);
         num_insns++;
@@ -1101,7 +1101,7 @@ void gen_intermediate_code(CPULM32State *env, struct TranslationBlock *tb)
         LOG_DIS("%8.8x:\t", dc->pc);
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         decode(dc, cpu_ldl_code(env, dc->pc));
@@ -1114,7 +1114,7 @@ void gen_intermediate_code(CPULM32State *env, struct TranslationBlock *tb)
          && num_insns < max_insns);
 
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 
     if (unlikely(cs->singlestep_enabled)) {
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ad4d4ef..29f4409 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5073,7 +5073,7 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         pc_offset = dc->pc - pc_start;
         gen_throws_exception = NULL;
@@ -5092,7 +5092,7 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
         }
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         dc->insn_pc = dc->pc;
@@ -5104,7 +5104,7 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
              num_insns < max_insns);
 
     if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
+        gen_io_start(cpu_env);
     if (unlikely(cs->singlestep_enabled)) {
         /* Make sure the pc is updated, and raise a debug exception.  */
         if (!dc->is_jmp) {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0bb6095..dcc6b37 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1637,7 +1637,7 @@ void gen_intermediate_code(CPUMBState *env, struct TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do
     {
         tcg_gen_insn_start(dc->pc);
@@ -1665,7 +1665,7 @@ void gen_intermediate_code(CPUMBState *env, struct TranslationBlock *tb)
         LOG_DIS("%8.8x:\t", dc->pc);
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         dc->clear_imm = 1;
@@ -1727,7 +1727,7 @@ void gen_intermediate_code(CPUMBState *env, struct TranslationBlock *tb)
     }
 
     if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
+        gen_io_start(cpu_env);
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp == DISAS_NEXT
         && (dc->cpustate_changed || org_flags != dc->tb_flags)) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 559f8fe..8372808 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5233,11 +5233,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             /* Mark as an IO operation because we read the time.  */
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
+                gen_io_start(cpu_env);
 	    }
             gen_helper_mfc0_count(arg, cpu_env);
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_end();
+                gen_io_start(cpu_env);
             }
             /* Break the TB to be able to take timer interrupts immediately
                after reading count.  */
@@ -5637,7 +5637,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         check_insn(ctx, ISA_MIPS32);
 
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
 
     switch (reg) {
@@ -6286,7 +6286,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 
     /* For simplicity assume that all writes can cause interrupts.  */
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         ctx->bstate = BS_STOP;
     }
     return;
@@ -6546,11 +6546,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 0:
             /* Mark as an IO operation because we read the time.  */
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
+                gen_io_start(cpu_env);
             }
             gen_helper_mfc0_count(arg, cpu_env);
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_end();
+                gen_io_start(cpu_env);
             }
             /* Break the TB to be able to take timer interrupts immediately
                after reading count.  */
@@ -6937,7 +6937,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         check_insn(ctx, ISA_MIPS64);
 
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
 
     switch (reg) {
@@ -7254,11 +7254,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* Mark as an IO operation because we may trigger a software
                interrupt.  */
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
+                gen_io_start(cpu_env);
             }
             gen_helper_mtc0_cause(cpu_env, arg);
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_end();
+                gen_io_start(cpu_env);
             }
             /* Stop translation as we may have triggered an intetrupt */
             ctx->bstate = BS_STOP;
@@ -7584,7 +7584,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 
     /* For simplicity assume that all writes can cause interrupts.  */
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         ctx->bstate = BS_STOP;
     }
     return;
@@ -19936,7 +19936,7 @@ void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *tb)
     }
 
     LOG_DISAS("\ntb %p idx %d hflags %04x\n", tb, ctx.mem_idx, ctx.hflags);
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     while (ctx.bstate == BS_NONE) {
         tcg_gen_insn_start(ctx.pc, ctx.hflags & MIPS_HFLAG_BMASK, ctx.btarget);
         num_insns++;
@@ -19954,7 +19954,7 @@ void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *tb)
         }
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         is_slot = ctx.hflags & MIPS_HFLAG_BMASK;
@@ -20015,7 +20015,7 @@ void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *tb)
             break;
     }
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
     if (cs->singlestep_enabled && ctx.bstate != BS_BRANCH) {
         save_cpu_state(&ctx, ctx.bstate != BS_EXCP);
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 0660b44..ca55303 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -846,7 +846,7 @@ void gen_intermediate_code(CPUMoxieState *env, struct TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(ctx.pc);
         num_insns++;
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 2f3c2e5..74c5318 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -834,7 +834,7 @@ void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
         }
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(dc->pc);
         num_insns++;
@@ -850,7 +850,7 @@ void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
         }
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         /* Decode an instruction */
@@ -867,7 +867,7 @@ void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
              num_insns < max_insns);
 
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 
     /* Indicate where the next block should start */
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index e49518e..f766fc4 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1556,7 +1556,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
 
     /* Allow the TCG optimizer to see that R0 == 0,
        when it's true, which is the common case.  */
@@ -1584,7 +1584,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
         }
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         disas_openrisc_insn(dc, cpu);
         dc->pc = dc->pc + 4;
@@ -1607,7 +1607,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
              && num_insns < max_insns);
 
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 
     if ((dc->tb_flags & TB_FLAGS_DFLAG ? 1 : 0) != (dc->delayed_branch != 0)) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c0cd64d..9e5f671 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7283,7 +7283,7 @@ void gen_intermediate_code(CPUPPCState *env, struct TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     tcg_clear_temp_count();
     /* Set env in case of segfault during code fetch */
     while (ctx.exception == POWERPC_EXCP_NONE && !tcg_op_buf_full()) {
@@ -7304,7 +7304,7 @@ void gen_intermediate_code(CPUPPCState *env, struct TranslationBlock *tb)
         LOG_DISAS("nip=" TARGET_FMT_lx " super=%d ir=%d\n",
                   ctx.nip, ctx.mem_idx, (int)msr_ir);
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO))
-            gen_io_start();
+            gen_io_start(cpu_env);
         if (unlikely(need_byteswap(&ctx))) {
             ctx.opcode = bswap32(cpu_ldl_code(env, ctx.nip));
         } else {
@@ -7385,7 +7385,7 @@ void gen_intermediate_code(CPUPPCState *env, struct TranslationBlock *tb)
         }
     }
     if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
+        gen_io_start(cpu_env);
     if (ctx.exception == POWERPC_EXCP_NONE) {
         gen_goto_tb(&ctx, 0, ctx.nip);
     } else if (ctx.exception != POWERPC_EXCP_BRANCH) {
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 56a0ab2..3804221 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -175,11 +175,11 @@ static void spr_write_ureg(DisasContext *ctx, int sprn, int gprn)
 static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_load_decr(cpu_gpr[gprn], cpu_env);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -187,11 +187,11 @@ static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_store_decr(cpu_env, cpu_gpr[gprn]);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -202,11 +202,11 @@ static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
 static void spr_read_tbl(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_load_tbl(cpu_gpr[gprn], cpu_env);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -214,11 +214,11 @@ static void spr_read_tbl(DisasContext *ctx, int gprn, int sprn)
 static void spr_read_tbu(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_load_tbu(cpu_gpr[gprn], cpu_env);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -239,11 +239,11 @@ static void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
 static void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_store_tbl(cpu_env, cpu_gpr[gprn]);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -251,11 +251,11 @@ static void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 static void spr_write_tbu(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_store_tbu(cpu_env, cpu_gpr[gprn]);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -283,11 +283,11 @@ static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
 static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_load_hdecr(cpu_gpr[gprn], cpu_env);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -295,11 +295,11 @@ static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 static void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_store_hdecr(cpu_env, cpu_gpr[gprn]);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         gen_stop_exception(ctx);
     }
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 95f91d4..7fa1229 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5749,7 +5749,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
 
     do {
         tcg_gen_insn_start(dc.pc, dc.cc_op);
@@ -5767,7 +5767,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
         }
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         status = translate_one(env, &dc);
@@ -5786,7 +5786,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
     } while (status == NO_EXIT);
 
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 
     switch (status) {
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8bc132b..f27ed37 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1847,7 +1847,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     while (ctx.bstate == BS_NONE && !tcg_op_buf_full()) {
         tcg_gen_insn_start(ctx.pc, ctx.envflags);
         num_insns++;
@@ -1866,7 +1866,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
         }
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         ctx.opcode = cpu_lduw_code(env, ctx.pc);
@@ -1883,7 +1883,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
             break;
     }
     if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
+        gen_io_start(cpu_env);
     if (cs->singlestep_enabled) {
         gen_save_cpu_state(&ctx, true);
         gen_helper_debug(cpu_env);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index aa6734d..0f9f0ed 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5789,7 +5789,7 @@ void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         if (dc->npc & JUMP_PC) {
             assert(dc->jump_pc[1] == dc->pc + 4);
@@ -5811,7 +5811,7 @@ void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
         }
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         insn = cpu_ldl_code(env, dc->pc);
@@ -5838,7 +5838,7 @@ void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
 
  exit_gen_loop:
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
     if (!dc->is_br) {
         if (dc->pc != DYNAMIC_PC &&
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index ff2ef7b..3f656ed 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2403,7 +2403,7 @@ void gen_intermediate_code(CPUTLGState *env, struct TranslationBlock *tb)
     if (max_insns > TCG_MAX_INSNS) {
         max_insns = TCG_MAX_INSNS;
     }
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
 
     while (1) {
         tcg_gen_insn_start(dc->pc);
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ddd2dd0..a19d110 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8811,7 +8811,7 @@ void gen_intermediate_code(CPUTriCoreState *env, struct TranslationBlock *tb)
     ctx.mem_idx = cpu_mmu_index(env, false);
 
     tcg_clear_temp_count();
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     while (ctx.bstate == BS_NONE) {
         tcg_gen_insn_start(ctx.pc);
         num_insns++;
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 666a201..caa76a5 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1912,7 +1912,7 @@ void gen_intermediate_code(CPUUniCore32State *env, TranslationBlock *tb)
     }
 #endif
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(dc->pc);
         num_insns++;
@@ -1930,7 +1930,7 @@ void gen_intermediate_code(CPUUniCore32State *env, TranslationBlock *tb)
         }
 
         if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         disas_uc32_insn(env, dc);
@@ -1960,7 +1960,7 @@ void gen_intermediate_code(CPUUniCore32State *env, TranslationBlock *tb)
                code.  */
             cpu_abort(cs, "IO on conditional branch instruction");
         }
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 
     /* At this stage dc->condjmp will only be set when the skipped
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 2630024..94bb298 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -514,12 +514,12 @@ static bool gen_check_sr(DisasContext *dc, uint32_t sr, unsigned access)
 static bool gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_update_ccount(cpu_env);
     tcg_gen_mov_i32(d, cpu_SR[sr]);
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         return true;
     }
     return false;
@@ -699,11 +699,11 @@ static bool gen_wsr_cpenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 static void gen_check_interrupts(DisasContext *dc)
 {
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_check_interrupts(cpu_env);
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 }
 
@@ -757,11 +757,11 @@ static bool gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 static bool gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_wsr_ccount(cpu_env, v);
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
         gen_jumpi_check_loop_end(dc, 0);
         return true;
     }
@@ -798,11 +798,11 @@ static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
         tcg_gen_mov_i32(cpu_SR[sr], v);
         tcg_gen_andi_i32(cpu_SR[INTSET], cpu_SR[INTSET], ~int_bit);
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         gen_helper_update_ccompare(cpu_env, tmp);
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_start(cpu_env);
             gen_jumpi_check_loop_end(dc, 0);
             ret = true;
         }
@@ -897,11 +897,11 @@ static void gen_waiti(DisasContext *dc, uint32_t imm4)
     TCGv_i32 intlevel = tcg_const_i32(imm4);
 
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_waiti(cpu_env, pc, intlevel);
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
     tcg_temp_free(pc);
     tcg_temp_free(intlevel);
@@ -3157,7 +3157,7 @@ void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
         dc.next_icount = tcg_temp_local_new_i32();
     }
 
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
 
     if ((tb->cflags & CF_USE_ICOUNT) &&
         (tb->flags & XTENSA_TBFLAG_YIELD)) {
@@ -3192,7 +3192,7 @@ void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
         }
 
         if (insn_count == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         if (dc.icount) {
@@ -3233,7 +3233,7 @@ done:
     }
 
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_start(cpu_env);
     }
 
     if (dc.is_jmp == DISAS_NEXT) {
-- 
2.7.4
