Received: from eggs.gnu.org ([2001:4830:134:3::10]:54025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9Kf-0007nv-AL
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9Ka-000415-NG
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9Ka-0003zq-FE
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:51:12 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E1F5C05AA61
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:51:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:50:21 +0100
Message-Id: <20170315135021.6978-32-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 31/31] ram: move postcopy_requests into RAMState
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
 include/migration/migration.h | 3 +--
 migration/migration.c         | 3 +--
 migration/ram.c               | 9 ++++++++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 43bdf86..bc48a8e 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -169,8 +169,6 @@ struct MigrationState
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t xbzrle_cache_size;
     int64_t setup_time;
-    /* Count of requests incoming from destination */
-    int64_t postcopy_requests;
 
     /* Flag set once the migration has been asked to enter postcopy */
     bool start_postcopy;
@@ -269,6 +267,7 @@ uint64_t ram_bytes_transferred(void);
 uint64_t ram_bytes_total(void);
 uint64_t ram_dirty_sync_count(void);
 uint64_t ram_dirty_pages_rate(void);
+uint64_t ram_postcopy_requests(void);
 void free_xbzrle_decoded_buf(void);
 
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
diff --git a/migration/migration.c b/migration/migration.c
index 0a70d55..0df6111 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -646,7 +646,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         (1ul << qemu_target_page_bits());
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count = ram_dirty_sync_count();
-    info->ram->postcopy_requests = s->postcopy_requests;
+    info->ram->postcopy_requests = ram_postcopy_requests();
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
@@ -1109,7 +1109,6 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->setup_time = 0;
     s->start_postcopy = false;
     s->postcopy_after_devices = false;
-    s->postcopy_requests = 0;
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
diff --git a/migration/ram.c b/migration/ram.c
index b85f58f..91f9fb5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -195,6 +195,8 @@ struct RAMState {
     uint64_t bytes_transferred;
     /* number of dirtied pages in the last second */
     uint64_t dirty_pages_rate;
+    /* Count of requests incoming from destination */
+    uint64_t postcopy_requests;
     /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
     /* Ram Bitmap protected by RCU */
@@ -261,6 +263,11 @@ uint64_t ram_dirty_pages_rate(void)
     return ram_state.dirty_pages_rate;
 }
 
+uint64_t ram_postcopy_requests(void)
+{
+    return ram_state.postcopy_requests;
+}
+
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* Current block being searched */
@@ -1197,7 +1204,7 @@ int ram_save_queue_pages(MigrationState *ms, const char *rbname,
 {
     RAMBlock *ramblock;
 
-    ms->postcopy_requests++;
+    ram_state.postcopy_requests++;
     rcu_read_lock();
     if (!rbname) {
         /* Reuse last RAMBlock */
-- 
2.9.3
