Received: from eggs.gnu.org ([2001:4830:134:3::10]:38013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTSKN-0003AS-Ez
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTSKJ-0007FS-GH
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:25:43 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:39384 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTSKI-0007FA-Rx
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:25:39 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri,  7 Jul 2017 14:25:24 +0200
Message-Id: <149943032384.8972.6794745647101488529.stgit@frigg.lan>
In-Reply-To: <149942760788.8972.474351671751194003.stgit@frigg.lan>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 11/27] target/i386: [tcg] Port to disas_log
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
 target/i386/translate.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 586f5740ec..94b09e0f6d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8522,6 +8522,23 @@ static void i386_tr_tb_stop(DisasContextBase *dcba=
se, CPUState *cpu)
     }
 }
=20
+static void i386_tr_disas_log(const DisasContextBase *dcbase,
+                              CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+    int disas_flags =3D !dc->code32;
+
+    qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+#ifdef TARGET_X86_64
+    if (dc->code64) {
+        disas_flags =3D 2;
+    }
+#endif
+    log_target_disas(cpu, dc->base.pc_first, dc->base.pc_next - dc->base=
.pc_first,
+                     disas_flags);
+
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
@@ -8615,18 +8632,9 @@ done_generating:
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(dc->base.pc_first)) {
-        int disas_flags;
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
-#ifdef TARGET_X86_64
-        if (dc->code64)
-            disas_flags =3D 2;
-        else
-#endif
-            disas_flags =3D !dc->code32;
-        log_target_disas(cs, dc->base.pc_first, dc->base.pc_next - dc->b=
ase.pc_first,
-                         disas_flags);
+        i386_tr_disas_log(&dc->base, cs);
         qemu_log("\n");
         qemu_log_unlock();
     }
