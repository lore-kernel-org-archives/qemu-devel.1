Received: from eggs.gnu.org ([2001:4830:134:3::10]:33072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTS4T-0002RW-V1
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTS4P-0008UZ-0h
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:09:17 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:41173 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTS4O-0008Tw-KR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:09:12 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri,  7 Jul 2017 14:08:57 +0200
Message-Id: <149942933722.8972.9785573707546033518.stgit@frigg.lan>
In-Reply-To: <149942760788.8972.474351671751194003.stgit@frigg.lan>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 07/27] target/i386: [tcg] Port to insn_start
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
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 7819545e37..a4b9e5628f 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8448,6 +8448,13 @@ static void i386_tr_init_disas_context(DisasContex=
tBase *dcbase, CPUState *cpu)
     cpu_cc_srcT =3D tcg_temp_local_new();
 }
=20
+static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -8475,7 +8482,7 @@ void gen_intermediate_code(CPUState *cs, Translatio=
nBlock *tb)
=20
     gen_tb_start(tb);
     for(;;) {
-        tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+        i386_tr_insn_start(&dc->base, cs);
         num_insns++;
=20
         /* If RF is set, suppress an internally generated breakpoint.  *=
/
