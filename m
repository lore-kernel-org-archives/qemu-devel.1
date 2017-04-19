Received: from eggs.gnu.org ([2001:4830:134:3::10]:44340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wiK-0004TL-7L
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wiJ-0007Hl-3T
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0wiI-0007HW-Qy
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5488C05491C
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:59:06 +0200
Message-Id: <20170419205923.8808-43-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 42/59] ram: We don't need MigrationState
 parameter anymore
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

Remove it from callers and callees.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 289d7eb..fe01e7b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -794,13 +794,11 @@ static void ram_release_pages(const char *rbname, uint64_t offset, int pages)
  *                if xbzrle noticed the page was the same.
  *
  * @rs: current RAM state
- * @ms: current migration state
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  * @last_stage: if we are at the completion stage
  */
-static int ram_save_page(RAMState *rs, MigrationState *ms,
-                         PageSearchStatus *pss, bool last_stage)
+static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 {
     int pages = -1;
     uint64_t bytes_xmit;
@@ -974,13 +972,12 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
  * Returns the number of pages written.
  *
  * @rs: current RAM state
- * @ms: current migration state
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  * @last_stage: if we are at the completion stage
  */
-static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
-                                    PageSearchStatus *pss, bool last_stage)
+static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
+                                    bool last_stage)
 {
     int pages = -1;
     uint64_t bytes_xmit = 0;
@@ -1311,10 +1308,8 @@ err:
  * @last_stage: if we are at the completion stage
  * @dirty_ram_abs: address of the start of the dirty page in ram_addr_t space
  */
-static int ram_save_target_page(RAMState *rs, MigrationState *ms,
-                                PageSearchStatus *pss,
-                                bool last_stage,
-                                ram_addr_t dirty_ram_abs)
+static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
+                                bool last_stage, ram_addr_t dirty_ram_abs)
 {
     int res = 0;
 
@@ -1329,9 +1324,9 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms,
 
         if (migrate_use_compression()
             && (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
-            res = ram_save_compressed_page(rs, ms, pss, last_stage);
+            res = ram_save_compressed_page(rs, pss, last_stage);
         } else {
-            res = ram_save_page(rs, ms, pss, last_stage);
+            res = ram_save_page(rs, pss, last_stage);
         }
 
         if (res < 0) {
@@ -1370,8 +1365,7 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms,
  * @last_stage: if we are at the completion stage
  * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
  */
-static int ram_save_host_page(RAMState *rs, MigrationState *ms,
-                              PageSearchStatus *pss,
+static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
                               bool last_stage,
                               ram_addr_t dirty_ram_abs)
 {
@@ -1379,7 +1373,7 @@ static int ram_save_host_page(RAMState *rs, MigrationState *ms,
     size_t pagesize = qemu_ram_pagesize(pss->block);
 
     do {
-        tmppages = ram_save_target_page(rs, ms, pss, last_stage, dirty_ram_abs);
+        tmppages = ram_save_target_page(rs, pss, last_stage, dirty_ram_abs);
         if (tmppages < 0) {
             return tmppages;
         }
@@ -1411,7 +1405,6 @@ static int ram_save_host_page(RAMState *rs, MigrationState *ms,
 static int ram_find_and_save_block(RAMState *rs, bool last_stage)
 {
     PageSearchStatus pss;
-    MigrationState *ms = migrate_get_current();
     int pages = 0;
     bool again, found;
     ram_addr_t dirty_ram_abs; /* Address of the start of the dirty page in
@@ -1440,7 +1433,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
         }
 
         if (found) {
-            pages = ram_save_host_page(rs, ms, &pss, last_stage, dirty_ram_abs);
+            pages = ram_save_host_page(rs, &pss, last_stage, dirty_ram_abs);
         }
     } while (!pages && again);
 
-- 
2.9.3
