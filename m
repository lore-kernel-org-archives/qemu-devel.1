Received: from eggs.gnu.org ([2001:4830:134:3::10]:38300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4f0-0007QO-00
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4eu-0008LV-8m
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:20:53 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 13:20:36 +0300
Message-Id: <149838603591.6497.5274008259647705750.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 24/26] target: [tcg,arm] Port to tb_stop
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
 target/arm/translate-a64.c |  121 +++++++++++++++--------------
 target/arm/translate.c     |  185 ++++++++++++++++++++++++--------------=
------
 2 files changed, 164 insertions(+), 142 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f618a15062..b14e96cd58 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11327,6 +11327,68 @@ static target_ulong aarch64_trblock_disas_insn(D=
isasContextBase *db,
     return dc->pc;
 }
=20
+static void aarch64_trblock_tb_stop(DisasContextBase *db, CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+
+    if (unlikely(db->singlestep_enabled || dc->ss_active)
+        && db->is_jmp !=3D DJ_EXC) {
+        /* Note that this means single stepping WFI doesn't halt the CPU.
+         * For conditional branch insns this is harmless unreachable cod=
e as
+         * gen_goto_tb() has already handled emitting the debug exceptio=
n
+         * (and thus a tb-jump is not possible when singlestepping).
+         */
+        assert(db->is_jmp !=3D DJ_TB_JUMP);
+        if (db->is_jmp !=3D DJ_JUMP) {
+            gen_a64_set_pc_im(dc->pc);
+        }
+        if (db->singlestep_enabled) {
+            gen_exception_internal(EXCP_DEBUG);
+        } else {
+            gen_step_complete_exception(dc);
+        }
+    } else {
+        /* Cast because target-specific values are not in generic enum *=
/
+        unsigned int is_jmp =3D (unsigned int)db->is_jmp;
+        switch (is_jmp) {
+        case DJ_NEXT:
+        case DJ_TOO_MANY:
+            gen_goto_tb(dc, 1, dc->pc);
+            break;
+        default:
+        case DJ_UPDATE:
+            gen_a64_set_pc_im(dc->pc);
+            /* fall through */
+        case DJ_JUMP:
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            break;
+        case DJ_TB_JUMP:
+        case DJ_EXC:
+        case DJ_SWI:
+            break;
+        case DJ_WFE:
+            gen_a64_set_pc_im(dc->pc);
+            gen_helper_wfe(cpu_env);
+            break;
+        case DJ_YIELD:
+            gen_a64_set_pc_im(dc->pc);
+            gen_helper_yield(cpu_env);
+            break;
+        case DJ_WFI:
+            /* This is a special case because we don't want to just halt=
 the CPU
+             * if trying to debug across a WFI.
+             */
+            gen_a64_set_pc_im(dc->pc);
+            gen_helper_wfi(cpu_env);
+            /* The helper doesn't necessarily throw an exception, but we
+             * must go back to the main loop to check for interrupts any=
way.
+             */
+            tcg_gen_exit_tb(0);
+            break;
+        }
+    }
+}
+
 void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
                                TranslationBlock *tb)
 {
@@ -11401,67 +11463,12 @@ void gen_intermediate_code_a64(DisasContextBase=
 *db, ARMCPU *cpu,
          */
     } while (!db->is_jmp);
=20
+    aarch64_trblock_tb_stop(db, cs);
+
     if (tb->cflags & CF_LAST_IO) {
         gen_io_end(cpu_env);
     }
=20
-    if (unlikely(cs->singlestep_enabled || dc->ss_active)
-        && db->is_jmp !=3D DJ_EXC) {
-        /* Note that this means single stepping WFI doesn't halt the CPU.
-         * For conditional branch insns this is harmless unreachable cod=
e as
-         * gen_goto_tb() has already handled emitting the debug exceptio=
n
-         * (and thus a tb-jump is not possible when singlestepping).
-         */
-        assert(db->is_jmp !=3D DJ_TB_JUMP);
-        if (db->is_jmp !=3D DJ_JUMP) {
-            gen_a64_set_pc_im(dc->pc);
-        }
-        if (cs->singlestep_enabled) {
-            gen_exception_internal(EXCP_DEBUG);
-        } else {
-            gen_step_complete_exception(dc);
-        }
-    } else {
-        /* Cast because target-specific values are not in generic enum *=
/
-        unsigned int is_jmp =3D (unsigned int)db->is_jmp;
-        switch (is_jmp) {
-        case DJ_NEXT:
-        case DJ_TOO_MANY:
-            gen_goto_tb(dc, 1, dc->pc);
-            break;
-        default:
-        case DJ_UPDATE:
-            gen_a64_set_pc_im(dc->pc);
-            /* fall through */
-        case DJ_JUMP:
-            tcg_gen_lookup_and_goto_ptr(cpu_pc);
-            break;
-        case DJ_TB_JUMP:
-        case DJ_EXC:
-        case DJ_SWI:
-            break;
-        case DJ_WFE:
-            gen_a64_set_pc_im(dc->pc);
-            gen_helper_wfe(cpu_env);
-            break;
-        case DJ_YIELD:
-            gen_a64_set_pc_im(dc->pc);
-            gen_helper_yield(cpu_env);
-            break;
-        case DJ_WFI:
-            /* This is a special case because we don't want to just halt=
 the CPU
-             * if trying to debug across a WFI.
-             */
-            gen_a64_set_pc_im(dc->pc);
-            gen_helper_wfi(cpu_env);
-            /* The helper doesn't necessarily throw an exception, but we
-             * must go back to the main loop to check for interrupts any=
way.
-             */
-            tcg_gen_exit_tb(0);
-            break;
-        }
-    }
-
 done_generating:
     gen_tb_end(tb, db->num_insns);
=20
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f4c57ed078..db31611258 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12053,97 +12053,23 @@ static target_ulong arm_trblock_disas_insn(Disa=
sContextBase *db, CPUState *cpu)
     return dc->pc;
 }
=20
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+static void arm_trblock_tb_stop(DisasContextBase *db, CPUState *cpu)
 {
-    CPUARMState *env =3D cpu->env_ptr;
-    ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
-    DisasContext dc1, *dc =3D &dc1;
-    DisasContextBase *db =3D &dc->base;
-    int max_insns;
-    CPUBreakpoint *bp;
-
-    /* generate intermediate code */
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+    /* Cast because target-specific values are not in generic enum */
+    unsigned int is_jmp =3D (unsigned int)db->is_jmp;
=20
-    /* The A64 decoder has its own top level loop, because it doesn't ne=
ed
-     * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
-     */
-    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(db, arm_cpu, tb);
+    if (is_jmp =3D=3D DJ_SKIP) {
         return;
     }
=20
-    db->tb =3D tb;
-    db->pc_first =3D tb->pc;
-    db->pc_next =3D db->pc_first;
-    db->is_jmp =3D DISAS_NEXT;
-    db->num_insns =3D 0;
-    db->singlestep_enabled =3D cpu->singlestep_enabled;
-    arm_trblock_init_disas_context(db, cpu);
-
-
-    arm_trblock_init_globals(db, cpu);
-    max_insns =3D tb->cflags & CF_COUNT_MASK;
-    if (max_insns =3D=3D 0) {
-        max_insns =3D CF_COUNT_MASK;
+    if ((dc->base.tb->cflags & CF_LAST_IO) && dc->condjmp) {
+        /* FIXME: This can theoretically happen with self-modifying code=
. */
+        cpu_abort(cpu, "IO on conditional branch instruction");
     }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns =3D TCG_MAX_INSNS;
-    }
-
-    gen_tb_start(tb, cpu_env);
-
-    tcg_clear_temp_count();
-    arm_trblock_tb_start(db, cpu);
-
-    do {
-        db->num_insns++;
-        arm_trblock_insn_start(db, cpu);
-
-        bp =3D NULL;
-        do {
-            bp =3D cpu_breakpoint_get(cpu, db->pc_next, bp);
-            if (unlikely(bp)) {
-                BreakpointCheckType bp_check =3D arm_trblock_breakpoint_=
check(
-                    db, cpu, bp);
-                if (bp_check =3D=3D BC_HIT_INSN) {
-                    /* Hit, keep translating */
-                    /*
-                     * TODO: if we're never going to have more than one =
BP in a
-                     *       single address, we can simply use a bool he=
re.
-                     */
-                    break;
-                } else {
-                    goto done_generating;
-                }
-            }
-        } while (bp !=3D NULL);
-
-        if (db->num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO))=
 {
-            gen_io_start(cpu_env);
-        }
-
-        db->pc_next =3D arm_trblock_disas_insn(db, cpu);
-
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
-                    dc->pc);
-        }
-
-        if (!db->is_jmp && (tcg_op_buf_full() || singlestep ||
-                            db->num_insns >=3D max_insns)) {
-            db->is_jmp =3D DJ_TOO_MANY;
-        }
-    } while (!db->is_jmp);
-
-    if (db->is_jmp !=3D DJ_SKIP) {
-    if (tb->cflags & CF_LAST_IO) {
-        if (dc->condjmp) {
-            /* FIXME:  This can theoretically happen with self-modifying
-               code.  */
-            cpu_abort(cpu, "IO on conditional branch instruction");
-        }
-        gen_io_end(cpu_env);
+    if (db->tb->cflags & CF_LAST_IO && dc->condjmp) {
+        /* FIXME: This can theoretically happen with self-modifying code=
. */
+        cpu_abort(cpu, "IO on conditional branch instruction");
     }
=20
     /* At this stage dc->condjmp will only be set when the skipped
@@ -12251,6 +12177,95 @@ void gen_intermediate_code(CPUState *cpu, Transl=
ationBlock *tb)
             gen_goto_tb(dc, 1, dc->pc);
         }
     }
+}
+
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+{
+    CPUARMState *env =3D cpu->env_ptr;
+    ARMCPU *arm_cpu =3D arm_env_get_cpu(env);
+    DisasContext dc1, *dc =3D &dc1;
+    DisasContextBase *db =3D &dc->base;
+    int max_insns;
+    CPUBreakpoint *bp;
+
+    /* generate intermediate code */
+
+    /* The A64 decoder has its own top level loop, because it doesn't ne=
ed
+     * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
+     */
+    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
+        gen_intermediate_code_a64(db, arm_cpu, tb);
+        return;
+    }
+
+    db->tb =3D tb;
+    db->pc_first =3D tb->pc;
+    db->pc_next =3D db->pc_first;
+    db->is_jmp =3D DISAS_NEXT;
+    db->num_insns =3D 0;
+    db->singlestep_enabled =3D cpu->singlestep_enabled;
+    arm_trblock_init_disas_context(db, cpu);
+
+
+    arm_trblock_init_globals(db, cpu);
+    max_insns =3D tb->cflags & CF_COUNT_MASK;
+    if (max_insns =3D=3D 0) {
+        max_insns =3D CF_COUNT_MASK;
+    }
+    if (max_insns > TCG_MAX_INSNS) {
+        max_insns =3D TCG_MAX_INSNS;
+    }
+
+    gen_tb_start(tb, cpu_env);
+
+    tcg_clear_temp_count();
+    arm_trblock_tb_start(db, cpu);
+
+    do {
+        db->num_insns++;
+        arm_trblock_insn_start(db, cpu);
+
+        bp =3D NULL;
+        do {
+            bp =3D cpu_breakpoint_get(cpu, db->pc_next, bp);
+            if (unlikely(bp)) {
+                BreakpointCheckType bp_check =3D arm_trblock_breakpoint_=
check(
+                    db, cpu, bp);
+                if (bp_check =3D=3D BC_HIT_INSN) {
+                    /* Hit, keep translating */
+                    /*
+                     * TODO: if we're never going to have more than one =
BP in a
+                     *       single address, we can simply use a bool he=
re.
+                     */
+                    break;
+                } else {
+                    goto done_generating;
+                }
+            }
+        } while (bp !=3D NULL);
+
+        if (db->num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO))=
 {
+            gen_io_start(cpu_env);
+        }
+
+        db->pc_next =3D arm_trblock_disas_insn(db, cpu);
+
+        if (tcg_check_temp_count()) {
+            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
+                    dc->pc);
+        }
+
+        if (!db->is_jmp && (tcg_op_buf_full() || singlestep ||
+                            db->num_insns >=3D max_insns)) {
+            db->is_jmp =3D DJ_TOO_MANY;
+        }
+    } while (!db->is_jmp);
+
+    arm_trblock_tb_stop(db, cpu);
+
+    if (tb->cflags & CF_LAST_IO) {
+        gen_io_end(cpu_env);
     }
=20
 done_generating:
