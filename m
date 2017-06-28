Received: from eggs.gnu.org ([2001:4830:134:3::10]:47152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCPA-00032n-81
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCP6-00018m-N0
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:11 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:54119)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCP6-00018a-9g
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:08 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 15:48:56 +0300
Message-Id: <149865413649.17063.7416035795116708956.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 08/29] target/i386: [tcg] Refactor
 insn_start
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
 target/i386/translate.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index d015ea73fa..ad57be2928 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8451,6 +8451,13 @@ static void i386_trblock_init_globals(DisasContext=
Base *dcbase, CPUState *cpu)
     cpu_cc_srcT =3D tcg_temp_local_new();
 }
=20
+static void i386_trblock_insn_start(DisasContextBase *dcbase, CPUState *=
cpu)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
@@ -8480,7 +8487,7 @@ void gen_intermediate_code(CPUState *cpu, Translati=
onBlock *tb)
=20
     gen_tb_start(tb);
     for(;;) {
-        tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+        i386_trblock_insn_start(&dc->base, cpu);
         num_insns++;
=20
         /* If RF is set, suppress an internally generated breakpoint.  *=
/
