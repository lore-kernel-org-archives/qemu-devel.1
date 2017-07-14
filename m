Received: from eggs.gnu.org ([2001:4830:134:3::10]:48079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwAk-00028V-SO
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwAh-0003hO-OZ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:42:02 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:43904 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwAh-0003h2-Ca
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:41:59 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 11:41:48 +0300
Message-Id: <150002170871.22386.2172835658104140576.stgit@frigg.lan>
In-Reply-To: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 07/26] target/i386: [tcg] Port to
 breakpoint_check
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c |   45 +++++++++++++++++++++++++++++++++--------=
----
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a4b9e5628f..d3df91041f 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8455,6 +8455,25 @@ static void i386_tr_insn_start(DisasContextBase *d=
cbase, CPUState *cpu)
     tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
 }
=20
+static bool i386_tr_breakpoint_check(DisasContextBase *dcbase, CPUState =
*cpu,
+                                     const CPUBreakpoint *bp)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+    /* If RF is set, suppress an internally generated breakpoint.  */
+    int flags =3D dc->base.tb->flags & HF_RF_MASK ? BP_GDB : BP_ANY;
+    if (bp->flags & flags) {
+        gen_debug(dc, dc->base.pc_next - dc->cs_base);
+        /* The address covered by the breakpoint must be included in
+           [tb->pc, tb->pc + tb->size) in order to for it to be
+           properly cleared -- thus we increment the PC here so that
+           the logic setting tb->size below does the right thing.  */
+        dc->base.pc_next +=3D 1;
+        return true;
+    } else {
+        return false;
+    }
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -8485,18 +8504,21 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
         i386_tr_insn_start(&dc->base, cs);
         num_insns++;
=20
-        /* If RF is set, suppress an internally generated breakpoint.  *=
/
-        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next,
-                                         tb->flags & HF_RF_MASK
-                                         ? BP_GDB : BP_ANY))) {
-            gen_debug(dc, dc->base.pc_next - dc->cs_base);
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  *=
/
-            dc->base.pc_next +=3D 1;
-            goto done_generating;
+        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
+            CPUBreakpoint *bp;
+            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
+                if (bp->pc =3D=3D dc->base.pc_next) {
+                    if (i386_tr_breakpoint_check(&dc->base, cs, bp)) {
+                        break;
+                    }
+                }
+            }
+
+            if (dc->base.is_jmp =3D=3D DISAS_NORETURN) {
+                break;
+            }
         }
+
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
             gen_io_start();
         }
@@ -8547,7 +8569,6 @@ void gen_intermediate_code(CPUState *cs, Translatio=
nBlock *tb)
     }
     if (tb->cflags & CF_LAST_IO)
         gen_io_end();
-done_generating:
     gen_tb_end(tb, num_insns);
=20
 #ifdef DEBUG_DISAS
