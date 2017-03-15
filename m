Received: from eggs.gnu.org ([2001:4830:134:3::10]:53962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KX-0007fn-1u
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KW-0003wR-6B
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9KV-0003vH-TQ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:08 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D37FA81245
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:51:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:50:18 +0100
Message-Id: <20170315135021.6978-29-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 28/31] ram: Create ram_dirty_sync_count()
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

This is a ram field that was inside MigrationState.  Move it to
RAMState and make it the same that the other ram stats.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h | 2 +-
 migration/migration.c         | 3 +--
 migration/ram.c               | 6 +++++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index e032fb0..54a1a4f 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -171,7 +171,6 @@ struct MigrationState
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t xbzrle_cache_size;
     int64_t setup_time;
-    int64_t dirty_sync_count;
     /* Count of requests incoming from destination */
     int64_t postcopy_requests;
 
@@ -270,6 +269,7 @@ void migrate_decompress_threads_join(void);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_transferred(void);
 uint64_t ram_bytes_total(void);
+uint64_t ram_dirty_sync_count(void);
 void free_xbzrle_decoded_buf(void);
 
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
diff --git a/migration/migration.c b/migration/migration.c
index 4f19382..09d02be 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -645,7 +645,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->normal_bytes = norm_mig_pages_transferred() *
         (1ul << qemu_target_page_bits());
     info->ram->mbps = s->mbps;
-    info->ram->dirty_sync_count = s->dirty_sync_count;
+    info->ram->dirty_sync_count = ram_dirty_sync_count();
     info->ram->postcopy_requests = s->postcopy_requests;
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
@@ -1109,7 +1109,6 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->dirty_pages_rate = 0;
     s->dirty_bytes_rate = 0;
     s->setup_time = 0;
-    s->dirty_sync_count = 0;
     s->start_postcopy = false;
     s->postcopy_after_devices = false;
     s->postcopy_requests = 0;
diff --git a/migration/ram.c b/migration/ram.c
index 50ca1da..4563e3d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -249,6 +249,11 @@ uint64_t ram_bytes_remaining(void)
     return ram_state.migration_dirty_pages * TARGET_PAGE_SIZE;
 }
 
+uint64_t ram_dirty_sync_count(void)
+{
+    return ram_state.bitmap_sync_count;
+}
+
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* Current block being searched */
@@ -686,7 +691,6 @@ static void migration_bitmap_sync(RAMState *rs)
         rs->start_time = end_time;
         rs->num_dirty_pages_period = 0;
     }
-    s->dirty_sync_count = rs->bitmap_sync_count;
     if (migrate_use_events()) {
         qapi_event_send_migration_pass(rs->bitmap_sync_count, NULL);
     }
-- 
2.9.3
