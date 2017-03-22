Received: from eggs.gnu.org ([2001:4830:134:3::10]:51485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cqfN7-0000wj-KV
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cqfN4-00040w-Ut
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:28:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cqfN4-00040r-MS
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:28:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 22 Mar 2017 11:16:05 +0000
Message-Id: <20170322111608.31230-6-stefanha@redhat.com>
In-Reply-To: <20170322111608.31230-1-stefanha@redhat.com>
References: <20170322111608.31230-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/8] qcow2: add bdrv_measure() support
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

Use qcow2_calc_prealloc_size() to get the required file size.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qcow2.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 19be468..ed898d3 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2940,6 +2940,124 @@ static coroutine_fn int qcow2_co_flush_to_os(BlockDriverState *bs)
     return 0;
 }
 
+static void qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
+                          BlockMeasureInfo *info, Error **errp)
+{
+    Error *local_err = NULL;
+    uint64_t required = 0; /* bytes that contribute to required size */
+    uint64_t virtual_size; /* disk size as seen by guest */
+    uint64_t refcount_bits;
+    size_t cluster_size;
+    int version;
+    char *optstr;
+    PreallocMode prealloc;
+    bool has_backing_file;
+
+    /* Parse image creation options */
+    cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
+    if (local_err) {
+        goto err;
+    }
+
+    version = qcow2_opt_get_version_del(opts, &local_err);
+    if (local_err) {
+        goto err;
+    }
+
+    refcount_bits = qcow2_opt_get_refcount_bits_del(opts, version, &local_err);
+    if (local_err) {
+        goto err;
+    }
+
+    optstr = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
+    prealloc = qapi_enum_parse(PreallocMode_lookup, optstr,
+                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
+                               &local_err);
+    g_free(optstr);
+    if (local_err) {
+        goto err;
+    }
+
+    optstr = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
+    has_backing_file = !!optstr;
+    g_free(optstr);
+
+    virtual_size = align_offset(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                                cluster_size);
+
+    /* Account for input image */
+    if (in_bs) {
+        int64_t ssize = bdrv_getlength(in_bs);
+        if (ssize < 0) {
+            error_setg_errno(errp, -ssize, "Unable to get image virtual_size");
+            return;
+        }
+
+        virtual_size = align_offset(ssize, cluster_size);
+
+        if (has_backing_file) {
+            /* We don't how much of the backing chain is shared by the input
+             * image and the new image file.  In the worst case the new image's
+             * backing file has nothing in common with the input image.  Be
+             * conservative and assume all clusters need to be written.
+             */
+            required = virtual_size;
+        } else {
+            int cluster_sectors = cluster_size / BDRV_SECTOR_SIZE;
+            int64_t sector_num;
+            int pnum = 0;
+
+            for (sector_num = 0;
+                 sector_num < ssize / BDRV_SECTOR_SIZE;
+                 sector_num += pnum) {
+                int nb_sectors = MAX(ssize / BDRV_SECTOR_SIZE - sector_num,
+                                     INT_MAX);
+                BlockDriverState *file;
+                int64_t ret;
+
+                ret = bdrv_get_block_status_above(in_bs, NULL,
+                                                  sector_num, nb_sectors,
+                                                  &pnum, &file);
+                if (ret < 0) {
+                    error_setg_errno(errp, -ret, "Unable to get block status");
+                    return;
+                }
+
+                if (ret & BDRV_BLOCK_ZERO) {
+                    /* Skip zero regions (safe with no backing file) */
+                } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
+                           (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
+                    /* Extend pnum to end of cluster for next iteration */
+                    pnum = ROUND_UP(sector_num + pnum, cluster_sectors) -
+                           sector_num;
+
+                    /* Count clusters we've seen */
+                    required += (sector_num % cluster_sectors + pnum) *
+                                BDRV_SECTOR_SIZE;
+                }
+            }
+        }
+    }
+
+    /* Take into account preallocation.  Nothing special is needed for
+     * PREALLOC_MODE_METADATA since metadata is always counted.
+     */
+    if (prealloc == PREALLOC_MODE_FULL || prealloc == PREALLOC_MODE_FALLOC) {
+        required = virtual_size;
+    }
+
+    info->fully_allocated =
+        qcow2_calc_prealloc_size(virtual_size, cluster_size,
+                                 ctz32(refcount_bits));
+
+    /* Remove regions that are not required */
+    info->required = info->fully_allocated - virtual_size + required;
+    return;
+
+err:
+    error_propagate(errp, local_err);
+}
+
 static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -3487,6 +3605,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_snapshot_delete   = qcow2_snapshot_delete,
     .bdrv_snapshot_list     = qcow2_snapshot_list,
     .bdrv_snapshot_load_tmp = qcow2_snapshot_load_tmp,
+    .bdrv_measure           = qcow2_measure,
     .bdrv_get_info          = qcow2_get_info,
     .bdrv_get_specific_info = qcow2_get_specific_info,
 
-- 
2.9.3
