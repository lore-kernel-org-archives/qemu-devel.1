Received: from eggs.gnu.org ([2001:4830:134:3::10]:42126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1kp-0002it-IM
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1kl-0001nZ-Dh
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 15:22:33 +0100
Message-Id: <20171221142251.18366-2-kwolf@redhat.com>
In-Reply-To: <20171221142251.18366-1-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/19] block: Remove unused
 bdrv_requests_pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  1 -
 block/io.c                | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index a5482775ec..e107163594 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1045,7 +1045,6 @@ bool blk_dev_is_tray_open(BlockBackend *blk);
 bool blk_dev_is_medium_locked(BlockBackend *blk);
 
 void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
-bool bdrv_requests_pending(BlockDriverState *bs);
 
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
 void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in);
diff --git a/block/io.c b/block/io.c
index 1e92d2e5b2..cf780c3cb0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -134,24 +134,6 @@ void bdrv_disable_copy_on_read(BlockDriverState *bs)
     assert(old >= 1);
 }
 
-/* Check if any requests are in-flight (including throttled requests) */
-bool bdrv_requests_pending(BlockDriverState *bs)
-{
-    BdrvChild *child;
-
-    if (atomic_read(&bs->in_flight)) {
-        return true;
-    }
-
-    QLIST_FOREACH(child, &bs->children, next) {
-        if (bdrv_requests_pending(child->bs)) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
 typedef struct {
     Coroutine *co;
     BlockDriverState *bs;
-- 
2.13.6
