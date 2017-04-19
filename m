Received: from eggs.gnu.org ([2001:4830:134:3::10]:44405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wiS-0004cO-Ax
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wiR-0007KC-06
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0wiQ-0007Jz-Mg
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AB587EBC2
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:59:11 +0200
Message-Id: <20170419205923.8808-48-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 47/59] ram: reorganize last_sent_block
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

We were setting it far away of when we changed it.  Now everything is
done inside save_page_header.  Once there, reorganize code to pass
RAMState.  We also set CONTINUE flag in a single place.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 9ed91e5..1ef142f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -451,18 +451,22 @@ void migrate_compress_threads_create(void)
  * @offset: offset inside the block for the page
  *          in the lower bits, it contains flags
  */
-static size_t save_page_header(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
+static size_t save_page_header(RAMState *rs, RAMBlock *block, ram_addr_t offset)
 {
     size_t size, len;
 
-    qemu_put_be64(f, offset);
+    if (block == rs->last_sent_block) {
+        offset |= RAM_SAVE_FLAG_CONTINUE;
+    }
+    qemu_put_be64(rs->f, offset);
     size = 8;
 
     if (!(offset & RAM_SAVE_FLAG_CONTINUE)) {
         len = strlen(block->idstr);
-        qemu_put_byte(f, len);
-        qemu_put_buffer(f, (uint8_t *)block->idstr, len);
+        qemu_put_byte(rs->f, len);
+        qemu_put_buffer(rs->f, (uint8_t *)block->idstr, len);
         size += 1 + len;
+        rs->last_sent_block = block;
     }
     return size;
 }
@@ -582,7 +586,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     }
 
     /* Send XBZRLE based compressed page */
-    bytes_xbzrle = save_page_header(rs->f, block,
+    bytes_xbzrle = save_page_header(rs, block,
                                     offset | RAM_SAVE_FLAG_XBZRLE);
     qemu_put_byte(rs->f, ENCODING_FLAG_XBZRLE);
     qemu_put_be16(rs->f, encoded_len);
@@ -767,7 +771,7 @@ static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
     if (is_zero_range(p, TARGET_PAGE_SIZE)) {
         rs->zero_pages++;
         rs->bytes_transferred +=
-            save_page_header(rs->f, block, offset | RAM_SAVE_FLAG_COMPRESS);
+            save_page_header(rs, block, offset | RAM_SAVE_FLAG_COMPRESS);
         qemu_put_byte(rs->f, 0);
         rs->bytes_transferred += 1;
         pages = 1;
@@ -824,9 +828,6 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 
     current_addr = block->offset + offset;
 
-    if (block == rs->last_sent_block) {
-        offset |= RAM_SAVE_FLAG_CONTINUE;
-    }
     if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
         if (ret != RAM_SAVE_CONTROL_DELAYED) {
             if (bytes_xmit > 0) {
@@ -858,8 +859,8 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 
     /* XBZRLE overflow or normal page */
     if (pages == -1) {
-        rs->bytes_transferred += save_page_header(rs->f, block,
-                                               offset | RAM_SAVE_FLAG_PAGE);
+        rs->bytes_transferred += save_page_header(rs, block,
+                                                  offset | RAM_SAVE_FLAG_PAGE);
         if (send_async) {
             qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
                                   migrate_release_ram() &
@@ -880,10 +881,11 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
                                 ram_addr_t offset)
 {
+    RAMState *rs = &ram_state;
     int bytes_sent, blen;
     uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
 
-    bytes_sent = save_page_header(f, block, offset |
+    bytes_sent = save_page_header(rs, block, offset |
                                   RAM_SAVE_FLAG_COMPRESS_PAGE);
     blen = qemu_put_compression_data(f, p, TARGET_PAGE_SIZE,
                                      migrate_compress_level());
@@ -1014,7 +1016,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
             pages = save_zero_page(rs, block, offset, p);
             if (pages == -1) {
                 /* Make sure the first page is sent out before other pages */
-                bytes_xmit = save_page_header(rs->f, block, offset |
+                bytes_xmit = save_page_header(rs, block, offset |
                                               RAM_SAVE_FLAG_COMPRESS_PAGE);
                 blen = qemu_put_compression_data(rs->f, p, TARGET_PAGE_SIZE,
                                                  migrate_compress_level());
@@ -1031,7 +1033,6 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
                 ram_release_pages(block->idstr, pss->offset, pages);
             }
         } else {
-            offset |= RAM_SAVE_FLAG_CONTINUE;
             pages = save_zero_page(rs, block, offset, p);
             if (pages == -1) {
                 pages = compress_page_with_multi_thread(rs, block, offset);
@@ -1336,13 +1337,6 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
         if (unsentmap) {
             clear_bit(dirty_ram_abs >> TARGET_PAGE_BITS, unsentmap);
         }
-        /* Only update last_sent_block if a block was actually sent; xbzrle
-         * might have decided the page was identical so didn't bother writing
-         * to the stream.
-         */
-        if (res > 0) {
-            rs->last_sent_block = pss->block;
-        }
     }
 
     return res;
-- 
2.9.3
