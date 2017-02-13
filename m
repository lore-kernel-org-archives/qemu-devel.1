Received: from eggs.gnu.org ([2001:4830:134:3::10]:39025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKlv-0003Te-Cq
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKlu-0005ua-2l
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdKlt-0005uJ-KI
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:41 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 13 Feb 2017 17:50:22 +0000
Message-Id: <20170213175033.7314-4-dgilbert@redhat.com>
In-Reply-To: <20170213175033.7314-1-dgilbert@redhat.com>
References: <20170213175033.7314-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 03/14] migration: add MigrationState arg for
 ram_save_/compressed_/page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, ashijeetacharya@gmail.com, amit@kernel.org, pbutsykin@virtuozzo.com, zhang.zhanghailiang@huawei.com

From: Pavel Butsykin <pbutsykin@virtuozzo.com>

Cosmetic patch. The use of ms variable instead of migrate_get_current()
looks nicer, especially when there reuse.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-Id: <20170203152321.19739-2-pbutsykin@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ef8fadf..91443b3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -713,13 +713,14 @@ static int save_zero_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset,
  *          >=0 - Number of pages written - this might legally be 0
  *                if xbzrle noticed the page was the same.
  *
+ * @ms: The current migration state.
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  * @last_stage: if we are at the completion stage
  * @bytes_transferred: increase it with the number of transferred bytes
  */
-static int ram_save_page(QEMUFile *f, PageSearchStatus *pss,
+static int ram_save_page(MigrationState *ms, QEMUFile *f, PageSearchStatus *pss,
                          bool last_stage, uint64_t *bytes_transferred)
 {
     int pages = -1;
@@ -765,8 +766,7 @@ static int ram_save_page(QEMUFile *f, PageSearchStatus *pss,
              */
             xbzrle_cache_zero_page(current_addr);
         } else if (!ram_bulk_stage &&
-                   !migration_in_postcopy(migrate_get_current()) &&
-                   migrate_use_xbzrle()) {
+                   !migration_in_postcopy(ms) && migrate_use_xbzrle()) {
             pages = save_xbzrle_page(f, &p, current_addr, block,
                                      offset, last_stage, bytes_transferred);
             if (!last_stage) {
@@ -893,14 +893,15 @@ static int compress_page_with_multi_thread(QEMUFile *f, RAMBlock *block,
  *
  * Returns: Number of pages written.
  *
+ * @ms: The current migration state.
  * @f: QEMUFile where to send the data
  * @block: block that contains the page we want to send
  * @offset: offset inside the block for the page
  * @last_stage: if we are at the completion stage
  * @bytes_transferred: increase it with the number of transferred bytes
  */
-static int ram_save_compressed_page(QEMUFile *f, PageSearchStatus *pss,
-                                    bool last_stage,
+static int ram_save_compressed_page(MigrationState *ms, QEMUFile *f,
+                                    PageSearchStatus *pss, bool last_stage,
                                     uint64_t *bytes_transferred)
 {
     int pages = -1;
@@ -1231,11 +1232,11 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
     if (migration_bitmap_clear_dirty(dirty_ram_abs)) {
         unsigned long *unsentmap;
         if (compression_switch && migrate_use_compression()) {
-            res = ram_save_compressed_page(f, pss,
+            res = ram_save_compressed_page(ms, f, pss,
                                            last_stage,
                                            bytes_transferred);
         } else {
-            res = ram_save_page(f, pss, last_stage,
+            res = ram_save_page(ms, f, pss, last_stage,
                                 bytes_transferred);
         }
 
-- 
2.9.3
