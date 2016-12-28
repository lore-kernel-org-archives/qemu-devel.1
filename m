Received: from eggs.gnu.org ([2001:4830:134:3::10]:44714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH5R-00017X-15
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH5N-00063u-Rf
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:28:21 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:48698 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH5N-000634-54
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:28:17 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Dec 2016 17:28:16 +0100
Message-Id: <148294249595.10801.5235807846405690957.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148294246378.10801.8881527920302104439.stgit@fimbulvetr.bsc.es>
References: <148294246378.10801.8881527920302104439.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 5/6] target: [tcg,
 i386] Port to generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target-i386/translate.c |  304 ++++++++++++++++++++++-------------------=
------
 1 file changed, 140 insertions(+), 164 deletions(-)

diff --git a/target-i386/translate.c b/target-i386/translate.c
index 61d73e286f..a63627b470 100644
--- a/target-i386/translate.c
+++ b/target-i386/translate.c
@@ -69,6 +69,10 @@
     case (2 << 6) | (OP << 3) | 0 ... (2 << 6) | (OP << 3) | 7: \
     case (3 << 6) | (OP << 3) | 0 ... (3 << 6) | (OP << 3) | 7
=20
+#include "exec/translate-all_template.h"
+#define DJ_JUMP (DJ_TARGET + 0)         /* end of block due to call/jump=
 */
+#define DJ_MISC (DJ_TARGET + 1)         /* some other reason */
+
 //#define MACRO_TEST   1
=20
 /* global register indexes */
@@ -94,7 +98,10 @@ static TCGv_i64 cpu_tmp1_i64;
 static int x86_64_hregs;
 #endif
=20
+
 typedef struct DisasContext {
+    DisasContextBase base;
+
     /* current insn context */
     int override; /* -1 if no override */
     int prefix;
@@ -102,8 +109,6 @@ typedef struct DisasContext {
     TCGMemOp dflag;
     target_ulong pc_start;
     target_ulong pc; /* pc =3D eip + cs_base */
-    int is_jmp; /* 1 =3D means jump (stop translation), 2 means CPU
-                   static state change (stop translation) */
     /* current block context */
     target_ulong cs_base; /* base of CS segment */
     int pe;     /* protected mode */
@@ -124,12 +129,10 @@ typedef struct DisasContext {
     int cpl;
     int iopl;
     int tf;     /* TF cpu flag */
-    int singlestep_enabled; /* "hardware" single step enabled */
     int jmp_opt; /* use direct block chaining for direct jumps */
     int repz_opt; /* optimize jumps within repz instructions */
     int mem_index; /* select memory access functions */
     uint64_t flags; /* all execution flags */
-    struct TranslationBlock *tb;
     int popl_esp_hack; /* for correct popl with esp base handling */
     int rip_offset; /* only used in x86_64, but left for simplicity */
     int cpuid_features;
@@ -140,6 +143,8 @@ typedef struct DisasContext {
     int cpuid_xsave_features;
 } DisasContext;
=20
+#include "translate-all_template.h"
+
 static void gen_eob(DisasContext *s);
 static void gen_jmp(DisasContext *s, target_ulong eip);
 static void gen_jmp_tb(DisasContext *s, target_ulong eip, int tb_num);
@@ -1112,7 +1117,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_=
port, int ot)
=20
 static inline void gen_ins(DisasContext *s, TCGMemOp ot)
 {
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (s->base.tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_string_movl_A0_EDI(s);
@@ -1127,14 +1132,14 @@ static inline void gen_ins(DisasContext *s, TCGMe=
mOp ot)
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_EDI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (s->base.tb->cflags & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
=20
 static inline void gen_outs(DisasContext *s, TCGMemOp ot)
 {
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (s->base.tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_string_movl_A0_ESI(s);
@@ -1147,7 +1152,7 @@ static inline void gen_outs(DisasContext *s, TCGMem=
Op ot)
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_ESI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (s->base.tb->cflags & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
@@ -2130,7 +2135,7 @@ static inline int insn_const_size(TCGMemOp ot)
 static inline bool use_goto_tb(DisasContext *s, target_ulong pc)
 {
 #ifndef CONFIG_USER_ONLY
-    return (pc & TARGET_PAGE_MASK) =3D=3D (s->tb->pc & TARGET_PAGE_MASK)=
 ||
+    return (pc & TARGET_PAGE_MASK) =3D=3D (s->base.tb->pc & TARGET_PAGE_=
MASK) ||
            (pc & TARGET_PAGE_MASK) =3D=3D (s->pc_start & TARGET_PAGE_MAS=
K);
 #else
     return true;
@@ -2145,7 +2150,7 @@ static inline void gen_goto_tb(DisasContext *s, int=
 tb_num, target_ulong eip)
         /* jump to same page: we can use a direct jump */
         tcg_gen_goto_tb(tb_num);
         gen_jmp_im(eip);
-        tcg_gen_exit_tb((uintptr_t)s->tb + tb_num);
+        tcg_gen_exit_tb((uintptr_t)s->base.tb + tb_num);
     } else {
         /* jump to another page: currently not optimized */
         gen_jmp_im(eip);
@@ -2166,7 +2171,7 @@ static inline void gen_jcc(DisasContext *s, int b,
=20
         gen_set_label(l1);
         gen_goto_tb(s, 1, val);
-        s->is_jmp =3D DISAS_TB_JUMP;
+        s->base.jmp_type =3D DJ_JUMP;
     } else {
         l1 =3D gen_new_label();
         l2 =3D gen_new_label();
@@ -2237,11 +2242,11 @@ static void gen_movl_seg_T0(DisasContext *s, int =
seg_reg)
            stop as a special handling must be done to disable hardware
            interrupts for the next instruction */
         if (seg_reg =3D=3D R_SS || (s->code32 && seg_reg < R_FS))
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.jmp_type =3D DJ_JUMP;
     } else {
         gen_op_movl_seg_T0_vm(seg_reg);
         if (seg_reg =3D=3D R_SS)
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.jmp_type =3D DJ_JUMP;
     }
 }
=20
@@ -2413,7 +2418,7 @@ static void gen_exception(DisasContext *s, int trap=
no, target_ulong cur_eip)
     gen_update_cc_op(s);
     gen_jmp_im(cur_eip);
     gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
-    s->is_jmp =3D DISAS_TB_JUMP;
+    s->base.jmp_type =3D DJ_JUMP;
 }
=20
 /* Generate #UD for the current instruction.  The assumption here is tha=
t
@@ -2451,7 +2456,7 @@ static void gen_interrupt(DisasContext *s, int intn=
o,
     gen_jmp_im(cur_eip);
     gen_helper_raise_interrupt(cpu_env, tcg_const_i32(intno),
                                tcg_const_i32(next_eip - cur_eip));
-    s->is_jmp =3D DISAS_TB_JUMP;
+    s->base.jmp_type =3D DJ_JUMP;
 }
=20
 static void gen_debug(DisasContext *s, target_ulong cur_eip)
@@ -2459,7 +2464,7 @@ static void gen_debug(DisasContext *s, target_ulong=
 cur_eip)
     gen_update_cc_op(s);
     gen_jmp_im(cur_eip);
     gen_helper_debug(cpu_env);
-    s->is_jmp =3D DISAS_TB_JUMP;
+    s->base.jmp_type =3D DJ_JUMP;
 }
=20
 static void gen_set_hflag(DisasContext *s, uint32_t mask)
@@ -2512,17 +2517,17 @@ static void gen_eob_inhibit_irq(DisasContext *s, =
bool inhibit)
         gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
     }
=20
-    if (s->tb->flags & HF_RF_MASK) {
+    if (s->base.tb->flags & HF_RF_MASK) {
         gen_helper_reset_rf(cpu_env);
     }
-    if (s->singlestep_enabled) {
+    if (s->base.singlestep_enabled) {
         gen_helper_debug(cpu_env);
     } else if (s->tf) {
         gen_helper_single_step(cpu_env);
     } else {
         tcg_gen_exit_tb(0);
     }
-    s->is_jmp =3D DISAS_TB_JUMP;
+    s->base.jmp_type =3D DJ_JUMP;
 }
=20
 /* End of block, resetting the inhibit irq flag.  */
@@ -2539,7 +2544,7 @@ static void gen_jmp_tb(DisasContext *s, target_ulon=
g eip, int tb_num)
     set_cc_op(s, CC_OP_DYNAMIC);
     if (s->jmp_opt) {
         gen_goto_tb(s, tb_num, eip);
-        s->is_jmp =3D DISAS_TB_JUMP;
+        s->base.jmp_type =3D DJ_JUMP;
     } else {
         gen_jmp_im(eip);
         gen_eob(s);
@@ -4376,10 +4381,10 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
     }
 }
=20
-/* convert one instruction. s->is_jmp is set if the translation must
+/* convert one instruction. s->base.jmp_type is set if the translation m=
ust
    be stopped. Return the next pc value */
-static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
-                               target_ulong pc_start)
+static target_ulong gen_intermediate_code_target_disas_insn(
+    DisasContext *s, CPUX86State *env)
 {
     int b, prefixes;
     int shift;
@@ -4387,6 +4392,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
     int rex_w, rex_r;
+    target_ulong pc_start =3D s->base.pc_next;
=20
     s->pc_start =3D s->pc =3D pc_start;
     prefixes =3D 0;
@@ -5327,7 +5333,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
         gen_movl_seg_T0(s, reg);
         gen_pop_update(s, ot);
         /* Note that reg =3D=3D R_SS in gen_movl_seg_T0 always sets is_j=
mp.  */
-        if (s->is_jmp) {
+        if (s->base.jmp_type) {
             gen_jmp_im(s->pc - s->cs_base);
             if (reg =3D=3D R_SS) {
                 s->tf =3D 0;
@@ -5342,7 +5348,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
         ot =3D gen_pop_T0(s);
         gen_movl_seg_T0(s, (b >> 3) & 7);
         gen_pop_update(s, ot);
-        if (s->is_jmp) {
+        if (s->base.jmp_type) {
             gen_jmp_im(s->pc - s->cs_base);
             gen_eob(s);
         }
@@ -5393,7 +5399,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
         gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
         gen_movl_seg_T0(s, reg);
         /* Note that reg =3D=3D R_SS in gen_movl_seg_T0 always sets is_j=
mp.  */
-        if (s->is_jmp) {
+        if (s->base.jmp_type) {
             gen_jmp_im(s->pc - s->cs_base);
             if (reg =3D=3D R_SS) {
                 s->tf =3D 0;
@@ -5598,7 +5604,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
         gen_movl_seg_T0(s, op);
         /* then put the data */
         gen_op_mov_reg_v(ot, reg, cpu_T1);
-        if (s->is_jmp) {
+        if (s->base.jmp_type) {
             gen_jmp_im(s->pc - s->cs_base);
             gen_eob(s);
         }
@@ -6254,7 +6260,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
             gen_repz_ins(s, ot, pc_start - s->cs_base, s->pc - s->cs_bas=
e);
         } else {
             gen_ins(s, ot);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (s->base.tb->cflags & CF_USE_ICOUNT) {
                 gen_jmp(s, s->pc - s->cs_base);
             }
         }
@@ -6269,7 +6275,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
             gen_repz_outs(s, ot, pc_start - s->cs_base, s->pc - s->cs_ba=
se);
         } else {
             gen_outs(s, ot);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (s->base.tb->cflags & CF_USE_ICOUNT) {
                 gen_jmp(s, s->pc - s->cs_base);
             }
         }
@@ -6285,14 +6291,14 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
         tcg_gen_movi_tl(cpu_T0, val);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_movi_i32(cpu_tmp2_i32, val);
         gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6306,14 +6312,14 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
                      svm_is_rep(prefixes));
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
=20
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_movi_i32(cpu_tmp2_i32, val);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
         gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6324,14 +6330,14 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
         tcg_gen_ext16u_tl(cpu_T0, cpu_regs[R_EDX]);
         gen_check_io(s, ot, pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
         gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6344,14 +6350,14 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
                      svm_is_rep(prefixes));
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
=20
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
         gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
         gen_bpt_io(s, cpu_tmp2_i32, ot);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -6893,7 +6899,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_pause(cpu_env, tcg_const_i32(s->pc - pc_start));
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.jmp_type =3D DJ_JUMP;
         }
         break;
     case 0x9b: /* fwait */
@@ -7062,11 +7068,11 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
     case 0x131: /* rdtsc */
         gen_update_cc_op(s);
         gen_jmp_im(pc_start - s->cs_base);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_start();
 	}
         gen_helper_rdtsc(cpu_env);
-        if (s->tb->cflags & CF_USE_ICOUNT) {
+        if (s->base.tb->cflags & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
@@ -7131,7 +7137,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_hlt(cpu_env, tcg_const_i32(s->pc - pc_start));
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.jmp_type =3D DJ_JUMP;
         }
         break;
     case 0x100:
@@ -7314,7 +7320,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
             gen_helper_vmrun(cpu_env, tcg_const_i32(s->aflag - 1),
                              tcg_const_i32(s->pc - pc_start));
             tcg_gen_exit_tb(0);
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.jmp_type =3D DJ_JUMP;
             break;
=20
         case 0xd9: /* VMMCALL */
@@ -7514,11 +7520,11 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
             }
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (s->base.tb->cflags & CF_USE_ICOUNT) {
                 gen_io_start();
             }
             gen_helper_rdtscp(cpu_env);
-            if (s->tb->cflags & CF_USE_ICOUNT) {
+            if (s->base.tb->cflags & CF_USE_ICOUNT) {
                 gen_io_end();
                 gen_jmp(s, s->pc - s->cs_base);
             }
@@ -8307,22 +8313,20 @@ void tcg_x86_init(void)
     }
 }
=20
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+void restore_state_to_opc(CPUX86State *env, TranslationBlock *tb,
+                          target_ulong *data)
 {
-    CPUX86State *env =3D cpu->env_ptr;
-    DisasContext dc1, *dc =3D &dc1;
-    target_ulong pc_ptr;
-    uint32_t flags;
-    target_ulong pc_start;
-    target_ulong cs_base;
-    int num_insns;
-    int max_insns;
+    int cc_op =3D data[1];
+    env->eip =3D data[0] - tb->cs_base;
+    if (cc_op !=3D CC_OP_DYNAMIC) {
+        env->cc_op =3D cc_op;
+    }
+}
=20
-    /* generate intermediate code */
-    pc_start =3D tb->pc;
-    cs_base =3D tb->cs_base;
-    flags =3D tb->flags;
+static void gen_intermediate_code_target_init_disas_context(
+    DisasContext *dc, CPUX86State *env)
+{
+    uint64_t flags =3D dc->base.tb->flags;
=20
     dc->pe =3D (flags >> HF_PE_SHIFT) & 1;
     dc->code32 =3D (flags >> HF_CS32_SHIFT) & 1;
@@ -8333,17 +8337,17 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
     dc->cpl =3D (flags >> HF_CPL_SHIFT) & 3;
     dc->iopl =3D (flags >> IOPL_SHIFT) & 3;
     dc->tf =3D (flags >> TF_SHIFT) & 1;
-    dc->singlestep_enabled =3D cpu->singlestep_enabled;
     dc->cc_op =3D CC_OP_DYNAMIC;
     dc->cc_op_dirty =3D false;
-    dc->cs_base =3D cs_base;
-    dc->tb =3D tb;
+    dc->cs_base =3D dc->base.tb->cs_base;
     dc->popl_esp_hack =3D 0;
+
     /* select memory access functions */
     dc->mem_index =3D 0;
 #ifdef CONFIG_SOFTMMU
     dc->mem_index =3D cpu_mmu_index(env, false);
 #endif
+
     dc->cpuid_features =3D env->features[FEAT_1_EDX];
     dc->cpuid_ext_features =3D env->features[FEAT_1_ECX];
     dc->cpuid_ext2_features =3D env->features[FEAT_8000_0001_EDX];
@@ -8355,7 +8359,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
     dc->code64 =3D (flags >> HF_CS64_SHIFT) & 1;
 #endif
     dc->flags =3D flags;
-    dc->jmp_opt =3D !(dc->tf || cpu->singlestep_enabled ||
+    dc->jmp_opt =3D !(dc->tf || dc->base.singlestep_enabled ||
                     (flags & HF_INHIBIT_IRQ_MASK));
     /* Do not optimize repz jumps at all in icount mode, because
        rep movsS instructions are execured with different paths
@@ -8367,13 +8371,17 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
        record/replay modes and there will always be an
        additional step for ecx=3D0 when icount is enabled.
      */
-    dc->repz_opt =3D !dc->jmp_opt && !(tb->cflags & CF_USE_ICOUNT);
+    dc->repz_opt =3D !dc->jmp_opt && !(dc->base.tb->cflags & CF_USE_ICOU=
NT);
 #if 0
     /* check addseg logic */
     if (!dc->addseg && (dc->vm86 || !dc->pe || !dc->code32))
         printf("ERROR addseg\n");
 #endif
+}
=20
+static void gen_intermediate_code_target_init_globals(
+    DisasContext *dc, CPUX86State *env)
+{
     cpu_T0 =3D tcg_temp_new();
     cpu_T1 =3D tcg_temp_new();
     cpu_A0 =3D tcg_temp_new();
@@ -8386,116 +8394,84 @@ void gen_intermediate_code(CPUState *cpu, Transl=
ationBlock *tb)
     cpu_ptr0 =3D tcg_temp_new_ptr();
     cpu_ptr1 =3D tcg_temp_new_ptr();
     cpu_cc_srcT =3D tcg_temp_local_new();
+}
=20
-    dc->is_jmp =3D DISAS_NEXT;
-    pc_ptr =3D pc_start;
-    num_insns =3D 0;
-    max_insns =3D tb->cflags & CF_COUNT_MASK;
-    if (max_insns =3D=3D 0) {
-        max_insns =3D CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns =3D TCG_MAX_INSNS;
-    }
+static void gen_intermediate_code_target_tb_start(
+    DisasContext *dc, CPUX86State *env)
+{
+}
=20
-    gen_tb_start(tb);
-    for(;;) {
-        tcg_gen_insn_start(pc_ptr, dc->cc_op);
-        num_insns++;
-
-        /* If RF is set, suppress an internally generated breakpoint.  *=
/
-        if (unlikely(cpu_breakpoint_test(cpu, pc_ptr,
-                                         tb->flags & HF_RF_MASK
-                                         ? BP_GDB : BP_ANY))) {
-            gen_debug(dc, pc_ptr - dc->cs_base);
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  *=
/
-            pc_ptr +=3D 1;
-            goto done_generating;
-        }
-        if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
+static void gen_intermediate_code_target_insn_start(
+    DisasContext *dc, CPUX86State *env)
+{
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+}
=20
-        pc_ptr =3D disas_insn(env, dc, pc_ptr);
-        /* stop translation if indicated */
-        if (dc->is_jmp)
-            break;
-        /* if single step mode, we generate only one instruction and
-           generate an exception */
-        /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
-           the flag and abort the translation to give the irqs a
-           change to be happen */
-        if (dc->tf || dc->singlestep_enabled ||
-            (flags & HF_INHIBIT_IRQ_MASK)) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
-            gen_eob(dc);
-            break;
-        }
-        /* Do not cross the boundary of the pages in icount mode,
-           it can cause an exception. Do it only when boundary is
-           crossed by the first instruction in the block.
-           If current instruction already crossed the bound - it's ok,
-           because an exception hasn't stopped this code.
-         */
-        if ((tb->cflags & CF_USE_ICOUNT)
-            && ((pc_ptr & TARGET_PAGE_MASK)
-                !=3D ((pc_ptr + TARGET_MAX_INSN_SIZE - 1) & TARGET_PAGE_=
MASK)
-                || (pc_ptr & ~TARGET_PAGE_MASK) =3D=3D 0)) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
-            gen_eob(dc);
-            break;
-        }
-        /* if too long translation, stop generation too */
-        if (tcg_op_buf_full() ||
-            (pc_ptr - pc_start) >=3D (TARGET_PAGE_SIZE - 32) ||
-            num_insns >=3D max_insns) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
-            gen_eob(dc);
-            break;
-        }
-        if (singlestep) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
-            gen_eob(dc);
-            break;
-        }
+static BreakpointHitType gen_intermediate_code_target_breakpoint_hit(
+    DisasContext *dc, CPUX86State *env,
+    const CPUBreakpoint *bp)
+{
+    /* If RF is set, suppress an internally generated breakpoint.  */
+    int flags =3D dc->base.tb->flags & HF_RF_MASK ? BP_GDB : BP_ANY;
+    if (bp->flags & flags) {
+        gen_debug(dc, dc->base.pc_next - dc->cs_base);
+        /* The address covered by the breakpoint must be included in [tb=
->pc,
+           tb->pc + tb->size) in order to for it to be properly cleared =
-- thus
+           we increment the PC here so that the generic logic setting tb=
->size
+           later does the right thing.  */
+        dc->base.pc_next +=3D 1;
+        return BH_HIT_TB;
+    } else {
+        return BH_MISS;
     }
-    if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
-done_generating:
-    gen_tb_end(tb, num_insns);
+}
=20
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        int disas_flags;
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-#ifdef TARGET_X86_64
-        if (dc->code64)
-            disas_flags =3D 2;
-        else
-#endif
-            disas_flags =3D !dc->code32;
-        log_target_disas(cpu, pc_start, pc_ptr - pc_start, disas_flags);
-        qemu_log("\n");
-        qemu_log_unlock();
+static DisasJumpType gen_intermediate_code_target_stop_check(
+    DisasContext *dc, CPUX86State *env)
+{
+    if (dc->tf) {
+        /*
+         * If single step mode, we generate only one instruction and gen=
erate an
+         * exception.
+         */
+        return DJ_MISC;
+    } else if (dc->flags & HF_INHIBIT_IRQ_MASK) {
+        /*
+         * If irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear the =
flag and
+         * abort the translation to give the irqs a change to be happen.
+         */
+        return DJ_MISC;
+    } else if ((dc->base.pc_next & TARGET_PAGE_MASK)
+               !=3D ((dc->base.pc_next + TARGET_MAX_INSN_SIZE - 1)
+                   & TARGET_PAGE_MASK)) {
+        /* next instruction crosses page boundary */
+        return DJ_MISC;
+    } else {
+        /* previously set during target disassembly */
+        return dc->base.jmp_type;
     }
-#endif
+}
=20
-    tb->size =3D pc_ptr - pc_start;
-    tb->icount =3D num_insns;
+static void gen_intermediate_code_target_stop(
+    DisasContext *dc, CPUX86State *env)
+{
+    DisasJumpType j =3D dc->base.jmp_type;
+    if (j =3D=3D DJ_TOO_MANY || j =3D=3D DJ_MISC) {
+        gen_jmp_im(dc->base.pc_next - dc->cs_base);
+        gen_eob(dc);
+    }
 }
=20
-void restore_state_to_opc(CPUX86State *env, TranslationBlock *tb,
-                          target_ulong *data)
+static int gen_intermediate_code_target_get_disas_flags(
+    const DisasContext *dc)
 {
-    int cc_op =3D data[1];
-    env->eip =3D data[0] - tb->cs_base;
-    if (cc_op !=3D CC_OP_DYNAMIC) {
-        env->cc_op =3D cc_op;
+#ifdef TARGET_X86_64
+    if (dc->code64) {
+        return 2;
+    } else {
+        return !dc->code32;
     }
+#else
+    return !dc->code32;
+#endif
 }
