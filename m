Received: from eggs.gnu.org ([2001:4830:134:3::10]:42953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXotp-0001vm-Eb
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXotm-0003Pq-GR
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:24:53 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Jun 2018 16:24:33 +0200
Message-Id: <20180626142434.22090-6-kwolf@redhat.com>
In-Reply-To: <20180626142434.22090-1-kwolf@redhat.com>
References: <20180626142434.22090-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] block: Use tracked request for truncate
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

When growing an image, block drivers (especially protocol drivers) may
initialise the newly added area. I/O requests to the same area need to
wait for this initialisation to be completed so that data writes don't
get overwritten and reads don't read uninitialised data.

To avoid overhead in the fast I/O path by adding new locking in the
protocol drivers and to restrict the impact to requests that actually
touch the new area, reuse the existing tracked request infrastructure in
block/io.c and mark all discard requests as serialising.

With this change, it is safe for protocol drivers to make
.bdrv_co_truncate actually asynchronous.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  1 +
 block/io.c                | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 740166a996..af71b414be 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -63,6 +63,7 @@ enum BdrvTrackedRequestType {
     BDRV_TRACKED_READ,
     BDRV_TRACKED_WRITE,
     BDRV_TRACKED_DISCARD,
+    BDRV_TRACKED_TRUNCATE,
 };
 
 typedef struct BdrvTrackedRequest {
diff --git a/block/io.c b/block/io.c
index 7e87a42b8e..01a3c4eac5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3039,6 +3039,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
+    BdrvTrackedRequest req;
+    int64_t old_size, new_bytes;
     int ret;
 
     assert(child->perm & BLK_PERM_RESIZE);
@@ -3053,7 +3055,28 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
         return -EINVAL;
     }
 
+    old_size = bdrv_getlength(bs);
+    if (old_size < 0) {
+        error_setg_errno(errp, -old_size, "Failed to get old image size");
+        return old_size;
+    }
+
+    if (offset > old_size) {
+        new_bytes = offset - old_size;
+    } else {
+        new_bytes = 0;
+    }
+
     bdrv_inc_in_flight(bs);
+    tracked_request_begin(&req, bs, offset, new_bytes, BDRV_TRACKED_TRUNCATE);
+
+    /* If we are growing the image and potentially using preallocation for the
+     * new area, we need to make sure that no write requests are made to it
+     * concurrently or they might be overwritten by preallocation. */
+    if (new_bytes) {
+        mark_request_serialising(&req, 1);
+        wait_serialising_requests(&req);
+    }
 
     if (!drv->bdrv_co_truncate) {
         if (bs->file && drv->is_filter) {
@@ -3087,7 +3110,9 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
     atomic_inc(&bs->write_gen);
 
 out:
+    tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
+
     return ret;
 }
 
-- 
2.13.6
