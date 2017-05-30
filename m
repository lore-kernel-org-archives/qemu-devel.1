Received: from eggs.gnu.org ([2001:4830:134:3::10]:59009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFeWI-0005pp-Ft
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFeWH-0001RE-CW
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:36:58 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14489 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFeWH-0001Qh-1T
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:36:57 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 13:36:38 +0300
Message-Id: <20170530103641.68891-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170530103641.68891-1-vsementsov@virtuozzo.com>
References: <20170530103641.68891-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/4] block: add bdrv_get_format_alloc_stat
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

The function should collect statistics, about allocted/unallocated by
top-level format driver space (in its .file) and allocation status
(allocated/hole/after eof) of corresponding areas in this .file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c                   | 16 ++++++++++++++++
 include/block/block.h     |  3 +++
 include/block/block_int.h |  2 ++
 qapi/block-core.json      | 26 ++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/block.c b/block.c
index 50ba264143..7d720ae0c2 100644
--- a/block.c
+++ b/block.c
@@ -3407,6 +3407,22 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
 }
 
 /**
+ * Collect format allocation info. See BlockFormatAllocInfo definition in
+ * qapi/block-core.json.
+ */
+int bdrv_get_format_alloc_stat(BlockDriverState *bs, BlockFormatAllocInfo *bfai)
+{
+    BlockDriver *drv = bs->drv;
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+    if (drv->bdrv_get_format_alloc_stat) {
+        return drv->bdrv_get_format_alloc_stat(bs, bfai);
+    }
+    return -ENOTSUP;
+}
+
+/**
  * Return number of sectors on success, -errno on error.
  */
 int64_t bdrv_nb_sectors(BlockDriverState *bs)
diff --git a/include/block/block.h b/include/block/block.h
index 9b355e92d8..646376a772 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -335,6 +335,9 @@ typedef enum {
 
 int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix);
 
+int bdrv_get_format_alloc_stat(BlockDriverState *bs,
+                               BlockFormatAllocInfo *bfai);
+
 /* The units of offset and total_work_size may be chosen arbitrarily by the
  * block driver; total_work_size may change during the course of the amendment
  * operation */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8d3724cce6..458c715e99 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -208,6 +208,8 @@ struct BlockDriver {
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
     int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
+    int (*bdrv_get_format_alloc_stat)(BlockDriverState *bs,
+                                      BlockFormatAllocInfo *bfai);
 
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ea0b3e8b13..365070b3eb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -139,6 +139,32 @@
            '*format-specific': 'ImageInfoSpecific' } }
 
 ##
+# @BlockFormatAllocInfo:
+#
+# Information about allocations, including metadata. All fields are in bytes.
+#
+# @alloc_alloc: allocated by format driver and allocated in underlying file
+#
+# @alloc_hole: allocated by format driver but actually is a hole in
+#              underlying file
+#
+# @alloc_overhead: allocated by format driver after end of underlying file
+#
+# @hole_alloc: not allocated by format driver but allocated in underlying file
+#
+# @hole_hole: not allocated by format driver hole in underlying file
+#
+# Since: 2.10
+#
+##
+{ 'struct': 'BlockFormatAllocInfo',
+  'data': {'alloc_alloc':    'uint64',
+           'alloc_hole':     'uint64',
+           'alloc_overhead': 'uint64',
+           'hole_alloc':     'uint64',
+           'hole_hole':      'uint64' } }
+
+##
 # @ImageCheck:
 #
 # Information about a QEMU image file check
-- 
2.11.1
