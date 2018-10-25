Received: from eggs.gnu.org ([2001:4830:134:3::10]:40456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKm-0006j1-KA
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjJl-0008Pr-JQ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjJl-0008PG-Eb
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:18 -0400
Message-Id: <20181025172057.20414-10-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 09/48] tcg: reset runtime helpers when flushing
 the code cache
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

In preparation for adding plugin support. One of the clean-up
actions when uninstalling plugins will be to flush the code
cache. We'll also have to clear the runtime helpers, since
some of those runtime helpers may belong to the plugin
being uninstalled.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h                 |  1 +
 accel/tcg/translate-all.c |  1 +
 tcg/tcg.c                 | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 3fa434d891..2c378415d2 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1079,6 +1079,7 @@ bool tcg_op_supported(TCGOpcode op);
 void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);
 void tcg_gen_runtime_helper(const TCGHelperInfo *orig, TCGTemp *ret, int nargs,
                             TCGTemp **args);
+void tcg_reset_runtime_helpers(void);
 
 TCGOp *tcg_emit_op(TCGOpcode opc);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 038d82fdb5..c8b3e0a491 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1255,6 +1255,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     page_flush_tb();
+    tcg_reset_runtime_helpers();
 
     tcg_region_reset_all();
     /* XXX: flush processor icache at this point if cache flush is
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 87e02da740..a6824145b0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -874,6 +874,7 @@ static const TCGHelperInfo all_helpers[] = {
 #include "exec/helper-tcg.h"
 };
 static struct qht helper_table;
+static struct qht runtime_helper_table;
 static bool helper_table_inited;
 
 static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
@@ -913,6 +914,22 @@ static void tcg_helper_insert(const TCGHelperInfo *info)
     g_assert(inserted);
 }
 
+static void
+rm_from_helper_table_and_free(void *p, uint32_t h, void *userp)
+{
+    bool success;
+
+    success = qht_remove(&helper_table, p, h);
+    g_assert(success);
+    g_free(p);
+}
+
+void tcg_reset_runtime_helpers(void)
+{
+    qht_iter(&runtime_helper_table, rm_from_helper_table_and_free, NULL);
+    qht_reset(&runtime_helper_table);
+}
+
 void tcg_context_init(TCGContext *s)
 {
     int op, total_args, n, i;
@@ -948,6 +965,7 @@ void tcg_context_init(TCGContext *s)
     /* Register helpers.  */
     qht_init(&helper_table, tcg_helper_cmp, ARRAY_SIZE(all_helpers),
              QHT_MODE_AUTO_RESIZE);
+    qht_init(&runtime_helper_table, tcg_helper_cmp, 1, QHT_MODE_AUTO_RESIZE);
 
     for (i = 0; i < ARRAY_SIZE(all_helpers); ++i) {
         tcg_helper_insert(&all_helpers[i]);
@@ -1847,6 +1865,9 @@ void tcg_gen_runtime_helper(const TCGHelperInfo *orig, TCGTemp *ret, int nargs,
         if (unlikely(existing)) {
             g_free(info);
             info = existing;
+        } else {
+            qht_insert(&runtime_helper_table, info, hash, &existing);
+            g_assert(existing == NULL);
         }
     }
     do_tcg_gen_callN(info, ret, nargs, args);
-- 
2.17.1
