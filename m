Received: from eggs.gnu.org ([2001:4830:134:3::10]:43219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr58r-0001ES-Pm
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr58n-00078e-Qq
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:31:29 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:35341)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dr58n-00078C-CI
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 12:31:25 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 10 Sep 2017 19:31:17 +0300
Message-Id: <150506107741.19604.8328467942268087647.stgit@frigg.lan>
In-Reply-To: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/7] trace: Add event "guest_bbl_after"
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

Need to use "TCG inlining" to avoid showing a trace entry for each exit
point (up to two per BBL).

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 accel/tcg/translator.c    |   54 +++++++++++++++++++++++++++++++++++++++=
++++++
 include/exec/translator.h |   22 ++++++++++++++++++
 tcg/tcg-op.c              |    2 ++
 tcg/tcg-op.h              |    1 +
 tcg/tcg.h                 |    5 ++++
 trace-events              |   11 +++++++++
 6 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 6598931171..d66d601c89 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -35,6 +35,7 @@ void translator_loop_temp_check(DisasContextBase *db)
 void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
                      CPUState *cpu, TranslationBlock *tb)
 {
+    target_ulong pc_bbl;
     int max_insns;
=20
     /* Initialize DisasContext */
@@ -63,6 +64,11 @@ void translator_loop(const TranslatorOps *ops, DisasCo=
ntextBase *db,
     /* Reset the temp count so that we can identify leaks */
     tcg_clear_temp_count();
=20
+    /* Tracking gen_goto_tb / gen_exit_tb */
+    pc_bbl =3D db->pc_first;
+    tcg_ctx.disas.seen_goto_tb =3D false;
+    tcg_ctx.disas.in_guest_code =3D false;
+
     /* Start translating.  */
     gen_tb_start(db->tb);
     ops->tb_start(db, cpu);
@@ -74,6 +80,11 @@ void translator_loop(const TranslatorOps *ops, DisasCo=
ntextBase *db,
         int insn_size_opcode_idx;
=20
         db->num_insns++;
+        if (db->num_insns =3D=3D 1) {
+            tcg_ctx.disas.in_guest_code =3D true;
+            tcg_ctx.disas.inline_label =3D NULL;
+        }
+
         ops->insn_start(db, cpu);
         tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exi=
t */
=20
@@ -144,6 +155,22 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
         }
     }
=20
+    /* Tracing after */
+    if (TRACE_GUEST_BBL_AFTER_ENABLED) {
+        tcg_ctx.disas.in_guest_code =3D false;
+        if (tcg_ctx.disas.inline_label =3D=3D NULL) {
+            tcg_ctx.disas.inline_label =3D gen_new_inline_label();
+        }
+
+        gen_set_inline_region_begin(tcg_ctx.disas.inline_label);
+
+        if (TRACE_GUEST_BBL_AFTER_ENABLED) {
+            trace_guest_bbl_after_tcg(cpu, tcg_ctx.tcg_env, pc_bbl);
+        }
+
+        gen_set_inline_region_end(tcg_ctx.disas.inline_label);
+    }
+
     /* Emit code to exit the TB, as indicated by db->is_jmp.  */
     ops->tb_stop(db, cpu);
     gen_tb_end(db->tb, db->num_insns);
@@ -163,3 +190,30 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
     }
 #endif
 }
+
+
+void translator__gen_goto_tb(TCGContext *ctx)
+{
+    if (ctx->disas.in_guest_code &&
+        (TRACE_GUEST_BBL_AFTER_ENABLED)) {
+        if (ctx->disas.inline_label =3D=3D NULL) {
+            ctx->disas.inline_label =3D gen_new_inline_label();
+        }
+        gen_set_inline_point(ctx->disas.inline_label);
+        /* disable next exit_tb */
+        ctx->disas.seen_goto_tb =3D true;
+    }
+}
+
+void translator__gen_exit_tb(TCGContext *ctx)
+{
+    if (ctx->disas.in_guest_code && !ctx->disas.seen_goto_tb &&
+        (TRACE_GUEST_BBL_AFTER_ENABLED)) {
+        if (ctx->disas.inline_label =3D=3D NULL) {
+            ctx->disas.inline_label =3D gen_new_inline_label();
+        }
+        gen_set_inline_point(ctx->disas.inline_label);
+        /* enable next exit_tb */
+        ctx->disas.seen_goto_tb =3D false;
+    }
+}
diff --git a/include/exec/translator.h b/include/exec/translator.h
index e2dc2a04ae..83aeea59a1 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -20,7 +20,6 @@
=20
=20
 #include "exec/exec-all.h"
-#include "tcg/tcg.h"
=20
=20
 /**
@@ -71,6 +70,21 @@ typedef struct DisasContextBase {
     bool singlestep_enabled;
 } DisasContextBase;
=20
+/**
+ * TCGContextDisas:
+ * @seen_goto_tb: Whether we've seen a call to tcg_gen_goto_tb().
+ * @in_guest_code: Whether we're generating guest code (or supporting
+ *                 boilerplate otherwise).
+ * @inline_label: Inline label.
+ *
+ * Extensions to #TCGContext specific to the generic translation framewo=
rk.
+ */
+typedef struct TCGContextDisas {
+    bool seen_goto_tb;
+    bool in_guest_code;
+    TCGInlineLabel *inline_label;
+} TCGContextDisas;
+
 /**
  * TranslatorOps:
  * @init_disas_context:
@@ -117,6 +131,8 @@ typedef struct TranslatorOps {
     void (*disas_log)(const DisasContextBase *db, CPUState *cpu);
 } TranslatorOps;
=20
+#include "tcg/tcg.h"
+
 /**
  * translator_loop:
  * @ops: Target-specific operations.
@@ -141,4 +157,8 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
=20
 void translator_loop_temp_check(DisasContextBase *db);
=20
+/* Internal functions to hook tracing into */
+void translator__gen_goto_tb(TCGContext *ctx);
+void translator__gen_exit_tb(TCGContext *ctx);
+
 #endif  /* EXEC__TRANSLATOR_H */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 688d91755b..575b4faf84 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2578,6 +2578,8 @@ void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, T=
CGv_i64 arg)
=20
 void tcg_gen_goto_tb(unsigned idx)
 {
+    translator__gen_goto_tb(&tcg_ctx);
+
     /* We only support two chained exits.  */
     tcg_debug_assert(idx <=3D 1);
 #ifdef CONFIG_DEBUG_TCG
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index da3784f8f2..9ab1497bc1 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -817,6 +817,7 @@ static inline void tcg_gen_insn_start(target_ulong pc=
, target_ulong a1,
=20
 static inline void tcg_gen_exit_tb(uintptr_t val)
 {
+    translator__gen_exit_tb(&tcg_ctx);
     tcg_gen_op1i(INDEX_op_exit_tb, val);
 }
=20
diff --git a/tcg/tcg.h b/tcg/tcg.h
index c6e3c6e68d..6483ed75d6 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -655,6 +655,8 @@ QEMU_BUILD_BUG_ON(OPPARAM_BUF_SIZE > (1 << 14));
 /* Make sure that we don't overflow 64 bits without noticing.  */
 QEMU_BUILD_BUG_ON(sizeof(TCGOp) > 8);
=20
+#include "exec/translator.h"
+
 struct TCGContext {
     uint8_t *pool_cur, *pool_end;
     TCGPool *pool_first, *pool_current, *pool_first_large;
@@ -730,6 +732,9 @@ struct TCGContext {
     CPUState *cpu;                      /* *_trans */
     TCGv_env tcg_env;                   /* *_exec  */
=20
+    /* Used by generic gen_intermediate_code */
+    TCGContextDisas disas;
+
     /* These structures are private to tcg-target.inc.c.  */
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     struct TCGLabelQemuLdst *ldst_labels;
diff --git a/trace-events b/trace-events
index 4e61697297..ce54bb4993 100644
--- a/trace-events
+++ b/trace-events
@@ -99,6 +99,17 @@ vcpu guest_cpu_reset(void)
 # Targets: TCG(all)
 vcpu tcg guest_bbl_before(uint64_t vaddr) "vaddr=3D0x%016"PRIx64, "vaddr=
=3D0x%016"PRIx64
=20
+# @vaddr: BBL's starting virtual address
+#
+# Mark end of BBL execution (after the BBL-exiting instruction).
+#
+# NOTE: This event might not be raised if the BBL ends unexpectedly (e.g=
.,
+#       triggers an exception).
+#
+# Mode: user, softmmu
+# Targets: TCG(all)
+vcpu tcg guest_bbl_after(uint64_t vaddr) "vaddr=3D0x%016"PRIx64, "vaddr=3D=
0x%016"PRIx64
+
 # @vaddr: Instruction's virtual address
 #
 # Mark start of instruction execution (before anything gets really execu=
ted).
