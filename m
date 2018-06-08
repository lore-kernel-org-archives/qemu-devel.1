Received: from eggs.gnu.org ([2001:4830:134:3::10]:42065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAWU-0000Sr-EL
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAWT-0008Vq-FN
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:05:18 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Jun 2018 14:04:16 +0800
Message-Id: <20180608060417.10170-6-famz@redhat.com>
In-Reply-To: <20180608060417.10170-1-famz@redhat.com>
References: <20180608060417.10170-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] block: Add backing passthrough
 implementations for copy_range
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

Similar to bdrv_co_block_status_from_backing we add the two passthrough
callbacks for copy_range. This will be used by the block driver filters
so that they can support copy offloading.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c                | 24 ++++++++++++++++++++++++
 include/block/block_int.h | 22 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/block/io.c b/block/io.c
index d8039793c2..d1559c9cd5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1900,6 +1900,30 @@ int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
     return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
 }
 
+int coroutine_fn bdrv_co_copy_range_from_backing(BlockDriverState *bs,
+                                                 BdrvChild *src, uint64_t src_offset,
+                                                 BdrvChild *dst, uint64_t dst_offset,
+                                                 uint64_t bytes, BdrvRequestFlags flags)
+{
+    if (!src->bs) {
+        return -ENOMEDIUM;
+    }
+    return bdrv_co_copy_range_from(src->bs->backing, src_offset, dst,
+                                   dst_offset, bytes, flags);
+}
+
+int coroutine_fn bdrv_co_copy_range_to_backing(BlockDriverState *bs,
+                                               BdrvChild *src, uint64_t src_offset,
+                                               BdrvChild *dst, uint64_t dst_offset,
+                                               uint64_t bytes, BdrvRequestFlags flags)
+{
+    if (!dst->bs) {
+        return -ENOMEDIUM;
+    }
+    return bdrv_co_copy_range_to(src, src_offset, dst->bs->backing,
+                                 dst_offset, bytes, flags);
+}
+
 /*
  * Returns the allocation status of the specified sectors.
  * Drivers not implementing the functionality are assumed to not support
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 2c51cd420f..b488d74c1b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1118,6 +1118,28 @@ int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
                                                    int64_t *pnum,
                                                    int64_t *map,
                                                    BlockDriverState **file);
+
+/*
+ * Default implementation for drivers to pass bdrv_co_copy_range_from() to
+ * their backing file.
+ */
+int coroutine_fn bdrv_co_copy_range_from_backing(BlockDriverState *bs,
+                                                 BdrvChild *src, uint64_t src_offset,
+                                                 BdrvChild *dst, uint64_t dst_offset,
+                                                 uint64_t bytes,
+                                                 BdrvRequestFlags flags);
+
+
+/*
+ * Default implementation for drivers to pass bdrv_co_copy_range_to() to their
+ * backing file.
+ */
+int coroutine_fn bdrv_co_copy_range_to_backing(BlockDriverState *bs,
+                                               BdrvChild *src, uint64_t src_offset,
+                                               BdrvChild *dst, uint64_t dst_offset,
+                                               uint64_t bytes,
+                                               BdrvRequestFlags flags);
+
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
 void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp);
 bool blk_dev_has_removable_media(BlockBackend *blk);
-- 
2.17.0
