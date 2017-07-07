Received: from eggs.gnu.org ([2001:4830:134:3::10]:43256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmM-0006RR-Sw
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmL-0000lP-OZ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:30 +0200
Message-Id: <1499447335-6125-76-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 075/100] block: new bdrv_reopen_bitmaps_rw
 interface
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add format driver handler, which should mark loaded read-only
bitmaps as 'IN_USE' in the image and unset read_only field in
corresponding BdrvDirtyBitmap's.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170628120530.31251-14-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 19 +++++++++++++++++++
 include/block/block_int.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/block.c b/block.c
index 15a4e75..3ec6624 100644
--- a/block.c
+++ b/block.c
@@ -2983,12 +2983,16 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
 {
     BlockDriver *drv;
     BlockDriverState *bs;
+    bool old_can_write, new_can_write;
 
     assert(reopen_state != NULL);
     bs = reopen_state->bs;
     drv = bs->drv;
     assert(drv != NULL);
 
+    old_can_write =
+        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
+
     /* If there are any driver level actions to take */
     if (drv->bdrv_reopen_commit) {
         drv->bdrv_reopen_commit(reopen_state);
@@ -3002,6 +3006,21 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
 
     bdrv_refresh_limits(bs, NULL);
+
+    new_can_write =
+        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
+    if (!old_can_write && new_can_write && drv->bdrv_reopen_bitmaps_rw) {
+        Error *local_err = NULL;
+        if (drv->bdrv_reopen_bitmaps_rw(bs, &local_err) < 0) {
+            /* This is not fatal, bitmaps just left read-only, so all following
+             * writes will fail. User can remove read-only bitmaps to unblock
+             * writes.
+             */
+            error_reportf_err(local_err,
+                              "%s: Failed to make dirty bitmaps writable: ",
+                              bdrv_get_node_name(bs));
+        }
+    }
 }
 
 /*
diff --git a/include/block/block_int.h b/include/block/block_int.h
index b9069c5..254f860 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -381,6 +381,13 @@ struct BlockDriver {
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);
 
+    /**
+     * Bitmaps should be marked as 'IN_USE' in the image on reopening image
+     * as rw. This handler should realize it. It also should unset readonly
+     * field of BlockDirtyBitmap's in case of success.
+     */
+    int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);
+
     QLIST_ENTRY(BlockDriver) list;
 };
 
-- 
1.8.3.1
