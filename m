Received: from eggs.gnu.org ([2001:4830:134:3::10]:46310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmd-0001BF-Oc
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmY-0008P5-JZ
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmY-0008OS-Ge
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:16 -0400
Message-Id: <1500235468-15341-34-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 33/45] tcg: take .helpers out of TCGContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Groundwork for supporting multiple TCG contexts.

The hash table becomes read-only after it is filled in,
so we can save space by keeping just a global pointer to it.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h |  2 --
 tcg/tcg.c | 10 +++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 1090285..7cbe802 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -664,8 +664,6 @@ struct TCGContext {
 
     tcg_insn_unit *code_ptr;
 
-    GHashTable *helpers;
-
 #ifdef CONFIG_PROFILER
     /* profiling info */
     int64_t tb_count1;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 28c1b94..c0c2d6c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -319,6 +319,7 @@ typedef struct TCGHelperInfo {
 static const TCGHelperInfo all_helpers[] = {
 #include "exec/helper-tcg.h"
 };
+static GHashTable *helper_table;
 
 static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
 static void process_op_defs(TCGContext *s);
@@ -329,7 +330,6 @@ void tcg_context_init(TCGContext *s)
     TCGOpDef *def;
     TCGArgConstraint *args_ct;
     int *sorted_args;
-    GHashTable *helper_table;
 
     memset(s, 0, sizeof(*s));
     s->nb_globals = 0;
@@ -357,7 +357,7 @@ void tcg_context_init(TCGContext *s)
 
     /* Register helpers.  */
     /* Use g_direct_hash/equal for direct pointer comparisons on func.  */
-    s->helpers = helper_table = g_hash_table_new(NULL, NULL);
+    helper_table = g_hash_table_new(NULL, NULL);
 
     for (i = 0; i < ARRAY_SIZE(all_helpers); ++i) {
         g_hash_table_insert(helper_table, (gpointer)all_helpers[i].func,
@@ -761,7 +761,7 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
     unsigned sizemask, flags;
     TCGHelperInfo *info;
 
-    info = g_hash_table_lookup(s->helpers, (gpointer)func);
+    info = g_hash_table_lookup(helper_table, (gpointer)func);
     flags = info->flags;
     sizemask = info->sizemask;
 
@@ -990,8 +990,8 @@ static char *tcg_get_arg_str_idx(TCGContext *s, char *buf,
 static inline const char *tcg_find_helper(TCGContext *s, uintptr_t val)
 {
     const char *ret = NULL;
-    if (s->helpers) {
-        TCGHelperInfo *info = g_hash_table_lookup(s->helpers, (gpointer)val);
+    if (helper_table) {
+        TCGHelperInfo *info = g_hash_table_lookup(helper_table, (gpointer)val);
         if (info) {
             ret = info->name;
         }
-- 
2.7.4
