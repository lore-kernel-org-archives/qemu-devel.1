Received: from eggs.gnu.org ([2001:4830:134:3::10]:53553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9K2-0007Cl-EB
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9K1-0003I8-KS
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9K1-0003HB-Ff
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:37 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7972BC04FF86
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:50:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:49:58 +0100
Message-Id: <20170315135021.6978-9-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 08/31] ram: Move iterations_prev into RAMState
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
 migration/ram.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ae077c5..6cdad06 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -157,6 +157,8 @@ struct RAMState {
     int64_t num_dirty_pages_period;
     /* xbzrle misses since the beggining of the period */
     uint64_t xbzrle_cache_miss_prev;
+    /* number of iterations at the beggining of period */
+    uint64_t iterations_prev;
 };
 typedef struct RAMState RAMState;
 
@@ -602,16 +604,13 @@ static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
         cpu_physical_memory_sync_dirty_bitmap(bitmap, start, length);
 }
 
-/* Fix me: there are too many global variables used in migration process. */
-static uint64_t iterations_prev;
-
 static void migration_bitmap_sync_init(RAMState *rs)
 {
     rs->start_time = 0;
     rs->bytes_xfer_prev = 0;
     rs->num_dirty_pages_period = 0;
     rs->xbzrle_cache_miss_prev = 0;
-    iterations_prev = 0;
+    rs->iterations_prev = 0;
 }
 
 /* Returns a summary bitmap of the page sizes of all RAMBlocks;
@@ -687,13 +686,13 @@ static void migration_bitmap_sync(RAMState *rs)
         }
 
         if (migrate_use_xbzrle()) {
-            if (iterations_prev != acct_info.iterations) {
+            if (rs->iterations_prev != acct_info.iterations) {
                 acct_info.xbzrle_cache_miss_rate =
                    (double)(acct_info.xbzrle_cache_miss -
                             rs->xbzrle_cache_miss_prev) /
-                   (acct_info.iterations - iterations_prev);
+                   (acct_info.iterations - rs->iterations_prev);
             }
-            iterations_prev = acct_info.iterations;
+            rs->iterations_prev = acct_info.iterations;
             rs->xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
         }
         s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
-- 
2.9.3
