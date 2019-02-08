Received: from eggs.gnu.org ([209.51.188.92]:52383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grxGg-00008h-Bt
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 22:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grxGf-0001AU-5H
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 22:55:58 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grxGe-00018O-MT
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 22:55:57 -0500
Received: by mail-pf1-x442.google.com with SMTP id c73so1023910pfe.13
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 19:55:56 -0800 (PST)
Received: from cloudburst.twiddle.net (97-126-115-157.tukw.qwest.net.
	[97.126.115.157])
	by smtp.gmail.com with ESMTPSA id a13sm636729pgw.34.2019.02.07.19.55.52
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Feb 2019 19:55:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 19:55:51 -0800
Message-Id: <20190208035551.3036-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] tcg: Diagnose referenced labels that have not
 been emitted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently, a jump to a label that is not defined anywhere will
be emitted not be relocated.  This results in a jump to a random
jump target.  With tcg debugging, print a diagnostic to the -d op
file and abort.

This could help debug or detect errors like
c2d9644e6d ("target/arm: Fix crash on conditional instruction in an IT block")

Reported-by: Roman Kapl <code@rkapl.cz>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h |  1 +
 tcg/tcg.h    | 12 +++++++++---
 tcg/tcg.c    | 23 +++++++++++++++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)
---
This detects errors earlier than the patch that Roman posted.


r~


diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 2d98868d8f..d3e51b15af 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -255,6 +255,7 @@ static inline void tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
 
 static inline void gen_set_label(TCGLabel *l)
 {
+    l->present = 1;
     tcg_gen_op1(INDEX_op_set_label, label_arg(l));
 }
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 045c24a357..32b7cf3489 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -244,16 +244,21 @@ typedef struct TCGRelocation {
     intptr_t addend;
 } TCGRelocation; 
 
-typedef struct TCGLabel {
+typedef struct TCGLabel TCGLabel;
+struct TCGLabel {
+    unsigned present : 1;
     unsigned has_value : 1;
-    unsigned id : 15;
+    unsigned id : 14;
     unsigned refs : 16;
     union {
         uintptr_t value;
         tcg_insn_unit *value_ptr;
         TCGRelocation *first_reloc;
     } u;
-} TCGLabel;
+#ifdef CONFIG_DEBUG_TCG
+    QSIMPLEQ_ENTRY(TCGLabel) next;
+#endif
+};
 
 typedef struct TCGPool {
     struct TCGPool *next;
@@ -685,6 +690,7 @@ struct TCGContext {
 #endif
 
 #ifdef CONFIG_DEBUG_TCG
+    QSIMPLEQ_HEAD(, TCGLabel) labels;
     int temps_in_use;
     int goto_tb_issue_mask;
 #endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 20a5d8f315..9b2bf7f439 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -305,6 +305,9 @@ TCGLabel *gen_new_label(void)
     *l = (TCGLabel){
         .id = s->nb_labels++
     };
+#ifdef CONFIG_DEBUG_TCG
+    QSIMPLEQ_INSERT_TAIL(&s->labels, l, next);
+#endif
 
     return l;
 }
@@ -1092,6 +1095,9 @@ void tcg_func_start(TCGContext *s)
 
     QTAILQ_INIT(&s->ops);
     QTAILQ_INIT(&s->free_ops);
+#ifdef CONFIG_DEBUG_TCG
+    QSIMPLEQ_INIT(&s->labels);
+#endif
 }
 
 static inline TCGTemp *tcg_temp_alloc(TCGContext *s)
@@ -3841,6 +3847,23 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 #endif
 
+#ifdef CONFIG_DEBUG_TCG
+    /* Ensure all labels referenced have been emitted.  */
+    {
+        TCGLabel *l;
+        bool error = false;
+
+        QSIMPLEQ_FOREACH(l, &s->labels, next) {
+            if (unlikely(!l->present) && l->refs) {
+                qemu_log_mask(CPU_LOG_TB_OP,
+                              "$L%d referenced but not present.\n", l->id);
+                error = true;
+            }
+        }
+        assert(!error);
+    }
+#endif
+
 #ifdef CONFIG_PROFILER
     atomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
 #endif
-- 
2.17.2
