Received: from eggs.gnu.org ([2001:4830:134:3::10]:60402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3mG-0005vP-UV
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3mD-0001Kg-RO
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:24:20 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:47525 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3mD-0001KJ-Dm
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:24:17 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 12:24:06 +0300
Message-Id: <149838264614.6497.9227999339922502463.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 10/26] target: [tcg,
 i386] Refactor breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/i386/translate.c |   48 +++++++++++++++++++++++++++++++++++------=
------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3c7ef4af67..04d65b8416 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
=20
+#include "qemu/error-report.h"
 #include "qemu/host-utils.h"
 #include "cpu.h"
 #include "disas/disas.h"
@@ -8474,12 +8475,32 @@ static void i386_trblock_insn_start(DisasContextB=
ase *db, CPUState *cpu)
     tcg_gen_insn_start(db->pc_next, dc->cc_op);
 }
=20
+static BreakpointCheckType i386_trblock_breakpoint_check(
+    DisasContextBase *db, CPUState *cpu, const CPUBreakpoint *bp)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+    /* If RF is set, suppress an internally generated breakpoint.  */
+    int flags =3D db->tb->flags & HF_RF_MASK ? BP_GDB : BP_ANY;
+    if (bp->flags & flags) {
+        gen_debug(dc, db->pc_next - dc->cs_base);
+        /* The address covered by the breakpoint must be included in
+           [tb->pc, tb->pc + tb->size) in order to for it to be
+           properly cleared -- thus we increment the PC here so that
+           the logic setting tb->size below does the right thing.  */
+        db->pc_next +=3D 1;
+        return BC_HIT_TB;
+    } else {
+        return BC_MISS;
+    }
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
     CPUX86State *env =3D cpu->env_ptr;
     DisasContext dc1, *dc =3D &dc1;
     DisasContextBase *db =3D &dc1.base;
+    CPUBreakpoint *bp;
     int num_insns;
     int max_insns;
=20
@@ -8507,18 +8528,21 @@ void gen_intermediate_code(CPUState *cpu, Transla=
tionBlock *tb)
         i386_trblock_insn_start(db, cpu);
         num_insns++;
=20
-        /* If RF is set, suppress an internally generated breakpoint.  *=
/
-        if (unlikely(cpu_breakpoint_test(cpu, db->pc_next,
-                                         tb->flags & HF_RF_MASK
-                                         ? BP_GDB : BP_ANY))) {
-            gen_debug(dc, db->pc_next - dc->cs_base);
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  *=
/
-            db->pc_next +=3D 1;
-            goto done_generating;
-        }
+        bp =3D NULL;
+        do {
+            bp =3D cpu_breakpoint_get(cpu, db->pc_next, bp);
+            if (unlikely(bp)) {
+                BreakpointCheckType bp_check =3D i386_trblock_breakpoint=
_check(
+                    db, cpu, bp);
+                if (bp_check =3D=3D BC_HIT_TB) {
+                    goto done_generating;
+                } else {
+                    error_report("Unexpected BreakpointCheckType %d", bp=
_check);
+                    abort();
+                }
+            }
+        } while (bp !=3D NULL);
+
         if (num_insns =3D=3D max_insns && (tb->cflags & CF_LAST_IO)) {
             gen_io_start(cpu_env);
         }
