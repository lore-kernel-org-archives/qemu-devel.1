Received: from eggs.gnu.org ([2001:4830:134:3::10]:34303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwxKN-0004OJ-3P
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwxKM-0003F6-61
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwxKL-0003EE-VB
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:10 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  4 Sep 2018 00:27:56 +0200
Message-Id: <20180903222758.13267-4-quintela@redhat.com>
In-Reply-To: <20180903222758.13267-1-quintela@redhat.com>
References: <20180903222758.13267-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] migration: fix calculating
 xbzrle_counters.cache_miss_rate
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

As Peter pointed out:
| - xbzrle_counters.cache_miss is done in save_xbzrle_page(), so it's
|   per-guest-page granularity
|
| - RAMState.iterations is done for each ram_find_and_save_block(), so
|   it's per-host-page granularity
|
| An example is that when we migrate a 2M huge page in the guest, we
| will only increase the RAMState.iterations by 1 (since
| ram_find_and_save_block() will be called once), but we might increase
| xbzrle_counters.cache_miss for 2M/4K=512 times (we'll call
| save_xbzrle_page() that many times) if all the pages got cache miss.
| Then IMHO the cache miss rate will be 512/1=51200% (while it should
| actually be just 100% cache miss).

And he also suggested as xbzrle_counters.cache_miss_rate is the only
user of rs->iterations we can adapt it to count target guest page
numbers

After that, rename 'iterations' to 'target_page_count' to better reflect
its meaning

Suggested-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20180903092644.25812-3-xiaoguangrong@tencent.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 79c89425a3..5a54836c28 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -301,10 +301,10 @@ struct RAMState {
     uint64_t num_dirty_pages_period;
     /* xbzrle misses since the beginning of the period */
     uint64_t xbzrle_cache_miss_prev;
-    /* number of iterations at the beginning of period */
-    uint64_t iterations_prev;
-    /* Iterations since start */
-    uint64_t iterations;
+    /* total handled target pages at the beginning of period */
+    uint64_t target_page_count_prev;
+    /* total handled target pages since start */
+    uint64_t target_page_count;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
     /* protects modification of the bitmap */
@@ -1592,19 +1592,19 @@ uint64_t ram_pagesize_summary(void)
 
 static void migration_update_rates(RAMState *rs, int64_t end_time)
 {
-    uint64_t iter_count = rs->iterations - rs->iterations_prev;
+    uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
 
     /* calculate period counters */
     ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
                 / (end_time - rs->time_last_bitmap_sync);
 
-    if (!iter_count) {
+    if (!page_count) {
         return;
     }
 
     if (migrate_use_xbzrle()) {
         xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
-            rs->xbzrle_cache_miss_prev) / iter_count;
+            rs->xbzrle_cache_miss_prev) / page_count;
         rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
     }
 }
@@ -1662,7 +1662,7 @@ static void migration_bitmap_sync(RAMState *rs)
 
         migration_update_rates(rs, end_time);
 
-        rs->iterations_prev = rs->iterations;
+        rs->target_page_count_prev = rs->target_page_count;
 
         /* reset period counters */
         rs->time_last_bitmap_sync = end_time;
@@ -3196,7 +3196,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
             done = 1;
             break;
         }
-        rs->iterations++;
+        rs->target_page_count += pages;
 
         /* we want to check in the 1st loop, just in case it was the 1st time
            and we had to sync the dirty bitmap.
-- 
2.17.1
