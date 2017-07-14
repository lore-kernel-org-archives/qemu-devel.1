Received: from eggs.gnu.org ([2001:4830:134:3::10]:58190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwno-0001VK-RP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVwnm-0006Pp-Gy
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:22:24 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 12:22:12 +0300
Message-Id: <150002413187.22386.156315485813606121.stgit@frigg.lan>
In-Reply-To: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 17/26] target/arm: [tcg,
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Benne=C3=A9 <alex.benee@linaro.org>
---
 target/arm/translate-a64.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5c04ff3d8b..dc91661df0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11247,6 +11247,14 @@ static void aarch64_tr_init_disas_context(DisasC=
ontextBase *dcbase,
     init_tmp_a64_array(dc);
 }
=20
+static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cp=
u)
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
+        aarch64_tr_insn_start(&dc->base, cs);
=20
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
