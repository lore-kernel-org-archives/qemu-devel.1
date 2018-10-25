Received: from eggs.gnu.org ([2001:4830:134:3::10]:40449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKp-0006ix-31
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjJl-0008Pf-Ez
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59947)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjJl-0008P8-8Z
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:17 -0400
Message-Id: <20181025172057.20414-9-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 08/48] tcg: export tcg_gen_runtime_helper
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

This takes the TCGHelperInfo directly, which will allow us to generate
helpers at run-time.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h |  2 ++
 tcg/tcg.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 9f9643b470..3fa434d891 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1077,6 +1077,8 @@ do {\
 bool tcg_op_supported(TCGOpcode op);
 
 void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);
+void tcg_gen_runtime_helper(const TCGHelperInfo *orig, TCGTemp *ret, int nargs,
+                            TCGTemp **args);
 
 TCGOp *tcg_emit_op(TCGOpcode opc);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 08b6926894..87e02da740 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1642,15 +1642,13 @@ bool tcg_op_supported(TCGOpcode op)
 /* Note: we convert the 64 bit args to 32 bit and do some alignment
    and endian swap. Maybe it would be better to do the alignment
    and endian swap in tcg_reg_alloc_call(). */
-void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
+static void do_tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, int nargs,
+                             TCGTemp **args)
 {
     int i, real_args, nb_rets, pi;
     unsigned sizemask, flags;
-    TCGHelperInfo *info;
-    uint32_t hash = tcg_helper_func_hash(func);
     TCGOp *op;
 
-    info = qht_lookup_custom(&helper_table, func, hash, tcg_helper_lookup_cmp);
     flags = info->flags;
     sizemask = info->sizemask;
 
@@ -1774,7 +1772,7 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
         op->args[pi++] = temp_arg(args[i]);
         real_args++;
     }
-    op->args[pi++] = (uintptr_t)func;
+    op->args[pi++] = (uintptr_t)info->func;
     op->args[pi++] = flags;
     TCGOP_CALLI(op) = real_args;
 
@@ -1812,6 +1810,48 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
 #endif /* TCG_TARGET_EXTEND_ARGS */
 }
 
+void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
+{
+    TCGHelperInfo *info;
+    uint32_t hash = tcg_helper_func_hash(func);
+
+    /*
+     * Here we can get away with tcg_helper_lookup_cmp, which only looks
+     * at the function pointer, since we have the compile-time guarantee
+     * that @func can only be in one TCGHelperInfo.
+     */
+    info = qht_lookup_custom(&helper_table, func, hash, tcg_helper_lookup_cmp);
+    do_tcg_gen_callN(info, ret, nargs, args);
+}
+
+void tcg_gen_runtime_helper(const TCGHelperInfo *orig, TCGTemp *ret, int nargs,
+                            TCGTemp **args)
+{
+    TCGHelperInfo *info;
+    uint32_t hash = tcg_helper_func_hash(orig->func);
+
+    /*
+     * Use the full TCGHelperInfo lookup, since there is no guarantee that func
+     * will be unique to each TCGHelperInfo. For instance, we could have the
+     * same helper function registered in several TCGHelperInfo's, each of them
+     * with different flags.
+     */
+    info = qht_lookup(&helper_table, orig, hash);
+    if (info == NULL) {
+        void *existing = NULL;
+
+        /* @orig might be in the stack, so we need to allocate a new struct */
+        info = g_new(TCGHelperInfo, 1);
+        memcpy(info, orig, sizeof(TCGHelperInfo));
+        qht_insert(&helper_table, info, hash, &existing);
+        if (unlikely(existing)) {
+            g_free(info);
+            info = existing;
+        }
+    }
+    do_tcg_gen_callN(info, ret, nargs, args);
+}
+
 static void tcg_reg_alloc_start(TCGContext *s)
 {
     int i, n;
-- 
2.17.1
