Received: from eggs.gnu.org ([2001:4830:134:3::10]:37231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cjncx-0008VZ-6C
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cjncw-0005pI-4G
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:52:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cjncv-0005p3-S5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:52:10 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  3 Mar 2017 21:51:47 +0800
Message-Id: <20170303135150.12145-2-stefanha@redhat.com>
In-Reply-To: <20170303135150.12145-1-stefanha@redhat.com>
References: <20170303135150.12145-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC 1/4] block: add bdrv_max_size() API
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

bdrv_max_size() provides a conservative maximum for the size of a new
image.  This information is handy if storage needs to be allocated (e.g.
a SAN or an LVM volume) ahead of time.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block.h     |  2 ++
 include/block/block_int.h |  2 ++
 block.c                   | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index c7c4a3a..12e1532 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -298,6 +298,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offset);
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
+uint64_t bdrv_max_size(BlockDriver *drv, QemuOpts *opts,
+                       BlockDriverState *in_bs, Error **errp);
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
 int bdrv_commit(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index a57c0bf..0354e22 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -201,6 +201,8 @@ struct BlockDriver {
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
     int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
+    uint64_t (*bdrv_max_size)(QemuOpts *opts, BlockDriverState *in_bs,
+                              Error **errp);
 
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
diff --git a/block.c b/block.c
index f293ccb..4a228f0 100644
--- a/block.c
+++ b/block.c
@@ -3188,6 +3188,43 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
     return -ENOTSUP;
 }
 
+/*
+ * bdrv_max_size:
+ * @drv: Format driver
+ * @opts: Creation options
+ * @in_bs: Existing image containing data for new image (may be NULL)
+ * @errp: Error object
+ *
+ * Calculate maximum file size required by a new image.  The value is
+ * conservative so actual creation of the image never requires more space than
+ * what is returned by this function.
+ *
+ * Note that this value is the file size including sparse regions, not the
+ * allocated file size.  A new 5 GB raw file therefore has a maximum size of 5
+ * GB, not 0!
+ *
+ * If @in_bs is given then space for allocated clusters and zero clusters
+ * from that image are included in the calculation.  If @opts contains a
+ * backing file that is shared by @in_bs then backing clusters are omitted
+ * from the calculation.
+ *
+ * If @in_bs is NULL then the calculation includes no allocated clusters
+ * unless a preallocation option is given in @opts.
+ *
+ * Returns the maximum size for the new image or 0 on error.
+ */
+uint64_t bdrv_max_size(BlockDriver *drv, QemuOpts *opts,
+                       BlockDriverState *in_bs, Error **errp)
+{
+    if (!drv->bdrv_max_size) {
+        error_setg(errp, "Block driver '%s' does not support max size "
+                   "calculation", drv->format_name);
+        return 0;
+    }
+
+    return drv->bdrv_max_size(opts, in_bs, errp);
+}
+
 /**
  * Return number of sectors on success, -errno on error.
  */
-- 
2.9.3
