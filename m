Received: from eggs.gnu.org ([2001:4830:134:3::10]:45248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cO-0007eP-L1
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cN-00007m-Rj
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cN-00007T-Lr
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:45:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7A63624CD
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:45:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:00 +0100
Message-Id: <20170323204544.12015-8-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 07/51] ram: Move bytes_xfer_prev into RAMState
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
---
 migration/ram.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5881805..5e53b47 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -157,6 +157,8 @@ struct RAMState {
     /* this variables are used for bitmap sync */
     /* last time we did a full bitmap_sync */
     int64_t start_time;
+    /* bytes transferred at start_time */
+    int64_t bytes_xfer_prev;
 };
 typedef struct RAMState RAMState;
 
@@ -620,14 +622,13 @@ static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
 }
 
 /* Fix me: there are too many global variables used in migration process. */
-static int64_t bytes_xfer_prev;
 static uint64_t xbzrle_cache_miss_prev;
 static uint64_t iterations_prev;
 
 static void migration_bitmap_sync_init(RAMState *rs)
 {
     rs->start_time = 0;
-    bytes_xfer_prev = 0;
+    rs->bytes_xfer_prev = 0;
     num_dirty_pages_period = 0;
     xbzrle_cache_miss_prev = 0;
     iterations_prev = 0;
@@ -663,8 +664,8 @@ static void migration_bitmap_sync(RAMState *rs)
 
     rs->bitmap_sync_count++;
 
-    if (!bytes_xfer_prev) {
-        bytes_xfer_prev = ram_bytes_transferred();
+    if (!rs->bytes_xfer_prev) {
+        rs->bytes_xfer_prev = ram_bytes_transferred();
     }
 
     if (!rs->start_time) {
@@ -698,13 +699,13 @@ static void migration_bitmap_sync(RAMState *rs)
 
             if (s->dirty_pages_rate &&
                (num_dirty_pages_period * TARGET_PAGE_SIZE >
-                   (bytes_xfer_now - bytes_xfer_prev)/2) &&
+                   (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
                (rs->dirty_rate_high_cnt++ >= 2)) {
                     trace_migration_throttle();
                     rs->dirty_rate_high_cnt = 0;
                     mig_throttle_guest_down();
              }
-             bytes_xfer_prev = bytes_xfer_now;
+             rs->bytes_xfer_prev = bytes_xfer_now;
         }
 
         if (migrate_use_xbzrle()) {
-- 
2.9.3
