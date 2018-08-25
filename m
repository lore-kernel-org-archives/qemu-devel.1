Received: from eggs.gnu.org ([2001:4830:134:3::10]:42336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <code@rkapl.cz>) id 1ftWPx-0007hO-FS
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 07:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <code@rkapl.cz>) id 1ftWPs-0008Vm-25
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 07:07:45 -0400
Received: from droplet.rkapl.cz ([46.101.253.207]:49332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <code@rkapl.cz>) id 1ftWPr-0008Kn-Nx
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 07:07:39 -0400
From: Roman Kapl <code@rkapl.cz>
Date: Sat, 25 Aug 2018 13:06:34 +0200
Message-Id: <20180825110634.16573-1-code@rkapl.cz>
Subject: [Qemu-devel] [PATCH] tcg: check for undefined labels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Roman Kapl <code@rkapl.cz>

Currently, if a jump to a label that is not defined anywhere in the code
is generated, QEMU will hapilly emit the code, but with effectively
random jump target (no relocation done). At least check that there are
no unprocessed relocations remaining when running a debug build and
print a warning message.

This could help debug or detect earlier errors like
c2d9644e6d ("target/arm: Fix crash on conditional instruction in an IT block")

Signed-off-by: Roman Kapl <code@rkapl.cz>
---
 tcg/tcg.c | 29 +++++++++++++++++++++++++++++
 tcg/tcg.h |  3 ++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index f27b22bd3c..3412502069 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -256,6 +256,21 @@ static __attribute__((unused)) inline void tcg_patch64(tcg_insn_unit *p,
 }
 #endif
 
+static void tcg_pending_relocs_inc(TCGContext *s)
+{
+#ifdef CONFIG_DEBUG_TCG
+    s->pending_relocs++;
+#endif
+}
+
+static void tcg_pending_relocs_dec(TCGContext *s)
+{
+#ifdef CONFIG_DEBUG_TCG
+    tcg_debug_assert(s->pending_relocs > 0);
+    s->pending_relocs--;
+#endif
+}
+
 /* label relocation processing */
 
 static void tcg_out_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
@@ -276,6 +291,7 @@ static void tcg_out_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
         r->addend = addend;
         r->next = l->u.first_reloc;
         l->u.first_reloc = r;
+        tcg_pending_relocs_inc(s);
     }
 }
 
@@ -287,6 +303,7 @@ static void tcg_out_label(TCGContext *s, TCGLabel *l, tcg_insn_unit *ptr)
     tcg_debug_assert(!l->has_value);
 
     for (r = l->u.first_reloc; r != NULL; r = r->next) {
+        tcg_pending_relocs_dec(s);
         patch_reloc(r->ptr, r->type, value, r->addend);
     }
 
@@ -3518,6 +3535,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     s->pool_labels = NULL;
 #endif
+#ifdef CONFIG_DEBUG_TCG
+    s->pending_relocs = 0;
+#endif
 
     num_insns = -1;
     QTAILQ_FOREACH(op, &s->ops, link) {
@@ -3587,6 +3607,15 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         }
     }
     tcg_debug_assert(num_insns >= 0);
+
+#ifdef CONFIG_DEBUG_TCG
+    if (s->pending_relocs) {
+        qemu_log("warning: block at " TARGET_FMT_lx  " has "
+                 "%d unresolved references to jump labels\n",
+                 tb->pc, s->pending_relocs);
+    }
+#endif
+
     s->gen_insn_end_off[num_insns] = tcg_current_code_size(s);
 
     /* Generate TB finalization at the end of block */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index f9f12378e9..e80c511f7c 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -241,7 +241,7 @@ typedef struct TCGRelocation {
     int type;
     tcg_insn_unit *ptr;
     intptr_t addend;
-} TCGRelocation; 
+} TCGRelocation;
 
 typedef struct TCGLabel {
     unsigned has_value : 1;
@@ -679,6 +679,7 @@ struct TCGContext {
 #ifdef CONFIG_DEBUG_TCG
     int temps_in_use;
     int goto_tb_issue_mask;
+    int pending_relocs;
 #endif
 
     /* Code generation.  Note that we specifically do not use tcg_insn_unit
-- 
2.18.0
