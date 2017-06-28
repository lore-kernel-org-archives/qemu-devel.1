Received: from eggs.gnu.org ([2001:4830:134:3::10]:53025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCih-0004Gz-Hv
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCie-0005hW-C9
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:09:23 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:52550)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCid-0005gm-Qd
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:09:20 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 16:09:06 +0300
Message-Id: <149865534644.17063.5754453204442221401.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 13/29] target/i386: [tcg] Port to generic
 translation framework
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

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/i386/translate.c |  120 +++++++----------------------------------=
------
 1 file changed, 18 insertions(+), 102 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3950fe95a4..295be26a95 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8454,6 +8454,10 @@ static void i386_trblock_init_globals(DisasContext=
Base *dcbase, CPUState *cpu)
     cpu_cc_srcT =3D tcg_temp_local_new();
 }
=20
+static void i386_trblock_tb_start(DisasContextBase *db, CPUState *cpu)
+{
+}
+
 static void i386_trblock_insn_start(DisasContextBase *dcbase, CPUState *=
cpu)
 {
     DisasContext *dc =3D container_of(dcbase, DisasContext, base);
@@ -8472,7 +8476,7 @@ static BreakpointCheckType i386_trblock_breakpoint_=
check(
         /* The address covered by the breakpoint must be included in
            [tb->pc, tb->pc + tb->size) in order to for it to be
            properly cleared -- thus we increment the PC here so that
-           the logic setting tb->size below does the right thing.  */
+           the generic logic setting tb->size later does the right thing=
.  */
         dc->base.pc_next +=3D 1;
         return BC_HIT_TB;
     } else {
@@ -8544,111 +8548,23 @@ static void i386_trblock_disas_log(const DisasCo=
ntextBase *dcbase,
=20
 }
=20
+static const TranslatorOps i386_trblock_ops =3D {
+    .init_disas_context =3D i386_trblock_init_disas_context,
+    .init_globals =3D i386_trblock_init_globals,
+    .tb_start =3D i386_trblock_tb_start,
+    .insn_start =3D i386_trblock_insn_start,
+    .breakpoint_check =3D i386_trblock_breakpoint_check,
+    .translate_insn =3D i386_trblock_translate_insn,
+    .tb_stop =3D i386_trblock_tb_stop,
+    .disas_log =3D i386_trblock_disas_log,
+};
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    DisasContext dc1, *dc =3D &dc1;
-    int num_insns;
-    int max_insns;
-
-    /* generate intermediate code */
-    dc->base.singlestep_enabled =3D cpu->singlestep_enabled;
-    dc->base.tb =3D tb;
-    dc->base.is_jmp =3D DISAS_NEXT;
-    dc->base.pc_first =3D tb->pc;
-    dc->base.pc_next =3D dc->base.pc_first;
-    i386_trblock_init_disas_context(&dc->base, cpu);
-
-    i386_trblock_init_globals(&dc->base, cpu);
-
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
-    for(;;) {
-        i386_trblock_insn_start(&dc->base, cpu);
-        num_insns++;
-
-        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->base.pc_next) {
-                    BreakpointCheckType bp_check =3D
-                        i386_trblock_breakpoint_check(&dc->base, cpu, bp=
);
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
-        if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
-
-        dc->base.pc_next =3D i386_trblock_translate_insn(&dc->base, cpu)=
;
-        /* stop translation if indicated */
-        if (dc->base.is_jmp) {
-            break;
-        }
-        /* if single step mode, we generate only one instruction and
-           generate an exception */
-        if (dc->base.singlestep_enabled) {
-            dc->base.is_jmp =3D DISAS_TOO_MANY;
-            break;
-        }
-        /* if too long translation, stop generation too */
-        if (tcg_op_buf_full() ||
-            num_insns >=3D max_insns) {
-            dc->base.is_jmp =3D DISAS_TOO_MANY;
-            break;
-        }
-        if (singlestep) {
-            dc->base.is_jmp =3D DISAS_TOO_MANY;
-            break;
-        }
-    }
-    i386_trblock_tb_stop(&dc->base, cpu);
-    if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
-done_generating:
-    gen_tb_end(tb, num_insns);
-
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(dc->base.pc_first)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        i386_trblock_disas_log(&dc->base, cpu);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
+    DisasContext dc1;
=20
-    tb->size =3D dc->base.pc_next - dc->base.pc_first;
-    tb->icount =3D num_insns;
+    translate_block(&i386_trblock_ops, &dc1.base, cpu, tb);
 }
=20
 void restore_state_to_opc(CPUX86State *env, TranslationBlock *tb,
