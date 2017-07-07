Received: from eggs.gnu.org ([2001:4830:134:3::10]:53908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTT6E-0001ob-GW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTT69-00047u-Gj
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:15:10 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri,  7 Jul 2017 15:14:48 +0200
Message-Id: <149943328848.8972.1818197840780080665.stgit@frigg.lan>
In-Reply-To: <149942760788.8972.474351671751194003.stgit@frigg.lan>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 23/27] target/arm: [tcg] Port to tb_stop
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
 target/arm/translate.c |  191 +++++++++++++++++++++++++-----------------=
------
 1 file changed, 101 insertions(+), 90 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9d033f2fb7..00cac01d66 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12017,101 +12017,17 @@ static target_ulong arm_tr_translate_insn(Disa=
sContextBase *dcbase,
     return dc->pc;
 }
=20
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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
-        gen_intermediate_code_a64(&dc->base, cs, tb);
+    if (dc->base.is_jmp =3D=3D DISAS_SKIP) {
         return;
     }
=20
-    dc->base.tb =3D tb;
-    dc->base.pc_first =3D dc->base.tb->pc;
-    dc->base.pc_next =3D dc->base.pc_first;
-    dc->base.is_jmp =3D DISAS_NEXT;
-    dc->base.num_insns =3D 0;
-    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
-    arm_tr_init_disas_context(&dc->base, cs);
-
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
-    arm_tr_tb_start(&dc->base, cs);
-
-    do {
-        dc->base.num_insns++;
-        arm_tr_insn_start(&dc->base, cs);
-
-        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->base.pc_next) {
-                    BreakpointCheckType bp_check =3D
-                        arm_tr_breakpoint_check(&dc->base, cs, bp);
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
-        dc->base.pc_next =3D arm_tr_translate_insn(&dc->base, cs);
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
-            cpu_abort(cs, "IO on conditional branch instruction");
-        }
-        gen_io_end();
+    if (dc->base.tb->cflags & CF_LAST_IO && dc->condjmp) {
+        /* FIXME: This can theoretically happen with self-modifying code=
. */
+        cpu_abort(cpu, "IO on conditional branch instruction");
     }
=20
     /* At this stage dc->condjmp will only be set when the skipped
@@ -12215,6 +12131,101 @@ void gen_intermediate_code(CPUState *cs, Transl=
ationBlock *tb)
             gen_goto_tb(dc, 1, dc->pc);
         }
     }
+}
+
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
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
+        gen_intermediate_code_a64(&dc->base, cs, tb);
+        return;
+    }
+
+    dc->base.tb =3D tb;
+    dc->base.pc_first =3D dc->base.tb->pc;
+    dc->base.pc_next =3D dc->base.pc_first;
+    dc->base.is_jmp =3D DISAS_NEXT;
+    dc->base.num_insns =3D 0;
+    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
+    arm_tr_init_disas_context(&dc->base, cs);
+
+
+    arm_tr_init_globals(&dc->base, cs);
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
+    arm_tr_tb_start(&dc->base, cs);
+
+    do {
+        dc->base.num_insns++;
+        arm_tr_insn_start(&dc->base, cs);
+
+        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
+            CPUBreakpoint *bp;
+            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
+                if (bp->pc =3D=3D dc->base.pc_next) {
+                    BreakpointCheckType bp_check =3D
+                        arm_tr_breakpoint_check(&dc->base, cs, bp);
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
+        dc->base.pc_next =3D arm_tr_translate_insn(&dc->base, cs);
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
+    arm_tr_tb_stop(&dc->base, cs);
+
+    if (dc->base.tb->cflags & CF_LAST_IO) {
+        gen_io_end();
     }
=20
 done_generating:
