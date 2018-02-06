Received: from eggs.gnu.org ([2001:4830:134:3::10]:43500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5WN-00031y-Gb
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5WJ-0004Q4-LH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:50:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej5WJ-0004PM-GF
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:50:55 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  6 Feb 2018 15:49:27 +0000
Message-Id: <20180206154936.13565-6-dgilbert@redhat.com>
In-Reply-To: <20180206154936.13565-1-dgilbert@redhat.com>
References: <20180206154936.13565-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] migration: Drop current address parameter
 from save_zero_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com, wei.w.wang@intel.com, danielhb@linux.vnet.ibm.com

From: Juan Quintela <quintela@redhat.com>

It already has RAMBlock and offset, it can calculate it itself.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index cb1950f3eb..5a109efeda 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -907,11 +907,10 @@ static void migration_bitmap_sync(RAMState *rs)
  * @rs: current RAM state
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
- * @p: pointer to the page
  */
-static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
-                          uint8_t *p)
+static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
 {
+    uint8_t *p = block->host + offset;
     int pages = -1;
 
     if (is_zero_range(p, TARGET_PAGE_SIZE)) {
@@ -984,7 +983,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
             }
         }
     } else {
-        pages = save_zero_page(rs, block, offset, p);
+        pages = save_zero_page(rs, block, offset);
         if (pages > 0) {
             /* Must let xbzrle know, otherwise a previous (now 0'd) cached
              * page would be stale
@@ -1160,7 +1159,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
          */
         if (block != rs->last_sent_block) {
             flush_compressed_data(rs);
-            pages = save_zero_page(rs, block, offset, p);
+            pages = save_zero_page(rs, block, offset);
             if (pages == -1) {
                 /* Make sure the first page is sent out before other pages */
                 bytes_xmit = save_page_header(rs, rs->f, block, offset |
@@ -1180,7 +1179,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
                 ram_release_pages(block->idstr, offset, pages);
             }
         } else {
-            pages = save_zero_page(rs, block, offset, p);
+            pages = save_zero_page(rs, block, offset);
             if (pages == -1) {
                 pages = compress_page_with_multi_thread(rs, block, offset);
             } else {
-- 
2.14.3
