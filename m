Received: from eggs.gnu.org ([2001:4830:134:3::10]:34999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fg7qd-00028j-KK
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fg7qa-0005Po-EN
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:55 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fg7qa-0005PI-5k
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:52 -0400
Received: by mail-pg1-x544.google.com with SMTP id s7-v6so151993pgv.3
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 05:15:52 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu, 19 Jul 2018 20:15:15 +0800
Message-Id: <20180719121520.30026-4-xiaoguangrong@tencent.com>
In-Reply-To: <20180719121520.30026-1-xiaoguangrong@tencent.com>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 3/8] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Currently, it includes:
pages: amount of pages compressed and transferred to the target VM
busy: amount of count that no free thread to compress data
busy-rate: rate of thread busy
reduced-size: amount of bytes reduced by compression
compression-rate: rate of compressed size

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hmp.c                 | 13 +++++++++++++
 migration/migration.c | 11 +++++++++++
 migration/ram.c       | 37 +++++++++++++++++++++++++++++++++++++
 migration/ram.h       |  1 +
 qapi/migration.json   | 26 +++++++++++++++++++++++++-
 5 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 47d36e3ccf..a9e2776d60 100644
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
+        monitor_printf(mon, "compression reduced size: %" PRIu64 "\n",
+                       info->compression->reduced_size);
+        monitor_printf(mon, "compression rate: %0.2f\n",
+                       info->compression->compression_rate);
+    }
+
     if (info->has_cpu_throttle_percentage) {
         monitor_printf(mon, "cpu throttle percentage: %" PRIu64 "\n",
                        info->cpu_throttle_percentage);
diff --git a/migration/migration.c b/migration/migration.c
index 0af75465b3..8fedf13889 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -754,6 +754,17 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         info->xbzrle_cache->overflow = xbzrle_counters.overflow;
     }
 
+    if (migrate_use_compression()) {
+        info->has_compression = true;
+        info->compression = g_malloc0(sizeof(*info->compression));
+        info->compression->pages = compression_counters.pages;
+        info->compression->busy = compression_counters.busy;
+        info->compression->busy_rate = compression_counters.busy_rate;
+        info->compression->reduced_size = compression_counters.reduced_size;
+        info->compression->compression_rate =
+                                    compression_counters.compression_rate;
+    }
+
     if (cpu_throttle_active()) {
         info->has_cpu_throttle_percentage = true;
         info->cpu_throttle_percentage = cpu_throttle_get_percentage();
diff --git a/migration/ram.c b/migration/ram.c
index 1b016e048d..e68b0e6dec 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -300,6 +300,15 @@ struct RAMState {
     uint64_t num_dirty_pages_period;
     /* xbzrle misses since the beginning of the period */
     uint64_t xbzrle_cache_miss_prev;
+
+    /* compression statistics since the beginning of the period */
+    /* amount of count that no free thread to compress data */
+    uint64_t compress_thread_busy_prev;
+    /* amount bytes reduced by compression */
+    uint64_t compress_reduced_size_prev;
+    /* amount of compressed pages */
+    uint64_t compress_pages_prev;
+
     /* number of iterations at the beginning of period */
     uint64_t iterations_prev;
     /* Iterations since start */
@@ -337,6 +346,8 @@ struct PageSearchStatus {
 };
 typedef struct PageSearchStatus PageSearchStatus;
 
+CompressionStats compression_counters;
+
 struct CompressParam {
     bool done;
     bool quit;
@@ -1597,6 +1608,24 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
             rs->xbzrle_cache_miss_prev) / iter_count;
         rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
     }
+
+    if (migrate_use_compression()) {
+        uint64_t comp_pages;
+
+        compression_counters.busy_rate = (double)(compression_counters.busy -
+            rs->compress_thread_busy_prev) / iter_count;
+        rs->compress_thread_busy_prev = compression_counters.busy;
+
+        comp_pages = compression_counters.pages - rs->compress_pages_prev;
+        if (comp_pages) {
+            compression_counters.compression_rate =
+                (double)(compression_counters.reduced_size -
+                rs->compress_reduced_size_prev) /
+                (comp_pages * TARGET_PAGE_SIZE);
+            rs->compress_pages_prev = compression_counters.pages;
+            rs->compress_reduced_size_prev = compression_counters.reduced_size;
+        }
+    }
 }
 
 static void migration_bitmap_sync(RAMState *rs)
@@ -1872,6 +1901,9 @@ static void flush_compressed_data(RAMState *rs)
         qemu_mutex_lock(&comp_param[idx].mutex);
         if (!comp_param[idx].quit) {
             len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
+            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
+            compression_counters.reduced_size += TARGET_PAGE_SIZE - len + 8;
+            compression_counters.pages++;
             ram_counters.transferred += len;
         }
         qemu_mutex_unlock(&comp_param[idx].mutex);
@@ -1903,6 +1935,10 @@ retry:
             qemu_cond_signal(&comp_param[idx].cond);
             qemu_mutex_unlock(&comp_param[idx].mutex);
             pages = 1;
+            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
+            compression_counters.reduced_size += TARGET_PAGE_SIZE -
+                                                 bytes_xmit + 8;
+            compression_counters.pages++;
             ram_counters.transferred += bytes_xmit;
             break;
         }
@@ -2233,6 +2269,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         if (res > 0) {
             return res;
         }
+        compression_counters.busy++;
     } else if (migrate_use_multifd()) {
         return ram_save_multifd_page(rs, block, offset);
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
index b4f394844b..5a34aa1754 100644
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
+# @reduced-size: amount of bytes reduced by compression
+#
+# @compression-rate: rate of compressed size
+#
+# Since: 3.0
+##
+{ 'struct': 'CompressionStats',
+  'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
+	   'reduced-size': 'int', 'compression-rate': 'number' } }
+
 ##
 # @MigrationStatus:
 #
@@ -172,6 +193,8 @@
 #           only present when the postcopy-blocktime migration capability
 #           is enabled. (Since 3.0)
 #
+# @compression: migration compression statistics, only returned if compression
+#           feature is on and status is 'active' or 'completed' (Since 3.0)
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
2.14.4
