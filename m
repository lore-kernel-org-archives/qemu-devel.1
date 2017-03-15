Received: from eggs.gnu.org ([2001:4830:134:3::10]:53604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9K8-0007Iz-2I
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9K3-0003KY-7j
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9K3-0003JJ-04
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:39 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED8E7201FB
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:50:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:49:59 +0100
Message-Id: <20170315135021.6978-10-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 09/31] ram: Move dup_pages into RAMState
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

Once there rename it to its actual meaning, zero_pages.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6cdad06..059e9f1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -159,6 +159,9 @@ struct RAMState {
     uint64_t xbzrle_cache_miss_prev;
     /* number of iterations at the beggining of period */
     uint64_t iterations_prev;
+    /* Accounting fields */
+    /* number of zero pages.  It used to be pages filled by the same char. */
+    uint64_t zero_pages;
 };
 typedef struct RAMState RAMState;
 
@@ -166,7 +169,6 @@ static RAMState ram_state;
 
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
-    uint64_t dup_pages;
     uint64_t skipped_pages;
     uint64_t norm_pages;
     uint64_t iterations;
@@ -186,12 +188,12 @@ static void acct_clear(void)
 
 uint64_t dup_mig_bytes_transferred(void)
 {
-    return acct_info.dup_pages * TARGET_PAGE_SIZE;
+    return ram_state.zero_pages * TARGET_PAGE_SIZE;
 }
 
 uint64_t dup_mig_pages_transferred(void)
 {
-    return acct_info.dup_pages;
+    return ram_state.zero_pages;
 }
 
 uint64_t skipped_mig_bytes_transferred(void)
@@ -718,13 +720,14 @@ static void migration_bitmap_sync(RAMState *rs)
  * @p: pointer to the page
  * @bytes_transferred: increase it with the number of transferred bytes
  */
-static int save_zero_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset,
+static int save_zero_page(RAMState *rs, QEMUFile *f, RAMBlock *block,
+                          ram_addr_t offset,
                           uint8_t *p, uint64_t *bytes_transferred)
 {
     int pages = -1;
 
     if (is_zero_range(p, TARGET_PAGE_SIZE)) {
-        acct_info.dup_pages++;
+        rs->zero_pages++;
         *bytes_transferred += save_page_header(f, block,
                                                offset | RAM_SAVE_FLAG_COMPRESS);
         qemu_put_byte(f, 0);
@@ -797,11 +800,11 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
             if (bytes_xmit > 0) {
                 acct_info.norm_pages++;
             } else if (bytes_xmit == 0) {
-                acct_info.dup_pages++;
+                rs->zero_pages++;
             }
         }
     } else {
-        pages = save_zero_page(f, block, offset, p, bytes_transferred);
+        pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
         if (pages > 0) {
             /* Must let xbzrle know, otherwise a previous (now 0'd) cached
              * page would be stale
@@ -973,7 +976,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
             if (bytes_xmit > 0) {
                 acct_info.norm_pages++;
             } else if (bytes_xmit == 0) {
-                acct_info.dup_pages++;
+                rs->zero_pages++;
             }
         }
     } else {
@@ -985,7 +988,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
          */
         if (block != rs->last_sent_block) {
             flush_compressed_data(f);
-            pages = save_zero_page(f, block, offset, p, bytes_transferred);
+            pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
             if (pages == -1) {
                 /* Make sure the first page is sent out before other pages */
                 bytes_xmit = save_page_header(f, block, offset |
@@ -1006,7 +1009,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
             }
         } else {
             offset |= RAM_SAVE_FLAG_CONTINUE;
-            pages = save_zero_page(f, block, offset, p, bytes_transferred);
+            pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
             if (pages == -1) {
                 pages = compress_page_with_multi_thread(f, block, offset,
                                                         bytes_transferred);
@@ -1428,7 +1431,7 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
 {
     uint64_t pages = size / TARGET_PAGE_SIZE;
     if (zero) {
-        acct_info.dup_pages += pages;
+        ram_state.zero_pages += pages;
     } else {
         acct_info.norm_pages += pages;
         bytes_transferred += size;
@@ -1941,6 +1944,7 @@ static int ram_save_init_globals(RAMState *rs)
 
     rs->dirty_rate_high_cnt = 0;
     rs->bitmap_sync_count = 0;
+    rs->zero_pages = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
-- 
2.9.3
