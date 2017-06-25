Received: from eggs.gnu.org ([2001:4830:134:3::10]:33393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3xy-00018O-Cd
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3xv-0000Nh-BT
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:36:26 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:55098 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3xu-0000NX-Vj
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:36:23 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 12:36:12 +0300
Message-Id: <149838337207.6497.2684491711424225877.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 13/26] target: [tcg,
 i386] Refactor disas_flags
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
 target/i386/translate.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index e7b46d282a..5e426de947 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8540,10 +8540,25 @@ static void i386_trblock_tb_stop(DisasContextBase=
 *db, CPUState *cpu)
     }
 }
=20
+static int i386_trblock_disas_flags(const DisasContextBase *db)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+
+#ifdef TARGET_X86_64
+    if (dc->code64) {
+        return 2;
+    } else {
+        return !dc->code32;
+    }
+#else
+    return !dc->code32;
+#endif
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    DisasContext dc1, *dc =3D &dc1;
+    DisasContext dc1;
     DisasContextBase *db =3D &dc1.base;
     CPUBreakpoint *bp;
     int num_insns;
@@ -8623,16 +8638,10 @@ done_generating:
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(db->pc_first)) {
-        int disas_flags;
+        int disas_flags =3D i386_trblock_disas_flags(db);
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(db->pc_first));
-#ifdef TARGET_X86_64
-        if (dc->code64)
-            disas_flags =3D 2;
-        else
-#endif
-            disas_flags =3D !dc->code32;
         log_target_disas(cpu, db->pc_first, db->pc_next - db->pc_first,
                          disas_flags);
         qemu_log("\n");
