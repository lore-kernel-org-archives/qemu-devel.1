Received: from eggs.gnu.org ([2001:4830:134:3::10]:56230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1ooa-0001nZ-Pm
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1ooZ-0007YK-M8
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:12 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:40324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f1ooZ-0007YA-F9
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 03:51:11 -0400
Received: by mail-pf0-x230.google.com with SMTP id y66so4951060pfi.7
	for <qemu-devel@nongnu.org>; Fri, 30 Mar 2018 00:51:11 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Fri, 30 Mar 2018 15:51:19 +0800
Message-Id: <20180330075128.26919-2-xiaoguangrong@tencent.com>
In-Reply-To: <20180330075128.26919-1-xiaoguangrong@tencent.com>
References: <20180330075128.26919-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v3 01/10] migration: stop compressing page in
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

As compression is a heavy work, do not do it in migration thread,
instead, we post it out as a normal page

Reviewed-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 0e90efa092..409c847a76 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1137,7 +1137,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
     int pages = -1;
     uint64_t bytes_xmit = 0;
     uint8_t *p;
-    int ret, blen;
+    int ret;
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
 
@@ -1167,23 +1167,23 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
         if (block != rs->last_sent_block) {
             flush_compressed_data(rs);
             pages = save_zero_page(rs, block, offset);
-            if (pages == -1) {
-                /* Make sure the first page is sent out before other pages */
-                bytes_xmit = save_page_header(rs, rs->f, block, offset |
-                                              RAM_SAVE_FLAG_COMPRESS_PAGE);
-                blen = qemu_put_compression_data(rs->f, p, TARGET_PAGE_SIZE,
-                                                 migrate_compress_level());
-                if (blen > 0) {
-                    ram_counters.transferred += bytes_xmit + blen;
-                    ram_counters.normal++;
-                    pages = 1;
-                } else {
-                    qemu_file_set_error(rs->f, blen);
-                    error_report("compressed data failed!");
-                }
-            }
             if (pages > 0) {
                 ram_release_pages(block->idstr, offset, pages);
+            } else {
+                /*
+                 * Make sure the first page is sent out before other pages.
+                 *
+                 * we post it as normal page as compression will take much
+                 * CPU resource.
+                 */
+                ram_counters.transferred += save_page_header(rs, rs->f, block,
+                                                offset | RAM_SAVE_FLAG_PAGE);
+                qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
+                                      migrate_release_ram() &
+                                      migration_in_postcopy());
+                ram_counters.transferred += TARGET_PAGE_SIZE;
+                ram_counters.normal++;
+                pages = 1;
             }
         } else {
             pages = save_zero_page(rs, block, offset);
-- 
2.14.3
