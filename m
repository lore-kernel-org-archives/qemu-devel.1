Received: from eggs.gnu.org ([2001:4830:134:3::10]:40362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKp-0006hw-BO
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjJl-0008PR-C8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjJl-0008Oz-4B
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:15 -0400
Message-Id: <20181025172057.20414-7-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 06/48] tcg: use QHT for helper_table
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

This will allow us to add TCG helpers at run-time.

While at it, rename tcg_find_helper to tcg_helper_find for consistency
with the added tcg_helper_foo functions.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.c | 59 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e85133ef05..65da3c5dbf 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -33,6 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "qemu/host-utils.h"
+#include "qemu/xxhash.h"
 #include "qemu/timer.h"
 
 /* Note: the long term plan is to reduce the dependencies on the QEMU
@@ -879,13 +880,46 @@ typedef struct TCGHelperInfo {
 static const TCGHelperInfo all_helpers[] = {
 #include "exec/helper-tcg.h"
 };
-static GHashTable *helper_table;
+static struct qht helper_table;
+static bool helper_table_inited;
 
 static int indirect_reg_alloc_order[ARRAY_SIZE(tcg_target_reg_alloc_order)];
 static void process_op_defs(TCGContext *s);
 static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
                                             TCGReg reg, const char *name);
 
+static inline uint32_t tcg_helper_func_hash(const void *func)
+{
+    return qemu_xxhash2((uint64_t)func);
+}
+
+static bool tcg_helper_cmp(const void *ap, const void *bp)
+{
+    const TCGHelperInfo *a = ap;
+    const TCGHelperInfo *b = bp;
+
+    return a->func == b->func &&
+        a->flags == b->flags &&
+        a->sizemask == b->sizemask &&
+        !strcmp(a->name, b->name);
+}
+
+static bool tcg_helper_lookup_cmp(const void *obj, const void *func)
+{
+    const TCGHelperInfo *info = obj;
+
+    return info->func == func;
+}
+
+static void tcg_helper_insert(const TCGHelperInfo *info)
+{
+    uint32_t hash = tcg_helper_func_hash(info->func);
+    bool inserted;
+
+    inserted = qht_insert(&helper_table, (void *)info, hash, NULL);
+    g_assert(inserted);
+}
+
 void tcg_context_init(TCGContext *s)
 {
     int op, total_args, n, i;
@@ -919,13 +953,13 @@ void tcg_context_init(TCGContext *s)
     }
 
     /* Register helpers.  */
-    /* Use g_direct_hash/equal for direct pointer comparisons on func.  */
-    helper_table = g_hash_table_new(NULL, NULL);
+    qht_init(&helper_table, tcg_helper_cmp, ARRAY_SIZE(all_helpers),
+             QHT_MODE_AUTO_RESIZE);
 
     for (i = 0; i < ARRAY_SIZE(all_helpers); ++i) {
-        g_hash_table_insert(helper_table, (gpointer)all_helpers[i].func,
-                            (gpointer)&all_helpers[i]);
+        tcg_helper_insert(&all_helpers[i]);
     }
+    helper_table_inited = true;
 
     tcg_target_init(s);
     process_op_defs(s);
@@ -1620,9 +1654,10 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
     int i, real_args, nb_rets, pi;
     unsigned sizemask, flags;
     TCGHelperInfo *info;
+    uint32_t hash = tcg_helper_func_hash(func);
     TCGOp *op;
 
-    info = g_hash_table_lookup(helper_table, (gpointer)func);
+    info = qht_lookup_custom(&helper_table, func, hash, tcg_helper_lookup_cmp);
     flags = info->flags;
     sizemask = info->sizemask;
 
@@ -1825,11 +1860,15 @@ static char *tcg_get_arg_str(TCGContext *s, char *buf,
 }
 
 /* Find helper name.  */
-static inline const char *tcg_find_helper(TCGContext *s, uintptr_t val)
+static inline const char *tcg_helper_find(TCGContext *s, uintptr_t val)
 {
     const char *ret = NULL;
-    if (helper_table) {
-        TCGHelperInfo *info = g_hash_table_lookup(helper_table, (gpointer)val);
+    if (helper_table_inited) {
+        uint32_t hash = tcg_helper_func_hash((void *)val);
+        TCGHelperInfo *info;
+
+        info = qht_lookup_custom(&helper_table, (void *)val, hash,
+                                 tcg_helper_lookup_cmp);
         if (info) {
             ret = info->name;
         }
@@ -1919,7 +1958,7 @@ void tcg_dump_ops(TCGContext *s)
 
             /* function name, flags, out args */
             col += qemu_log(" %s %s,$0x%" TCG_PRIlx ",$%d", def->name,
-                            tcg_find_helper(s, op->args[nb_oargs + nb_iargs]),
+                            tcg_helper_find(s, op->args[nb_oargs + nb_iargs]),
                             op->args[nb_oargs + nb_iargs + 1], nb_oargs);
             for (i = 0; i < nb_oargs; i++) {
                 col += qemu_log(",%s", tcg_get_arg_str(s, buf, sizeof(buf),
-- 
2.17.1
