Received: from eggs.gnu.org ([2001:4830:134:3::10]:33664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkf-0005c7-GB
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXke-0005Lo-9U
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIXke-0005Lf-0T
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC063DC8F5
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 09:59:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Jun 2017 11:59:25 +0200
Message-Id: <20170607095926.1834-7-quintela@redhat.com>
In-Reply-To: <20170607095926.1834-1-quintela@redhat.com>
References: <20170607095926.1834-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] ram: Make RAMState dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We create the variable while we are at migration and we remove it
after migration.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 58 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index cd6a121..9ffd0a5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -204,11 +204,11 @@ struct RAMState {
 };
 typedef struct RAMState RAMState;
 
-static RAMState ram_state;
+static RAMState *ram_state;
 
 uint64_t ram_bytes_remaining(void)
 {
-    return ram_state.migration_dirty_pages * TARGET_PAGE_SIZE;
+    return ram_state->migration_dirty_pages * TARGET_PAGE_SIZE;
 }
 
 MigrationStats ram_counters;
@@ -793,7 +793,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
                                 ram_addr_t offset)
 {
-    RAMState *rs = &ram_state;
+    RAMState *rs = ram_state;
     int bytes_sent, blen;
     uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
 
@@ -1140,7 +1140,7 @@ static void migration_page_queue_free(RAMState *rs)
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
 {
     RAMBlock *ramblock;
-    RAMState *rs = &ram_state;
+    RAMState *rs = ram_state;
 
     ram_counters.postcopy_requests++;
     rcu_read_lock();
@@ -1361,7 +1361,7 @@ void free_xbzrle_decoded_buf(void)
 
 static void ram_migration_cleanup(void *opaque)
 {
-    RAMState *rs = opaque;
+    RAMState **rsp = opaque;
     RAMBlock *block;
 
     /* caller have hold iothread lock or is in a bh, so there is
@@ -1388,7 +1388,9 @@ static void ram_migration_cleanup(void *opaque)
         XBZRLE.zero_target_page = NULL;
     }
     XBZRLE_cache_unlock();
-    migration_page_queue_free(rs);
+    migration_page_queue_free(*rsp);
+    g_free(*rsp);
+    *rsp = NULL;
 }
 
 static void ram_state_reset(RAMState *rs)
@@ -1559,7 +1561,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
                                           RAMBlock *block,
                                           PostcopyDiscardState *pds)
 {
-    RAMState *rs = &ram_state;
+    RAMState *rs = ram_state;
     unsigned long *bitmap = block->bmap;
     unsigned long *unsentmap = block->unsentmap;
     unsigned int host_ratio = block->page_size / TARGET_PAGE_SIZE;
@@ -1714,7 +1716,7 @@ static int postcopy_chunk_hostpages(MigrationState *ms, RAMBlock *block)
  */
 int ram_postcopy_send_discard_bitmap(MigrationState *ms)
 {
-    RAMState *rs = &ram_state;
+    RAMState *rs = ram_state;
     RAMBlock *block;
     int ret;
 
@@ -1797,12 +1799,13 @@ err:
     return ret;
 }
 
-static int ram_state_init(RAMState *rs)
+static int ram_state_init(RAMState **rsp)
 {
-    memset(rs, 0, sizeof(*rs));
-    qemu_mutex_init(&rs->bitmap_mutex);
-    qemu_mutex_init(&rs->src_page_req_mutex);
-    QSIMPLEQ_INIT(&rs->src_page_requests);
+    *rsp = g_new0(RAMState, 1);
+
+    qemu_mutex_init(&(*rsp)->bitmap_mutex);
+    qemu_mutex_init(&(*rsp)->src_page_req_mutex);
+    QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
 
     if (migrate_use_xbzrle()) {
         XBZRLE_cache_lock();
@@ -1813,6 +1816,8 @@ static int ram_state_init(RAMState *rs)
         if (!XBZRLE.cache) {
             XBZRLE_cache_unlock();
             error_report("Error creating cache");
+            g_free(*rsp);
+            *rsp = NULL;
             return -1;
         }
         XBZRLE_cache_unlock();
@@ -1821,6 +1826,8 @@ static int ram_state_init(RAMState *rs)
         XBZRLE.encoded_buf = g_try_malloc0(TARGET_PAGE_SIZE);
         if (!XBZRLE.encoded_buf) {
             error_report("Error allocating encoded_buf");
+            g_free(*rsp);
+            *rsp = NULL;
             return -1;
         }
 
@@ -1829,6 +1836,8 @@ static int ram_state_init(RAMState *rs)
             error_report("Error allocating current_buf");
             g_free(XBZRLE.encoded_buf);
             XBZRLE.encoded_buf = NULL;
+            g_free(*rsp);
+            *rsp = NULL;
             return -1;
         }
     }
@@ -1838,7 +1847,7 @@ static int ram_state_init(RAMState *rs)
 
     qemu_mutex_lock_ramlist();
     rcu_read_lock();
-    ram_state_reset(rs);
+    ram_state_reset(*rsp);
 
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
@@ -1860,10 +1869,10 @@ static int ram_state_init(RAMState *rs)
      * Count the total number of pages used by ram blocks not including any
      * gaps due to alignment or unplugs.
      */
-    rs->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
+    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
 
     memory_global_dirty_log_start();
-    migration_bitmap_sync(rs);
+    migration_bitmap_sync(*rsp);
     qemu_mutex_unlock_ramlist();
     qemu_mutex_unlock_iothread();
     rcu_read_unlock();
@@ -1888,16 +1897,16 @@ static int ram_state_init(RAMState *rs)
  */
 static int ram_save_setup(QEMUFile *f, void *opaque)
 {
-    RAMState *rs = opaque;
+    RAMState **rsp = opaque;
     RAMBlock *block;
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
-        if (ram_state_init(rs) < 0) {
+        if (ram_state_init(rsp) != 0) {
             return -1;
-         }
+        }
     }
-    rs->f = f;
+    (*rsp)->f = f;
 
     rcu_read_lock();
 
@@ -1932,7 +1941,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
  */
 static int ram_save_iterate(QEMUFile *f, void *opaque)
 {
-    RAMState *rs = opaque;
+    RAMState **temp = opaque;
+    RAMState *rs = *temp;
     int ret;
     int i;
     int64_t t0;
@@ -2007,7 +2017,8 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
  */
 static int ram_save_complete(QEMUFile *f, void *opaque)
 {
-    RAMState *rs = opaque;
+    RAMState **temp = opaque;
+    RAMState *rs = *temp;
 
     rcu_read_lock();
 
@@ -2044,7 +2055,8 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
                              uint64_t *non_postcopiable_pending,
                              uint64_t *postcopiable_pending)
 {
-    RAMState *rs = opaque;
+    RAMState **temp = opaque;
+    RAMState *rs = *temp;
     uint64_t remaining_size;
 
     remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
-- 
2.9.4
