Received: from eggs.gnu.org ([2001:4830:134:3::10]:60431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj7-0006Qm-VD
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj3-00033m-C9
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:45 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:37241 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBj2-0002xh-Vz
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:05:21 +0300
Message-Id: <20170628120530.31251-22-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v22 21/30] block: add
 bdrv_can_store_new_dirty_bitmap
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

This will be needed to check some restrictions before making bitmap
persistent in qmp-block-dirty-bitmap-add (this functionality will be
added by future patch)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block.c                   | 22 ++++++++++++++++++++++
 include/block/block.h     |  3 +++
 include/block/block_int.h |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/block.c b/block.c
index c649afec91..b2719bceff 100644
--- a/block.c
+++ b/block.c
@@ -4954,3 +4954,25 @@ void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 
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
index a4f09df95a..1daf9a0882 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -630,4 +630,7 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
                     Error **errp);
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
+bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                     uint32_t granularity, Error **errp);
+
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4ad8eec2dd..009b4d41df 100644
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
2.11.1
