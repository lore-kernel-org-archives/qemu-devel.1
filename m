Received: from eggs.gnu.org ([2001:4830:134:3::10]:35572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fAxgL-0007gl-6Z
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fAxgG-0005U0-5g
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:08:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 24 Apr 2018 16:08:19 +0300
Message-Id: <20180424130821.50987-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180424130821.50987-1-vsementsov@virtuozzo.com>
References: <20180424130821.50987-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [RFC 1/3] block: add bdrv_reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, famz@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

It will be used to reconnect NBD connection.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h     |  2 ++
 include/block/block_int.h |  3 +++
 block.c                   | 22 ++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index cdec3639a3..912e3f3dcc 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -604,4 +604,6 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
  */
 void bdrv_register_buf(BlockDriverState *bs, void *host, size_t size);
 void bdrv_unregister_buf(BlockDriverState *bs, void *host);
+
+int bdrv_reconnect(BlockDriverState *bs, Error **errp);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index c4dd1d4bb8..ab9018f1c4 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -475,6 +475,9 @@ struct BlockDriver {
      */
     void (*bdrv_register_buf)(BlockDriverState *bs, void *host, size_t size);
     void (*bdrv_unregister_buf)(BlockDriverState *bs, void *host);
+
+    int (*bdrv_reconnect)(BlockDriverState *bs, Error **errp);
+
     QLIST_ENTRY(BlockDriver) list;
 };
 
diff --git a/block.c b/block.c
index a2caadf0a0..fab4413d59 100644
--- a/block.c
+++ b/block.c
@@ -4095,6 +4095,28 @@ int bdrv_has_zero_init(BlockDriverState *bs)
     return 0;
 }
 
+int bdrv_reconnect(BlockDriverState *bs, Error **errp)
+{
+    int ret;
+
+    if (bs->drv && bs->drv->bdrv_reconnect) {
+        return bs->drv->bdrv_reconnect(bs, errp);
+    }
+
+    if (bs->backing) {
+        ret = bdrv_reconnect(bs->backing->bs, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    if (bs->file) {
+        return bdrv_reconnect(bs->file->bs, errp);
+    }
+
+    return 0;
+}
+
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)
 {
     BlockDriverInfo bdi;
-- 
2.11.1
