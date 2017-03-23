Received: from eggs.gnu.org ([2001:4830:134:3::10]:45428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cc-0007qg-18
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cb-0000Gh-3o
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9ca-0000GG-UT
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED05E3B713
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:09 +0100
Message-Id: <20170323204544.12015-17-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 16/51] ram: Move iterations into RAMState
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
---
 migration/ram.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 9fa3bd7..690ca8f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -170,6 +170,8 @@ struct RAMState {
     uint64_t zero_pages;
     /* number of normal transferred pages */
     uint64_t norm_pages;
+    /* Iterations since start */
+    uint64_t iterations;
 };
 typedef struct RAMState RAMState;
 
@@ -177,7 +179,6 @@ static RAMState ram_state;
 
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
-    uint64_t iterations;
     uint64_t xbzrle_bytes;
     uint64_t xbzrle_pages;
     uint64_t xbzrle_cache_miss;
@@ -693,13 +694,13 @@ static void migration_bitmap_sync(RAMState *rs)
         }
 
         if (migrate_use_xbzrle()) {
-            if (rs->iterations_prev != acct_info.iterations) {
+            if (rs->iterations_prev != rs->iterations) {
                 acct_info.xbzrle_cache_miss_rate =
                    (double)(acct_info.xbzrle_cache_miss -
                             rs->xbzrle_cache_miss_prev) /
-                   (acct_info.iterations - rs->iterations_prev);
+                   (rs->iterations - rs->iterations_prev);
             }
-            rs->iterations_prev = acct_info.iterations;
+            rs->iterations_prev = rs->iterations;
             rs->xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
         }
         s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
@@ -1993,6 +1994,7 @@ static int ram_save_init_globals(RAMState *rs)
     rs->bitmap_sync_count = 0;
     rs->zero_pages = 0;
     rs->norm_pages = 0;
+    rs->iterations = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
@@ -2150,7 +2152,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
             done = 1;
             break;
         }
-        acct_info.iterations++;
+        rs->iterations++;
 
         /* we want to check in the 1st loop, just in case it was the 1st time
            and we had to sync the dirty bitmap.
-- 
2.9.3
