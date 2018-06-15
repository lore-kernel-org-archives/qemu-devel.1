Received: from eggs.gnu.org ([2001:4830:134:3::10]:48006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRu-0004HQ-R1
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRt-0000kD-Nr
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTqRt-0000jq-D7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:37 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Jun 2018 16:15:14 +0100
Message-Id: <20180615151518.83637-7-dgilbert@redhat.com>
In-Reply-To: <20180615151518.83637-1-dgilbert@redhat.com>
References: <20180615151518.83637-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 06/10] migration: introduce
 migration_update_rates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, vsementsov@virtuozzo.com, xiaoguangrong@tencent.com, bala24@linux.vnet.ibm.com

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It is used to slightly clean the code up, no logic is changed

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20180604095520.8563-5-xiaoguangrong@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d273a19699..77071a43ed 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1141,6 +1141,25 @@ uint64_t ram_pagesize_summary(void)
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
@@ -1170,9 +1189,6 @@ static void migration_bitmap_sync(RAMState *rs)
 
     /* more than 1 second = 1000 millisecons */
     if (end_time > rs->time_last_bitmap_sync + 1000) {
-        /* calculate period counters */
-        ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
-            / (end_time - rs->time_last_bitmap_sync);
         bytes_xfer_now = ram_counters.transferred;
 
         /* During block migration the auto-converge logic incorrectly detects
@@ -1194,16 +1210,9 @@ static void migration_bitmap_sync(RAMState *rs)
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
2.17.1
