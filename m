Received: from eggs.gnu.org ([2001:4830:134:3::10]:51459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgpYI-0005df-No
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgpYH-0003CY-T8
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:19:06 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 23 Feb 2017 17:18:43 +0800
Message-Id: <20170223091845.18523-5-famz@redhat.com>
In-Reply-To: <20170223091845.18523-1-famz@redhat.com>
References: <20170223091845.18523-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] block: Introduce bdrv_dma_map and
 bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Allow block driver to map and unmap a buffer for later I/O, as a performance
hint.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c          | 10 ++++++++++
 block/io.c                     | 24 ++++++++++++++++++++++++
 include/block/block.h          |  2 ++
 include/block/block_int.h      |  4 ++++
 include/sysemu/block-backend.h |  3 +++
 5 files changed, 43 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 819f272..ff05662 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1786,3 +1786,13 @@ static void blk_root_drained_end(BdrvChild *child)
     assert(blk->public.io_limits_disabled);
     --blk->public.io_limits_disabled;
 }
+
+void blk_dma_map(BlockBackend *blk, void *host, size_t size)
+{
+    bdrv_dma_map(blk_bs(blk), host, size);
+}
+
+void blk_dma_unmap(BlockBackend *blk, void *host)
+{
+    bdrv_dma_unmap(blk_bs(blk), host);
+}
diff --git a/block/io.c b/block/io.c
index d5c4544..541a5fb 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2646,3 +2646,27 @@ void bdrv_io_unplug(BlockDriverState *bs)
         bdrv_io_unplug(child->bs);
     }
 }
+
+void bdrv_dma_map(BlockDriverState *bs, void *host, size_t size)
+{
+    BdrvChild *child;
+
+    if (bs->drv && bs->drv->bdrv_dma_map) {
+        bs->drv->bdrv_dma_map(bs, host, size);
+    }
+    QLIST_FOREACH(child, &bs->children, next) {
+        bdrv_dma_map(child->bs, host, size);
+    }
+}
+
+void bdrv_dma_unmap(BlockDriverState *bs, void *host)
+{
+    BdrvChild *child;
+
+    if (bs->drv && bs->drv->bdrv_dma_unmap) {
+        bs->drv->bdrv_dma_unmap(bs, host);
+    }
+    QLIST_FOREACH(child, &bs->children, next) {
+        bdrv_dma_unmap(child->bs, host);
+    }
+}
diff --git a/include/block/block.h b/include/block/block.h
index 4e81f20..1c72159 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -551,4 +551,6 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
                     Error **errp);
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
+void bdrv_dma_map(BlockDriverState *bs, void *host, size_t size);
+void bdrv_dma_unmap(BlockDriverState *bs, void *host);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1670941..b061fd1 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -320,6 +320,10 @@ struct BlockDriver {
     void (*bdrv_del_child)(BlockDriverState *parent, BdrvChild *child,
                            Error **errp);
 
+    /* Map and unmap a buffer for later I/O, as a performance hint to the
+     * driver. */
+    void (*bdrv_dma_map)(BlockDriverState *bs, void *host, size_t size);
+    void (*bdrv_dma_unmap)(BlockDriverState *bs, void *host);
     QLIST_ENTRY(BlockDriver) list;
 };
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index f365a51..6832b48 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -230,4 +230,7 @@ void blk_io_limits_disable(BlockBackend *blk);
 void blk_io_limits_enable(BlockBackend *blk, const char *group);
 void blk_io_limits_update_group(BlockBackend *blk, const char *group);
 
+void blk_dma_map(BlockBackend *blk, void *host, size_t size);
+void blk_dma_unmap(BlockBackend *blk, void *host);
+
 #endif
-- 
2.9.3
