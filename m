Received: from eggs.gnu.org ([2001:4830:134:3::10]:44622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunn-0005OG-Uq
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunm-0001mV-Rx
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:59 +0200
Message-Id: <20180710154304.18304-20-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/24] block: Extract common write req handling
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

As a mechanical refactoring patch, this is the first step towards
unified and more correct write code paths. This is helpful because
multiple BlockDriverState fields need to be updated after modifying
image data, and it's hard to maintain in multiple places such as copy
offload, discard and truncate.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 91 +++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 34 deletions(-)

diff --git a/block/io.c b/block/io.c
index 6293612e73..313fe0776c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1575,6 +1575,61 @@ fail:
     return ret;
 }
 
+static inline int coroutine_fn
+bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
+                          BdrvTrackedRequest *req, int flags)
+{
+    BlockDriverState *bs = child->bs;
+    bool waited;
+    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
+
+    if (bs->read_only) {
+        return -EPERM;
+    }
+
+    /* BDRV_REQ_NO_SERIALISING is only for read operation */
+    assert(!(flags & BDRV_REQ_NO_SERIALISING));
+    assert(!(bs->open_flags & BDRV_O_INACTIVE));
+    assert((bs->open_flags & BDRV_O_NO_IO) == 0);
+    assert(!(flags & ~BDRV_REQ_MASK));
+
+    if (flags & BDRV_REQ_SERIALISING) {
+        mark_request_serialising(req, bdrv_get_cluster_size(bs));
+    }
+
+    waited = wait_serialising_requests(req);
+
+    assert(!waited || !req->serialising ||
+           is_request_serialising_and_aligned(req));
+    assert(req->overlap_offset <= offset);
+    assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
+
+    if (flags & BDRV_REQ_WRITE_UNCHANGED) {
+        assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
+    } else {
+        assert(child->perm & BLK_PERM_WRITE);
+    }
+    assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
+    return notifier_with_return_list_notify(&bs->before_write_notifiers, req);
+}
+
+static inline void coroutine_fn
+bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
+                         BdrvTrackedRequest *req, int ret)
+{
+    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
+    BlockDriverState *bs = child->bs;
+
+    atomic_inc(&bs->write_gen);
+    bdrv_set_dirty(bs, offset, bytes);
+
+    stat64_max(&bs->wr_highest_offset, offset + bytes);
+
+    if (ret == 0) {
+        bs->total_sectors = MAX(bs->total_sectors, end_sector);
+    }
+}
+
 /*
  * Forwards an already correctly aligned write request to the BlockDriver,
  * after possibly fragmenting it.
@@ -1585,10 +1640,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
-    bool waited;
     int ret;
 
-    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
     uint64_t bytes_remaining = bytes;
     int max_transfer;
 
@@ -1604,31 +1657,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
     assert(!qiov || bytes == qiov->size);
-    assert((bs->open_flags & BDRV_O_NO_IO) == 0);
-    assert(!(flags & ~BDRV_REQ_MASK));
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
 
-    /* BDRV_REQ_NO_SERIALISING is only for read operation */
-    assert(!(flags & BDRV_REQ_NO_SERIALISING));
-
-    if (flags & BDRV_REQ_SERIALISING) {
-        mark_request_serialising(req, bdrv_get_cluster_size(bs));
-    }
-
-    waited = wait_serialising_requests(req);
-    assert(!waited || !req->serialising ||
-           is_request_serialising_and_aligned(req));
-    assert(req->overlap_offset <= offset);
-    assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
-    if (flags & BDRV_REQ_WRITE_UNCHANGED) {
-        assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
-    } else {
-        assert(child->perm & BLK_PERM_WRITE);
-    }
-    assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
-
-    ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
+    ret = bdrv_co_write_req_prepare(child, offset, bytes, req, flags);
 
     if (!ret && bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
         !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
@@ -1677,15 +1709,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     }
     bdrv_debug_event(bs, BLKDBG_PWRITEV_DONE);
 
-    atomic_inc(&bs->write_gen);
-    bdrv_set_dirty(bs, offset, bytes);
-
-    stat64_max(&bs->wr_highest_offset, offset + bytes);
-
     if (ret >= 0) {
-        bs->total_sectors = MAX(bs->total_sectors, end_sector);
         ret = 0;
     }
+    bdrv_co_write_req_finish(child, offset, bytes, req, ret);
 
     return ret;
 }
@@ -1800,10 +1827,6 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     if (!bs->drv) {
         return -ENOMEDIUM;
     }
-    if (bs->read_only) {
-        return -EPERM;
-    }
-    assert(!(bs->open_flags & BDRV_O_INACTIVE));
 
     ret = bdrv_check_byte_request(bs, offset, bytes);
     if (ret < 0) {
-- 
2.13.6
