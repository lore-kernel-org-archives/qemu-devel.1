Received: from eggs.gnu.org ([2001:4830:134:3::10]:33662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkf-0005c4-EN
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkc-0005LV-7o
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIXkb-0005LF-Vp
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC3B13E9
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 09:59:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Jun 2017 11:59:24 +0200
Message-Id: <20170607095926.1834-6-quintela@redhat.com>
In-Reply-To: <20170607095926.1834-1-quintela@redhat.com>
References: <20170607095926.1834-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] ram: Use MigrationStats for statistics
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

RAM Statistics need to survive migration to make info migrate work, so we
need to store them outside of RAMState.  As we already have an struct
with those fields, just used them. (MigrationStats and XBZRLECacheStats).

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c |  28 ++++-----
 migration/ram.c       | 163 ++++++++++++++------------------------------------
 migration/ram.h       |  14 +----
 3 files changed, 61 insertions(+), 144 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9cf47d3..6f0705a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -592,28 +592,28 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
 {
     info->has_ram = true;
     info->ram = g_malloc0(sizeof(*info->ram));
-    info->ram->transferred = ram_bytes_transferred();
+    info->ram->transferred = ram_counters.transferred;
     info->ram->total = ram_bytes_total();
-    info->ram->duplicate = dup_mig_pages_transferred();
+    info->ram->duplicate = ram_counters.duplicate;
     /* legacy value.  It is not used anymore */
     info->ram->skipped = 0;
-    info->ram->normal = norm_mig_pages_transferred();
-    info->ram->normal_bytes = norm_mig_pages_transferred() *
+    info->ram->normal = ram_counters.normal;
+    info->ram->normal_bytes = ram_counters.normal *
         qemu_target_page_size();
     info->ram->mbps = s->mbps;
-    info->ram->dirty_sync_count = ram_dirty_sync_count();
-    info->ram->postcopy_requests = ram_postcopy_requests();
+    info->ram->dirty_sync_count = ram_counters.dirty_sync_count;
+    info->ram->postcopy_requests = ram_counters.postcopy_requests;
     info->ram->page_size = qemu_target_page_size();
 
     if (migrate_use_xbzrle()) {
         info->has_xbzrle_cache = true;
         info->xbzrle_cache = g_malloc0(sizeof(*info->xbzrle_cache));
         info->xbzrle_cache->cache_size = migrate_xbzrle_cache_size();
-        info->xbzrle_cache->bytes = xbzrle_mig_bytes_transferred();
-        info->xbzrle_cache->pages = xbzrle_mig_pages_transferred();
-        info->xbzrle_cache->cache_miss = xbzrle_mig_pages_cache_miss();
-        info->xbzrle_cache->cache_miss_rate = xbzrle_mig_cache_miss_rate();
-        info->xbzrle_cache->overflow = xbzrle_mig_pages_overflow();
+        info->xbzrle_cache->bytes = xbzrle_counters.bytes;
+        info->xbzrle_cache->pages = xbzrle_counters.pages;
+        info->xbzrle_cache->cache_miss = xbzrle_counters.cache_miss;
+        info->xbzrle_cache->cache_miss_rate = xbzrle_counters.cache_miss_rate;
+        info->xbzrle_cache->overflow = xbzrle_counters.overflow;
     }
 
     if (cpu_throttle_active()) {
@@ -623,7 +623,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
-        info->ram->dirty_pages_rate = ram_dirty_pages_rate();
+        info->ram->dirty_pages_rate = ram_counters.dirty_pages_rate;
     }
 }
 
@@ -2018,8 +2018,8 @@ static void *migration_thread(void *opaque)
                                       bandwidth, threshold_size);
             /* if we haven't sent anything, we don't want to recalculate
                10000 is a small enough number for our purposes */
-            if (ram_dirty_pages_rate() && transferred_bytes > 10000) {
-                s->expected_downtime = ram_dirty_pages_rate() *
+            if (ram_counters.dirty_pages_rate && transferred_bytes > 10000) {
+                s->expected_downtime = ram_counters.dirty_pages_rate *
                     qemu_target_page_size() / bandwidth;
             }
 
diff --git a/migration/ram.c b/migration/ram.c
index ac30e9e..cd6a121 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -74,6 +74,8 @@ static inline bool is_zero_range(uint8_t *p, uint64_t size)
     return buffer_is_zero(p, size);
 }
 
+XBZRLECacheStats xbzrle_counters;
+
 /* struct contains XBZRLE cache and a static page
    used by the compression */
 static struct {
@@ -177,8 +179,6 @@ struct RAMState {
     bool ram_bulk_stage;
     /* How many times we have dirty too many pages */
     int dirty_rate_high_cnt;
-    /* How many times we have synchronized the bitmap */
-    uint64_t bitmap_sync_count;
     /* these variables are used for bitmap sync */
     /* last time we did a full bitmap_sync */
     int64_t time_last_bitmap_sync;
@@ -190,33 +190,11 @@ struct RAMState {
     uint64_t xbzrle_cache_miss_prev;
     /* number of iterations at the beginning of period */
     uint64_t iterations_prev;
-    /* Accounting fields */
-    /* number of zero pages.  It used to be pages filled by the same char. */
-    uint64_t zero_pages;
-    /* number of normal transferred pages */
-    uint64_t norm_pages;
     /* Iterations since start */
     uint64_t iterations;
-    /* xbzrle transmitted bytes.  Notice that this is with
-     * compression, they can't be calculated from the pages */
-    uint64_t xbzrle_bytes;
-    /* xbzrle transmmited pages */
-    uint64_t xbzrle_pages;
-    /* xbzrle number of cache miss */
-    uint64_t xbzrle_cache_miss;
-    /* xbzrle miss rate */
-    double xbzrle_cache_miss_rate;
-    /* xbzrle number of overflows */
-    uint64_t xbzrle_overflows;
-    /* number of dirty bits in the bitmap */
-    uint64_t migration_dirty_pages;
-    /* total number of bytes transferred */
-    uint64_t bytes_transferred;
-    /* number of dirtied pages in the last second */
-    uint64_t dirty_pages_rate;
-    /* Count of requests incoming from destination */
-    uint64_t postcopy_requests;
     /* protects modification of the bitmap */
+    uint64_t migration_dirty_pages;
+    /* number of dirty bits in the bitmap */
     QemuMutex bitmap_mutex;
     /* The RAMBlock used in the last src_page_requests */
     RAMBlock *last_req_rb;
@@ -228,65 +206,12 @@ typedef struct RAMState RAMState;
 
 static RAMState ram_state;
 
-uint64_t dup_mig_pages_transferred(void)
-{
-    return ram_state.zero_pages;
-}
-
-uint64_t norm_mig_pages_transferred(void)
-{
-    return ram_state.norm_pages;
-}
-
-uint64_t xbzrle_mig_bytes_transferred(void)
-{
-    return ram_state.xbzrle_bytes;
-}
-
-uint64_t xbzrle_mig_pages_transferred(void)
-{
-    return ram_state.xbzrle_pages;
-}
-
-uint64_t xbzrle_mig_pages_cache_miss(void)
-{
-    return ram_state.xbzrle_cache_miss;
-}
-
-double xbzrle_mig_cache_miss_rate(void)
-{
-    return ram_state.xbzrle_cache_miss_rate;
-}
-
-uint64_t xbzrle_mig_pages_overflow(void)
-{
-    return ram_state.xbzrle_overflows;
-}
-
-uint64_t ram_bytes_transferred(void)
-{
-    return ram_state.bytes_transferred;
-}
-
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state.migration_dirty_pages * TARGET_PAGE_SIZE;
 }
 
-uint64_t ram_dirty_sync_count(void)
-{
-    return ram_state.bitmap_sync_count;
-}
-
-uint64_t ram_dirty_pages_rate(void)
-{
-    return ram_state.dirty_pages_rate;
-}
-
-uint64_t ram_postcopy_requests(void)
-{
-    return ram_state.postcopy_requests;
-}
+MigrationStats ram_counters;
 
 /* used by the search for pages to send */
 struct PageSearchStatus {
@@ -513,7 +438,7 @@ static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
     /* We don't care if this fails to allocate a new cache page
      * as long as it updated an old one */
     cache_insert(XBZRLE.cache, current_addr, XBZRLE.zero_target_page,
-                 rs->bitmap_sync_count);
+                 ram_counters.dirty_sync_count);
 }
 
 #define ENCODING_FLAG_XBZRLE 0x1
@@ -539,11 +464,12 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     int encoded_len = 0, bytes_xbzrle;
     uint8_t *prev_cached_page;
 
-    if (!cache_is_cached(XBZRLE.cache, current_addr, rs->bitmap_sync_count)) {
-        rs->xbzrle_cache_miss++;
+    if (!cache_is_cached(XBZRLE.cache, current_addr,
+                         ram_counters.dirty_sync_count)) {
+        xbzrle_counters.cache_miss++;
         if (!last_stage) {
             if (cache_insert(XBZRLE.cache, current_addr, *current_data,
-                             rs->bitmap_sync_count) == -1) {
+                             ram_counters.dirty_sync_count) == -1) {
                 return -1;
             } else {
                 /* update *current_data when the page has been
@@ -568,7 +494,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
         return 0;
     } else if (encoded_len == -1) {
         trace_save_xbzrle_page_overflow();
-        rs->xbzrle_overflows++;
+        xbzrle_counters.overflow++;
         /* update data in the cache */
         if (!last_stage) {
             memcpy(prev_cached_page, *current_data, TARGET_PAGE_SIZE);
@@ -589,9 +515,9 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     qemu_put_be16(rs->f, encoded_len);
     qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_len);
     bytes_xbzrle += encoded_len + 1 + 2;
-    rs->xbzrle_pages++;
-    rs->xbzrle_bytes += bytes_xbzrle;
-    rs->bytes_transferred += bytes_xbzrle;
+    xbzrle_counters.pages++;
+    xbzrle_counters.bytes += bytes_xbzrle;
+    ram_counters.transferred += bytes_xbzrle;
 
     return 1;
 }
@@ -673,7 +599,7 @@ static void migration_bitmap_sync(RAMState *rs)
     int64_t end_time;
     uint64_t bytes_xfer_now;
 
-    rs->bitmap_sync_count++;
+    ram_counters.dirty_sync_count++;
 
     if (!rs->time_last_bitmap_sync) {
         rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
@@ -697,9 +623,9 @@ static void migration_bitmap_sync(RAMState *rs)
     /* more than 1 second = 1000 millisecons */
     if (end_time > rs->time_last_bitmap_sync + 1000) {
         /* calculate period counters */
-        rs->dirty_pages_rate = rs->num_dirty_pages_period * 1000
+        ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
             / (end_time - rs->time_last_bitmap_sync);
-        bytes_xfer_now = ram_bytes_transferred();
+        bytes_xfer_now = ram_counters.transferred;
 
         if (migrate_auto_converge()) {
             /* The following detection logic can be refined later. For now:
@@ -719,13 +645,13 @@ static void migration_bitmap_sync(RAMState *rs)
 
         if (migrate_use_xbzrle()) {
             if (rs->iterations_prev != rs->iterations) {
-                rs->xbzrle_cache_miss_rate =
-                   (double)(rs->xbzrle_cache_miss -
+                xbzrle_counters.cache_miss_rate =
+                   (double)(xbzrle_counters.cache_miss -
                             rs->xbzrle_cache_miss_prev) /
                    (rs->iterations - rs->iterations_prev);
             }
             rs->iterations_prev = rs->iterations;
-            rs->xbzrle_cache_miss_prev = rs->xbzrle_cache_miss;
+            rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
         }
 
         /* reset period counters */
@@ -734,7 +660,7 @@ static void migration_bitmap_sync(RAMState *rs)
         rs->bytes_xfer_prev = bytes_xfer_now;
     }
     if (migrate_use_events()) {
-        qapi_event_send_migration_pass(rs->bitmap_sync_count, NULL);
+        qapi_event_send_migration_pass(ram_counters.dirty_sync_count, NULL);
     }
 }
 
@@ -754,11 +680,11 @@ static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
     int pages = -1;
 
     if (is_zero_range(p, TARGET_PAGE_SIZE)) {
-        rs->zero_pages++;
-        rs->bytes_transferred +=
+        ram_counters.duplicate++;
+        ram_counters.transferred +=
             save_page_header(rs, rs->f, block, offset | RAM_SAVE_FLAG_ZERO);
         qemu_put_byte(rs->f, 0);
-        rs->bytes_transferred += 1;
+        ram_counters.transferred += 1;
         pages = 1;
     }
 
@@ -806,7 +732,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     ret = ram_control_save_page(rs->f, block->offset,
                            offset, TARGET_PAGE_SIZE, &bytes_xmit);
     if (bytes_xmit) {
-        rs->bytes_transferred += bytes_xmit;
+        ram_counters.transferred += bytes_xmit;
         pages = 1;
     }
 
@@ -817,9 +743,9 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
     if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
         if (ret != RAM_SAVE_CONTROL_DELAYED) {
             if (bytes_xmit > 0) {
-                rs->norm_pages++;
+                ram_counters.normal++;
             } else if (bytes_xmit == 0) {
-                rs->zero_pages++;
+                ram_counters.duplicate++;
             }
         }
     } else {
@@ -845,8 +771,8 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 
     /* XBZRLE overflow or normal page */
     if (pages == -1) {
-        rs->bytes_transferred += save_page_header(rs, rs->f, block,
-                                                  offset | RAM_SAVE_FLAG_PAGE);
+        ram_counters.transferred +=
+            save_page_header(rs, rs->f, block, offset | RAM_SAVE_FLAG_PAGE);
         if (send_async) {
             qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
                                   migrate_release_ram() &
@@ -854,9 +780,9 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
         } else {
             qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
         }
-        rs->bytes_transferred += TARGET_PAGE_SIZE;
+        ram_counters.transferred += TARGET_PAGE_SIZE;
         pages = 1;
-        rs->norm_pages++;
+        ram_counters.normal++;
     }
 
     XBZRLE_cache_unlock();
@@ -908,7 +834,7 @@ static void flush_compressed_data(RAMState *rs)
         qemu_mutex_lock(&comp_param[idx].mutex);
         if (!comp_param[idx].quit) {
             len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
-            rs->bytes_transferred += len;
+            ram_counters.transferred += len;
         }
         qemu_mutex_unlock(&comp_param[idx].mutex);
     }
@@ -938,8 +864,8 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
                 qemu_cond_signal(&comp_param[idx].cond);
                 qemu_mutex_unlock(&comp_param[idx].mutex);
                 pages = 1;
-                rs->norm_pages++;
-                rs->bytes_transferred += bytes_xmit;
+                ram_counters.normal++;
+                ram_counters.transferred += bytes_xmit;
                 break;
             }
         }
@@ -979,15 +905,15 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
     ret = ram_control_save_page(rs->f, block->offset,
                                 offset, TARGET_PAGE_SIZE, &bytes_xmit);
     if (bytes_xmit) {
-        rs->bytes_transferred += bytes_xmit;
+        ram_counters.transferred += bytes_xmit;
         pages = 1;
     }
     if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
         if (ret != RAM_SAVE_CONTROL_DELAYED) {
             if (bytes_xmit > 0) {
-                rs->norm_pages++;
+                ram_counters.normal++;
             } else if (bytes_xmit == 0) {
-                rs->zero_pages++;
+                ram_counters.duplicate++;
             }
         }
     } else {
@@ -1007,8 +933,8 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
                 blen = qemu_put_compression_data(rs->f, p, TARGET_PAGE_SIZE,
                                                  migrate_compress_level());
                 if (blen > 0) {
-                    rs->bytes_transferred += bytes_xmit + blen;
-                    rs->norm_pages++;
+                    ram_counters.transferred += bytes_xmit + blen;
+                    ram_counters.normal++;
                     pages = 1;
                 } else {
                     qemu_file_set_error(rs->f, blen);
@@ -1216,7 +1142,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
     RAMBlock *ramblock;
     RAMState *rs = &ram_state;
 
-    rs->postcopy_requests++;
+    ram_counters.postcopy_requests++;
     rcu_read_lock();
     if (!rbname) {
         /* Reuse last RAMBlock */
@@ -1404,13 +1330,12 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
 void acct_update_position(QEMUFile *f, size_t size, bool zero)
 {
     uint64_t pages = size / TARGET_PAGE_SIZE;
-    RAMState *rs = &ram_state;
 
     if (zero) {
-        rs->zero_pages += pages;
+        ram_counters.duplicate += pages;
     } else {
-        rs->norm_pages += pages;
-        rs->bytes_transferred += size;
+        ram_counters.normal += pages;
+        ram_counters.transferred += size;
         qemu_update_position(f, size);
     }
 }
@@ -2060,7 +1985,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
 
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
-    rs->bytes_transferred += 8;
+    ram_counters.transferred += 8;
 
     ret = qemu_file_get_error(f);
     if (ret < 0) {
diff --git a/migration/ram.h b/migration/ram.h
index d4da419..6272eb0 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -32,19 +32,11 @@
 #include "qemu-common.h"
 #include "exec/cpu-common.h"
 
+extern MigrationStats ram_counters;
+extern XBZRLECacheStats xbzrle_counters;
+
 int64_t xbzrle_cache_resize(int64_t new_size);
-uint64_t dup_mig_pages_transferred(void);
-uint64_t norm_mig_pages_transferred(void);
-uint64_t xbzrle_mig_bytes_transferred(void);
-uint64_t xbzrle_mig_pages_transferred(void);
-uint64_t xbzrle_mig_pages_cache_miss(void);
-double xbzrle_mig_cache_miss_rate(void);
-uint64_t xbzrle_mig_pages_overflow(void);
-uint64_t ram_bytes_transferred(void);
 uint64_t ram_bytes_remaining(void);
-uint64_t ram_dirty_sync_count(void);
-uint64_t ram_dirty_pages_rate(void);
-uint64_t ram_postcopy_requests(void);
 uint64_t ram_bytes_total(void);
 
 void migrate_compress_threads_create(void);
-- 
2.9.4
