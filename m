Received: from eggs.gnu.org ([2001:4830:134:3::10]:38682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4in-00014O-RD
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4ik-0002Cx-Me
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:24:49 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 13:24:38 +0300
Message-Id: <149838627784.6497.8303638411162957700.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 25/26] target: [tcg, arm] Port to disas_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/arm/translate-a64.c |   10 +++++++++-
 target/arm/translate.c     |   10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b14e96cd58..97e8bda230 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11389,6 +11389,13 @@ static void aarch64_trblock_tb_stop(DisasContext=
Base *db, CPUState *cpu)
     }
 }
=20
+static int aarch64_trblock_disas_flags(const DisasContextBase *db)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+
+    return 4 | (bswap_code(dc->sctlr_b) ? 2 : 0);
+}
+
 void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
                                TranslationBlock *tb)
 {
@@ -11475,11 +11482,12 @@ done_generating:
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
         qemu_log_in_addr_range(db->pc_first)) {
+        int disas_flags =3D aarch64_trblock_disas_flags(db);
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(db->pc_first));
         log_target_disas(cs, db->pc_first, dc->pc - db->pc_first,
-                         4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
+                         disas_flags);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index db31611258..d87328602a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12179,6 +12179,13 @@ static void arm_trblock_tb_stop(DisasContextBase=
 *db, CPUState *cpu)
     }
 }
=20
+static int arm_trblock_disas_flags(const DisasContextBase *db)
+{
+    DisasContext *dc =3D container_of(db, DisasContext, base);
+
+    return dc->thumb | (dc->sctlr_b << 1);
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
@@ -12274,11 +12281,12 @@ done_generating:
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
         qemu_log_in_addr_range(db->pc_first)) {
+        int disas_flags =3D arm_trblock_disas_flags(db);
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(db->pc_first));
         log_target_disas(cpu, db->pc_first, dc->pc - db->pc_first,
-                         dc->thumb | (dc->sctlr_b << 1));
+                         disas_flags);
         qemu_log("\n");
         qemu_log_unlock();
     }
