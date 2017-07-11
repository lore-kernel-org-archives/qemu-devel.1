Received: from eggs.gnu.org ([2001:4830:134:3::10]:46632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxlk-0001YO-Tf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxlj-0006z0-Nn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:12 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:50 +0200
Message-Id: <20170711160814.20941-62-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 61/85] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

bdrv_measure() provides a conservative maximum for the size of a new
image.  This information is handy if storage needs to be allocated (e.g.
a SAN or an LVM volume) ahead of time.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20170705125738.8777-2-stefanha@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json      | 25 +++++++++++++++++++++++++
 include/block/block.h     |  2 ++
 include/block/block_int.h |  2 ++
 block.c                   | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4bf11e8..c437aa5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -488,6 +488,31 @@
            '*dirty-bitmaps': ['BlockDirtyInfo'] } }
 
 ##
+# @BlockMeasureInfo:
+#
+# Image file size calculation information.  This structure describes the size
+# requirements for creating a new image file.
+#
+# The size requirements depend on the new image file format.  File size always
+# equals virtual disk size for the 'raw' format, even for sparse POSIX files.
+# Compact formats such as 'qcow2' represent unallocated and zero regions
+# efficiently so file size may be smaller than virtual disk size.
+#
+# The values are upper bounds that are guaranteed to fit the new image file.
+# Subsequent modification, such as internal snapshot or bitmap creation, may
+# require additional space and is not covered here.
+#
+# @required: Size required for a new image file, in bytes.
+#
+# @fully-allocated: Image file size, in bytes, once data has been written
+#                   to all sectors.
+#
+# Since: 2.10
+##
+{ 'struct': 'BlockMeasureInfo',
+  'data': {'required': 'int', 'fully-allocated': 'int'} }
+
+##
 # @query-block:
 #
 # Get a list of BlockInfo for all virtual block devices.
diff --git a/include/block/block.h b/include/block/block.h
index f0fdbe8..96edc85 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -306,6 +306,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp);
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
+BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
+                               BlockDriverState *in_bs, Error **errp);
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 58d4ffd..d0cd8a3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -209,6 +209,8 @@ struct BlockDriver {
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
     int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
+    BlockMeasureInfo *(*bdrv_measure)(QemuOpts *opts, BlockDriverState *in_bs,
+                                      Error **errp);
 
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
diff --git a/block.c b/block.c
index 913bb43..162e9d9 100644
--- a/block.c
+++ b/block.c
@@ -3463,6 +3463,41 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
     return -ENOTSUP;
 }
 
+/*
+ * bdrv_measure:
+ * @drv: Format driver
+ * @opts: Creation options for new image
+ * @in_bs: Existing image containing data for new image (may be NULL)
+ * @errp: Error object
+ * Returns: A #BlockMeasureInfo (free using qapi_free_BlockMeasureInfo())
+ *          or NULL on error
+ *
+ * Calculate file size required to create a new image.
+ *
+ * If @in_bs is given then space for allocated clusters and zero clusters
+ * from that image are included in the calculation.  If @opts contains a
+ * backing file that is shared by @in_bs then backing clusters may be omitted
+ * from the calculation.
+ *
+ * If @in_bs is NULL then the calculation includes no allocated clusters
+ * unless a preallocation option is given in @opts.
+ *
+ * Note that @in_bs may use a different BlockDriver from @drv.
+ *
+ * If an error occurs the @errp pointer is set.
+ */
+BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
+                               BlockDriverState *in_bs, Error **errp)
+{
+    if (!drv->bdrv_measure) {
+        error_setg(errp, "Block driver '%s' does not support size measurement",
+                   drv->format_name);
+        return NULL;
+    }
+
+    return drv->bdrv_measure(opts, in_bs, errp);
+}
+
 /**
  * Return number of sectors on success, -errno on error.
  */
-- 
2.9.4
