Received: from eggs.gnu.org ([2001:4830:134:3::10]:45394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cZ-0007oI-NW
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9cY-0000EZ-Jp
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9cY-0000DX-BX
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51DCC7E9E1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:07 +0100
Message-Id: <20170323204544.12015-15-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 14/51] ram: Move norm_pages to RAMState
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 57f5858..2c36729 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -168,6 +168,8 @@ struct RAMState {
     /* Accounting fields */
     /* number of zero pages.  It used to be pages filled by the same char. */
     uint64_t zero_pages;
+    /* number of normal transferred pages */
+    uint64_t norm_pages;
 };
 typedef struct RAMState RAMState;
 
@@ -175,7 +177,6 @@ static RAMState ram_state;
 
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
-    uint64_t norm_pages;
     uint64_t iterations;
     uint64_t xbzrle_bytes;
     uint64_t xbzrle_pages;
@@ -198,12 +199,12 @@ uint64_t dup_mig_pages_transferred(void)
 
 uint64_t norm_mig_bytes_transferred(void)
 {
-    return acct_info.norm_pages * TARGET_PAGE_SIZE;
+    return ram_state.norm_pages * TARGET_PAGE_SIZE;
 }
 
 uint64_t norm_mig_pages_transferred(void)
 {
-    return acct_info.norm_pages;
+    return ram_state.norm_pages;
 }
 
 uint64_t xbzrle_mig_bytes_transferred(void)
@@ -808,7 +809,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
     if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
         if (ret != RAM_SAVE_CONTROL_DELAYED) {
             if (bytes_xmit > 0) {
-                acct_info.norm_pages++;
+                rs->norm_pages++;
             } else if (bytes_xmit == 0) {
                 rs->zero_pages++;
             }
@@ -847,7 +848,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
         }
         *bytes_transferred += TARGET_PAGE_SIZE;
         pages = 1;
-        acct_info.norm_pages++;
+        rs->norm_pages++;
     }
 
     XBZRLE_cache_unlock();
@@ -914,8 +915,8 @@ static inline void set_compress_params(CompressParam *param, RAMBlock *block,
     param->offset = offset;
 }
 
-static int compress_page_with_multi_thread(QEMUFile *f, RAMBlock *block,
-                                           ram_addr_t offset,
+static int compress_page_with_multi_thread(RAMState *rs, QEMUFile *f,
+                                           RAMBlock *block, ram_addr_t offset,
                                            uint64_t *bytes_transferred)
 {
     int idx, thread_count, bytes_xmit = -1, pages = -1;
@@ -932,7 +933,7 @@ static int compress_page_with_multi_thread(QEMUFile *f, RAMBlock *block,
                 qemu_cond_signal(&comp_param[idx].cond);
                 qemu_mutex_unlock(&comp_param[idx].mutex);
                 pages = 1;
-                acct_info.norm_pages++;
+                rs->norm_pages++;
                 *bytes_transferred += bytes_xmit;
                 break;
             }
@@ -984,7 +985,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
     if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
         if (ret != RAM_SAVE_CONTROL_DELAYED) {
             if (bytes_xmit > 0) {
-                acct_info.norm_pages++;
+                rs->norm_pages++;
             } else if (bytes_xmit == 0) {
                 rs->zero_pages++;
             }
@@ -1007,7 +1008,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
                                                  migrate_compress_level());
                 if (blen > 0) {
                     *bytes_transferred += bytes_xmit + blen;
-                    acct_info.norm_pages++;
+                    rs->norm_pages++;
                     pages = 1;
                 } else {
                     qemu_file_set_error(f, blen);
@@ -1021,7 +1022,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
             offset |= RAM_SAVE_FLAG_CONTINUE;
             pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
             if (pages == -1) {
-                pages = compress_page_with_multi_thread(f, block, offset,
+                pages = compress_page_with_multi_thread(rs, f, block, offset,
                                                         bytes_transferred);
             } else {
                 ram_release_pages(ms, block->idstr, pss->offset, pages);
@@ -1455,7 +1456,7 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
     if (zero) {
         rs->zero_pages += pages;
     } else {
-        acct_info.norm_pages += pages;
+        rs->norm_pages += pages;
         bytes_transferred += size;
         qemu_update_position(f, size);
     }
@@ -1996,6 +1997,7 @@ static int ram_save_init_globals(RAMState *rs)
     rs->dirty_rate_high_cnt = 0;
     rs->bitmap_sync_count = 0;
     rs->zero_pages = 0;
+    rs->norm_pages = 0;
     migration_bitmap_sync_init(rs);
     qemu_mutex_init(&migration_bitmap_mutex);
 
-- 
2.9.3
