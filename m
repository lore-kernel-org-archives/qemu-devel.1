Received: from eggs.gnu.org ([2001:4830:134:3::10]:56296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3EA-0001O7-6w
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 04:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3E5-00074M-D4
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 04:49:06 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 11:47:46 +0300
Message-Id: <149838046604.6497.6648018844505723967.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 01/26] Pass generic CPUState to
 gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

Needed to implement a target-agnostic gen_intermediate_code() in the
future.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/exec-all.h       |    2 +-
 target/alpha/translate.c      |   11 +++++------
 target/arm/translate.c        |   20 ++++++++++----------
 target/cris/translate.c       |   17 ++++++++---------
 target/i386/translate.c       |   13 ++++++-------
 target/lm32/translate.c       |   22 +++++++++++-----------
 target/m68k/translate.c       |   15 +++++++--------
 target/microblaze/translate.c |   22 +++++++++++-----------
 target/mips/translate.c       |   15 +++++++--------
 target/moxie/translate.c      |   14 +++++++-------
 target/openrisc/translate.c   |   19 ++++++++++---------
 target/ppc/translate.c        |   15 +++++++--------
 target/s390x/translate.c      |   13 ++++++-------
 target/sh4/translate.c        |   15 +++++++--------
 target/sparc/translate.c      |   11 +++++------
 target/tilegx/translate.c     |    7 +++----
 target/tricore/translate.c    |    9 ++++-----
 target/unicore32/translate.c  |   17 ++++++++---------
 target/xtensa/translate.c     |   13 ++++++-------
 translate-all.c               |    2 +-
 20 files changed, 130 insertions(+), 142 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 87ae10bcc9..1ec7637170 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -43,7 +43,7 @@ typedef ram_addr_t tb_page_addr_t;
=20
 #include "qemu/log.h"
=20
-void gen_intermediate_code(CPUArchState *env, struct TranslationBlock *t=
b);
+void gen_intermediate_code(CPUState *env, struct TranslationBlock *tb);
 void restore_state_to_opc(CPUArchState *env, struct TranslationBlock *tb=
,
                           target_ulong *data);
=20
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 7c45ae360c..9b60680454 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2900,10 +2900,9 @@ static ExitStatus translate_one(DisasContext *ctx,=
 uint32_t insn)
     return ret;
 }
=20
-void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *=
tb)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    AlphaCPU *cpu =3D alpha_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUAlphaState *env =3D cpu->env_ptr;
     DisasContext ctx, *ctxp =3D &ctx;
     target_ulong pc_start;
     target_ulong pc_mask;
@@ -2918,7 +2917,7 @@ void gen_intermediate_code(CPUAlphaState *env, stru=
ct TranslationBlock *tb)
     ctx.pc =3D pc_start;
     ctx.mem_idx =3D cpu_mmu_index(env, false);
     ctx.implver =3D env->implver;
-    ctx.singlestep_enabled =3D cs->singlestep_enabled;
+    ctx.singlestep_enabled =3D cpu->singlestep_enabled;
=20
 #ifdef CONFIG_USER_ONLY
     ctx.ir =3D cpu_std_ir;
@@ -2961,7 +2960,7 @@ void gen_intermediate_code(CPUAlphaState *env, stru=
ct TranslationBlock *tb)
         tcg_gen_insn_start(ctx.pc);
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, ctx.pc, BP_ANY))) {
             ret =3D gen_excp(&ctx, EXCP_DEBUG, 0);
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
@@ -3030,7 +3029,7 @@ void gen_intermediate_code(CPUAlphaState *env, stru=
ct TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.pc - pc_start, 1);
+        log_target_disas(cpu, pc_start, ctx.pc - pc_start, 1);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0862f9e4aa..96272a9888 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11787,10 +11787,10 @@ static bool insn_crosses_page(CPUARMState *env,=
 DisasContext *s)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    ARMCPU *cpu =3D arm_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUARMState *env =3D cpu->env_ptr;
+    ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
     DisasContext dc1, *dc =3D &dc1;
     target_ulong pc_start;
     target_ulong next_page_start;
@@ -11804,7 +11804,7 @@ void gen_intermediate_code(CPUARMState *env, Tran=
slationBlock *tb)
      * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
      */
     if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(cpu, tb);
+        gen_intermediate_code_a64(arm_cpu, tb);
         return;
     }
=20
@@ -11814,7 +11814,7 @@ void gen_intermediate_code(CPUARMState *env, Tran=
slationBlock *tb)
=20
     dc->is_jmp =3D DISAS_NEXT;
     dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->singlestep_enabled =3D cpu->singlestep_enabled;
     dc->condjmp =3D 0;
=20
     dc->aarch64 =3D 0;
@@ -11840,7 +11840,7 @@ void gen_intermediate_code(CPUARMState *env, Tran=
slationBlock *tb)
     dc->vec_stride =3D ARM_TBFLAG_VECSTRIDE(tb->flags);
     dc->c15_cpar =3D ARM_TBFLAG_XSCALE_CPAR(tb->flags);
     dc->v7m_handler_mode =3D ARM_TBFLAG_HANDLER(tb->flags);
-    dc->cp_regs =3D cpu->cp_regs;
+    dc->cp_regs =3D arm_cpu->cp_regs;
     dc->features =3D env->features;
=20
     /* Single step state. The code-generation logic here is:
@@ -11941,9 +11941,9 @@ void gen_intermediate_code(CPUARMState *env, Tran=
slationBlock *tb)
         }
 #endif
=20
-        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
+        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
             CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
+            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
                 if (bp->pc =3D=3D dc->pc) {
                     if (bp->flags & BP_CPU) {
                         gen_set_condexec(dc);
@@ -12042,7 +12042,7 @@ void gen_intermediate_code(CPUARMState *env, Tran=
slationBlock *tb)
         if (dc->condjmp) {
             /* FIXME:  This can theoretically happen with self-modifying
                code.  */
-            cpu_abort(cs, "IO on conditional branch instruction");
+            cpu_abort(cpu, "IO on conditional branch instruction");
         }
         gen_io_end();
     }
@@ -12156,7 +12156,7 @@ done_generating:
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start,
+        log_target_disas(cpu, pc_start, dc->pc - pc_start,
                          dc->thumb | (dc->sctlr_b << 1));
         qemu_log("\n");
         qemu_log_unlock();
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0ee05ca02d..35931e7061 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3080,10 +3080,9 @@ static unsigned int crisv32_decoder(CPUCRISState *=
env, DisasContext *dc)
  */
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *t=
b)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    CRISCPU *cpu =3D cris_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUCRISState *env =3D cpu->env_ptr;
     uint32_t pc_start;
     unsigned int insn_len;
     struct DisasContext ctx;
@@ -3105,13 +3104,13 @@ void gen_intermediate_code(CPUCRISState *env, str=
uct TranslationBlock *tb)
      * delayslot, like in real hw.
      */
     pc_start =3D tb->pc & ~1;
-    dc->cpu =3D cpu;
+    dc->cpu =3D cris_env_get_cpu(env);
     dc->tb =3D tb;
=20
     dc->is_jmp =3D DISAS_NEXT;
     dc->ppc =3D pc_start;
     dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->singlestep_enabled =3D cpu->singlestep_enabled;
     dc->flags_uptodate =3D 1;
     dc->flagx_known =3D 1;
     dc->flags_x =3D tb->flags & X_FLAG;
@@ -3151,7 +3150,7 @@ void gen_intermediate_code(CPUCRISState *env, struc=
t TranslationBlock *tb)
                            ? dc->ppc | 1 : dc->pc);
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, dc->pc, BP_ANY))) {
             cris_evaluate_flags(dc);
             tcg_gen_movi_tl(env_pc, dc->pc);
             t_gen_raise_exception(EXCP_DEBUG);
@@ -3225,7 +3224,7 @@ void gen_intermediate_code(CPUCRISState *env, struc=
t TranslationBlock *tb)
=20
         /* If we are rexecuting a branch due to exceptions on
            delay slots don't break.  */
-        if (!(tb->pc & 1) && cs->singlestep_enabled) {
+        if (!(tb->pc & 1) && cpu->singlestep_enabled) {
             break;
         }
     } while (!dc->is_jmp && !dc->cpustate_changed
@@ -3258,7 +3257,7 @@ void gen_intermediate_code(CPUCRISState *env, struc=
t TranslationBlock *tb)
=20
     cris_evaluate_flags(dc);
=20
-    if (unlikely(cs->singlestep_enabled)) {
+    if (unlikely(cpu->singlestep_enabled)) {
         if (dc->is_jmp =3D=3D DISAS_NEXT) {
             tcg_gen_movi_tl(env_pc, npc);
         }
@@ -3293,7 +3292,7 @@ void gen_intermediate_code(CPUCRISState *env, struc=
t TranslationBlock *tb)
         qemu_log_lock();
         qemu_log("--------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start,
+        log_target_disas(cpu, pc_start, dc->pc - pc_start,
                          env->pregs[PR_VR]);
         qemu_log("\nisize=3D%d osize=3D%d\n",
                  dc->pc - pc_start, tcg_op_buf_count());
diff --git a/target/i386/translate.c b/target/i386/translate.c
index ed3b896db4..b94303ff10 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8378,10 +8378,9 @@ void tcg_x86_init(void)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUX86State *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    X86CPU *cpu =3D x86_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUX86State *env =3D cpu->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
     target_ulong pc_ptr;
     uint32_t flags;
@@ -8404,7 +8403,7 @@ void gen_intermediate_code(CPUX86State *env, Transl=
ationBlock *tb)
     dc->cpl =3D (flags >> HF_CPL_SHIFT) & 3;
     dc->iopl =3D (flags >> IOPL_SHIFT) & 3;
     dc->tf =3D (flags >> TF_SHIFT) & 1;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->singlestep_enabled =3D cpu->singlestep_enabled;
     dc->cc_op =3D CC_OP_DYNAMIC;
     dc->cc_op_dirty =3D false;
     dc->cs_base =3D cs_base;
@@ -8426,7 +8425,7 @@ void gen_intermediate_code(CPUX86State *env, Transl=
ationBlock *tb)
     dc->code64 =3D (flags >> HF_CS64_SHIFT) & 1;
 #endif
     dc->flags =3D flags;
-    dc->jmp_opt =3D !(dc->tf || cs->singlestep_enabled ||
+    dc->jmp_opt =3D !(dc->tf || cpu->singlestep_enabled ||
                     (flags & HF_INHIBIT_IRQ_MASK));
     /* Do not optimize repz jumps at all in icount mode, because
        rep movsS instructions are execured with different paths
@@ -8475,7 +8474,7 @@ void gen_intermediate_code(CPUX86State *env, Transl=
ationBlock *tb)
         num_insns++;
=20
         /* If RF is set, suppress an internally generated breakpoint.  *=
/
-        if (unlikely(cpu_breakpoint_test(cs, pc_ptr,
+        if (unlikely(cpu_breakpoint_test(cpu, pc_ptr,
                                          tb->flags & HF_RF_MASK
                                          ? BP_GDB : BP_ANY))) {
             gen_debug(dc, pc_ptr - dc->cs_base);
@@ -8551,7 +8550,7 @@ done_generating:
         else
 #endif
             disas_flags =3D !dc->code32;
-        log_target_disas(cs, pc_start, pc_ptr - pc_start, disas_flags);
+        log_target_disas(cpu, pc_start, pc_ptr - pc_start, disas_flags);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 692882f447..0ac34fc620 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1044,10 +1044,10 @@ static inline void decode(DisasContext *dc, uint3=
2_t ir)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPULM32State *env, struct TranslationBlock *t=
b)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    LM32CPU *cpu =3D lm32_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPULM32State *env =3D cpu->env_ptr;
+    LM32CPU *lm32_cpu =3D lm32_env_get_cpu(env);
     struct DisasContext ctx, *dc =3D &ctx;
     uint32_t pc_start;
     uint32_t next_page_start;
@@ -1055,14 +1055,14 @@ void gen_intermediate_code(CPULM32State *env, str=
uct TranslationBlock *tb)
     int max_insns;
=20
     pc_start =3D tb->pc;
-    dc->features =3D cpu->features;
-    dc->num_breakpoints =3D cpu->num_breakpoints;
-    dc->num_watchpoints =3D cpu->num_watchpoints;
+    dc->features =3D lm32_cpu->features;
+    dc->num_breakpoints =3D lm32_cpu->num_breakpoints;
+    dc->num_watchpoints =3D lm32_cpu->num_watchpoints;
     dc->tb =3D tb;
=20
     dc->is_jmp =3D DISAS_NEXT;
     dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->singlestep_enabled =3D cpu->singlestep_enabled;
=20
     if (pc_start & 3) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -1085,7 +1085,7 @@ void gen_intermediate_code(CPULM32State *env, struc=
t TranslationBlock *tb)
         tcg_gen_insn_start(dc->pc);
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, dc->pc, BP_ANY))) {
             tcg_gen_movi_tl(cpu_pc, dc->pc);
             t_gen_raise_exception(dc, EXCP_DEBUG);
             dc->is_jmp =3D DISAS_UPDATE;
@@ -1108,7 +1108,7 @@ void gen_intermediate_code(CPULM32State *env, struc=
t TranslationBlock *tb)
         dc->pc +=3D 4;
     } while (!dc->is_jmp
          && !tcg_op_buf_full()
-         && !cs->singlestep_enabled
+         && !cpu->singlestep_enabled
          && !singlestep
          && (dc->pc < next_page_start)
          && num_insns < max_insns);
@@ -1117,7 +1117,7 @@ void gen_intermediate_code(CPULM32State *env, struc=
t TranslationBlock *tb)
         gen_io_end();
     }
=20
-    if (unlikely(cs->singlestep_enabled)) {
+    if (unlikely(cpu->singlestep_enabled)) {
         if (dc->is_jmp =3D=3D DISAS_NEXT) {
             tcg_gen_movi_tl(cpu_pc, dc->pc);
         }
@@ -1150,7 +1150,7 @@ void gen_intermediate_code(CPULM32State *env, struc=
t TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("\n");
-        log_target_disas(cs, pc_start, dc->pc - pc_start, 0);
+        log_target_disas(cpu, pc_start, dc->pc - pc_start, 0);
         qemu_log("\nisize=3D%d osize=3D%d\n",
                  dc->pc - pc_start, tcg_op_buf_count());
         qemu_log_unlock();
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ad4d4efb8d..0a3372818c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5039,10 +5039,9 @@ static void disas_m68k_insn(CPUM68KState * env, Di=
sasContext *s)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    M68kCPU *cpu =3D m68k_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUM68KState *env =3D cpu->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
     target_ulong pc_start;
     int pc_offset;
@@ -5059,7 +5058,7 @@ void gen_intermediate_code(CPUM68KState *env, Trans=
lationBlock *tb)
     dc->pc =3D pc_start;
     dc->cc_op =3D CC_OP_DYNAMIC;
     dc->cc_op_synced =3D 1;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->singlestep_enabled =3D cpu->singlestep_enabled;
     dc->fpcr =3D env->fpcr;
     dc->user =3D (env->sr & SR_S) =3D=3D 0;
     dc->done_mac =3D 0;
@@ -5080,7 +5079,7 @@ void gen_intermediate_code(CPUM68KState *env, Trans=
lationBlock *tb)
         tcg_gen_insn_start(dc->pc, dc->cc_op);
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, dc->pc, BP_ANY))) {
             gen_exception(dc, dc->pc, EXCP_DEBUG);
             dc->is_jmp =3D DISAS_JUMP;
             /* The address covered by the breakpoint must be included in
@@ -5098,14 +5097,14 @@ void gen_intermediate_code(CPUM68KState *env, Tra=
nslationBlock *tb)
         dc->insn_pc =3D dc->pc;
 	disas_m68k_insn(env, dc);
     } while (!dc->is_jmp && !tcg_op_buf_full() &&
-             !cs->singlestep_enabled &&
+             !cpu->singlestep_enabled &&
              !singlestep &&
              (pc_offset) < (TARGET_PAGE_SIZE - 32) &&
              num_insns < max_insns);
=20
     if (tb->cflags & CF_LAST_IO)
         gen_io_end();
-    if (unlikely(cs->singlestep_enabled)) {
+    if (unlikely(cpu->singlestep_enabled)) {
         /* Make sure the pc is updated, and raise a debug exception.  */
         if (!dc->is_jmp) {
             update_cc_op(dc);
@@ -5138,7 +5137,7 @@ void gen_intermediate_code(CPUM68KState *env, Trans=
lationBlock *tb)
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start, 0);
+        log_target_disas(cpu, pc_start, dc->pc - pc_start, 0);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
index 0bb609513c..d5f499658d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1594,10 +1594,10 @@ static inline void decode(DisasContext *dc, uint3=
2_t ir)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUMBState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    MicroBlazeCPU *cpu =3D mb_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUMBState *env =3D cpu->env_ptr;
+    MicroBlazeCPU *mb_cpu =3D mb_env_get_cpu(env);
     uint32_t pc_start;
     struct DisasContext ctx;
     struct DisasContext *dc =3D &ctx;
@@ -1607,7 +1607,7 @@ void gen_intermediate_code(CPUMBState *env, struct =
TranslationBlock *tb)
     int max_insns;
=20
     pc_start =3D tb->pc;
-    dc->cpu =3D cpu;
+    dc->cpu =3D mb_cpu;
     dc->tb =3D tb;
     org_flags =3D dc->synced_flags =3D dc->tb_flags =3D tb->flags;
=20
@@ -1618,13 +1618,13 @@ void gen_intermediate_code(CPUMBState *env, struc=
t TranslationBlock *tb)
         dc->jmp =3D JMP_INDIRECT;
     }
     dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->singlestep_enabled =3D cpu->singlestep_enabled;
     dc->cpustate_changed =3D 0;
     dc->abort_at_next_insn =3D 0;
     dc->nr_nops =3D 0;
=20
     if (pc_start & 3) {
-        cpu_abort(cs, "Microblaze: unaligned PC=3D%x\n", pc_start);
+        cpu_abort(cpu, "Microblaze: unaligned PC=3D%x\n", pc_start);
     }
=20
     next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE=
;
@@ -1650,7 +1650,7 @@ void gen_intermediate_code(CPUMBState *env, struct =
TranslationBlock *tb)
         }
 #endif
=20
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, dc->pc, BP_ANY))) {
             t_gen_raise_exception(dc, EXCP_DEBUG);
             dc->is_jmp =3D DISAS_UPDATE;
             /* The address covered by the breakpoint must be included in
@@ -1707,7 +1707,7 @@ void gen_intermediate_code(CPUMBState *env, struct =
TranslationBlock *tb)
                 break;
             }
         }
-        if (cs->singlestep_enabled) {
+        if (cpu->singlestep_enabled) {
             break;
         }
     } while (!dc->is_jmp && !dc->cpustate_changed
@@ -1728,7 +1728,7 @@ void gen_intermediate_code(CPUMBState *env, struct =
TranslationBlock *tb)
=20
     if (tb->cflags & CF_LAST_IO)
         gen_io_end();
-    /* Force an update if the per-tb cpu state has changed.  */
+    /* Force an update if the per-tb mb_cpu state has changed.  */
     if (dc->is_jmp =3D=3D DISAS_NEXT
         && (dc->cpustate_changed || org_flags !=3D dc->tb_flags)) {
         dc->is_jmp =3D DISAS_UPDATE;
@@ -1736,7 +1736,7 @@ void gen_intermediate_code(CPUMBState *env, struct =
TranslationBlock *tb)
     }
     t_sync_flags(dc);
=20
-    if (unlikely(cs->singlestep_enabled)) {
+    if (unlikely(cpu->singlestep_enabled)) {
         TCGv_i32 tmp =3D tcg_const_i32(EXCP_DEBUG);
=20
         if (dc->is_jmp !=3D DISAS_JUMP) {
@@ -1773,7 +1773,7 @@ void gen_intermediate_code(CPUMBState *env, struct =
TranslationBlock *tb)
         qemu_log_lock();
         qemu_log("--------------\n");
 #if DISAS_GNU
-        log_target_disas(cs, pc_start, dc->pc - pc_start, 0);
+        log_target_disas(cpu, pc_start, dc->pc - pc_start, 0);
 #endif
         qemu_log("\nisize=3D%d osize=3D%d\n",
                  dc->pc - pc_start, tcg_op_buf_count());
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 559f8fed89..1f9e02f426 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -19878,10 +19878,9 @@ static void decode_opc(CPUMIPSState *env, DisasC=
ontext *ctx)
     }
 }
=20
-void gen_intermediate_code(CPUMIPSState *env, struct TranslationBlock *t=
b)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    MIPSCPU *cpu =3D mips_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUMIPSState *env =3D cpu->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
     target_ulong next_page_start;
@@ -19894,7 +19893,7 @@ void gen_intermediate_code(CPUMIPSState *env, str=
uct TranslationBlock *tb)
     next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE=
;
     ctx.pc =3D pc_start;
     ctx.saved_pc =3D -1;
-    ctx.singlestep_enabled =3D cs->singlestep_enabled;
+    ctx.singlestep_enabled =3D cpu->singlestep_enabled;
     ctx.insn_flags =3D env->insn_flags;
     ctx.CP0_Config1 =3D env->CP0_Config1;
     ctx.tb =3D tb;
@@ -19941,7 +19940,7 @@ void gen_intermediate_code(CPUMIPSState *env, str=
uct TranslationBlock *tb)
         tcg_gen_insn_start(ctx.pc, ctx.hflags & MIPS_HFLAG_BMASK, ctx.bt=
arget);
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, ctx.pc, BP_ANY))) {
             save_cpu_state(&ctx, 1);
             ctx.bstate =3D BS_BRANCH;
             gen_helper_raise_exception_debug(cpu_env);
@@ -19996,7 +19995,7 @@ void gen_intermediate_code(CPUMIPSState *env, str=
uct TranslationBlock *tb)
            This is what GDB expects and is consistent with what the
            hardware does (e.g. if a delay slot instruction faults, the
            reported PC is the PC of the branch).  */
-        if (cs->singlestep_enabled && (ctx.hflags & MIPS_HFLAG_BMASK) =3D=
=3D 0) {
+        if (cpu->singlestep_enabled && (ctx.hflags & MIPS_HFLAG_BMASK) =3D=
=3D 0) {
             break;
         }
=20
@@ -20017,7 +20016,7 @@ void gen_intermediate_code(CPUMIPSState *env, str=
uct TranslationBlock *tb)
     if (tb->cflags & CF_LAST_IO) {
         gen_io_end();
     }
-    if (cs->singlestep_enabled && ctx.bstate !=3D BS_BRANCH) {
+    if (cpu->singlestep_enabled && ctx.bstate !=3D BS_BRANCH) {
         save_cpu_state(&ctx, ctx.bstate !=3D BS_EXCP);
         gen_helper_raise_exception_debug(cpu_env);
     } else {
@@ -20049,7 +20048,7 @@ done_generating:
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.pc - pc_start, 0);
+        log_target_disas(cpu, pc_start, ctx.pc - pc_start, 0);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 0660b44c08..176063a1de 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -822,10 +822,10 @@ static int decode_opc(MoxieCPU *cpu, DisasContext *=
ctx)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUMoxieState *env, struct TranslationBlock *=
tb)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    MoxieCPU *cpu =3D moxie_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUMoxieState *env =3D cpu->env_ptr;
+    MoxieCPU *moxie_cpu =3D moxie_env_get_cpu(env);
     DisasContext ctx;
     target_ulong pc_start;
     int num_insns, max_insns;
@@ -851,7 +851,7 @@ void gen_intermediate_code(CPUMoxieState *env, struct=
 TranslationBlock *tb)
         tcg_gen_insn_start(ctx.pc);
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, ctx.pc, BP_ANY))) {
             tcg_gen_movi_i32(cpu_pc, ctx.pc);
             gen_helper_debug(cpu_env);
             ctx.bstate =3D BS_EXCP;
@@ -864,12 +864,12 @@ void gen_intermediate_code(CPUMoxieState *env, stru=
ct TranslationBlock *tb)
         }
=20
         ctx.opcode =3D cpu_lduw_code(env, ctx.pc);
-        ctx.pc +=3D decode_opc(cpu, &ctx);
+        ctx.pc +=3D decode_opc(moxie_cpu, &ctx);
=20
         if (num_insns >=3D max_insns) {
             break;
         }
-        if (cs->singlestep_enabled) {
+        if (cpu->singlestep_enabled) {
             break;
         }
         if ((ctx.pc & (TARGET_PAGE_SIZE - 1)) =3D=3D 0) {
@@ -877,7 +877,7 @@ void gen_intermediate_code(CPUMoxieState *env, struct=
 TranslationBlock *tb)
         }
     } while (ctx.bstate =3D=3D BS_NONE && !tcg_op_buf_full());
=20
-    if (cs->singlestep_enabled) {
+    if (cpu->singlestep_enabled) {
         tcg_gen_movi_tl(cpu_pc, ctx.pc);
         gen_helper_debug(cpu_env);
     } else {
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index e49518e893..aaac359d5b 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1518,9 +1518,10 @@ static void disas_openrisc_insn(DisasContext *dc, =
OpenRISCCPU *cpu)
     }
 }
=20
-void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBloc=
k *tb)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    OpenRISCCPU *cpu =3D openrisc_env_get_cpu(env);
+    OpenRISCState *env =3D cpu->env_ptr;
+    OpenRISCCPU *or_cpu =3D openrisc_env_get_cpu(env);
     CPUState *cs =3D CPU(cpu);
     struct DisasContext ctx, *dc =3D &ctx;
     uint32_t pc_start;
@@ -1533,10 +1534,10 @@ void gen_intermediate_code(CPUOpenRISCState *env,=
 struct TranslationBlock *tb)
=20
     dc->is_jmp =3D DISAS_NEXT;
     dc->pc =3D pc_start;
-    dc->mem_idx =3D cpu_mmu_index(&cpu->env, false);
+    dc->mem_idx =3D cpu_mmu_index(&or_cpu->env, false);
     dc->tb_flags =3D tb->flags;
     dc->delayed_branch =3D (dc->tb_flags & TB_FLAGS_DFLAG) !=3D 0;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->singlestep_enabled =3D cpu->singlestep_enabled;
=20
     next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE=
;
     num_insns =3D 0;
@@ -1571,7 +1572,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, s=
truct TranslationBlock *tb)
 			   | (num_insns ? 2 : 0));
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, dc->pc, BP_ANY))) {
             tcg_gen_movi_tl(cpu_pc, dc->pc);
             gen_exception(dc, EXCP_DEBUG);
             dc->is_jmp =3D DISAS_UPDATE;
@@ -1586,7 +1587,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, s=
truct TranslationBlock *tb)
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
             gen_io_start();
         }
-        disas_openrisc_insn(dc, cpu);
+        disas_openrisc_insn(dc, or_cpu);
         dc->pc =3D dc->pc + 4;
=20
         /* delay slot */
@@ -1601,7 +1602,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, s=
truct TranslationBlock *tb)
         }
     } while (!dc->is_jmp
              && !tcg_op_buf_full()
-             && !cs->singlestep_enabled
+             && !cpu->singlestep_enabled
              && !singlestep
              && (dc->pc < next_page_start)
              && num_insns < max_insns);
@@ -1619,7 +1620,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, s=
truct TranslationBlock *tb)
         dc->is_jmp =3D DISAS_UPDATE;
         tcg_gen_movi_tl(cpu_pc, dc->pc);
     }
-    if (unlikely(cs->singlestep_enabled)) {
+    if (unlikely(cpu->singlestep_enabled)) {
         gen_exception(dc, EXCP_DEBUG);
     } else {
         switch (dc->is_jmp) {
@@ -1647,7 +1648,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, s=
truct TranslationBlock *tb)
=20
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        log_target_disas(cs, pc_start, tb->size, 0);
+        log_target_disas(cpu, pc_start, tb->size, 0);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c0cd64d927..9a934117d8 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7203,10 +7203,9 @@ void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
 }
=20
 /***********************************************************************=
******/
-void gen_intermediate_code(CPUPPCState *env, struct TranslationBlock *tb=
)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUPPCState *env =3D cpu->env_ptr;
     DisasContext ctx, *ctxp =3D &ctx;
     opc_handler_t **table, *handler;
     target_ulong pc_start;
@@ -7267,7 +7266,7 @@ void gen_intermediate_code(CPUPPCState *env, struct=
 TranslationBlock *tb)
         ctx.singlestep_enabled =3D 0;
     if ((env->flags & POWERPC_FLAG_BE) && msr_be)
         ctx.singlestep_enabled |=3D CPU_BRANCH_STEP;
-    if (unlikely(cs->singlestep_enabled)) {
+    if (unlikely(cpu->singlestep_enabled)) {
         ctx.singlestep_enabled |=3D GDBSTUB_SINGLE_STEP;
     }
 #if defined (DO_SINGLE_STEP) && 0
@@ -7290,7 +7289,7 @@ void gen_intermediate_code(CPUPPCState *env, struct=
 TranslationBlock *tb)
         tcg_gen_insn_start(ctx.nip);
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, ctx.nip, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, ctx.nip, BP_ANY))) {
             gen_debug_exception(ctxp);
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
@@ -7369,7 +7368,7 @@ void gen_intermediate_code(CPUPPCState *env, struct=
 TranslationBlock *tb)
                      ctx.exception !=3D POWERPC_EXCP_BRANCH)) {
             gen_exception_nip(ctxp, POWERPC_EXCP_TRACE, ctx.nip);
         } else if (unlikely(((ctx.nip & (TARGET_PAGE_SIZE - 1)) =3D=3D 0=
) ||
-                            (cs->singlestep_enabled) ||
+                            (cpu->singlestep_enabled) ||
                             singlestep ||
                             num_insns >=3D max_insns)) {
             /* if we reach a page boundary or are single stepping, stop
@@ -7389,7 +7388,7 @@ void gen_intermediate_code(CPUPPCState *env, struct=
 TranslationBlock *tb)
     if (ctx.exception =3D=3D POWERPC_EXCP_NONE) {
         gen_goto_tb(&ctx, 0, ctx.nip);
     } else if (ctx.exception !=3D POWERPC_EXCP_BRANCH) {
-        if (unlikely(cs->singlestep_enabled)) {
+        if (unlikely(cpu->singlestep_enabled)) {
             gen_debug_exception(ctxp);
         }
         /* Generate the return instruction */
@@ -7408,7 +7407,7 @@ void gen_intermediate_code(CPUPPCState *env, struct=
 TranslationBlock *tb)
         flags |=3D ctx.le_mode << 16;
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.nip - pc_start, flags);
+        log_target_disas(cpu, pc_start, ctx.nip - pc_start, flags);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 8c055b7bb7..684ae4ce2f 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5708,10 +5708,9 @@ static ExitStatus translate_one(CPUS390XState *env=
, DisasContext *s)
     return ret;
 }
=20
-void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *=
tb)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    S390CPU *cpu =3D s390_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUS390XState *env =3D cpu->env_ptr;
     DisasContext dc;
     target_ulong pc_start;
     uint64_t next_page_start;
@@ -5730,7 +5729,7 @@ void gen_intermediate_code(CPUS390XState *env, stru=
ct TranslationBlock *tb)
     dc.pc =3D pc_start;
     dc.cc_op =3D CC_OP_DYNAMIC;
     dc.ex_value =3D tb->cs_base;
-    do_debug =3D dc.singlestep_enabled =3D cs->singlestep_enabled;
+    do_debug =3D dc.singlestep_enabled =3D cpu->singlestep_enabled;
=20
     next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE=
;
=20
@@ -5749,7 +5748,7 @@ void gen_intermediate_code(CPUS390XState *env, stru=
ct TranslationBlock *tb)
         tcg_gen_insn_start(dc.pc, dc.cc_op);
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, dc.pc, BP_ANY))) {
             status =3D EXIT_PC_STALE;
             do_debug =3D true;
             /* The address covered by the breakpoint must be included in
@@ -5773,7 +5772,7 @@ void gen_intermediate_code(CPUS390XState *env, stru=
ct TranslationBlock *tb)
                 || tcg_op_buf_full()
                 || num_insns >=3D max_insns
                 || singlestep
-                || cs->singlestep_enabled
+                || cpu->singlestep_enabled
                 || dc.ex_value)) {
             status =3D EXIT_PC_STALE;
         }
@@ -5823,7 +5822,7 @@ void gen_intermediate_code(CPUS390XState *env, stru=
ct TranslationBlock *tb)
             qemu_log("IN: EXECUTE %016" PRIx64 "\n", dc.ex_value);
         } else {
             qemu_log("IN: %s\n", lookup_symbol(pc_start));
-            log_target_disas(cs, pc_start, dc.pc - pc_start, 1);
+            log_target_disas(cpu, pc_start, dc.pc - pc_start, 1);
             qemu_log("\n");
         }
         qemu_log_unlock();
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8bc132b27b..6a797072d4 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1815,10 +1815,9 @@ static void decode_opc(DisasContext * ctx)
     }
 }
=20
-void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *t=
b)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    SuperHCPU *cpu =3D sh_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUSH4State *env =3D cpu->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
     int num_insns;
@@ -1834,7 +1833,7 @@ void gen_intermediate_code(CPUSH4State * env, struc=
t TranslationBlock *tb)
        so assume it is a dynamic branch.  */
     ctx.delayed_pc =3D -1; /* use delayed pc from env pointer */
     ctx.tb =3D tb;
-    ctx.singlestep_enabled =3D cs->singlestep_enabled;
+    ctx.singlestep_enabled =3D cpu->singlestep_enabled;
     ctx.features =3D env->features;
     ctx.has_movcal =3D (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
=20
@@ -1852,7 +1851,7 @@ void gen_intermediate_code(CPUSH4State * env, struc=
t TranslationBlock *tb)
         tcg_gen_insn_start(ctx.pc, ctx.envflags);
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, ctx.pc, BP_ANY))) {
             /* We have hit a breakpoint - make sure PC is up-to-date */
             gen_save_cpu_state(&ctx, true);
             gen_helper_debug(cpu_env);
@@ -1874,7 +1873,7 @@ void gen_intermediate_code(CPUSH4State * env, struc=
t TranslationBlock *tb)
 	ctx.pc +=3D 2;
 	if ((ctx.pc & (TARGET_PAGE_SIZE - 1)) =3D=3D 0)
 	    break;
-        if (cs->singlestep_enabled) {
+        if (cpu->singlestep_enabled) {
 	    break;
         }
         if (num_insns >=3D max_insns)
@@ -1884,7 +1883,7 @@ void gen_intermediate_code(CPUSH4State * env, struc=
t TranslationBlock *tb)
     }
     if (tb->cflags & CF_LAST_IO)
         gen_io_end();
-    if (cs->singlestep_enabled) {
+    if (cpu->singlestep_enabled) {
         gen_save_cpu_state(&ctx, true);
         gen_helper_debug(cpu_env);
     } else {
@@ -1915,7 +1914,7 @@ void gen_intermediate_code(CPUSH4State * env, struc=
t TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
 	qemu_log("IN:\n");	/* , lookup_symbol(pc_start)); */
-        log_target_disas(cs, pc_start, ctx.pc - pc_start, 0);
+        log_target_disas(cpu, pc_start, ctx.pc - pc_start, 0);
 	qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index aa6734d54e..90c43e4460 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5747,10 +5747,9 @@ static void disas_sparc_insn(DisasContext * dc, un=
signed int insn)
     }
 }
=20
-void gen_intermediate_code(CPUSPARCState * env, TranslationBlock * tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock * tb)
 {
-    SPARCCPU *cpu =3D sparc_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUSPARCState *env =3D cpu->env_ptr;
     target_ulong pc_start, last_pc;
     DisasContext dc1, *dc =3D &dc1;
     int num_insns;
@@ -5768,7 +5767,7 @@ void gen_intermediate_code(CPUSPARCState * env, Tra=
nslationBlock * tb)
     dc->def =3D env->def;
     dc->fpu_enabled =3D tb_fpu_enabled(tb->flags);
     dc->address_mask_32bit =3D tb_am_enabled(tb->flags);
-    dc->singlestep =3D (cs->singlestep_enabled || singlestep);
+    dc->singlestep =3D (cpu->singlestep_enabled || singlestep);
 #ifndef CONFIG_USER_ONLY
     dc->supervisor =3D (tb->flags & TB_FLAG_SUPER) !=3D 0;
 #endif
@@ -5800,7 +5799,7 @@ void gen_intermediate_code(CPUSPARCState * env, Tra=
nslationBlock * tb)
         num_insns++;
         last_pc =3D dc->pc;
=20
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, dc->pc, BP_ANY))) {
             if (dc->pc !=3D pc_start) {
                 save_state(dc);
             }
@@ -5864,7 +5863,7 @@ void gen_intermediate_code(CPUSPARCState * env, Tra=
nslationBlock * tb)
         qemu_log_lock();
         qemu_log("--------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, last_pc + 4 - pc_start, 0);
+        log_target_disas(cpu, pc_start, last_pc + 4 - pc_start, 0);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index ff2ef7b63d..a86e9e9d22 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2370,12 +2370,11 @@ static void translate_one_bundle(DisasContext *dc=
, uint64_t bundle)
     }
 }
=20
-void gen_intermediate_code(CPUTLGState *env, struct TranslationBlock *tb=
)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    TileGXCPU *cpu =3D tilegx_env_get_cpu(env);
+    CPUTLGState *env =3D cpu->env_ptr;
     DisasContext ctx;
     DisasContext *dc =3D &ctx;
-    CPUState *cs =3D CPU(cpu);
     uint64_t pc_start =3D tb->pc;
     uint64_t next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_=
PAGE_SIZE;
     int num_insns =3D 0;
@@ -2397,7 +2396,7 @@ void gen_intermediate_code(CPUTLGState *env, struct=
 TranslationBlock *tb)
     if (!max_insns) {
         max_insns =3D CF_COUNT_MASK;
     }
-    if (cs->singlestep_enabled || singlestep) {
+    if (cpu->singlestep_enabled || singlestep) {
         max_insns =3D 1;
     }
     if (max_insns > TCG_MAX_INSNS) {
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ddd2dd07dd..1930da2f2a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8782,10 +8782,9 @@ static void decode_opc(CPUTriCoreState *env, Disas=
Context *ctx, int *is_branch)
     }
 }
=20
-void gen_intermediate_code(CPUTriCoreState *env, struct TranslationBlock=
 *tb)
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    TriCoreCPU *cpu =3D tricore_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUTriCoreState *env =3D cpu->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
     int num_insns, max_insns;
@@ -8806,7 +8805,7 @@ void gen_intermediate_code(CPUTriCoreState *env, st=
ruct TranslationBlock *tb)
     ctx.pc =3D pc_start;
     ctx.saved_pc =3D -1;
     ctx.tb =3D tb;
-    ctx.singlestep_enabled =3D cs->singlestep_enabled;
+    ctx.singlestep_enabled =3D cpu->singlestep_enabled;
     ctx.bstate =3D BS_NONE;
     ctx.mem_idx =3D cpu_mmu_index(env, false);
=20
@@ -8840,7 +8839,7 @@ void gen_intermediate_code(CPUTriCoreState *env, st=
ruct TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.pc - pc_start, 0);
+        log_target_disas(cpu, pc_start, ctx.pc - pc_start, 0);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 666a2016a8..494ed58c10 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1869,10 +1869,9 @@ static void disas_uc32_insn(CPUUniCore32State *env=
, DisasContext *s)
 }
=20
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUUniCore32State *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    UniCore32CPU *cpu =3D uc32_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUUniCore32State *env =3D cpu->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
     target_ulong pc_start;
     uint32_t next_page_start;
@@ -1888,7 +1887,7 @@ void gen_intermediate_code(CPUUniCore32State *env, =
TranslationBlock *tb)
=20
     dc->is_jmp =3D DISAS_NEXT;
     dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->singlestep_enabled =3D cpu->singlestep_enabled;
     dc->condjmp =3D 0;
     cpu_F0s =3D tcg_temp_new_i32();
     cpu_F1s =3D tcg_temp_new_i32();
@@ -1917,7 +1916,7 @@ void gen_intermediate_code(CPUUniCore32State *env, =
TranslationBlock *tb)
         tcg_gen_insn_start(dc->pc);
         num_insns++;
=20
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, dc->pc, BP_ANY))) {
             gen_set_pc_im(dc->pc);
             gen_exception(EXCP_DEBUG);
             dc->is_jmp =3D DISAS_JUMP;
@@ -1949,7 +1948,7 @@ void gen_intermediate_code(CPUUniCore32State *env, =
TranslationBlock *tb)
          * Also stop translation when a page boundary is reached.  This
          * ensures prefetch aborts occur at the right place.  */
     } while (!dc->is_jmp && !tcg_op_buf_full() &&
-             !cs->singlestep_enabled &&
+             !cpu->singlestep_enabled &&
              !singlestep &&
              dc->pc < next_page_start &&
              num_insns < max_insns);
@@ -1958,7 +1957,7 @@ void gen_intermediate_code(CPUUniCore32State *env, =
TranslationBlock *tb)
         if (dc->condjmp) {
             /* FIXME:  This can theoretically happen with self-modifying
                code.  */
-            cpu_abort(cs, "IO on conditional branch instruction");
+            cpu_abort(cpu, "IO on conditional branch instruction");
         }
         gen_io_end();
     }
@@ -1966,7 +1965,7 @@ void gen_intermediate_code(CPUUniCore32State *env, =
TranslationBlock *tb)
     /* At this stage dc->condjmp will only be set when the skipped
        instruction was a conditional branch or trap, and the PC has
        already been written.  */
-    if (unlikely(cs->singlestep_enabled)) {
+    if (unlikely(cpu->singlestep_enabled)) {
         /* Make sure the pc is updated, and raise a debug exception.  */
         if (dc->condjmp) {
             if (dc->is_jmp =3D=3D DISAS_SYSCALL) {
@@ -2027,7 +2026,7 @@ done_generating:
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start, 0);
+        log_target_disas(cpu, pc_start, dc->pc - pc_start, 0);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 263002486c..63e4f25c08 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -3117,10 +3117,9 @@ static void gen_ibreak_check(CPUXtensaState *env, =
DisasContext *dc)
     }
 }
=20
-void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    XtensaCPU *cpu =3D xtensa_env_get_cpu(env);
-    CPUState *cs =3D CPU(cpu);
+    CPUXtensaState *env =3D cpu->env_ptr;
     DisasContext dc;
     int insn_count =3D 0;
     int max_insns =3D tb->cflags & CF_COUNT_MASK;
@@ -3136,7 +3135,7 @@ void gen_intermediate_code(CPUXtensaState *env, Tra=
nslationBlock *tb)
     }
=20
     dc.config =3D env->config;
-    dc.singlestep_enabled =3D cs->singlestep_enabled;
+    dc.singlestep_enabled =3D cpu->singlestep_enabled;
     dc.tb =3D tb;
     dc.pc =3D pc_start;
     dc.ring =3D tb->flags & XTENSA_TBFLAG_RING_MASK;
@@ -3179,7 +3178,7 @@ void gen_intermediate_code(CPUXtensaState *env, Tra=
nslationBlock *tb)
         tcg_gen_insn_start(dc.pc);
         ++insn_count;
=20
-        if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cpu, dc.pc, BP_ANY))) {
             tcg_gen_movi_i32(cpu_pc, dc.pc);
             gen_exception(&dc, EXCP_DEBUG);
             dc.is_jmp =3D DISAS_UPDATE;
@@ -3215,7 +3214,7 @@ void gen_intermediate_code(CPUXtensaState *env, Tra=
nslationBlock *tb)
         if (dc.icount) {
             tcg_gen_mov_i32(cpu_SR[ICOUNT], dc.next_icount);
         }
-        if (cs->singlestep_enabled) {
+        if (cpu->singlestep_enabled) {
             tcg_gen_movi_i32(cpu_pc, dc.pc);
             gen_exception(&dc, EXCP_DEBUG);
             break;
@@ -3247,7 +3246,7 @@ done:
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc.pc - pc_start, 0);
+        log_target_disas(cpu, pc_start, dc.pc - pc_start, 0);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/translate-all.c b/translate-all.c
index b3ee876526..e5de5cace9 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1292,7 +1292,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_func_start(&tcg_ctx);
=20
     tcg_ctx.cpu =3D ENV_GET_CPU(env);
-    gen_intermediate_code(env, tb);
+    gen_intermediate_code(cpu, tb);
     tcg_ctx.cpu =3D NULL;
=20
     trace_translate_block(tb, tb->pc, tb->tc_ptr);
