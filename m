Received: from eggs.gnu.org ([2001:4830:134:3::10]:33065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDufA-0004qL-KH
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDuf5-0002gB-Ml
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:56 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:41088 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDuf5-0002f8-BJ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:51 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 25 May 2017 18:26:23 +0300
Message-Id: <20170525152628.37628-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-1-vsementsov@virtuozzo.com>
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/7] block: add bdrv_get_format_allocated_size
 format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

The function should return actually used by top-level format driver
space (in it's .file). It differs from bdrv_get_allocated_file_size,
which returns allocated on fs file size.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c                   | 15 +++++++++++++++
 include/block/block.h     |  1 +
 include/block/block_int.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/block.c b/block.c
index ba22fc0dfb..6e1a435490 100644
--- a/block.c
+++ b/block.c
@@ -3407,6 +3407,21 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
 }
 
 /**
+ * Actually used by top-level format driver space (in it's .file) in bytes
+ */
+int64_t bdrv_get_format_allocated_size(BlockDriverState *bs)
+{
+    BlockDriver *drv = bs->drv;
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+    if (drv->bdrv_get_format_allocated_size) {
+        return drv->bdrv_get_format_allocated_size(bs);
+    }
+    return -ENOTSUP;
+}
+
+/**
  * Return number of sectors on success, -errno on error.
  */
 int64_t bdrv_nb_sectors(BlockDriverState *bs)
diff --git a/include/block/block.h b/include/block/block.h
index 9b355e92d8..c36b9ccae4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -304,6 +304,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp);
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
+int64_t bdrv_get_format_allocated_size(BlockDriverState *bs);
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8d3724cce6..e562fa7a5a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -208,6 +208,7 @@ struct BlockDriver {
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
     int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
+    int64_t (*bdrv_get_format_allocated_size)(BlockDriverState *bs);
 
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
-- 
2.11.1
