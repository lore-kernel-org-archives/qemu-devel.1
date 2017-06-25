Received: from eggs.gnu.org ([2001:4830:134:3::10]:57242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3Le-0003x5-R7
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 04:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3Lb-0002Lh-Ae
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 04:56:50 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 11:55:50 +0300
Message-Id: <149838095039.6497.9448439115949437094.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 03/26] cpu-exec: Avoid global variables in
 icount-related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/exec/gen-icount.h     |    6 +++--
 target/alpha/translate.c      |   14 ++++++------
 target/arm/translate-a64.c    |   10 ++++-----
 target/arm/translate.c        |   10 ++++-----
 target/cris/translate.c       |    6 +++--
 target/hppa/translate.c       |    6 +++--
 target/i386/translate.c       |   46 +++++++++++++++++++++--------------=
------
 target/lm32/translate.c       |   14 ++++++------
 target/m68k/translate.c       |    6 +++--
 target/microblaze/translate.c |    6 +++--
 target/mips/translate.c       |   26 ++++++++++++-----------
 target/moxie/translate.c      |    2 +-
 target/nios2/translate.c      |    6 +++--
 target/openrisc/translate.c   |    6 +++--
 target/ppc/translate.c        |    6 +++--
 target/ppc/translate_init.c   |   32 ++++++++++++++---------------
 target/s390x/translate.c      |    6 +++--
 target/sh4/translate.c        |    6 +++--
 target/sparc/translate.c      |    6 +++--
 target/tilegx/translate.c     |    2 +-
 target/tricore/translate.c    |    2 +-
 target/unicore32/translate.c  |    6 +++--
 target/xtensa/translate.c     |   26 ++++++++++++-----------
 23 files changed, 128 insertions(+), 128 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 62d462e494..9b26c7da5f 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -8,7 +8,7 @@
 static int icount_start_insn_idx;
 static TCGLabel *exitreq_label;
=20
-static inline void gen_tb_start(TranslationBlock *tb)
+static inline void gen_tb_start(TranslationBlock *tb, TCGv_env cpu_env)
 {
     TCGv_i32 count, imm;
=20
@@ -59,14 +59,14 @@ static void gen_tb_end(TranslationBlock *tb, int num_=
insns)
     tcg_ctx.gen_op_buf[tcg_ctx.gen_op_buf[0].prev].next =3D 0;
 }
=20
-static inline void gen_io_start(void)
+static inline void gen_io_start(TCGv_env cpu_env)
 {
     TCGv_i32 tmp =3D tcg_const_i32(1);
     tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do=
_io));
     tcg_temp_free_i32(tmp);
 }
=20
-static inline void gen_io_end(void)
+static inline void gen_io_end(TCGv_env cpu_env)
 {
     TCGv_i32 tmp =3D tcg_const_i32(0);
     tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do=
_io));
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 9b60680454..fdc49109ad 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1329,9 +1329,9 @@ static ExitStatus gen_mfpr(DisasContext *ctx, TCGv =
va, int regno)
         helper =3D gen_helper_get_vmtime;
     do_helper:
         if (use_icount) {
-            gen_io_start();
+            gen_io_start(cpu_env);
             helper(va);
-            gen_io_end();
+            gen_io_end(cpu_env);
             return EXIT_PC_STALE;
         } else {
             helper(va);
@@ -2379,9 +2379,9 @@ static ExitStatus translate_one(DisasContext *ctx, =
uint32_t insn)
             /* RPCC */
             va =3D dest_gpr(ctx, ra);
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
+                gen_io_start(cpu_env);
                 gen_helper_load_pcc(va, cpu_env);
-                gen_io_end();
+                gen_io_end(cpu_env);
                 ret =3D EXIT_PC_STALE;
             } else {
                 gen_helper_load_pcc(va, cpu_env);
@@ -2955,7 +2955,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         pc_mask =3D ~TARGET_PAGE_MASK;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(ctx.pc);
         num_insns++;
@@ -2970,7 +2970,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
             break;
         }
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         insn =3D cpu_ldl_code(env, ctx.pc);
=20
@@ -2991,7 +2991,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
     } while (ret =3D=3D NO_EXIT);
=20
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
=20
     switch (ret) {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 860e279658..43261e7939 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1558,7 +1558,7 @@ static void handle_sys(DisasContext *s, uint32_t in=
sn, bool isread,
     }
=20
     if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
=20
     tcg_rt =3D cpu_reg(s, rt);
@@ -1590,7 +1590,7 @@ static void handle_sys(DisasContext *s, uint32_t in=
sn, bool isread,
=20
     if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) *=
/
-        gen_io_end();
+        gen_io_end(cpu_env);
         s->is_jmp =3D DISAS_UPDATE;
     } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
@@ -11263,7 +11263,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
=20
     tcg_clear_temp_count();
=20
@@ -11297,7 +11297,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
         }
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         if (dc->ss_active && !dc->pstate_ss) {
@@ -11338,7 +11338,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, Trans=
lationBlock *tb)
              num_insns < max_insns);
=20
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
=20
     if (unlikely(cs->singlestep_enabled || dc->ss_active)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 96272a9888..073562269b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7654,7 +7654,7 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
         }
=20
         if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         if (isread) {
@@ -7746,7 +7746,7 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
=20
         if ((s->tb->cflags & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             /* I/O operations must end the TB here (whether read or writ=
e) */
-            gen_io_end();
+            gen_io_end(cpu_env);
             gen_lookup_tb(s);
         } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
             /* We default to ending the TB on a coprocessor register wri=
te,
@@ -11881,7 +11881,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
=20
     tcg_clear_temp_count();
=20
@@ -11969,7 +11969,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
         }
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         if (dc->ss_active && !dc->pstate_ss) {
@@ -12044,7 +12044,7 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
                code.  */
             cpu_abort(cpu, "IO on conditional branch instruction");
         }
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
=20
     /* At this stage dc->condjmp will only be set when the skipped
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 35931e7061..90424abe00 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3144,7 +3144,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(dc->delayed_branch =3D=3D 1
                            ? dc->ppc | 1 : dc->pc);
@@ -3167,7 +3167,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         LOG_DIS("%8.8x:\t", dc->pc);
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         dc->clear_x =3D 1;
=20
@@ -3240,7 +3240,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
     npc =3D dc->pc;
=20
         if (tb->cflags & CF_LAST_IO)
-            gen_io_end();
+            gen_io_end(cpu_env);
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp =3D=3D DISAS_NEXT
         && (dc->cpustate_changed || !dc->flagx_known
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e10abc5e04..ba154661fc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3773,7 +3773,7 @@ void gen_intermediate_code(CPUHPPAState *env, struc=
t TranslationBlock *tb)
     }
=20
     num_insns =3D 0;
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
=20
     /* Seed the nullification status from PSW[N], as shown in TB->FLAGS.=
  */
     ctx.null_cond =3D cond_make_f();
@@ -3793,7 +3793,7 @@ void gen_intermediate_code(CPUHPPAState *env, struc=
t TranslationBlock *tb)
             break;
         }
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         if (ctx.iaoq_f < TARGET_PAGE_SIZE) {
@@ -3869,7 +3869,7 @@ void gen_intermediate_code(CPUHPPAState *env, struc=
t TranslationBlock *tb)
     } while (ret =3D=3D NO_EXIT);
=20
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
=20
     switch (ret) {
diff --git a/target/i386/translate.c b/target/i386/translate.c
index b94303ff10..9f42a5509d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1120,7 +1120,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_=
port, int ot)
 static inline void gen_ins(DisasContext *s, TCGMemOp ot)
 {
     if (s->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_string_movl_A0_EDI(s);
     /* Note: we must do this dummy write first to be restartable in
@@ -1135,14 +1135,14 @@ static inline void gen_ins(DisasContext *s, TCGMe=
mOp ot)
     gen_op_add_reg_T0(s->aflag, R_EDI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
     if (s->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
 }
=20
 static inline void gen_outs(DisasContext *s, TCGMemOp ot)
 {
     if (s->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, cpu_T0, cpu_A0);
@@ -1155,7 +1155,7 @@ static inline void gen_outs(DisasContext *s, TCGMem=
Op ot)
     gen_op_add_reg_T0(s->aflag, R_ESI);
     gen_bpt_io(s, cpu_tmp2_i32, ot);
     if (s->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
 }
=20
@@ -6338,14 +6338,14 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
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
+            gen_io_end(cpu_env);
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6359,14 +6359,14 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
=20
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
+            gen_io_end(cpu_env);
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6377,14 +6377,14 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
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
+            gen_io_end(cpu_env);
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6397,14 +6397,14 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
         gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
=20
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
+            gen_io_end(cpu_env);
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -7112,11 +7112,11 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
         gen_update_cc_op(s);
         gen_jmp_im(pc_start - s->cs_base);
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
 	}
         gen_helper_rdtsc(cpu_env);
         if (s->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_end(cpu_env);
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -7571,11 +7571,11 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
             gen_update_cc_op(s);
             gen_jmp_im(pc_start - s->cs_base);
             if (s->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
+                gen_io_start(cpu_env);
             }
             gen_helper_rdtscp(cpu_env);
             if (s->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_end();
+                gen_io_end(cpu_env);
                 gen_jmp(s, s->pc - s->cs_base);
             }
             break;
@@ -7940,24 +7940,24 @@ static target_ulong disas_insn(CPUX86State *env, =
DisasContext *s,
                 gen_jmp_im(pc_start - s->cs_base);
                 if (b & 2) {
                     if (s->tb->cflags & CF_USE_ICOUNT) {
-                        gen_io_start();
+                        gen_io_start(cpu_env);
                     }
                     gen_op_mov_v_reg(ot, cpu_T0, rm);
                     gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
                                          cpu_T0);
                     if (s->tb->cflags & CF_USE_ICOUNT) {
-                        gen_io_end();
+                        gen_io_end(cpu_env);
                     }
                     gen_jmp_im(s->pc - s->cs_base);
                     gen_eob(s);
                 } else {
                     if (s->tb->cflags & CF_USE_ICOUNT) {
-                        gen_io_start();
+                        gen_io_start(cpu_env);
                     }
                     gen_helper_read_crN(cpu_T0, cpu_env, tcg_const_i32(r=
eg));
                     gen_op_mov_reg_v(ot, rm, cpu_T0);
                     if (s->tb->cflags & CF_USE_ICOUNT) {
-                        gen_io_end();
+                        gen_io_end(cpu_env);
                     }
                 }
                 break;
@@ -8468,7 +8468,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     for(;;) {
         tcg_gen_insn_start(pc_ptr, dc->cc_op);
         num_insns++;
@@ -8486,7 +8486,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
             goto done_generating;
         }
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         pc_ptr =3D disas_insn(env, dc, pc_ptr);
@@ -8533,7 +8533,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
         }
     }
     if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
+        gen_io_end(cpu_env);
 done_generating:
     gen_tb_end(tb, num_insns);
=20
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 0ac34fc620..b635d4ea7a 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -875,24 +875,24 @@ static void dec_wcsr(DisasContext *dc)
     case CSR_IM:
         /* mark as an io operation because it could cause an interrupt *=
/
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         gen_helper_wcsr_im(cpu_env, cpu_R[dc->r1]);
         tcg_gen_movi_tl(cpu_pc, dc->pc + 4);
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_end(cpu_env);
         }
         dc->is_jmp =3D DISAS_UPDATE;
         break;
     case CSR_IP:
         /* mark as an io operation because it could cause an interrupt *=
/
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         gen_helper_wcsr_ip(cpu_env, cpu_R[dc->r1]);
         tcg_gen_movi_tl(cpu_pc, dc->pc + 4);
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_end(cpu_env);
         }
         dc->is_jmp =3D DISAS_UPDATE;
         break;
@@ -1080,7 +1080,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(dc->pc);
         num_insns++;
@@ -1101,7 +1101,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         LOG_DIS("%8.8x:\t", dc->pc);
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         decode(dc, cpu_ldl_code(env, dc->pc));
@@ -1114,7 +1114,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
          && num_insns < max_insns);
=20
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
=20
     if (unlikely(cpu->singlestep_enabled)) {
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0a3372818c..5fac91aec5 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5072,7 +5072,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         pc_offset =3D dc->pc - pc_start;
         gen_throws_exception =3D NULL;
@@ -5091,7 +5091,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
         }
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         dc->insn_pc =3D dc->pc;
@@ -5103,7 +5103,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
              num_insns < max_insns);
=20
     if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
+        gen_io_end(cpu_env);
     if (unlikely(cpu->singlestep_enabled)) {
         /* Make sure the pc is updated, and raise a debug exception.  */
         if (!dc->is_jmp) {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
index d5f499658d..7bcdc81413 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1637,7 +1637,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do
     {
         tcg_gen_insn_start(dc->pc);
@@ -1665,7 +1665,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         LOG_DIS("%8.8x:\t", dc->pc);
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         dc->clear_imm =3D 1;
@@ -1727,7 +1727,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
     }
=20
     if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
+        gen_io_end(cpu_env);
     /* Force an update if the per-tb mb_cpu state has changed.  */
     if (dc->is_jmp =3D=3D DISAS_NEXT
         && (dc->cpustate_changed || org_flags !=3D dc->tb_flags)) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1f9e02f426..1a14319e7a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5233,11 +5233,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
         case 0:
             /* Mark as an IO operation because we read the time.  */
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
+                gen_io_start(cpu_env);
 	    }
             gen_helper_mfc0_count(arg, cpu_env);
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_end();
+                gen_io_end(cpu_env);
             }
             /* Break the TB to be able to take timer interrupts immediat=
ely
                after reading count.  */
@@ -5637,7 +5637,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
         check_insn(ctx, ISA_MIPS32);
=20
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
=20
     switch (reg) {
@@ -6286,7 +6286,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
=20
     /* For simplicity assume that all writes can cause interrupts.  */
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         ctx->bstate =3D BS_STOP;
     }
     return;
@@ -6546,11 +6546,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
         case 0:
             /* Mark as an IO operation because we read the time.  */
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
+                gen_io_start(cpu_env);
             }
             gen_helper_mfc0_count(arg, cpu_env);
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_end();
+                gen_io_end(cpu_env);
             }
             /* Break the TB to be able to take timer interrupts immediat=
ely
                after reading count.  */
@@ -6937,7 +6937,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
         check_insn(ctx, ISA_MIPS64);
=20
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
=20
     switch (reg) {
@@ -7254,11 +7254,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
             /* Mark as an IO operation because we may trigger a software
                interrupt.  */
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
+                gen_io_start(cpu_env);
             }
             gen_helper_mtc0_cause(cpu_env, arg);
             if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_end();
+                gen_io_end(cpu_env);
             }
             /* Stop translation as we may have triggered an intetrupt */
             ctx->bstate =3D BS_STOP;
@@ -7584,7 +7584,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
=20
     /* For simplicity assume that all writes can cause interrupts.  */
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         ctx->bstate =3D BS_STOP;
     }
     return;
@@ -19935,7 +19935,7 @@ void gen_intermediate_code(CPUState *cpu, struct =
TranslationBlock *tb)
     }
=20
     LOG_DISAS("\ntb %p idx %d hflags %04x\n", tb, ctx.mem_idx, ctx.hflag=
s);
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     while (ctx.bstate =3D=3D BS_NONE) {
         tcg_gen_insn_start(ctx.pc, ctx.hflags & MIPS_HFLAG_BMASK, ctx.bt=
arget);
         num_insns++;
@@ -19953,7 +19953,7 @@ void gen_intermediate_code(CPUState *cpu, struct =
TranslationBlock *tb)
         }
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         is_slot =3D ctx.hflags & MIPS_HFLAG_BMASK;
@@ -20014,7 +20014,7 @@ void gen_intermediate_code(CPUState *cpu, struct =
TranslationBlock *tb)
             break;
     }
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
     if (cpu->singlestep_enabled && ctx.bstate !=3D BS_BRANCH) {
         save_cpu_state(&ctx, ctx.bstate !=3D BS_EXCP);
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 176063a1de..2bcf1f6856 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -846,7 +846,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tran=
slationBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(ctx.pc);
         num_insns++;
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 2f3c2e5dfb..b21fed869b 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -834,7 +834,7 @@ void gen_intermediate_code(CPUNios2State *env, Transl=
ationBlock *tb)
         }
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(dc->pc);
         num_insns++;
@@ -850,7 +850,7 @@ void gen_intermediate_code(CPUNios2State *env, Transl=
ationBlock *tb)
         }
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         /* Decode an instruction */
@@ -867,7 +867,7 @@ void gen_intermediate_code(CPUNios2State *env, Transl=
ationBlock *tb)
              num_insns < max_insns);
=20
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
=20
     /* Indicate where the next block should start */
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index aaac359d5b..6c555dfeeb 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1557,7 +1557,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
=20
     /* Allow the TCG optimizer to see that R0 =3D=3D 0,
        when it's true, which is the common case.  */
@@ -1585,7 +1585,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         }
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         disas_openrisc_insn(dc, or_cpu);
         dc->pc =3D dc->pc + 4;
@@ -1608,7 +1608,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
              && num_insns < max_insns);
=20
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
=20
     if ((dc->tb_flags & TB_FLAGS_DFLAG ? 1 : 0) !=3D (dc->delayed_branch=
 !=3D 0)) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9a934117d8..b395241f01 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7282,7 +7282,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     tcg_clear_temp_count();
     /* Set env in case of segfault during code fetch */
     while (ctx.exception =3D=3D POWERPC_EXCP_NONE && !tcg_op_buf_full())=
 {
@@ -7303,7 +7303,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         LOG_DISAS("nip=3D" TARGET_FMT_lx " super=3D%d ir=3D%d\n",
                   ctx.nip, ctx.mem_idx, (int)msr_ir);
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO))
-            gen_io_start();
+            gen_io_start(cpu_env);
         if (unlikely(need_byteswap(&ctx))) {
             ctx.opcode =3D bswap32(cpu_ldl_code(env, ctx.nip));
         } else {
@@ -7384,7 +7384,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         }
     }
     if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
+        gen_io_end(cpu_env);
     if (ctx.exception =3D=3D POWERPC_EXCP_NONE) {
         gen_goto_tb(&ctx, 0, ctx.nip);
     } else if (ctx.exception !=3D POWERPC_EXCP_BRANCH) {
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 56a0ab22cf..d25c309415 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -175,11 +175,11 @@ static void spr_write_ureg(DisasContext *ctx, int s=
prn, int gprn)
 static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_load_decr(cpu_gpr[gprn], cpu_env);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -187,11 +187,11 @@ static void spr_read_decr(DisasContext *ctx, int gp=
rn, int sprn)
 static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_store_decr(cpu_env, cpu_gpr[gprn]);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -202,11 +202,11 @@ static void spr_write_decr(DisasContext *ctx, int s=
prn, int gprn)
 static void spr_read_tbl(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_load_tbl(cpu_gpr[gprn], cpu_env);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -214,11 +214,11 @@ static void spr_read_tbl(DisasContext *ctx, int gpr=
n, int sprn)
 static void spr_read_tbu(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_load_tbu(cpu_gpr[gprn], cpu_env);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -239,11 +239,11 @@ static void spr_read_atbu(DisasContext *ctx, int gp=
rn, int sprn)
 static void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_store_tbl(cpu_env, cpu_gpr[gprn]);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -251,11 +251,11 @@ static void spr_write_tbl(DisasContext *ctx, int sp=
rn, int gprn)
 static void spr_write_tbu(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_store_tbu(cpu_env, cpu_gpr[gprn]);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -283,11 +283,11 @@ static void spr_read_purr(DisasContext *ctx, int gp=
rn, int sprn)
 static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_load_hdecr(cpu_gpr[gprn], cpu_env);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         gen_stop_exception(ctx);
     }
 }
@@ -295,11 +295,11 @@ static void spr_read_hdecr(DisasContext *ctx, int g=
prn, int sprn)
 static void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_store_hdecr(cpu_env, cpu_gpr[gprn]);
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         gen_stop_exception(ctx);
     }
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 684ae4ce2f..14abb6e6b9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5742,7 +5742,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
=20
     do {
         tcg_gen_insn_start(dc.pc, dc.cc_op);
@@ -5760,7 +5760,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         }
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         status =3D translate_one(env, &dc);
@@ -5779,7 +5779,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
     } while (status =3D=3D NO_EXIT);
=20
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
=20
     switch (status) {
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 6a797072d4..2558347d9a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1846,7 +1846,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     while (ctx.bstate =3D=3D BS_NONE && !tcg_op_buf_full()) {
         tcg_gen_insn_start(ctx.pc, ctx.envflags);
         num_insns++;
@@ -1865,7 +1865,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
         }
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         ctx.opcode =3D cpu_lduw_code(env, ctx.pc);
@@ -1882,7 +1882,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
             break;
     }
     if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
+        gen_io_end(cpu_env);
     if (cpu->singlestep_enabled) {
         gen_save_cpu_state(&ctx, true);
         gen_helper_debug(cpu_env);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 90c43e4460..763d399419 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5788,7 +5788,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock * tb)
         max_insns =3D TCG_MAX_INSNS;
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         if (dc->npc & JUMP_PC) {
             assert(dc->jump_pc[1] =3D=3D dc->pc + 4);
@@ -5810,7 +5810,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock * tb)
         }
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         insn =3D cpu_ldl_code(env, dc->pc);
@@ -5837,7 +5837,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock * tb)
=20
  exit_gen_loop:
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
     if (!dc->is_br) {
         if (dc->pc !=3D DYNAMIC_PC &&
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index a86e9e9d22..2dbed6b19b 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2402,7 +2402,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
     if (max_insns > TCG_MAX_INSNS) {
         max_insns =3D TCG_MAX_INSNS;
     }
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
=20
     while (1) {
         tcg_gen_insn_start(dc->pc);
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 1930da2f2a..a4a8bb2272 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8810,7 +8810,7 @@ void gen_intermediate_code(CPUState *cpu, struct Tr=
anslationBlock *tb)
     ctx.mem_idx =3D cpu_mmu_index(env, false);
=20
     tcg_clear_temp_count();
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     while (ctx.bstate =3D=3D BS_NONE) {
         tcg_gen_insn_start(ctx.pc);
         num_insns++;
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 494ed58c10..a7878ffd81 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1911,7 +1911,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
     }
 #endif
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
     do {
         tcg_gen_insn_start(dc->pc);
         num_insns++;
@@ -1929,7 +1929,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
         }
=20
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         disas_uc32_insn(env, dc);
@@ -1959,7 +1959,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
                code.  */
             cpu_abort(cpu, "IO on conditional branch instruction");
         }
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
=20
     /* At this stage dc->condjmp will only be set when the skipped
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 63e4f25c08..63e9646d17 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -514,12 +514,12 @@ static bool gen_check_sr(DisasContext *dc, uint32_t=
 sr, unsigned access)
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
+        gen_io_end(cpu_env);
         return true;
     }
     return false;
@@ -699,11 +699,11 @@ static bool gen_wsr_cpenable(DisasContext *dc, uint=
32_t sr, TCGv_i32 v)
 static void gen_check_interrupts(DisasContext *dc)
 {
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_check_interrupts(cpu_env);
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
 }
=20
@@ -757,11 +757,11 @@ static bool gen_wsr_ps(DisasContext *dc, uint32_t s=
r, TCGv_i32 v)
 static bool gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_wsr_ccount(cpu_env, v);
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
         gen_jumpi_check_loop_end(dc, 0);
         return true;
     }
@@ -798,11 +798,11 @@ static bool gen_wsr_ccompare(DisasContext *dc, uint=
32_t sr, TCGv_i32 v)
         tcg_gen_mov_i32(cpu_SR[sr], v);
         tcg_gen_andi_i32(cpu_SR[INTSET], cpu_SR[INTSET], ~int_bit);
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
         gen_helper_update_ccompare(cpu_env, tmp);
         if (dc->tb->cflags & CF_USE_ICOUNT) {
-            gen_io_end();
+            gen_io_end(cpu_env);
             gen_jumpi_check_loop_end(dc, 0);
             ret =3D true;
         }
@@ -897,11 +897,11 @@ static void gen_waiti(DisasContext *dc, uint32_t im=
m4)
     TCGv_i32 intlevel =3D tcg_const_i32(imm4);
=20
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_start();
+        gen_io_start(cpu_env);
     }
     gen_helper_waiti(cpu_env, pc, intlevel);
     if (dc->tb->cflags & CF_USE_ICOUNT) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
     tcg_temp_free(pc);
     tcg_temp_free(intlevel);
@@ -3156,7 +3156,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
         dc.next_icount =3D tcg_temp_local_new_i32();
     }
=20
-    gen_tb_start(tb);
+    gen_tb_start(tb, cpu_env);
=20
     if ((tb->cflags & CF_USE_ICOUNT) &&
         (tb->flags & XTENSA_TBFLAG_YIELD)) {
@@ -3191,7 +3191,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
         }
=20
         if (insn_count =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
+            gen_io_start(cpu_env);
         }
=20
         if (dc.icount) {
@@ -3232,7 +3232,7 @@ done:
     }
=20
     if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
+        gen_io_end(cpu_env);
     }
=20
     if (dc.is_jmp =3D=3D DISAS_NEXT) {
