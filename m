Received: from eggs.gnu.org ([2001:4830:134:3::10]:45744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cz-0008CZ-0m
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cy-0000VS-4N
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cx-0000VJ-Ua
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA69F83F47
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:25 +0100
Message-Id: <20170323204544.12015-33-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 32/51] ram: Remove dirty_bytes_rate
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
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h | 1 -
 migration/migration.c         | 6 +++---
 migration/ram.c               | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 768fa72..0d5d5fc 100644
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
index 983c3d9..4af934b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1110,7 +1110,6 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->downtime = 0;
     s->expected_downtime = 0;
     s->dirty_pages_rate = 0;
-    s->dirty_bytes_rate = 0;
     s->setup_time = 0;
     s->start_postcopy = false;
     s->postcopy_after_devices = false;
@@ -2000,8 +1999,9 @@ static void *migration_thread(void *opaque)
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
index 98095ea..c66c308 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -727,7 +727,6 @@ static void migration_bitmap_sync(RAMState *rs)
         }
         s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
             / (end_time - rs->start_time);
-        s->dirty_bytes_rate = s->dirty_pages_rate * TARGET_PAGE_SIZE;
         rs->start_time = end_time;
         rs->num_dirty_pages_period = 0;
     }
-- 
2.9.3
