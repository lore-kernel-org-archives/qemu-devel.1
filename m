Received: from eggs.gnu.org ([2001:4830:134:3::10]:36571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVxFB-0007CG-RD
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVxF8-0004mv-Of
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:50:41 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 12:50:27 +0300
Message-Id: <150002582711.22386.191527630537864599.stgit@frigg.lan>
In-Reply-To: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 24/26] target/arm: [tcg] Port to disas_log
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
 target/arm/translate.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f221cbee5d..507f51d001 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12135,6 +12135,15 @@ static void arm_tr_tb_stop(DisasContextBase *dcb=
ase, CPUState *cpu)
     }
 }
=20
+static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *c=
pu)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+
+    qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+    log_target_disas(cpu, dc->base.pc_first, dc->pc - dc->base.pc_first,
+                     dc->thumb | (dc->sctlr_b << 1));
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -12222,9 +12231,7 @@ void gen_intermediate_code(CPUState *cs, Translat=
ionBlock *tb)
         qemu_log_in_addr_range(dc->base.pc_first)) {
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
-        log_target_disas(cs, dc->base.pc_first, dc->pc - dc->base.pc_fir=
st,
-                         dc->thumb | (dc->sctlr_b << 1));
+        arm_tr_disas_log(&dc->base, cs);
         qemu_log("\n");
         qemu_log_unlock();
     }
