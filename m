Received: from eggs.gnu.org ([2001:4830:134:3::10]:57324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6l-0005nz-3B
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6g-0002Uw-4k
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:28 +0100
Message-Id: <20171222151846.28110-18-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 17/35] block: Remove unused
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

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
