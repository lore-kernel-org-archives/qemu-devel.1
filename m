Received: from eggs.gnu.org ([2001:4830:134:3::10]:47702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8X-0003Qz-Sb
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8W-0003I7-Gj
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1g0R8V-0003FY-8r
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:20 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Sep 2018 14:53:37 +0200
Message-Id: <20180913125343.10912-7-quintela@redhat.com>
In-Reply-To: <20180913125343.10912-1-quintela@redhat.com>
References: <20180913125343.10912-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 06/12] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Currently, it includes:
pages: amount of pages compressed and transferred to the target VM
busy: amount of count that no free thread to compress data
busy-rate: rate of thread busy
compressed-size: amount of bytes after compression
compression-rate: rate of compressed size

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20180906070101.27280-3-xiaoguangrong@tencent.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                 | 13 +++++++++++++
 migration/migration.c | 12 ++++++++++++
 migration/ram.c       | 45 ++++++++++++++++++++++++++++++++++++++++---
 migration/ram.h       |  1 +
 qapi/migration.json   | 26 ++++++++++++++++++++++++-
 5 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/hmp.c b/hmp.c
index 4975fa56b0..f57b23d889 100644
--- a/hmp.c
+++ b/hmp.c
@@ -271,6 +271,19 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->xbzrle_cache->overflow);
     }
 
+    if (info->has_compression) {
+        monitor_printf(mon, "compression pages: %" PRIu64 " pages\n",
+                       info->compression->pages);
+        monitor_printf(mon, "compression busy: %" PRIu64 "\n",
+                       info->compression->busy);
+        monitor_printf(mon, "compression busy rate: %0.2f\n",
+                       info->compression->busy_rate);
+        monitor_printf(mon, "compressed size: %" PRIu64 "\n",
+                       info->compression->compressed_size);
+        monitor_printf(mon, "compression rate: %0.2f\n",
+                       info->compression->compression_rate);
+    }
+
     if (info->has_cpu_throttle_percentage) {
         monitor_printf(mon, "cpu throttle percentage: %" PRIu64 "\n",
                        info->cpu_throttle_percentage);
diff --git a/migration/migration.c b/migration/migration.c
index 4b316ec343..f1d662f928 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -758,6 +758,18 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         info->xbzrle_cache->overflow = xbzrle_counters.overflow;
     }
 
+    if (migrate_use_compression()) {
+        info->has_compression = true;
+        info->compression = g_malloc0(sizeof(*info->compression));
+        info->compression->pages = compression_counters.pages;
+        info->compression->busy = compression_counters.busy;
+        info->compression->busy_rate = compression_counters.busy_rate;
+        info->compression->compressed_size =
+                                    compression_counters.compressed_size;
+        info->compression->compression_rate =
+                                    compression_counters.compression_rate;
+    }
+
     if (cpu_throttle_active()) {
         info->has_cpu_throttle_percentage = true;
         info->cpu_throttle_percentage = cpu_throttle_get_percentage();
diff --git a/migration/ram.c b/migration/ram.c
index e152831254..65a563993d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -301,6 +301,15 @@ struct RAMState {
     uint64_t num_dirty_pages_period;
     /* xbzrle misses since the beginning of the period */
     uint64_t xbzrle_cache_miss_prev;
+
+    /* compression statistics since the beginning of the period */
+    /* amount of count that no free thread to compress data */
+    uint64_t compress_thread_busy_prev;
+    /* amount bytes after compression */
+    uint64_t compressed_size_prev;
+    /* amount of compressed pages */
+    uint64_t compress_pages_prev;
+
     /* total handled target pages at the beginning of period */
     uint64_t target_page_count_prev;
     /* total handled target pages since start */
@@ -338,6 +347,8 @@ struct PageSearchStatus {
 };
 typedef struct PageSearchStatus PageSearchStatus;
 
+CompressionStats compression_counters;
+
 struct CompressParam {
     bool done;
     bool quit;
@@ -1593,6 +1604,7 @@ uint64_t ram_pagesize_summary(void)
 static void migration_update_rates(RAMState *rs, int64_t end_time)
 {
     uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
+    double compressed_size;
 
     /* calculate period counters */
     ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
@@ -1607,6 +1619,26 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
             rs->xbzrle_cache_miss_prev) / page_count;
         rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
     }
+
+    if (migrate_use_compression()) {
+        compression_counters.busy_rate = (double)(compression_counters.busy -
+            rs->compress_thread_busy_prev) / page_count;
+        rs->compress_thread_busy_prev = compression_counters.busy;
+
+        compressed_size = compression_counters.compressed_size -
+                          rs->compressed_size_prev;
+        if (compressed_size) {
+            double uncompressed_size = (compression_counters.pages -
+                                    rs->compress_pages_prev) * TARGET_PAGE_SIZE;
+
+            /* Compression-Ratio = Uncompressed-size / Compressed-size */
+            compression_counters.compression_rate =
+                                        uncompressed_size / compressed_size;
+
+            rs->compress_pages_prev = compression_counters.pages;
+            rs->compressed_size_prev = compression_counters.compressed_size;
+        }
+    }
 }
 
 static void migration_bitmap_sync(RAMState *rs)
@@ -1888,10 +1920,16 @@ exit:
 static void
 update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
 {
-    if (param->zero_page) {
-        ram_counters.duplicate++;
-    }
     ram_counters.transferred += bytes_xmit;
+
+    if (param->zero_page) {
+        ram_counters.duplicate++;
+        return;
+    }
+
+    /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
+    compression_counters.compressed_size += bytes_xmit - 8;
+    compression_counters.pages++;
 }
 
 static void flush_compressed_data(RAMState *rs)
@@ -2264,6 +2302,7 @@ static bool save_compress_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
         return true;
     }
 
+    compression_counters.busy++;
     return false;
 }
 
diff --git a/migration/ram.h b/migration/ram.h
index 457bf54b8c..a139066846 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -36,6 +36,7 @@
 
 extern MigrationStats ram_counters;
 extern XBZRLECacheStats xbzrle_counters;
+extern CompressionStats compression_counters;
 
 int xbzrle_cache_resize(int64_t new_size, Error **errp);
 uint64_t ram_bytes_remaining(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index f62d3f9a4b..6e8c21258a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -75,6 +75,27 @@
            'cache-miss': 'int', 'cache-miss-rate': 'number',
            'overflow': 'int' } }
 
+##
+# @CompressionStats:
+#
+# Detailed migration compression statistics
+#
+# @pages: amount of pages compressed and transferred to the target VM
+#
+# @busy: count of times that no free thread was available to compress data
+#
+# @busy-rate: rate of thread busy
+#
+# @compressed-size: amount of bytes after compression
+#
+# @compression-rate: rate of compressed size
+#
+# Since: 3.1
+##
+{ 'struct': 'CompressionStats',
+  'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
+	   'compressed-size': 'int', 'compression-rate': 'number' } }
+
 ##
 # @MigrationStatus:
 #
@@ -172,6 +193,8 @@
 #           only present when the postcopy-blocktime migration capability
 #           is enabled. (Since 3.0)
 #
+# @compression: migration compression statistics, only returned if compression
+#           feature is on and status is 'active' or 'completed' (Since 3.1)
 #
 # Since: 0.14.0
 ##
@@ -186,7 +209,8 @@
            '*cpu-throttle-percentage': 'int',
            '*error-desc': 'str',
            '*postcopy-blocktime' : 'uint32',
-           '*postcopy-vcpu-blocktime': ['uint32']} }
+           '*postcopy-vcpu-blocktime': ['uint32'],
+           '*compression': 'CompressionStats'} }
 
 ##
 # @query-migrate:
-- 
2.17.1
