Received: from eggs.gnu.org ([2001:4830:134:3::10]:44607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunn-0005Nk-Il
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunm-0001mN-Je
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:43:01 +0200
Message-Id: <20180710154304.18304-22-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/24] block: Use common req handling for discard
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

Reuse the new bdrv_co_write_req_prepare/finish helpers. The variation
here is that discard requests don't affect bs->wr_highest_offset, and it
cannot extend the image.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/block/io.c b/block/io.c
index c88b2b48d7..72cfd9bd16 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1623,15 +1623,32 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
 
     atomic_inc(&bs->write_gen);
 
-    stat64_max(&bs->wr_highest_offset, offset + bytes);
-
+    /*
+     * Discard cannot extend the image, but in error handling cases, such as
+     * when reverting a qcow2 cluster allocation, the discarded range can pass
+     * the end of image file, so we cannot assert about BDRV_TRACKED_DISCARD
+     * here. Instead, just skip it, since semantically a discard request
+     * beyond EOF cannot expand the image anyway.
+     */
     if (ret == 0 &&
-        end_sector > bs->total_sectors) {
+        end_sector > bs->total_sectors &&
+        req->type != BDRV_TRACKED_DISCARD)  {
         bs->total_sectors = end_sector;
         bdrv_parent_cb_resize(bs);
         bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
     }
-    bdrv_set_dirty(bs, offset, bytes);
+    if (req->bytes) {
+        switch (req->type) {
+        case BDRV_TRACKED_WRITE:
+            stat64_max(&bs->wr_highest_offset, offset + bytes);
+            /* fall through, to set dirty bits */
+        case BDRV_TRACKED_DISCARD:
+            bdrv_set_dirty(bs, offset, bytes);
+            break;
+        default:
+            break;
+        }
+    }
 }
 
 /*
@@ -2692,10 +2709,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
     ret = bdrv_check_byte_request(bs, offset, bytes);
     if (ret < 0) {
         return ret;
-    } else if (bs->read_only) {
-        return -EPERM;
     }
-    assert(!(bs->open_flags & BDRV_O_INACTIVE));
 
     /* Do nothing if disabled.  */
     if (!(bs->open_flags & BDRV_O_UNMAP)) {
@@ -2719,7 +2733,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
     bdrv_inc_in_flight(bs);
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_DISCARD);
 
-    ret = notifier_with_return_list_notify(&bs->before_write_notifiers, &req);
+    ret = bdrv_co_write_req_prepare(child, offset, bytes, &req, 0);
     if (ret < 0) {
         goto out;
     }
@@ -2785,8 +2799,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
     }
     ret = 0;
 out:
-    atomic_inc(&bs->write_gen);
-    bdrv_set_dirty(bs, req.offset, req.bytes);
+    bdrv_co_write_req_finish(child, req.offset, req.bytes, &req, ret);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
     return ret;
-- 
2.13.6
