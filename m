Received: from eggs.gnu.org ([2001:4830:134:3::10]:42546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCDe-0002C8-La
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCDb-0003LC-G1
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:37:18 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:38354)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCDa-0003Kv-Op
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:37:15 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 15:36:50 +0300
Message-Id: <149865341027.17063.1860120579163763533.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 05/29] target/i386: [tcg] Port to
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
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/i386/translate.c |  142 +++++++++++++++++++++++------------------=
------
 1 file changed, 70 insertions(+), 72 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5b02637400..8cf2485e2c 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -99,6 +99,8 @@ static int x86_64_hregs;
 #endif
=20
 typedef struct DisasContext {
+    DisasContextBase base;
+
     /* current insn context */
     int override; /* -1 if no override */
     int prefix;
@@ -106,8 +108,6 @@ typedef struct DisasContext {
     TCGMemOp dflag;
     target_ulong pc_start;
     target_ulong pc; /* pc =3D eip + cs_base */
-    int is_jmp; /* 1 =3D means jump (stop translation), 2 means CPU
-                   static state change (stop translation) */
     /* current block context */
     target_ulong cs_base; /* base of CS segment */
     int pe;     /* protected mode */
@@ -128,12 +128,10 @@ typedef struct DisasContext {
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
@@ -1123,7 +1121,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_=
port, int ot)
=20
 static inline void gen_ins(DisasContext *s, TCGMemOp ot)
 {
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (s->base.tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_string_movl_A0_EDI(s);
@@ -1138,14 +1136,14 @@ static inline void gen_ins(DisasContext *s, TCGMe=
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
@@ -1158,7 +1156,7 @@ static inline void gen_outs(DisasContext *s, TCGMem=
Op ot)
     gen_op_movl_T0_Dshift(ot);
     gen_op_add_reg_T0(s->aflag, R_ESI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
-    if (s->tb->cflags & CF_USE_ICOUNT) {
+    if (s->base.tb->cflags & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
@@ -2141,7 +2139,7 @@ static inline int insn_const_size(TCGMemOp ot)
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
@@ -2156,7 +2154,7 @@ static inline void gen_goto_tb(DisasContext *s, int=
 tb_num, target_ulong eip)
         /* jump to same page: we can use a direct jump */
         tcg_gen_goto_tb(tb_num);
         gen_jmp_im(eip);
-        tcg_gen_exit_tb((uintptr_t)s->tb + tb_num);
+        tcg_gen_exit_tb((uintptr_t)s->base.tb + tb_num);
     } else {
         /* jump to another page */
         gen_jmp_im(eip);
@@ -2177,7 +2175,7 @@ static inline void gen_jcc(DisasContext *s, int b,
=20
         gen_set_label(l1);
         gen_goto_tb(s, 1, val);
-        s->is_jmp =3D DISAS_TB_JUMP;
+        s->base.is_jmp =3D DISAS_TB_JUMP;
     } else {
         l1 =3D gen_new_label();
         l2 =3D gen_new_label();
@@ -2248,11 +2246,11 @@ static void gen_movl_seg_T0(DisasContext *s, int =
seg_reg)
            stop as a special handling must be done to disable hardware
            interrupts for the next instruction */
         if (seg_reg =3D=3D R_SS || (s->code32 && seg_reg < R_FS))
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.is_jmp =3D DISAS_TB_JUMP;
     } else {
         gen_op_movl_seg_T0_vm(seg_reg);
         if (seg_reg =3D=3D R_SS)
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.is_jmp =3D DISAS_TB_JUMP;
     }
 }
=20
@@ -2424,7 +2422,7 @@ static void gen_exception(DisasContext *s, int trap=
no, target_ulong cur_eip)
     gen_update_cc_op(s);
     gen_jmp_im(cur_eip);
     gen_helper_raise_exception(cpu_env, tcg_const_i32(trapno));
-    s->is_jmp =3D DISAS_TB_JUMP;
+    s->base.is_jmp =3D DISAS_TB_JUMP;
 }
=20
 /* Generate #UD for the current instruction.  The assumption here is tha=
t
@@ -2462,7 +2460,7 @@ static void gen_interrupt(DisasContext *s, int intn=
o,
     gen_jmp_im(cur_eip);
     gen_helper_raise_interrupt(cpu_env, tcg_const_i32(intno),
                                tcg_const_i32(next_eip - cur_eip));
-    s->is_jmp =3D DISAS_TB_JUMP;
+    s->base.is_jmp =3D DISAS_TB_JUMP;
 }
=20
 static void gen_debug(DisasContext *s, target_ulong cur_eip)
@@ -2470,7 +2468,7 @@ static void gen_debug(DisasContext *s, target_ulong=
 cur_eip)
     gen_update_cc_op(s);
     gen_jmp_im(cur_eip);
     gen_helper_debug(cpu_env);
-    s->is_jmp =3D DISAS_TB_JUMP;
+    s->base.is_jmp =3D DISAS_TB_JUMP;
 }
=20
 static void gen_set_hflag(DisasContext *s, uint32_t mask)
@@ -2526,10 +2524,10 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, =
bool recheck_tf, TCGv jr)
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
     } else if (recheck_tf) {
         gen_helper_rechecking_single_step(cpu_env);
@@ -2545,7 +2543,7 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bo=
ol recheck_tf, TCGv jr)
     } else {
         tcg_gen_exit_tb(0);
     }
-    s->is_jmp =3D DISAS_TB_JUMP;
+    s->base.is_jmp =3D DISAS_TB_JUMP;
 }
=20
 static inline void
@@ -2584,7 +2582,7 @@ static void gen_jmp_tb(DisasContext *s, target_ulon=
g eip, int tb_num)
     set_cc_op(s, CC_OP_DYNAMIC);
     if (s->jmp_opt) {
         gen_goto_tb(s, tb_num, eip);
-        s->is_jmp =3D DISAS_TB_JUMP;
+        s->base.is_jmp =3D DISAS_TB_JUMP;
     } else {
         gen_jmp_im(eip);
         gen_eob(s);
@@ -4419,7 +4417,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
     }
 }
=20
-/* convert one instruction. s->is_jmp is set if the translation must
+/* convert one instruction. s->base.is_jmp is set if the translation mus=
t
    be stopped. Return the next pc value */
 static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                                target_ulong pc_start)
@@ -5379,7 +5377,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
         gen_movl_seg_T0(s, reg);
         gen_pop_update(s, ot);
         /* Note that reg =3D=3D R_SS in gen_movl_seg_T0 always sets is_j=
mp.  */
-        if (s->is_jmp) {
+        if (s->base.is_jmp) {
             gen_jmp_im(s->pc - s->cs_base);
             if (reg =3D=3D R_SS) {
                 s->tf =3D 0;
@@ -5394,7 +5392,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
         ot =3D gen_pop_T0(s);
         gen_movl_seg_T0(s, (b >> 3) & 7);
         gen_pop_update(s, ot);
-        if (s->is_jmp) {
+        if (s->base.is_jmp) {
             gen_jmp_im(s->pc - s->cs_base);
             gen_eob(s);
         }
@@ -5445,7 +5443,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
         gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
         gen_movl_seg_T0(s, reg);
         /* Note that reg =3D=3D R_SS in gen_movl_seg_T0 always sets is_j=
mp.  */
-        if (s->is_jmp) {
+        if (s->base.is_jmp) {
             gen_jmp_im(s->pc - s->cs_base);
             if (reg =3D=3D R_SS) {
                 s->tf =3D 0;
@@ -5654,7 +5652,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
         gen_movl_seg_T0(s, op);
         /* then put the data */
         gen_op_mov_reg_v(ot, reg, cpu_T1);
-        if (s->is_jmp) {
+        if (s->base.is_jmp) {
             gen_jmp_im(s->pc - s->cs_base);
             gen_eob(s);
         }
@@ -6310,7 +6308,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
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
@@ -6325,7 +6323,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
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
@@ -6341,14 +6339,14 @@ static target_ulong disas_insn(CPUX86State *env, =
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
@@ -6362,14 +6360,14 @@ static target_ulong disas_insn(CPUX86State *env, =
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
@@ -6380,14 +6378,14 @@ static target_ulong disas_insn(CPUX86State *env, =
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
@@ -6400,14 +6398,14 @@ static target_ulong disas_insn(CPUX86State *env, =
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
@@ -6946,7 +6944,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_pause(cpu_env, tcg_const_i32(s->pc - pc_start));
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.is_jmp =3D DISAS_TB_JUMP;
         }
         break;
     case 0x9b: /* fwait */
@@ -7115,11 +7113,11 @@ static target_ulong disas_insn(CPUX86State *env, =
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
@@ -7191,7 +7189,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             gen_helper_hlt(cpu_env, tcg_const_i32(s->pc - pc_start));
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.is_jmp =3D DISAS_TB_JUMP;
         }
         break;
     case 0x100:
@@ -7374,7 +7372,7 @@ static target_ulong disas_insn(CPUX86State *env, Di=
sasContext *s,
             gen_helper_vmrun(cpu_env, tcg_const_i32(s->aflag - 1),
                              tcg_const_i32(s->pc - pc_start));
             tcg_gen_exit_tb(0);
-            s->is_jmp =3D DISAS_TB_JUMP;
+            s->base.is_jmp =3D DISAS_TB_JUMP;
             break;
=20
         case 0xd9: /* VMMCALL */
@@ -7574,11 +7572,11 @@ static target_ulong disas_insn(CPUX86State *env, =
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
@@ -7943,24 +7941,24 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
                 gen_update_cc_op(s);
                 gen_jmp_im(pc_start - s->cs_base);
                 if (b & 2) {
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
                         gen_io_start();
                     }
                     gen_op_mov_v_reg(ot, cpu_T0, rm);
                     gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
                                          cpu_T0);
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
                         gen_io_end();
                     }
                     gen_jmp_im(s->pc - s->cs_base);
                     gen_eob(s);
                 } else {
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
                         gen_io_start();
                     }
                     gen_helper_read_crN(cpu_T0, cpu_env, tcg_const_i32(r=
eg));
                     gen_op_mov_reg_v(ot, rm, cpu_T0);
-                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                    if (s->base.tb->cflags & CF_USE_ICOUNT) {
                         gen_io_end();
                     }
                 }
@@ -8386,15 +8384,13 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
 {
     CPUX86State *env =3D cpu->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
-    target_ulong pc_ptr;
     uint32_t flags;
-    target_ulong pc_start;
     target_ulong cs_base;
     int num_insns;
     int max_insns;
=20
     /* generate intermediate code */
-    pc_start =3D tb->pc;
+    dc->base.pc_first =3D tb->pc;
     cs_base =3D tb->cs_base;
     flags =3D tb->flags;
=20
@@ -8407,11 +8403,11 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
     dc->cpl =3D (flags >> HF_CPL_SHIFT) & 3;
     dc->iopl =3D (flags >> IOPL_SHIFT) & 3;
     dc->tf =3D (flags >> TF_SHIFT) & 1;
-    dc->singlestep_enabled =3D cpu->singlestep_enabled;
+    dc->base.singlestep_enabled =3D cpu->singlestep_enabled;
     dc->cc_op =3D CC_OP_DYNAMIC;
     dc->cc_op_dirty =3D false;
     dc->cs_base =3D cs_base;
-    dc->tb =3D tb;
+    dc->base.tb =3D tb;
     dc->popl_esp_hack =3D 0;
     /* select memory access functions */
     dc->mem_index =3D 0;
@@ -8461,8 +8457,8 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
     cpu_ptr1 =3D tcg_temp_new_ptr();
     cpu_cc_srcT =3D tcg_temp_local_new();
=20
-    dc->is_jmp =3D DISAS_NEXT;
-    pc_ptr =3D pc_start;
+    dc->base.is_jmp =3D DISAS_NEXT;
+    dc->base.pc_next =3D dc->base.pc_first;
     num_insns =3D 0;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
@@ -8474,37 +8470,38 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
=20
     gen_tb_start(tb);
     for(;;) {
-        tcg_gen_insn_start(pc_ptr, dc->cc_op);
+        tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
         num_insns++;
=20
         /* If RF is set, suppress an internally generated breakpoint.  *=
/
-        if (unlikely(cpu_breakpoint_test(cpu, pc_ptr,
+        if (unlikely(cpu_breakpoint_test(cpu, dc->base.pc_next,
                                          tb->flags & HF_RF_MASK
                                          ? BP_GDB : BP_ANY))) {
-            gen_debug(dc, pc_ptr - dc->cs_base);
+            gen_debug(dc, dc->base.pc_next - dc->cs_base);
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  *=
/
-            pc_ptr +=3D 1;
+            dc->base.pc_next +=3D 1;
             goto done_generating;
         }
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
             gen_io_start();
         }
=20
-        pc_ptr =3D disas_insn(env, dc, pc_ptr);
+        dc->base.pc_next =3D disas_insn(env, dc, dc->base.pc_next);
         /* stop translation if indicated */
-        if (dc->is_jmp)
+        if (dc->base.is_jmp) {
             break;
+        }
         /* if single step mode, we generate only one instruction and
            generate an exception */
         /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
            the flag and abort the translation to give the irqs a
            change to be happen */
-        if (dc->tf || dc->singlestep_enabled ||
+        if (dc->tf || dc->base.singlestep_enabled ||
             (flags & HF_INHIBIT_IRQ_MASK)) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
+            gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
@@ -8515,23 +8512,23 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
            because an exception hasn't stopped this code.
          */
         if ((tb->cflags & CF_USE_ICOUNT)
-            && ((pc_ptr & TARGET_PAGE_MASK)
-                !=3D ((pc_ptr + TARGET_MAX_INSN_SIZE - 1) & TARGET_PAGE_=
MASK)
-                || (pc_ptr & ~TARGET_PAGE_MASK) =3D=3D 0)) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
+            && ((dc->base.pc_next & TARGET_PAGE_MASK)
+                !=3D ((dc->base.pc_next + TARGET_MAX_INSN_SIZE - 1) & TA=
RGET_PAGE_MASK)
+                || (dc->base.pc_next & ~TARGET_PAGE_MASK) =3D=3D 0)) {
+            gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
         /* if too long translation, stop generation too */
         if (tcg_op_buf_full() ||
-            (pc_ptr - pc_start) >=3D (TARGET_PAGE_SIZE - 32) ||
+            (dc->base.pc_next - dc->base.pc_first) >=3D (TARGET_PAGE_SIZ=
E - 32) ||
             num_insns >=3D max_insns) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
+            gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
         if (singlestep) {
-            gen_jmp_im(pc_ptr - dc->cs_base);
+            gen_jmp_im(dc->base.pc_next - dc->cs_base);
             gen_eob(dc);
             break;
         }
@@ -8543,24 +8540,25 @@ done_generating:
=20
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
+        && qemu_log_in_addr_range(dc->base.pc_first)) {
         int disas_flags;
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
+        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
 #ifdef TARGET_X86_64
         if (dc->code64)
             disas_flags =3D 2;
         else
 #endif
             disas_flags =3D !dc->code32;
-        log_target_disas(cpu, pc_start, pc_ptr - pc_start, disas_flags);
+        log_target_disas(cpu, dc->base.pc_first, dc->base.pc_next - dc->=
base.pc_first,
+                         disas_flags);
         qemu_log("\n");
         qemu_log_unlock();
     }
 #endif
=20
-    tb->size =3D pc_ptr - pc_start;
+    tb->size =3D dc->base.pc_next - dc->base.pc_first;
     tb->icount =3D num_insns;
 }
=20
