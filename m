Received: from eggs.gnu.org ([2001:4830:134:3::10]:51757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e54NN-0000mk-Gn
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e54NM-0003FB-Ec
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e54NM-0003EJ-6W
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48FAF820E6
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 06:32:15 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 19 Oct 2017 14:31:59 +0800
Message-Id: <20171019063200.19048-4-peterx@redhat.com>
In-Reply-To: <20171019063200.19048-1-peterx@redhat.com>
References: <20171019063200.19048-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] migration: clean up xbzrle cache
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
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Let's further simplify ram_init_all() and ram_save_cleanup() by abstract
all the XBZRLE related codes into their own functions.

When allocating xbzrle cache, we are always very careful on -ENOMEM;
which makes sense.  Replacing the last g_malloc0() with g_try_malloc0(),
then refactor the logic a bit.

This patch should be fixing some memory leaks when some memory
allocation failed for XBZRLE in the past.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 121 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 45 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 72c48e76e9..3df7715d63 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1575,6 +1575,22 @@ static void ram_state_cleanup(RAMState **rsp)
     *rsp = NULL;
 }
 
+static void xbzrle_cleanup(void)
+{
+    XBZRLE_cache_lock();
+    if (XBZRLE.cache) {
+        cache_fini(XBZRLE.cache);
+        g_free(XBZRLE.encoded_buf);
+        g_free(XBZRLE.current_buf);
+        g_free(XBZRLE.zero_target_page);
+        XBZRLE.cache = NULL;
+        XBZRLE.encoded_buf = NULL;
+        XBZRLE.current_buf = NULL;
+        XBZRLE.zero_target_page = NULL;
+    }
+    XBZRLE_cache_unlock();
+}
+
 static void ram_save_cleanup(void *opaque)
 {
     RAMState **rsp = opaque;
@@ -1592,18 +1608,7 @@ static void ram_save_cleanup(void *opaque)
         block->unsentmap = NULL;
     }
 
-    XBZRLE_cache_lock();
-    if (XBZRLE.cache) {
-        cache_fini(XBZRLE.cache);
-        g_free(XBZRLE.encoded_buf);
-        g_free(XBZRLE.current_buf);
-        g_free(XBZRLE.zero_target_page);
-        XBZRLE.cache = NULL;
-        XBZRLE.encoded_buf = NULL;
-        XBZRLE.current_buf = NULL;
-        XBZRLE.zero_target_page = NULL;
-    }
-    XBZRLE_cache_unlock();
+    xbzrle_cleanup();
     compress_threads_save_cleanup();
     ram_state_cleanup(rsp);
 }
@@ -2014,6 +2019,62 @@ err:
     return ret;
 }
 
+/*
+ * For every allocation, we will try not to crash the VM if the
+ * allocation failed.
+ */
+static int xbzrle_init(void)
+{
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
+    XBZRLE.cache = cache_init(migrate_xbzrle_cache_size() /
+                              TARGET_PAGE_SIZE,
+                              TARGET_PAGE_SIZE);
+    if (!XBZRLE.cache) {
+        error_report("%s: Error creating cache", __func__);
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
@@ -2044,39 +2105,9 @@ static int ram_init_all(RAMState **rsp)
         return -1;
     }
 
-    if (migrate_use_xbzrle()) {
-        XBZRLE_cache_lock();
-        XBZRLE.zero_target_page = g_malloc0(TARGET_PAGE_SIZE);
-        XBZRLE.cache = cache_init(migrate_xbzrle_cache_size() /
-                                  TARGET_PAGE_SIZE,
-                                  TARGET_PAGE_SIZE);
-        if (!XBZRLE.cache) {
-            XBZRLE_cache_unlock();
-            error_report("Error creating cache");
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
2.13.5
