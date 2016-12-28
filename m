Received: from eggs.gnu.org ([2001:4830:134:3::10]:38147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMGPs-0000jJ-Dl
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 10:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMGPm-0004uY-Cl
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 10:45:24 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Dec 2016 16:45:15 +0100
Message-Id: <148293991543.31645.6377546595882975134.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148293987753.31645.8166717498506500137.stgit@fimbulvetr.bsc.es>
References: <148293987753.31645.8166717498506500137.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 6/6] target: [tcg,
 arm] Port to generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target-arm/translate-a64.c |  346 ++++++++++-----------
 target-arm/translate.c     |  720 ++++++++++++++++++++++----------------=
------
 target-arm/translate.h     |   42 ++-
 3 files changed, 555 insertions(+), 553 deletions(-)

diff --git a/target-arm/translate-a64.c b/target-arm/translate-a64.c
index 6dc27a6115..d6f5a65b5a 100644
--- a/target-arm/translate-a64.c
+++ b/target-arm/translate-a64.c
@@ -296,17 +296,17 @@ static void gen_exception(int excp, uint32_t syndro=
me, uint32_t target_el)
=20
 static void gen_exception_internal_insn(DisasContext *s, int offset, int=
 excp)
 {
-    gen_a64_set_pc_im(s->pc - offset);
+    gen_a64_set_pc_im(s->base.pc_next - offset);
     gen_exception_internal(excp);
-    s->is_jmp =3D DISAS_EXC;
+    s->base.jmp_type =3D DJ_EXC;
 }
=20
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
                                uint32_t syndrome, uint32_t target_el)
 {
-    gen_a64_set_pc_im(s->pc - offset);
+    gen_a64_set_pc_im(s->base.pc_next - offset);
     gen_exception(excp, syndrome, target_el);
-    s->is_jmp =3D DISAS_EXC;
+    s->base.jmp_type =3D DJ_EXC;
 }
=20
 static void gen_ss_advance(DisasContext *s)
@@ -334,7 +334,7 @@ static void gen_step_complete_exception(DisasContext =
*s)
     gen_ss_advance(s);
     gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
                   default_exception_el(s));
-    s->is_jmp =3D DISAS_EXC;
+    s->base.jmp_type =3D DJ_EXC;
 }
=20
 static inline bool use_goto_tb(DisasContext *s, int n, uint64_t dest)
@@ -342,13 +342,14 @@ static inline bool use_goto_tb(DisasContext *s, int=
 n, uint64_t dest)
     /* No direct tb linking with singlestep (either QEMU's or the ARM
      * debug architecture kind) or deterministic io
      */
-    if (s->singlestep_enabled || s->ss_active || (s->tb->cflags & CF_LAS=
T_IO)) {
+    if (s->base.singlestep_enabled || s->ss_active ||
+        (s->base.tb->cflags & CF_LAST_IO)) {
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
@@ -360,21 +361,21 @@ static inline void gen_goto_tb(DisasContext *s, int=
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
+        s->base.jmp_type =3D DJ_TB_JUMP;
     } else {
         gen_a64_set_pc_im(dest);
         if (s->ss_active) {
             gen_step_complete_exception(s);
-        } else if (s->singlestep_enabled) {
+        } else if (s->base.singlestep_enabled) {
             gen_exception_internal(EXCP_DEBUG);
         } else {
             tcg_gen_exit_tb(0);
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.jmp_type =3D DJ_TB_JUMP;
         }
     }
 }
@@ -405,11 +406,11 @@ static void unallocated_encoding(DisasContext *s)
         qemu_log_mask(LOG_UNIMP,                                        =
 \
                       "%s:%d: unsupported instruction encoding 0x%08x " =
 \
                       "at pc=3D%016" PRIx64 "\n",                       =
   \
-                      __FILE__, __LINE__, insn, s->pc - 4);             =
 \
+                      __FILE__, __LINE__, insn, s->base.pc_next - 4);   =
 \
         unallocated_encoding(s);                                        =
 \
     } while (0);
=20
-static void init_tmp_a64_array(DisasContext *s)
+void init_tmp_a64_array(DisasContext *s)
 {
 #ifdef CONFIG_DEBUG_TCG
     int i;
@@ -1223,11 +1224,11 @@ static inline AArch64DecodeFn *lookup_disas_fn(co=
nst AArch64DecodeTable *table,
  */
 static void disas_uncond_b_imm(DisasContext *s, uint32_t insn)
 {
-    uint64_t addr =3D s->pc + sextract32(insn, 0, 26) * 4 - 4;
+    uint64_t addr =3D s->base.pc_next + sextract32(insn, 0, 26) * 4 - 4;
=20
     if (insn & (1U << 31)) {
         /* C5.6.26 BL Branch with link */
-        tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
+        tcg_gen_movi_i64(cpu_reg(s, 30), s->base.pc_next);
     }
=20
     /* C5.6.20 B Branch / C5.6.26 BL Branch with link */
@@ -1250,7 +1251,7 @@ static void disas_comp_b_imm(DisasContext *s, uint3=
2_t insn)
     sf =3D extract32(insn, 31, 1);
     op =3D extract32(insn, 24, 1); /* 0: CBZ; 1: CBNZ */
     rt =3D extract32(insn, 0, 5);
-    addr =3D s->pc + sextract32(insn, 5, 19) * 4 - 4;
+    addr =3D s->base.pc_next + sextract32(insn, 5, 19) * 4 - 4;
=20
     tcg_cmp =3D read_cpu_reg(s, rt, sf);
     label_match =3D gen_new_label();
@@ -1258,7 +1259,7 @@ static void disas_comp_b_imm(DisasContext *s, uint3=
2_t insn)
     tcg_gen_brcondi_i64(op ? TCG_COND_NE : TCG_COND_EQ,
                         tcg_cmp, 0, label_match);
=20
-    gen_goto_tb(s, 0, s->pc);
+    gen_goto_tb(s, 0, s->base.pc_next);
     gen_set_label(label_match);
     gen_goto_tb(s, 1, addr);
 }
@@ -1278,7 +1279,7 @@ static void disas_test_b_imm(DisasContext *s, uint3=
2_t insn)
=20
     bit_pos =3D (extract32(insn, 31, 1) << 5) | extract32(insn, 19, 5);
     op =3D extract32(insn, 24, 1); /* 0: TBZ; 1: TBNZ */
-    addr =3D s->pc + sextract32(insn, 5, 14) * 4 - 4;
+    addr =3D s->base.pc_next + sextract32(insn, 5, 14) * 4 - 4;
     rt =3D extract32(insn, 0, 5);
=20
     tcg_cmp =3D tcg_temp_new_i64();
@@ -1287,7 +1288,7 @@ static void disas_test_b_imm(DisasContext *s, uint3=
2_t insn)
     tcg_gen_brcondi_i64(op ? TCG_COND_NE : TCG_COND_EQ,
                         tcg_cmp, 0, label_match);
     tcg_temp_free_i64(tcg_cmp);
-    gen_goto_tb(s, 0, s->pc);
+    gen_goto_tb(s, 0, s->base.pc_next);
     gen_set_label(label_match);
     gen_goto_tb(s, 1, addr);
 }
@@ -1307,14 +1308,14 @@ static void disas_cond_b_imm(DisasContext *s, uin=
t32_t insn)
         unallocated_encoding(s);
         return;
     }
-    addr =3D s->pc + sextract32(insn, 5, 19) * 4 - 4;
+    addr =3D s->base.pc_next + sextract32(insn, 5, 19) * 4 - 4;
     cond =3D extract32(insn, 0, 4);
=20
     if (cond < 0x0e) {
         /* genuinely conditional branches */
         TCGLabel *label_match =3D gen_new_label();
         arm_gen_test_cc(cond, label_match);
-        gen_goto_tb(s, 0, s->pc);
+        gen_goto_tb(s, 0, s->base.pc_next);
         gen_set_label(label_match);
         gen_goto_tb(s, 1, addr);
     } else {
@@ -1338,13 +1339,13 @@ static void handle_hint(DisasContext *s, uint32_t=
 insn,
     case 0: /* NOP */
         return;
     case 3: /* WFI */
-        s->is_jmp =3D DISAS_WFI;
+        s->base.jmp_type =3D DJ_WFI;
         return;
     case 1: /* YIELD */
-        s->is_jmp =3D DISAS_YIELD;
+        s->base.jmp_type =3D DJ_YIELD;
         return;
     case 2: /* WFE */
-        s->is_jmp =3D DISAS_WFE;
+        s->base.jmp_type =3D DJ_WFE;
         return;
     case 4: /* SEV */
     case 5: /* SEVL */
@@ -1396,7 +1397,7 @@ static void handle_sync(DisasContext *s, uint32_t i=
nsn,
          * a self-modified code correctly and also to take
          * any pending interrupts immediately.
          */
-        s->is_jmp =3D DISAS_UPDATE;
+        s->base.jmp_type =3D DJ_UPDATE;
         return;
     default:
         unallocated_encoding(s);
@@ -1421,11 +1422,11 @@ static void handle_msr_i(DisasContext *s, uint32_=
t insn,
     {
         TCGv_i32 tcg_imm =3D tcg_const_i32(crm);
         TCGv_i32 tcg_op =3D tcg_const_i32(op);
-        gen_a64_set_pc_im(s->pc - 4);
+        gen_a64_set_pc_im(s->base.pc_next - 4);
         gen_helper_msr_i_pstate(cpu_env, tcg_op, tcg_imm);
         tcg_temp_free_i32(tcg_imm);
         tcg_temp_free_i32(tcg_op);
-        s->is_jmp =3D DISAS_UPDATE;
+        s->base.jmp_type =3D DJ_UPDATE;
         break;
     }
     default:
@@ -1521,7 +1522,7 @@ static void handle_sys(DisasContext *s, uint32_t in=
sn, bool isread,
         TCGv_i32 tcg_syn, tcg_isread;
         uint32_t syndrome;
=20
-        gen_a64_set_pc_im(s->pc - 4);
+        gen_a64_set_pc_im(s->base.pc_next - 4);
         tmpptr =3D tcg_const_ptr(ri);
         syndrome =3D syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, is=
read);
         tcg_syn =3D tcg_const_i32(syndrome);
@@ -1560,7 +1561,7 @@ static void handle_sys(DisasContext *s, uint32_t in=
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
@@ -1591,16 +1592,16 @@ static void handle_sys(DisasContext *s, uint32_t =
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
+        s->base.jmp_type =3D DJ_UPDATE;
     } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
-        s->is_jmp =3D DISAS_UPDATE;
+        s->base.jmp_type =3D DJ_UPDATE;
     }
 }
=20
@@ -1680,7 +1681,7 @@ static void disas_exc(DisasContext *s, uint32_t ins=
n)
             /* The pre HVC helper handles cases when HVC gets trapped
              * as an undefined insn by runtime configuration.
              */
-            gen_a64_set_pc_im(s->pc - 4);
+            gen_a64_set_pc_im(s->base.pc_next - 4);
             gen_helper_pre_hvc(cpu_env);
             gen_ss_advance(s);
             gen_exception_insn(s, 0, EXCP_HVC, syn_aa64_hvc(imm16), 2);
@@ -1690,7 +1691,7 @@ static void disas_exc(DisasContext *s, uint32_t ins=
n)
                 unallocated_encoding(s);
                 break;
             }
-            gen_a64_set_pc_im(s->pc - 4);
+            gen_a64_set_pc_im(s->base.pc_next - 4);
             tmp =3D tcg_const_i32(syn_aa64_smc(imm16));
             gen_helper_pre_smc(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
@@ -1780,7 +1781,7 @@ static void disas_uncond_b_reg(DisasContext *s, uin=
t32_t insn)
         gen_a64_set_pc(s, cpu_reg(s, rn));
         /* BLR also needs to load return address */
         if (opc =3D=3D 1) {
-            tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
+            tcg_gen_movi_i64(cpu_reg(s, 30), s->base.pc_next);
         }
         break;
     case 4: /* ERET */
@@ -1789,7 +1790,7 @@ static void disas_uncond_b_reg(DisasContext *s, uin=
t32_t insn)
             return;
         }
         gen_helper_exception_return(cpu_env);
-        s->is_jmp =3D DISAS_JUMP;
+        s->base.jmp_type =3D DJ_JUMP;
         return;
     case 5: /* DRPS */
         if (rn !=3D 0x1f) {
@@ -1803,7 +1804,7 @@ static void disas_uncond_b_reg(DisasContext *s, uin=
t32_t insn)
         return;
     }
=20
-    s->is_jmp =3D DISAS_JUMP;
+    s->base.jmp_type =3D DJ_JUMP;
 }
=20
 /* C3.2 Branches, exception generating and system instructions */
@@ -2078,7 +2079,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t =
insn)
=20
     tcg_rt =3D cpu_reg(s, rt);
=20
-    tcg_addr =3D tcg_const_i64((s->pc - 4) + imm);
+    tcg_addr =3D tcg_const_i64((s->base.pc_next - 4) + imm);
     if (is_vector) {
         do_fp_ld(s, rt, tcg_addr, size);
     } else {
@@ -2896,7 +2897,7 @@ static void disas_pc_rel_adr(DisasContext *s, uint3=
2_t insn)
     offset =3D sextract64(insn, 5, 19);
     offset =3D offset << 2 | extract32(insn, 29, 2);
     rd =3D extract32(insn, 0, 5);
-    base =3D s->pc - 4;
+    base =3D s->base.pc_next - 4;
=20
     if (page) {
         /* ADRP (page based) */
@@ -11163,9 +11164,9 @@ static void disas_a64_insn(CPUARMState *env, Disa=
sContext *s)
 {
     uint32_t insn;
=20
-    insn =3D arm_ldl_code(env, s->pc, s->sctlr_b);
+    insn =3D arm_ldl_code(env, s->base.pc_next, s->sctlr_b);
     s->insn =3D insn;
-    s->pc +=3D 4;
+    s->base.pc_next +=3D 4;
=20
     s->fp_access_checked =3D false;
=20
@@ -11202,23 +11203,16 @@ static void disas_a64_insn(CPUARMState *env, Di=
sasContext *s)
     free_tmp_a64(s);
 }
=20
-void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
-{
-    CPUState *cs =3D CPU(cpu);
-    CPUARMState *env =3D &cpu->env;
-    DisasContext dc1, *dc =3D &dc1;
-    target_ulong pc_start;
-    target_ulong next_page_start;
-    int num_insns;
-    int max_insns;
=20
-    pc_start =3D tb->pc;
=20
-    dc->tb =3D tb;
+/* Use separate top-level templates for each architecture */
+#define gen_intermediate_code gen_intermediate_code_aarch64
+#include "translate-all_template.h"
+#undef gen_intermediate_code
=20
-    dc->is_jmp =3D DISAS_NEXT;
-    dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+static void gen_intermediate_code_target_init_disas_context(
+    DisasContext *restrict dc, CPUArchState *restrict env)
+{
     dc->condjmp =3D 0;
=20
     dc->aarch64 =3D 1;
@@ -11229,20 +11223,20 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Tra=
nslationBlock *tb)
                                !arm_el_is_aa64(env, 3);
     dc->thumb =3D 0;
     dc->sctlr_b =3D 0;
-    dc->be_data =3D ARM_TBFLAG_BE_DATA(tb->flags) ? MO_BE : MO_LE;
+    dc->be_data =3D ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_=
LE;
     dc->condexec_mask =3D 0;
     dc->condexec_cond =3D 0;
-    dc->mmu_idx =3D ARM_TBFLAG_MMUIDX(tb->flags);
-    dc->tbi0 =3D ARM_TBFLAG_TBI0(tb->flags);
-    dc->tbi1 =3D ARM_TBFLAG_TBI1(tb->flags);
+    dc->mmu_idx =3D ARM_TBFLAG_MMUIDX(dc->base.tb->flags);
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
-    dc->cp_regs =3D cpu->cp_regs;
+    dc->cp_regs =3D arm_env_get_cpu(env)->cp_regs;
     dc->features =3D env->features;
=20
     /* Single step state. The code-generation logic here is:
@@ -11260,147 +11254,149 @@ void gen_intermediate_code_a64(ARMCPU *cpu, T=
ranslationBlock *tb)
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
-    if (max_insns =3D=3D 0) {
-        max_insns =3D CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns =3D TCG_MAX_INSNS;
-    }
-
-    gen_tb_start(tb);
-
-    tcg_clear_temp_count();
-
-    do {
-        dc->insn_start_idx =3D tcg_op_buf_count();
-        tcg_gen_insn_start(dc->pc, 0, 0);
-        num_insns++;
+    dc->next_page_start =3D
+        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+}
=20
-        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->pc) {
-                    if (bp->flags & BP_CPU) {
-                        gen_a64_set_pc_im(dc->pc);
-                        gen_helper_check_breakpoints(cpu_env);
-                        /* End the TB early; it likely won't be executed=
 */
-                        dc->is_jmp =3D DISAS_UPDATE;
-                    } else {
-                        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
-                        /* The address covered by the breakpoint must be
-                           included in [tb->pc, tb->pc + tb->size) in or=
der
-                           to for it to be properly cleared -- thus we
-                           increment the PC here so that the logic setti=
ng
-                           tb->size below does the right thing.  */
-                        dc->pc +=3D 4;
-                        goto done_generating;
-                    }
-                    break;
-                }
-            }
-        }
+static void gen_intermediate_code_target_init_globals(
+    DisasContext *restrict dc, CPUArchState *restrict env)
+{
+}
=20
-        if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
+static void gen_intermediate_code_target_tb_start(
+    DisasContext *restrict dc, CPUArchState *restrict env)
+{
+}
=20
-        if (dc->ss_active && !dc->pstate_ss) {
-            /* Singlestep state is Active-pending.
-             * If we're in this state at the start of a TB then either
-             *  a) we just took an exception to an EL which is being deb=
ugged
-             *     and this is the first insn in the exception handler
-             *  b) debug exceptions were masked and we just unmasked the=
m
-             *     without changing EL (eg by clearing PSTATE.D)
-             * In either case we're going to take a swstep exception in =
the
-             * "did not step an insn" case, and so the syndrome ISV and =
EX
-             * bits should be zero.
-             */
-            assert(num_insns =3D=3D 1);
-            gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
-                          default_exception_el(dc));
-            dc->is_jmp =3D DISAS_EXC;
-            break;
-        }
+static void gen_intermediate_code_target_insn_start(
+    DisasContext *restrict dc, CPUArchState *restrict env)
+{
+    dc->insn_start_idx =3D tcg_op_buf_count();
+    tcg_gen_insn_start(dc->base.pc_next, 0, 0);
+}
=20
+static BreakpointHitType gen_intermediate_code_target_breakpoint_hit(
+    DisasContext *restrict dc, CPUArchState *restrict env,
+    const CPUBreakpoint *restrict bp)
+{
+    if (bp->flags & BP_CPU) {
+        gen_a64_set_pc_im(dc->base.pc_next);
+        gen_helper_check_breakpoints(cpu_env);
+        /* End the TB early; it likely won't be executed */
+        dc->base.jmp_type =3D DJ_UPDATE;
+        return BH_HIT_INSN;
+    } else {
+        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        /* The address covered by the breakpoint must be
+           included in [tb->pc, tb->pc + tb->size) in order
+           to for it to be properly cleared -- thus we
+           increment the PC here so that the logic setting
+           tb->size below does the right thing.  */
+        dc->base.pc_next +=3D 4;
+        return BH_HIT_TB;
+    }
+}
+
+static target_ulong gen_intermediate_code_target_disas_insn(
+    DisasContext *restrict dc, CPUArchState *restrict env)
+{
+    if (dc->ss_active && !dc->pstate_ss) {
+        /* Singlestep state is Active-pending.
+         * If we're in this state at the start of a TB then either
+         *  a) we just took an exception to an EL which is being debugge=
d
+         *     and this is the first insn in the exception handler
+         *  b) debug exceptions were masked and we just unmasked them
+         *     without changing EL (eg by clearing PSTATE.D)
+         * In either case we're going to take a swstep exception in the
+         * "did not step an insn" case, and so the syndrome ISV and EX
+         * bits should be zero.
+         */
+        assert(dc->base.num_insns =3D=3D 1);
+        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
+                      default_exception_el(dc));
+        dc->base.jmp_type =3D DJ_EXC;
+    } else {
         disas_a64_insn(env, dc);
+    }
+    return dc->base.pc_next;
+}
=20
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
-                    dc->pc);
-        }
-
-        /* Translation stops when a conditional branch is encountered.
-         * Otherwise the subsequent code could get translated several ti=
mes.
-         * Also stop translation when a page boundary is reached.  This
-         * ensures prefetch aborts occur at the right place.
-         */
-    } while (!dc->is_jmp && !tcg_op_buf_full() &&
-             !cs->singlestep_enabled &&
-             !singlestep &&
-             !dc->ss_active &&
-             dc->pc < next_page_start &&
-             num_insns < max_insns);
-
-    if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+static DisasJumpType gen_intermediate_code_target_stop_check(
+    DisasContext *restrict dc, CPUArchState *restrict env)
+{
+    /* Translation stops when a conditional branch is encountered.
+     * Otherwise the subsequent code could get translated several times.
+     * Also stop translation when a page boundary is reached.  This
+     * ensures prefetch aborts occur at the right place.
+     */
+    if (dc->ss_active) {
+        return DJ_SS;
+    } else {
+        return dc->base.jmp_type;
     }
+}
=20
-    if (unlikely(cs->singlestep_enabled || dc->ss_active)
-        && dc->is_jmp !=3D DISAS_EXC) {
+static void gen_intermediate_code_target_stop(
+    DisasContext *restrict dc, CPUArchState *restrict env)
+{
+    if (unlikely(dc->base.singlestep_enabled || dc->ss_active)
+        && dc->base.jmp_type !=3D DJ_EXC) {
         /* Note that this means single stepping WFI doesn't halt the CPU.
          * For conditional branch insns this is harmless unreachable cod=
e as
          * gen_goto_tb() has already handled emitting the debug exceptio=
n
          * (and thus a tb-jump is not possible when singlestepping).
          */
-        assert(dc->is_jmp !=3D DISAS_TB_JUMP);
-        if (dc->is_jmp !=3D DISAS_JUMP) {
-            gen_a64_set_pc_im(dc->pc);
+        assert(dc->base.jmp_type !=3D DJ_TB_JUMP);
+        if (dc->base.jmp_type !=3D DJ_JUMP) {
+            gen_a64_set_pc_im(dc->base.pc_next);
         }
-        if (cs->singlestep_enabled) {
+        if (dc->base.singlestep_enabled) {
             gen_exception_internal(EXCP_DEBUG);
         } else {
             gen_step_complete_exception(dc);
         }
     } else {
-        switch (dc->is_jmp) {
-        case DISAS_NEXT:
-            gen_goto_tb(dc, 1, dc->pc);
+        /* Cast because target-specific values are not in generic enum *=
/
+        unsigned int jt =3D (unsigned int)dc->base.jmp_type;
+
+        switch (jt) {
+        case DJ_NEXT:
+        case DJ_TOO_MANY:               /* target set DJ_NEXT */
+            gen_goto_tb(dc, 1, dc->base.pc_next);
             break;
         default:
-        case DISAS_UPDATE:
-            gen_a64_set_pc_im(dc->pc);
+        case DJ_UPDATE:
+            gen_a64_set_pc_im(dc->base.pc_next);
             /* fall through */
-        case DISAS_JUMP:
+        case DJ_JUMP:
             /* indicate that the hash table must be used to find the nex=
t TB */
             tcg_gen_exit_tb(0);
             break;
-        case DISAS_TB_JUMP:
-        case DISAS_EXC:
-        case DISAS_SWI:
+        case DJ_TB_JUMP:
+        case DJ_EXC:
+        case DJ_SWI:
+            /* nothing to generate */
             break;
-        case DISAS_WFE:
-            gen_a64_set_pc_im(dc->pc);
+        case DJ_WFE:
+            gen_a64_set_pc_im(dc->base.pc_next);
             gen_helper_wfe(cpu_env);
             break;
-        case DISAS_YIELD:
-            gen_a64_set_pc_im(dc->pc);
+        case DJ_YIELD:
+            gen_a64_set_pc_im(dc->base.pc_next);
             gen_helper_yield(cpu_env);
             break;
-        case DISAS_WFI:
+        case DJ_WFI:
             /* This is a special case because we don't want to just halt=
 the CPU
              * if trying to debug across a WFI.
              */
-            gen_a64_set_pc_im(dc->pc);
+            gen_a64_set_pc_im(dc->base.pc_next);
             gen_helper_wfi(cpu_env);
             /* The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts any=
way.
@@ -11409,22 +11405,10 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Tra=
nslationBlock *tb)
             break;
         }
     }
+}
=20
-done_generating:
-    gen_tb_end(tb, num_insns);
-
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start,
-                         4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
-    tb->size =3D dc->pc - pc_start;
-    tb->icount =3D num_insns;
+static int gen_intermediate_code_target_get_disas_flags(
+    const DisasContext *dc)
+{
+    return 4 | (bswap_code(dc->sctlr_b) ? 2 : 0);
 }
diff --git a/target-arm/translate.c b/target-arm/translate.c
index 3aa766901c..a489f22e98 100644
--- a/target-arm/translate.c
+++ b/target-arm/translate.c
@@ -149,9 +149,9 @@ static void load_reg_var(DisasContext *s, TCGv_i32 va=
r, int reg)
         uint32_t addr;
         /* normally, since we updated PC, we need only to add one insn *=
/
         if (s->thumb)
-            addr =3D (long)s->pc + 2;
+            addr =3D (long)s->base.pc_next + 2;
         else
-            addr =3D (long)s->pc + 4;
+            addr =3D (long)s->base.pc_next + 4;
         tcg_gen_movi_i32(var, addr);
     } else {
         tcg_gen_mov_i32(var, cpu_R[reg]);
@@ -177,7 +177,7 @@ static void store_reg(DisasContext *s, int reg, TCGv_=
i32 var)
          * We choose to ignore [1:0] in ARM mode for all architecture ve=
rsions.
          */
         tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
-        s->is_jmp =3D DISAS_JUMP;
+        s->base.jmp_type =3D DJ_JUMP;
     }
     tcg_gen_mov_i32(cpu_R[reg], var);
     tcg_temp_free_i32(var);
@@ -250,7 +250,7 @@ static void gen_step_complete_exception(DisasContext =
*s)
     gen_ss_advance(s);
     gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
                   default_exception_el(s));
-    s->is_jmp =3D DISAS_EXC;
+    s->base.jmp_type =3D DJ_EXC;
 }
=20
 static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
@@ -865,7 +865,7 @@ static inline void gen_bx_im(DisasContext *s, uint32_=
t addr)
 {
     TCGv_i32 tmp;
=20
-    s->is_jmp =3D DISAS_JUMP;
+    s->base.jmp_type =3D DJ_JUMP;
     if (s->thumb !=3D (addr & 1)) {
         tmp =3D tcg_temp_new_i32();
         tcg_gen_movi_i32(tmp, addr & 1);
@@ -878,7 +878,7 @@ static inline void gen_bx_im(DisasContext *s, uint32_=
t addr)
 /* Set PC and Thumb state from var.  var is marked as dead.  */
 static inline void gen_bx(DisasContext *s, TCGv_i32 var)
 {
-    s->is_jmp =3D DISAS_JUMP;
+    s->base.jmp_type =3D DJ_JUMP;
     tcg_gen_andi_i32(cpu_R[15], var, ~1);
     tcg_gen_andi_i32(var, var, 1);
     store_cpu_field(var, thumb);
@@ -1031,7 +1031,7 @@ static inline void gen_hvc(DisasContext *s, int imm=
16)
      * as an undefined insn by runtime configuration (ie before
      * the insn really executes).
      */
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->base.pc_next - 4);
     gen_helper_pre_hvc(cpu_env);
     /* Otherwise we will treat this as a real exception which
      * happens after execution of the insn. (The distinction matters
@@ -1039,8 +1039,8 @@ static inline void gen_hvc(DisasContext *s, int imm=
16)
      * for single stepping.)
      */
     s->svc_imm =3D imm16;
-    gen_set_pc_im(s, s->pc);
-    s->is_jmp =3D DISAS_HVC;
+    gen_set_pc_im(s, s->base.pc_next);
+    s->base.jmp_type =3D DJ_HVC;
 }
=20
 static inline void gen_smc(DisasContext *s)
@@ -1050,12 +1050,12 @@ static inline void gen_smc(DisasContext *s)
      */
     TCGv_i32 tmp;
=20
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->base.pc_next - 4);
     tmp =3D tcg_const_i32(syn_aa32_smc());
     gen_helper_pre_smc(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-    gen_set_pc_im(s, s->pc);
-    s->is_jmp =3D DISAS_SMC;
+    gen_set_pc_im(s, s->base.pc_next);
+    s->base.jmp_type =3D DJ_SMC;
 }
=20
 static inline void
@@ -1072,25 +1072,25 @@ gen_set_condexec (DisasContext *s)
 static void gen_exception_internal_insn(DisasContext *s, int offset, int=
 excp)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->base.pc_next - offset);
     gen_exception_internal(excp);
-    s->is_jmp =3D DISAS_JUMP;
+    s->base.jmp_type =3D DJ_JUMP;
 }
=20
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
                                int syn, uint32_t target_el)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - offset);
+    gen_set_pc_im(s, s->base.pc_next - offset);
     gen_exception(excp, syn, target_el);
-    s->is_jmp =3D DISAS_JUMP;
+    s->base.jmp_type =3D DJ_JUMP;
 }
=20
 /* Force a TB lookup after an instruction that changes the CPU state.  *=
/
 static inline void gen_lookup_tb(DisasContext *s)
 {
-    tcg_gen_movi_i32(cpu_R[15], s->pc & ~1);
-    s->is_jmp =3D DISAS_JUMP;
+    tcg_gen_movi_i32(cpu_R[15], s->base.pc_next & ~1);
+    s->base.jmp_type =3D DJ_JUMP;
 }
=20
 static inline void gen_hlt(DisasContext *s, int imm)
@@ -3945,7 +3945,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t=
 insn)
                 if (s->thumb && rn =3D=3D 15) {
                     /* This is actually UNPREDICTABLE */
                     addr =3D tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc & ~2);
+                    tcg_gen_movi_i32(addr, s->base.pc_next & ~2);
                 } else {
                     addr =3D load_reg(s, rn);
                 }
@@ -3984,7 +3984,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t=
 insn)
                 if (s->thumb && rn =3D=3D 15) {
                     /* This is actually UNPREDICTABLE */
                     addr =3D tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc & ~2);
+                    tcg_gen_movi_i32(addr, s->base.pc_next & ~2);
                 } else {
                     addr =3D load_reg(s, rn);
                 }
@@ -4035,8 +4035,9 @@ static int disas_vfp_insn(DisasContext *s, uint32_t=
 insn)
 static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
 {
 #ifndef CONFIG_USER_ONLY
-    return (s->tb->pc & TARGET_PAGE_MASK) =3D=3D (dest & TARGET_PAGE_MAS=
K) ||
-           ((s->pc - 1) & TARGET_PAGE_MASK) =3D=3D (dest & TARGET_PAGE_M=
ASK);
+    return
+        (s->base.tb->pc & TARGET_PAGE_MASK) =3D=3D (dest & TARGET_PAGE_M=
ASK) ||
+        ((s->base.pc_next - 1) & TARGET_PAGE_MASK) =3D=3D (dest & TARGET=
_PAGE_MASK);
 #else
     return true;
 #endif
@@ -4047,7 +4048,7 @@ static inline void gen_goto_tb(DisasContext *s, int=
 n, target_ulong dest)
     if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(n);
         gen_set_pc_im(s, dest);
-        tcg_gen_exit_tb((uintptr_t)s->tb + n);
+        tcg_gen_exit_tb((uintptr_t)s->base.tb + n);
     } else {
         gen_set_pc_im(s, dest);
         tcg_gen_exit_tb(0);
@@ -4056,14 +4057,14 @@ static inline void gen_goto_tb(DisasContext *s, i=
nt n, target_ulong dest)
=20
 static inline void gen_jmp (DisasContext *s, uint32_t dest)
 {
-    if (unlikely(s->singlestep_enabled || s->ss_active)) {
+    if (unlikely(s->base.singlestep_enabled || s->ss_active)) {
         /* An indirect jump so that we still trigger the debug exception=
.  */
         if (s->thumb)
             dest |=3D 1;
         gen_bx_im(s, dest);
     } else {
         gen_goto_tb(s, 0, dest);
-        s->is_jmp =3D DISAS_TB_JUMP;
+        s->base.jmp_type =3D DJ_TB_JUMP;
     }
 }
=20
@@ -4306,7 +4307,7 @@ static void gen_msr_banked(DisasContext *s, int r, =
int sysm, int rn)
=20
     /* Sync state because msr_banked() can raise exceptions */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->base.pc_next - 4);
     tcg_reg =3D load_reg(s, rn);
     tcg_tgtmode =3D tcg_const_i32(tgtmode);
     tcg_regno =3D tcg_const_i32(regno);
@@ -4314,7 +4315,7 @@ static void gen_msr_banked(DisasContext *s, int r, =
int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     tcg_temp_free_i32(tcg_reg);
-    s->is_jmp =3D DISAS_UPDATE;
+    s->base.jmp_type =3D DJ_UPDATE;
 }
=20
 static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
@@ -4328,7 +4329,7 @@ static void gen_mrs_banked(DisasContext *s, int r, =
int sysm, int rn)
=20
     /* Sync state because mrs_banked() can raise exceptions */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->base.pc_next - 4);
     tcg_reg =3D tcg_temp_new_i32();
     tcg_tgtmode =3D tcg_const_i32(tgtmode);
     tcg_regno =3D tcg_const_i32(regno);
@@ -4336,7 +4337,7 @@ static void gen_mrs_banked(DisasContext *s, int r, =
int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     store_reg(s, rn, tcg_reg);
-    s->is_jmp =3D DISAS_UPDATE;
+    s->base.jmp_type =3D DJ_UPDATE;
 }
=20
 /* Store value to PC as for an exception return (ie don't
@@ -4359,7 +4360,7 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, T=
CGv_i32 cpsr)
      */
     gen_helper_cpsr_write_eret(cpu_env, cpsr);
     tcg_temp_free_i32(cpsr);
-    s->is_jmp =3D DISAS_JUMP;
+    s->base.jmp_type =3D DJ_JUMP;
 }
=20
 /* Generate an old-style exception return. Marks pc as dead. */
@@ -4372,16 +4373,16 @@ static void gen_nop_hint(DisasContext *s, int val=
)
 {
     switch (val) {
     case 1: /* yield */
-        gen_set_pc_im(s, s->pc);
-        s->is_jmp =3D DISAS_YIELD;
+        gen_set_pc_im(s, s->base.pc_next);
+        s->base.jmp_type =3D DJ_YIELD;
         break;
     case 3: /* wfi */
-        gen_set_pc_im(s, s->pc);
-        s->is_jmp =3D DISAS_WFI;
+        gen_set_pc_im(s, s->base.pc_next);
+        s->base.jmp_type =3D DJ_WFI;
         break;
     case 2: /* wfe */
-        gen_set_pc_im(s, s->pc);
-        s->is_jmp =3D DISAS_WFE;
+        gen_set_pc_im(s, s->base.pc_next);
+        s->base.jmp_type =3D DJ_WFE;
         break;
     case 4: /* sev */
     case 5: /* sevl */
@@ -7499,7 +7500,7 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
             }
=20
             gen_set_condexec(s);
-            gen_set_pc_im(s, s->pc - 4);
+            gen_set_pc_im(s, s->base.pc_next - 4);
             tmpptr =3D tcg_const_ptr(ri);
             tcg_syn =3D tcg_const_i32(syndrome);
             tcg_isread =3D tcg_const_i32(isread);
@@ -7518,14 +7519,14 @@ static int disas_coproc_insn(DisasContext *s, uin=
t32_t insn)
             if (isread) {
                 return 1;
             }
-            gen_set_pc_im(s, s->pc);
-            s->is_jmp =3D DISAS_WFI;
+            gen_set_pc_im(s, s->base.pc_next);
+            s->base.jmp_type =3D DJ_WFI;
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
@@ -7616,7 +7617,7 @@ static int disas_coproc_insn(DisasContext *s, uint3=
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
@@ -7880,7 +7881,7 @@ static void gen_srs(DisasContext *s,
     tmp =3D tcg_const_i32(mode);
     /* get_r13_banked() will raise an exception if called from System mo=
de */
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->pc - 4);
+    gen_set_pc_im(s, s->base.pc_next - 4);
     gen_helper_get_r13_banked(addr, cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     switch (amode) {
@@ -7930,7 +7931,7 @@ static void gen_srs(DisasContext *s,
         tcg_temp_free_i32(tmp);
     }
     tcg_temp_free_i32(addr);
-    s->is_jmp =3D DISAS_UPDATE;
+    s->base.jmp_type =3D DJ_UPDATE;
 }
=20
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
@@ -8014,7 +8015,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
             /* setend */
             if (((insn >> 9) & 1) !=3D !!(s->be_data =3D=3D MO_BE)) {
                 gen_helper_setend(cpu_env);
-                s->is_jmp =3D DISAS_UPDATE;
+                s->base.jmp_type =3D DJ_UPDATE;
             }
             return;
         } else if ((insn & 0x0fffff00) =3D=3D 0x057ff000) {
@@ -8088,7 +8089,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
             /* branch link and change to thumb (blx <offset>) */
             int32_t offset;
=20
-            val =3D (uint32_t)s->pc;
+            val =3D (uint32_t)s->base.pc_next;
             tmp =3D tcg_temp_new_i32();
             tcg_gen_movi_i32(tmp, val);
             store_reg(s, 14, tmp);
@@ -8266,7 +8267,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
             /* branch link/exchange thumb (blx) */
             tmp =3D load_reg(s, rm);
             tmp2 =3D tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc);
+            tcg_gen_movi_i32(tmp2, s->base.pc_next);
             store_reg(s, 14, tmp2);
             gen_bx(s, tmp);
             break;
@@ -9319,7 +9320,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
                             /* store */
                             if (i =3D=3D 15) {
                                 /* special case: r15 =3D PC + 8 */
-                                val =3D (long)s->pc + 4;
+                                val =3D (long)s->base.pc_next + 4;
                                 tmp =3D tcg_temp_new_i32();
                                 tcg_gen_movi_i32(tmp, val);
                             } else if (user) {
@@ -9370,7 +9371,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
                     tmp =3D load_cpu_field(spsr);
                     gen_helper_cpsr_write_eret(cpu_env, tmp);
                     tcg_temp_free_i32(tmp);
-                    s->is_jmp =3D DISAS_JUMP;
+                    s->base.jmp_type =3D DJ_JUMP;
                 }
             }
             break;
@@ -9380,7 +9381,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
                 int32_t offset;
=20
                 /* branch (and link) */
-                val =3D (int32_t)s->pc;
+                val =3D (int32_t)s->base.pc_next;
                 if (insn & (1 << 24)) {
                     tmp =3D tcg_temp_new_i32();
                     tcg_gen_movi_i32(tmp, val);
@@ -9406,9 +9407,9 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
             break;
         case 0xf:
             /* swi */
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->svc_imm =3D extract32(insn, 0, 24);
-            s->is_jmp =3D DISAS_SWI;
+            s->base.jmp_type =3D DJ_SWI;
             break;
         default:
         illegal_op:
@@ -9532,7 +9533,7 @@ static int disas_thumb2_insn(CPUARMState *env, Disa=
sContext *s, uint16_t insn_hw
             tcg_gen_andi_i32(tmp, tmp, 0xfffffffc);
=20
             tmp2 =3D tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc | 1);
+            tcg_gen_movi_i32(tmp2, s->base.pc_next | 1);
             store_reg(s, 14, tmp2);
             gen_bx(s, tmp);
             return 0;
@@ -9544,24 +9545,24 @@ static int disas_thumb2_insn(CPUARMState *env, Di=
sasContext *s, uint16_t insn_hw
             tcg_gen_addi_i32(tmp, tmp, offset);
=20
             tmp2 =3D tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc | 1);
+            tcg_gen_movi_i32(tmp2, s->base.pc_next | 1);
             store_reg(s, 14, tmp2);
             gen_bx(s, tmp);
             return 0;
         }
-        if ((s->pc & ~TARGET_PAGE_MASK) =3D=3D 0) {
+        if ((s->base.pc_next & ~TARGET_PAGE_MASK) =3D=3D 0) {
             /* Instruction spans a page boundary.  Implement it as two
                16-bit instructions in case the second half causes an
                prefetch abort.  */
             offset =3D ((int32_t)insn << 21) >> 9;
-            tcg_gen_movi_i32(cpu_R[14], s->pc + 2 + offset);
+            tcg_gen_movi_i32(cpu_R[14], s->base.pc_next + 2 + offset);
             return 0;
         }
         /* Fall through to 32-bit decode.  */
     }
=20
-    insn =3D arm_lduw_code(env, s->pc, s->sctlr_b);
-    s->pc +=3D 2;
+    insn =3D arm_lduw_code(env, s->base.pc_next, s->sctlr_b);
+    s->base.pc_next +=3D 2;
     insn |=3D (uint32_t)insn_hw1 << 16;
=20
     if ((insn & 0xf800e800) !=3D 0xf000e800) {
@@ -9583,7 +9584,7 @@ static int disas_thumb2_insn(CPUARMState *env, Disa=
sContext *s, uint16_t insn_hw
                 /* Load/store doubleword.  */
                 if (rn =3D=3D 15) {
                     addr =3D tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc & ~3);
+                    tcg_gen_movi_i32(addr, s->base.pc_next & ~3);
                 } else {
                     addr =3D load_reg(s, rn);
                 }
@@ -9637,7 +9638,7 @@ static int disas_thumb2_insn(CPUARMState *env, Disa=
sContext *s, uint16_t insn_hw
                 /* Table Branch.  */
                 if (rn =3D=3D 15) {
                     addr =3D tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc);
+                    tcg_gen_movi_i32(addr, s->base.pc_next);
                 } else {
                     addr =3D load_reg(s, rn);
                 }
@@ -9656,7 +9657,7 @@ static int disas_thumb2_insn(CPUARMState *env, Disa=
sContext *s, uint16_t insn_hw
                 }
                 tcg_temp_free_i32(addr);
                 tcg_gen_shli_i32(tmp, tmp, 1);
-                tcg_gen_addi_i32(tmp, tmp, s->pc);
+                tcg_gen_addi_i32(tmp, tmp, s->base.pc_next);
                 store_reg(s, 15, tmp);
             } else {
                 int op2 =3D (insn >> 6) & 0x3;
@@ -10275,10 +10276,10 @@ static int disas_thumb2_insn(CPUARMState *env, =
DisasContext *s, uint16_t insn_hw
=20
                 if (insn & (1 << 14)) {
                     /* Branch and link.  */
-                    tcg_gen_movi_i32(cpu_R[14], s->pc | 1);
+                    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | 1);
                 }
=20
-                offset +=3D s->pc;
+                offset +=3D s->base.pc_next;
                 if (insn & (1 << 12)) {
                     /* b/bl */
                     gen_jmp(s, offset);
@@ -10474,7 +10475,7 @@ static int disas_thumb2_insn(CPUARMState *env, Di=
sasContext *s, uint16_t insn_hw
                 offset |=3D (insn & (1 << 11)) << 8;
=20
                 /* jump to the offset */
-                gen_jmp(s, s->pc + offset);
+                gen_jmp(s, s->base.pc_next + offset);
             }
         } else {
             /* Data processing immediate.  */
@@ -10575,7 +10576,7 @@ static int disas_thumb2_insn(CPUARMState *env, Di=
sasContext *s, uint16_t insn_hw
                     } else {
                         /* Add/sub 12-bit immediate.  */
                         if (rn =3D=3D 15) {
-                            offset =3D s->pc & ~(uint32_t)3;
+                            offset =3D s->base.pc_next & ~(uint32_t)3;
                             if (insn & (1 << 23))
                                 offset -=3D imm;
                             else
@@ -10695,8 +10696,8 @@ static int disas_thumb2_insn(CPUARMState *env, Di=
sasContext *s, uint16_t insn_hw
         if (rn =3D=3D 15) {
             addr =3D tcg_temp_new_i32();
             /* PC relative.  */
-            /* s->pc has already been incremented by 4.  */
-            imm =3D s->pc & 0xfffffffc;
+            /* s->base.pc_next has already been incremented by 4.  */
+            imm =3D s->base.pc_next & 0xfffffffc;
             if (insn & (1 << 23))
                 imm +=3D insn & 0xfff;
             else
@@ -10834,8 +10835,8 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
         }
     }
=20
-    insn =3D arm_lduw_code(env, s->pc, s->sctlr_b);
-    s->pc +=3D 2;
+    insn =3D arm_lduw_code(env, s->base.pc_next, s->sctlr_b);
+    s->base.pc_next +=3D 2;
=20
     switch (insn >> 12) {
     case 0: case 1:
@@ -10922,7 +10923,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
         if (insn & (1 << 11)) {
             rd =3D (insn >> 8) & 7;
             /* load pc-relative.  Bit 1 of PC is ignored.  */
-            val =3D s->pc + 2 + ((insn & 0xff) * 4);
+            val =3D s->base.pc_next + 2 + ((insn & 0xff) * 4);
             val &=3D ~(uint32_t)2;
             addr =3D tcg_temp_new_i32();
             tcg_gen_movi_i32(addr, val);
@@ -10960,7 +10961,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
                 tmp =3D load_reg(s, rm);
                 if (insn & (1 << 7)) {
                     ARCH(5);
-                    val =3D (uint32_t)s->pc | 1;
+                    val =3D (uint32_t)s->base.pc_next | 1;
                     tmp2 =3D tcg_temp_new_i32();
                     tcg_gen_movi_i32(tmp2, val);
                     store_reg(s, 14, tmp2);
@@ -11258,7 +11259,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
         } else {
             /* PC. bit 1 is ignored.  */
             tmp =3D tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, (s->pc + 2) & ~(uint32_t)2);
+            tcg_gen_movi_i32(tmp, (s->base.pc_next + 2) & ~(uint32_t)2);
         }
         val =3D (insn & 0xff) * 4;
         tcg_gen_addi_i32(tmp, tmp, val);
@@ -11361,7 +11362,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
                 tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, s->condlabel);
             tcg_temp_free_i32(tmp);
             offset =3D ((insn & 0xf8) >> 2) | (insn & 0x200) >> 3;
-            val =3D (uint32_t)s->pc + 2;
+            val =3D (uint32_t)s->base.pc_next + 2;
             val +=3D offset;
             gen_jmp(s, val);
             break;
@@ -11421,7 +11422,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
                 ARCH(6);
                 if (((insn >> 3) & 1) !=3D !!(s->be_data =3D=3D MO_BE)) =
{
                     gen_helper_setend(cpu_env);
-                    s->is_jmp =3D DISAS_UPDATE;
+                    s->base.jmp_type =3D DJ_UPDATE;
                 }
                 break;
             case 3:
@@ -11513,9 +11514,9 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
=20
         if (cond =3D=3D 0xf) {
             /* swi */
-            gen_set_pc_im(s, s->pc);
+            gen_set_pc_im(s, s->base.pc_next);
             s->svc_imm =3D extract32(insn, 0, 8);
-            s->is_jmp =3D DISAS_SWI;
+            s->base.jmp_type =3D DJ_SWI;
             break;
         }
         /* generate a conditional jump to next instruction */
@@ -11524,7 +11525,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
         s->condjmp =3D 1;
=20
         /* jump to the offset */
-        val =3D (uint32_t)s->pc + 2;
+        val =3D (uint32_t)s->base.pc_next + 2;
         offset =3D ((int32_t)insn << 24) >> 24;
         val +=3D offset << 1;
         gen_jmp(s, val);
@@ -11537,7 +11538,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
             break;
         }
         /* unconditional branch */
-        val =3D (uint32_t)s->pc;
+        val =3D (uint32_t)s->base.pc_next;
         offset =3D ((int32_t)insn << 21) >> 21;
         val +=3D (offset << 1) + 2;
         gen_jmp(s, val);
@@ -11559,20 +11560,20 @@ undef:
                        default_exception_el(s));
 }
=20
-static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
+static bool insn_crosses_page(CPUARMState *env, const DisasContext *s)
 {
     /* Return true if the insn at dc->pc might cross a page boundary.
      * (False positives are OK, false negatives are not.)
      */
     uint16_t insn;
=20
-    if ((s->pc & 3) =3D=3D 0) {
+    if ((s->base.pc_next & 3) =3D=3D 0) {
         /* At a 4-aligned address we can't be crossing a page */
         return false;
     }
=20
     /* This must be a Thumb insn */
-    insn =3D arm_lduw_code(env, s->pc, s->sctlr_b);
+    insn =3D arm_lduw_code(env, s->base.pc_next, s->sctlr_b);
=20
     if ((insn >> 11) >=3D 0x1d) {
         /* Top five bits 0b11101 / 0b11110 / 0b11111 : this is the
@@ -11588,35 +11589,108 @@ static bool insn_crosses_page(CPUARMState *env=
, DisasContext *s)
     return false;
 }
=20
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
-{
-    CPUARMState *env =3D cpu->env_ptr;
-    ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
-    DisasContext dc1, *dc =3D &dc1;
-    target_ulong pc_start;
-    target_ulong next_page_start;
-    int num_insns;
-    int max_insns;
-    bool end_of_page;
+static const char *cpu_mode_names[16] =3D {
+  "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
+  "???", "???", "hyp", "und", "???", "???", "???", "sys"
+};
=20
-    /* generate intermediate code */
+void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fpri=
ntf,
+                        int flags)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    int i;
+    uint32_t psr;
+    const char *ns_status;
=20
-    /* The A64 decoder has its own top level loop, because it doesn't ne=
ed
-     * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
-     */
-    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(arm_cpu, tb);
+    if (is_a64(env)) {
+        aarch64_cpu_dump_state(cs, f, cpu_fprintf, flags);
         return;
     }
=20
-    pc_start =3D tb->pc;
+    for (i =3D 0; i < 16; i++) {
+        cpu_fprintf(f, "R%02d=3D%08x", i, env->regs[i]);
+        if ((i % 4) =3D=3D 3) {
+            cpu_fprintf(f, "\n");
+        } else {
+            cpu_fprintf(f, " ");
+        }
+    }
+    psr =3D cpsr_read(env);
+
+    if (arm_feature(env, ARM_FEATURE_EL3) &&
+        (psr & CPSR_M) !=3D ARM_CPU_MODE_MON) {
+        ns_status =3D env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+    } else {
+        ns_status =3D "";
+    }
+
+    cpu_fprintf(f, "PSR=3D%08x %c%c%c%c %c %s%s%d\n",
+                psr,
+                psr & (1 << 31) ? 'N' : '-',
+                psr & (1 << 30) ? 'Z' : '-',
+                psr & (1 << 29) ? 'C' : '-',
+                psr & (1 << 28) ? 'V' : '-',
+                psr & CPSR_T ? 'T' : 'A',
+                ns_status,
+                cpu_mode_names[psr & 0xf], (psr & 0x10) ? 32 : 26);
+
+    if (flags & CPU_DUMP_FPU) {
+        int numvfpregs =3D 0;
+        if (arm_feature(env, ARM_FEATURE_VFP)) {
+            numvfpregs +=3D 16;
+        }
+        if (arm_feature(env, ARM_FEATURE_VFP3)) {
+            numvfpregs +=3D 16;
+        }
+        for (i =3D 0; i < numvfpregs; i++) {
+            uint64_t v =3D float64_val(env->vfp.regs[i]);
+            cpu_fprintf(f, "s%02d=3D%08x s%02d=3D%08x d%02d=3D%016" PRIx=
64 "\n",
+                        i * 2, (uint32_t)v,
+                        i * 2 + 1, (uint32_t)(v >> 32),
+                        i, v);
+        }
+        cpu_fprintf(f, "FPSCR: %08x\n", (int)env->vfp.xregs[ARM_VFP_FPSC=
R]);
+    }
+}
+
+void restore_state_to_opc(CPUARMState *env, TranslationBlock *tb,
+                          target_ulong *data)
+{
+    if (is_a64(env)) {
+        env->pc =3D data[0];
+        env->condexec_bits =3D 0;
+    } else {
+        env->regs[15] =3D data[0];
+        env->condexec_bits =3D data[1];
+    }
+}
+
+
+
+/* Use separate top-level templates for each architecture */
+#define gen_intermediate_code gen_intermediate_code_arm
+#include "translate-all_template.h"
+#undef gen_intermediate_code
+
+#if !defined(TARGET_AARCH64)
+void gen_intermediate_code_aarch64(CPUState *cpu, struct TranslationBloc=
k *tb)
+{
+}
+#endif
=20
-    dc->tb =3D tb;
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
+{
+    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
+        gen_intermediate_code_aarch64(cpu, tb);
+    } else {
+        gen_intermediate_code_arm(cpu, tb);
+    }
+}
=20
-    dc->is_jmp =3D DISAS_NEXT;
-    dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cpu->singlestep_enabled;
+static void gen_intermediate_code_target_init_disas_context(
+    DisasContext *dc, CPUARMState *env)
+{
     dc->condjmp =3D 0;
=20
     dc->aarch64 =3D 0;
@@ -11624,24 +11698,24 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
      * there is no secure EL1, so we route exceptions to EL3.
      */
     dc->secure_routed_to_el3 =3D arm_feature(env, ARM_FEATURE_EL3) &&
-                               !arm_el_is_aa64(env, 3);
-    dc->thumb =3D ARM_TBFLAG_THUMB(tb->flags);
-    dc->sctlr_b =3D ARM_TBFLAG_SCTLR_B(tb->flags);
-    dc->be_data =3D ARM_TBFLAG_BE_DATA(tb->flags) ? MO_BE : MO_LE;
-    dc->condexec_mask =3D (ARM_TBFLAG_CONDEXEC(tb->flags) & 0xf) << 1;
-    dc->condexec_cond =3D ARM_TBFLAG_CONDEXEC(tb->flags) >> 4;
-    dc->mmu_idx =3D ARM_TBFLAG_MMUIDX(tb->flags);
+        !arm_el_is_aa64(env, 3);
+    dc->thumb =3D ARM_TBFLAG_THUMB(dc->base.tb->flags);
+    dc->sctlr_b =3D ARM_TBFLAG_SCTLR_B(dc->base.tb->flags);
+    dc->be_data =3D ARM_TBFLAG_BE_DATA(dc->base.tb->flags) ? MO_BE : MO_=
LE;
+    dc->condexec_mask =3D (ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) & 0xf=
) << 1;
+    dc->condexec_cond =3D ARM_TBFLAG_CONDEXEC(dc->base.tb->flags) >> 4;
+    dc->mmu_idx =3D ARM_TBFLAG_MMUIDX(dc->base.tb->flags);
     dc->current_el =3D arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user =3D (dc->current_el =3D=3D 0);
 #endif
-    dc->ns =3D ARM_TBFLAG_NS(tb->flags);
-    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(tb->flags);
-    dc->vfp_enabled =3D ARM_TBFLAG_VFPEN(tb->flags);
-    dc->vec_len =3D ARM_TBFLAG_VECLEN(tb->flags);
-    dc->vec_stride =3D ARM_TBFLAG_VECSTRIDE(tb->flags);
-    dc->c15_cpar =3D ARM_TBFLAG_XSCALE_CPAR(tb->flags);
-    dc->cp_regs =3D arm_cpu->cp_regs;
+    dc->ns =3D ARM_TBFLAG_NS(dc->base.tb->flags);
+    dc->fp_excp_el =3D ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
+    dc->vfp_enabled =3D ARM_TBFLAG_VFPEN(dc->base.tb->flags);
+    dc->vec_len =3D ARM_TBFLAG_VECLEN(dc->base.tb->flags);
+    dc->vec_stride =3D ARM_TBFLAG_VECSTRIDE(dc->base.tb->flags);
+    dc->c15_cpar =3D ARM_TBFLAG_XSCALE_CPAR(dc->base.tb->flags);
+    dc->cp_regs =3D arm_env_get_cpu(env)->cp_regs;
     dc->features =3D env->features;
=20
     /* Single step state. The code-generation logic here is:
@@ -11659,11 +11733,18 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
      *   emit code to generate a software step exception
      *   end the TB
      */
-    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(tb->flags);
-    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(tb->flags);
+    dc->ss_active =3D ARM_TBFLAG_SS_ACTIVE(dc->base.tb->flags);
+    dc->pstate_ss =3D ARM_TBFLAG_PSTATE_SS(dc->base.tb->flags);
     dc->is_ldex =3D false;
     dc->ss_same_el =3D false; /* Can't be true since EL_d must be AArch6=
4 */
=20
+    dc->next_page_start =3D
+        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+}
+
+static void gen_intermediate_code_target_init_globals(
+    DisasContext *dc, CPUARMState *env)
+{
     cpu_F0s =3D tcg_temp_new_i32();
     cpu_F1s =3D tcg_temp_new_i32();
     cpu_F0d =3D tcg_temp_new_i64();
@@ -11672,20 +11753,11 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
     cpu_V1 =3D cpu_F1d;
     /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
     cpu_M0 =3D tcg_temp_new_i64();
-    next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE=
;
-    num_insns =3D 0;
-    max_insns =3D tb->cflags & CF_COUNT_MASK;
-    if (max_insns =3D=3D 0) {
-        max_insns =3D CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns =3D TCG_MAX_INSNS;
-    }
-
-    gen_tb_start(tb);
-
-    tcg_clear_temp_count();
+}
=20
+static void gen_intermediate_code_target_tb_start(
+    DisasContext *dc, CPUARMState *env)
+{
     /* A note on handling of the condexec (IT) bits:
      *
      * We want to avoid the overhead of having to write the updated cond=
exec
@@ -11716,118 +11788,129 @@ void gen_intermediate_code(CPUState *cpu, Tra=
nslationBlock *tb)
      * middle of a TB.
      */
=20
-    /* Reset the conditional execution bits immediately. This avoids
-       complications trying to do it at the end of the block.  */
-    if (dc->condexec_mask || dc->condexec_cond)
-      {
+    /*
+     * Reset the conditional execution bits immediately. This avoids
+     * complications trying to do it at the end of the block.
+     */
+    if (dc->condexec_mask || dc->condexec_cond) {
         TCGv_i32 tmp =3D tcg_temp_new_i32();
         tcg_gen_movi_i32(tmp, 0);
         store_cpu_field(tmp, condexec_bits);
-      }
-    do {
-        tcg_gen_insn_start(dc->pc,
-                           (dc->condexec_cond << 4) | (dc->condexec_mask=
 >> 1),
-                           0);
-        num_insns++;
+    }
+}
+
+static void gen_intermediate_code_target_insn_start(
+    DisasContext *dc, CPUARMState *env)
+{
+    tcg_gen_insn_start(dc->base.pc_next,
+                       (dc->condexec_cond << 4) | (dc->condexec_mask >> =
1),
+                       0);
+
=20
 #ifdef CONFIG_USER_ONLY
-        /* Intercept jump to the magic kernel page.  */
-        if (dc->pc >=3D 0xffff0000) {
-            /* We always get here via a jump, so know we are not in a
-               conditional execution block.  */
-            gen_exception_internal(EXCP_KERNEL_TRAP);
-            dc->is_jmp =3D DISAS_EXC;
-            break;
-        }
+    /* Intercept jump to the magic kernel page.  */
+    if (dc->base.pc_next >=3D 0xffff0000) {
+        /* We always get here via a jump, so know we are not in a
+           conditional execution block.  */
+        gen_exception_internal(EXCP_KERNEL_TRAP);
+        dc->base.jmp_type =3D DJ_EXC;
+    }
 #else
-        if (dc->pc >=3D 0xfffffff0 && arm_dc_feature(dc, ARM_FEATURE_M))=
 {
-            /* We always get here via a jump, so know we are not in a
-               conditional execution block.  */
-            gen_exception_internal(EXCP_EXCEPTION_EXIT);
-            dc->is_jmp =3D DISAS_EXC;
-            break;
-        }
+    if (dc->base.pc_next >=3D 0xfffffff0 && arm_dc_feature(dc, ARM_FEATU=
RE_M)) {
+        /* We always get here via a jump, so know we are not in a
+           conditional execution block.  */
+        gen_exception_internal(EXCP_EXCEPTION_EXIT);
+        dc->base.jmp_type =3D DJ_EXC;
+    }
 #endif
+}
=20
-        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->pc) {
-                    if (bp->flags & BP_CPU) {
-                        gen_set_condexec(dc);
-                        gen_set_pc_im(dc, dc->pc);
-                        gen_helper_check_breakpoints(cpu_env);
-                        /* End the TB early; it's likely not going to be=
 executed */
-                        dc->is_jmp =3D DISAS_UPDATE;
-                    } else {
-                        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
-                        /* The address covered by the breakpoint must be
-                           included in [tb->pc, tb->pc + tb->size) in or=
der
-                           to for it to be properly cleared -- thus we
-                           increment the PC here so that the logic setti=
ng
-                           tb->size below does the right thing.  */
-                        /* TODO: Advance PC by correct instruction lengt=
h to
-                         * avoid disassembler error messages */
-                        dc->pc +=3D 2;
-                        goto done_generating;
-                    }
-                    break;
-                }
-            }
-        }
-
-        if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
-
-        if (dc->ss_active && !dc->pstate_ss) {
-            /* Singlestep state is Active-pending.
-             * If we're in this state at the start of a TB then either
-             *  a) we just took an exception to an EL which is being deb=
ugged
-             *     and this is the first insn in the exception handler
-             *  b) debug exceptions were masked and we just unmasked the=
m
-             *     without changing EL (eg by clearing PSTATE.D)
-             * In either case we're going to take a swstep exception in =
the
-             * "did not step an insn" case, and so the syndrome ISV and =
EX
-             * bits should be zero.
-             */
-            assert(num_insns =3D=3D 1);
-            gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
-                          default_exception_el(dc));
-            goto done_generating;
-        }
+static BreakpointHitType gen_intermediate_code_target_breakpoint_hit(
+    DisasContext *dc, CPUARMState *env,
+    const CPUBreakpoint *bp)
+{
+    if (bp->flags & BP_CPU) {
+        gen_set_condexec(dc);
+        gen_set_pc_im(dc, dc->base.pc_next);
+        gen_helper_check_breakpoints(cpu_env);
+        /* End the TB early; it's likely not going to be executed */
+        dc->base.jmp_type =3D DJ_UPDATE;
+        return BH_HIT_INSN;
+    } else {
+        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        /* The address covered by the breakpoint must be
+           included in [tb->pc, tb->pc + tb->size) in order
+           to for it to be properly cleared -- thus we
+           increment the PC here so that the logic setting
+           tb->size below does the right thing.  */
+        /* TODO: Advance PC by correct instruction length to avoid
+         * disassembler error messages */
+        dc->base.pc_next +=3D 2;
+        return BH_HIT_TB;
+    }
+}
+
+static target_ulong gen_intermediate_code_target_disas_insn(
+    DisasContext *dc, CPUArchState *env)
+{
+    if (dc->ss_active && !dc->pstate_ss) {
+        /* Singlestep state is Active-pending.
+         * If we're in this state at the start of a TB then either
+         *  a) we just took an exception to an EL which is being debugge=
d
+         *     and this is the first insn in the exception handler
+         *  b) debug exceptions were masked and we just unmasked them
+         *     without changing EL (eg by clearing PSTATE.D)
+         * In either case we're going to take a swstep exception in the
+         * "did not step an insn" case, and so the syndrome ISV and EX
+         * bits should be zero.
+         */
+        assert(dc->base.num_insns =3D=3D 1);
+        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
+                      default_exception_el(dc));
+        dc->base.jmp_type =3D DJ_SKIP;
+        return dc->base.pc_next;
+    }
=20
-        if (dc->thumb) {
-            disas_thumb_insn(env, dc);
-            if (dc->condexec_mask) {
-                dc->condexec_cond =3D (dc->condexec_cond & 0xe)
-                                   | ((dc->condexec_mask >> 4) & 1);
-                dc->condexec_mask =3D (dc->condexec_mask << 1) & 0x1f;
-                if (dc->condexec_mask =3D=3D 0) {
-                    dc->condexec_cond =3D 0;
-                }
+    if (dc->thumb) {
+        disas_thumb_insn(env, dc);
+        if (dc->condexec_mask) {
+            dc->condexec_cond =3D (dc->condexec_cond & 0xe)
+                | ((dc->condexec_mask >> 4) & 1);
+            dc->condexec_mask =3D (dc->condexec_mask << 1) & 0x1f;
+            if (dc->condexec_mask =3D=3D 0) {
+                dc->condexec_cond =3D 0;
             }
-        } else {
-            unsigned int insn =3D arm_ldl_code(env, dc->pc, dc->sctlr_b)=
;
-            dc->pc +=3D 4;
-            disas_arm_insn(dc, insn);
         }
+    } else {
+        unsigned int insn =3D arm_ldl_code(env, dc->base.pc_next, dc->sc=
tlr_b);
+        dc->base.pc_next +=3D 4;
+        disas_arm_insn(dc, insn);
+    }
=20
-        if (dc->condjmp && !dc->is_jmp) {
-            gen_set_label(dc->condlabel);
-            dc->condjmp =3D 0;
-        }
+    if (dc->condjmp && !dc->base.jmp_type) {
+        gen_set_label(dc->condlabel);
+        dc->condjmp =3D 0;
+    }
=20
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
-                    dc->pc);
-        }
+    return dc->base.pc_next;
+}
=20
-        /* Translation stops when a conditional branch is encountered.
-         * Otherwise the subsequent code could get translated several ti=
mes.
-         * Also stop translation when a page boundary is reached.  This
-         * ensures prefetch aborts occur at the right place.  */
+static DisasJumpType gen_intermediate_code_target_stop_check(
+    DisasContext *dc, CPUARMState *env)
+{
+    /* Translation stops when a conditional branch is encountered.
+     * Otherwise the subsequent code could get translated several times.
+     * Also stop translation when a page boundary is reached.  This
+     * ensures prefetch aborts occur at the right place.  */
=20
+    if (dc->ss_active) {
+        return DJ_SS;
+    } else if ((dc->base.pc_next >=3D dc->next_page_start - 3)
+               && insn_crosses_page(env, dc)) {
+        /*
+         * Generic code already checked if the next insn starts in a new
+         * page.
+         */
         /* We want to stop the TB if the next insn starts in a new page,
          * or if it spans between this page and the next. This means tha=
t
          * if we're looking at the last halfword in the page we need to
@@ -11837,48 +11920,53 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
          * in it at the end of this page (which would execute correctly
          * but isn't very efficient).
          */
-        end_of_page =3D (dc->pc >=3D next_page_start) ||
-            ((dc->pc >=3D next_page_start - 3) && insn_crosses_page(env,=
 dc));
+        return DJ_PAGE_CROSS;
+    } else {
+        return dc->base.jmp_type;
+    }
+}
=20
-    } while (!dc->is_jmp && !tcg_op_buf_full() &&
-             !cpu->singlestep_enabled &&
-             !singlestep &&
-             !dc->ss_active &&
-             !end_of_page &&
-             num_insns < max_insns);
+static void gen_intermediate_code_target_stop(
+    DisasContext *dc, CPUARMState *env)
+{
+    /* Cast because target-specific values are not in generic enum */
+    unsigned int jt =3D (unsigned int)dc->base.jmp_type;
=20
-    if (tb->cflags & CF_LAST_IO) {
-        if (dc->condjmp) {
-            /* FIXME:  This can theoretically happen with self-modifying
-               code.  */
-            cpu_abort(cpu, "IO on conditional branch instruction");
-        }
-        gen_io_end();
+    if (jt =3D=3D DJ_SKIP) {
+        return;
+    }
+
+    if ((dc->base.tb->cflags & CF_LAST_IO) && dc->condjmp) {
+        /* FIXME: This can theoretically happen with self-modifying code=
. */
+        cpu_abort(ENV_GET_CPU(env), "IO on conditional branch instructio=
n");
     }
=20
     /* At this stage dc->condjmp will only be set when the skipped
        instruction was a conditional branch or trap, and the PC has
        already been written.  */
-    if (unlikely(cpu->singlestep_enabled || dc->ss_active)) {
+    if (unlikely(dc->base.singlestep_enabled || dc->ss_active)) {
         /* Unconditional and "condition passed" instruction codepath. */
         gen_set_condexec(dc);
-        switch (dc->is_jmp) {
-        case DISAS_SWI:
+
+        /* Cast because we have values outside generic enum */
+        switch (jt) {
+        case DJ_SWI:
             gen_ss_advance(dc);
             gen_exception(EXCP_SWI, syn_aa32_svc(dc->svc_imm, dc->thumb)=
,
                           default_exception_el(dc));
             break;
-        case DISAS_HVC:
+        case DJ_HVC:
             gen_ss_advance(dc);
             gen_exception(EXCP_HVC, syn_aa32_hvc(dc->svc_imm), 2);
             break;
-        case DISAS_SMC:
+        case DJ_SMC:
             gen_ss_advance(dc);
             gen_exception(EXCP_SMC, syn_aa32_smc(), 3);
             break;
-        case DISAS_NEXT:
-        case DISAS_UPDATE:
-            gen_set_pc_im(dc, dc->pc);
+        case DJ_NEXT:
+        case DJ_TOO_MANY:               /* target set DJ_NEXT */
+        case DJ_UPDATE:
+            gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
             if (dc->ss_active) {
@@ -11889,11 +11977,12 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
                 gen_exception_internal(EXCP_DEBUG);
             }
         }
+
         if (dc->condjmp) {
             /* "Condition failed" instruction codepath. */
             gen_set_label(dc->condlabel);
             gen_set_condexec(dc);
-            gen_set_pc_im(dc, dc->pc);
+            gen_set_pc_im(dc, dc->base.pc_next);
             if (dc->ss_active) {
                 gen_step_complete_exception(dc);
             } else {
@@ -11910,146 +11999,59 @@ void gen_intermediate_code(CPUState *cpu, Tran=
slationBlock *tb)
            Hardware breakpoints have already been handled and skip this =
code.
          */
         gen_set_condexec(dc);
-        switch(dc->is_jmp) {
-        case DISAS_NEXT:
-            gen_goto_tb(dc, 1, dc->pc);
+
+        switch (jt) {
+        case DJ_NEXT:
+        case DJ_TOO_MANY:               /* target set DJ_NEXT */
+            gen_goto_tb(dc, 1, dc->base.pc_next);
             break;
-        case DISAS_UPDATE:
-            gen_set_pc_im(dc, dc->pc);
+        case DJ_UPDATE:
+            gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
-        case DISAS_JUMP:
+        case DJ_JUMP:
         default:
             /* indicate that the hash table must be used to find the nex=
t TB */
             tcg_gen_exit_tb(0);
             break;
-        case DISAS_TB_JUMP:
+        case DJ_TB_JUMP:
             /* nothing more to generate */
             break;
-        case DISAS_WFI:
+        case DJ_WFI:
             gen_helper_wfi(cpu_env);
             /* The helper doesn't necessarily throw an exception, but we
              * must go back to the main loop to check for interrupts any=
way.
              */
             tcg_gen_exit_tb(0);
             break;
-        case DISAS_WFE:
+        case DJ_WFE:
             gen_helper_wfe(cpu_env);
             break;
-        case DISAS_YIELD:
+        case DJ_YIELD:
             gen_helper_yield(cpu_env);
             break;
-        case DISAS_SWI:
+        case DJ_SWI:
             gen_exception(EXCP_SWI, syn_aa32_svc(dc->svc_imm, dc->thumb)=
,
                           default_exception_el(dc));
             break;
-        case DISAS_HVC:
+        case DJ_HVC:
             gen_exception(EXCP_HVC, syn_aa32_hvc(dc->svc_imm), 2);
             break;
-        case DISAS_SMC:
+        case DJ_SMC:
             gen_exception(EXCP_SMC, syn_aa32_smc(), 3);
             break;
         }
+
         if (dc->condjmp) {
             gen_set_label(dc->condlabel);
             gen_set_condexec(dc);
-            gen_goto_tb(dc, 1, dc->pc);
+            gen_goto_tb(dc, 1, dc->base.pc_next);
             dc->condjmp =3D 0;
         }
     }
-
-done_generating:
-    gen_tb_end(tb, num_insns);
-
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cpu, pc_start, dc->pc - pc_start,
-                         dc->thumb | (dc->sctlr_b << 1));
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
-    tb->size =3D dc->pc - pc_start;
-    tb->icount =3D num_insns;
 }
=20
-static const char *cpu_mode_names[16] =3D {
-  "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
-  "???", "???", "hyp", "und", "???", "???", "???", "sys"
-};
-
-void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fpri=
ntf,
-                        int flags)
+static int gen_intermediate_code_target_get_disas_flags(
+    const DisasContext *dc)
 {
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-    int i;
-    uint32_t psr;
-    const char *ns_status;
-
-    if (is_a64(env)) {
-        aarch64_cpu_dump_state(cs, f, cpu_fprintf, flags);
-        return;
-    }
-
-    for(i=3D0;i<16;i++) {
-        cpu_fprintf(f, "R%02d=3D%08x", i, env->regs[i]);
-        if ((i % 4) =3D=3D 3)
-            cpu_fprintf(f, "\n");
-        else
-            cpu_fprintf(f, " ");
-    }
-    psr =3D cpsr_read(env);
-
-    if (arm_feature(env, ARM_FEATURE_EL3) &&
-        (psr & CPSR_M) !=3D ARM_CPU_MODE_MON) {
-        ns_status =3D env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
-    } else {
-        ns_status =3D "";
-    }
-
-    cpu_fprintf(f, "PSR=3D%08x %c%c%c%c %c %s%s%d\n",
-                psr,
-                psr & (1 << 31) ? 'N' : '-',
-                psr & (1 << 30) ? 'Z' : '-',
-                psr & (1 << 29) ? 'C' : '-',
-                psr & (1 << 28) ? 'V' : '-',
-                psr & CPSR_T ? 'T' : 'A',
-                ns_status,
-                cpu_mode_names[psr & 0xf], (psr & 0x10) ? 32 : 26);
-
-    if (flags & CPU_DUMP_FPU) {
-        int numvfpregs =3D 0;
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
-            numvfpregs +=3D 16;
-        }
-        if (arm_feature(env, ARM_FEATURE_VFP3)) {
-            numvfpregs +=3D 16;
-        }
-        for (i =3D 0; i < numvfpregs; i++) {
-            uint64_t v =3D float64_val(env->vfp.regs[i]);
-            cpu_fprintf(f, "s%02d=3D%08x s%02d=3D%08x d%02d=3D%016" PRIx=
64 "\n",
-                        i * 2, (uint32_t)v,
-                        i * 2 + 1, (uint32_t)(v >> 32),
-                        i, v);
-        }
-        cpu_fprintf(f, "FPSCR: %08x\n", (int)env->vfp.xregs[ARM_VFP_FPSC=
R]);
-    }
-}
-
-void restore_state_to_opc(CPUARMState *env, TranslationBlock *tb,
-                          target_ulong *data)
-{
-    if (is_a64(env)) {
-        env->pc =3D data[0];
-        env->condexec_bits =3D 0;
-        env->exception.syndrome =3D data[2] << ARM_INSN_START_WORD2_SHIF=
T;
-    } else {
-        env->regs[15] =3D data[0];
-        env->condexec_bits =3D data[1];
-        env->exception.syndrome =3D data[2] << ARM_INSN_START_WORD2_SHIF=
T;
-    }
+    return dc->thumb | (dc->sctlr_b << 1);
 }
diff --git a/target-arm/translate.h b/target-arm/translate.h
index 3dd4c4578e..1e72712119 100644
--- a/target-arm/translate.h
+++ b/target-arm/translate.h
@@ -1,11 +1,15 @@
 #ifndef TARGET_ARM_TRANSLATE_H
 #define TARGET_ARM_TRANSLATE_H
=20
+#include "exec/translate-all_template.h"
+
+
 /* internal defines */
 typedef struct DisasContext {
-    target_ulong pc;
+    DisasContextBase base;
+
+    target_ulong next_page_start;
     uint32_t insn;
-    int is_jmp;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
     /* The label that will be jumped to when the instruction is skipped.=
  */
@@ -13,8 +17,6 @@ typedef struct DisasContext {
     /* Thumb-2 conditional execution bits.  */
     int condexec_mask;
     int condexec_cond;
-    struct TranslationBlock *tb;
-    int singlestep_enabled;
     int thumb;
     int sctlr_b;
     TCGMemOp be_data;
@@ -104,31 +106,45 @@ static inline int default_exception_el(DisasContext=
 *s)
             ? 3 : MAX(1, s->current_el);
 }
=20
-/* target-specific extra values for is_jmp */
-/* TODO: rename as DJ_* when transitioning this target to generic transl=
ation */
+/* Target-specific values for DisasContextBase::jmp_type */
+#include "exec/translate-all_template.h"
+#define DJ_JUMP    (DJ_TARGET + 0)
+#define DJ_UPDATE  (DJ_TARGET + 1)
+#define DJ_TB_JUMP (DJ_TARGET + 2)
 /* These instructions trap after executing, so the A32/T32 decoder must
  * defer them until after the conditional execution state has been updat=
ed.
  * WFI also needs special handling when single-stepping.
  */
-#define DISAS_WFI (DISAS_TARGET + 0)
-#define DISAS_SWI (DISAS_TARGET + 1)
+#define DJ_WFI     (DJ_TARGET + 3)
+#define DJ_SWI     (DJ_TARGET + 4)
 /* For instructions which unconditionally cause an exception we can skip
  * emitting unreachable code at the end of the TB in the A64 decoder
  */
-#define DISAS_EXC (DISAS_TARGET + 2)
+#define DJ_EXC     (DJ_TARGET + 5)
 /* WFE */
-#define DISAS_WFE (DISAS_TARGET + 3)
-#define DISAS_HVC (DISAS_TARGET + 4)
-#define DISAS_SMC (DISAS_TARGET + 5)
-#define DISAS_YIELD (DISAS_TARGET + 6)
+#define DJ_WFE     (DJ_TARGET + 6)
+#define DJ_HVC     (DJ_TARGET + 7)
+#define DJ_SMC     (DJ_TARGET + 8)
+#define DJ_YIELD   (DJ_TARGET + 9)
+#define DJ_SS      (DJ_TARGET + 10)
+#define DJ_PAGE_CROSS (DJ_TARGET + 11)
+#define DJ_SKIP    (DJ_TARGET + 12)
+
+void gen_intermediate_code_arm(CPUState *cpu, struct TranslationBlock *t=
b);
+void gen_intermediate_code_aarch64(CPUState *cpu, struct TranslationBloc=
k *tb);
=20
 #ifdef TARGET_AARCH64
+void init_tmp_a64_array(DisasContext *s);
 void a64_translate_init(void);
 void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb);
 void gen_a64_set_pc_im(uint64_t val);
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
 #else
+static inline void init_tmp_a64_array(DisasContext *s)
+{
+}
+
 static inline void a64_translate_init(void)
 {
 }
