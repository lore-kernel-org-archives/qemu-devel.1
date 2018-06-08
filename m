Received: from eggs.gnu.org ([2001:4830:134:3::10]:42028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAWN-0000Ix-Lh
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAWM-0008Ru-Q6
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:05:11 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Jun 2018 14:04:15 +0800
Message-Id: <20180608060417.10170-5-famz@redhat.com>
In-Reply-To: <20180608060417.10170-1-famz@redhat.com>
References: <20180608060417.10170-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] block-backend: Add blk_aio_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c          | 36 ++++++++++++++++++++++++++++++++++
 include/sysemu/block-backend.h |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index e20a204bee..36d928e13d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1213,6 +1213,14 @@ typedef struct BlkRwCo {
             unsigned long int req;
             void *buf;
         } ioctl;
+
+        struct {
+            BlockBackend *dst_blk;
+            int64_t src_off;
+            int64_t dst_off;
+            int bytes;
+            BdrvRequestFlags flags;
+        } copy_range;
     };
 
 } BlkRwCo;
@@ -1505,6 +1513,34 @@ BlockAIOCB *blk_aio_pwritev(BlockBackend *blk, int64_t offset,
     return blk_aio_prwv(blk, &rwco, blk_aio_write_entry, cb, opaque);
 }
 
+static void blk_aio_copy_range_entry(void *opaque)
+{
+    BlkAioEmAIOCB *acb = opaque;
+    BlkRwCo *rwco = &acb->rwco;
+
+    rwco->ret = blk_co_copy_range(rwco->blk, rwco->copy_range.src_off,
+                                  rwco->copy_range.dst_blk,
+                                  rwco->copy_range.dst_off,
+                                  rwco->copy_range.bytes,
+                                  rwco->copy_range.flags);
+    blk_aio_complete(acb);
+}
+
+BlockAIOCB *blk_aio_copy_range(BlockBackend *src, int64_t src_offset,
+                               BlockBackend *dst, int64_t dst_offset,
+                               uint64_t bytes, BdrvRequestFlags flags,
+                               BlockCompletionFunc *cb, void *opaque)
+{
+    BlkRwCo rwco = (BlkRwCo) {
+        .copy_range.src_off = src_offset,
+        .copy_range.dst_blk = dst,
+        .copy_range.dst_off = dst_offset,
+        .copy_range.bytes = bytes,
+        .copy_range.flags = flags,
+    };
+    return blk_aio_prwv(src, &rwco, blk_aio_copy_range_entry, cb, opaque);
+}
+
 static void blk_aio_flush_entry(void *opaque)
 {
     BlkAioEmAIOCB *acb = opaque;
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8d03d493c2..ea121eac3f 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -147,6 +147,10 @@ BlockAIOCB *blk_aio_flush(BlockBackend *blk,
                           BlockCompletionFunc *cb, void *opaque);
 BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int bytes,
                              BlockCompletionFunc *cb, void *opaque);
+BlockAIOCB *blk_aio_copy_range(BlockBackend *src, int64_t src_offset,
+                               BlockBackend *dst, int64_t dst_offset,
+                               uint64_t bytes, BdrvRequestFlags flags,
+                               BlockCompletionFunc *cb, void *opaque);
 void blk_aio_cancel(BlockAIOCB *acb);
 void blk_aio_cancel_async(BlockAIOCB *acb);
 int blk_co_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
-- 
2.17.0
