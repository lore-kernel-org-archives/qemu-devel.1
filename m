Received: from eggs.gnu.org ([2001:4830:134:3::10]:36326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdST-0002HG-DD
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSN-0005C2-T0
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:49 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:31626 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSN-00058v-EM
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:43 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:26 +0300
Message-Id: <20170123121036.4823-15-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-1-vsementsov@virtuozzo.com>
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 14/24] block: add
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
---
 block.c                   | 22 ++++++++++++++++++++++
 include/block/block.h     |  2 ++
 include/block/block_int.h |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/block.c b/block.c
index 646ea50316..c20b22ff25 100644
--- a/block.c
+++ b/block.c
@@ -4139,3 +4139,25 @@ void bdrv_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
 
     drv->bdrv_store_persistent_dirty_bitmaps(bs, errp);
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
index e3175b5e4c..1b5f2704f6 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -554,5 +554,7 @@ void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
 void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 void bdrv_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                     uint32_t granularity, Error **errp);
 
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index e8d9210075..b38b3aa198 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -324,6 +324,8 @@ struct BlockDriver {
                                                 Error **errp);
     void (*bdrv_store_persistent_dirty_bitmaps)(BlockDriverState *bs,
                                                 Error **errp);
+    bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs, const char *name,
+                                            uint32_t granularity, Error **errp);
 
     QLIST_ENTRY(BlockDriver) list;
 };
-- 
2.11.0
