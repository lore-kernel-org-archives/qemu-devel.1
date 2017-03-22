Received: from eggs.gnu.org ([2001:4830:134:3::10]:51592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cqfNG-00013k-7Y
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cqfNF-000462-2P
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:28:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cqfNE-00045Y-Pb
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:28:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 22 Mar 2017 11:16:01 +0000
Message-Id: <20170322111608.31230-2-stefanha@redhat.com>
In-Reply-To: <20170322111608.31230-1-stefanha@redhat.com>
References: <20170322111608.31230-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/8] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

bdrv_measure() provides a conservative maximum for the size of a new
image.  This information is handy if storage needs to be allocated (e.g.
a SAN or an LVM volume) ahead of time.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json      | 25 +++++++++++++++++++++++++
 include/block/block.h     |  4 ++++
 include/block/block_int.h |  2 ++
 block.c                   | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0f132fc..42fb90e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -463,6 +463,31 @@
            '*dirty-bitmaps': ['BlockDirtyInfo'] } }
 
 ##
+# @BlockMeasureInfo:
+#
+# Image size calculation information.  This structure describes the size
+# requirements for creating a new image file.
+#
+# The size requirements depend on the new image file format.  File size always
+# equals virtual disk size for the 'raw' format.  Compact formats such as
+# 'qcow2' represent unallocated and zero regions efficiently so file size may
+# be smaller than virtual disk size.
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
index 5149260..43c789f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -298,6 +298,10 @@ int bdrv_truncate(BdrvChild *child, int64_t offset);
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
+void bdrv_measure(BlockDriver *drv, QemuOpts *opts,
+                  BlockDriverState *in_bs,
+                  BlockMeasureInfo *info,
+                  Error **errp);
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 59400bd..5099a58 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -201,6 +201,8 @@ struct BlockDriver {
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
     int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
+    void (*bdrv_measure)(QemuOpts *opts, BlockDriverState *in_bs,
+                         BlockMeasureInfo *info, Error **errp);
 
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
diff --git a/block.c b/block.c
index 6e906ec..a191b82 100644
--- a/block.c
+++ b/block.c
@@ -3266,6 +3266,41 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
     return -ENOTSUP;
 }
 
+/*
+ * bdrv_measure:
+ * @drv: Format driver
+ * @opts: Creation options for new image
+ * @in_bs: Existing image containing data for new image (may be NULL)
+ * @info: Result object
+ * @errp: Error object
+ *
+ * Calculate file size required to create a new image.
+ *
+ * If @in_bs is given then space for allocated clusters and zero clusters
+ * from that image are included in the calculation.  If @opts contains a
+ * backing file that is shared by @in_bs then backing clusters are omitted
+ * from the calculation.
+ *
+ * If @in_bs is NULL then the calculation includes no allocated clusters
+ * unless a preallocation option is given in @opts.
+ *
+ * Note that @in_bs may use a different BlockDriver from @drv.
+ *
+ * If an error occurs the @errp pointer is set.
+ */
+void bdrv_measure(BlockDriver *drv, QemuOpts *opts,
+                  BlockDriverState *in_bs, BlockMeasureInfo *info,
+                  Error **errp)
+{
+    if (!drv->bdrv_measure) {
+        error_setg(errp, "Block driver '%s' does not support size measurement",
+                   drv->format_name);
+        return;
+    }
+
+    drv->bdrv_measure(opts, in_bs, info, errp);
+}
+
 /**
  * Return number of sectors on success, -errno on error.
  */
-- 
2.9.3
