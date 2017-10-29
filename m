Received: from eggs.gnu.org ([2001:4830:134:3::10]:45027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLY-00039N-83
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLX-0001vE-4k
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e8nLW-0001tM-TF
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01D91356EB
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 13:09:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Sun, 29 Oct 2017 14:09:28 +0100
Message-Id: <20171029130934.4555-4-quintela@redhat.com>
In-Reply-To: <20171029130934.4555-1-quintela@redhat.com>
References: <20171029130934.4555-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] migration: No need to return the size of
 the cache
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

After the previous commits, we make sure that the value passed is
right, or we just drop an error.  So now we return if there is one
error or we have setup correctly the value passed.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

Improve error messasge
Return 0 always for success
---
 migration/migration.c |  6 ++----
 migration/ram.c       | 10 ++++------
 migration/ram.h       |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 62761d5705..6bbd4715d3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1406,14 +1406,12 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
 void qmp_migrate_set_cache_size(int64_t value, Error **errp)
 {
     MigrationState *s = migrate_get_current();
-    int64_t new_size;
 
-    new_size = xbzrle_cache_resize(value, errp);
-    if (new_size < 0) {
+    if (xbzrle_cache_resize(value, errp) < 0) {
         return;
     }
 
-    s->xbzrle_cache_size = new_size;
+    s->xbzrle_cache_size = value;
 }
 
 int64_t qmp_query_migrate_cache_size(Error **errp)
diff --git a/migration/ram.c b/migration/ram.c
index 42f3b7cb28..997340c7c2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -112,15 +112,15 @@ static void XBZRLE_cache_unlock(void)
  * migration may be using the cache and might finish during this call,
  * hence changes to the cache are protected by XBZRLE.lock().
  *
- * Returns the new_size or negative in case of error.
+ * Returns 0 for success or -1 for error
  *
  * @new_size: new cache size
  * @errp: set *errp if the check failed, with reason
  */
-int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
+int xbzrle_cache_resize(int64_t new_size, Error **errp)
 {
     PageCache *new_cache;
-    int64_t ret;
+    int64_t ret = 0;
 
     /* Check for truncation */
     if (new_size != (size_t)new_size) {
@@ -138,7 +138,7 @@ int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
 
     if (new_size == migrate_xbzrle_cache_size()) {
         /* nothing to do */
-        return new_size;
+        return 0;
     }
 
     XBZRLE_cache_lock();
@@ -153,8 +153,6 @@ int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
         cache_fini(XBZRLE.cache);
         XBZRLE.cache = new_cache;
     }
-
-    ret = new_size;
 out:
     XBZRLE_cache_unlock();
     return ret;
diff --git a/migration/ram.h b/migration/ram.h
index f9f7eef894..64d81e9f1d 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -35,7 +35,7 @@
 extern MigrationStats ram_counters;
 extern XBZRLECacheStats xbzrle_counters;
 
-int64_t xbzrle_cache_resize(int64_t new_size, Error **errp);
+int xbzrle_cache_resize(int64_t new_size, Error **errp);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
 
-- 
2.13.6
