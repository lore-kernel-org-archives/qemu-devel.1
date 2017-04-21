Received: from eggs.gnu.org ([2001:4830:134:3::10]:44734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XBQ-0001lr-Kp
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XBP-0007E9-J9
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XBP-0007E4-AB
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37CC3B083A
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:57:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:55:51 +0200
Message-Id: <20170421115646.15544-11-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 10/65] ram: Move num_dirty_pages_period into
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d13674f..d6cf032 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -159,6 +159,8 @@ struct RAMState {
     int64_t time_last_bitmap_sync;
     /* bytes transferred at start_time */
     uint64_t bytes_xfer_prev;
+    /* number of dirty pages since start_time */
+    int64_t num_dirty_pages_period;
 };
 typedef struct RAMState RAMState;
 
@@ -612,13 +614,13 @@ static inline bool migration_bitmap_clear_dirty(ram_addr_t addr)
     return ret;
 }
 
-static int64_t num_dirty_pages_period;
-static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
+static void migration_bitmap_sync_range(RAMState *rs, ram_addr_t start,
+                                        ram_addr_t length)
 {
     unsigned long *bitmap;
     bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
     migration_dirty_pages += cpu_physical_memory_sync_dirty_bitmap(bitmap,
-                             start, length, &num_dirty_pages_period);
+                             start, length, &rs->num_dirty_pages_period);
 }
 
 /* Fix me: there are too many global variables used in migration process. */
@@ -629,7 +631,7 @@ static void migration_bitmap_sync_init(RAMState *rs)
 {
     rs->time_last_bitmap_sync = 0;
     rs->bytes_xfer_prev = 0;
-    num_dirty_pages_period = 0;
+    rs->num_dirty_pages_period = 0;
     xbzrle_cache_miss_prev = 0;
     iterations_prev = 0;
 }
@@ -678,12 +680,12 @@ static void migration_bitmap_sync(RAMState *rs)
     qemu_mutex_lock(&migration_bitmap_mutex);
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
-        migration_bitmap_sync_range(block->offset, block->used_length);
+        migration_bitmap_sync_range(rs, block->offset, block->used_length);
     }
     rcu_read_unlock();
     qemu_mutex_unlock(&migration_bitmap_mutex);
 
-    trace_migration_bitmap_sync_end(num_dirty_pages_period);
+    trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
 
     end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 
@@ -698,7 +700,7 @@ static void migration_bitmap_sync(RAMState *rs)
             bytes_xfer_now = ram_bytes_transferred();
 
             if (s->dirty_pages_rate &&
-               (num_dirty_pages_period * TARGET_PAGE_SIZE >
+               (rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
                    (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
                (rs->dirty_rate_high_cnt++ >= 2)) {
                     trace_migration_throttle();
@@ -718,11 +720,11 @@ static void migration_bitmap_sync(RAMState *rs)
             iterations_prev = acct_info.iterations;
             xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
         }
-        s->dirty_pages_rate = num_dirty_pages_period * 1000
+        s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
             / (end_time - rs->time_last_bitmap_sync);
         s->dirty_bytes_rate = s->dirty_pages_rate * TARGET_PAGE_SIZE;
         rs->time_last_bitmap_sync = end_time;
-        num_dirty_pages_period = 0;
+        rs->num_dirty_pages_period = 0;
     }
     s->dirty_sync_count = rs->bitmap_sync_count;
     if (migrate_use_events()) {
-- 
2.9.3
