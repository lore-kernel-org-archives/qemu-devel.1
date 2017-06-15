Received: from eggs.gnu.org ([2001:4830:134:3::10]:44178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLct2-000676-IN
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 18:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLcsy-0005Ee-0W
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 18:05:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dLcsx-0005EV-NV
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 18:05:03 -0400
Date: Thu, 15 Jun 2017 18:05:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170615220501.GA26408@flamenco>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149727924970.28532.9346819516051209538.stgit@frigg.lan>
Subject: [Qemu-devel] [PATCH] translator mega-patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Mon, Jun 12, 2017 at 17:54:09 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  include/exec/gen-icount.h             |    2 
>  include/exec/translate-all_template.h |   73 ++++++++++++
>  include/qom/cpu.h                     |   22 ++++
>  translate-all_template.h              |  204 +++++++++++++++++++++++++++++++++

I think this concept of "template" is quite painful.

Find appended something that I find more palatable: it embeds
DisasContextBase in DisasContext, so that we can have a standalone
object with all generic code; target-specific code is called via
an "ops" struct with function pointers that targets fill in.
The target-specific DisasContext struct can then be retrieved from
the base struct with container_of().

I'll send as a separate, proper patch the gen-icount changes; really
having cpu_env there as a global seems wrong to me.

What do you think?

		Emilio

PS. Apply with `git am --scissors'.

--- 8< ---

Warning: INCOMPLETE, do not even think of merging!

This is just to show an alternative approach to including C
code from the target translators (ugh!). Only arm and aarch64
have been converted.

This applies on top of this series:
  https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02833.html

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 Makefile.target            |   2 +-
 include/exec/exec-all.h    |   2 +-
 include/exec/gen-icount.h  |   6 +-
 include/exec/translator.h  |  74 +++++++++++++++++++
 target/arm/translate-a64.c | 130 ++++++++++++++++++----------------
 target/arm/translate.c     | 173 +++++++++++++++++++++++----------------------
 target/arm/translate.h     |  11 +--
 translator.c               | 170 ++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 411 insertions(+), 157 deletions(-)
 create mode 100644 include/exec/translator.h
 create mode 100644 translator.c

diff --git a/Makefile.target b/Makefile.target
index ce8dfe4..ef2d538 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -88,7 +88,7 @@ all: $(PROGS) stap
 
 #########################################################
 # cpu emulator library
-obj-y = exec.o translate-all.o cpu-exec.o
+obj-y = exec.o translate-all.o cpu-exec.o translator.o
 obj-y += translate-common.o
 obj-y += cpu-exec-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 6ad31a8..d376546 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,6 +22,7 @@
 
 #include "qemu-common.h"
 #include "exec/tb-context.h"
+#include "exec/translator.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
 #define DEBUG_DISAS
@@ -37,7 +38,6 @@ typedef ram_addr_t tb_page_addr_t;
 
 /* is_jmp field values */
 /* TODO: delete after all targets are transitioned to generic translation */
-#include "exec/translate-all_template.h"
 #define DISAS_NEXT    DJ_NEXT           /* next instruction can be analyzed */
 #define DISAS_JUMP    (DJ_TARGET + 0)   /* only pc was modified dynamically */
 #define DISAS_UPDATE  (DJ_TARGET + 1)   /* cpu state was modified dynamically */
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
diff --git a/include/exec/translator.h b/include/exec/translator.h
new file mode 100644
index 0000000..f2da424
--- /dev/null
+++ b/include/exec/translator.h
@@ -0,0 +1,74 @@
+#ifndef EXEC_TRANSLATOR_H
+#define EXEC_TRANSLATOR_H
+
+#include "exec/exec-all.h"
+#include "tcg.h"
+
+/**
+ * BreakpointHitType:
+ * @BH_MISS: No hit
+ * @BH_HIT_INSN: Hit, but continue translating instruction
+ * @BH_HIT_TB: Hit, stop translating TB
+ *
+ * How to react to a breakpoint hit.
+ */
+typedef enum BreakpointHitType {
+    BH_MISS,
+    BH_HIT_INSN,
+    BH_HIT_TB,
+} BreakpointHitType;
+
+/**
+ * DisasJumpType:
+ * @DJ_NEXT: Next instruction in program order
+ * @DJ_TOO_MANY: Too many instructions executed
+ * @DJ_TARGET: Start of target-specific conditions
+ *
+ * What instruction to disassemble next.
+ */
+typedef enum DisasJumpType {
+    DJ_NEXT,
+    DJ_TOO_MANY,
+    DJ_TARGET,
+} DisasJumpType;
+
+/**
+ * DisasContextBase:
+ * @tb: Translation block for this disassembly.
+ * @pc_first: Address of first guest instruction in this TB.
+ * @pc_next: Address of next guest instruction in this TB (current during
+ *           disassembly).
+ * @num_insns: Number of translated instructions (including current).
+ * @singlestep_enabled: "Hardware" single stepping enabled.
+ *
+ * Architecture-agnostic disassembly context.
+ */
+typedef struct DisasContextBase {
+    TranslationBlock *tb;
+    target_ulong pc_first;
+    target_ulong pc_next;
+    DisasJumpType jmp_type;
+    unsigned int num_insns;
+    bool singlestep_enabled;
+} DisasContextBase;
+
+/* all void-returning ops are optional, i.e. can be NULL */
+struct translator_ops {
+    void (*init_context)(DisasContextBase *, CPUArchState *);
+    void (*init_globals)(DisasContextBase *, CPUArchState *);
+    void (*tb_start)(DisasContextBase *, CPUArchState *);
+    void (*insn_start)(DisasContextBase *, CPUArchState *);
+    BreakpointHitType (*breakpoint_hit)(DisasContextBase *, CPUArchState *,
+                                        const CPUBreakpoint *);
+    target_ulong (*disas_insn)(DisasContextBase *, CPUArchState *);
+    DisasJumpType (*stop_check)(DisasContextBase *, CPUArchState *);
+    void (*stop)(DisasContextBase *, CPUArchState *);
+    int (*disas_flags)(const DisasContextBase *);
+};
+
+typedef struct translator_ops TranslatorOps;
+
+void translator_gen(const TranslatorOps *tr, DisasContextBase *base,
+                    CPUState *cpu, TranslationBlock *tb, TCGv_env cpu_env);
+
+#endif /* EXEC_TRANSLATOR_H */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 508a016..c486d04 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1561,7 +1561,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     }
 
     if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
 
     tcg_rt = cpu_reg(s, rt);
@@ -1593,7 +1593,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
 
     if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
-        gen_io_end();
+        gen_io_end(cpu_env);
         s->base.jmp_type = DJ_UPDATE;
     } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
@@ -11191,16 +11191,10 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     free_tmp_a64(s);
 }
 
-
-
-/* Use separate top-level templates for each architecture */
-#define gen_intermediate_code gen_intermediate_code_aarch64
-#include "translate-all_template.h"
-#undef gen_intermediate_code
-
-static void gen_intermediate_code_target_init_disas_context(
-    DisasContext *dc, CPUArchState *env)
+static void a64_tr_init_dc(DisasContextBase *base, CPUArchState *env)
 {
+    DisasContext *dc = container_of(base, DisasContext, base);
+
     dc->condjmp = 0;
 
     dc->aarch64 = 1;
@@ -11211,17 +11205,17 @@ static void gen_intermediate_code_target_init_disas_context(
                                !arm_el_is_aa64(env, 3);
     dc->thumb = 0;
     dc->sctlr_b = 0;
-    dc->be_data = ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_LE;
+    dc->be_data = ARM_TBFLAG_BE_DATA(base->tb->flags) ? MO_BE : MO_LE;
     dc->condexec_mask = 0;
     dc->condexec_cond = 0;
-    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(dc->base.tb->flags));
-    dc->tbi0 = ARM_TBFLAG_TBI0(dc->base.tb->flags);
-    dc->tbi1 = ARM_TBFLAG_TBI1(dc->base.tb->flags);
+    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(base->tb->flags));
+    dc->tbi0 = ARM_TBFLAG_TBI0(base->tb->flags);
+    dc->tbi1 = ARM_TBFLAG_TBI1(base->tb->flags);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
-    dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
+    dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(base->tb->flags);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_env_get_cpu(env)->cp_regs;
@@ -11242,43 +11236,35 @@ static void gen_intermediate_code_target_init_disas_context(
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active = ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
-    dc->pstate_ss = ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
+    dc->ss_active = ARM_TBFLAG_SS_ACTIVE(base->tb->flags);
+    dc->pstate_ss = ARM_TBFLAG_PSTATE_SS(base->tb->flags);
     dc->is_ldex = false;
     dc->ss_same_el = (arm_debug_target_el(env) == dc->current_el);
 
     init_tmp_a64_array(dc);
 
     dc->next_page_start =
-        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-}
-
-static void gen_intermediate_code_target_init_globals(
-    DisasContext *dc, CPUArchState *env)
-{
+        (base->pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
 }
 
-static void gen_intermediate_code_target_tb_start(
-    DisasContext *dc, CPUArchState *env)
+static void a64_tr_insn_start(DisasContextBase *base, CPUArchState *env)
 {
-}
+    DisasContext *dc = container_of(base, DisasContext, base);
 
-static void gen_intermediate_code_target_insn_start(
-    DisasContext *dc, CPUArchState *env)
-{
     dc->insn_start_idx = tcg_op_buf_count();
-    tcg_gen_insn_start(dc->base.pc_next, 0, 0);
+    tcg_gen_insn_start(base->pc_next, 0, 0);
 }
 
-static BreakpointHitType gen_intermediate_code_target_breakpoint_hit(
-    DisasContext *dc, CPUArchState *env,
-    const CPUBreakpoint *bp)
+static BreakpointHitType
+a64_tr_bp_hit(DisasContextBase *b, CPUArchState *env, const CPUBreakpoint *bp)
 {
+    DisasContext *dc = container_of(b, DisasContext, base);
+
     if (bp->flags & BP_CPU) {
-        gen_a64_set_pc_im(dc->base.pc_next);
+        gen_a64_set_pc_im(b->pc_next);
         gen_helper_check_breakpoints(cpu_env);
         /* End the TB early; it likely won't be executed */
-        dc->base.jmp_type = DJ_UPDATE;
+        b->jmp_type = DJ_UPDATE;
         return BH_HIT_INSN;
     } else {
         gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
@@ -11287,14 +11273,15 @@ static BreakpointHitType gen_intermediate_code_target_breakpoint_hit(
            to for it to be properly cleared -- thus we
            increment the PC here so that the logic setting
            tb->size below does the right thing.  */
-        dc->base.pc_next += 4;
+        b->pc_next += 4;
         return BH_HIT_TB;
     }
 }
 
-static target_ulong gen_intermediate_code_target_disas_insn(
-    DisasContext *dc, CPUArchState *env)
+static target_ulong a64_tr_disas_insn(DisasContextBase *base, CPUArchState *env)
 {
+    DisasContext *dc = container_of(base, DisasContext, base);
+
     if (dc->ss_active && !dc->pstate_ss) {
         /* Singlestep state is Active-pending.
          * If we're in this state at the start of a TB then either
@@ -11306,19 +11293,21 @@ static target_ulong gen_intermediate_code_target_disas_insn(
          * "did not step an insn" case, and so the syndrome ISV and EX
          * bits should be zero.
          */
-        assert(dc->base.num_insns == 1);
+        assert(base->num_insns == 1);
         gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                       default_exception_el(dc));
-        dc->base.jmp_type = DJ_EXC;
+        base->jmp_type = DJ_EXC;
     } else {
         disas_a64_insn(env, dc);
     }
-    return dc->base.pc_next;
+    return base->pc_next;
 }
 
-static DisasJumpType gen_intermediate_code_target_stop_check(
-    DisasContext *dc, CPUArchState *env)
+static DisasJumpType
+a64_tr_stop_check(DisasContextBase *base, CPUArchState *env)
 {
+    DisasContext *dc = container_of(base, DisasContext, base);
+
     /* Translation stops when a conditional branch is encountered.
      * Otherwise the subsequent code could get translated several times.
      * Also stop translation when a page boundary is reached.  This
@@ -11327,41 +11316,42 @@ static DisasJumpType gen_intermediate_code_target_stop_check(
     if (dc->ss_active) {
         return DJ_SS;
     } else {
-        return dc->base.jmp_type;
+        return base->jmp_type;
     }
 }
 
-static void gen_intermediate_code_target_stop(
-    DisasContext *dc, CPUArchState *env)
+static void a64_tr_stop(DisasContextBase *base, CPUArchState *env)
 {
-    if (unlikely(dc->base.singlestep_enabled || dc->ss_active)
-        && dc->base.jmp_type != DJ_EXC) {
+    DisasContext *dc = container_of(base, DisasContext, base);
+
+    if (unlikely(base->singlestep_enabled || dc->ss_active)
+        && base->jmp_type != DJ_EXC) {
         /* Note that this means single stepping WFI doesn't halt the CPU.
          * For conditional branch insns this is harmless unreachable code as
          * gen_goto_tb() has already handled emitting the debug exception
          * (and thus a tb-jump is not possible when singlestepping).
          */
-        assert(dc->base.jmp_type != DJ_TB_JUMP);
-        if (dc->base.jmp_type != DJ_JUMP) {
-            gen_a64_set_pc_im(dc->base.pc_next);
+        assert(base->jmp_type != DJ_TB_JUMP);
+        if (base->jmp_type != DJ_JUMP) {
+            gen_a64_set_pc_im(base->pc_next);
         }
-        if (dc->base.singlestep_enabled) {
+        if (base->singlestep_enabled) {
             gen_exception_internal(EXCP_DEBUG);
         } else {
             gen_step_complete_exception(dc);
         }
     } else {
         /* Cast because target-specific values are not in generic enum */
-        unsigned int jt = (unsigned int)dc->base.jmp_type;
+        unsigned int jt = (unsigned int)base->jmp_type;
 
         switch (jt) {
         case DJ_NEXT:
         case DJ_TOO_MANY:               /* target set DJ_NEXT */
-            gen_goto_tb(dc, 1, dc->base.pc_next);
+            gen_goto_tb(dc, 1, base->pc_next);
             break;
         default:
         case DJ_UPDATE:
-            gen_a64_set_pc_im(dc->base.pc_next);
+            gen_a64_set_pc_im(base->pc_next);
             /* fall through */
         case DJ_JUMP:
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
@@ -11375,18 +11365,18 @@ static void gen_intermediate_code_target_stop(
             /* nothing to generate */
             break;
         case DJ_WFE:
-            gen_a64_set_pc_im(dc->base.pc_next);
+            gen_a64_set_pc_im(base->pc_next);
             gen_helper_wfe(cpu_env);
             break;
         case DJ_YIELD:
-            gen_a64_set_pc_im(dc->base.pc_next);
+            gen_a64_set_pc_im(base->pc_next);
             gen_helper_yield(cpu_env);
             break;
         case DJ_WFI:
             /* This is a special case because we don't want to just halt the CPU
              * if trying to debug across a WFI.
              */
-            gen_a64_set_pc_im(dc->base.pc_next);
+            gen_a64_set_pc_im(base->pc_next);
             gen_helper_wfi(cpu_env);
             /* The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts anyway.
@@ -11397,8 +11387,26 @@ static void gen_intermediate_code_target_stop(
     }
 }
 
-static int gen_intermediate_code_target_get_disas_flags(
-    const DisasContext *dc)
+static int a64_tr_disas_flags(const DisasContextBase *base)
 {
+    DisasContext *dc = container_of(base, DisasContext, base);
+
     return 4 | (bswap_code(dc->sctlr_b) ? 2 : 0);
 }
+
+static const TranslatorOps a64_tr = {
+    .init_context	= a64_tr_init_dc,
+    .insn_start		= a64_tr_insn_start,
+    .breakpoint_hit	= a64_tr_bp_hit,
+    .disas_insn		= a64_tr_disas_insn,
+    .stop_check		= a64_tr_stop_check,
+    .stop		= a64_tr_stop,
+    .disas_flags	= a64_tr_disas_flags,
+};
+
+void gen_intermediate_code_a64(CPUState *cpu, struct TranslationBlock *tb)
+{
+    DisasContext dc;
+
+    translator_gen(&a64_tr, &dc.base, cpu, tb, cpu_env);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 06f207a..5ea9952 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7655,7 +7655,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
         }
 
         if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
 
         if (isread) {
@@ -7747,7 +7747,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 
         if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             /* I/O operations must end the TB here (whether read or write) */
-            gen_io_end();
+            gen_io_end(cpu_env);
             gen_lookup_tb(s);
         } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
             /* We default to ending the TB on a coprocessor register write,
@@ -11864,31 +11864,10 @@ void restore_state_to_opc(CPUARMState *env, TranslationBlock *tb,
     }
 }
 
-
-
-/* Use separate top-level templates for each architecture */
-#define gen_intermediate_code gen_intermediate_code_arm
-#include "translate-all_template.h"
-#undef gen_intermediate_code
-
-#if !defined(TARGET_AARCH64)
-void gen_intermediate_code_aarch64(CPUState *cpu, struct TranslationBlock *tb)
-{
-}
-#endif
-
-void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
+static void arm_tr_init_dc(DisasContextBase *base, CPUARMState *env)
 {
-    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_aarch64(cpu, tb);
-    } else {
-        gen_intermediate_code_arm(cpu, tb);
-    }
-}
+    DisasContext *dc = container_of(base, DisasContext, base);
 
-static void gen_intermediate_code_target_init_disas_context(
-    DisasContext *dc, CPUARMState *env)
-{
     dc->condjmp = 0;
 
     dc->aarch64 = 0;
@@ -11897,23 +11876,23 @@ static void gen_intermediate_code_target_init_disas_context(
      */
     dc->secure_routed_to_el3 = arm_feature(env, ARM_FEATURE_EL3) &&
         !arm_el_is_aa64(env, 3);
-    dc->thumb = ARM_TBFLAG_THUMB(dc->base.tb->flags);
-    dc->sctlr_b = ARM_TBFLAG_SCTLR_B(dc->base.tb->flags);
-    dc->be_data = ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_LE;
-    dc->condexec_mask = (ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) & 0xf) << 1;
-    dc->condexec_cond = ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) >> 4;
-    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(dc->base.tb->flags));
+    dc->thumb = ARM_TBFLAG_THUMB(base->tb->flags);
+    dc->sctlr_b = ARM_TBFLAG_SCTLR_B(base->tb->flags);
+    dc->be_data = ARM_TBFLAG_BE_DATA(base->tb->flags) ? MO_BE : MO_LE;
+    dc->condexec_mask = (ARM_TBFLAG_CONDEXEC(base->tb->flags) & 0xf) << 1;
+    dc->condexec_cond = ARM_TBFLAG_CONDEXEC(base->tb->flags) >> 4;
+    dc->mmu_idx = core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(base->tb->flags));
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
-    dc->ns = ARM_TBFLAG_NS(dc->base.tb->flags);
-    dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
-    dc->vfp_enabled = ARM_TBFLAG_VFPEN(dc->base.tb->flags);
-    dc->vec_len = ARM_TBFLAG_VECLEN(dc->base.tb->flags);
-    dc->vec_stride = ARM_TBFLAG_VECSTRIDE(dc->base.tb->flags);
-    dc->c15_cpar = ARM_TBFLAG_XSCALE_CPAR(dc->base.tb->flags);
-    dc->v7m_handler_mode = ARM_TBFLAG_HANDLER(dc->base.tb->flags);
+    dc->ns = ARM_TBFLAG_NS(base->tb->flags);
+    dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(base->tb->flags);
+    dc->vfp_enabled = ARM_TBFLAG_VFPEN(base->tb->flags);
+    dc->vec_len = ARM_TBFLAG_VECLEN(base->tb->flags);
+    dc->vec_stride = ARM_TBFLAG_VECSTRIDE(base->tb->flags);
+    dc->c15_cpar = ARM_TBFLAG_XSCALE_CPAR(base->tb->flags);
+    dc->v7m_handler_mode = ARM_TBFLAG_HANDLER(base->tb->flags);
     dc->cp_regs = arm_env_get_cpu(env)->cp_regs;
     dc->features = env->features;
 
@@ -11932,17 +11911,16 @@ static void gen_intermediate_code_target_init_disas_context(
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active = ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
-    dc->pstate_ss = ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
+    dc->ss_active = ARM_TBFLAG_SS_ACTIVE(base->tb->flags);
+    dc->pstate_ss = ARM_TBFLAG_PSTATE_SS(base->tb->flags);
     dc->is_ldex = false;
     dc->ss_same_el = false; /* Can't be true since EL_d must be AArch64 */
 
     dc->next_page_start =
-        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+        (base->pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
 }
 
-static void gen_intermediate_code_target_init_globals(
-    DisasContext *dc, CPUARMState *env)
+static void arm_tr_init_globals(DisasContextBase *base, CPUARMState *env)
 {
     cpu_F0s = tcg_temp_new_i32();
     cpu_F1s = tcg_temp_new_i32();
@@ -11954,8 +11932,7 @@ static void gen_intermediate_code_target_init_globals(
     cpu_M0 = tcg_temp_new_i64();
 }
 
-static void gen_intermediate_code_target_tb_start(
-    DisasContext *dc, CPUARMState *env)
+static void arm_tr_tb_start(DisasContextBase *base, CPUARMState *env)
 {
     /* A note on handling of the condexec (IT) bits:
      *
@@ -11986,6 +11963,7 @@ static void gen_intermediate_code_target_tb_start(
      * we don't need to care about whether CPUARMState is correct in the
      * middle of a TB.
      */
+    DisasContext *dc = container_of(base, DisasContext, base);
 
     /*
      * Reset the conditional execution bits immediately. This avoids
@@ -11998,43 +11976,45 @@ static void gen_intermediate_code_target_tb_start(
     }
 }
 
-static void gen_intermediate_code_target_insn_start(
-    DisasContext *dc, CPUARMState *env)
+static void arm_tr_insn_start(DisasContextBase *base, CPUARMState *env)
 {
+    DisasContext *dc = container_of(base, DisasContext, base);
+
     dc->insn_start_idx = tcg_op_buf_count();
-    tcg_gen_insn_start(dc->base.pc_next,
+    tcg_gen_insn_start(base->pc_next,
                        (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
                        0);
 
 
 #ifdef CONFIG_USER_ONLY
     /* Intercept jump to the magic kernel page.  */
-    if (dc->base.pc_next >= 0xffff0000) {
+    if (base->pc_next >= 0xffff0000) {
         /* We always get here via a jump, so know we are not in a
            conditional execution block.  */
         gen_exception_internal(EXCP_KERNEL_TRAP);
-        dc->base.jmp_type = DJ_EXC;
+        base->jmp_type = DJ_EXC;
     }
 #else
-    if (dc->base.pc_next >= 0xfffffff0 && arm_dc_feature(dc, ARM_FEATURE_M)) {
+    if (base->pc_next >= 0xfffffff0 && arm_dc_feature(dc, ARM_FEATURE_M)) {
         /* We always get here via a jump, so know we are not in a
            conditional execution block.  */
         gen_exception_internal(EXCP_EXCEPTION_EXIT);
-        dc->base.jmp_type = DJ_EXC;
+        base->jmp_type = DJ_EXC;
     }
 #endif
 }
 
-static BreakpointHitType gen_intermediate_code_target_breakpoint_hit(
-    DisasContext *dc, CPUARMState *env,
-    const CPUBreakpoint *bp)
+static BreakpointHitType
+arm_tr_bp_hit(DisasContextBase *base, CPUARMState *env, const CPUBreakpoint *bp)
 {
+    DisasContext *dc = container_of(base, DisasContext, base);
+
     if (bp->flags & BP_CPU) {
         gen_set_condexec(dc);
-        gen_set_pc_im(dc, dc->base.pc_next);
+        gen_set_pc_im(dc, base->pc_next);
         gen_helper_check_breakpoints(cpu_env);
         /* End the TB early; it's likely not going to be executed */
-        dc->base.jmp_type = DJ_UPDATE;
+        base->jmp_type = DJ_UPDATE;
         return BH_HIT_INSN;
     } else {
         gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
@@ -12045,14 +12025,15 @@ static BreakpointHitType gen_intermediate_code_target_breakpoint_hit(
            tb->size below does the right thing.  */
         /* TODO: Advance PC by correct instruction length to avoid
          * disassembler error messages */
-        dc->base.pc_next += 2;
+        base->pc_next += 2;
         return BH_HIT_TB;
     }
 }
 
-static target_ulong gen_intermediate_code_target_disas_insn(
-    DisasContext *dc, CPUArchState *env)
+static target_ulong arm_tr_disas_insn(DisasContextBase *base, CPUArchState *env)
 {
+    DisasContext *dc = container_of(base, DisasContext, base);
+
     if (dc->ss_active && !dc->pstate_ss) {
         /* Singlestep state is Active-pending.
          * If we're in this state at the start of a TB then either
@@ -12064,11 +12045,11 @@ static target_ulong gen_intermediate_code_target_disas_insn(
          * "did not step an insn" case, and so the syndrome ISV and EX
          * bits should be zero.
          */
-        assert(dc->base.num_insns == 1);
+        assert(base->num_insns == 1);
         gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                       default_exception_el(dc));
-        dc->base.jmp_type = DJ_SKIP;
-        return dc->base.pc_next;
+        base->jmp_type = DJ_SKIP;
+        return base->pc_next;
     }
 
     if (dc->thumb) {
@@ -12082,30 +12063,32 @@ static target_ulong gen_intermediate_code_target_disas_insn(
             }
         }
     } else {
-        unsigned int insn = arm_ldl_code(env, dc->base.pc_next, dc->sctlr_b);
-        dc->base.pc_next += 4;
+        unsigned int insn = arm_ldl_code(env, base->pc_next, dc->sctlr_b);
+        base->pc_next += 4;
         disas_arm_insn(dc, insn);
     }
 
-    if (dc->condjmp && !dc->base.jmp_type) {
+    if (dc->condjmp && !base->jmp_type) {
         gen_set_label(dc->condlabel);
         dc->condjmp = 0;
     }
 
-    return dc->base.pc_next;
+    return base->pc_next;
 }
 
-static DisasJumpType gen_intermediate_code_target_stop_check(
-    DisasContext *dc, CPUARMState *env)
+static DisasJumpType arm_tr_stop_check(DisasContextBase *base, CPUARMState *env)
 {
+    DisasContext *dc = container_of(base, DisasContext, base);
+
     /* Translation stops when a conditional branch is encountered.
      * Otherwise the subsequent code could get translated several times.
      * Also stop translation when a page boundary is reached.  This
      * ensures prefetch aborts occur at the right place.  */
 
+    dc = container_of(base, DisasContext, base);
     if (is_singlestepping(dc)) {
         return DJ_SS;
-    } else if ((dc->base.pc_next >= dc->next_page_start - 3)
+    } else if ((base->pc_next >= dc->next_page_start - 3)
                && insn_crosses_page(env, dc)) {
         /*
          * Generic code already checked if the next insn starts in a new
@@ -12122,21 +12105,21 @@ static DisasJumpType gen_intermediate_code_target_stop_check(
          */
         return DJ_PAGE_CROSS;
     } else {
-        return dc->base.jmp_type;
+        return base->jmp_type;
     }
 }
 
-static void gen_intermediate_code_target_stop(
-    DisasContext *dc, CPUARMState *env)
+static void arm_tr_stop(DisasContextBase *base, CPUARMState *env)
 {
+    DisasContext *dc = container_of(base, DisasContext, base);
     /* Cast because target-specific values are not in generic enum */
-    unsigned int jt = (unsigned int)dc->base.jmp_type;
+    unsigned int jt = (unsigned int)base->jmp_type;
 
     if (jt == DJ_SKIP) {
         return;
     }
 
-    if ((dc->base.tb->cflags & CF_LAST_IO) && dc->condjmp) {
+    if ((base->tb->cflags & CF_LAST_IO) && dc->condjmp) {
         /* FIXME: This can theoretically happen with self-modifying code. */
         cpu_abort(ENV_GET_CPU(env), "IO on conditional branch instruction");
     }
@@ -12145,7 +12128,7 @@ static void gen_intermediate_code_target_stop(
        instruction was a conditional branch or trap, and the PC has
        already been written.  */
     gen_set_condexec(dc);
-    if (dc->base.jmp_type == DJ_BX_EXCRET) {
+    if (base->jmp_type == DJ_BX_EXCRET) {
         /* Exception return branches need some special case code at the
          * end of the TB, which is complex enough that it has to
          * handle the single-step vs not and the condition-failed
@@ -12171,7 +12154,7 @@ static void gen_intermediate_code_target_stop(
         case DJ_NEXT:
         case DJ_TOO_MANY:               /* target set DJ_NEXT */
         case DJ_UPDATE:
-            gen_set_pc_im(dc, dc->base.pc_next);
+            gen_set_pc_im(dc, base->pc_next);
             /* fall through */
         default:
             /* FIXME: Single stepping a WFI insn will not halt the CPU. */
@@ -12191,10 +12174,10 @@ static void gen_intermediate_code_target_stop(
         switch (jt) {
         case DJ_NEXT:
         case DJ_TOO_MANY:               /* target set DJ_NEXT */
-            gen_goto_tb(dc, 1, dc->base.pc_next);
+            gen_goto_tb(dc, 1, base->pc_next);
             break;
         case DJ_UPDATE:
-            gen_set_pc_im(dc, dc->base.pc_next);
+            gen_set_pc_im(dc, base->pc_next);
             /* fall through */
         case DJ_JUMP:
             gen_goto_ptr();
@@ -12238,16 +12221,40 @@ static void gen_intermediate_code_target_stop(
         gen_set_label(dc->condlabel);
         gen_set_condexec(dc);
         if (unlikely(is_singlestepping(dc))) {
-            gen_set_pc_im(dc, dc->base.pc_next);
+            gen_set_pc_im(dc, base->pc_next);
             gen_singlestep_exception(dc);
         } else {
-            gen_goto_tb(dc, 1, dc->base.pc_next);
+            gen_goto_tb(dc, 1, base->pc_next);
         }
     }
 }
 
-static int gen_intermediate_code_target_get_disas_flags(
-    const DisasContext *dc)
+static int arm_tr_disas_flags(const DisasContextBase *base)
 {
+    DisasContext *dc = container_of(base, DisasContext, base);
+
     return dc->thumb | (dc->sctlr_b << 1);
 }
+
+static const TranslatorOps arm_tr = {
+    .init_context	= arm_tr_init_dc,
+    .init_globals	= arm_tr_init_globals,
+    .tb_start		= arm_tr_tb_start,
+    .insn_start		= arm_tr_insn_start,
+    .breakpoint_hit	= arm_tr_bp_hit,
+    .disas_insn		= arm_tr_disas_insn,
+    .stop_check		= arm_tr_stop_check,
+    .stop		= arm_tr_stop,
+    .disas_flags	= arm_tr_disas_flags,
+};
+
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
+{
+    DisasContext dc;
+
+    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
+        gen_intermediate_code_a64(cpu, tb);
+    } else {
+        translator_gen(&arm_tr, &dc.base, cpu, tb, cpu_env);
+    }
+}
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 5473994..1aa5d49 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -1,8 +1,7 @@
 #ifndef TARGET_ARM_TRANSLATE_H
 #define TARGET_ARM_TRANSLATE_H
 
-#include "exec/translate-all_template.h"
-
+#include "exec/translator.h"
 
 /* internal defines */
 typedef struct DisasContext {
@@ -122,7 +121,6 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 }
 
 /* Target-specific values for DisasContextBase::jmp_type */
-#include "exec/translate-all_template.h"
 #define DJ_JUMP    (DJ_TARGET + 0)
 #define DJ_UPDATE  (DJ_TARGET + 1)
 #define DJ_TB_JUMP (DJ_TARGET + 2)
@@ -153,13 +151,10 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 #define DJ_PAGE_CROSS (DJ_TARGET + 13)
 #define DJ_SKIP    (DJ_TARGET + 14)
 
-void gen_intermediate_code_arm(CPUState *cpu, struct TranslationBlock *tb);
-void gen_intermediate_code_aarch64(CPUState *cpu, struct TranslationBlock *tb);
-
 #ifdef TARGET_AARCH64
 void init_tmp_a64_array(DisasContext *s);
 void a64_translate_init(void);
-void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb);
+void gen_intermediate_code_a64(CPUState *cpu, TranslationBlock *tb);
 void gen_a64_set_pc_im(uint64_t val);
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
@@ -172,7 +167,7 @@ static inline void a64_translate_init(void)
 {
 }
 
-static inline void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
+static inline void gen_intermediate_code_a64(CPUState *cpu, TranslationBlock *tb)
 {
 }
 
diff --git a/translator.c b/translator.c
new file mode 100644
index 0000000..2248b52
--- /dev/null
+++ b/translator.c
@@ -0,0 +1,170 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+#include "disas/disas.h"
+#include "cpu.h"
+#include "tcg.h"
+#include "tcg-op.h"
+#include "exec/exec-all.h"
+#include "exec/translator.h"
+#include "exec/gen-icount.h"
+#include "exec/log.h"
+
+static inline void check_tcg(const DisasContextBase *base)
+{
+    if (tcg_check_temp_count()) {
+        error_report("warning: TCG temporary leaks before "TARGET_FMT_lx,
+                     base->pc_next);
+    }
+}
+
+void translator_gen(const TranslatorOps *tr, DisasContextBase *base,
+                    CPUState *cpu, TranslationBlock *tb, TCGv_env cpu_env)
+{
+    CPUArchState *env = cpu->env_ptr;
+    int max_insns;
+
+    /* Initialize DisasContextBase */
+    base->tb = tb;
+    base->singlestep_enabled = cpu->singlestep_enabled;
+    base->pc_first = tb->pc;
+    base->pc_next = base->pc_first;
+    base->jmp_type = DJ_NEXT;
+    base->num_insns = 0;
+    if (tr->init_context) {
+        tr->init_context(base, env);
+    }
+
+    /* Initialize globals */
+    if (tr->init_globals) {
+        tr->init_globals(base, env);
+    }
+    tcg_clear_temp_count();
+
+    /* Instruction counting */
+    max_insns = base->tb->cflags & CF_COUNT_MASK;
+    if (max_insns == 0) {
+        max_insns = CF_COUNT_MASK;
+    }
+    if (max_insns > TCG_MAX_INSNS) {
+        max_insns = TCG_MAX_INSNS;
+    }
+    if (base->singlestep_enabled || singlestep) {
+        max_insns = 1;
+    }
+
+    /* Start translating */
+    gen_tb_start(base->tb, cpu_env);
+    if (tr->tb_start) {
+        tr->tb_start(base, env);
+    }
+
+    while (true) {
+        CPUBreakpoint *bp;
+
+        base->num_insns++;
+        if (tr->insn_start) {
+            tr->insn_start(base, env);
+        }
+
+        /* Early exit before breakpoint checks */
+        if (unlikely(base->jmp_type != DJ_NEXT)) {
+            break;
+        }
+
+        /* Pass breakpoint hits to target for further processing */
+        bp = NULL;
+        do {
+            bp = cpu_breakpoint_get(cpu, base->pc_next, bp);
+            if (unlikely(bp)) {
+                BreakpointHitType bh = tr->breakpoint_hit(base, env, bp);
+                if (bh == BH_HIT_INSN) {
+                    /* Hit, keep translating */
+                    /*
+                     * TODO: if we're never going to have more than one BP in a
+                     *       single address, we can simply use a bool here.
+                     */
+                    break;
+                } else if (bh == BH_HIT_TB) {
+                    goto done_generating;
+                }
+            }
+        } while (bp != NULL);
+
+        /* Accept I/O on last instruction */
+        if (base->num_insns == max_insns &&
+            (base->tb->cflags & CF_LAST_IO)) {
+            gen_io_start(cpu_env);
+        }
+
+        /* Disassemble one instruction */
+        base->pc_next = tr->disas_insn(base, env);
+
+        /**************************************************/
+        /* Conditions to stop translation                 */
+        /**************************************************/
+
+        /* Disassembly already set a stop condition */
+        if (base->jmp_type >= DJ_TARGET) {
+            break;
+        }
+
+        /* Target-specific conditions */
+        base->jmp_type = tr->stop_check(base, env);
+        if (base->jmp_type >= DJ_TARGET) {
+            break;
+        }
+
+        /* Too many instructions */
+        if (tcg_op_buf_full() || base->num_insns >= max_insns) {
+            base->jmp_type = DJ_TOO_MANY;
+            break;
+        }
+
+        /*
+         * Check if next instruction is on next page, which can cause an
+         * exception.
+         *
+         * NOTE: Target-specific code must check a single instruction does not
+         *       cross page boundaries; the first in the TB is always allowed to
+         *       cross pages (never goes through this check).
+         */
+        if ((base->pc_first & TARGET_PAGE_MASK)
+            != (base->pc_next & TARGET_PAGE_MASK)) {
+            base->jmp_type = DJ_TOO_MANY;
+            break;
+        }
+
+        check_tcg(base);
+    }
+
+    if (tr->stop) {
+        tr->stop(base, env);
+    }
+
+    if (base->tb->cflags & CF_LAST_IO) {
+        gen_io_end(cpu_env);
+    }
+
+ done_generating:
+    gen_tb_end(base->tb, base->num_insns);
+
+    check_tcg(base);
+
+#ifdef DEBUG_DISAS
+    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
+        qemu_log_in_addr_range(base->pc_first)) {
+        qemu_log_lock();
+        qemu_log("----------------\n");
+        qemu_log("IN: %s\n", lookup_symbol(base->pc_first));
+        log_target_disas(cpu, base->pc_first,
+                         base->pc_next - base->pc_first,
+                         tr->disas_flags(base));
+        qemu_log("\n");
+        qemu_log_unlock();
+    }
+#endif
+
+    base->tb->size = base->pc_next - base->pc_first;
+    base->tb->icount = base->num_insns;
+}
-- 
2.7.4
