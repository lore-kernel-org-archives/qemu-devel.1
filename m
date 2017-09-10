Received: from eggs.gnu.org ([2001:4830:134:3::10]:40565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr4xA-00059P-28
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr4x6-0002rs-3b
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:19:24 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:55797)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr4x5-0002rR-Oq
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:19:20 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 10 Sep 2017 19:19:11 +0300
Message-Id: <150506035158.19604.740046564057160055.stgit@frigg.lan>
In-Reply-To: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/7] trace: Add event "guest_inst_before"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 accel/tcg/translator.c |    3 +++
 trace-events           |    8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 91b3b0da32..287d27b4f7 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -69,6 +69,8 @@ void translator_loop(const TranslatorOps *ops, DisasCon=
textBase *db,
     tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit */
=20
     while (true) {
+        target_ulong pc_insn =3D db->pc_next;
+
         db->num_insns++;
         ops->insn_start(db, cpu);
         tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exi=
t */
@@ -96,6 +98,7 @@ void translator_loop(const TranslatorOps *ops, DisasCon=
textBase *db,
         if (db->num_insns =3D=3D 1) {
             trace_guest_bbl_before_tcg(cpu, tcg_ctx.tcg_env, db->pc_firs=
t);
         }
+        trace_guest_inst_before_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
=20
         /* Disassemble one instruction.  The translate_insn hook should
            update db->pc_next and db->is_jmp to indicate what should be
diff --git a/trace-events b/trace-events
index d242f54254..46457c6158 100644
--- a/trace-events
+++ b/trace-events
@@ -99,6 +99,14 @@ vcpu guest_cpu_reset(void)
 # Targets: TCG(all)
 vcpu tcg guest_bbl_before(uint64_t vaddr) "vaddr=3D0x%016"PRIx64, "vaddr=
=3D0x%016"PRIx64
=20
+# @vaddr: Instruction's virtual address
+#
+# Mark start of instruction execution (before anything gets really execu=
ted).
+#
+# Mode: user, softmmu
+# Targets: TCG(all)
+vcpu tcg guest_inst_before(uint64_t vaddr) "vaddr=3D0x%016"PRIx64, "vadd=
r=3D0x%016"PRIx64
+
 # @vaddr: Access' virtual address.
 # @info : Access' information (see below).
 #
