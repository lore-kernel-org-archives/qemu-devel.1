Received: from eggs.gnu.org ([2001:4830:134:3::10]:53976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KY-0007hc-Jl
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KX-0003y4-Tf
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9KX-0003xH-Cl
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:09 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5769064473
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:51:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:50:19 +0100
Message-Id: <20170315135021.6978-30-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 29/31] ram: Remove dirty_bytes_rate
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

It can be recalculated from dirty_pages_rate.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h | 1 -
 migration/migration.c         | 5 ++---
 migration/ram.c               | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 54a1a4f..42b9edf 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -167,7 +167,6 @@ struct MigrationState
     int64_t downtime;
     int64_t expected_downtime;
     int64_t dirty_pages_rate;
-    int64_t dirty_bytes_rate;
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t xbzrle_cache_size;
     int64_t setup_time;
diff --git a/migration/migration.c b/migration/migration.c
index 09d02be..2f8c440 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1107,7 +1107,6 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->downtime = 0;
     s->expected_downtime = 0;
     s->dirty_pages_rate = 0;
-    s->dirty_bytes_rate = 0;
     s->setup_time = 0;
     s->start_postcopy = false;
     s->postcopy_after_devices = false;
@@ -1999,8 +1998,8 @@ static void *migration_thread(void *opaque)
                                       bandwidth, max_size);
             /* if we haven't sent anything, we don't want to recalculate
                10000 is a small enough number for our purposes */
-            if (s->dirty_bytes_rate && transferred_bytes > 10000) {
-                s->expected_downtime = s->dirty_bytes_rate / bandwidth;
+            if (s->dirty_pages_rate && transferred_bytes > 10000) {
+                s->expected_downtime = s->dirty_pages_rate * (1ul << qemu_target_page_bits())/ bandwidth;
             }
 
             qemu_file_reset_rate_limit(s->to_dst_file);
diff --git a/migration/ram.c b/migration/ram.c
index 4563e3d..1006e60 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -687,7 +687,6 @@ static void migration_bitmap_sync(RAMState *rs)
         }
         s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
             / (end_time - rs->start_time);
-        s->dirty_bytes_rate = s->dirty_pages_rate * TARGET_PAGE_SIZE;
         rs->start_time = end_time;
         rs->num_dirty_pages_period = 0;
     }
-- 
2.9.3
