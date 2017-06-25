Received: from eggs.gnu.org ([2001:4830:134:3::10]:59920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3iN-00049z-N6
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3iH-0007B1-Ce
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:20:19 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:46116 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3iH-0007AF-0r
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:20:13 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 12:20:04 +0300
Message-Id: <149838240417.6497.17254324769778894023.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 09/26] target: [tcg,
 i386] Refactor insn_start
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
 target/i386/translate.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index f0d12a3d13..3c7ef4af67 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8468,6 +8468,12 @@ static void i386_trblock_init_globals(DisasContext=
Base *db, CPUState *cpu)
     cpu_cc_srcT =3D tcg_temp_local_new();
 }
=20
+static void i386_trblock_insn_start(DisasContextBase *db, CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+    tcg_gen_insn_start(db->pc_next, dc->cc_op);
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
@@ -8498,7 +8504,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
=20
     gen_tb_start(tb, cpu_env);
     for(;;) {
-        tcg_gen_insn_start(db->pc_next, dc->cc_op);
+        i386_trblock_insn_start(db, cpu);
         num_insns++;
=20
         /* If RF is set, suppress an internally generated breakpoint.  *=
/
