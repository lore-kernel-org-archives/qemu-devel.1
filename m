Received: from eggs.gnu.org ([2001:4830:134:3::10]:49293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJH-0007cD-W6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ1-00045T-U7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:12 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:18 +0200
Message-Id: <1502117160-24655-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 14/56] migration: Fix
 migrate-set-cache-size error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

qmp_migrate_set_cache_size() calls xbzrle_cache_resize() to do the
actual work, which in turn calls cache_init() to resize the cache.  If
cache_init() fails, xbzrle_cache_resize() reports that error with
error_report() and fails.  qmp_migrate_set_cache_size() detects the
failure and reports "Parameter 'cache size' expects is smaller than
page size" with error_setg().  The first error is accurate, the second
is bogus.  With HMP, we get both.  With QMP, we get the accurate one
on stderr, and the bogus one via QMP.

Fix by making xbzrle_cache_resize() use error_setg() instead of
error_report().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c | 4 +---
 migration/ram.c       | 9 +++++++--
 migration/ram.h       | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c3fe0ed..3ce68f3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1298,10 +1298,8 @@ void qmp_migrate_set_cache_size(int64_t value, Error **errp)
         return;
     }
 
-    new_size = xbzrle_cache_resize(value);
+    new_size = xbzrle_cache_resize(value, errp);
     if (new_size < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
-                   "is smaller than page size");
         return;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index e18b3e2..e9ab858 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -29,6 +29,7 @@
 #include "cpu.h"
 #include <zlib.h>
 #include "qapi-event.h"
+#include "qapi/qmp/qerror.h"
 #include "qemu/cutils.h"
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
@@ -110,15 +111,19 @@ static void XBZRLE_cache_unlock(void)
  * hence changes to the cache are protected by XBZRLE.lock().
  *
  * Returns the new_size or negative in case of error.
+ * Returns the the new cache size on success, -1 on error.
  *
  * @new_size: new cache size
+ * @errp: return location for an Error
  */
-int64_t xbzrle_cache_resize(int64_t new_size)
+int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
 {
     PageCache *new_cache;
     int64_t ret;
 
     if (new_size < TARGET_PAGE_SIZE) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
+                   "is smaller than page size");
         return -1;
     }
 
@@ -131,7 +136,7 @@ int64_t xbzrle_cache_resize(int64_t new_size)
         new_cache = cache_init(new_size / TARGET_PAGE_SIZE,
                                         TARGET_PAGE_SIZE);
         if (!new_cache) {
-            error_report("Error creating cache");
+            error_setg(errp, "Error creating cache");
             ret = -1;
             goto out;
         }
diff --git a/migration/ram.h b/migration/ram.h
index c081fde..97842bf 100644
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
2.7.5
