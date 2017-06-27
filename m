Received: from eggs.gnu.org ([2001:4830:134:3::10]:60413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPzG0-0003eQ-9X
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPzFz-0008M0-DC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:46:52 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed, 28 Jun 2017 01:46:15 +0300
Message-Id: <20170627224616.18538-2-el13635@mail.ntua.gr>
In-Reply-To: <20170627224616.18538-1-el13635@mail.ntua.gr>
References: <20170627224616.18538-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 1/2] block: pass bdrv_* methods to bs->file by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

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
 block.c    | 45 ++++++++++++++++++++++++++++++++++-----------
 block/io.c |  4 ++++
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index 69439628..ad11230a 100644
--- a/block.c
+++ b/block.c
@@ -494,6 +494,8 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 
     if (drv && drv->bdrv_probe_blocksizes) {
         return drv->bdrv_probe_blocksizes(bs, bsz);
+    } else if (bs->file && bs->file->bs) {
+        return bdrv_probe_blocksizes(bs->file->bs, bsz);
     }
 
     return -ENOTSUP;
@@ -511,6 +513,8 @@ int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 
     if (drv && drv->bdrv_probe_geometry) {
         return drv->bdrv_probe_geometry(bs, geo);
+    } else if (bs->file && bs->file->bs) {
+        return bdrv_probe_geometry(bs->file->bs, geo);
     }
 
     return -ENOTSUP;
@@ -3406,13 +3410,18 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
 
     assert(child->perm & BLK_PERM_RESIZE);
 
-    if (!drv) {
-        error_setg(errp, "No medium inserted");
-        return -ENOMEDIUM;
-    }
-    if (!drv->bdrv_truncate) {
-        error_setg(errp, "Image format driver does not support resize");
-        return -ENOTSUP;
+    if (!drv || !drv->bdrv_truncate) {
+        if (bs->file && bs->file->bs) {
+            return bdrv_truncate(bs->file, offset, errp);
+        }
+        if (!drv) {
+            error_setg(errp, "No medium inserted");
+            return -ENOMEDIUM;
+        }
+        if (!drv->bdrv_truncate) {
+            error_setg(errp, "Image format driver does not support resize");
+            return -ENOTSUP;
+        }
     }
     if (bs->read_only) {
         error_setg(errp, "Image is read-only");
@@ -3778,6 +3787,9 @@ int bdrv_has_zero_init(BlockDriverState *bs)
     if (bs->drv->bdrv_has_zero_init) {
         return bs->drv->bdrv_has_zero_init(bs);
     }
+    if (bs->file && bs->file->bs) {
+        return bdrv_has_zero_init(bs->file->bs);
+    }
 
     /* safe default */
     return 0;
@@ -3832,10 +3844,15 @@ void bdrv_get_backing_filename(BlockDriverState *bs,
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BlockDriver *drv = bs->drv;
-    if (!drv)
-        return -ENOMEDIUM;
-    if (!drv->bdrv_get_info)
-        return -ENOTSUP;
+    if (!drv || !drv->bdrv_get_info) {
+        if (bs->file && bs->file->bs) {
+            return bdrv_get_info(bs->file->bs, bdi);
+        }
+        if (!drv)
+            return -ENOMEDIUM;
+        if (!drv->bdrv_get_info)
+            return -ENOTSUP;
+    }
     memset(bdi, 0, sizeof(*bdi));
     return drv->bdrv_get_info(bs, bdi);
 }
@@ -4205,6 +4222,8 @@ int bdrv_media_changed(BlockDriverState *bs)
 
     if (drv && drv->bdrv_media_changed) {
         return drv->bdrv_media_changed(bs);
+    } else if (bs->file && bs->file->bs) {
+        bdrv_media_changed(bs->file->bs);
     }
     return -ENOTSUP;
 }
@@ -4218,6 +4237,8 @@ void bdrv_eject(BlockDriverState *bs, bool eject_flag)
 
     if (drv && drv->bdrv_eject) {
         drv->bdrv_eject(bs, eject_flag);
+    } else if (bs->file && bs->file->bs) {
+        bdrv_eject(bs->file->bs, eject_flag);
     }
 }
 
@@ -4233,6 +4254,8 @@ void bdrv_lock_medium(BlockDriverState *bs, bool locked)
 
     if (drv && drv->bdrv_lock_medium) {
         drv->bdrv_lock_medium(bs, locked);
+    } else if (bs->file && bs->file->bs) {
+        bdrv_lock_medium(bs->file->bs, locked);
     }
 }
 
diff --git a/block/io.c b/block/io.c
index c72d7015..c1b73226 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2403,6 +2403,10 @@ int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
 
     bdrv_inc_in_flight(bs);
     if (!drv || (!drv->bdrv_aio_ioctl && !drv->bdrv_co_ioctl)) {
+        if (bs->file && bs->file->bs) {
+            bdrv_dec_in_flight(bs);
+            return bdrv_co_ioctl(bs->file->bs, req, buf);
+        }
         co.ret = -ENOTSUP;
         goto out;
     }
-- 
2.11.0
