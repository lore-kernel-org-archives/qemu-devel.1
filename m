Received: from eggs.gnu.org ([2001:4830:134:3::10]:44183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wi9-0004J4-6A
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wi8-0007DZ-E5
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0wi8-0007DG-73
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E23BAC05491A
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:58:59 +0200
Message-Id: <20170419205923.8808-36-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 35/59] ram: Remove dirty_bytes_rate
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

It can be recalculated from dirty_pages_rate.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>

--

Dave was the one that reviewed it O:-)

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h | 1 -
 migration/migration.c         | 6 +++---
 migration/ram.c               | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 2f9c973..e185d13 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -155,7 +155,6 @@ struct MigrationState
     int64_t downtime;
     int64_t expected_downtime;
     int64_t dirty_pages_rate;
-    int64_t dirty_bytes_rate;
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t xbzrle_cache_size;
     int64_t setup_time;
diff --git a/migration/migration.c b/migration/migration.c
index 94647a8..dcf9b94 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1118,7 +1118,6 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->downtime = 0;
     s->expected_downtime = 0;
     s->dirty_pages_rate = 0;
-    s->dirty_bytes_rate = 0;
     s->setup_time = 0;
     s->start_postcopy = false;
     s->postcopy_after_devices = false;
@@ -2008,8 +2007,9 @@ static void *migration_thread(void *opaque)
                                       bandwidth, max_size);
             /* if we haven't sent anything, we don't want to recalculate
                10000 is a small enough number for our purposes */
-            if (s->dirty_bytes_rate && transferred_bytes > 10000) {
-                s->expected_downtime = s->dirty_bytes_rate / bandwidth;
+            if (s->dirty_pages_rate && transferred_bytes > 10000) {
+                s->expected_downtime = s->dirty_pages_rate *
+                    (1ul << qemu_target_page_bits()) / bandwidth;
             }
 
             qemu_file_reset_rate_limit(s->to_dst_file);
diff --git a/migration/ram.c b/migration/ram.c
index 1580617..ef4f508 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -728,7 +728,6 @@ static void migration_bitmap_sync(RAMState *rs)
         }
         s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
             / (end_time - rs->time_last_bitmap_sync);
-        s->dirty_bytes_rate = s->dirty_pages_rate * TARGET_PAGE_SIZE;
         rs->time_last_bitmap_sync = end_time;
         rs->num_dirty_pages_period = 0;
     }
-- 
2.9.3
