Received: from eggs.gnu.org ([2001:4830:134:3::10]:51807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCew-00019A-F7
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCer-0001tv-EK
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:05:30 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:49431)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCer-0001qs-2M
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:05:25 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 16:05:04 +0300
Message-Id: <149865510456.17063.14029858939919926288.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 12/29] target/i386: [tcg] Refactor disas_log
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
 target/i386/translate.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 1ca40c2fe4..3950fe95a4 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8526,6 +8526,24 @@ static void i386_trblock_tb_stop(DisasContextBase =
*dcbase, CPUState *cpu)
     }
 }
=20
+static void i386_trblock_disas_log(const DisasContextBase *dcbase,
+                                   CPUState *cpu)
+{
+    DisasContext *dc =3D container_of(dcbase, DisasContext, base);
+    int disas_flags;
+
+    qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+#ifdef TARGET_X86_64
+    if (dc->code64)
+        disas_flags =3D 2;
+    else
+#endif
+        disas_flags =3D !dc->code32;
+    log_target_disas(cpu, dc->base.pc_first, dc->base.pc_next - dc->base=
.pc_first,
+                     disas_flags);
+
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
@@ -8621,18 +8639,9 @@ done_generating:
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
-        log_target_disas(cpu, dc->base.pc_first, dc->base.pc_next - dc->=
base.pc_first,
-                         disas_flags);
+        i386_trblock_disas_log(&dc->base, cpu);
         qemu_log("\n");
         qemu_log_unlock();
     }
