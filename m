Received: from eggs.gnu.org ([2001:4830:134:3::10]:34927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4Dc-0005hk-EN
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4DZ-0005ee-7z
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:52:36 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 12:52:20 +0300
Message-Id: <149838433995.6497.5247761690570877525.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 17/26] target: [tcg,
 arm] Port to DisasContextBase
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
 target/arm/translate-a64.c |  113 ++++++++++++++++++--------------
 target/arm/translate.c     |  154 ++++++++++++++++++++++++++++----------=
------
 target/arm/translate.h     |   11 ++-
 3 files changed, 167 insertions(+), 111 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d2fe2718ad..8d48251321 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -302,17 +302,21 @@ static void gen_exception(int excp, uint32_t syndro=
me, uint32_t target_el)
=20
 static void gen_exception_internal_insn(DisasContext *s, int offset, int=
 excp)
 {
+    DisasContextBase *b =3D &s->base;
+
     gen_a64_set_pc_im(s->pc - offset);
     gen_exception_internal(excp);
-    s->is_jmp =3D DJ_EXC;
+    b->is_jmp =3D DJ_EXC;
 }
=20
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
                                uint32_t syndrome, uint32_t target_el)
 {
+    DisasContextBase *b =3D &s->base;
+
     gen_a64_set_pc_im(s->pc - offset);
     gen_exception(excp, syndrome, target_el);
-    s->is_jmp =3D DJ_EXC;
+    b->is_jmp =3D DJ_EXC;
 }
=20
 static void gen_ss_advance(DisasContext *s)
@@ -328,6 +332,8 @@ static void gen_ss_advance(DisasContext *s)
=20
 static void gen_step_complete_exception(DisasContext *s)
 {
+    DisasContextBase *b =3D &s->base;
+
     /* We just completed step of an insn. Move from Active-not-pending
      * to Active-pending, and then also take the swstep exception.
      * This corresponds to making the (IMPDEF) choice to prioritize
@@ -340,21 +346,23 @@ static void gen_step_complete_exception(DisasContex=
t *s)
     gen_ss_advance(s);
     gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
                   default_exception_el(s));
-    s->is_jmp =3D DJ_EXC;
+    b->is_jmp =3D DJ_EXC;
 }
=20
 static inline bool use_goto_tb(DisasContext *s, int n, uint64_t dest)
 {
+    DisasContextBase *b =3D &s->base;
+
     /* No direct tb linking with singlestep (either QEMU's or the ARM
      * debug architecture kind) or deterministic io
      */
-    if (s->singlestep_enabled || s->ss_active || (s->tb->cflags & CF_LAS=
T_IO)) {
+    if (b->singlestep_enabled || s->ss_active || (b->tb->cflags & CF_LAS=
T_IO)) {
         return false;
     }
=20
 #ifndef CONFIG_USER_ONLY
     /* Only link tbs from inside the same guest page */
-    if ((s->tb->pc & TARGET_PAGE_MASK) !=3D (dest & TARGET_PAGE_MASK)) {
+    if ((b->tb->pc & TARGET_PAGE_MASK) !=3D (dest & TARGET_PAGE_MASK)) {
         return false;
     }
 #endif
@@ -364,23 +372,24 @@ static inline bool use_goto_tb(DisasContext *s, int=
 n, uint64_t dest)
=20
 static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
 {
+    DisasContextBase *b =3D &s->base;
     TranslationBlock *tb;
=20
-    tb =3D s->tb;
+    tb =3D b->tb;
     if (use_goto_tb(s, n, dest)) {
         tcg_gen_goto_tb(n);
         gen_a64_set_pc_im(dest);
         tcg_gen_exit_tb((intptr_t)tb + n);
-        s->is_jmp =3D DJ_TB_JUMP;
+        b->is_jmp =3D DJ_TB_JUMP;
     } else {
         gen_a64_set_pc_im(dest);
         if (s->ss_active) {
             gen_step_complete_exception(s);
-        } else if (s->singlestep_enabled) {
+        } else if (b->singlestep_enabled) {
             gen_exception_internal(EXCP_DEBUG);
         } else {
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
-            s->is_jmp =3D DJ_TB_JUMP;
+            b->is_jmp =3D DJ_TB_JUMP;
         }
     }
 }
@@ -1320,6 +1329,7 @@ static void disas_cond_b_imm(DisasContext *s, uint3=
2_t insn)
 static void handle_hint(DisasContext *s, uint32_t insn,
                         unsigned int op1, unsigned int op2, unsigned int=
 crm)
 {
+    DisasContextBase *b =3D &s->base;
     unsigned int selector =3D crm << 3 | op2;
=20
     if (op1 !=3D 3) {
@@ -1331,16 +1341,16 @@ static void handle_hint(DisasContext *s, uint32_t=
 insn,
     case 0: /* NOP */
         return;
     case 3: /* WFI */
-        s->is_jmp =3D DJ_WFI;
+        b->is_jmp =3D DJ_WFI;
         return;
     case 1: /* YIELD */
         if (!parallel_cpus) {
-            s->is_jmp =3D DJ_YIELD;
+            b->is_jmp =3D DJ_YIELD;
         }
         return;
     case 2: /* WFE */
         if (!parallel_cpus) {
-            s->is_jmp =3D DJ_WFE;
+            b->is_jmp =3D DJ_WFE;
         }
         return;
     case 4: /* SEV */
@@ -1362,6 +1372,7 @@ static void gen_clrex(DisasContext *s, uint32_t ins=
n)
 static void handle_sync(DisasContext *s, uint32_t insn,
                         unsigned int op1, unsigned int op2, unsigned int=
 crm)
 {
+    DisasContextBase *b =3D &s->base;
     TCGBar bar;
=20
     if (op1 !=3D 3) {
@@ -1393,7 +1404,7 @@ static void handle_sync(DisasContext *s, uint32_t i=
nsn,
          * a self-modified code correctly and also to take
          * any pending interrupts immediately.
          */
-        s->is_jmp =3D DJ_UPDATE;
+        b->is_jmp =3D DJ_UPDATE;
         return;
     default:
         unallocated_encoding(s);
@@ -1405,6 +1416,7 @@ static void handle_sync(DisasContext *s, uint32_t i=
nsn,
 static void handle_msr_i(DisasContext *s, uint32_t insn,
                          unsigned int op1, unsigned int op2, unsigned in=
t crm)
 {
+    DisasContextBase *b =3D &s->base;
     int op =3D op1 << 3 | op2;
     switch (op) {
     case 0x05: /* SPSel */
@@ -1422,7 +1434,7 @@ static void handle_msr_i(DisasContext *s, uint32_t =
insn,
         gen_helper_msr_i_pstate(cpu_env, tcg_op, tcg_imm);
         tcg_temp_free_i32(tcg_imm);
         tcg_temp_free_i32(tcg_op);
-        s->is_jmp =3D DJ_UPDATE;
+        b->is_jmp =3D DJ_UPDATE;
         break;
     }
     default:
@@ -1486,6 +1498,7 @@ static void handle_sys(DisasContext *s, uint32_t in=
sn, bool isread,
                        unsigned int op0, unsigned int op1, unsigned int =
op2,
                        unsigned int crn, unsigned int crm, unsigned int =
rt)
 {
+    DisasContextBase *b =3D &s->base;
     const ARMCPRegInfo *ri;
     TCGv_i64 tcg_rt;
=20
@@ -1557,7 +1570,7 @@ static void handle_sys(DisasContext *s, uint32_t in=
sn, bool isread,
         break;
     }
=20
-    if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+    if ((b->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         gen_io_start(cpu_env);
     }
=20
@@ -1588,16 +1601,16 @@ static void handle_sys(DisasContext *s, uint32_t =
insn, bool isread,
         }
     }
=20
-    if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+    if ((b->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) *=
/
         gen_io_end(cpu_env);
-        s->is_jmp =3D DJ_UPDATE;
+        b->is_jmp =3D DJ_UPDATE;
     } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
-        s->is_jmp =3D DJ_UPDATE;
+        b->is_jmp =3D DJ_UPDATE;
     }
 }
=20
@@ -1757,6 +1770,7 @@ static void disas_exc(DisasContext *s, uint32_t ins=
n)
  */
 static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 {
+    DisasContextBase *b =3D &s->base;
     unsigned int opc, op2, op3, rn, op4;
=20
     opc =3D extract32(insn, 21, 4);
@@ -1786,7 +1800,7 @@ static void disas_uncond_b_reg(DisasContext *s, uin=
t32_t insn)
             return;
         }
         gen_helper_exception_return(cpu_env);
-        s->is_jmp =3D DJ_JUMP;
+        b->is_jmp =3D DJ_JUMP;
         return;
     case 5: /* DRPS */
         if (rn !=3D 0x1f) {
@@ -1800,7 +1814,7 @@ static void disas_uncond_b_reg(DisasContext *s, uin=
t32_t insn)
         return;
     }
=20
-    s->is_jmp =3D DJ_JUMP;
+    b->is_jmp =3D DJ_JUMP;
 }
=20
 /* C3.2 Branches, exception generating and system instructions */
@@ -11188,23 +11202,23 @@ static void disas_a64_insn(CPUARMState *env, Di=
sasContext *s)
     free_tmp_a64(s);
 }
=20
-void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
+void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
+                               TranslationBlock *tb)
 {
     CPUState *cs =3D CPU(cpu);
     CPUARMState *env =3D &cpu->env;
-    DisasContext dc1, *dc =3D &dc1;
-    target_ulong pc_start;
+    DisasContext *dc =3D container_of(db, DisasContext, base);
     target_ulong next_page_start;
-    int num_insns;
     int max_insns;
=20
-    pc_start =3D tb->pc;
-
-    dc->tb =3D tb;
+    db->tb =3D tb;
+    db->pc_first =3D tb->pc;
+    db->pc_next =3D db->pc_first;
+    db->is_jmp =3D DJ_NEXT;
+    db->num_insns =3D 0;
+    db->singlestep_enabled =3D cs->singlestep_enabled;
=20
-    dc->is_jmp =3D DJ_NEXT;
-    dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cs->singlestep_enabled;
+    dc->pc =3D db->pc_first;
     dc->condjmp =3D 0;
=20
     dc->aarch64 =3D 1;
@@ -11253,8 +11267,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
=20
     init_tmp_a64_array(dc);
=20
-    next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE=
;
-    num_insns =3D 0;
+    next_page_start =3D (db->pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_=
SIZE;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
         max_insns =3D CF_COUNT_MASK;
@@ -11268,9 +11281,9 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
     tcg_clear_temp_count();
=20
     do {
+        db->num_insns++;
         dc->insn_start_idx =3D tcg_op_buf_count();
         tcg_gen_insn_start(dc->pc, 0, 0);
-        num_insns++;
=20
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
@@ -11280,7 +11293,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
                         gen_a64_set_pc_im(dc->pc);
                         gen_helper_check_breakpoints(cpu_env);
                         /* End the TB early; it likely won't be executed=
 */
-                        dc->is_jmp =3D DJ_UPDATE;
+                        db->is_jmp =3D DJ_UPDATE;
                     } else {
                         gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
                         /* The address covered by the breakpoint must be
@@ -11296,7 +11309,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
             }
         }
=20
-        if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (db->num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO))=
 {
             gen_io_start(cpu_env);
         }
=20
@@ -11311,10 +11324,10 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Tra=
nslationBlock *tb)
              * "did not step an insn" case, and so the syndrome ISV and =
EX
              * bits should be zero.
              */
-            assert(num_insns =3D=3D 1);
+            assert(db->num_insns =3D=3D 1);
             gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                           default_exception_el(dc));
-            dc->is_jmp =3D DJ_EXC;
+            db->is_jmp =3D DJ_EXC;
             break;
         }
=20
@@ -11330,26 +11343,26 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Tra=
nslationBlock *tb)
          * Also stop translation when a page boundary is reached.  This
          * ensures prefetch aborts occur at the right place.
          */
-    } while (!dc->is_jmp && !tcg_op_buf_full() &&
+    } while (!db->is_jmp && !tcg_op_buf_full() &&
              !cs->singlestep_enabled &&
              !singlestep &&
              !dc->ss_active &&
              dc->pc < next_page_start &&
-             num_insns < max_insns);
+             db->num_insns < max_insns);
=20
     if (tb->cflags & CF_LAST_IO) {
         gen_io_end(cpu_env);
     }
=20
     if (unlikely(cs->singlestep_enabled || dc->ss_active)
-        && dc->is_jmp !=3D DJ_EXC) {
+        && db->is_jmp !=3D DJ_EXC) {
         /* Note that this means single stepping WFI doesn't halt the CPU.
          * For conditional branch insns this is harmless unreachable cod=
e as
          * gen_goto_tb() has already handled emitting the debug exceptio=
n
          * (and thus a tb-jump is not possible when singlestepping).
          */
-        assert(dc->is_jmp !=3D DJ_TB_JUMP);
-        if (dc->is_jmp !=3D DJ_JUMP) {
+        assert(db->is_jmp !=3D DJ_TB_JUMP);
+        if (db->is_jmp !=3D DJ_JUMP) {
             gen_a64_set_pc_im(dc->pc);
         }
         if (cs->singlestep_enabled) {
@@ -11358,7 +11371,9 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
             gen_step_complete_exception(dc);
         }
     } else {
-        switch (dc->is_jmp) {
+        /* Cast because target-specific values are not in generic enum *=
/
+        unsigned int is_jmp =3D (unsigned int)db->is_jmp;
+        switch (is_jmp) {
         case DJ_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
             break;
@@ -11396,20 +11411,20 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Tra=
nslationBlock *tb)
     }
=20
 done_generating:
-    gen_tb_end(tb, num_insns);
+    gen_tb_end(tb, db->num_insns);
=20
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(pc_start)) {
+        qemu_log_in_addr_range(db->pc_first)) {
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start,
+        qemu_log("IN: %s\n", lookup_symbol(db->pc_first));
+        log_target_disas(cs, db->pc_first, dc->pc - db->pc_first,
                          4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
         qemu_log("\n");
         qemu_log_unlock();
     }
 #endif
-    tb->size =3D dc->pc - pc_start;
-    tb->icount =3D num_insns;
+    tb->size =3D dc->pc - db->pc_first;
+    tb->icount =3D db->num_insns;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 04063fed6b..19d042d843 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -217,6 +217,8 @@ static inline TCGv_i32 load_reg(DisasContext *s, int =
reg)
    marked as dead.  */
 static void store_reg(DisasContext *s, int reg, TCGv_i32 var)
 {
+    DisasContextBase *b =3D &s->base;
+
     if (reg =3D=3D 15) {
         /* In Thumb mode, we must ignore bit 0.
          * In ARM mode, for ARMv4 and ARMv5, it is UNPREDICTABLE if bits=
 [1:0]
@@ -224,7 +226,7 @@ static void store_reg(DisasContext *s, int reg, TCGv_=
i32 var)
          * We choose to ignore [1:0] in ARM mode for all architecture ve=
rsions.
          */
         tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
-        s->is_jmp =3D DJ_JUMP;
+        b->is_jmp =3D DJ_JUMP;
     }
     tcg_gen_mov_i32(cpu_R[reg], var);
     tcg_temp_free_i32(var);
@@ -285,6 +287,8 @@ static void gen_ss_advance(DisasContext *s)
=20
 static void gen_step_complete_exception(DisasContext *s)
 {
+    DisasContextBase *b =3D &s->base;
+
     /* We just completed step of an insn. Move from Active-not-pending
      * to Active-pending, and then also take the swstep exception.
      * This corresponds to making the (IMPDEF) choice to prioritize
@@ -297,7 +301,7 @@ static void gen_step_complete_exception(DisasContext =
*s)
     gen_ss_advance(s);
     gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
                   default_exception_el(s));
-    s->is_jmp =3D DJ_EXC;
+    b->is_jmp =3D DJ_EXC;
 }
=20
 static void gen_singlestep_exception(DisasContext *s)
@@ -315,13 +319,15 @@ static void gen_singlestep_exception(DisasContext *=
s)
=20
 static inline bool is_singlestepping(DisasContext *s)
 {
+    DisasContextBase *b =3D &s->base;
+
     /* Return true if we are singlestepping either because of
      * architectural singlestep or QEMU gdbstub singlestep. This does
      * not include the command line '-singlestep' mode which is rather
      * misnamed as it only means "one instruction per TB" and doesn't
      * affect the code we generate.
      */
-    return s->singlestep_enabled || s->ss_active;
+    return b->singlestep_enabled || s->ss_active;
 }
=20
 static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
@@ -926,9 +932,10 @@ static inline void gen_set_pc_im(DisasContext *s, ta=
rget_ulong val)
 /* Set PC and Thumb state from an immediate address.  */
 static inline void gen_bx_im(DisasContext *s, uint32_t addr)
 {
+    DisasContextBase *b =3D &s->base;
     TCGv_i32 tmp;
=20
-    s->is_jmp =3D DJ_JUMP;
+    b->is_jmp =3D DJ_JUMP;
     if (s->thumb !=3D (addr & 1)) {
         tmp =3D tcg_temp_new_i32();
         tcg_gen_movi_i32(tmp, addr & 1);
@@ -941,7 +948,9 @@ static inline void gen_bx_im(DisasContext *s, uint32_=
t addr)
 /* Set PC and Thumb state from var.  var is marked as dead.  */
 static inline void gen_bx(DisasContext *s, TCGv_i32 var)
 {
-    s->is_jmp =3D DJ_JUMP;
+    DisasContextBase *b =3D &s->base;
+
+    b->is_jmp =3D DJ_JUMP;
     tcg_gen_andi_i32(cpu_R[15], var, ~1);
     tcg_gen_andi_i32(var, var, 1);
     store_cpu_field(var, thumb);
@@ -954,12 +963,14 @@ static inline void gen_bx(DisasContext *s, TCGv_i32=
 var)
  */
 static inline void gen_bx_excret(DisasContext *s, TCGv_i32 var)
 {
+    DisasContextBase *b =3D &s->base;
+
     /* Generate the same code here as for a simple bx, but flag via
-     * s->is_jmp that we need to do the rest of the work later.
+     * b->is_jmp that we need to do the rest of the work later.
      */
     gen_bx(s, var);
     if (s->v7m_handler_mode && arm_dc_feature(s, ARM_FEATURE_M)) {
-        s->is_jmp =3D DJ_BX_EXCRET;
+        b->is_jmp =3D DJ_BX_EXCRET;
     }
 }
=20
@@ -1146,6 +1157,8 @@ DO_GEN_ST(32, MO_UL)
=20
 static inline void gen_hvc(DisasContext *s, int imm16)
 {
+    DisasContextBase *b =3D &s->base;
+
     /* The pre HVC helper handles cases when HVC gets trapped
      * as an undefined insn by runtime configuration (ie before
      * the insn really executes).
@@ -1159,11 +1172,12 @@ static inline void gen_hvc(DisasContext *s, int i=
mm16)
      */
     s->svc_imm =3D imm16;
     gen_set_pc_im(s, s->pc);
-    s->is_jmp =3D DJ_HVC;
+    b->is_jmp =3D DJ_HVC;
 }
=20
 static inline void gen_smc(DisasContext *s)
 {
+    DisasContextBase *b =3D &s->base;
     /* As with HVC, we may take an exception either before or after
      * the insn executes.
      */
@@ -1174,31 +1188,37 @@ static inline void gen_smc(DisasContext *s)
     gen_helper_pre_smc(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     gen_set_pc_im(s, s->pc);
-    s->is_jmp =3D DJ_SMC;
+    b->is_jmp =3D DJ_SMC;
 }
=20
 static void gen_exception_internal_insn(DisasContext *s, int offset, int=
 excp)
 {
+    DisasContextBase *b =3D &s->base;
+
     gen_set_condexec(s);
     gen_set_pc_im(s, s->pc - offset);
     gen_exception_internal(excp);
-    s->is_jmp =3D DJ_EXC;
+    b->is_jmp =3D DJ_EXC;
 }
=20
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
                                int syn, uint32_t target_el)
 {
+    DisasContextBase *b =3D &s->base;
+
     gen_set_condexec(s);
     gen_set_pc_im(s, s->pc - offset);
     gen_exception(excp, syn, target_el);
-    s->is_jmp =3D DJ_EXC;
+    b->is_jmp =3D DJ_EXC;
 }
=20
 /* Force a TB lookup after an instruction that changes the CPU state.  *=
/
 static inline void gen_lookup_tb(DisasContext *s)
 {
+    DisasContextBase *b =3D &s->base;
+
     tcg_gen_movi_i32(cpu_R[15], s->pc & ~1);
-    s->is_jmp =3D DJ_EXIT;
+    b->is_jmp =3D DJ_EXIT;
 }
=20
 static inline void gen_hlt(DisasContext *s, int imm)
@@ -4143,7 +4163,9 @@ static int disas_vfp_insn(DisasContext *s, uint32_t=
 insn)
 static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
 {
 #ifndef CONFIG_USER_ONLY
-    return (s->tb->pc & TARGET_PAGE_MASK) =3D=3D (dest & TARGET_PAGE_MAS=
K) ||
+    DisasContextBase *b =3D &s->base;
+
+    return (b->tb->pc & TARGET_PAGE_MASK) =3D=3D (dest & TARGET_PAGE_MAS=
K) ||
            ((s->pc - 1) & TARGET_PAGE_MASK) =3D=3D (dest & TARGET_PAGE_M=
ASK);
 #else
     return true;
@@ -4160,10 +4182,12 @@ static void gen_goto_ptr(void)
=20
 static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
 {
+    DisasContextBase *b =3D &s->base;
+
     if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(n);
         gen_set_pc_im(s, dest);
-        tcg_gen_exit_tb((uintptr_t)s->tb + n);
+        tcg_gen_exit_tb((uintptr_t)b->tb + n);
     } else {
         gen_set_pc_im(s, dest);
         gen_goto_ptr();
@@ -4172,6 +4196,8 @@ static void gen_goto_tb(DisasContext *s, int n, tar=
get_ulong dest)
=20
 static inline void gen_jmp (DisasContext *s, uint32_t dest)
 {
+    DisasContextBase *b =3D &s->base;
+
     if (unlikely(is_singlestepping(s))) {
         /* An indirect jump so that we still trigger the debug exception=
.  */
         if (s->thumb)
@@ -4179,7 +4205,7 @@ static inline void gen_jmp (DisasContext *s, uint32=
_t dest)
         gen_bx_im(s, dest);
     } else {
         gen_goto_tb(s, 0, dest);
-        s->is_jmp =3D DJ_TB_JUMP;
+        b->is_jmp =3D DJ_TB_JUMP;
     }
 }
=20
@@ -4413,6 +4439,7 @@ undef:
=20
 static void gen_msr_banked(DisasContext *s, int r, int sysm, int rn)
 {
+    DisasContextBase *b =3D &s->base;
     TCGv_i32 tcg_reg, tcg_tgtmode, tcg_regno;
     int tgtmode =3D 0, regno =3D 0;
=20
@@ -4430,11 +4457,12 @@ static void gen_msr_banked(DisasContext *s, int r=
, int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     tcg_temp_free_i32(tcg_reg);
-    s->is_jmp =3D DJ_UPDATE;
+    b->is_jmp =3D DJ_UPDATE;
 }
=20
 static void gen_mrs_banked(DisasContext *s, int r, int sysm, int rn)
 {
+    DisasContextBase *b =3D &s->base;
     TCGv_i32 tcg_reg, tcg_tgtmode, tcg_regno;
     int tgtmode =3D 0, regno =3D 0;
=20
@@ -4452,7 +4480,7 @@ static void gen_mrs_banked(DisasContext *s, int r, =
int sysm, int rn)
     tcg_temp_free_i32(tcg_tgtmode);
     tcg_temp_free_i32(tcg_regno);
     store_reg(s, rn, tcg_reg);
-    s->is_jmp =3D DJ_UPDATE;
+    b->is_jmp =3D DJ_UPDATE;
 }
=20
 /* Store value to PC as for an exception return (ie don't
@@ -4468,6 +4496,8 @@ static void store_pc_exc_ret(DisasContext *s, TCGv_=
i32 pc)
 /* Generate a v6 exception return.  Marks both values as dead.  */
 static void gen_rfe(DisasContext *s, TCGv_i32 pc, TCGv_i32 cpsr)
 {
+    DisasContextBase *b =3D &s->base;
+
     store_pc_exc_ret(s, pc);
     /* The cpsr_write_eret helper will mask the low bits of PC
      * appropriately depending on the new Thumb bit, so it must
@@ -4475,7 +4505,7 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, T=
CGv_i32 cpsr)
      */
     gen_helper_cpsr_write_eret(cpu_env, cpsr);
     tcg_temp_free_i32(cpsr);
-    s->is_jmp =3D DJ_JUMP;
+    b->is_jmp =3D DJ_JUMP;
 }
=20
 /* Generate an old-style exception return. Marks pc as dead. */
@@ -4494,21 +4524,23 @@ static void gen_exception_return(DisasContext *s,=
 TCGv_i32 pc)
  */
 static void gen_nop_hint(DisasContext *s, int val)
 {
+    DisasContextBase *b =3D &s->base;
+
     switch (val) {
     case 1: /* yield */
         if (!parallel_cpus) {
             gen_set_pc_im(s, s->pc);
-            s->is_jmp =3D DJ_YIELD;
+            b->is_jmp =3D DJ_YIELD;
         }
         break;
     case 3: /* wfi */
         gen_set_pc_im(s, s->pc);
-        s->is_jmp =3D DJ_WFI;
+        b->is_jmp =3D DJ_WFI;
         break;
     case 2: /* wfe */
         if (!parallel_cpus) {
             gen_set_pc_im(s, s->pc);
-            s->is_jmp =3D DJ_WFE;
+            b->is_jmp =3D DJ_WFE;
         }
         break;
     case 4: /* sev */
@@ -7529,6 +7561,8 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
=20
 static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 {
+    DisasContextBase *b =3D &s->base;
+
     int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
     const ARMCPRegInfo *ri;
=20
@@ -7647,13 +7681,13 @@ static int disas_coproc_insn(DisasContext *s, uin=
t32_t insn)
                 return 1;
             }
             gen_set_pc_im(s, s->pc);
-            s->is_jmp =3D DJ_WFI;
+            b->is_jmp =3D DJ_WFI;
             return 0;
         default:
             break;
         }
=20
-        if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+        if ((b->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             gen_io_start(cpu_env);
         }
=20
@@ -7744,7 +7778,7 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
             }
         }
=20
-        if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
+        if ((b->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             /* I/O operations must end the TB here (whether read or writ=
e) */
             gen_io_end(cpu_env);
             gen_lookup_tb(s);
@@ -7946,6 +7980,7 @@ static void gen_store_exclusive(DisasContext *s, in=
t rd, int rt, int rt2,
 static void gen_srs(DisasContext *s,
                     uint32_t mode, uint32_t amode, bool writeback)
 {
+    DisasContextBase *b =3D &s->base;
     int32_t offset;
     TCGv_i32 addr, tmp;
     bool undef =3D false;
@@ -8058,11 +8093,12 @@ static void gen_srs(DisasContext *s,
         tcg_temp_free_i32(tmp);
     }
     tcg_temp_free_i32(addr);
-    s->is_jmp =3D DJ_UPDATE;
+    b->is_jmp =3D DJ_UPDATE;
 }
=20
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
+    DisasContextBase *b =3D &s->base;
     unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -8146,7 +8182,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
             /* setend */
             if (((insn >> 9) & 1) !=3D !!(s->be_data =3D=3D MO_BE)) {
                 gen_helper_setend(cpu_env);
-                s->is_jmp =3D DJ_UPDATE;
+                b->is_jmp =3D DJ_UPDATE;
             }
             return;
         } else if ((insn & 0x0fffff00) =3D=3D 0x057ff000) {
@@ -9519,7 +9555,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
                     tmp =3D load_cpu_field(spsr);
                     gen_helper_cpsr_write_eret(cpu_env, tmp);
                     tcg_temp_free_i32(tmp);
-                    s->is_jmp =3D DJ_JUMP;
+                    b->is_jmp =3D DJ_JUMP;
                 }
             }
             break;
@@ -9557,7 +9593,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
             /* swi */
             gen_set_pc_im(s, s->pc);
             s->svc_imm =3D extract32(insn, 0, 24);
-            s->is_jmp =3D DJ_SWI;
+            b->is_jmp =3D DJ_SWI;
             break;
         default:
         illegal_op:
@@ -11013,6 +11049,7 @@ illegal_op:
=20
 static void disas_thumb_insn(CPUARMState *env, DisasContext *s)
 {
+    DisasContextBase *b =3D &s->base;
     uint32_t val, insn, op, rm, rn, rd, shift, cond;
     int32_t offset;
     int i;
@@ -11619,7 +11656,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
                 ARCH(6);
                 if (((insn >> 3) & 1) !=3D !!(s->be_data =3D=3D MO_BE)) =
{
                     gen_helper_setend(cpu_env);
-                    s->is_jmp =3D DJ_UPDATE;
+                    b->is_jmp =3D DJ_UPDATE;
                 }
                 break;
             case 3:
@@ -11713,7 +11750,7 @@ static void disas_thumb_insn(CPUARMState *env, Di=
sasContext *s)
             /* swi */
             gen_set_pc_im(s, s->pc);
             s->svc_imm =3D extract32(insn, 0, 8);
-            s->is_jmp =3D DJ_SWI;
+            b->is_jmp =3D DJ_SWI;
             break;
         }
         /* generate a conditional jump to next instruction */
@@ -11792,9 +11829,8 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
     CPUARMState *env =3D cpu->env_ptr;
     ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
     DisasContext dc1, *dc =3D &dc1;
-    target_ulong pc_start;
+    DisasContextBase *db =3D &dc->base;
     target_ulong next_page_start;
-    int num_insns;
     int max_insns;
     bool end_of_page;
=20
@@ -11804,17 +11840,18 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
      * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
      */
     if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(arm_cpu, tb);
+        gen_intermediate_code_a64(db, arm_cpu, tb);
         return;
     }
=20
-    pc_start =3D tb->pc;
-
-    dc->tb =3D tb;
+    db->tb =3D tb;
+    db->pc_first =3D tb->pc;
+    db->pc_next =3D db->pc_first;
+    db->is_jmp =3D DJ_NEXT;
+    db->num_insns =3D 0;
+    db->singlestep_enabled =3D cpu->singlestep_enabled;
=20
-    dc->is_jmp =3D DJ_NEXT;
-    dc->pc =3D pc_start;
-    dc->singlestep_enabled =3D cpu->singlestep_enabled;
+    dc->pc =3D db->pc_first;
     dc->condjmp =3D 0;
=20
     dc->aarch64 =3D 0;
@@ -11871,8 +11908,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
     cpu_V1 =3D cpu_F1d;
     /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
     cpu_M0 =3D tcg_temp_new_i64();
-    next_page_start =3D (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE=
;
-    num_insns =3D 0;
+    next_page_start =3D (db->pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_=
SIZE;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
         max_insns =3D CF_COUNT_MASK;
@@ -11924,11 +11960,11 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
         store_cpu_field(tmp, condexec_bits);
       }
     do {
+        db->num_insns++;
         dc->insn_start_idx =3D tcg_op_buf_count();
         tcg_gen_insn_start(dc->pc,
                            (dc->condexec_cond << 4) | (dc->condexec_mask=
 >> 1),
                            0);
-        num_insns++;
=20
 #ifdef CONFIG_USER_ONLY
         /* Intercept jump to the magic kernel page.  */
@@ -11950,7 +11986,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
                         gen_set_pc_im(dc, dc->pc);
                         gen_helper_check_breakpoints(cpu_env);
                         /* End the TB early; it's likely not going to be=
 executed */
-                        dc->is_jmp =3D DJ_UPDATE;
+                        db->is_jmp =3D DJ_UPDATE;
                     } else {
                         gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
                         /* The address covered by the breakpoint must be
@@ -11968,7 +12004,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
             }
         }
=20
-        if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (db->num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO))=
 {
             gen_io_start(cpu_env);
         }
=20
@@ -11983,7 +12019,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
              * "did not step an insn" case, and so the syndrome ISV and =
EX
              * bits should be zero.
              */
-            assert(num_insns =3D=3D 1);
+            assert(db->num_insns =3D=3D 1);
             gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                           default_exception_el(dc));
             goto done_generating;
@@ -12005,7 +12041,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
             disas_arm_insn(dc, insn);
         }
=20
-        if (dc->condjmp && !dc->is_jmp) {
+        if (dc->condjmp && !db->is_jmp) {
             gen_set_label(dc->condlabel);
             dc->condjmp =3D 0;
         }
@@ -12032,11 +12068,11 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
         end_of_page =3D (dc->pc >=3D next_page_start) ||
             ((dc->pc >=3D next_page_start - 3) && insn_crosses_page(env,=
 dc));
=20
-    } while (!dc->is_jmp && !tcg_op_buf_full() &&
+    } while (!db->is_jmp && !tcg_op_buf_full() &&
              !is_singlestepping(dc) &&
              !singlestep &&
              !end_of_page &&
-             num_insns < max_insns);
+             db->num_insns < max_insns);
=20
     if (tb->cflags & CF_LAST_IO) {
         if (dc->condjmp) {
@@ -12051,7 +12087,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
        instruction was a conditional branch or trap, and the PC has
        already been written.  */
     gen_set_condexec(dc);
-    if (dc->is_jmp =3D=3D DJ_BX_EXCRET) {
+    if (db->is_jmp =3D=3D DJ_BX_EXCRET) {
         /* Exception return branches need some special case code at the
          * end of the TB, which is complex enough that it has to
          * handle the single-step vs not and the condition-failed
@@ -12059,8 +12095,10 @@ void gen_intermediate_code(CPUState *cpu, Transl=
ationBlock *tb)
          */
         gen_bx_excret_final_code(dc);
     } else if (unlikely(is_singlestepping(dc))) {
+        /* Cast because target-specific values are not in generic enum *=
/
+        unsigned int is_jmp =3D (unsigned int)db->is_jmp;
         /* Unconditional and "condition passed" instruction codepath. */
-        switch (dc->is_jmp) {
+        switch (is_jmp) {
         case DJ_SWI:
             gen_ss_advance(dc);
             gen_exception(EXCP_SWI, syn_aa32_svc(dc->svc_imm, dc->thumb)=
,
@@ -12083,6 +12121,8 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
             gen_singlestep_exception(dc);
         }
     } else {
+        /* Cast because target-specific values are not in generic enum *=
/
+        unsigned int is_jmp =3D (unsigned int)db->is_jmp;
         /* While branches must always occur at the end of an IT block,
            there are a few other things that can cause us to terminate
            the TB in the middle of an IT block:
@@ -12091,7 +12131,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
             - Hardware watchpoints.
            Hardware breakpoints have already been handled and skip this =
code.
          */
-        switch(dc->is_jmp) {
+        switch (is_jmp) {
         case DJ_NEXT:
             gen_goto_tb(dc, 1, dc->pc);
             break;
@@ -12148,22 +12188,22 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
     }
=20
 done_generating:
-    gen_tb_end(tb, num_insns);
+    gen_tb_end(tb, db->num_insns);
=20
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(pc_start)) {
+        qemu_log_in_addr_range(db->pc_first)) {
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cpu, pc_start, dc->pc - pc_start,
+        qemu_log("IN: %s\n", lookup_symbol(db->pc_first));
+        log_target_disas(cpu, db->pc_first, dc->pc - db->pc_first,
                          dc->thumb | (dc->sctlr_b << 1));
         qemu_log("\n");
         qemu_log_unlock();
     }
 #endif
-    tb->size =3D dc->pc - pc_start;
-    tb->icount =3D num_insns;
+    tb->size =3D dc->pc - db->pc_first;
+    tb->icount =3D db->num_insns;
 }
=20
 static const char *cpu_mode_names[16] =3D {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index d6511a2524..190d461134 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -3,9 +3,10 @@
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
@@ -13,8 +14,6 @@ typedef struct DisasContext {
     /* Thumb-2 conditional execution bits.  */
     int condexec_mask;
     int condexec_cond;
-    struct TranslationBlock *tb;
-    int singlestep_enabled;
     int thumb;
     int sctlr_b;
     TCGMemOp be_data;
@@ -149,7 +148,8 @@ static void disas_set_insn_syndrome(DisasContext *s, =
uint32_t syn)
=20
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
-void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb);
+void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
+                               TranslationBlock *tb);
 void gen_a64_set_pc_im(uint64_t val);
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
@@ -158,7 +158,8 @@ static inline void a64_translate_init(void)
 {
 }
=20
-static inline void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlo=
ck *tb)
+static inline void gen_intermediate_code_a64(DisasContextBase *db, ARMCP=
U *cpu,
+                                             TranslationBlock *tb)
 {
 }
=20
