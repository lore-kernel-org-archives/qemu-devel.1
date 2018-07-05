Received: from eggs.gnu.org ([2001:4830:134:3::10]:53341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faypn-0001bx-OW
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faypm-00013i-Fg
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:37:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  5 Jul 2018 15:36:56 +0800
Message-Id: <20180705073701.10558-5-famz@redhat.com>
In-Reply-To: <20180705073701.10558-1-famz@redhat.com>
References: <20180705073701.10558-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/9] block: Extract common write req handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

As a mechanical refactoring patch, this is the first step towards
unified and more correct write code paths. This is helpful because
multiple BlockDriverState fields need to be updated after modifying
image data, and it's hard to maintain in multiple places such as copy
offload, discard and truncate.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 70 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/block/io.c b/block/io.c
index 443a8584c4..03d9eb0a65 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1538,6 +1538,48 @@ fail:
     return ret;
 }
 
+static inline int coroutine_fn
+bdrv_co_write_req_prepare(BdrvChild *child, BdrvTrackedRequest *req, int flags)
+{
+    BlockDriverState *bs = child->bs;
+    bool waited;
+    int64_t end_sector = DIV_ROUND_UP(req->offset + req->bytes, BDRV_SECTOR_SIZE);
+
+    if (bs->read_only) {
+        return -EPERM;
+    }
+    assert(!(bs->open_flags & BDRV_O_INACTIVE));
+    assert((bs->open_flags & BDRV_O_NO_IO) == 0);
+    assert(!(flags & ~BDRV_REQ_MASK));
+    waited = wait_serialising_requests(req);
+    assert(!waited || !req->serialising);
+    assert(req->overlap_offset <= req->offset);
+    assert(req->offset + req->bytes <= req->overlap_offset + req->overlap_bytes);
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
+bdrv_co_write_req_finish(BdrvChild *child, BdrvTrackedRequest *req, int ret)
+{
+    int64_t end_sector = DIV_ROUND_UP(req->offset + req->bytes, BDRV_SECTOR_SIZE);
+    BlockDriverState *bs = child->bs;
+
+    atomic_inc(&bs->write_gen);
+    bdrv_set_dirty(bs, req->offset, req->bytes);
+
+    stat64_max(&bs->wr_highest_offset, req->offset + req->bytes);
+
+    if (ret == 0) {
+        bs->total_sectors = MAX(bs->total_sectors, end_sector);
+    }
+}
+
 /*
  * Forwards an already correctly aligned write request to the BlockDriver,
  * after possibly fragmenting it.
@@ -1548,10 +1590,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
-    bool waited;
     int ret;
 
-    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
     uint64_t bytes_remaining = bytes;
     int max_transfer;
 
@@ -1567,23 +1607,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
     assert(!qiov || bytes == qiov->size);
-    assert((bs->open_flags & BDRV_O_NO_IO) == 0);
-    assert(!(flags & ~BDRV_REQ_MASK));
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
 
-    waited = wait_serialising_requests(req);
-    assert(!waited || !req->serialising);
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
+    ret = bdrv_co_write_req_prepare(child, req, flags);
 
     if (!ret && bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
         !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
@@ -1632,15 +1659,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
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
+    bdrv_co_write_req_finish(child, req, ret);
 
     return ret;
 }
@@ -1755,10 +1777,6 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
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
2.17.1
