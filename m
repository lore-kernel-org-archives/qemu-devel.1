Received: from eggs.gnu.org ([2001:4830:134:3::10]:56008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvJ-0004b8-S2
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvI-0005eo-O5
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:53 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Tue, 19 Jun 2018 16:43:34 +0300
Message-ID: <1529415820-7750-3-git-send-email-ari@tuxera.com>
In-Reply-To: <1529415820-7750-1-git-send-email-ari@tuxera.com>
References: <1529415820-7750-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 2/8] block: Add a mechanism for passing a
 block driver a block configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>

A block driver may need to know about the block configuration, most
critically the sector sizes, of a block backend for alignment purposes
or for some other reason. It doesn't seem like qemu has an existing
mechanism for a block backend to convey the required information to
the relevant block driver when it is being realized.

The need for this mechanism rises from the fact that a drive may not
have a backend at the time it is created, as devices are created after
drives during qemu startup. Therefore, a driver requiring information
about the block configuration can get this information when a backend
is created for it at the earliest. The most natural place for this to
take place seems to be in the realization functions of the various
block device drivers, such as scsi-hd. The interface proposed here
allows the block driver to receive information about the block
configuration and the associated backend through a new callback.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 block/io.c                | 22 ++++++++++++++++++++++
 hw/block/block.c          | 12 +++++++++++-
 include/block/block.h     | 10 ++++++++++
 include/block/block_int.h |  9 +++++++++
 include/hw/block/block.h  |  1 +
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index b7beaee..3a06843 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2932,3 +2932,25 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
     bdrv_dec_in_flight(dst_bs);
     return ret;
 }
+
+void bdrv_apply_blkconf(BlockDriverState *bs, BlockConf *conf)
+{
+    BlockDriver *drv = bs->drv;
+
+    if (!drv) {
+        return;
+    }
+
+    if (drv->bdrv_apply_blkconf) {
+        drv->bdrv_apply_blkconf(bs, conf);
+        return;
+    }
+
+    if (bs->file && bs->file->bs) {
+        bdrv_apply_blkconf(bs->file->bs, conf);
+    }
+
+    if (bs->drv->supports_backing && backing_bs(bs)) {
+        bdrv_apply_blkconf(backing_bs(bs), conf);
+    }
+}
diff --git a/hw/block/block.c b/hw/block/block.c
index cf0eb82..607b4fc 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -25,7 +25,7 @@ void blkconf_blocksizes(BlockConf *conf)
     /* fill in detected values if they are not defined via qemu command line */
     if (!conf->physical_block_size) {
         if (!backend_ret) {
-           conf->physical_block_size = blocksizes.phys;
+            conf->physical_block_size = blocksizes.phys;
         } else {
             conf->physical_block_size = BDRV_SECTOR_SIZE;
         }
@@ -39,6 +39,16 @@ void blkconf_blocksizes(BlockConf *conf)
     }
 }
 
+void blkconf_apply_to_blkdrv(BlockConf *conf)
+{
+    BlockBackend *blk = conf->blk;
+    BlockDriverState *bs = blk_bs(blk);
+
+    if (bs) {
+        bdrv_apply_blkconf(bs, conf);
+    }
+}
+
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp)
 {
diff --git a/include/block/block.h b/include/block/block.h
index 6466ce0..358127a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -10,6 +10,7 @@
 #include "block/dirty-bitmap.h"
 #include "block/blockjob.h"
 #include "qemu/hbitmap.h"
+#include "hw/block/block.h"
 
 /* block.c */
 typedef struct BlockDriver BlockDriver;
@@ -652,4 +653,13 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host);
 int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
                                     BdrvChild *dst, uint64_t dst_offset,
                                     uint64_t bytes, BdrvRequestFlags flags);
+
+/*
+ * bdrv_apply_blkconf:
+ *
+ * Recursively finds the highest-level block drivers among the files and
+ * backing files that accept a block configuration and applies the given block
+ * configuration to them.
+ */
+void bdrv_apply_blkconf(BlockDriverState *bs, BlockConf *conf);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 327e478..74c470e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -465,6 +465,15 @@ struct BlockDriver {
     void (*bdrv_abort_perm_update)(BlockDriverState *bs);
 
     /**
+     * Called to inform the driver of the block configuration of the virtual
+     * block device.
+     *
+     * This function is called by a block device realization function if the
+     * device wants to inform the block driver of its block configuration.
+     */
+    void (*bdrv_apply_blkconf)(BlockDriverState *bs, BlockConf *conf);
+
+    /**
      * Returns in @nperm and @nshared the permissions that the driver for @bs
      * needs on its child @c, based on the cumulative permissions requested by
      * the parents in @parent_perm and @parent_shared.
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index e9f9e22..de74d4f 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -76,6 +76,7 @@ bool blkconf_geometry(BlockConf *conf, int *trans,
                       unsigned cyls_max, unsigned heads_max, unsigned secs_max,
                       Error **errp);
 void blkconf_blocksizes(BlockConf *conf);
+void blkconf_apply_to_blkdrv(BlockConf *conf);
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp);
 
-- 
2.7.4
