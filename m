Received: from eggs.gnu.org ([2001:4830:134:3::10]:41423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr513-00074o-MM
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr50z-0003wf-N7
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:23:25 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:57795)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr50z-0003wR-C1
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:23:21 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 10 Sep 2017 19:23:13 +0300
Message-Id: <150506059354.19604.5050182852156612042.stgit@frigg.lan>
In-Reply-To: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/7] trace: Add event "guest_inst_info_before"
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
 accel/tcg/translator.c |   18 ++++++++++++++++++
 trace-events           |    9 +++++++++
 2 files changed, 27 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 287d27b4f7..6598931171 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -70,6 +70,8 @@ void translator_loop(const TranslatorOps *ops, DisasCon=
textBase *db,
=20
     while (true) {
         target_ulong pc_insn =3D db->pc_next;
+        TCGv_i32 insn_size_tcg =3D 0;
+        int insn_size_opcode_idx;
=20
         db->num_insns++;
         ops->insn_start(db, cpu);
@@ -99,6 +101,16 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
             trace_guest_bbl_before_tcg(cpu, tcg_ctx.tcg_env, db->pc_firs=
t);
         }
         trace_guest_inst_before_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
+        if (TRACE_GUEST_INST_INFO_BEFORE_EXEC_ENABLED) {
+            insn_size_tcg =3D tcg_temp_new_i32();
+            insn_size_opcode_idx =3D tcg_op_buf_count();
+            tcg_gen_movi_i32(insn_size_tcg, 0xdeadbeef);
+
+            trace_guest_inst_info_before_tcg(
+                cpu, tcg_ctx.tcg_env, pc_insn, insn_size_tcg);
+
+            tcg_temp_free_i32(insn_size_tcg);
+        }
=20
         /* Disassemble one instruction.  The translate_insn hook should
            update db->pc_next and db->is_jmp to indicate what should be
@@ -113,6 +125,12 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
             ops->translate_insn(db, cpu);
         }
=20
+        /* Tracing after (patched values) */
+        if (TRACE_GUEST_INST_INFO_BEFORE_EXEC_ENABLED) {
+            unsigned int insn_size =3D db->pc_next - pc_insn;
+            tcg_set_insn_param(insn_size_opcode_idx, 1, insn_size);
+        }
+
         /* Stop translation if translate_insn so indicated.  */
         if (db->is_jmp !=3D DISAS_NEXT) {
             break;
diff --git a/trace-events b/trace-events
index 46457c6158..4e61697297 100644
--- a/trace-events
+++ b/trace-events
@@ -107,6 +107,15 @@ vcpu tcg guest_bbl_before(uint64_t vaddr) "vaddr=3D0=
x%016"PRIx64, "vaddr=3D0x%016"PR
 # Targets: TCG(all)
 vcpu tcg guest_inst_before(uint64_t vaddr) "vaddr=3D0x%016"PRIx64, "vadd=
r=3D0x%016"PRIx64
=20
+# @vaddr: Instruction's virtual address
+# @size: Instruction's size in bytes
+#
+# Same as 'guest_inst_before', with additional information.
+#
+# Mode: user, softmmu
+# Targets: TCG(all)
+disable vcpu tcg guest_inst_info_before(uint64_t vaddr, TCGv_i32 size) "=
vaddr=3D0x%016"PRIx64, "vaddr=3D0x%016"PRIx64" size=3D%d"
+
 # @vaddr: Access' virtual address.
 # @info : Access' information (see below).
 #
