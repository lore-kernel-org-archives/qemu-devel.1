Received: from eggs.gnu.org ([2001:4830:134:3::10]:36486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAwtx-00029t-LO
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAwtu-00024f-VU
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAwtu-000249-MU
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 998E180C04
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 11:13:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 13:13:40 +0200
Message-Id: <20170517111346.21450-2-quintela@redhat.com>
In-Reply-To: <20170517111346.21450-1-quintela@redhat.com>
References: <20170517111346.21450-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] migration: Fix regression with compression
 threads
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

Compression threads got broken on commit

  commit 247956946651ae0280f7b1ea88bb6237dd01c231
  Author: Juan Quintela <quintela@redhat.com>
  Date:   Tue Mar 21 11:45:01 2017 +0100

      ram: reorganize last_sent_block

On do_compress_ram_page() we use a different QEMUFile than the
migration one.  We need to pass it there.  The failure can be seen as:

(qemu) qemu-system-x86_64: Unknown combination of migration flags: 0
qemu-system-x86_64: error while loading state section id 3(ram)
qemu-system-x86_64: load of migration failed: Invalid argument

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 293d27c..995d1fc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -436,20 +436,21 @@ void migrate_compress_threads_create(void)
  * @offset: offset inside the block for the page
  *          in the lower bits, it contains flags
  */
-static size_t save_page_header(RAMState *rs, RAMBlock *block, ram_addr_t offset)
+static size_t save_page_header(RAMState *rs, QEMUFile *f,  RAMBlock *block,
+                               ram_addr_t offset)
 {
     size_t size, len;
 
     if (block == rs->last_sent_block) {
         offset |= RAM_SAVE_FLAG_CONTINUE;
     }
-    qemu_put_be64(rs->f, offset);
+    qemu_put_be64(f, offset);
     size = 8;
 
     if (!(offset & RAM_SAVE_FLAG_CONTINUE)) {
         len = strlen(block->idstr);
-        qemu_put_byte(rs->f, len);
-        qemu_put_buffer(rs->f, (uint8_t *)block->idstr, len);
+        qemu_put_byte(f, len);
+        qemu_put_buffer(f, (uint8_t *)block->idstr, len);
         size += 1 + len;
         rs->last_sent_block = block;
     }
@@ -571,7 +572,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     }
 
     /* Send XBZRLE based compressed page */
-    bytes_xbzrle = save_page_header(rs, block,
+    bytes_xbzrle = save_page_header(rs, rs->f, block,
                                     offset | RAM_SAVE_FLAG_XBZRLE);
     qemu_put_byte(rs->f, ENCODING_FLAG_XBZRLE);
     qemu_put_be16(rs->f, encoded_len);
@@ -745,7 +746,7 @@ static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
     if (is_zero_range(p, TARGET_PAGE_SIZE)) {
         rs->zero_pages++;
         rs->bytes_transferred +=
-            save_page_header(rs, block, offset | RAM_SAVE_FLAG_COMPRESS);
+            save_page_header(rs, rs->f, block, offset | RAM_SAVE_FLAG_COMPRESS);
         qemu_put_byte(rs->f, 0);
         rs->bytes_transferred += 1;
         pages = 1;
@@ -834,7 +835,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 
     /* XBZRLE overflow or normal page */
     if (pages == -1) {
-        rs->bytes_transferred += save_page_header(rs, block,
+        rs->bytes_transferred += save_page_header(rs, rs->f, block,
                                                   offset | RAM_SAVE_FLAG_PAGE);
         if (send_async) {
             qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
@@ -860,7 +861,7 @@ static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
     int bytes_sent, blen;
     uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
 
-    bytes_sent = save_page_header(rs, block, offset |
+    bytes_sent = save_page_header(rs, f, block, offset |
                                   RAM_SAVE_FLAG_COMPRESS_PAGE);
     blen = qemu_put_compression_data(f, p, TARGET_PAGE_SIZE,
                                      migrate_compress_level());
@@ -991,7 +992,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
             pages = save_zero_page(rs, block, offset, p);
             if (pages == -1) {
                 /* Make sure the first page is sent out before other pages */
-                bytes_xmit = save_page_header(rs, block, offset |
+                bytes_xmit = save_page_header(rs, rs->f, block, offset |
                                               RAM_SAVE_FLAG_COMPRESS_PAGE);
                 blen = qemu_put_compression_data(rs->f, p, TARGET_PAGE_SIZE,
                                                  migrate_compress_level());
-- 
2.9.3
