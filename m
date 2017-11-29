Received: from eggs.gnu.org ([2001:4830:134:3::10]:41271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3hr-0005I1-O9
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3hq-0005ql-Sc
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:51:23 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 22:49:48 +0800
Message-Id: <20171129144956.11409-2-famz@redhat.com>
In-Reply-To: <20171129144956.11409-1-famz@redhat.com>
References: <20171129144956.11409-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/9] block: Remove unused
 bdrv_requests_pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c                | 18 ------------------
 include/block/block_int.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4fdf93a014..7f07972489 100644
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
-- 
2.14.3
