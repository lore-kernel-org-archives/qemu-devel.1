Received: from eggs.gnu.org ([2001:4830:134:3::10]:38646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e1z4Q-000774-6O
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e1z4P-0002LB-5h
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e1z4O-0002Kd-TM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B899C04AC71
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 18:15:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 10 Oct 2017 20:15:37 +0200
Message-Id: <20171010181542.24168-6-quintela@redhat.com>
In-Reply-To: <20171010181542.24168-1-quintela@redhat.com>
References: <20171010181542.24168-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 05/10] migration: Make cache_init() take an
 error parameter
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

Once there, take a total size instead of the size of the pages.  We
move the check that the new_size is bigger than one page from
xbzrle_cache_resize().

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/page_cache.c | 17 +++++++++++------
 migration/page_cache.h |  7 +++----
 migration/ram.c        | 18 +++++-------------
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/migration/page_cache.c b/migration/page_cache.c
index 6b2dd77cf0..9a9d13d6a2 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -14,6 +14,8 @@
 
 #include "qemu/osdep.h"
 
+#include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
 #include "migration/page_cache.h"
@@ -44,21 +46,23 @@ struct PageCache {
     size_t num_items;
 };
 
-PageCache *cache_init(size_t num_pages, size_t page_size)
+PageCache *cache_init(int64_t new_size, size_t page_size, Error **errp)
 {
     int64_t i;
-
+    size_t num_pages = new_size / page_size;
     PageCache *cache;
 
-    if (num_pages <= 0) {
-        DPRINTF("invalid number of pages\n");
+    if (new_size < page_size) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
+                   "is smaller than one target page size");
         return NULL;
     }
 
     /* We prefer not to abort if there is no memory */
     cache = g_try_malloc(sizeof(*cache));
     if (!cache) {
-        DPRINTF("Failed to allocate cache\n");
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
+                   "Failed to allocate cache");
         return NULL;
     }
     /* round down to the nearest power of 2 */
@@ -76,7 +80,8 @@ PageCache *cache_init(size_t num_pages, size_t page_size)
     cache->page_cache = g_try_malloc((cache->max_num_items) *
                                      sizeof(*cache->page_cache));
     if (!cache->page_cache) {
-        DPRINTF("Failed to allocate cache->page_cache\n");
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
+                   "Failed to allocate page cache");
         g_free(cache);
         return NULL;
     }
diff --git a/migration/page_cache.h b/migration/page_cache.h
index 931868b857..4596496416 100644
--- a/migration/page_cache.h
+++ b/migration/page_cache.h
@@ -24,12 +24,11 @@ typedef struct PageCache PageCache;
  *
  * Returns new allocated cache or NULL on error
  *
- * @cache pointer to the PageCache struct
- * @num_pages: cache maximal number of cached pages
+ * @cache_size: cache size in byets
  * @page_size: cache page size
+ * @errp: set *errp if the check failed, with reason
  */
-PageCache *cache_init(size_t num_pages, size_t page_size);
-
+PageCache *cache_init(int64_t cache_size, size_t page_size, Error **errp);
 /**
  * cache_fini: free all cache resources
  * @cache pointer to the PageCache struct
diff --git a/migration/ram.c b/migration/ram.c
index 7c3acad029..47501460c8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -135,22 +135,14 @@ int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
         return -1;
     }
 
-    if (new_size < TARGET_PAGE_SIZE) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "is smaller than one target page size");
-        return -1;
-    }
-
     XBZRLE_cache_lock();
 
     if (XBZRLE.cache != NULL) {
         if (pow2floor(new_size) == migrate_xbzrle_cache_size()) {
             goto out_new_size;
         }
-        new_cache = cache_init(new_size / TARGET_PAGE_SIZE,
-                                        TARGET_PAGE_SIZE);
+        new_cache = cache_init(new_size, TARGET_PAGE_SIZE, errp);
         if (!new_cache) {
-            error_setg(errp, "Error creating cache");
             ret = -1;
             goto out;
         }
@@ -2028,6 +2020,7 @@ err:
 static int ram_state_init(RAMState **rsp)
 {
     *rsp = g_new0(RAMState, 1);
+    Error *local_err = NULL;
 
     qemu_mutex_init(&(*rsp)->bitmap_mutex);
     qemu_mutex_init(&(*rsp)->src_page_req_mutex);
@@ -2036,12 +2029,11 @@ static int ram_state_init(RAMState **rsp)
     if (migrate_use_xbzrle()) {
         XBZRLE_cache_lock();
         XBZRLE.zero_target_page = g_malloc0(TARGET_PAGE_SIZE);
-        XBZRLE.cache = cache_init(migrate_xbzrle_cache_size() /
-                                  TARGET_PAGE_SIZE,
-                                  TARGET_PAGE_SIZE);
+        XBZRLE.cache = cache_init(migrate_xbzrle_cache_size(),
+                                  TARGET_PAGE_SIZE, &local_err);
         if (!XBZRLE.cache) {
             XBZRLE_cache_unlock();
-            error_report("Error creating cache");
+            error_report_err(local_err);
             g_free(*rsp);
             *rsp = NULL;
             return -1;
-- 
2.13.6
