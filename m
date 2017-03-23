Received: from eggs.gnu.org ([2001:4830:134:3::10]:45803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9d2-0008E8-0g
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9d0-0000XZ-Qe
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9d0-0000Wa-IZ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AEDA80474
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:27 +0100
Message-Id: <20170323204544.12015-35-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 34/51] ram: Move postcopy_requests into RAMState
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
 include/migration/migration.h |  6 ++----
 migration/migration.c         |  5 ++---
 migration/ram.c               | 13 +++++++++----
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index ffa7944..e88bbaf 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -157,8 +157,6 @@ struct MigrationState
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t xbzrle_cache_size;
     int64_t setup_time;
-    /* Count of requests incoming from destination */
-    int64_t postcopy_requests;
 
     /* Flag set once the migration has been asked to enter postcopy */
     bool start_postcopy;
@@ -254,6 +252,7 @@ uint64_t ram_bytes_transferred(void);
 uint64_t ram_bytes_total(void);
 uint64_t ram_dirty_sync_count(void);
 uint64_t ram_dirty_pages_rate(void);
+uint64_t ram_postcopy_requests(void);
 void free_xbzrle_decoded_buf(void);
 
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
@@ -356,8 +355,7 @@ int global_state_store(void);
 void global_state_store_running(void);
 
 void flush_page_queue(void);
-int ram_save_queue_pages(MigrationState *ms, const char *rbname,
-                         ram_addr_t start, ram_addr_t len);
+int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
 uint64_t ram_pagesize_summary(void);
 
 PostcopyState postcopy_state_get(void);
diff --git a/migration/migration.c b/migration/migration.c
index d2d9b91..ad4ea03 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -649,7 +649,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         (1ul << qemu_target_page_bits());
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count = ram_dirty_sync_count();
-    info->ram->postcopy_requests = s->postcopy_requests;
+    info->ram->postcopy_requests = ram_postcopy_requests();
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
@@ -1112,7 +1112,6 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->setup_time = 0;
     s->start_postcopy = false;
     s->postcopy_after_devices = false;
-    s->postcopy_requests = 0;
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
@@ -1472,7 +1471,7 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
         return;
     }
 
-    if (ram_save_queue_pages(ms, rbname, start, len)) {
+    if (ram_save_queue_pages(rbname, start, len)) {
         mark_source_rp_bad(ms);
     }
 }
diff --git a/migration/ram.c b/migration/ram.c
index 6cb1435..c0d6841 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -213,6 +213,8 @@ struct RAMState {
     uint64_t bytes_transferred;
     /* number of dirtied pages in the last second */
     uint64_t dirty_pages_rate;
+    /* Count of requests incoming from destination */
+    uint64_t postcopy_requests;
     /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
     /* Ram Bitmap protected by RCU */
@@ -282,6 +284,11 @@ uint64_t ram_dirty_pages_rate(void)
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
@@ -1237,19 +1244,17 @@ void flush_page_queue(void)
  *
  * Returns zero on success or negative on error
  *
- * @ms: current migration state
  * @rbname: Name of the RAMBLock of the request. NULL means the
  *          same that last one.
  * @start: starting address from the start of the RAMBlock
  * @len: length (in bytes) to send
  */
-int ram_save_queue_pages(MigrationState *ms, const char *rbname,
-                         ram_addr_t start, ram_addr_t len)
+int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
 {
     RAMBlock *ramblock;
     RAMState *rs = &ram_state;
 
-    ms->postcopy_requests++;
+    rs->postcopy_requests++;
     rcu_read_lock();
     if (!rbname) {
         /* Reuse last RAMBlock */
-- 
2.9.3
