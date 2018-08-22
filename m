Received: from eggs.gnu.org ([2001:4830:134:3::10]:39084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpU-0006xp-63
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpP-0000FJ-LI
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRpP-0000Ew-FJ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:35 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:48 +0200
Message-Id: <20180822120050.12694-19-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 18/20] migration: drop the return value of
 do_compress_ram_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It is not used and cleans the code up a little

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8ffa0a6d55..11066df881 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -382,8 +382,8 @@ static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
-static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                ram_addr_t offset, uint8_t *source_buf);
+static void do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
+                                 ram_addr_t offset, uint8_t *source_buf);
 
 static void *do_data_compress(void *opaque)
 {
@@ -1849,15 +1849,14 @@ static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
     return 1;
 }
 
-static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                ram_addr_t offset, uint8_t *source_buf)
+static void do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
+                                 ram_addr_t offset, uint8_t *source_buf)
 {
     RAMState *rs = ram_state;
-    int bytes_sent, blen;
     uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
+    int ret;
 
-    bytes_sent = save_page_header(rs, f, block, offset |
-                                  RAM_SAVE_FLAG_COMPRESS_PAGE);
+    save_page_header(rs, f, block, offset | RAM_SAVE_FLAG_COMPRESS_PAGE);
 
     /*
      * copy it to a internal buffer to avoid it being modified by VM
@@ -1865,17 +1864,14 @@ static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
      * decompression
      */
     memcpy(source_buf, p, TARGET_PAGE_SIZE);
-    blen = qemu_put_compression_data(f, stream, source_buf, TARGET_PAGE_SIZE);
-    if (blen < 0) {
-        bytes_sent = 0;
-        qemu_file_set_error(migrate_get_current()->to_dst_file, blen);
+    ret = qemu_put_compression_data(f, stream, source_buf, TARGET_PAGE_SIZE);
+    if (ret < 0) {
+        qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
         error_report("compressed data failed!");
-    } else {
-        bytes_sent += blen;
-        ram_release_pages(block->idstr, offset & TARGET_PAGE_MASK, 1);
+        return;
     }
 
-    return bytes_sent;
+    ram_release_pages(block->idstr, offset & TARGET_PAGE_MASK, 1);
 }
 
 static void flush_compressed_data(RAMState *rs)
-- 
2.17.1
