Received: from eggs.gnu.org ([2001:4830:134:3::10]:39027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4b-0006s3-N9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4a-0001ge-Ly
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:09 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:22 +0200
Message-Id: <20180515154033.19899-27-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 26/37] block: Add BDRV_REQ_WRITE_UNCHANGED flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

This flag signifies that a write request will not change the visible
disk content.  With this flag set, it is sufficient to have the
BLK_PERM_WRITE_UNCHANGED permission instead of BLK_PERM_WRITE.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20180421132929.21610-4-mreitz@redhat.com
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 6 +++++-
 block/io.c            | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 397b5e8d44..3894edda9d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -54,8 +54,12 @@ typedef enum {
     BDRV_REQ_FUA                = 0x10,
     BDRV_REQ_WRITE_COMPRESSED   = 0x20,
 
+    /* Signifies that this write request will not change the visible disk
+     * content. */
+    BDRV_REQ_WRITE_UNCHANGED    = 0x40,
+
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x3f,
+    BDRV_REQ_MASK               = 0x7f,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
diff --git a/block/io.c b/block/io.c
index 4fad5ac2fe..9e8449e795 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1504,7 +1504,11 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     assert(!waited || !req->serialising);
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
-    assert(child->perm & BLK_PERM_WRITE);
+    if (flags & BDRV_REQ_WRITE_UNCHANGED) {
+        assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
+    } else {
+        assert(child->perm & BLK_PERM_WRITE);
+    }
     assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
 
     ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
-- 
2.13.6
