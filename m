Received: from eggs.gnu.org ([2001:4830:134:3::10]:46531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDu-0007Yw-6Q
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDp-00019b-Ce
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:22 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:42116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmDp-00019H-66
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:17 -0400
Received: by mail-pg0-x233.google.com with SMTP id p9-v6so14239988pgc.9
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:17 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:12 +0800
Message-Id: <20180604095520.8563-5-xiaoguangrong@tencent.com>
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 04/12] migration: introduce
 migration_update_rates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It is used to slightly clean the code up, no logic is changed

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index dd1283dd45..ee03b28435 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1130,6 +1130,25 @@ uint64_t ram_pagesize_summary(void)
     return summary;
 }
 
+static void migration_update_rates(RAMState *rs, int64_t end_time)
+{
+    uint64_t iter_count = rs->iterations - rs->iterations_prev;
+
+    /* calculate period counters */
+    ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
+                / (end_time - rs->time_last_bitmap_sync);
+
+    if (!iter_count) {
+        return;
+    }
+
+    if (migrate_use_xbzrle()) {
+        xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
+            rs->xbzrle_cache_miss_prev) / iter_count;
+        rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
+    }
+}
+
 static void migration_bitmap_sync(RAMState *rs)
 {
     RAMBlock *block;
@@ -1159,9 +1178,6 @@ static void migration_bitmap_sync(RAMState *rs)
 
     /* more than 1 second = 1000 millisecons */
     if (end_time > rs->time_last_bitmap_sync + 1000) {
-        /* calculate period counters */
-        ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
-            / (end_time - rs->time_last_bitmap_sync);
         bytes_xfer_now = ram_counters.transferred;
 
         /* During block migration the auto-converge logic incorrectly detects
@@ -1183,16 +1199,9 @@ static void migration_bitmap_sync(RAMState *rs)
             }
         }
 
-        if (migrate_use_xbzrle()) {
-            if (rs->iterations_prev != rs->iterations) {
-                xbzrle_counters.cache_miss_rate =
-                   (double)(xbzrle_counters.cache_miss -
-                            rs->xbzrle_cache_miss_prev) /
-                   (rs->iterations - rs->iterations_prev);
-                rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
-            }
-            rs->iterations_prev = rs->iterations;
-        }
+        migration_update_rates(rs, end_time);
+
+        rs->iterations_prev = rs->iterations;
 
         /* reset period counters */
         rs->time_last_bitmap_sync = end_time;
-- 
2.14.4
