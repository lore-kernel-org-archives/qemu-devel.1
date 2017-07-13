Received: from eggs.gnu.org ([2001:4830:134:3::10]:47139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVg4r-0001LY-I5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVg4q-0005vQ-FV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:30:53 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Thu, 13 Jul 2017 18:30:25 +0300
Message-Id: <20170713153028.31065-2-el13635@mail.ntua.gr>
In-Reply-To: <20170713153028.31065-1-el13635@mail.ntua.gr>
References: <20170713153028.31065-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v6 1/4] block: pass bdrv_* methods to bs->file
 by default in block filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The following functions fail if bs->drv is a filter and does not
implement them:

bdrv_probe_blocksizes
bdrv_probe_geometry
bdrv_truncate
bdrv_has_zero_init
bdrv_get_info

Instead, the call should be passed to bs->file if it exists, to allow
filter drivers to support those methods without implementing them. This
commit makes `drv->is_filter = true` imply that these callbacks will be
forwarded to bs->file by default, so disabling support for these
functions must be done explicitly.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c                   | 21 +++++++++++++++++++--
 include/block/block_int.h |  6 +++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index d24ae85868..dd409bfb5b 100644
--- a/block.c
+++ b/block.c
@@ -494,6 +494,8 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 
     if (drv && drv->bdrv_probe_blocksizes) {
         return drv->bdrv_probe_blocksizes(bs, bsz);
+    } else if (drv && drv->is_filter && bs->file) {
+        return bdrv_probe_blocksizes(bs->file->bs, bsz);
     }
 
     return -ENOTSUP;
@@ -511,6 +513,8 @@ int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 
     if (drv && drv->bdrv_probe_geometry) {
         return drv->bdrv_probe_geometry(bs, geo);
+    } else if (drv && drv->is_filter && bs->file) {
+        return bdrv_probe_geometry(bs->file->bs, geo);
     }
 
     return -ENOTSUP;
@@ -3420,11 +3424,15 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
 
     assert(child->perm & BLK_PERM_RESIZE);
 
+    /* if bs->drv == NULL, bs is closed, so there's nothing to do here */
     if (!drv) {
         error_setg(errp, "No medium inserted");
         return -ENOMEDIUM;
     }
     if (!drv->bdrv_truncate) {
+        if (bs->file && drv->is_filter) {
+            return bdrv_truncate(bs->file, offset, prealloc, errp);
+        }
         error_setg(errp, "Image format driver does not support resize");
         return -ENOTSUP;
     }
@@ -3761,6 +3769,9 @@ int bdrv_has_zero_init(BlockDriverState *bs)
     if (bs->drv->bdrv_has_zero_init) {
         return bs->drv->bdrv_has_zero_init(bs);
     }
+    if (bs->file && bs->drv->is_filter) {
+        return bdrv_has_zero_init(bs->file->bs);
+    }
 
     /* safe default */
     return 0;
@@ -3815,10 +3826,16 @@ void bdrv_get_backing_filename(BlockDriverState *bs,
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BlockDriver *drv = bs->drv;
-    if (!drv)
+    /* if bs->drv == NULL, bs is closed, so there's nothing to do here */
+    if (!drv) {
         return -ENOMEDIUM;
-    if (!drv->bdrv_get_info)
+    }
+    if (!drv->bdrv_get_info) {
+        if (bs->file && drv->is_filter) {
+            return bdrv_get_info(bs->file->bs, bdi);
+        }
         return -ENOTSUP;
+    }
     memset(bdi, 0, sizeof(*bdi));
     return drv->bdrv_get_info(bs, bdi);
 }
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 669a2797fd..37388ccb18 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -87,7 +87,11 @@ struct BlockDriver {
     const char *format_name;
     int instance_size;
 
-    /* set to true if the BlockDriver is a block filter */
+    /* set to true if the BlockDriver is a block filter. Block filters pass
+     * certain callbacks that refer to data (see block.c) to their bs->file if
+     * the driver doesn't implement them. Drivers that do not wish to forward
+     * must implement them and return -ENOTSUP.
+     */
     bool is_filter;
     /* for snapshots block filter like Quorum can implement the
      * following recursive callback.
-- 
2.11.0
