Received: from eggs.gnu.org ([2001:4830:134:3::10]:34549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP49f-0004qp-46
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP49c-0004Y7-0r
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:48:31 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 12:48:17 +0300
Message-Id: <149838409778.6497.16277162983730521098.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 16/26] target: [tcg,
 arm] Replace DISAS_* with DJ_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/arm/translate-a64.c |   58 ++++++++++++++--------------
 target/arm/translate.c     |   90 ++++++++++++++++++++++----------------=
------
 target/arm/translate.h     |   24 ++++++------
 3 files changed, 87 insertions(+), 85 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 43261e7939..d2fe2718ad 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -304,7 +304,7 @@ static void gen_exception_internal_insn(DisasContext =
*s, int offset, int excp)
 {
     gen_a64_set_pc_im(s->pc - offset);
     gen_exception_internal(excp);
-    s->is_jmp =3D DISAS_EXC;
+    s->is_jmp =3D DJ_EXC;
 }
=20
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
@@ -312,7 +312,7 @@ static void gen_exception_insn(DisasContext *s, int o=
ffset, int excp,
 {
     gen_a64_set_pc_im(s->pc - offset);
     gen_exception(excp, syndrome, target_el);
-    s->is_jmp =3D DISAS_EXC;
+    s->is_jmp =3D DJ_EXC;
 }
=20
 static void gen_ss_advance(DisasContext *s)
@@ -340,7 +340,7 @@ static void gen_step_complete_exception(DisasContext =
*s)
     gen_ss_advance(s);
     gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
                   default_exception_el(s));
-    s->is_jmp =3D DISAS_EXC;
+    s->is_jmp =3D DJ_EXC;
 }
=20
 static inline bool use_goto_tb(DisasContext *s, int n, uint64_t dest)
@@ -371,7 +371,7 @@ static inline void gen_goto_tb(DisasContext *s, int n=
, uint64_t dest)
         tcg_gen_goto_tb(n);
         gen_a64_set_pc_im(dest);
         tcg_gen_exit_tb((intptr_t)tb + n);
-        s->is_jmp =3D DISAS_TB_JUMP;
+        s->is_jmp =3D DJ_TB_JUMP;
     } else {
         gen_a64_set_pc_im(dest);
         if (s->ss_active) {
@@ -380,7 +380,7 @@ static inline void gen_goto_tb(DisasContext *s, int n=
, uint64_t dest)
             gen_exception_internal(EXCP_DEBUG);
         } else {
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->is_jmp =3D DJ_TB_JUMP;
         }
     }
 }
@@ -1331,16 +1331,16 @@ static void handle_hint(DisasContext *s, uint32_t=
 insn,
     case 0: /* NOP */
         return;
     case 3: /* WFI */
-        s->is_jmp =3D DISAS_WFI;
+        s->is_jmp =3D DJ_WFI;
         return;
     case 1: /* YIELD */
         if (!parallel_cpus) {
-            s->is_jmp =3D DISAS_YIELD;
+            s->is_jmp =3D DJ_YIELD;
         }
         return;
     case 2: /* WFE */
         if (!parallel_cpus) {
-            s->is_jmp =3D DISAS_WFE;
+            s->is_jmp =3D DJ_WFE;
         }
         return;
     case 4: /* SEV */
@@ -1393,7 +1393,7 @@ static void handle_sync(DisasContext *s, uint32_t i=
nsn,
          * a self-modified code correctly and also to take
          * any pending interrupts immediately.
          */
-        s->is_jmp =3D DISAS_UPDATE;
+        s->is_jmp =3D DJ_UPDATE;
         return;
     default:
         unallocated_encoding(s);
@@ -1422,7 +1422,7 @@ static void handle_msr_i(DisasContext *s, uint32_t =
insn,
         gen_helper_msr_i_pstate(cpu_env, tcg_op, tcg_imm);
         tcg_temp_free_i32(tcg_imm);
         tcg_temp_free_i32(tcg_op);
-        s->is_jmp =3D DISAS_UPDATE;
+        s->is_jmp =3D DJ_UPDATE;
         break;
     }
     default:
@@ -1591,13 +1591,13 @@ static void handle_sys(DisasContext *s, uint32_t =
insn, bool isread,
     if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) *=
/
         gen_io_end(cpu_env);
-        s->is_jmp =3D DISAS_UPDATE;
+        s->is_jmp =3D DJ_UPDATE;
     } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
-        s->is_jmp =3D DISAS_UPDATE;
+        s->is_jmp =3D DJ_UPDATE;
     }
 }
=20
@@ -1786,7 +1786,7 @@ static void disas_uncond_b_reg(DisasContext *s, uin=
t32_t insn)
             return;
         }
         gen_helper_exception_return(cpu_env);
-        s->is_jmp =3D DISAS_JUMP;
+        s->is_jmp =3D DJ_JUMP;
         return;
     case 5: /* DRPS */
         if (rn !=3D 0x1f) {
@@ -1800,7 +1800,7 @@ static void disas_uncond_b_reg(DisasContext *s, uin=
t32_t insn)
         return;
     }
=20
-    s->is_jmp =3D DISAS_JUMP;
+    s->is_jmp =3D DJ_JUMP;
 }
=20
 /* C3.2 Branches, exception generating and system instructions */
@@ -11202,7 +11202,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
=20
     dc->tb =3D tb;
=20
-    dc->is_jmp =3D DISAS_NEXT;
+    dc->is_jmp =3D DJ_NEXT;
     dc->pc =3D pc_start;
     dc->singlestep_enabled =3D cs->singlestep_enabled;
     dc->condjmp =3D 0;
@@ -11280,7 +11280,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
                         gen_a64_set_pc_im(dc->pc);
                         gen_helper_check_breakpoints(cpu_env);
                         /* End the TB early; it likely won't be executed=
 */
-                        dc->is_jmp =3D DISAS_UPDATE;
+                        dc->is_jmp =3D DJ_UPDATE;
                     } else {
                         gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
                         /* The address covered by the breakpoint must be
@@ -11314,7 +11314,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
             assert(num_insns =3D=3D 1);
             gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                           default_exception_el(dc));
-            dc->is_jmp =3D DISAS_EXC;
+            dc->is_jmp =3D DJ_EXC;
             break;
         }
=20
@@ -11342,14 +11342,14 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Tra=
nslationBlock *tb)
     }
=20
     if (unlikely(cs->singlestep_enabled || dc->ss_active)
-        && dc->is_jmp !=3D DISAS_EXC) {
+        && dc->is_jmp !=3D DJ_EXC) {
         /* Note that this means single stepping WFI doesn't halt the CPU.
          * For conditional branch insns this is harmless unreachable cod=
e as
          * gen_goto_tb() has already handled emitting the debug exceptio=
n
          * (and thus a tb-jump is not possible when singlestepping).
          */
-        assert(dc->is_jmp !=3D DISAS_TB_JUMP);
-        if (dc->is_jmp !=3D DISAS_JUMP) {
+        assert(dc->is_jmp !=3D DJ_TB_JUMP);
+        if (dc->is_jmp !=3D DJ_JUMP) {
             gen_a64_set_pc_im(dc->pc);
         }
         if (cs->singlestep_enabled) {
@@ -11359,29 +11359,29 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Tra=
nslationBlock *tb)
         }
     } else {
         switch (dc->is_jmp) {
-        case DISAS_NEXT:
+        case DJ_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
             break;
         default:
-        case DISAS_UPDATE:
+        case DJ_UPDATE:
             gen_a64_set_pc_im(dc->pc);
             /* fall through */
-        case DISAS_JUMP:
+        case DJ_JUMP:
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
             break;
-        case DISAS_TB_JUMP:
-        case DISAS_EXC:
-        case DISAS_SWI:
+        case DJ_TB_JUMP:
+        case DJ_EXC:
+        case DJ_SWI:
             break;
-        case DISAS_WFE:
+        case DJ_WFE:
             gen_a64_set_pc_im(dc->pc);
             gen_helper_wfe(cpu_env);
             break;
-        case DISAS_YIELD:
+        case DJ_YIELD:
             gen_a64_set_pc_im(dc->pc);
             gen_helper_yield(cpu_env);
             break;
-        case DISAS_WFI:
+        case DJ_WFI:
             /* This is a special case because we don't want to just halt=
 the CPU
              * if trying to debug across a WFI.
              */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 073562269b..04063fed6b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -224,7 +224,7 @@ static void store_reg(DisasContext *s, int reg, TCGv_=
i32 var)
          * We choose to ignore [1:0] in ARM mode for all architecture ve=
rsions.
          */
         tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
-        s->is_jmp =3D DISAS_JUMP;
+        s->is_jmp =3D DJ_JUMP;
     }
     tcg_gen_mov_i32(cpu_R[reg], var);
     tcg_temp_free_i32(var);
@@ -297,7 +297,7 @@ static void gen_step_complete_exception(DisasContext =
*s)
     gen_ss_advance(s);
     gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
                   default_exception_el(s));
-    s->is_jmp =3D DISAS_EXC;
+    s->is_jmp =3D DJ_EXC;
 }
=20
 static void gen_singlestep_exception(DisasContext *s)
@@ -928,7 +928,7 @@ static inline void gen_bx_im(DisasContext *s, uint32_=
t addr)
 {
     TCGv_i32 tmp;
=20
-    s->is_jmp =3D DISAS_JUMP;
+    s->is_jmp =3D DJ_JUMP;
     if (s->thumb !=3D (addr & 1)) {
         tmp =3D tcg_temp_new_i32();
         tcg_gen_movi_i32(tmp, addr & 1);
@@ -941,7 +941,7 @@ static inline void gen_bx_im(DisasContext *s, uint32_=
t addr)
 /* Set PC and Thumb state from var.  var is marked as dead.  */
 static inline void gen_bx(DisasContext *s, TCGv_i32 var)
 {
-    s->is_jmp =3D DISAS_JUMP;
+    s->is_jmp =3D DJ_JUMP;
     tcg_gen_andi_i32(cpu_R[15], var, ~1);
     tcg_gen_andi_i32(var, var, 1);
     store_cpu_field(var, thumb);
@@ -959,7 +959,7 @@ static inline void gen_bx_excret(DisasContext *s, TCG=
v_i32 var)
      */
     gen_bx(s, var);
     if (s->v7m_handler_mode && arm_dc_feature(s, ARM_FEATURE_M)) {
-        s->is_jmp =3D DISAS_BX_EXCRET;
+        s->is_jmp =3D DJ_BX_EXCRET;
     }
 }
=20
@@ -970,7 +970,7 @@ static inline void gen_bx_excret_final_code(DisasCont=
ext *s)
=20
     /* Is the new PC value in the magic range indicating exception retur=
n? */
     tcg_gen_brcondi_i32(TCG_COND_GEU, cpu_R[15], 0xff000000, excret_labe=
l);
-    /* No: end the TB as we would for a DISAS_JMP */
+    /* No: end the TB as we would for a DJ_JMP */
     if (is_singlestepping(s)) {
         gen_singlestep_exception(s);
     } else {
@@ -1159,7 +1159,7 @@ static inline void gen_hvc(DisasContext *s, int imm=
16)
      */
     s->svc_imm =3D imm16;
     gen_set_pc_im(s, s->pc);
-    s->is_jmp =3D DISAS_HVC;
+    s->is_jmp =3D DJ_HVC;
 }
=20
 static inline void gen_smc(DisasContext *s)
@@ -1174,7 +1174,7 @@ static inline void gen_smc(DisasContext *s)
     gen_helper_pre_smc(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     gen_set_pc_im(s, s->pc);
-    s->is_jmp =3D DISAS_SMC;
+    s->is_jmp =3D DJ_SMC;
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
+    s->is_jmp =3D DJ_EXC;
 }
=20
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
@@ -1191,14 +1191,14 @@ static void gen_exception_insn(DisasContext *s, i=
nt offset, int excp,
     gen_set_condexec(s);
     gen_set_pc_im(s, s->pc - offset);
     gen_exception(excp, syn, target_el);
-    s->is_jmp =3D DISAS_EXC;
+    s->is_jmp =3D DJ_EXC;
 }
=20
 /* Force a TB lookup after an instruction that changes the CPU state.  *=
/
 static inline void gen_lookup_tb(DisasContext *s)
 {
     tcg_gen_movi_i32(cpu_R[15], s->pc & ~1);
-    s->is_jmp =3D DISAS_EXIT;
+    s->is_jmp =3D DJ_EXIT;
 }
=20
 static inline void gen_hlt(DisasContext *s, int imm)
@@ -4179,7 +4179,7 @@ static inline void gen_jmp (DisasContext *s, uint32=
_t dest)
         gen_bx_im(s, dest);
     } else {
         gen_goto_tb(s, 0, dest);
-        s->is_jmp =3D DISAS_TB_JUMP;
+        s->is_jmp =3D DJ_TB_JUMP;
     }
 }
=20
@@ -4430,7 +4430,7 @@ static void gen_msr_banked(DisasContext *s, int r, =
int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     tcg_temp_free_i32(tcg_reg);
-    s->is_jmp =3D DISAS_UPDATE;
+    s->is_jmp =3D DJ_UPDATE;
 }
=20
 static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
@@ -4452,7 +4452,7 @@ static void gen_mrs_banked(DisasContext *s, int r, =
int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     store_reg(s, rn, tcg_reg);
-    s->is_jmp =3D DISAS_UPDATE;
+    s->is_jmp =3D DJ_UPDATE;
 }
=20
 /* Store value to PC as for an exception return (ie don't
@@ -4475,7 +4475,7 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, T=
CGv_i32 cpsr)
      */
     gen_helper_cpsr_write_eret(cpu_env, cpsr);
     tcg_temp_free_i32(cpsr);
-    s->is_jmp =3D DISAS_JUMP;
+    s->is_jmp =3D DJ_JUMP;
 }
=20
 /* Generate an old-style exception return. Marks pc as dead. */
@@ -4498,17 +4498,17 @@ static void gen_nop_hint(DisasContext *s, int val=
)
     case 1: /* yield */
         if (!parallel_cpus) {
             gen_set_pc_im(s, s->pc);
-            s->is_jmp =3D DISAS_YIELD;
+            s->is_jmp =3D DJ_YIELD;
         }
         break;
     case 3: /* wfi */
         gen_set_pc_im(s, s->pc);
-        s->is_jmp =3D DISAS_WFI;
+        s->is_jmp =3D DJ_WFI;
         break;
     case 2: /* wfe */
         if (!parallel_cpus) {
             gen_set_pc_im(s, s->pc);
-            s->is_jmp =3D DISAS_WFE;
+            s->is_jmp =3D DJ_WFE;
         }
         break;
     case 4: /* sev */
@@ -7647,7 +7647,7 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
                 return 1;
             }
             gen_set_pc_im(s, s->pc);
-            s->is_jmp =3D DISAS_WFI;
+            s->is_jmp =3D DJ_WFI;
             return 0;
         default:
             break;
@@ -8058,7 +8058,7 @@ static void gen_srs(DisasContext *s,
         tcg_temp_free_i32(tmp);
     }
     tcg_temp_free_i32(addr);
-    s->is_jmp =3D DISAS_UPDATE;
+    s->is_jmp =3D DJ_UPDATE;
 }
=20
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
@@ -8146,7 +8146,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
             /* setend */
             if (((insn >> 9) & 1) !=3D !!(s->be_data =3D=3D MO_BE)) {
                 gen_helper_setend(cpu_env);
-                s->is_jmp =3D DISAS_UPDATE;
+                s->is_jmp =3D DJ_UPDATE;
             }
             return;
         } else if ((insn & 0x0fffff00) =3D=3D 0x057ff000) {
@@ -9519,7 +9519,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
                     tmp =3D load_cpu_field(spsr);
                     gen_helper_cpsr_write_eret(cpu_env, tmp);
                     tcg_temp_free_i32(tmp);
-                    s->is_jmp =3D DISAS_JUMP;
+                    s->is_jmp =3D DJ_JUMP;
                 }
             }
             break;
@@ -9557,7 +9557,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
             /* swi */
             gen_set_pc_im(s, s->pc);
             s->svc_imm =3D extract32(insn, 0, 24);
-            s->is_jmp =3D DISAS_SWI;
+            s->is_jmp =3D DJ_SWI;
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
+                    s->is_jmp =3D DJ_UPDATE;
                 }
                 break;
             case 3:
@@ -11713,7 +11713,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
             /* swi */
             gen_set_pc_im(s, s->pc);
             s->svc_imm =3D extract32(insn, 0, 8);
-            s->is_jmp =3D DISAS_SWI;
+            s->is_jmp =3D DJ_SWI;
             break;
         }
         /* generate a conditional jump to next instruction */
@@ -11812,7 +11812,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
=20
     dc->tb =3D tb;
=20
-    dc->is_jmp =3D DISAS_NEXT;
+    dc->is_jmp =3D DJ_NEXT;
     dc->pc =3D pc_start;
     dc->singlestep_enabled =3D cpu->singlestep_enabled;
     dc->condjmp =3D 0;
@@ -11936,7 +11936,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
             /* We always get here via a jump, so know we are not in a
                conditional execution block.  */
             gen_exception_internal(EXCP_KERNEL_TRAP);
-            dc->is_jmp =3D DISAS_EXC;
+            dc->is_jmp =3D DJ_EXC;
             break;
         }
 #endif
@@ -11950,7 +11950,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
                         gen_set_pc_im(dc, dc->pc);
                         gen_helper_check_breakpoints(cpu_env);
                         /* End the TB early; it's likely not going to be=
 executed */
-                        dc->is_jmp =3D DISAS_UPDATE;
+                        dc->is_jmp =3D DJ_UPDATE;
                     } else {
                         gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
                         /* The address covered by the breakpoint must be
@@ -12051,7 +12051,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
        instruction was a conditional branch or trap, and the PC has
        already been written.  */
     gen_set_condexec(dc);
-    if (dc->is_jmp =3D=3D DISAS_BX_EXCRET) {
+    if (dc->is_jmp =3D=3D DJ_BX_EXCRET) {
         /* Exception return branches need some special case code at the
          * end of the TB, which is complex enough that it has to
          * handle the single-step vs not and the condition-failed
@@ -12061,21 +12061,21 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
     } else if (unlikely(is_singlestepping(dc))) {
         /* Unconditional and "condition passed" instruction codepath. */
         switch (dc->is_jmp) {
-        case DISAS_SWI:
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
+        case DJ_NEXT:
+        case DJ_UPDATE:
             gen_set_pc_im(dc, dc->pc);
             /* fall through */
         default:
@@ -12092,44 +12092,44 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
            Hardware breakpoints have already been handled and skip this =
code.
          */
         switch(dc->is_jmp) {
-        case DISAS_NEXT:
+        case DJ_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
             break;
-        case DISAS_UPDATE:
+        case DJ_UPDATE:
             gen_set_pc_im(dc, dc->pc);
             /* fall through */
-        case DISAS_JUMP:
+        case DJ_JUMP:
             gen_goto_ptr();
             break;
         default:
             /* indicate that the hash table must be used to find the nex=
t TB */
             tcg_gen_exit_tb(0);
             break;
-        case DISAS_TB_JUMP:
-        case DISAS_EXC:
+        case DJ_TB_JUMP:
+        case DJ_EXC:
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
diff --git a/target/arm/translate.h b/target/arm/translate.h
index e42fdbe61c..d6511a2524 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -119,31 +119,33 @@ static void disas_set_insn_syndrome(DisasContext *s=
, uint32_t syn)
     s->insn_start_idx =3D 0;
 }
=20
-/* target-specific extra values for is_jmp */
-/* TODO: rename as DJ_* when transitioning this target to generic transl=
ation */
+/* Target-specific values for DisasContextBase::is_jmp */
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
 /* M profile branch which might be an exception return (and so needs
  * custom end-of-TB code)
  */
-#define DISAS_BX_EXCRET (DISAS_TARGET + 7)
+#define DJ_BX_EXCRET (DJ_TARGET + 10)
 /* For instructions which want an immediate exit to the main loop,
  * as opposed to attempting to use lookup_and_goto_ptr.
  */
-#define DISAS_EXIT (DISAS_TARGET + 8)
+#define DJ_EXIT (DJ_TARGET + 11)
=20
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
