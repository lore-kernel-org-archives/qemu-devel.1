Received: from eggs.gnu.org ([2001:4830:134:3::10]:59775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cizVE-0003tv-Rg
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cizVA-0005Wz-0m
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:20:52 -0500
Received: from [59.151.112.132] (port=6960 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cizV9-0005RL-7l
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:20:47 -0500
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Date: Wed, 1 Mar 2017 16:19:51 +0800
Message-ID: <20170301081951.27363-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] Add inst_dirty_pages_rate in 'info migrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, izumi.taku@jp.fujitsu.com, Chao Fan <fanc.fnst@cn.fujitsu.com>

Auto-converge aims to accelerate migration by slowing down the
generation of dirty pages. But user doesn't know how to determine the
throttle value, so, a new item "inst-dirty-pages-rate" in "info migrate"
would be helpful for user's determination.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 hmp.c                         |  4 ++++
 include/migration/migration.h |  1 +
 include/qemu/bitmap.h         | 17 +++++++++++++++++
 migration/migration.c         |  2 ++
 migration/ram.c               | 44 +++++++++++++++++++++++++++++++++++++++++++
 qapi-schema.json              |  1 +
 6 files changed, 69 insertions(+)

diff --git a/hmp.c b/hmp.c
index 2bc4f06..c7892ea 100644
--- a/hmp.c
+++ b/hmp.c
@@ -219,6 +219,10 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
                            info->ram->dirty_pages_rate);
         }
+        if (info->ram->inst_dirty_pages_rate) {
+            monitor_printf(mon, "inst dirty pages rate: %" PRIu64 " bytes/s\n",
+                           info->ram->inst_dirty_pages_rate);
+        }
         if (info->ram->postcopy_requests) {
             monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
                            info->ram->postcopy_requests);
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 1735d66..95f0453 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -164,6 +164,7 @@ struct MigrationState
     int64_t downtime;
     int64_t expected_downtime;
     int64_t dirty_pages_rate;
+    int64_t inst_dirty_pages_rate;
     int64_t dirty_bytes_rate;
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t xbzrle_cache_size;
diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 63ea2d0..dc99f9b 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -235,4 +235,21 @@ static inline unsigned long *bitmap_zero_extend(unsigned long *old,
     return new;
 }
 
+static inline unsigned long bitmap_weight(const unsigned long *src, long nbits)
+{
+    unsigned long i, count = 0, nlong = nbits / BITS_PER_LONG;
+
+    if (small_nbits(nbits)) {
+        return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
+    }
+    for (i = 0; i < nlong; i++) {
+        count += hweight_long(src[i]);
+    }
+    if (nbits % BITS_PER_LONG) {
+        count += hweight_long(src[i] & BITMAP_LAST_WORD_MASK(nbits));
+    }
+
+    return count;
+}
+
 #endif /* BITMAP_H */
diff --git a/migration/migration.c b/migration/migration.c
index c6ae69d..18fc2ec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -644,6 +644,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
         info->ram->dirty_pages_rate = s->dirty_pages_rate;
+        info->ram->inst_dirty_pages_rate = s->inst_dirty_pages_rate;
     }
 }
 
@@ -1099,6 +1100,7 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->downtime = 0;
     s->expected_downtime = 0;
     s->dirty_pages_rate = 0;
+    s->inst_dirty_pages_rate = 0;
     s->dirty_bytes_rate = 0;
     s->setup_time = 0;
     s->dirty_sync_count = 0;
diff --git a/migration/ram.c b/migration/ram.c
index f289fcd..185556f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -44,6 +44,7 @@
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
+#include "hw/boards.h"
 
 static int dirty_rate_high_cnt;
 
@@ -591,6 +592,9 @@ static int64_t num_dirty_pages_period;
 static uint64_t xbzrle_cache_miss_prev;
 static uint64_t iterations_prev;
 
+static int64_t dirty_pages_time_prev;
+static int64_t dirty_pages_time_now;
+
 static void migration_bitmap_sync_init(void)
 {
     start_time = 0;
@@ -598,6 +602,44 @@ static void migration_bitmap_sync_init(void)
     num_dirty_pages_period = 0;
     xbzrle_cache_miss_prev = 0;
     iterations_prev = 0;
+    dirty_pages_time_prev = 0;
+    dirty_pages_time_now = 0;
+}
+
+static void migration_inst_rate(void)
+{
+    RAMBlock *block;
+    MigrationState *s = migrate_get_current();
+    int64_t inst_dirty_pages = 0;
+    int64_t i;
+    unsigned long *num;
+    unsigned long len = 0;
+
+    dirty_pages_time_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    if (dirty_pages_time_prev != 0) {
+        rcu_read_lock();
+        DirtyMemoryBlocks *blocks = atomic_rcu_read(
+                         &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]);
+        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+            if (len == 0) {
+                len = block->offset;
+            }
+            len += block->used_length;
+        }
+        ram_addr_t idx = (len >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
+        if (((len >> TARGET_PAGE_BITS) % DIRTY_MEMORY_BLOCK_SIZE) != 0) {
+            idx++;
+        }
+        for (i = 0; i < idx; i++) {
+            num = blocks->blocks[i];
+            inst_dirty_pages += bitmap_weight(num, DIRTY_MEMORY_BLOCK_SIZE);
+        }
+        rcu_read_unlock();
+
+        s->inst_dirty_pages_rate = inst_dirty_pages * TARGET_PAGE_SIZE *
+                    1000 / (dirty_pages_time_now - dirty_pages_time_prev);
+    }
+    dirty_pages_time_prev = dirty_pages_time_now;
 }
 
 static void migration_bitmap_sync(void)
@@ -621,6 +663,8 @@ static void migration_bitmap_sync(void)
     trace_migration_bitmap_sync_start();
     memory_global_dirty_log_sync();
 
+    migration_inst_rate();
+
     qemu_mutex_lock(&migration_bitmap_mutex);
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
diff --git a/qapi-schema.json b/qapi-schema.json
index e9a6364..87c0617 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -581,6 +581,7 @@
   'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
            'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
+           'inst-dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
            'postcopy-requests' : 'int' } }
 
-- 
2.9.3
