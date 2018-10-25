Received: from eggs.gnu.org ([2001:4830:134:3::10]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKg-0006hm-24
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKb-0000MD-R4
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKb-00008c-Fn
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:47 -0400
Message-Id: <20181025172057.20414-39-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 38/48] translator: implement 2-pass translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

The second pass only occurs when a plugin has subscribed to
TB translation events.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h              |  8 ++++
 accel/tcg/translator.c | 91 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index d5afe25c97..479b57d65f 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -720,6 +720,14 @@ struct TCGContext {
 
     TCGLabel *exitreq_label;
 
+    /*
+     * We keep one plugin_tb struct per TCGContext. Note that on every TB
+     * translation we clear but do not free its contents; this way we
+     * avoid a lot of malloc/free churn, since after a few TB's it's
+     * unlikely that we'll need to allocate either more instructions or more
+     * space for instructions (for variable-instruction-length ISAs).
+     */
+    struct qemu_plugin_tb plugin_tb;
     struct qemu_plugin_dyn_cb_arr *plugin_mem_cb;
     struct qemu_plugin_insn *plugin_insn;
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 8591e4b72a..88f9ac62a3 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -17,6 +17,7 @@
 #include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "exec/plugin-gen.h"
 
 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
@@ -35,6 +36,21 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
                      CPUState *cpu, TranslationBlock *tb)
 {
     int bp_insn = 0;
+    int insn_idx = 0;
+    bool tb_trans_cb = false;
+    bool first_pass = true; /* second pass otherwise */
+    void *saved_dc = g_alloca(ops->ctx_size);
+    /* tb->plugin_mask is a u32 */
+    unsigned long plugin_mask = tb->plugin_mask;
+    struct qemu_plugin_tb *plugin_tb = &tcg_ctx->plugin_tb;
+
+    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, &plugin_mask)) {
+        tb_trans_cb = true;
+        plugin_tb->cbs.n = 0;
+        plugin_tb->n = 0;
+        plugin_tb->vaddr = tb->pc;
+        tcg_ctx->plugin_mem_cb = NULL;
+    }
 
     /* Initialize DisasContext */
     db->tb = tb;
@@ -56,6 +72,21 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
         db->max_insns = 1;
     }
 
+ translate:
+    tcg_func_start(tcg_ctx);
+
+    /* See the "2-pass translation" comment below */
+    if (tb_trans_cb) {
+        void *dc = db;
+
+        dc -= ops->ctx_base_offset;
+        if (first_pass) {
+            memcpy(saved_dc, dc, ops->ctx_size);
+        } else {
+            memcpy(dc, saved_dc, ops->ctx_size);
+        }
+    }
+
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
@@ -67,7 +98,53 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
+    if (!first_pass && plugin_tb->cbs.n) {
+        qemu_plugin_gen_vcpu_udata_callbacks(&plugin_tb->cbs);
+    }
+
     while (true) {
+        struct qemu_plugin_insn *plugin_insn = NULL;
+        bool mem_helpers = false;
+
+        /*
+         * 2-pass translation.
+         *
+         * In the first pass we fully determine the TB.
+         * If no plugins have subscribed to TB translation events, we're done.
+         *
+         * If they have, we first share with plugins a TB descriptor so
+         * that plugins can subscribe to instruction-related events, e.g.
+         * memory accesses of particular instructions, or TB execution.
+         * With this info, which is kept in plugin_tb, we then do a second pass,
+         * inserting the appropriate instrumentation into the translated TB.
+         *
+         * Since all translation state is kept in DisasContext, we copy it
+         * before the first pass, and restore it before the second.
+         */
+        if (tb_trans_cb) {
+            if (first_pass) {
+                plugin_insn = qemu_plugin_tb_insn_get(plugin_tb);
+                tcg_ctx->plugin_insn = plugin_insn;
+                plugin_insn->vaddr = db->pc_next;
+                g_assert(tcg_ctx->plugin_mem_cb == NULL);
+            } else {
+                struct qemu_plugin_insn *insn = &plugin_tb->insns[insn_idx++];
+
+                tcg_ctx->plugin_insn = NULL;
+                if (unlikely(insn->exec_cbs.n)) {
+                    qemu_plugin_gen_vcpu_udata_callbacks(&insn->exec_cbs);
+                }
+                if (insn->mem_cbs.n) {
+                    tcg_ctx->plugin_mem_cb = &insn->mem_cbs;
+                    if (insn->calls_helpers) {
+                        qemu_plugin_gen_enable_mem_helpers(&insn->mem_cbs);
+                        mem_helpers = true;
+                    }
+                } else {
+                    tcg_ctx->plugin_mem_cb = NULL;
+                }
+            }
+        }
         db->num_insns++;
         ops->insn_start(db, cpu);
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
@@ -101,10 +178,14 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
             && (tb_cflags(db->tb) & CF_LAST_IO)) {
             /* Accept I/O on the last instruction.  */
             gen_io_start();
-            ops->translate_insn(db, cpu, NULL);
+            ops->translate_insn(db, cpu, plugin_insn);
             gen_io_end();
         } else {
-            ops->translate_insn(db, cpu, NULL);
+            ops->translate_insn(db, cpu, plugin_insn);
+        }
+
+        if (unlikely(mem_helpers)) {
+            qemu_plugin_gen_disable_mem_helpers();
         }
 
         /* Stop translation if translate_insn so indicated.  */
@@ -120,6 +201,12 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
         }
     }
 
+    if (tb_trans_cb && first_pass) {
+        qemu_plugin_tb_trans_cb(cpu, plugin_tb);
+        first_pass = false;
+        goto translate;
+    }
+
     /* Emit code to exit the TB, as indicated by db->is_jmp.  */
     ops->tb_stop(db, cpu);
     gen_tb_end(db->tb, db->num_insns - bp_insn);
-- 
2.17.1
