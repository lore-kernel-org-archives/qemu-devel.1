Received: from eggs.gnu.org ([2001:4830:134:3::10]:35244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4j-000685-6F
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4h-0002ow-4v
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:53 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs4g-0002ok-SA
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:51 -0500
Received: by mail-pf0-x243.google.com with SMTP id y143so12799521pfb.1
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:10:50 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:10:11 -0800
Message-Id: <1484514617-11726-2-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
References: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/7] target/xtensa: refactor CCOUNT/CCOMPARE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Xtensa cores may have a register (CCOUNT) that counts core clock cycles.
It may also have a number of registers (CCOMPAREx); when CCOUNT value
passes the value of CCOMPAREx, timer interrupt x is raised.

Currently xtensa target counts a number of completed instructions and
assumes that for CCOUNT one instruction takes one cycle to complete.
It calls helper function to update CCOUNT register at every TB end and
raise timer interrupts. This scheme works very predictably and doesn't
have noticeable performance impact, but it is hard to use with multiple
synchronized processors, especially with coming MTTCG.

Derive CCOUNT from the virtual simulation time, QEMU_CLOCK_VIRTUAL.
Use native QEMU timers for CCOMPARE timers, one timer for each register.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/pic_cpu.c       | 75 +++++++++--------------------------------------
 target/xtensa/cpu.h       | 16 ++++++----
 target/xtensa/helper.h    |  5 ++--
 target/xtensa/op_helper.c | 33 ++++++++++++++++-----
 target/xtensa/translate.c | 43 ++++++++-------------------
 5 files changed, 65 insertions(+), 107 deletions(-)

diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index 2bed64f..0e812d7 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -31,22 +31,6 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 
-void xtensa_advance_ccount(CPUXtensaState *env, uint32_t d)
-{
-    uint32_t old_ccount = env->sregs[CCOUNT] + 1;
-
-    env->sregs[CCOUNT] += d;
-
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_TIMER_INTERRUPT)) {
-        int i;
-        for (i = 0; i < env->config->nccompare; ++i) {
-            if (env->sregs[CCOMPARE + i] - old_ccount < d) {
-                xtensa_timer_irq(env, i, 1);
-            }
-        }
-    }
-}
-
 void check_interrupts(CPUXtensaState *env)
 {
     CPUState *cs = CPU(xtensa_env_get_cpu(env));
@@ -54,17 +38,6 @@ void check_interrupts(CPUXtensaState *env)
     uint32_t int_set_enabled = env->sregs[INTSET] & env->sregs[INTENABLE];
     int level;
 
-    /* If the CPU is halted advance CCOUNT according to the QEMU_CLOCK_VIRTUAL time
-     * elapsed since the moment when it was advanced last time.
-     */
-    if (cs->halted) {
-        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-        xtensa_advance_ccount(env,
-                muldiv64(now - env->halt_clock,
-                    env->config->clock_freq_khz, 1000000));
-        env->halt_clock = now;
-    }
     for (level = env->config->nlevel; level > minlevel; --level) {
         if (env->config->level_mask[level] & int_set_enabled) {
             env->pending_irq_level = level;
@@ -109,49 +82,29 @@ void xtensa_timer_irq(CPUXtensaState *env, uint32_t id, uint32_t active)
     qemu_set_irq(env->irq_inputs[env->config->timerint[id]], active);
 }
 
-void xtensa_rearm_ccompare_timer(CPUXtensaState *env)
-{
-    int i;
-    uint32_t wake_ccount = env->sregs[CCOUNT] - 1;
-
-    for (i = 0; i < env->config->nccompare; ++i) {
-        if (env->sregs[CCOMPARE + i] - env->sregs[CCOUNT] <
-                wake_ccount - env->sregs[CCOUNT]) {
-            wake_ccount = env->sregs[CCOMPARE + i];
-        }
-    }
-    env->wake_ccount = wake_ccount;
-    timer_mod(env->ccompare_timer, env->halt_clock +
-            (uint64_t)(wake_ccount - env->sregs[CCOUNT]) *
-            1000000 / env->config->clock_freq_khz);
-}
-
 static void xtensa_ccompare_cb(void *opaque)
 {
-    XtensaCPU *cpu = opaque;
-    CPUXtensaState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
+    XtensaCcompareTimer *ccompare = opaque;
+    CPUXtensaState *env = ccompare->env;
+    unsigned i = ccompare - env->ccompare;
 
-    if (cs->halted) {
-        env->halt_clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        xtensa_advance_ccount(env, env->wake_ccount - env->sregs[CCOUNT]);
-        if (!cpu_has_work(cs)) {
-            env->sregs[CCOUNT] = env->wake_ccount + 1;
-            xtensa_rearm_ccompare_timer(env);
-        }
-    }
+    xtensa_timer_irq(env, i, 1);
 }
 
 void xtensa_irq_init(CPUXtensaState *env)
 {
-    XtensaCPU *cpu = xtensa_env_get_cpu(env);
-
     env->irq_inputs = (void **)qemu_allocate_irqs(
             xtensa_set_irq, env, env->config->ninterrupt);
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_TIMER_INTERRUPT) &&
-            env->config->nccompare > 0) {
-        env->ccompare_timer =
-            timer_new_ns(QEMU_CLOCK_VIRTUAL, &xtensa_ccompare_cb, cpu);
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_TIMER_INTERRUPT)) {
+        unsigned i;
+
+        env->time_base = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        env->ccount_base = env->sregs[CCOUNT];
+        for (i = 0; i < env->config->nccompare; ++i) {
+            env->ccompare[i].env = env;
+            env->ccompare[i].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                    xtensa_ccompare_cb, env->ccompare + i);
+        }
     }
 }
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 77bd9d2..744af81 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -269,6 +269,8 @@ typedef enum {
     INTTYPE_MAX
 } interrupt_type;
 
+struct CPUXtensaState;
+
 typedef struct xtensa_tlb_entry {
     uint32_t vaddr;
     uint32_t paddr;
@@ -298,6 +300,11 @@ typedef struct XtensaGdbRegmap {
     XtensaGdbReg reg[1 + 16 + 64 + 256 + 256];
 } XtensaGdbRegmap;
 
+typedef struct XtensaCcompareTimer {
+    struct CPUXtensaState *env;
+    QEMUTimer *timer;
+} XtensaCcompareTimer;
+
 struct XtensaConfig {
     const char *name;
     uint64_t options;
@@ -369,9 +376,10 @@ typedef struct CPUXtensaState {
     bool runstall;
     int pending_irq_level; /* level of last raised IRQ */
     void **irq_inputs;
-    QEMUTimer *ccompare_timer;
-    uint32_t wake_ccount;
-    int64_t halt_clock;
+    XtensaCcompareTimer ccompare[MAX_NCCOMPARE];
+    uint64_t time_base;
+    uint64_t ccount_time;
+    uint32_t ccount_base;
 
     int exception_taken;
     unsigned static_vectors;
@@ -439,9 +447,7 @@ void xtensa_register_core(XtensaConfigList *node);
 void check_interrupts(CPUXtensaState *s);
 void xtensa_irq_init(CPUXtensaState *env);
 void *xtensa_get_extint(CPUXtensaState *env, unsigned extint);
-void xtensa_advance_ccount(CPUXtensaState *env, uint32_t d);
 void xtensa_timer_irq(CPUXtensaState *env, uint32_t id, uint32_t active);
-void xtensa_rearm_ccompare_timer(CPUXtensaState *env);
 int cpu_xtensa_signal_handler(int host_signum, void *pinfo, void *puc);
 void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 void xtensa_sync_window_from_phys(CPUXtensaState *env);
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 5ea9c5b..427bdc7 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -18,8 +18,9 @@ DEF_HELPER_1(simcall, void, env)
 DEF_HELPER_1(dump_state, void, env)
 
 DEF_HELPER_3(waiti, void, env, i32, i32)
-DEF_HELPER_3(timer_irq, void, env, i32, i32)
-DEF_HELPER_2(advance_ccount, void, env, i32)
+DEF_HELPER_1(update_ccount, void, env)
+DEF_HELPER_2(wsr_ccount, void, env, i32)
+DEF_HELPER_2(update_ccompare, void, env, i32)
 DEF_HELPER_1(check_interrupts, void, env)
 DEF_HELPER_3(check_atomctl, void, env, i32, i32)
 
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 0a4b214..5e5c7da 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -398,22 +398,39 @@ void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
     }
 
     cpu = CPU(xtensa_env_get_cpu(env));
-    env->halt_clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     cpu->halted = 1;
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_TIMER_INTERRUPT)) {
-        xtensa_rearm_ccompare_timer(env);
-    }
     HELPER(exception)(env, EXCP_HLT);
 }
 
-void HELPER(timer_irq)(CPUXtensaState *env, uint32_t id, uint32_t active)
+void HELPER(update_ccount)(CPUXtensaState *env)
+{
+    uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    env->ccount_time = now;
+    env->sregs[CCOUNT] = env->ccount_base +
+        (uint32_t)((now - env->time_base) *
+                   env->config->clock_freq_khz / 1000000);
+}
+
+void HELPER(wsr_ccount)(CPUXtensaState *env, uint32_t v)
 {
-    xtensa_timer_irq(env, id, active);
+    int i;
+
+    HELPER(update_ccount)(env);
+    env->ccount_base += v - env->sregs[CCOUNT];
+    for (i = 0; i < env->config->nccompare; ++i) {
+        HELPER(update_ccompare)(env, i);
+    }
 }
 
-void HELPER(advance_ccount)(CPUXtensaState *env, uint32_t d)
+void HELPER(update_ccompare)(CPUXtensaState *env, uint32_t i)
 {
-    xtensa_advance_ccount(env, d);
+    uint64_t dcc;
+
+    HELPER(update_ccount)(env);
+    dcc = (uint64_t)(env->sregs[CCOMPARE + i] - env->sregs[CCOUNT] - 1) + 1;
+    timer_mod(env->ccompare[i].timer,
+              env->ccount_time + (dcc * 1000000) / env->config->clock_freq_khz);
 }
 
 void HELPER(check_interrupts)(CPUXtensaState *env)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 0858c29..cb42945 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -64,7 +64,6 @@ typedef struct DisasContext {
     bool sar_m32_allocated;
     TCGv_i32 sar_m32;
 
-    uint32_t ccount_delta;
     unsigned window;
 
     bool debug;
@@ -314,20 +313,9 @@ static void gen_left_shift_sar(DisasContext *dc, TCGv_i32 sa)
     tcg_temp_free(tmp);
 }
 
-static void gen_advance_ccount(DisasContext *dc)
-{
-    if (dc->ccount_delta > 0) {
-        TCGv_i32 tmp = tcg_const_i32(dc->ccount_delta);
-        gen_helper_advance_ccount(cpu_env, tmp);
-        tcg_temp_free(tmp);
-    }
-    dc->ccount_delta = 0;
-}
-
 static void gen_exception(DisasContext *dc, int excp)
 {
     TCGv_i32 tmp = tcg_const_i32(excp);
-    gen_advance_ccount(dc);
     gen_helper_exception(cpu_env, tmp);
     tcg_temp_free(tmp);
 }
@@ -336,7 +324,6 @@ static void gen_exception_cause(DisasContext *dc, uint32_t cause)
 {
     TCGv_i32 tpc = tcg_const_i32(dc->pc);
     TCGv_i32 tcause = tcg_const_i32(cause);
-    gen_advance_ccount(dc);
     gen_helper_exception_cause(cpu_env, tpc, tcause);
     tcg_temp_free(tpc);
     tcg_temp_free(tcause);
@@ -351,7 +338,6 @@ static void gen_exception_cause_vaddr(DisasContext *dc, uint32_t cause,
 {
     TCGv_i32 tpc = tcg_const_i32(dc->pc);
     TCGv_i32 tcause = tcg_const_i32(cause);
-    gen_advance_ccount(dc);
     gen_helper_exception_cause_vaddr(cpu_env, tpc, tcause, vaddr);
     tcg_temp_free(tpc);
     tcg_temp_free(tcause);
@@ -361,7 +347,6 @@ static void gen_debug_exception(DisasContext *dc, uint32_t cause)
 {
     TCGv_i32 tpc = tcg_const_i32(dc->pc);
     TCGv_i32 tcause = tcg_const_i32(cause);
-    gen_advance_ccount(dc);
     gen_helper_debug_exception(cpu_env, tpc, tcause);
     tcg_temp_free(tpc);
     tcg_temp_free(tcause);
@@ -394,7 +379,6 @@ static bool gen_check_cpenable(DisasContext *dc, unsigned cp)
 static void gen_jump_slot(DisasContext *dc, TCGv dest, int slot)
 {
     tcg_gen_mov_i32(cpu_pc, dest);
-    gen_advance_ccount(dc);
     if (dc->icount) {
         tcg_gen_mov_i32(cpu_SR[ICOUNT], dc->next_icount);
     }
@@ -465,7 +449,6 @@ static bool gen_check_loop_end(DisasContext *dc, int slot)
             dc->next_pc == dc->lend) {
         TCGLabel *label = gen_new_label();
 
-        gen_advance_ccount(dc);
         tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_SR[LCOUNT], 0, label);
         tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_SR[LCOUNT], 1);
         gen_jumpi(dc, dc->lbeg, slot);
@@ -488,7 +471,6 @@ static void gen_brcond(DisasContext *dc, TCGCond cond,
 {
     TCGLabel *label = gen_new_label();
 
-    gen_advance_ccount(dc);
     tcg_gen_brcond_i32(cond, t0, t1, label);
     gen_jumpi_check_loop_end(dc, 0);
     gen_set_label(label);
@@ -530,7 +512,7 @@ static bool gen_check_sr(DisasContext *dc, uint32_t sr, unsigned access)
 
 static void gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
-    gen_advance_ccount(dc);
+    gen_helper_update_ccount(cpu_env);
     tcg_gen_mov_i32(d, cpu_SR[sr]);
 }
 
@@ -546,6 +528,7 @@ static void gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
     static void (* const rsr_handler[256])(DisasContext *dc,
             TCGv_i32 d, uint32_t sr) = {
         [CCOUNT] = gen_rsr_ccount,
+        [INTSET] = gen_rsr_ccount,
         [PTEVADDR] = gen_rsr_ptevaddr,
     };
 
@@ -720,6 +703,11 @@ static void gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     gen_jumpi_check_loop_end(dc, -1);
 }
 
+static void gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+{
+    gen_helper_wsr_ccount(cpu_env, v);
+}
+
 static void gen_wsr_icount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     if (dc->icount) {
@@ -741,10 +729,12 @@ static void gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     uint32_t id = sr - CCOMPARE;
     if (id < dc->config->nccompare) {
         uint32_t int_bit = 1 << dc->config->timerint[id];
-        gen_advance_ccount(dc);
+        TCGv_i32 tmp = tcg_const_i32(id);
+
         tcg_gen_mov_i32(cpu_SR[sr], v);
         tcg_gen_andi_i32(cpu_SR[INTSET], cpu_SR[INTSET], ~int_bit);
-        gen_helper_check_interrupts(cpu_env);
+        gen_helper_update_ccompare(cpu_env, tmp);
+        tcg_temp_free(tmp);
     }
 }
 
@@ -777,6 +767,7 @@ static void gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
         [INTCLEAR] = gen_wsr_intclear,
         [INTENABLE] = gen_wsr_intenable,
         [PS] = gen_wsr_ps,
+        [CCOUNT] = gen_wsr_ccount,
         [ICOUNT] = gen_wsr_icount,
         [ICOUNTLEVEL] = gen_wsr_icountlevel,
         [CCOMPARE] = gen_wsr_ccompare,
@@ -829,7 +820,6 @@ static void gen_waiti(DisasContext *dc, uint32_t imm4)
 {
     TCGv_i32 pc = tcg_const_i32(dc->next_pc);
     TCGv_i32 intlevel = tcg_const_i32(imm4);
-    gen_advance_ccount(dc);
     gen_helper_waiti(cpu_env, pc, intlevel);
     tcg_temp_free(pc);
     tcg_temp_free(intlevel);
@@ -841,7 +831,6 @@ static bool gen_window_check1(DisasContext *dc, unsigned r1)
         TCGv_i32 pc = tcg_const_i32(dc->pc);
         TCGv_i32 w = tcg_const_i32(r1 / 4);
 
-        gen_advance_ccount(dc);
         gen_helper_window_check(cpu_env, pc, w);
         dc->is_jmp = DISAS_UPDATE;
         return false;
@@ -1037,7 +1026,6 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                             HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
                             {
                                 TCGv_i32 tmp = tcg_const_i32(dc->pc);
-                                gen_advance_ccount(dc);
                                 gen_helper_retw(tmp, cpu_env, tmp);
                                 gen_jump(dc, tmp);
                                 tcg_temp_free(tmp);
@@ -1086,7 +1074,6 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                     HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
                     if (gen_window_check2(dc, RRR_T, RRR_S)) {
                         TCGv_i32 pc = tcg_const_i32(dc->pc);
-                        gen_advance_ccount(dc);
                         gen_helper_movsp(cpu_env, pc);
                         tcg_gen_mov_i32(cpu_R[RRR_T], cpu_R[RRR_S]);
                         tcg_temp_free(pc);
@@ -2517,7 +2504,6 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                 tcg_gen_addi_i32(addr, cpu_R[RRI8_S], RRI8_IMM8 << 2);
                 gen_load_store_alignment(dc, 2, addr, true);
 
-                gen_advance_ccount(dc);
                 tpc = tcg_const_i32(dc->pc);
                 gen_helper_check_atomctl(cpu_env, tpc, addr);
                 tcg_gen_qemu_ld32u(cpu_R[RRI8_T], addr, dc->cring);
@@ -2747,7 +2733,6 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                     TCGv_i32 pc = tcg_const_i32(dc->pc);
                     TCGv_i32 s = tcg_const_i32(BRI12_S);
                     TCGv_i32 imm = tcg_const_i32(BRI12_IMM12);
-                    gen_advance_ccount(dc);
                     gen_helper_entry(cpu_env, pc, s, imm);
                     tcg_temp_free(imm);
                     tcg_temp_free(s);
@@ -2966,7 +2951,6 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                 HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
                 {
                     TCGv_i32 tmp = tcg_const_i32(dc->pc);
-                    gen_advance_ccount(dc);
                     gen_helper_retw(tmp, cpu_env, tmp);
                     gen_jump(dc, tmp);
                     tcg_temp_free(tmp);
@@ -3063,7 +3047,6 @@ void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
     dc.lbeg = env->sregs[LBEG];
     dc.lend = env->sregs[LEND];
     dc.is_jmp = DISAS_NEXT;
-    dc.ccount_delta = 0;
     dc.debug = tb->flags & XTENSA_TBFLAG_DEBUG;
     dc.icount = tb->flags & XTENSA_TBFLAG_ICOUNT;
     dc.cpenable = (tb->flags & XTENSA_TBFLAG_CPENABLE_MASK) >>
@@ -3088,8 +3071,6 @@ void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
         tcg_gen_insn_start(dc.pc);
         ++insn_count;
 
-        ++dc.ccount_delta;
-
         if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
             tcg_gen_movi_i32(cpu_pc, dc.pc);
             gen_exception(&dc, EXCP_DEBUG);
-- 
2.1.4
