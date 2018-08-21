Received: from eggs.gnu.org ([2001:4830:134:3::10]:47125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1kh-0003sZ-Pi
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1kg-0004ZQ-EO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:10:59 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:42240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fs1kg-0004Yk-2w
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:10:58 -0400
Received: by mail-pl0-x235.google.com with SMTP id g23-v6so5465777plq.9
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 01:10:58 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 21 Aug 2018 16:10:23 +0800
Message-Id: <20180821081029.26121-5-xiaoguangrong@tencent.com>
In-Reply-To: <20180821081029.26121-1-xiaoguangrong@tencent.com>
References: <20180821081029.26121-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v4 04/10] migration: drop the return value of
 do_compress_ram_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It is not used and cleans the code up a little

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 49ace30614..e463de4f69 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -381,8 +381,8 @@ static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
 static QemuCond decomp_done_cond;
 
-static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
-                                ram_addr_t offset, uint8_t *source_buf);
+static void do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
+                                 ram_addr_t offset, uint8_t *source_buf);
 
 static void *do_data_compress(void *opaque)
 {
@@ -1842,15 +1842,14 @@ static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
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
@@ -1858,17 +1857,14 @@ static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
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
2.14.4
