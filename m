Received: from eggs.gnu.org ([2001:4830:134:3::10]:60630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VR5-0001V4-Va
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VR4-00037l-V0
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:39 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Mar 2018 19:09:07 +0800
Message-Id: <20180329110914.20888-2-famz@redhat.com>
In-Reply-To: <20180329110914.20888-1-famz@redhat.com>
References: <20180329110914.20888-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 1/8] block: Introduce bdrv_co_map_range API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

A little similar to bdrv_co_block_status but with the capability to do
allocation depending on the BDRV_REQ_ALLOCATE flag, this API is the
building block needed by copy offloading to work for format drivers.

The idea is the format drivers return "where" to copy from/to in its
underlying "file", then the block layer will drill down until it reaches
a protocol layer that can do offloaded copying.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c                | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h     |  8 +++++++-
 include/block/block_int.h | 21 +++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index bd9a19a9c4..1b4cfcacb1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2826,3 +2826,47 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host)
         bdrv_unregister_buf(child->bs, host);
     }
 }
+
+int coroutine_fn bdrv_co_map_range(BdrvChild *child, int64_t offset,
+                                   int64_t bytes, int64_t *pnum, int64_t *map,
+                                   BlockDriverState **file,
+                                   int flags)
+{
+    BlockDriverState *bs = child->bs;
+
+    if (bs->encrypted) {
+        return -ENOTSUP;
+    }
+    while (bs && bs->drv && bs->drv->bdrv_co_map_range) {
+        int64_t cur_pnum, cur_map;
+        BlockDriverState *cur_file = NULL;
+        int r = bs->drv->bdrv_co_map_range(bs, offset, bytes,
+                                           &cur_pnum, &cur_map, &cur_file,
+                                           flags);
+        if (r < 0) {
+            return r;
+        }
+        offset = cur_map;
+        bytes = cur_pnum;
+        if (pnum) {
+            *pnum = cur_pnum;
+        }
+        if (map) {
+            *map = cur_map;
+        }
+        if (!(r & BDRV_BLOCK_OFFSET_VALID)) {
+            return -ENOTSUP;
+        }
+        if (file) {
+            *file = cur_file;
+        }
+        if (!cur_file) {
+            return -ENOTSUP;
+        }
+        if (cur_file == bs) {
+            return r;
+        }
+        bs = cur_file;
+    }
+    return -ENOTSUP;
+}
diff --git a/include/block/block.h b/include/block/block.h
index cdec3639a3..21d3e9db32 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -53,9 +53,10 @@ typedef enum {
     BDRV_REQ_NO_SERIALISING     = 0x8,
     BDRV_REQ_FUA                = 0x10,
     BDRV_REQ_WRITE_COMPRESSED   = 0x20,
+    BDRV_REQ_ALLOCATE           = 0x40,
 
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x3f,
+    BDRV_REQ_MASK               = 0x7f,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
@@ -604,4 +605,9 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
  */
 void bdrv_register_buf(BlockDriverState *bs, void *host, size_t size);
 void bdrv_unregister_buf(BlockDriverState *bs, void *host);
+
+int bdrv_co_map_range(BdrvChild *child, int64_t offset,
+                      int64_t bytes, int64_t *pnum, int64_t *map,
+                      BlockDriverState **file,
+                      int flags);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index c4dd1d4bb8..3f3f6f3efd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -475,6 +475,27 @@ struct BlockDriver {
      */
     void (*bdrv_register_buf)(BlockDriverState *bs, void *host, size_t size);
     void (*bdrv_unregister_buf)(BlockDriverState *bs, void *host);
+
+    /**
+     * Get or create offset mappings for a virtual range.
+     *
+     * @offset: the offset of the beginning of the range.
+     * @bytes: the maximum bytes of the range to map.
+     * @pnum: at return, this will point to the number of bytes in the returned
+     * mapping status
+     * @map: at return, this will point to the offset which the range maps to
+     * @file: at return, this will point to the file where the data is mapped.
+     * If it is set to bs, it means the mapping is terminal and the result can
+     * be used for read/write and copy_range; if it is NULL, it means the range
+     * doesn't map to a file, or no I/O to any file is necessary; otherwise, it
+     * means the query should be passed down to an underlying format/protocol.
+     * @flags: flags for the request. BDRV_REQ_ALLOCATE means the range
+     * should be allocated if necessary.
+     */
+    int (*bdrv_co_map_range)(BlockDriverState *bs, int64_t offset,
+                             int64_t bytes, int64_t *pnum, int64_t *map,
+                             BlockDriverState **file,
+                             int flags);
     QLIST_ENTRY(BlockDriver) list;
 };
 
-- 
2.14.3
