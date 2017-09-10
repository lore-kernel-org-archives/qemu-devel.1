Received: from eggs.gnu.org ([2001:4830:134:3::10]:44825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr5Ge-0003Hd-Ma
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr5Gb-0000gP-K9
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:39:32 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:55976)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr5Gb-0000g9-9G
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:39:29 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 10 Sep 2017 19:39:21 +0300
Message-Id: <150506156146.19604.7064966029596517363.stgit@frigg.lan>
In-Reply-To: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/7] trace: Add event "guest_inst_info_after"
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
 accel/tcg/translator.c |   18 ++++++++++++++----
 trace-events           |    8 ++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index c010aeee45..d3039e7fd2 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -36,6 +36,7 @@ void translator_loop(const TranslatorOps *ops, DisasCon=
textBase *db,
                      CPUState *cpu, TranslationBlock *tb)
 {
     target_ulong pc_bbl, pc_insn =3D 0;
+    unsigned int insn_size =3D 0;
     bool translated_insn =3D false;
     int max_insns;
=20
@@ -82,6 +83,8 @@ void translator_loop(const TranslatorOps *ops, DisasCon=
textBase *db,
         /* Tracing after (previous instruction) */
         if (db->num_insns > 0) {
             trace_guest_inst_after_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
+            trace_guest_inst_info_after_tcg(
+                cpu, tcg_ctx.tcg_env, pc_insn, insn_size);
         }
         pc_insn =3D db->pc_next;
=20
@@ -145,7 +148,7 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
         translated_insn =3D true;
         /* Tracing after (patched values) */
         if (TRACE_GUEST_INST_INFO_BEFORE_EXEC_ENABLED) {
-            unsigned int insn_size =3D db->pc_next - pc_insn;
+            insn_size =3D db->pc_next - pc_insn;
             tcg_set_insn_param(insn_size_opcode_idx, 1, insn_size);
         }
=20
@@ -164,7 +167,8 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
=20
     /* Tracing after */
     if (TRACE_GUEST_BBL_AFTER_ENABLED ||
-        TRACE_GUEST_INST_AFTER_ENABLED) {
+        TRACE_GUEST_INST_AFTER_ENABLED ||
+        TRACE_GUEST_INST_INFO_AFTER_ENABLED) {
         tcg_ctx.disas.in_guest_code =3D false;
         if (tcg_ctx.disas.inline_label =3D=3D NULL) {
             tcg_ctx.disas.inline_label =3D gen_new_inline_label();
@@ -175,6 +179,10 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
         if (TRACE_GUEST_INST_AFTER_ENABLED && translated_insn) {
             trace_guest_inst_after_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
         }
+        if (TRACE_GUEST_INST_INFO_AFTER_ENABLED && translated_insn) {
+            trace_guest_inst_info_after_tcg(
+                cpu, tcg_ctx.tcg_env, pc_insn, insn_size);
+        }
         if (TRACE_GUEST_BBL_AFTER_ENABLED) {
             trace_guest_bbl_after_tcg(cpu, tcg_ctx.tcg_env, pc_bbl);
         }
@@ -207,7 +215,8 @@ void translator__gen_goto_tb(TCGContext *ctx)
 {
     if (ctx->disas.in_guest_code &&
         (TRACE_GUEST_BBL_AFTER_ENABLED ||
-         TRACE_GUEST_INST_AFTER_ENABLED)) {
+         TRACE_GUEST_INST_AFTER_ENABLED ||
+         TRACE_GUEST_INST_INFO_AFTER_ENABLED)) {
         if (ctx->disas.inline_label =3D=3D NULL) {
             ctx->disas.inline_label =3D gen_new_inline_label();
         }
@@ -221,7 +230,8 @@ void translator__gen_exit_tb(TCGContext *ctx)
 {
     if (ctx->disas.in_guest_code && !ctx->disas.seen_goto_tb &&
         (TRACE_GUEST_BBL_AFTER_ENABLED ||
-         TRACE_GUEST_INST_AFTER_ENABLED)) {
+         TRACE_GUEST_INST_AFTER_ENABLED ||
+         TRACE_GUEST_INST_INFO_AFTER_ENABLED)) {
         if (ctx->disas.inline_label =3D=3D NULL) {
             ctx->disas.inline_label =3D gen_new_inline_label();
         }
diff --git a/trace-events b/trace-events
index c477302d8d..73d797cb48 100644
--- a/trace-events
+++ b/trace-events
@@ -135,6 +135,14 @@ vcpu tcg guest_inst_after(uint64_t vaddr) "vaddr=3D0=
x%016"PRIx64, "vaddr=3D0x%016"PR
 # Targets: TCG(all)
 disable vcpu tcg guest_inst_info_before(uint64_t vaddr, TCGv_i32 size) "=
vaddr=3D0x%016"PRIx64, "vaddr=3D0x%016"PRIx64" size=3D%d"
=20
+# @vaddr: Instruction's virtual address
+# @size: Instruction's size in bytes
+#
+# Same as 'guest_inst_after', with additional information.
+#
+# Targets: TCG(all)
+disable vcpu tcg guest_inst_info_after(uint64_t vaddr, uint32_t size) "v=
addr=3D0x%016"PRIx64" size=3D%d", "vaddr=3D0x%016"PRIx64" size=3D%d"
+
 # @vaddr: Access' virtual address.
 # @info : Access' information (see below).
 #
