Received: from eggs.gnu.org ([2001:4830:134:3::10]:60566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqR-0002Ph-Bi
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqQ-0004YJ-Ek
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:27 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:44482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iqQ-0004Xw-90
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:26 -0400
Received: by mail-pf0-x22c.google.com with SMTP id x7so5175683pfa.1
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:54 -0700
Message-Id: <20171010005600.28735-18-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/23] tcg: take .helpers out of TCGContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Groundwork for supporting multiple TCG contexts.

The hash table becomes read-only after it is filled in,
so we can save space by keeping just a global pointer to it.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h |  2 --
 tcg/tcg.c | 10 +++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 25662c36d4..b2d42e3136 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -656,8 +656,6 @@ struct TCGContext {
 
     tcg_insn_unit *code_ptr;
 
-    GHashTable *helpers;
-
 #ifdef CONFIG_PROFILER
     /* profiling info */
     int64_t tb_count1;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a874bdd41f..ee60798438 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -318,6 +318,7 @@ typedef struct TCGHelperInfo {
 static const TCGHelperInfo all_helpers[] = {
 #include "exec/helper-tcg.h"
 };
+static GHashTable *helper_table;
 
 static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
 static void process_op_defs(TCGContext *s);
@@ -328,7 +329,6 @@ void tcg_context_init(TCGContext *s)
     TCGOpDef *def;
     TCGArgConstraint *args_ct;
     int *sorted_args;
-    GHashTable *helper_table;
 
     memset(s, 0, sizeof(*s));
     s->nb_globals = 0;
@@ -356,7 +356,7 @@ void tcg_context_init(TCGContext *s)
 
     /* Register helpers.  */
     /* Use g_direct_hash/equal for direct pointer comparisons on func.  */
-    s->helpers = helper_table = g_hash_table_new(NULL, NULL);
+    helper_table = g_hash_table_new(NULL, NULL);
 
     for (i = 0; i < ARRAY_SIZE(all_helpers); ++i) {
         g_hash_table_insert(helper_table, (gpointer)all_helpers[i].func,
@@ -982,7 +982,7 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
     unsigned sizemask, flags;
     TCGHelperInfo *info;
 
-    info = g_hash_table_lookup(s->helpers, (gpointer)func);
+    info = g_hash_table_lookup(helper_table, (gpointer)func);
     flags = info->flags;
     sizemask = info->sizemask;
 
@@ -1211,8 +1211,8 @@ static char *tcg_get_arg_str_idx(TCGContext *s, char *buf,
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
2.13.6
