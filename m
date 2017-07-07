Received: from eggs.gnu.org ([2001:4830:134:3::10]:41335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTSSN-0001ru-S3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTSSK-00030H-O5
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:33:59 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri,  7 Jul 2017 14:33:37 +0200
Message-Id: <149943081748.8972.7818853386428463912.stgit@frigg.lan>
In-Reply-To: <149942760788.8972.474351671751194003.stgit@frigg.lan>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 13/27] target/arm: [tcg] Port to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c |  119 ++++++++++++++++++++++----------------=
------
 target/arm/translate.c     |  114 +++++++++++++++++++++-----------------=
----
 target/arm/translate.h     |   11 ++--
 3 files changed, 121 insertions(+), 123 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f9bd1a9679..4270ac3847 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -304,7 +304,7 @@ static void gen_exception_internal_insn(DisasContext =
*s, int offset, int excp)
 {
     gen_a64_set_pc_im(s->pc - offset);
     gen_exception_internal(excp);
-    s->is_jmp =3D DISAS_EXC;
+    s->base.is_jmp =3D DISAS_EXC;
 }
=20
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
@@ -312,7 +312,7 @@ static void gen_exception_insn(DisasContext *s, int o=
ffset, int excp,
 {
     gen_a64_set_pc_im(s->pc - offset);
     gen_exception(excp, syndrome, target_el);
-    s->is_jmp =3D DISAS_EXC;
+    s->base.is_jmp =3D DISAS_EXC;
 }
=20
 static void gen_ss_advance(DisasContext *s)
@@ -340,7 +340,7 @@ static void gen_step_complete_exception(DisasContext =
*s)
     gen_ss_advance(s);
     gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
                   default_exception_el(s));
-    s->is_jmp =3D DISAS_EXC;
+    s->base.is_jmp =3D DISAS_EXC;
 }
=20
 static inline bool use_goto_tb(DisasContext *s, int n, uint64_t dest)
@@ -348,13 +348,13 @@ static inline bool use_goto_tb(DisasContext *s, int=
 n, uint64_t dest)
     /* No direct tb linking with singlestep (either QEMU's or the ARM
      * debug architecture kind) or deterministic io
      */
-    if (s->singlestep_enabled || s->ss_active || (s->tb->cflags & CF_LAS=
T_IO)) {
+    if (s->base.singlestep_enabled || s->ss_active || (s->base.tb->cflag=
s & CF_LAST_IO)) {
         return false;
     }
=20
 #ifndef CONFIG_USER_ONLY
     /* Only link tbs from inside the same guest page */
-    if ((s->tb->pc & TARGET_PAGE_MASK) !=3D (dest & TARGET_PAGE_MASK)) {
+    if ((s->base.tb->pc & TARGET_PAGE_MASK) !=3D (dest & TARGET_PAGE_MAS=
K)) {
         return false;
     }
 #endif
@@ -366,21 +366,21 @@ static inline void gen_goto_tb(DisasContext *s, int=
 n, uint64_t dest)
 {
     TranslationBlock *tb;
=20
-    tb =3D s->tb;
+    tb =3D s->base.tb;
     if (use_goto_tb(s, n, dest)) {
         tcg_gen_goto_tb(n);
         gen_a64_set_pc_im(dest);
         tcg_gen_exit_tb((intptr_t)tb + n);
-        s->is_jmp =3D DISAS_TB_JUMP;
+        s->base.is_jmp =3D DISAS_TB_JUMP;
     } else {
         gen_a64_set_pc_im(dest);
         if (s->ss_active) {
             gen_step_complete_exception(s);
-        } else if (s->singlestep_enabled) {
+        } else if (s->base.singlestep_enabled) {
             gen_exception_internal(EXCP_DEBUG);
         } else {
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.is_jmp =3D DISAS_TB_JUMP;
         }
     }
 }
@@ -1331,16 +1331,16 @@ static void handle_hint(DisasContext *s, uint32_t=
 insn,
     case 0: /* NOP */
         return;
     case 3: /* WFI */
-        s->is_jmp =3D DISAS_WFI;
+        s->base.is_jmp =3D DISAS_WFI;
         return;
     case 1: /* YIELD */
         if (!parallel_cpus) {
-            s->is_jmp =3D DISAS_YIELD;
+            s->base.is_jmp =3D DISAS_YIELD;
         }
         return;
     case 2: /* WFE */
         if (!parallel_cpus) {
-            s->is_jmp =3D DISAS_WFE;
+            s->base.is_jmp =3D DISAS_WFE;
         }
         return;
     case 4: /* SEV */
@@ -1393,7 +1393,7 @@ static void handle_sync(DisasContext *s, uint32_t i=
nsn,
          * a self-modified code correctly and also to take
          * any pending interrupts immediately.
          */
-        s->is_jmp =3D DISAS_UPDATE;
+        s->base.is_jmp =3D DISAS_UPDATE;
         return;
     default:
         unallocated_encoding(s);
@@ -1424,7 +1424,7 @@ static void handle_msr_i(DisasContext *s, uint32_t =
insn,
         tcg_temp_free_i32(tcg_op);
         /* For DAIFClear, exit the cpu loop to re-evaluate pending IRQs.=
  */
         gen_a64_set_pc_im(s->pc);
-        s->is_jmp =3D (op =3D=3D 0x1f ? DISAS_EXIT : DISAS_JUMP);
+        s->base.is_jmp =3D (op =3D=3D 0x1f ? DISAS_EXIT : DISAS_JUMP);
         break;
     }
     default:
@@ -1559,7 +1559,7 @@ static void handle_sys(DisasContext *s, uint32_t in=
sn, bool isread,
         break;
     }
=20
-    if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+    if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) =
{
         gen_io_start();
     }
=20
@@ -1590,16 +1590,16 @@ static void handle_sys(DisasContext *s, uint32_t =
insn, bool isread,
         }
     }
=20
-    if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+    if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) =
{
         /* I/O operations must end the TB here (whether read or write) *=
/
         gen_io_end();
-        s->is_jmp =3D DISAS_UPDATE;
+        s->base.is_jmp =3D DISAS_UPDATE;
     } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
-        s->is_jmp =3D DISAS_UPDATE;
+        s->base.is_jmp =3D DISAS_UPDATE;
     }
 }
=20
@@ -1788,7 +1788,7 @@ static void disas_uncond_b_reg(DisasContext *s, uin=
t32_t insn)
             return;
         }
         gen_helper_exception_return(cpu_env);
-        s->is_jmp =3D DISAS_JUMP;
+        s->base.is_jmp =3D DISAS_JUMP;
         return;
     case 5: /* DRPS */
         if (rn !=3D 0x1f) {
@@ -1802,7 +1802,7 @@ static void disas_uncond_b_reg(DisasContext *s, uin=
t32_t insn)
         return;
     }
=20
-    s->is_jmp =3D DISAS_JUMP;
+    s->base.is_jmp =3D DISAS_JUMP;
 }
=20
 /* C3.2 Branches, exception generating and system instructions */
@@ -11190,23 +11190,23 @@ static void disas_a64_insn(CPUARMState *env, Di=
sasContext *s)
     free_tmp_a64(s);
 }
=20
-void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
+void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
+                               TranslationBlock *tb)
 {
     CPUARMState *env =3D cs->env_ptr;
     ARMCPU *cpu =3D arm_env_get_cpu(env);
-    DisasContext dc1, *dc =3D &dc1;
-    target_ulong pc_start;
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
     target_ulong next_page_start;
-    int num_insns;
     int max_insns;
=20
-    pc_start =3D tb->pc;
+    dc->base.tb =3D tb;
+    dc->base.pc_first =3D dc->base.tb->pc;
+    dc->base.pc_next =3D dc->base.pc_first;
+    dc->base.is_jmp =3D DISAS_NEXT;
+    dc->base.num_insns =3D 0;
+    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
=20
-    dc->tb =3D tb;
-
-    dc->is_jmp =3D DISAS_NEXT;
-    dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->pc =3D dc->base.pc_first;
     dc->condjmp =3D 0;
=20
     dc->aarch64 =3D 1;
@@ -11217,17 +11217,17 @@ void gen_intermediate_code_a64(CPUState *cs, Tr=
anslationBlock *tb)
                                !arm_el_is_aa64(env, 3);
     dc->thumb =3D 0;
     dc->sctlr_b =3D 0;
-    dc->be_data =3D ARM_TBFLAG_BE_DATA(tb->flags) ? MO_BE : MO_LE;
+    dc->be_data =3D ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_=
LE;
     dc->condexec_mask =3D 0;
     dc->condexec_cond =3D 0;
-    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(tb->flags=
));
-    dc->tbi0 =3D ARM_TBFLAG_TBI0(tb->flags);
-    dc->tbi1 =3D ARM_TBFLAG_TBI1(tb->flags);
+    dc->mmu_idx =3D core_to_arm_mmu_idx(env, ARM_TBFLAG_MMUIDX(dc->base.=
tb->flags));
+    dc->tbi0 =3D ARM_TBFLAG_TBI0(dc->base.tb->flags);
+    dc->tbi1 =3D ARM_TBFLAG_TBI1(dc->base.tb->flags);
     dc->current_el =3D arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user =3D (dc->current_el =3D=3D 0);
 #endif
-    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(tb->flags);
+    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
     dc->vec_len =3D 0;
     dc->vec_stride =3D 0;
     dc->cp_regs =3D cpu->cp_regs;
@@ -11248,16 +11248,15 @@ void gen_intermediate_code_a64(CPUState *cs, Tr=
anslationBlock *tb)
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(tb->flags);
-    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(tb->flags);
+    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
+    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
     dc->is_ldex =3D false;
     dc->ss_same_el =3D (arm_debug_target_el(env) =3D=3D dc->current_el);
=20
     init_tmp_a64_array(dc);
=20
-    next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE=
;
-    num_insns =3D 0;
-    max_insns =3D tb->cflags & CF_COUNT_MASK;
+    next_page_start =3D (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_=
PAGE_SIZE;
+    max_insns =3D dc->base.tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
         max_insns =3D CF_COUNT_MASK;
     }
@@ -11270,9 +11269,9 @@ void gen_intermediate_code_a64(CPUState *cs, Tran=
slationBlock *tb)
     tcg_clear_temp_count();
=20
     do {
+        dc->base.num_insns++;
         dc->insn_start_idx =3D tcg_op_buf_count();
         tcg_gen_insn_start(dc->pc, 0, 0);
-        num_insns++;
=20
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
@@ -11282,14 +11281,14 @@ void gen_intermediate_code_a64(CPUState *cs, Tr=
anslationBlock *tb)
                         gen_a64_set_pc_im(dc->pc);
                         gen_helper_check_breakpoints(cpu_env);
                         /* End the TB early; it likely won't be executed=
 */
-                        dc->is_jmp =3D DISAS_UPDATE;
+                        dc->base.is_jmp =3D DISAS_UPDATE;
                     } else {
                         gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
                         /* The address covered by the breakpoint must be
-                           included in [tb->pc, tb->pc + tb->size) in or=
der
+                           included in [dc->base.tb->pc, dc->base.tb->pc=
 + dc->base.tb->size) in order
                            to for it to be properly cleared -- thus we
                            increment the PC here so that the logic setti=
ng
-                           tb->size below does the right thing.  */
+                           dc->base.tb->size below does the right thing.=
  */
                         dc->pc +=3D 4;
                         goto done_generating;
                     }
@@ -11298,7 +11297,7 @@ void gen_intermediate_code_a64(CPUState *cs, Tran=
slationBlock *tb)
             }
         }
=20
-        if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (dc->base.num_insns =3D=3D max_insns && (dc->base.tb->cflags =
& CF_LAST_IO)) {
             gen_io_start();
         }
=20
@@ -11313,10 +11312,10 @@ void gen_intermediate_code_a64(CPUState *cs, Tr=
anslationBlock *tb)
              * "did not step an insn" case, and so the syndrome ISV and =
EX
              * bits should be zero.
              */
-            assert(num_insns =3D=3D 1);
+            assert(dc->base.num_insns =3D=3D 1);
             gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                           default_exception_el(dc));
-            dc->is_jmp =3D DISAS_EXC;
+            dc->base.is_jmp =3D DISAS_EXC;
             break;
         }
=20
@@ -11332,26 +11331,26 @@ void gen_intermediate_code_a64(CPUState *cs, Tr=
anslationBlock *tb)
          * Also stop translation when a page boundary is reached.  This
          * ensures prefetch aborts occur at the right place.
          */
-    } while (!dc->is_jmp && !tcg_op_buf_full() &&
+    } while (!dc->base.is_jmp && !tcg_op_buf_full() &&
              !cs->singlestep_enabled &&
              !singlestep &&
              !dc->ss_active &&
              dc->pc < next_page_start &&
-             num_insns < max_insns);
+             dc->base.num_insns < max_insns);
=20
-    if (tb->cflags & CF_LAST_IO) {
+    if (dc->base.tb->cflags & CF_LAST_IO) {
         gen_io_end();
     }
=20
     if (unlikely(cs->singlestep_enabled || dc->ss_active)
-        && dc->is_jmp !=3D DISAS_EXC) {
+        && dc->base.is_jmp !=3D DISAS_EXC) {
         /* Note that this means single stepping WFI doesn't halt the CPU.
          * For conditional branch insns this is harmless unreachable cod=
e as
          * gen_goto_tb() has already handled emitting the debug exceptio=
n
          * (and thus a tb-jump is not possible when singlestepping).
          */
-        assert(dc->is_jmp !=3D DISAS_TB_JUMP);
-        if (dc->is_jmp !=3D DISAS_JUMP) {
+        assert(dc->base.is_jmp !=3D DISAS_TB_JUMP);
+        if (dc->base.is_jmp !=3D DISAS_JUMP) {
             gen_a64_set_pc_im(dc->pc);
         }
         if (cs->singlestep_enabled) {
@@ -11360,7 +11359,7 @@ void gen_intermediate_code_a64(CPUState *cs, Tran=
slationBlock *tb)
             gen_step_complete_exception(dc);
         }
     } else {
-        switch (dc->is_jmp) {
+        switch (dc->base.is_jmp) {
         case DISAS_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
             break;
@@ -11401,20 +11400,20 @@ void gen_intermediate_code_a64(CPUState *cs, Tr=
anslationBlock *tb)
     }
=20
 done_generating:
-    gen_tb_end(tb, num_insns);
+    gen_tb_end(tb, dc->base.num_insns);
=20
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(pc_start)) {
+        qemu_log_in_addr_range(dc->base.pc_first)) {
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start,
+        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+        log_target_disas(cs, dc->base.pc_first, dc->pc - dc->base.pc_fir=
st,
                          4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
         qemu_log("\n");
         qemu_log_unlock();
     }
 #endif
-    tb->size =3D dc->pc - pc_start;
-    tb->icount =3D num_insns;
+    dc->base.tb->size =3D dc->pc - dc->base.pc_first;
+    dc->base.tb->icount =3D dc->base.num_insns;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e80cc357c1..15b4fcb417 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -224,7 +224,7 @@ static void store_reg(DisasContext *s, int reg, TCGv_=
i32 var)
          * We choose to ignore [1:0] in ARM mode for all architecture ve=
rsions.
          */
         tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
-        s->is_jmp =3D DISAS_JUMP;
+        s->base.is_jmp =3D DISAS_JUMP;
     }
     tcg_gen_mov_i32(cpu_R[reg], var);
     tcg_temp_free_i32(var);
@@ -297,7 +297,7 @@ static void gen_step_complete_exception(DisasContext =
*s)
     gen_ss_advance(s);
     gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
                   default_exception_el(s));
-    s->is_jmp =3D DISAS_EXC;
+    s->base.is_jmp =3D DISAS_EXC;
 }
=20
 static void gen_singlestep_exception(DisasContext *s)
@@ -321,7 +321,7 @@ static inline bool is_singlestepping(DisasContext *s)
      * misnamed as it only means "one instruction per TB" and doesn't
      * affect the code we generate.
      */
-    return s->singlestep_enabled || s->ss_active;
+    return s->base.singlestep_enabled || s->ss_active;
 }
=20
 static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
@@ -928,7 +928,7 @@ static inline void gen_bx_im(DisasContext *s, uint32_=
t addr)
 {
     TCGv_i32 tmp;
=20
-    s->is_jmp =3D DISAS_JUMP;
+    s->base.is_jmp =3D DISAS_JUMP;
     if (s->thumb !=3D (addr & 1)) {
         tmp =3D tcg_temp_new_i32();
         tcg_gen_movi_i32(tmp, addr & 1);
@@ -941,7 +941,7 @@ static inline void gen_bx_im(DisasContext *s, uint32_=
t addr)
 /* Set PC and Thumb state from var.  var is marked as dead.  */
 static inline void gen_bx(DisasContext *s, TCGv_i32 var)
 {
-    s->is_jmp =3D DISAS_JUMP;
+    s->base.is_jmp =3D DISAS_JUMP;
     tcg_gen_andi_i32(cpu_R[15], var, ~1);
     tcg_gen_andi_i32(var, var, 1);
     store_cpu_field(var, thumb);
@@ -955,11 +955,11 @@ static inline void gen_bx(DisasContext *s, TCGv_i32=
 var)
 static inline void gen_bx_excret(DisasContext *s, TCGv_i32 var)
 {
     /* Generate the same code here as for a simple bx, but flag via
-     * s->is_jmp that we need to do the rest of the work later.
+     * s->base.is_jmp that we need to do the rest of the work later.
      */
     gen_bx(s, var);
     if (s->v7m_handler_mode && arm_dc_feature(s, ARM_FEATURE_M)) {
-        s->is_jmp =3D DISAS_BX_EXCRET;
+        s->base.is_jmp =3D DISAS_BX_EXCRET;
     }
 }
=20
@@ -1159,7 +1159,7 @@ static inline void gen_hvc(DisasContext *s, int imm=
16)
      */
     s->svc_imm =3D imm16;
     gen_set_pc_im(s, s->pc);
-    s->is_jmp =3D DISAS_HVC;
+    s->base.is_jmp =3D DISAS_HVC;
 }
=20
 static inline void gen_smc(DisasContext *s)
@@ -1174,7 +1174,7 @@ static inline void gen_smc(DisasContext *s)
     gen_helper_pre_smc(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     gen_set_pc_im(s, s->pc);
-    s->is_jmp =3D DISAS_SMC;
+    s->base.is_jmp =3D DISAS_SMC;
 }
=20
 static void gen_exception_internal_insn(DisasContext *s, int offset, int=
 excp)
@@ -1182,7 +1182,7 @@ static void gen_exception_internal_insn(DisasContex=
t *s, int offset, int excp)
     gen_set_condexec(s);
     gen_set_pc_im(s, s->pc - offset);
     gen_exception_internal(excp);
-    s->is_jmp =3D DISAS_EXC;
+    s->base.is_jmp =3D DISAS_EXC;
 }
=20
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
@@ -1191,14 +1191,14 @@ static void gen_exception_insn(DisasContext *s, i=
nt offset, int excp,
     gen_set_condexec(s);
     gen_set_pc_im(s, s->pc - offset);
     gen_exception(excp, syn, target_el);
-    s->is_jmp =3D DISAS_EXC;
+    s->base.is_jmp =3D DISAS_EXC;
 }
=20
 /* Force a TB lookup after an instruction that changes the CPU state.  *=
/
 static inline void gen_lookup_tb(DisasContext *s)
 {
     tcg_gen_movi_i32(cpu_R[15], s->pc & ~1);
-    s->is_jmp =3D DISAS_EXIT;
+    s->base.is_jmp =3D DISAS_EXIT;
 }
=20
 static inline void gen_hlt(DisasContext *s, int imm)
@@ -4143,7 +4143,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t=
 insn)
 static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
 {
 #ifndef CONFIG_USER_ONLY
-    return (s->tb->pc & TARGET_PAGE_MASK) =3D=3D (dest & TARGET_PAGE_MAS=
K) ||
+    return (s->base.tb->pc & TARGET_PAGE_MASK) =3D=3D (dest & TARGET_PAG=
E_MASK) ||
            ((s->pc - 1) & TARGET_PAGE_MASK) =3D=3D (dest & TARGET_PAGE_M=
ASK);
 #else
     return true;
@@ -4163,7 +4163,7 @@ static void gen_goto_tb(DisasContext *s, int n, tar=
get_ulong dest)
     if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(n);
         gen_set_pc_im(s, dest);
-        tcg_gen_exit_tb((uintptr_t)s->tb + n);
+        tcg_gen_exit_tb((uintptr_t)s->base.tb + n);
     } else {
         gen_set_pc_im(s, dest);
         gen_goto_ptr();
@@ -4179,7 +4179,7 @@ static inline void gen_jmp (DisasContext *s, uint32=
_t dest)
         gen_bx_im(s, dest);
     } else {
         gen_goto_tb(s, 0, dest);
-        s->is_jmp =3D DISAS_TB_JUMP;
+        s->base.is_jmp =3D DISAS_TB_JUMP;
     }
 }
=20
@@ -4430,7 +4430,7 @@ static void gen_msr_banked(DisasContext *s, int r, =
int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     tcg_temp_free_i32(tcg_reg);
-    s->is_jmp =3D DISAS_UPDATE;
+    s->base.is_jmp =3D DISAS_UPDATE;
 }
=20
 static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
@@ -4452,7 +4452,7 @@ static void gen_mrs_banked(DisasContext *s, int r, =
int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     store_reg(s, rn, tcg_reg);
-    s->is_jmp =3D DISAS_UPDATE;
+    s->base.is_jmp =3D DISAS_UPDATE;
 }
=20
 /* Store value to PC as for an exception return (ie don't
@@ -4475,7 +4475,7 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, T=
CGv_i32 cpsr)
      */
     gen_helper_cpsr_write_eret(cpu_env, cpsr);
     tcg_temp_free_i32(cpsr);
-    s->is_jmp =3D DISAS_JUMP;
+    s->base.is_jmp =3D DISAS_JUMP;
 }
=20
 /* Generate an old-style exception return. Marks pc as dead. */
@@ -4498,17 +4498,17 @@ static void gen_nop_hint(DisasContext *s, int val=
)
     case 1: /* yield */
         if (!parallel_cpus) {
             gen_set_pc_im(s, s->pc);
-            s->is_jmp =3D DISAS_YIELD;
+            s->base.is_jmp =3D DISAS_YIELD;
         }
         break;
     case 3: /* wfi */
         gen_set_pc_im(s, s->pc);
-        s->is_jmp =3D DISAS_WFI;
+        s->base.is_jmp =3D DISAS_WFI;
         break;
     case 2: /* wfe */
         if (!parallel_cpus) {
             gen_set_pc_im(s, s->pc);
-            s->is_jmp =3D DISAS_WFE;
+            s->base.is_jmp =3D DISAS_WFE;
         }
         break;
     case 4: /* sev */
@@ -7647,13 +7647,13 @@ static int disas_coproc_insn(DisasContext *s, uin=
t32_t insn)
                 return 1;
             }
             gen_set_pc_im(s, s->pc);
-            s->is_jmp =3D DISAS_WFI;
+            s->base.is_jmp =3D DISAS_WFI;
             return 0;
         default:
             break;
         }
=20
-        if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+        if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_I=
O)) {
             gen_io_start();
         }
=20
@@ -7744,7 +7744,7 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
             }
         }
=20
-        if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+        if ((s->base.tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_I=
O)) {
             /* I/O operations must end the TB here (whether read or writ=
e) */
             gen_io_end();
             gen_lookup_tb(s);
@@ -8058,7 +8058,7 @@ static void gen_srs(DisasContext *s,
         tcg_temp_free_i32(tmp);
     }
     tcg_temp_free_i32(addr);
-    s->is_jmp =3D DISAS_UPDATE;
+    s->base.is_jmp =3D DISAS_UPDATE;
 }
=20
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
@@ -8146,7 +8146,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
             /* setend */
             if (((insn >> 9) & 1) !=3D !!(s->be_data =3D=3D MO_BE)) {
                 gen_helper_setend(cpu_env);
-                s->is_jmp =3D DISAS_UPDATE;
+                s->base.is_jmp =3D DISAS_UPDATE;
             }
             return;
         } else if ((insn & 0x0fffff00) =3D=3D 0x057ff000) {
@@ -9519,7 +9519,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
                     tmp =3D load_cpu_field(spsr);
                     gen_helper_cpsr_write_eret(cpu_env, tmp);
                     tcg_temp_free_i32(tmp);
-                    s->is_jmp =3D DISAS_JUMP;
+                    s->base.is_jmp =3D DISAS_JUMP;
                 }
             }
             break;
@@ -9557,7 +9557,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
             /* swi */
             gen_set_pc_im(s, s->pc);
             s->svc_imm =3D extract32(insn, 0, 24);
-            s->is_jmp =3D DISAS_SWI;
+            s->base.is_jmp =3D DISAS_SWI;
             break;
         default:
         illegal_op:
@@ -11619,7 +11619,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
                 ARCH(6);
                 if (((insn >> 3) & 1) !=3D !!(s->be_data =3D=3D MO_BE)) =
{
                     gen_helper_setend(cpu_env);
-                    s->is_jmp =3D DISAS_UPDATE;
+                    s->base.is_jmp =3D DISAS_UPDATE;
                 }
                 break;
             case 3:
@@ -11713,7 +11713,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
             /* swi */
             gen_set_pc_im(s, s->pc);
             s->svc_imm =3D extract32(insn, 0, 8);
-            s->is_jmp =3D DISAS_SWI;
+            s->base.is_jmp =3D DISAS_SWI;
             break;
         }
         /* generate a conditional jump to next instruction */
@@ -11792,9 +11792,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
     CPUARMState *env =3D cs->env_ptr;
     ARMCPU *cpu =3D arm_env_get_cpu(env);
     DisasContext dc1, *dc =3D &dc1;
-    target_ulong pc_start;
     target_ulong next_page_start;
-    int num_insns;
     int max_insns;
     bool end_of_page;
=20
@@ -11804,17 +11802,18 @@ void gen_intermediate_code(CPUState *cs, Transl=
ationBlock *tb)
      * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
      */
     if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(cs, tb);
+        gen_intermediate_code_a64(&dc->base, cs, tb);
         return;
     }
=20
-    pc_start =3D tb->pc;
+    dc->base.tb =3D tb;
+    dc->base.pc_first =3D tb->pc;
+    dc->base.pc_next =3D dc->base.pc_first;
+    dc->base.is_jmp =3D DISAS_NEXT;
+    dc->base.num_insns =3D 0;
+    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
=20
-    dc->tb =3D tb;
-
-    dc->is_jmp =3D DISAS_NEXT;
-    dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->pc =3D dc->base.pc_first;
     dc->condjmp =3D 0;
=20
     dc->aarch64 =3D 0;
@@ -11871,8 +11870,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
     cpu_V1 =3D cpu_F1d;
     /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
     cpu_M0 =3D tcg_temp_new_i64();
-    next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE=
;
-    num_insns =3D 0;
+    next_page_start =3D (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_=
PAGE_SIZE;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
         max_insns =3D CF_COUNT_MASK;
@@ -11924,11 +11922,11 @@ void gen_intermediate_code(CPUState *cs, Transl=
ationBlock *tb)
         store_cpu_field(tmp, condexec_bits);
       }
     do {
+        dc->base.num_insns++;
         dc->insn_start_idx =3D tcg_op_buf_count();
         tcg_gen_insn_start(dc->pc,
                            (dc->condexec_cond << 4) | (dc->condexec_mask=
 >> 1),
                            0);
-        num_insns++;
=20
 #ifdef CONFIG_USER_ONLY
         /* Intercept jump to the magic kernel page.  */
@@ -11936,7 +11934,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
             /* We always get here via a jump, so know we are not in a
                conditional execution block.  */
             gen_exception_internal(EXCP_KERNEL_TRAP);
-            dc->is_jmp =3D DISAS_EXC;
+            dc->base.is_jmp =3D DISAS_EXC;
             break;
         }
 #endif
@@ -11950,7 +11948,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
                         gen_set_pc_im(dc, dc->pc);
                         gen_helper_check_breakpoints(cpu_env);
                         /* End the TB early; it's likely not going to be=
 executed */
-                        dc->is_jmp =3D DISAS_UPDATE;
+                        dc->base.is_jmp =3D DISAS_UPDATE;
                     } else {
                         gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
                         /* The address covered by the breakpoint must be
@@ -11968,7 +11966,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
             }
         }
=20
-        if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (dc->base.num_insns =3D=3D max_insns && (tb->cflags & CF_LAST=
_IO)) {
             gen_io_start();
         }
=20
@@ -11983,7 +11981,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
              * "did not step an insn" case, and so the syndrome ISV and =
EX
              * bits should be zero.
              */
-            assert(num_insns =3D=3D 1);
+            assert(dc->base.num_insns =3D=3D 1);
             gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                           default_exception_el(dc));
             goto done_generating;
@@ -12005,7 +12003,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
             disas_arm_insn(dc, insn);
         }
=20
-        if (dc->condjmp && !dc->is_jmp) {
+        if (dc->condjmp && !dc->base.is_jmp) {
             gen_set_label(dc->condlabel);
             dc->condjmp =3D 0;
         }
@@ -12032,11 +12030,11 @@ void gen_intermediate_code(CPUState *cs, Transl=
ationBlock *tb)
         end_of_page =3D (dc->pc >=3D next_page_start) ||
             ((dc->pc >=3D next_page_start - 3) && insn_crosses_page(env,=
 dc));
=20
-    } while (!dc->is_jmp && !tcg_op_buf_full() &&
+    } while (!dc->base.is_jmp && !tcg_op_buf_full() &&
              !is_singlestepping(dc) &&
              !singlestep &&
              !end_of_page &&
-             num_insns < max_insns);
+             dc->base.num_insns < max_insns);
=20
     if (tb->cflags & CF_LAST_IO) {
         if (dc->condjmp) {
@@ -12051,7 +12049,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
        instruction was a conditional branch or trap, and the PC has
        already been written.  */
     gen_set_condexec(dc);
-    if (dc->is_jmp =3D=3D DISAS_BX_EXCRET) {
+    if (dc->base.is_jmp =3D=3D DISAS_BX_EXCRET) {
         /* Exception return branches need some special case code at the
          * end of the TB, which is complex enough that it has to
          * handle the single-step vs not and the condition-failed
@@ -12060,7 +12058,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
         gen_bx_excret_final_code(dc);
     } else if (unlikely(is_singlestepping(dc))) {
         /* Unconditional and "condition passed" instruction codepath. */
-        switch (dc->is_jmp) {
+        switch (dc->base.is_jmp) {
         case DISAS_SWI:
             gen_ss_advance(dc);
             gen_exception(EXCP_SWI, syn_aa32_svc(dc->svc_imm, dc->thumb)=
,
@@ -12091,7 +12089,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
             - Hardware watchpoints.
            Hardware breakpoints have already been handled and skip this =
code.
          */
-        switch(dc->is_jmp) {
+        switch(dc->base.is_jmp) {
         case DISAS_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
             break;
@@ -12148,22 +12146,22 @@ void gen_intermediate_code(CPUState *cs, Transl=
ationBlock *tb)
     }
=20
 done_generating:
-    gen_tb_end(tb, num_insns);
+    gen_tb_end(tb, dc->base.num_insns);
=20
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(pc_start)) {
+        qemu_log_in_addr_range(dc->base.pc_first)) {
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start,
+        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+        log_target_disas(cs, dc->base.pc_first, dc->pc - dc->base.pc_fir=
st,
                          dc->thumb | (dc->sctlr_b << 1));
         qemu_log("\n");
         qemu_log_unlock();
     }
 #endif
-    tb->size =3D dc->pc - pc_start;
-    tb->icount =3D num_insns;
+    tb->size =3D dc->pc - dc->base.pc_first;
+    tb->icount =3D dc->base.num_insns;
 }
=20
 static const char *cpu_mode_names[16] =3D {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index aba3f44c9f..6fe40a344a 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -6,9 +6,10 @@
=20
 /* internal defines */
 typedef struct DisasContext {
+    DisasContextBase base;
+
     target_ulong pc;
     uint32_t insn;
-    int is_jmp;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
     /* The label that will be jumped to when the instruction is skipped.=
  */
@@ -16,8 +17,6 @@ typedef struct DisasContext {
     /* Thumb-2 conditional execution bits.  */
     int condexec_mask;
     int condexec_cond;
-    struct TranslationBlock *tb;
-    int singlestep_enabled;
     int thumb;
     int sctlr_b;
     TCGMemOp be_data;
@@ -152,7 +151,8 @@ static void disas_set_insn_syndrome(DisasContext *s, =
uint32_t syn)
=20
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
-void gen_intermediate_code_a64(CPUState *cpu, TranslationBlock *tb);
+void gen_intermediate_code_a64(DisasContextBase *db, CPUState *cpu,
+                               TranslationBlock *tb);
 void gen_a64_set_pc_im(uint64_t val);
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
@@ -161,7 +161,8 @@ static inline void a64_translate_init(void)
 {
 }
=20
-static inline void gen_intermediate_code_a64(CPUState *cpu, TranslationB=
lock *tb)
+static inline void gen_intermediate_code_a64(DisasContextBase *db, CPUSt=
ate *cpu,
+                                             TranslationBlock *tb)
 {
 }
=20
