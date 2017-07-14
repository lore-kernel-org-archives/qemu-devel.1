Received: from eggs.gnu.org ([2001:4830:134:3::10]:52404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwQP-0007mh-79
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwQK-0003bG-AF
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:58:13 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:37732 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwQJ-0003aj-UY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:58:08 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 11:57:57 +0300
Message-Id: <150002267714.22386.5095442346868988808.stgit@frigg.lan>
In-Reply-To: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 11/26] target/i386: [tcg] Port to generic
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Tested-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c |  107 +++++++++--------------------------------=
------
 1 file changed, 20 insertions(+), 87 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a7c227203a..589b7da500 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8449,6 +8449,11 @@ static void i386_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cpu)
     cpu_cc_srcT =3D tcg_temp_local_new();
 }
=20
+static void i386_tr_tb_start(DisasContextBase *db, CPUState *cpu,
+                             int *max_insns)
+{
+}
+
 static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc =3D container_of(dcbase, DisasContext, base);
@@ -8467,7 +8472,7 @@ static bool i386_tr_breakpoint_check(DisasContextBa=
se *dcbase, CPUState *cpu,
         /* The address covered by the breakpoint must be included in
            [tb->pc, tb->pc + tb->size) in order to for it to be
            properly cleared -- thus we increment the PC here so that
-           the logic setting tb->size below does the right thing.  */
+           the generic logic setting tb->size later does the right thing=
.  */
         dc->base.pc_next +=3D 1;
         return true;
     } else {
@@ -8538,94 +8543,22 @@ static void i386_tr_disas_log(const DisasContextB=
ase *dcbase,
=20
 }
=20
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
-{
-    DisasContext dc1, *dc =3D &dc1;
-    int num_insns;
-    int max_insns;
-
-    /* generate intermediate code */
-    dc->base.singlestep_enabled =3D cs->singlestep_enabled;
-    dc->base.tb =3D tb;
-    dc->base.is_jmp =3D DISAS_NEXT;
-    dc->base.pc_first =3D tb->pc;
-    dc->base.pc_next =3D dc->base.pc_first;
-    i386_tr_init_disas_context(&dc->base, cs);
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
-        i386_tr_insn_start(&dc->base, cs);
-        num_insns++;
-
-        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc =3D=3D dc->base.pc_next) {
-                    if (i386_tr_breakpoint_check(&dc->base, cs, bp)) {
-                        break;
-                    }
-                }
-            }
-
-            if (dc->base.is_jmp =3D=3D DISAS_NORETURN) {
-                break;
-            }
-        }
-
-        if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
-
-        dc->base.pc_next =3D i386_tr_translate_insn(&dc->base, cs);
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
-    i386_tr_tb_stop(&dc->base, cs);
-    if (tb->cflags & CF_LAST_IO)
-        gen_io_end();
-    gen_tb_end(tb, num_insns);
+static const TranslatorOps i386_tr_ops =3D {
+    .init_disas_context =3D i386_tr_init_disas_context,
+    .tb_start           =3D i386_tr_tb_start,
+    .insn_start         =3D i386_tr_insn_start,
+    .breakpoint_check   =3D i386_tr_breakpoint_check,
+    .translate_insn     =3D i386_tr_translate_insn,
+    .tb_stop            =3D i386_tr_tb_stop,
+    .disas_log          =3D i386_tr_disas_log,
+};
=20
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(dc->base.pc_first)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        i386_tr_disas_log(&dc->base, cs);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+{
+    DisasContext dc;
=20
-    tb->size =3D dc->base.pc_next - dc->base.pc_first;
-    tb->icount =3D num_insns;
+    translator_loop(&i386_tr_ops, &dc.base, cpu, tb);
 }
=20
 void restore_state_to_opc(CPUX86State *env, TranslationBlock *tb,
