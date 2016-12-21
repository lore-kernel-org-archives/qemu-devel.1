Received: from eggs.gnu.org ([2001:4830:134:3::10]:58690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cJiIU-0003n0-B0
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cJiIR-0006hc-4p
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:55:14 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:48261 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cJiIQ-0006Y9-IC
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:55:10 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Dec 2016 17:54:46 +0300
Message-Id: <1482332102-131788-9-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482332102-131788-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482332102-131788-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 08/24] block: introduce auto-loading bitmaps
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

Auto loading bitmaps are bitmaps stored in the disk image, which should
be loaded when the image is opened and become BdrvDirtyBitmaps for the
corresponding drive.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block.c                   | 14 ++++++++++++++
 include/block/block.h     |  2 ++
 include/block/block_int.h |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/block.c b/block.c
index 39ddea3..1095176 100644
--- a/block.c
+++ b/block.c
@@ -1141,6 +1141,13 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
     assert(bdrv_min_mem_align(bs) != 0);
     assert(is_power_of_2(bs->bl.request_alignment));
 
+    bdrv_load_autoloading_dirty_bitmaps(bs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto free_and_fail;
+    }
+
     qemu_opts_del(opts);
     return 0;
 
@@ -4093,3 +4100,10 @@ void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 
     parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
 }
+
+void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+{
+    if (bs->drv && bs->drv->bdrv_load_autoloading_dirty_bitmaps) {
+        bs->drv->bdrv_load_autoloading_dirty_bitmaps(bs, errp);
+    }
+}
diff --git a/include/block/block.h b/include/block/block.h
index 49bb0b2..f701da2 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -552,4 +552,6 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
                     Error **errp);
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
+void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 83a423c..ca955f0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -320,6 +320,9 @@ struct BlockDriver {
     void (*bdrv_del_child)(BlockDriverState *parent, BdrvChild *child,
                            Error **errp);
 
+    void (*bdrv_load_autoloading_dirty_bitmaps)(BlockDriverState *bs,
+                                                Error **errp);
+
     QLIST_ENTRY(BlockDriver) list;
 };
 
-- 
1.8.3.1
