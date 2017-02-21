Received: from eggs.gnu.org ([2001:4830:134:3::10]:43819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvQ-0001M1-DU
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvM-0008S7-Cv
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:47 +0100
Message-Id: <1487689130-30373-52-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 51/54] block: Assertions for write permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This adds assertions that ensure that the necessary write permissions
have been granted before someone attempts to write to a node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 63e4400..4c79745 100644
--- a/block/io.c
+++ b/block/io.c
@@ -925,9 +925,11 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     return drv->bdrv_co_pwritev_compressed(bs, offset, bytes, qiov);
 }
 
-static int coroutine_fn bdrv_co_do_copy_on_readv(BlockDriverState *bs,
+static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
         int64_t offset, unsigned int bytes, QEMUIOVector *qiov)
 {
+    BlockDriverState *bs = child->bs;
+
     /* Perform I/O through a temporary buffer so that users who scribble over
      * their read buffer while the operation is in progress do not end up
      * modifying the image file.  This is critical for zero-copy guest I/O
@@ -943,6 +945,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BlockDriverState *bs,
     size_t skip_bytes;
     int ret;
 
+    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
+
     /* Cover entire cluster so no additional backing file I/O is required when
      * allocating cluster in the image file.
      */
@@ -1051,7 +1055,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         }
 
         if (!ret || pnum != nb_sectors) {
-            ret = bdrv_co_do_copy_on_readv(bs, offset, bytes, qiov);
+            ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov);
             goto out;
         }
     }
@@ -1334,6 +1338,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     assert(!waited || !req->serialising);
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
+    assert(child->perm & BLK_PERM_WRITE);
 
     ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
 
-- 
1.8.3.1
