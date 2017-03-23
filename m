Received: from eggs.gnu.org ([2001:4830:134:3::10]:45777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9d0-0008DA-L1
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cz-0000WQ-G4
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cz-0000Vg-7u
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 407C2624CF
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:26 +0100
Message-Id: <20170323204544.12015-34-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 33/51] ram: Move dirty_pages_rate to RAMState
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

Treat it like the rest of ram stats counters.  Export its value the
same way.  As an added bonus, no more MigrationState used in
migration_bitmap_sync();

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  2 +-
 migration/migration.c         |  7 +++----
 migration/ram.c               | 12 +++++++++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 0d5d5fc..ffa7944 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -154,7 +154,6 @@ struct MigrationState
     int64_t total_time;
     int64_t downtime;
     int64_t expected_downtime;
-    int64_t dirty_pages_rate;
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t xbzrle_cache_size;
     int64_t setup_time;
@@ -254,6 +253,7 @@ uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_transferred(void);
 uint64_t ram_bytes_total(void);
 uint64_t ram_dirty_sync_count(void);
+uint64_t ram_dirty_pages_rate(void);
 void free_xbzrle_decoded_buf(void);
 
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
diff --git a/migration/migration.c b/migration/migration.c
index 4af934b..d2d9b91 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -653,7 +653,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
-        info->ram->dirty_pages_rate = s->dirty_pages_rate;
+        info->ram->dirty_pages_rate = ram_dirty_pages_rate();
     }
 }
 
@@ -1109,7 +1109,6 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->mbps = 0.0;
     s->downtime = 0;
     s->expected_downtime = 0;
-    s->dirty_pages_rate = 0;
     s->setup_time = 0;
     s->start_postcopy = false;
     s->postcopy_after_devices = false;
@@ -1999,8 +1998,8 @@ static void *migration_thread(void *opaque)
                                       bandwidth, max_size);
             /* if we haven't sent anything, we don't want to recalculate
                10000 is a small enough number for our purposes */
-            if (s->dirty_pages_rate && transferred_bytes > 10000) {
-                s->expected_downtime = s->dirty_pages_rate *
+            if (ram_dirty_pages_rate() && transferred_bytes > 10000) {
+                s->expected_downtime = ram_dirty_pages_rate() *
                     (1ul << qemu_target_page_bits()) / bandwidth;
             }
 
diff --git a/migration/ram.c b/migration/ram.c
index c66c308..6cb1435 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -211,6 +211,8 @@ struct RAMState {
     uint64_t migration_dirty_pages;
     /* total number of bytes transferred */
     uint64_t bytes_transferred;
+    /* number of dirtied pages in the last second */
+    uint64_t dirty_pages_rate;
     /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
     /* Ram Bitmap protected by RCU */
@@ -275,6 +277,11 @@ uint64_t ram_dirty_sync_count(void)
     return ram_state.bitmap_sync_count;
 }
 
+uint64_t ram_dirty_pages_rate(void)
+{
+    return ram_state.dirty_pages_rate;
+}
+
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* Current block being searched */
@@ -665,7 +672,6 @@ uint64_t ram_pagesize_summary(void)
 static void migration_bitmap_sync(RAMState *rs)
 {
     RAMBlock *block;
-    MigrationState *s = migrate_get_current();
     int64_t end_time;
     int64_t bytes_xfer_now;
 
@@ -704,7 +710,7 @@ static void migration_bitmap_sync(RAMState *rs)
                throttling */
             bytes_xfer_now = ram_bytes_transferred();
 
-            if (s->dirty_pages_rate &&
+            if (rs->dirty_pages_rate &&
                (rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
                    (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
                (rs->dirty_rate_high_cnt++ >= 2)) {
@@ -725,7 +731,7 @@ static void migration_bitmap_sync(RAMState *rs)
             rs->iterations_prev = rs->iterations;
             rs->xbzrle_cache_miss_prev = rs->xbzrle_cache_miss;
         }
-        s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
+        rs->dirty_pages_rate = rs->num_dirty_pages_period * 1000
             / (end_time - rs->start_time);
         rs->start_time = end_time;
         rs->num_dirty_pages_period = 0;
-- 
2.9.3
