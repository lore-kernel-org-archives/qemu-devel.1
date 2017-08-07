Received: from eggs.gnu.org ([2001:4830:134:3::10]:48992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ5-0007Np-1X
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIp-0003uN-7A
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:59 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:19 +0200
Message-Id: <1502117160-24655-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 15/56] migration: Make XBZRLE cache size
 unsigned in QAPI/QMP
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

Sizes should use QAPI type 'size' (uint64_t).  migrate-set-cache-size
parameter @value is 'int' (int64_t).  qmp_migrate_set_cache_size()
ensures it fits into size_t.  page_cache.c implicitly converts the
signed size to unsigned types (it can't quite decide whether to use
uint64_t or size_t for cache offsets, but that's not something I can
tackle now).

XBZRLECacheStats member @cache-size and query-migrate-cache-size's
result are also 'int'.

Change the migrate-set-cache-size parameter and the XBZRLECacheStats
members to 'size', fix up hmp_migrate_set_cache_size(), and tweak a
few variable types to reduce implicit conversions.

migrate-set-cache-size now accepts size values between 2^63 and
2^64-1.  It accepts negative values as before, because that's how the
QObject input visitor works for backward compatibility.

So does HMP's migrate_set_cache_size.

query-migrate and query-migrate-cache-size now report cache sizes
above 2^63-1 correctly instead of their (negative) two's complement.

So does HMP's "info migrate_cache_size".  HMP's "info migrate" already
reported the cache size correctly, because it printed the signed
integer with PRIu32.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c                  |  4 ++--
 migration/migration.c  | 10 +++++-----
 migration/migration.h  |  4 ++--
 migration/page_cache.c | 20 +++++++++-----------
 migration/page_cache.h |  2 +-
 migration/ram.c        |  5 ++---
 migration/ram.h        |  2 +-
 qapi-schema.json       |  6 +++---
 8 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/hmp.c b/hmp.c
index 1932a11..184fb8b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -344,7 +344,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 
 void hmp_info_migrate_cache_size(Monitor *mon, const QDict *qdict)
 {
-    monitor_printf(mon, "xbzrel cache size: %" PRId64 " kbytes\n",
+    monitor_printf(mon, "xbzrel cache size: %" PRIu64 " kbytes\n",
                    qmp_query_migrate_cache_size(NULL) >> 10);
 }
 
@@ -1504,7 +1504,7 @@ void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict)
 
 void hmp_migrate_set_cache_size(Monitor *mon, const QDict *qdict)
 {
-    int64_t value = qdict_get_int(qdict, "value");
+    uint64_t value = qdict_get_uint(qdict, "value");
     Error *err = NULL;
 
     qmp_migrate_set_cache_size(value, &err);
diff --git a/migration/migration.c b/migration/migration.c
index 3ce68f3..2d7f3a2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1279,13 +1279,13 @@ void qmp_migrate_cancel(Error **errp)
     migrate_fd_cancel(migrate_get_current());
 }
 
-void qmp_migrate_set_cache_size(int64_t value, Error **errp)
+void qmp_migrate_set_cache_size(uint64_t value, Error **errp)
 {
     MigrationState *s = migrate_get_current();
-    int64_t new_size;
+    ssize_t new_size;
 
     /* Check for truncation */
-    if (value != (size_t)value) {
+    if (value != (ssize_t)value) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
                    "exceeding address space");
         return;
@@ -1306,7 +1306,7 @@ void qmp_migrate_set_cache_size(int64_t value, Error **errp)
     s->xbzrle_cache_size = new_size;
 }
 
-int64_t qmp_query_migrate_cache_size(Error **errp)
+uint64_t qmp_query_migrate_cache_size(Error **errp)
 {
     return migrate_xbzrle_cache_size();
 }
@@ -1431,7 +1431,7 @@ int migrate_use_xbzrle(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_XBZRLE];
 }
 
-int64_t migrate_xbzrle_cache_size(void)
+size_t migrate_xbzrle_cache_size(void)
 {
     MigrationState *s;
 
diff --git a/migration/migration.h b/migration/migration.h
index 148c9fa..e4708e1 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -106,7 +106,7 @@ struct MigrationState
     int64_t downtime;
     int64_t expected_downtime;
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
-    int64_t xbzrle_cache_size;
+    size_t xbzrle_cache_size;
     int64_t setup_time;
 
     /* Flag set once the migration has been asked to enter postcopy */
@@ -172,7 +172,7 @@ bool migrate_zero_blocks(void);
 bool migrate_auto_converge(void);
 
 int migrate_use_xbzrle(void);
-int64_t migrate_xbzrle_cache_size(void);
+size_t migrate_xbzrle_cache_size(void);
 bool migrate_colo_enabled(void);
 
 bool migrate_use_block(void);
diff --git a/migration/page_cache.c b/migration/page_cache.c
index ba984c4..226ea72 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -40,18 +40,17 @@ struct CacheItem {
 struct PageCache {
     CacheItem *page_cache;
     unsigned int page_size;
-    int64_t max_num_items;
+    uint64_t max_num_items;
     uint64_t max_item_age;
-    int64_t num_items;
+    uint64_t num_items;
 };
 
-PageCache *cache_init(int64_t num_pages, unsigned int page_size)
+PageCache *cache_init(uint64_t num_pages, unsigned page_size)
 {
-    int64_t i;
-
+    uint64_t i;
     PageCache *cache;
 
-    if (num_pages <= 0) {
+    if (!num_pages) {
         DPRINTF("invalid number of pages\n");
         return NULL;
     }
@@ -65,18 +64,17 @@ PageCache *cache_init(int64_t num_pages, unsigned int page_size)
     /* round down to the nearest power of 2 */
     if (!is_power_of_2(num_pages)) {
         num_pages = pow2floor(num_pages);
-        DPRINTF("rounding down to %" PRId64 "\n", num_pages);
+        DPRINTF("rounding down to %zd\n", num_pages);
     }
     cache->page_size = page_size;
     cache->num_items = 0;
     cache->max_item_age = 0;
     cache->max_num_items = num_pages;
 
-    DPRINTF("Setting cache buckets to %" PRId64 "\n", cache->max_num_items);
+    DPRINTF("Setting cache buckets to %zd\n", cache->max_num_items);
 
     /* We prefer not to abort if there is no memory */
-    cache->page_cache = g_try_malloc((cache->max_num_items) *
-                                     sizeof(*cache->page_cache));
+    cache->page_cache = g_try_new(CacheItem, cache->max_num_items);
     if (!cache->page_cache) {
         DPRINTF("Failed to allocate cache->page_cache\n");
         g_free(cache);
@@ -94,7 +92,7 @@ PageCache *cache_init(int64_t num_pages, unsigned int page_size)
 
 void cache_fini(PageCache *cache)
 {
-    int64_t i;
+    uint64_t i;
 
     g_assert(cache);
     g_assert(cache->page_cache);
diff --git a/migration/page_cache.h b/migration/page_cache.h
index 4fadd0c..b9afce3 100644
--- a/migration/page_cache.h
+++ b/migration/page_cache.h
@@ -28,7 +28,7 @@ typedef struct PageCache PageCache;
  * @num_pages: cache maximal number of cached pages
  * @page_size: cache page size
  */
-PageCache *cache_init(int64_t num_pages, unsigned int page_size);
+PageCache *cache_init(uint64_t num_pages, unsigned page_size);
 
 /**
  * cache_fini: free all cache resources
diff --git a/migration/ram.c b/migration/ram.c
index e9ab858..ce38be4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -110,16 +110,15 @@ static void XBZRLE_cache_unlock(void)
  * migration may be using the cache and might finish during this call,
  * hence changes to the cache are protected by XBZRLE.lock().
  *
- * Returns the new_size or negative in case of error.
  * Returns the the new cache size on success, -1 on error.
  *
  * @new_size: new cache size
  * @errp: return location for an Error
  */
-int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
+ssize_t xbzrle_cache_resize(size_t new_size, Error **errp)
 {
     PageCache *new_cache;
-    int64_t ret;
+    ssize_t ret;
 
     if (new_size < TARGET_PAGE_SIZE) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
diff --git a/migration/ram.h b/migration/ram.h
index 97842bf..7c4187d 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -35,7 +35,7 @@
 extern MigrationStats ram_counters;
 extern XBZRLECacheStats xbzrle_counters;
 
-int64_t xbzrle_cache_resize(int64_t new_size, Error **errp);
+ssize_t xbzrle_cache_resize(size_t new_size, Error **errp);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
 
diff --git a/qapi-schema.json b/qapi-schema.json
index c8cceb9..ecabff6 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -646,7 +646,7 @@
 # Since: 1.2
 ##
 { 'struct': 'XBZRLECacheStats',
-  'data': {'cache-size': 'int', 'bytes': 'int', 'pages': 'int',
+  'data': {'cache-size': 'size', 'bytes': 'int', 'pages': 'int',
            'cache-miss': 'int', 'cache-miss-rate': 'number',
            'overflow': 'int' } }
 
@@ -2875,7 +2875,7 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate-set-cache-size', 'data': {'value': 'int'} }
+{ 'command': 'migrate-set-cache-size', 'data': {'value': 'size'} }
 
 ##
 # @query-migrate-cache-size:
@@ -2892,7 +2892,7 @@
 # <- { "return": 67108864 }
 #
 ##
-{ 'command': 'query-migrate-cache-size', 'returns': 'int' }
+{ 'command': 'query-migrate-cache-size', 'returns': 'size' }
 
 ##
 # @ObjectPropertyInfo:
-- 
2.7.5
