Received: from eggs.gnu.org ([2001:4830:134:3::10]:45246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XCE-0002gV-0Q
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XCA-0007Xz-3I
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XC9-0007Xc-Sv
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC2568E697
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:57:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:16 +0200
Message-Id: <20170421115646.15544-36-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 35/65] ram: Remove dirty_bytes_rate
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
