Received: from eggs.gnu.org ([2001:4830:134:3::10]:38619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e1z4O-00075k-I3
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e1z4N-0002KE-FF
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e1z4N-0002Jr-6X
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 552AF4ACA5
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 18:15:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 10 Oct 2017 20:15:36 +0200
Message-Id: <20171010181542.24168-5-quintela@redhat.com>
In-Reply-To: <20171010181542.24168-1-quintela@redhat.com>
References: <20171010181542.24168-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 04/10] migration: Move xbzrle cache resize
 error handling to xbzrle_cache_resize
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 18 +-----------------
 migration/ram.c       | 22 ++++++++++++++++++++--
 migration/ram.h       |  2 +-
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index fb62a639d8..3feffb5e26 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1373,24 +1373,8 @@ void qmp_migrate_set_cache_size(int64_t value, Error **errp)
     MigrationState *s = migrate_get_current();
     int64_t new_size;
 
-    /* Check for truncation */
-    if (value != (size_t)value) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "exceeding address space");
-        return;
-    }
-
-    /* Cache should not be larger than guest ram size */
-    if (value > ram_bytes_total()) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "exceeds guest ram size ");
-        return;
-    }
-
-    new_size = xbzrle_cache_resize(value);
+    new_size = xbzrle_cache_resize(value, errp);
     if (new_size < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "is smaller than page size");
         return;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index b83f8977c5..7c3acad029 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -42,6 +42,7 @@
 #include "postcopy-ram.h"
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
+#include "qapi/qmp/qerror.h"
 #include "trace.h"
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
@@ -113,13 +114,30 @@ static void XBZRLE_cache_unlock(void)
  * Returns the new_size or negative in case of error.
  *
  * @new_size: new cache size
+ * @errp: set *errp if the check failed, with reason
  */
-int64_t xbzrle_cache_resize(int64_t new_size)
+int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
 {
     PageCache *new_cache;
     int64_t ret;
 
+    /* Check for truncation */
+    if (new_size != (size_t)new_size) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
+                   "exceeding address space");
+        return -1;
+    }
+
+    /* Cache should not be larger than guest ram size */
+    if (new_size > ram_bytes_total()) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
+                   "exceeds guest ram size");
+        return -1;
+    }
+
     if (new_size < TARGET_PAGE_SIZE) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
+                   "is smaller than one target page size");
         return -1;
     }
 
@@ -132,7 +150,7 @@ int64_t xbzrle_cache_resize(int64_t new_size)
         new_cache = cache_init(new_size / TARGET_PAGE_SIZE,
                                         TARGET_PAGE_SIZE);
         if (!new_cache) {
-            error_report("Error creating cache");
+            error_setg(errp, "Error creating cache");
             ret = -1;
             goto out;
         }
diff --git a/migration/ram.h b/migration/ram.h
index 4a72d66503..511b3dc582 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -35,7 +35,7 @@
 extern MigrationStats ram_counters;
 extern XBZRLECacheStats xbzrle_counters;
 
-int64_t xbzrle_cache_resize(int64_t new_size);
+int64_t xbzrle_cache_resize(int64_t new_size, Error **errp);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
 
-- 
2.13.6
