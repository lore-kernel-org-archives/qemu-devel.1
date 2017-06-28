Received: from eggs.gnu.org ([2001:4830:134:3::10]:60386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj6-0006QQ-Sm
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj3-00032g-1K
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:44 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:42486 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBj2-0002wZ-L4
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:40 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:05:13 +0300
Message-Id: <20170628120530.31251-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v22 13/30] block: new bdrv_reopen_bitmaps_rw
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Add format driver handler, which should mark loaded read-only
bitmaps as 'IN_USE' in the image and unset read_only field in
corresponding BdrvDirtyBitmap's.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block.c                   | 19 +++++++++++++++++++
 include/block/block_int.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/block.c b/block.c
index 37d68e3276..3f83da178d 100644
--- a/block.c
+++ b/block.c
@@ -2990,12 +2990,16 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
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
@@ -3009,6 +3013,21 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
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
index 748970055e..4ad8eec2dd 100644
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
2.11.1
