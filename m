Received: from eggs.gnu.org ([2001:4830:134:3::10]:38244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQDTY-0003MI-27
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQDTU-0001gu-Ul
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:57:48 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 16:57:33 +0300
Message-Id: <149865825357.17063.13113603039704787150.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 25/29] target/arm: [tcg] Port to tb_stop
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
---
 target/arm/translate.c |  195 ++++++++++++++++++++++++++----------------=
------
 1 file changed, 104 insertions(+), 91 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7ab09a7e5f..ef0b870a2f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12018,103 +12018,21 @@ static target_ulong arm_trblock_translate_insn=
(DisasContextBase *dcbase,
     return dc->pc;
 }
=20
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+static void arm_trblock_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
-    DisasContext dc1, *dc =3D &dc1;
-    int max_insns;
-
-    /* generate intermediate code */
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
=20
-    /* The A64 decoder has its own top level loop, because it doesn't ne=
ed
-     * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
-     */
-    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(&dc->base, cpu, tb);
+    if (dc->base.is_jmp =3D=3D DISAS_SKIP) {
         return;
     }
=20
-    dc->base.tb =3D tb;
-    dc->base.pc_first =3D dc->base.tb->pc;
-    dc->base.pc_next =3D dc->base.pc_first;
-    dc->base.is_jmp =3D DISAS_NEXT;
-    dc->base.num_insns =3D 0;
-    dc->base.singlestep_enabled =3D cpu->singlestep_enabled;
-    arm_trblock_init_disas_context(&dc->base, cpu);
-
-
-    arm_trblock_init_globals(&dc->base, cpu);
-    max_insns =3D tb->cflags & CF_COUNT_MASK;
-    if (max_insns =3D=3D 0) {
-        max_insns =3D CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns =3D TCG_MAX_INSNS;
+    if ((dc->base.tb->cflags & CF_LAST_IO) && dc->condjmp) {
+        /* FIXME: This can theoretically happen with self-modifying code=
. */
+        cpu_abort(cpu, "IO on conditional branch instruction");
     }
-
-    gen_tb_start(tb);
-
-    tcg_clear_temp_count();
-    arm_trblock_tb_start(&dc->base, cpu);
-
-    do {
-        dc->base.num_insns++;
-        arm_trblock_insn_start(&dc->base, cpu);
-
-        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->base.pc_next) {
-                    BreakpointCheckType bp_check =3D
-                        arm_trblock_breakpoint_check(&dc->base, cpu, bp)=
;
-                    switch (bp_check) {
-                    case BC_MISS:
-                        /* Target ignored this breakpoint, go to next */
-                        break;
-                    case BC_HIT_INSN:
-                        /* Hit, keep translating */
-                        /*
-                         * TODO: if we're never going to have more than =
one
-                         *       BP in a single address, we can simply u=
se a
-                         *       bool here.
-                         */
-                        goto done_breakpoints;
-                    case BC_HIT_TB:
-                        /* Hit, end TB */
-                        goto done_generating;
-                    default:
-                        g_assert_not_reached();
-                    }
-                }
-            }
-        }
-    done_breakpoints:
-
-        if (dc->base.num_insns =3D=3D max_insns && (tb->cflags & CF_LAST=
_IO)) {
-            gen_io_start();
-        }
-
-        dc->base.pc_next =3D arm_trblock_translate_insn(&dc->base, cpu);
-
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
-                    dc->pc);
-        }
-
-        if (!dc->base.is_jmp && (tcg_op_buf_full() || singlestep ||
-                            dc->base.num_insns >=3D max_insns)) {
-            dc->base.is_jmp =3D DISAS_TOO_MANY;
-        }
-    } while (!dc->base.is_jmp);
-
-    if (dc->base.is_jmp !=3D DISAS_SKIP) {
-    if (tb->cflags & CF_LAST_IO) {
-        if (dc->condjmp) {
-            /* FIXME:  This can theoretically happen with self-modifying
-               code.  */
-            cpu_abort(cpu, "IO on conditional branch instruction");
-        }
-        gen_io_end();
+    if (dc->base.tb->cflags & CF_LAST_IO && dc->condjmp) {
+        /* FIXME: This can theoretically happen with self-modifying code=
. */
+        cpu_abort(cpu, "IO on conditional branch instruction");
     }
=20
     /* At this stage dc->condjmp will only be set when the skipped
@@ -12218,6 +12136,101 @@ void gen_intermediate_code(CPUState *cpu, Trans=
lationBlock *tb)
             gen_goto_tb(dc, 1, dc->pc);
         }
     }
+}
+
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+{
+    DisasContext dc1, *dc =3D &dc1;
+    int max_insns;
+
+    /* generate intermediate code */
+
+    /* The A64 decoder has its own top level loop, because it doesn't ne=
ed
+     * the A32/T32 complexity to do with conditional execution/IT blocks=
/etc.
+     */
+    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
+        gen_intermediate_code_a64(&dc->base, cpu, tb);
+        return;
+    }
+
+    dc->base.tb =3D tb;
+    dc->base.pc_first =3D dc->base.tb->pc;
+    dc->base.pc_next =3D dc->base.pc_first;
+    dc->base.is_jmp =3D DISAS_NEXT;
+    dc->base.num_insns =3D 0;
+    dc->base.singlestep_enabled =3D cpu->singlestep_enabled;
+    arm_trblock_init_disas_context(&dc->base, cpu);
+
+
+    arm_trblock_init_globals(&dc->base, cpu);
+    max_insns =3D tb->cflags & CF_COUNT_MASK;
+    if (max_insns =3D=3D 0) {
+        max_insns =3D CF_COUNT_MASK;
+    }
+    if (max_insns > TCG_MAX_INSNS) {
+        max_insns =3D TCG_MAX_INSNS;
+    }
+
+    gen_tb_start(tb);
+
+    tcg_clear_temp_count();
+    arm_trblock_tb_start(&dc->base, cpu);
+
+    do {
+        dc->base.num_insns++;
+        arm_trblock_insn_start(&dc->base, cpu);
+
+        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+            CPUBreakpoint *bp;
+            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+                if (bp->pc =3D=3D dc->base.pc_next) {
+                    BreakpointCheckType bp_check =3D
+                        arm_trblock_breakpoint_check(&dc->base, cpu, bp)=
;
+                    switch (bp_check) {
+                    case BC_MISS:
+                        /* Target ignored this breakpoint, go to next */
+                        break;
+                    case BC_HIT_INSN:
+                        /* Hit, keep translating */
+                        /*
+                         * TODO: if we're never going to have more than =
one
+                         *       BP in a single address, we can simply u=
se a
+                         *       bool here.
+                         */
+                        goto done_breakpoints;
+                    case BC_HIT_TB:
+                        /* Hit, end TB */
+                        goto done_generating;
+                    default:
+                        g_assert_not_reached();
+                    }
+                }
+            }
+        }
+    done_breakpoints:
+
+        if (dc->base.num_insns =3D=3D max_insns && (tb->cflags & CF_LAST=
_IO)) {
+            gen_io_start();
+        }
+
+        dc->base.pc_next =3D arm_trblock_translate_insn(&dc->base, cpu);
+
+        if (tcg_check_temp_count()) {
+            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n=
",
+                    dc->pc);
+        }
+
+        if (!dc->base.is_jmp && (tcg_op_buf_full() || singlestep ||
+                            dc->base.num_insns >=3D max_insns)) {
+            dc->base.is_jmp =3D DISAS_TOO_MANY;
+        }
+    } while (!dc->base.is_jmp);
+
+    arm_trblock_tb_stop(&dc->base, cpu);
+
+    if (dc->base.tb->cflags & CF_LAST_IO) {
+        gen_io_end();
     }
=20
 done_generating:
