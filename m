Received: from eggs.gnu.org ([2001:4830:134:3::10]:53455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9Jx-000797-6H
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9Jv-0003E0-Lw
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9Jv-0003Dk-D5
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:31 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6056AC05AA65
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:50:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:49:54 +0100
Message-Id: <20170315135021.6978-5-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 04/31] ram: Move start time into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c0bee94..f6ac503 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -148,6 +148,9 @@ struct RAMState {
     int dirty_rate_high_cnt;
     /* How many times we have synchronized the bitmap */
     uint64_t bitmap_sync_count;
+    /* this variables are used for bitmap sync */
+    /* last time we did a full bitmap_sync */
+    int64_t start_time;
 };
 typedef struct RAMState RAMState;
 
@@ -594,15 +597,14 @@ static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
 }
 
 /* Fix me: there are too many global variables used in migration process. */
-static int64_t start_time;
 static int64_t bytes_xfer_prev;
 static int64_t num_dirty_pages_period;
 static uint64_t xbzrle_cache_miss_prev;
 static uint64_t iterations_prev;
 
-static void migration_bitmap_sync_init(void)
+static void migration_bitmap_sync_init(RAMState *rs)
 {
-    start_time = 0;
+    rs->start_time = 0;
     bytes_xfer_prev = 0;
     num_dirty_pages_period = 0;
     xbzrle_cache_miss_prev = 0;
@@ -640,8 +642,8 @@ static void migration_bitmap_sync(RAMState *rs)
         bytes_xfer_prev = ram_bytes_transferred();
     }
 
-    if (!start_time) {
-        start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    if (!rs->start_time) {
+        rs->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     }
 
     trace_migration_bitmap_sync_start();
@@ -661,7 +663,7 @@ static void migration_bitmap_sync(RAMState *rs)
     end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 
     /* more than 1 second = 1000 millisecons */
-    if (end_time > start_time + 1000) {
+    if (end_time > rs->start_time + 1000) {
         if (migrate_auto_converge()) {
             /* The following detection logic can be refined later. For now:
                Check to see if the dirtied bytes is 50% more than the approx.
@@ -692,9 +694,9 @@ static void migration_bitmap_sync(RAMState *rs)
             xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
         }
         s->dirty_pages_rate = num_dirty_pages_period * 1000
-            / (end_time - start_time);
+            / (end_time - rs->start_time);
         s->dirty_bytes_rate = s->dirty_pages_rate * TARGET_PAGE_SIZE;
-        start_time = end_time;
+        rs->start_time = end_time;
         num_dirty_pages_period = 0;
     }
     s->dirty_sync_count = rs->bitmap_sync_count;
@@ -1937,7 +1939,7 @@ static int ram_save_init_globals(RAMState *rs)
 
     rs->dirty_rate_high_cnt = 0;
     rs->bitmap_sync_count = 0;
-    migration_bitmap_sync_init();
+    migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
     if (migrate_use_xbzrle()) {
-- 
2.9.3
