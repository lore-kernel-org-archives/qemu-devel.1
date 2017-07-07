Received: from eggs.gnu.org ([2001:4830:134:3::10]:43455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmW-0006d5-5s
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmV-000110-2u
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:38 +0200
Message-Id: <1499447335-6125-84-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 083/100] block: add
 bdrv_can_store_new_dirty_bitmap
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

This will be needed to check some restrictions before making bitmap
persistent in qmp-block-dirty-bitmap-add (this functionality will be
added by future patch)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-22-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 22 ++++++++++++++++++++++
 include/block/block.h     |  3 +++
 include/block/block_int.h |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/block.c b/block.c
index 700431d..1d44165 100644
--- a/block.c
+++ b/block.c
@@ -4880,3 +4880,25 @@ void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 
     parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
 }
+
+bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                     uint32_t granularity, Error **errp)
+{
+    BlockDriver *drv = bs->drv;
+
+    if (!drv) {
+        error_setg_errno(errp, ENOMEDIUM,
+                         "Can't store persistent bitmaps to %s",
+                         bdrv_get_device_or_node_name(bs));
+        return false;
+    }
+
+    if (!drv->bdrv_can_store_new_dirty_bitmap) {
+        error_setg_errno(errp, ENOTSUP,
+                         "Can't store persistent bitmaps to %s",
+                         bdrv_get_device_or_node_name(bs));
+        return false;
+    }
+
+    return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
+}
diff --git a/include/block/block.h b/include/block/block.h
index 2d637d1..f0fdbe8 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -617,4 +617,7 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
                     Error **errp);
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
+bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                     uint32_t granularity, Error **errp);
+
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 254f860..c9e29bf 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -387,6 +387,10 @@ struct BlockDriver {
      * field of BlockDirtyBitmap's in case of success.
      */
     int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);
+    bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
+                                            const char *name,
+                                            uint32_t granularity,
+                                            Error **errp);
 
     QLIST_ENTRY(BlockDriver) list;
 };
-- 
1.8.3.1
