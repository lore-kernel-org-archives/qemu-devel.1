Received: from eggs.gnu.org ([2001:4830:134:3::10]:44028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr5Cl-0002R1-BJ
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr5Ci-00089U-6R
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:35:31 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:56924)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr5Ch-00089K-Ry
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:35:28 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 10 Sep 2017 19:35:19 +0300
Message-Id: <150506131942.19604.1306593039321280342.stgit@frigg.lan>
In-Reply-To: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/7] trace: Add event "guest_inst_after"
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
 accel/tcg/translator.c |   23 ++++++++++++++++++-----
 trace-events           |    8 ++++++++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index d66d601c89..c010aeee45 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -35,7 +35,8 @@ void translator_loop_temp_check(DisasContextBase *db)
 void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
                      CPUState *cpu, TranslationBlock *tb)
 {
-    target_ulong pc_bbl;
+    target_ulong pc_bbl, pc_insn =3D 0;
+    bool translated_insn =3D false;
     int max_insns;
=20
     /* Initialize DisasContext */
@@ -75,10 +76,15 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
     tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit */
=20
     while (true) {
-        target_ulong pc_insn =3D db->pc_next;
         TCGv_i32 insn_size_tcg =3D 0;
         int insn_size_opcode_idx;
=20
+        /* Tracing after (previous instruction) */
+        if (db->num_insns > 0) {
+            trace_guest_inst_after_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
+        }
+        pc_insn =3D db->pc_next;
+
         db->num_insns++;
         if (db->num_insns =3D=3D 1) {
             tcg_ctx.disas.in_guest_code =3D true;
@@ -136,6 +142,7 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
             ops->translate_insn(db, cpu);
         }
=20
+        translated_insn =3D true;
         /* Tracing after (patched values) */
         if (TRACE_GUEST_INST_INFO_BEFORE_EXEC_ENABLED) {
             unsigned int insn_size =3D db->pc_next - pc_insn;
@@ -156,7 +163,8 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
     }
=20
     /* Tracing after */
-    if (TRACE_GUEST_BBL_AFTER_ENABLED) {
+    if (TRACE_GUEST_BBL_AFTER_ENABLED ||
+        TRACE_GUEST_INST_AFTER_ENABLED) {
         tcg_ctx.disas.in_guest_code =3D false;
         if (tcg_ctx.disas.inline_label =3D=3D NULL) {
             tcg_ctx.disas.inline_label =3D gen_new_inline_label();
@@ -164,6 +172,9 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
=20
         gen_set_inline_region_begin(tcg_ctx.disas.inline_label);
=20
+        if (TRACE_GUEST_INST_AFTER_ENABLED && translated_insn) {
+            trace_guest_inst_after_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
+        }
         if (TRACE_GUEST_BBL_AFTER_ENABLED) {
             trace_guest_bbl_after_tcg(cpu, tcg_ctx.tcg_env, pc_bbl);
         }
@@ -195,7 +206,8 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
 void translator__gen_goto_tb(TCGContext *ctx)
 {
     if (ctx->disas.in_guest_code &&
-        (TRACE_GUEST_BBL_AFTER_ENABLED)) {
+        (TRACE_GUEST_BBL_AFTER_ENABLED ||
+         TRACE_GUEST_INST_AFTER_ENABLED)) {
         if (ctx->disas.inline_label =3D=3D NULL) {
             ctx->disas.inline_label =3D gen_new_inline_label();
         }
@@ -208,7 +220,8 @@ void translator__gen_goto_tb(TCGContext *ctx)
 void translator__gen_exit_tb(TCGContext *ctx)
 {
     if (ctx->disas.in_guest_code && !ctx->disas.seen_goto_tb &&
-        (TRACE_GUEST_BBL_AFTER_ENABLED)) {
+        (TRACE_GUEST_BBL_AFTER_ENABLED ||
+         TRACE_GUEST_INST_AFTER_ENABLED)) {
         if (ctx->disas.inline_label =3D=3D NULL) {
             ctx->disas.inline_label =3D gen_new_inline_label();
         }
diff --git a/trace-events b/trace-events
index ce54bb4993..c477302d8d 100644
--- a/trace-events
+++ b/trace-events
@@ -118,6 +118,14 @@ vcpu tcg guest_bbl_after(uint64_t vaddr) "vaddr=3D0x=
%016"PRIx64, "vaddr=3D0x%016"PRI
 # Targets: TCG(all)
 vcpu tcg guest_inst_before(uint64_t vaddr) "vaddr=3D0x%016"PRIx64, "vadd=
r=3D0x%016"PRIx64
=20
+# @vaddr: Instruction's virtual address
+#
+# Mark end of instruction execution (after its operations have taken eff=
ect).
+#
+# Mode: user, softmmu
+# Targets: TCG(all)
+vcpu tcg guest_inst_after(uint64_t vaddr) "vaddr=3D0x%016"PRIx64, "vaddr=
=3D0x%016"PRIx64
+
 # @vaddr: Instruction's virtual address
 # @size: Instruction's size in bytes
 #
