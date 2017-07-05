Received: from eggs.gnu.org ([2001:4830:134:3::10]:39005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSkUT-0005Br-Ns
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSkUS-0004MU-Nc
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:37:13 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  5 Jul 2017 21:36:32 +0800
Message-Id: <20170705133635.11850-4-famz@redhat.com>
In-Reply-To: <20170705133635.11850-1-famz@redhat.com>
References: <20170705133635.11850-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/6] block: Introduce bdrv_dma_map and
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

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
index 0df3457..784b936 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1974,3 +1974,13 @@ static void blk_root_drained_end(BdrvChild *child)
         }
     }
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
index 2de7c77..988e4db 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2537,3 +2537,27 @@ void bdrv_io_unplug(BlockDriverState *bs)
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
index 4c149ad..f59b50a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -624,4 +624,6 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
                     Error **errp);
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
+void bdrv_dma_map(BlockDriverState *bs, void *host, size_t size);
+void bdrv_dma_unmap(BlockDriverState *bs, void *host);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 15fa602..4092669 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -381,6 +381,10 @@ struct BlockDriver {
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);
 
+    /* Map and unmap a buffer for I/O, as a performance hint to the
+     * driver. */
+    void (*bdrv_dma_map)(BlockDriverState *bs, void *host, size_t size);
+    void (*bdrv_dma_unmap)(BlockDriverState *bs, void *host);
     QLIST_ENTRY(BlockDriver) list;
 };
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 1e05281..5f7ccdb 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -239,4 +239,7 @@ void blk_io_limits_disable(BlockBackend *blk);
 void blk_io_limits_enable(BlockBackend *blk, const char *group);
 void blk_io_limits_update_group(BlockBackend *blk, const char *group);
 
+void blk_dma_map(BlockBackend *blk, void *host, size_t size);
+void blk_dma_unmap(BlockBackend *blk, void *host);
+
 #endif
-- 
2.9.4
