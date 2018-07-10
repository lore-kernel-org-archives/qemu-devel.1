Received: from eggs.gnu.org ([2001:4830:134:3::10]:50477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmCr-0002Eu-VV
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmCq-000812-RR
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:33:02 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 10 Jul 2018 14:31:24 +0800
Message-Id: <20180710063124.2263-11-famz@redhat.com>
In-Reply-To: <20180710063124.2263-1-famz@redhat.com>
References: <20180710063124.2263-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/10] block: Use common write req handling
 in truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
---
 block/io.c | 57 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/block/io.c b/block/io.c
index e3e2d5286d..abcb8b3de6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1582,14 +1582,24 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
            is_request_serialising_and_aligned(req));
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
-
-    if (flags & BDRV_REQ_WRITE_UNCHANGED) {
-        assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
-    } else {
-        assert(child->perm & BLK_PERM_WRITE);
-    }
     assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
-    return notifier_with_return_list_notify(&bs->before_write_notifiers, req);
+
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
+    }
 }
 
 static inline void coroutine_fn
@@ -1608,8 +1618,9 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
      * beyond EOF cannot expand the image anyway.
      * */
     if (ret == 0 &&
-        end_sector > bs->total_sectors &&
-        req->type != BDRV_TRACKED_DISCARD)  {
+        (req->type == BDRV_TRACKED_TRUNCATE ||
+         end_sector > bs->total_sectors) &&
+        req->type != BDRV_TRACKED_DISCARD) {
         bs->total_sectors = end_sector;
         bdrv_parent_cb_resize(bs);
         bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
@@ -3088,7 +3099,6 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
     int64_t old_size, new_bytes;
     int ret;
 
-    assert(child->perm & BLK_PERM_RESIZE);
 
     /* if bs->drv == NULL, bs is closed, so there's nothing to do here */
     if (!drv) {
@@ -3121,7 +3131,18 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
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
@@ -3133,13 +3154,6 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
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
@@ -3151,9 +3165,10 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
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
2.17.1
