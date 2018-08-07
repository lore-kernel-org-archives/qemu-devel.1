Received: from eggs.gnu.org ([2001:4830:134:3::10]:48588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fmy3E-0003Rf-Dn
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fmy3D-0005Cl-Cs
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:13:12 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:42158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fmy3D-0005Cb-62
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:13:11 -0400
Received: by mail-pl0-x244.google.com with SMTP id g6-v6so3295886plq.9
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 02:13:11 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue,  7 Aug 2018 17:12:08 +0800
Message-Id: <20180807091209.13531-10-xiaoguangrong@tencent.com>
In-Reply-To: <20180807091209.13531-1-xiaoguangrong@tencent.com>
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 09/10] migration: fix calculating
 xbzrle_counters.cache_miss_rate
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
user of rs->iterations we can adapt it to count guest page numbers

After that, rename 'iterations' to 'handle_pages' to better reflect
its meaning

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 09be01dca2..bd7c18d1f9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -300,10 +300,10 @@ struct RAMState {
     uint64_t num_dirty_pages_period;
     /* xbzrle misses since the beginning of the period */
     uint64_t xbzrle_cache_miss_prev;
-    /* number of iterations at the beginning of period */
-    uint64_t iterations_prev;
-    /* Iterations since start */
-    uint64_t iterations;
+    /* total handled pages at the beginning of period */
+    uint64_t handle_pages_prev;
+    /* total handled pages since start */
+    uint64_t handle_pages;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
     /* last dirty_sync_count we have seen */
@@ -1587,19 +1587,19 @@ uint64_t ram_pagesize_summary(void)
 
 static void migration_update_rates(RAMState *rs, int64_t end_time)
 {
-    uint64_t iter_count = rs->iterations - rs->iterations_prev;
+    uint64_t page_count = rs->handle_pages - rs->handle_pages_prev;
 
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
@@ -1657,7 +1657,7 @@ static void migration_bitmap_sync(RAMState *rs)
 
         migration_update_rates(rs, end_time);
 
-        rs->iterations_prev = rs->iterations;
+        rs->handle_pages_prev = rs->handle_pages;
 
         /* reset period counters */
         rs->time_last_bitmap_sync = end_time;
@@ -3209,7 +3209,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
             break;
         }
 
-        rs->iterations++;
+        rs->handle_pages += pages;
 
         /* we want to check in the 1st loop, just in case it was the 1st time
            and we had to sync the dirty bitmap.
-- 
2.14.4
