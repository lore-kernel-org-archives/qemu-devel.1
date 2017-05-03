Received: from eggs.gnu.org ([2001:4830:134:3::10]:57812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d5tLw-0000bF-GW
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d5tLp-00004u-S8
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:25:56 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:11601 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1d5tLp-0008Sy-H0
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:25:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  3 May 2017 15:25:30 +0300
Message-Id: <20170503122539.282182-17-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-1-vsementsov@virtuozzo.com>
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 16/25] block: add
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
 include/block/block_int.h |  5 +++++
 3 files changed, 30 insertions(+)

diff --git a/block.c b/block.c
index 17c853f3ee..795d36bb64 100644
--- a/block.c
+++ b/block.c
@@ -4804,3 +4804,25 @@ void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 
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
index 144df0ddfb..f92529a4e8 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -624,4 +624,7 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
                     Error **errp);
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
+bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                     uint32_t granularity, Error **errp);
+
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4f8cd29ae4..9092e78ade 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -373,6 +373,11 @@ struct BlockDriver {
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);
 
+    bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
+                                            const char *name,
+                                            uint32_t granularity,
+                                            Error **errp);
+
     QLIST_ENTRY(BlockDriver) list;
 };
 
-- 
2.11.1
