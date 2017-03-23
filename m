Received: from eggs.gnu.org ([2001:4830:134:3::10]:45356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cX-0007mE-BM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cU-0000Al-Mg
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cU-0000AK-EU
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DC53C0467F1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:04 +0100
Message-Id: <20170323204544.12015-12-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 11/51] ram: Move dup_pages into RAMState
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

Once there rename it to its actual meaning, zero_pages.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d8428c1..0da133f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -165,6 +165,9 @@ struct RAMState {
     uint64_t xbzrle_cache_miss_prev;
     /* number of iterations at the beginning of period */
     uint64_t iterations_prev;
+    /* Accounting fields */
+    /* number of zero pages.  It used to be pages filled by the same char. */
+    uint64_t zero_pages;
 };
 typedef struct RAMState RAMState;
 
@@ -172,7 +175,6 @@ static RAMState ram_state;
 
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
-    uint64_t dup_pages;
     uint64_t skipped_pages;
     uint64_t norm_pages;
     uint64_t iterations;
@@ -192,12 +194,12 @@ static void acct_clear(void)
 
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
@@ -737,19 +739,21 @@ static void migration_bitmap_sync(RAMState *rs)
  *
  * Returns the number of pages written.
  *
+ * @rs: current RAM state
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
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
@@ -822,11 +826,11 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
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
@@ -998,7 +1002,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
             if (bytes_xmit > 0) {
                 acct_info.norm_pages++;
             } else if (bytes_xmit == 0) {
-                acct_info.dup_pages++;
+                rs->zero_pages++;
             }
         }
     } else {
@@ -1010,7 +1014,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
          */
         if (block != rs->last_sent_block) {
             flush_compressed_data(f);
-            pages = save_zero_page(f, block, offset, p, bytes_transferred);
+            pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
             if (pages == -1) {
                 /* Make sure the first page is sent out before other pages */
                 bytes_xmit = save_page_header(f, block, offset |
@@ -1031,7 +1035,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
             }
         } else {
             offset |= RAM_SAVE_FLAG_CONTINUE;
-            pages = save_zero_page(f, block, offset, p, bytes_transferred);
+            pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
             if (pages == -1) {
                 pages = compress_page_with_multi_thread(f, block, offset,
                                                         bytes_transferred);
@@ -1462,8 +1466,10 @@ static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage,
 void acct_update_position(QEMUFile *f, size_t size, bool zero)
 {
     uint64_t pages = size / TARGET_PAGE_SIZE;
+    RAMState *rs = &ram_state;
+
     if (zero) {
-        acct_info.dup_pages += pages;
+        rs->zero_pages += pages;
     } else {
         acct_info.norm_pages += pages;
         bytes_transferred += size;
@@ -2005,6 +2011,7 @@ static int ram_save_init_globals(RAMState *rs)
 
     rs->dirty_rate_high_cnt = 0;
     rs->bitmap_sync_count = 0;
+    rs->zero_pages = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
-- 
2.9.3
