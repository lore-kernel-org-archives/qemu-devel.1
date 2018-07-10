Received: from eggs.gnu.org ([2001:4830:134:3::10]:44647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunq-0005Qw-17
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcuno-0001nb-UO
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:46 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:43:04 +0200
Message-Id: <20180710154304.18304-25-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/24] block: Use common write req handling in
 truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Truncation is the last to convert from open coded req handling to
reusing helpers. This time the permission check in prepare has to adapt
to the new caller: it checks a different permission bit, and doesn't
trigger the before write notifier.

Also, truncation should always trigger a bs->total_sectors update and in
turn call parent resize_cb. Update the condition in finish helper, too.

It's intended to do a duplicated bs->read_only check before calling
bdrv_co_write_req_prepare() so that we can be more informative with the
error message, as bdrv_co_write_req_prepare() doesn't have Error
parameter.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 55 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/block/io.c b/block/io.c
index 77d38ca1d3..7100344c7b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1604,14 +1604,24 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
            is_request_serialising_and_aligned(req));
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
+    assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
 
-    if (flags & BDRV_REQ_WRITE_UNCHANGED) {
-        assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
-    } else {
-        assert(child->perm & BLK_PERM_WRITE);
+    switch (req->type) {
+    case BDRV_TRACKED_WRITE:
+    case BDRV_TRACKED_DISCARD:
+        if (flags & BDRV_REQ_WRITE_UNCHANGED) {
+            assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
+        } else {
+            assert(child->perm & BLK_PERM_WRITE);
+        }
+        return notifier_with_return_list_notify(&bs->before_write_notifiers,
+                                                req);
+    case BDRV_TRACKED_TRUNCATE:
+        assert(child->perm & BLK_PERM_RESIZE);
+        return 0;
+    default:
+        abort();
     }
-    assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
-    return notifier_with_return_list_notify(&bs->before_write_notifiers, req);
 }
 
 static inline void coroutine_fn
@@ -1631,8 +1641,9 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
      * beyond EOF cannot expand the image anyway.
      */
     if (ret == 0 &&
-        end_sector > bs->total_sectors &&
-        req->type != BDRV_TRACKED_DISCARD)  {
+        (req->type == BDRV_TRACKED_TRUNCATE ||
+         end_sector > bs->total_sectors) &&
+        req->type != BDRV_TRACKED_DISCARD) {
         bs->total_sectors = end_sector;
         bdrv_parent_cb_resize(bs);
         bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
@@ -3111,7 +3122,6 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
     int64_t old_size, new_bytes;
     int ret;
 
-    assert(child->perm & BLK_PERM_RESIZE);
 
     /* if bs->drv == NULL, bs is closed, so there's nothing to do here */
     if (!drv) {
@@ -3144,7 +3154,18 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
      * concurrently or they might be overwritten by preallocation. */
     if (new_bytes) {
         mark_request_serialising(&req, 1);
-        wait_serialising_requests(&req);
+    }
+    if (bs->read_only) {
+        error_setg(errp, "Image is read-only");
+        ret = -EACCES;
+        goto out;
+    }
+    ret = bdrv_co_write_req_prepare(child, offset - new_bytes, new_bytes, &req,
+                                    0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Failed to prepare request for truncation");
+        goto out;
     }
 
     if (!drv->bdrv_co_truncate) {
@@ -3156,13 +3177,6 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
         ret = -ENOTSUP;
         goto out;
     }
-    if (bs->read_only) {
-        error_setg(errp, "Image is read-only");
-        ret = -EACCES;
-        goto out;
-    }
-
-    assert(!(bs->open_flags & BDRV_O_INACTIVE));
 
     ret = drv->bdrv_co_truncate(bs, offset, prealloc, errp);
     if (ret < 0) {
@@ -3174,9 +3188,10 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
     } else {
         offset = bs->total_sectors * BDRV_SECTOR_SIZE;
     }
-    bdrv_dirty_bitmap_truncate(bs, offset);
-    bdrv_parent_cb_resize(bs);
-    atomic_inc(&bs->write_gen);
+    /* It's possible that truncation succeeded but refresh_total_sectors
+     * failed, but the latter doesn't affect how we should finish the request.
+     * Pass 0 as the last parameter so that dirty bitmaps etc. are handled. */
+    bdrv_co_write_req_finish(child, offset - new_bytes, new_bytes, &req, 0);
 
 out:
     tracked_request_end(&req);
-- 
2.13.6
