Received: from eggs.gnu.org ([2001:4830:134:3::10]:49830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co5Fx-0000oZ-50
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co5Fw-0000Vx-4N
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:30:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1co5Fv-0000Ub-TL
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:30:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 15 Mar 2017 17:29:37 +0800
Message-Id: <20170315092940.1367-6-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-1-stefanha@redhat.com>
References: <20170315092940.1367-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC v2 5/8] qcow2: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Use qcow2_calc_prealloc_size() to get the required file size.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
TODO:
 * Query block status and only count allocated clusters if in_bs != NULL
 * Exclude backing file clusters if in_bs != NULL and -o backing_file=
   is given
---
 block/qcow2.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 19be468..a4caf97 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2940,6 +2940,58 @@ static coroutine_fn int qcow2_co_flush_to_os(BlockDriverState *bs)
     return 0;
 }
 
+static void qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
+                          BlockMeasureInfo *info, Error **errp)
+{
+    Error *local_err = NULL;
+    uint64_t allocated_bytes = 0;
+    uint64_t prealloc_size;
+    uint64_t size;
+    uint64_t refcount_bits;
+    size_t cluster_size;
+    int version;
+
+    size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                    BDRV_SECTOR_SIZE);
+
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
+    if (in_bs) {
+        int64_t ssize = bdrv_getlength(in_bs);
+        if (ssize < 0) {
+            error_setg_errno(errp, -ssize, "Unable to get image size");
+            return;
+        }
+
+        size = ssize;
+
+        /* TODO How many clusters are allocated modulo backing file in opts? */
+    }
+
+    prealloc_size = qcow2_calc_prealloc_size(size, cluster_size,
+                                             ctz32(refcount_bits));
+    info->required_bytes = prealloc_size - (align_offset(size, cluster_size) -
+                                            allocated_bytes);
+    info->fully_allocated_bytes = prealloc_size;
+    return;
+
+err:
+    error_propagate(errp, local_err);
+}
+
 static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -3487,6 +3539,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_snapshot_delete   = qcow2_snapshot_delete,
     .bdrv_snapshot_list     = qcow2_snapshot_list,
     .bdrv_snapshot_load_tmp = qcow2_snapshot_load_tmp,
+    .bdrv_measure           = qcow2_measure,
     .bdrv_get_info          = qcow2_get_info,
     .bdrv_get_specific_info = qcow2_get_specific_info,
 
-- 
2.9.3
