Received: from eggs.gnu.org ([2001:4830:134:3::10]:42951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXotp-0001vl-Cx
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXotm-0003QB-Hr
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:24:53 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Jun 2018 16:24:32 +0200
Message-Id: <20180626142434.22090-5-kwolf@redhat.com>
In-Reply-To: <20180626142434.22090-1-kwolf@redhat.com>
References: <20180626142434.22090-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] block: Move bdrv_truncate()
 implementation to io.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

This moves the bdrv_truncate() implementation from block.c to block/io.c
so it can have access to the tracked requests infrastructure.

This involves making refresh_total_sectors() public (in block_int.h).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |   2 +
 block.c                   | 111 +---------------------------------------------
 block/io.c                | 109 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 110 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index c653ee663a..740166a996 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1157,4 +1157,6 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
                                        BdrvChild *dst, uint64_t dst_offset,
                                        uint64_t bytes, BdrvRequestFlags flags);
 
+int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
+
 #endif /* BLOCK_INT_H */
diff --git a/block.c b/block.c
index f761bc85d5..70a46fdd84 100644
--- a/block.c
+++ b/block.c
@@ -725,7 +725,7 @@ static int find_image_format(BlockBackend *file, const char *filename,
  * Set the current 'total_sectors' value
  * Return 0 on success, -errno on error.
  */
-static int refresh_total_sectors(BlockDriverState *bs, int64_t hint)
+int refresh_total_sectors(BlockDriverState *bs, int64_t hint)
 {
     BlockDriver *drv = bs->drv;
 
@@ -2226,16 +2226,6 @@ static void bdrv_parent_cb_change_media(BlockDriverState *bs, bool load)
     }
 }
 
-static void bdrv_parent_cb_resize(BlockDriverState *bs)
-{
-    BdrvChild *c;
-    QLIST_FOREACH(c, &bs->parents, next_parent) {
-        if (c->role->resize) {
-            c->role->resize(c);
-        }
-    }
-}
-
 /*
  * Sets the backing file link of a BDS. A new reference is created; callers
  * which don't need their own reference any more must call bdrv_unref().
@@ -3786,105 +3776,6 @@ exit:
 }
 
 /**
- * Truncate file to 'offset' bytes (needed only for file protocols)
- */
-int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
-                                  PreallocMode prealloc, Error **errp)
-{
-    BlockDriverState *bs = child->bs;
-    BlockDriver *drv = bs->drv;
-    int ret;
-
-    assert(child->perm & BLK_PERM_RESIZE);
-
-    /* if bs->drv == NULL, bs is closed, so there's nothing to do here */
-    if (!drv) {
-        error_setg(errp, "No medium inserted");
-        return -ENOMEDIUM;
-    }
-    if (offset < 0) {
-        error_setg(errp, "Image size cannot be negative");
-        return -EINVAL;
-    }
-
-    bdrv_inc_in_flight(bs);
-
-    if (!drv->bdrv_co_truncate) {
-        if (bs->file && drv->is_filter) {
-            ret = bdrv_co_truncate(bs->file, offset, prealloc, errp);
-            goto out;
-        }
-        error_setg(errp, "Image format driver does not support resize");
-        ret = -ENOTSUP;
-        goto out;
-    }
-    if (bs->read_only) {
-        error_setg(errp, "Image is read-only");
-        ret = -EACCES;
-        goto out;
-    }
-
-    assert(!(bs->open_flags & BDRV_O_INACTIVE));
-
-    ret = drv->bdrv_co_truncate(bs, offset, prealloc, errp);
-    if (ret < 0) {
-        goto out;
-    }
-    ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not refresh total sector count");
-    } else {
-        offset = bs->total_sectors * BDRV_SECTOR_SIZE;
-    }
-    bdrv_dirty_bitmap_truncate(bs, offset);
-    bdrv_parent_cb_resize(bs);
-    atomic_inc(&bs->write_gen);
-
-out:
-    bdrv_dec_in_flight(bs);
-    return ret;
-}
-
-typedef struct TruncateCo {
-    BdrvChild *child;
-    int64_t offset;
-    PreallocMode prealloc;
-    Error **errp;
-    int ret;
-} TruncateCo;
-
-static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
-{
-    TruncateCo *tco = opaque;
-    tco->ret = bdrv_co_truncate(tco->child, tco->offset, tco->prealloc,
-                                tco->errp);
-}
-
-int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
-                  Error **errp)
-{
-    Coroutine *co;
-    TruncateCo tco = {
-        .child      = child,
-        .offset     = offset,
-        .prealloc   = prealloc,
-        .errp       = errp,
-        .ret        = NOT_DONE,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_truncate_co_entry(&tco);
-    } else {
-        co = qemu_coroutine_create(bdrv_truncate_co_entry, &tco);
-        qemu_coroutine_enter(co);
-        BDRV_POLL_WHILE(child->bs, tco.ret == NOT_DONE);
-    }
-
-    return tco.ret;
-}
-
-/**
  * Length of a allocated file in bytes. Sparse files are counted by actual
  * allocated space. Return < 0 if error or unknown.
  */
diff --git a/block/io.c b/block/io.c
index ef4fedd364..7e87a42b8e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3020,3 +3020,112 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
     bdrv_dec_in_flight(dst_bs);
     return ret;
 }
+
+static void bdrv_parent_cb_resize(BlockDriverState *bs)
+{
+    BdrvChild *c;
+    QLIST_FOREACH(c, &bs->parents, next_parent) {
+        if (c->role->resize) {
+            c->role->resize(c);
+        }
+    }
+}
+
+/**
+ * Truncate file to 'offset' bytes (needed only for file protocols)
+ */
+int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
+                                  PreallocMode prealloc, Error **errp)
+{
+    BlockDriverState *bs = child->bs;
+    BlockDriver *drv = bs->drv;
+    int ret;
+
+    assert(child->perm & BLK_PERM_RESIZE);
+
+    /* if bs->drv == NULL, bs is closed, so there's nothing to do here */
+    if (!drv) {
+        error_setg(errp, "No medium inserted");
+        return -ENOMEDIUM;
+    }
+    if (offset < 0) {
+        error_setg(errp, "Image size cannot be negative");
+        return -EINVAL;
+    }
+
+    bdrv_inc_in_flight(bs);
+
+    if (!drv->bdrv_co_truncate) {
+        if (bs->file && drv->is_filter) {
+            ret = bdrv_co_truncate(bs->file, offset, prealloc, errp);
+            goto out;
+        }
+        error_setg(errp, "Image format driver does not support resize");
+        ret = -ENOTSUP;
+        goto out;
+    }
+    if (bs->read_only) {
+        error_setg(errp, "Image is read-only");
+        ret = -EACCES;
+        goto out;
+    }
+
+    assert(!(bs->open_flags & BDRV_O_INACTIVE));
+
+    ret = drv->bdrv_co_truncate(bs, offset, prealloc, errp);
+    if (ret < 0) {
+        goto out;
+    }
+    ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not refresh total sector count");
+    } else {
+        offset = bs->total_sectors * BDRV_SECTOR_SIZE;
+    }
+    bdrv_dirty_bitmap_truncate(bs, offset);
+    bdrv_parent_cb_resize(bs);
+    atomic_inc(&bs->write_gen);
+
+out:
+    bdrv_dec_in_flight(bs);
+    return ret;
+}
+
+typedef struct TruncateCo {
+    BdrvChild *child;
+    int64_t offset;
+    PreallocMode prealloc;
+    Error **errp;
+    int ret;
+} TruncateCo;
+
+static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
+{
+    TruncateCo *tco = opaque;
+    tco->ret = bdrv_co_truncate(tco->child, tco->offset, tco->prealloc,
+                                tco->errp);
+}
+
+int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
+                  Error **errp)
+{
+    Coroutine *co;
+    TruncateCo tco = {
+        .child      = child,
+        .offset     = offset,
+        .prealloc   = prealloc,
+        .errp       = errp,
+        .ret        = NOT_DONE,
+    };
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_truncate_co_entry(&tco);
+    } else {
+        co = qemu_coroutine_create(bdrv_truncate_co_entry, &tco);
+        qemu_coroutine_enter(co);
+        BDRV_POLL_WHILE(child->bs, tco.ret == NOT_DONE);
+    }
+
+    return tco.ret;
+}
-- 
2.13.6
