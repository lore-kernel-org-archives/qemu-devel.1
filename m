Received: from eggs.gnu.org ([2001:4830:134:3::10]:60818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQDA9-00038c-4g
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQDA5-0007I1-7d
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:37:45 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 16:37:23 +0300
Message-Id: <149865704378.17063.12646195470292499503.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 20/29] target/arm: [tcg,
 a64] Port to insn_start
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
 target/arm/translate-a64.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 88624a726d..5784620642 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11247,6 +11247,14 @@ static void aarch64_trblock_init_disas_context(D=
isasContextBase *dcbase,
     init_tmp_a64_array(dc);
 }
=20
+static void aarch64_trblock_insn_start(DisasContextBase *dcbase, CPUStat=
e *cpu)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+
+    dc->insn_start_idx =3D tcg_op_buf_count();
+    tcg_gen_insn_start(dc->pc, 0, 0);
+}
+
 void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
                                TranslationBlock *tb)
 {
@@ -11278,8 +11286,7 @@ void gen_intermediate_code_a64(DisasContextBase *=
dcbase, CPUState *cs,
=20
     do {
         dc->base.num_insns++;
-        dc->insn_start_idx =3D tcg_op_buf_count();
-        tcg_gen_insn_start(dc->pc, 0, 0);
+        aarch64_trblock_insn_start(&dc->base, cs);
=20
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
