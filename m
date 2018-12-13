Received: from eggs.gnu.org ([2001:4830:134:3::10]:39184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gXLsS-0003jy-JV
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 02:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gXLsQ-0001uQ-Mo
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 02:57:48 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gXLsQ-0001r3-8R
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 02:57:46 -0500
Received: by mail-pl1-x641.google.com with SMTP id e5so676222plb.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 23:57:46 -0800 (PST)
From: guangrong.xiao@gmail.com
Date: Thu, 13 Dec 2018 15:57:27 +0800
Message-Id: <20181213075727.23540-3-xiaoguangrong@tencent.com>
In-Reply-To: <20181213075727.23540-1-xiaoguangrong@tencent.com>
References: <20181213075727.23540-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 2/2] migration: introduce pages-per-second
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It introduces a new statistic, pages-per-second, as bandwidth or mbps is
not enough to measure the performance of posting pages out as we have
compression, xbzrle, which can significantly reduce the amount of the
data size, instead, pages-per-second if the one we want

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hmp.c                 |  2 ++
 migration/migration.c | 12 +++++++++++-
 migration/migration.h |  8 ++++++++
 migration/ram.c       |  6 ++++++
 qapi/migration.json   |  5 ++++-
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 2c5bb504d4..bd7e30cc2e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -236,6 +236,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->ram->page_size >> 10);
         monitor_printf(mon, "multifd bytes: %" PRIu64 " kbytes\n",
                        info->ram->multifd_bytes >> 10);
+        monitor_printf(mon, "pages-per-second: %" PRIu64 "\n",
+                       info->ram->pages_per_second);
 
         if (info->ram->dirty_pages_rate) {
             monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
diff --git a/migration/migration.c b/migration/migration.c
index d19935b529..2a54cd3423 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -780,6 +780,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->postcopy_requests = ram_counters.postcopy_requests;
     info->ram->page_size = qemu_target_page_size();
     info->ram->multifd_bytes = ram_counters.multifd_bytes;
+    info->ram->pages_per_second = s->pages_per_second;
 
     if (migrate_use_xbzrle()) {
         info->has_xbzrle_cache = true;
@@ -1578,6 +1579,7 @@ void migrate_init(MigrationState *s)
     s->rp_state.from_dst_file = NULL;
     s->rp_state.error = false;
     s->mbps = 0.0;
+    s->pages_per_second = 0.0;
     s->downtime = 0;
     s->expected_downtime = 0;
     s->setup_time = 0;
@@ -2914,7 +2916,7 @@ static void migration_calculate_complete(MigrationState *s)
 static void migration_update_counters(MigrationState *s,
                                       int64_t current_time)
 {
-    uint64_t transferred, time_spent;
+    uint64_t transferred, transferred_pages, time_spent;
     uint64_t current_bytes; /* bytes transferred since the beginning */
     double bandwidth;
 
@@ -2931,6 +2933,12 @@ static void migration_update_counters(MigrationState *s,
     s->mbps = (((double) transferred * 8.0) /
                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
 
+
+    transferred_pages = ram_get_total_transferred_pages() -
+                            s->iteration_initial_pages;
+    s->pages_per_second = (double) transferred_pages /
+                             (((double) time_spent / 1000.0));
+
     compress_adaptive_update(s->mbps);
 
     /*
@@ -2945,6 +2953,7 @@ static void migration_update_counters(MigrationState *s,
 
     s->iteration_start_time = current_time;
     s->iteration_initial_bytes = current_bytes;
+    s->iteration_initial_pages = ram_get_total_transferred_pages();
 
     trace_migrate_transferred(transferred, time_spent,
                               bandwidth, s->threshold_size);
@@ -3351,6 +3360,7 @@ static void migration_instance_init(Object *obj)
 
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
+    ms->pages_per_second = -1;
     qemu_sem_init(&ms->pause_sem, 0);
     qemu_mutex_init(&ms->error_mutex);
 
diff --git a/migration/migration.h b/migration/migration.h
index d631776230..73a6803cc4 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -126,6 +126,12 @@ struct MigrationState
      */
     QemuSemaphore rate_limit_sem;
 
+    /* pages already send at the beggining of current interation */
+    uint64_t iteration_initial_pages;
+
+    /* pages transferred per second */
+    double pages_per_second;
+
     /* bytes already send at the beggining of current interation */
     uint64_t iteration_initial_bytes;
     /* time at the start of current iteration */
@@ -279,6 +285,8 @@ int migrate_compress_wait_thread(void);
 int migrate_compress_wait_thread_adaptive(void);
 void compress_adaptive_update(double mbps);
 
+uint64_t ram_get_total_transferred_pages(void);
+
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
 bool migrate_postcopy_blocktime(void);
diff --git a/migration/ram.c b/migration/ram.c
index 3b08a605e4..b6b08a4800 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1613,6 +1613,12 @@ uint64_t ram_pagesize_summary(void)
     return summary;
 }
 
+uint64_t ram_get_total_transferred_pages(void)
+{
+    return  ram_counters.normal + ram_counters.duplicate +
+                compression_counters.pages + xbzrle_counters.pages;
+}
+
 static void compress_adaptive_init(void)
 {
     /* fully wait on default. */
diff --git a/qapi/migration.json b/qapi/migration.json
index 6d925c73fc..e64b2e3901 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -41,6 +41,9 @@
 #
 # @multifd-bytes: The number of bytes sent through multifd (since 3.0)
 #
+# @pages-per-second: the number of memory pages transferred per second
+#        (Since 3.2)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationStats',
@@ -49,7 +52,7 @@
            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
            'postcopy-requests' : 'int', 'page-size' : 'int',
-           'multifd-bytes' : 'uint64' } }
+           'multifd-bytes' : 'uint64', 'pages-per-second' : 'uint64' } }
 
 ##
 # @XBZRLECacheStats:
-- 
2.14.5
