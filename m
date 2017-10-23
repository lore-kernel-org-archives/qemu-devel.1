Received: from eggs.gnu.org ([2001:4830:134:3::10]:35912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHW-0005tS-CH
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHS-0000Qx-8l
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fHS-0000Q4-0J
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AC9A80C26
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:54 +0200
Message-Id: <20171023160800.20540-16-quintela@redhat.com>
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 15/21] migration: clean up xbzrle cache
 init/destroy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

Let's further simplify ram_init_all() and ram_save_cleanup() by abstract
all the XBZRLE related codes into their own functions.

When allocating xbzrle cache, we are always very careful on -ENOMEM;
which makes sense.  Replacing the last g_malloc0() with g_try_malloc0(),
then refactor the logic a bit.

This patch should be fixing some memory leaks when some memory
allocation failed for XBZRLE in the past.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 131 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 81 insertions(+), 50 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d91e8787ae..60f9cfe8be 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1585,23 +1585,8 @@ static void ram_state_cleanup(RAMState **rsp)
     *rsp = NULL;
 }
 
-static void ram_save_cleanup(void *opaque)
+static void xbzrle_cleanup(void)
 {
-    RAMState **rsp = opaque;
-    RAMBlock *block;
-
-    /* caller have hold iothread lock or is in a bh, so there is
-     * no writing race against this migration_bitmap
-     */
-    memory_global_dirty_log_stop();
-
-    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
-        g_free(block->bmap);
-        block->bmap = NULL;
-        g_free(block->unsentmap);
-        block->unsentmap = NULL;
-    }
-
     XBZRLE_cache_lock();
     if (XBZRLE.cache) {
         cache_fini(XBZRLE.cache);
@@ -1614,6 +1599,26 @@ static void ram_save_cleanup(void *opaque)
         XBZRLE.zero_target_page = NULL;
     }
     XBZRLE_cache_unlock();
+}
+
+static void ram_save_cleanup(void *opaque)
+{
+    RAMState **rsp = opaque;
+    RAMBlock *block;
+
+    /* caller have hold iothread lock or is in a bh, so there is
+     * no writing race against this migration_bitmap
+     */
+    memory_global_dirty_log_stop();
+
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        g_free(block->bmap);
+        block->bmap = NULL;
+        g_free(block->unsentmap);
+        block->unsentmap = NULL;
+    }
+
+    xbzrle_cleanup();
     compress_threads_save_cleanup();
     ram_state_cleanup(rsp);
 }
@@ -2024,6 +2029,63 @@ err:
     return ret;
 }
 
+/*
+ * For every allocation, we will try not to crash the VM if the
+ * allocation failed.
+ */
+static int xbzrle_init(void)
+{
+    Error *local_err = NULL;
+
+    if (!migrate_use_xbzrle()) {
+        return 0;
+    }
+
+    XBZRLE_cache_lock();
+
+    XBZRLE.zero_target_page = g_try_malloc0(TARGET_PAGE_SIZE);
+    if (!XBZRLE.zero_target_page) {
+        error_report("%s: Error allocating zero page", __func__);
+        goto err_out;
+    }
+
+    XBZRLE.cache = cache_init(migrate_xbzrle_cache_size(),
+                              TARGET_PAGE_SIZE, &local_err);
+    if (!XBZRLE.cache) {
+        error_report_err(local_err);
+        goto free_zero_page;
+    }
+
+    XBZRLE.encoded_buf = g_try_malloc0(TARGET_PAGE_SIZE);
+    if (!XBZRLE.encoded_buf) {
+        error_report("%s: Error allocating encoded_buf", __func__);
+        goto free_cache;
+    }
+
+    XBZRLE.current_buf = g_try_malloc(TARGET_PAGE_SIZE);
+    if (!XBZRLE.current_buf) {
+        error_report("%s: Error allocating current_buf", __func__);
+        goto free_encoded_buf;
+    }
+
+    /* We are all good */
+    XBZRLE_cache_unlock();
+    return 0;
+
+free_encoded_buf:
+    g_free(XBZRLE.encoded_buf);
+    XBZRLE.encoded_buf = NULL;
+free_cache:
+    cache_fini(XBZRLE.cache);
+    XBZRLE.cache = NULL;
+free_zero_page:
+    g_free(XBZRLE.zero_target_page);
+    XBZRLE.zero_target_page = NULL;
+err_out:
+    XBZRLE_cache_unlock();
+    return -ENOMEM;
+}
+
 static int ram_state_init(RAMState **rsp)
 {
     *rsp = g_try_new0(RAMState, 1);
@@ -2050,44 +2112,13 @@ static int ram_state_init(RAMState **rsp)
 
 static int ram_init_all(RAMState **rsp)
 {
-    Error *local_err = NULL;
-
     if (ram_state_init(rsp)) {
         return -1;
     }
 
-    if (migrate_use_xbzrle()) {
-        XBZRLE_cache_lock();
-        XBZRLE.zero_target_page = g_malloc0(TARGET_PAGE_SIZE);
-        XBZRLE.cache = cache_init(migrate_xbzrle_cache_size(),
-                                  TARGET_PAGE_SIZE, &local_err);
-        if (!XBZRLE.cache) {
-            XBZRLE_cache_unlock();
-            error_report_err(local_err);
-            g_free(*rsp);
-            *rsp = NULL;
-            return -1;
-        }
-        XBZRLE_cache_unlock();
-
-        /* We prefer not to abort if there is no memory */
-        XBZRLE.encoded_buf = g_try_malloc0(TARGET_PAGE_SIZE);
-        if (!XBZRLE.encoded_buf) {
-            error_report("Error allocating encoded_buf");
-            g_free(*rsp);
-            *rsp = NULL;
-            return -1;
-        }
-
-        XBZRLE.current_buf = g_try_malloc(TARGET_PAGE_SIZE);
-        if (!XBZRLE.current_buf) {
-            error_report("Error allocating current_buf");
-            g_free(XBZRLE.encoded_buf);
-            XBZRLE.encoded_buf = NULL;
-            g_free(*rsp);
-            *rsp = NULL;
-            return -1;
-        }
+    if (xbzrle_init()) {
+        ram_state_cleanup(rsp);
+        return -1;
     }
 
     /* For memory_global_dirty_log_start below.  */
-- 
2.13.6
