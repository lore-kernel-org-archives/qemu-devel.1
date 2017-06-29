Received: from eggs.gnu.org ([2001:4830:134:3::10]:45341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQeQQ-0002dN-Qc
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQeQP-0005Qg-QD
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:44:22 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Thu, 29 Jun 2017 21:43:18 +0300
Message-Id: <20170629184320.7151-2-el13635@mail.ntua.gr>
In-Reply-To: <20170629184320.7151-1-el13635@mail.ntua.gr>
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v2 1/3] block: pass bdrv_* methods to bs->file
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The following functions fail if bs->drv does not implement them:

bdrv_probe_blocksizes
bdrv_probe_geometry
bdrv_truncate
bdrv_has_zero_init
bdrv_get_info
bdrv_media_changed
bdrv_eject
bdrv_lock_medium
bdrv_co_ioctl

Instead, the call should be passed to bs->file if it exists, to allow
filter drivers to support those methods without implementing them.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c    | 27 +++++++++++++++++++++++++--
 block/io.c |  5 +++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 69439628..9e8d34ad 100644
--- a/block.c
+++ b/block.c
@@ -494,6 +494,8 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 
     if (drv && drv->bdrv_probe_blocksizes) {
         return drv->bdrv_probe_blocksizes(bs, bsz);
+    } else if (drv && bs->file && bs->file->bs) {
+        return bdrv_probe_blocksizes(bs->file->bs, bsz);
     }
 
     return -ENOTSUP;
@@ -511,6 +513,8 @@ int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 
     if (drv && drv->bdrv_probe_geometry) {
         return drv->bdrv_probe_geometry(bs, geo);
+    } else if (drv && bs->file && bs->file->bs) {
+        return bdrv_probe_geometry(bs->file->bs, geo);
     }
 
     return -ENOTSUP;
@@ -3406,11 +3410,15 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
 
     assert(child->perm & BLK_PERM_RESIZE);
 
+    /* if bs->drv == NULL, bs is closed, so there's nothing to do here */
     if (!drv) {
         error_setg(errp, "No medium inserted");
         return -ENOMEDIUM;
     }
     if (!drv->bdrv_truncate) {
+        if (bs->file && bs->file->bs) {
+            return bdrv_truncate(bs->file, offset, errp);
+        }
         error_setg(errp, "Image format driver does not support resize");
         return -ENOTSUP;
     }
@@ -3778,6 +3786,9 @@ int bdrv_has_zero_init(BlockDriverState *bs)
     if (bs->drv->bdrv_has_zero_init) {
         return bs->drv->bdrv_has_zero_init(bs);
     }
+    if (bs->file && bs->file->bs) {
+        return bdrv_has_zero_init(bs->file->bs);
+    }
 
     /* safe default */
     return 0;
@@ -3832,10 +3843,16 @@ void bdrv_get_backing_filename(BlockDriverState *bs,
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
+        if (bs->file && bs->file->bs) {
+            return bdrv_get_info(bs->file->bs, bdi);
+        }
         return -ENOTSUP;
+    }
     memset(bdi, 0, sizeof(*bdi));
     return drv->bdrv_get_info(bs, bdi);
 }
@@ -4205,6 +4222,8 @@ int bdrv_media_changed(BlockDriverState *bs)
 
     if (drv && drv->bdrv_media_changed) {
         return drv->bdrv_media_changed(bs);
+    } else if (drv && bs->file && bs->file->bs) {
+        bdrv_media_changed(bs->file->bs);
     }
     return -ENOTSUP;
 }
@@ -4218,6 +4237,8 @@ void bdrv_eject(BlockDriverState *bs, bool eject_flag)
 
     if (drv && drv->bdrv_eject) {
         drv->bdrv_eject(bs, eject_flag);
+    } else if (drv && bs->file && bs->file->bs) {
+        bdrv_eject(bs->file->bs, eject_flag);
     }
 }
 
@@ -4233,6 +4254,8 @@ void bdrv_lock_medium(BlockDriverState *bs, bool locked)
 
     if (drv && drv->bdrv_lock_medium) {
         drv->bdrv_lock_medium(bs, locked);
+    } else if (drv && bs->file && bs->file->bs) {
+        bdrv_lock_medium(bs->file->bs, locked);
     }
 }
 
diff --git a/block/io.c b/block/io.c
index c72d7015..a1aee01d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2401,6 +2401,11 @@ int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
     };
     BlockAIOCB *acb;
 
+    if (drv && !drv->bdrv_aio_ioctl && !drv->bdrv_co_ioctl &&
+        bs->file && bs->file->bs) {
+        return bdrv_co_ioctl(bs->file->bs, req, buf);
+    }
+
     bdrv_inc_in_flight(bs);
     if (!drv || (!drv->bdrv_aio_ioctl && !drv->bdrv_co_ioctl)) {
         co.ret = -ENOTSUP;
-- 
2.11.0
