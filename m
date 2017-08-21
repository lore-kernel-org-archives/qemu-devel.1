Received: from eggs.gnu.org ([2001:4830:134:3::10]:52035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1djnGe-0005Xr-Pl
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1djnGZ-00053D-3A
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:01:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 21 Aug 2017 14:55:30 +0100
Message-Id: <20170821135530.32344-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2] qcow2: allocate cluster_cache/cluster_data
 on demand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Most qcow2 files are uncompressed so it is wasteful to allocate (32 + 1)
* cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
s->cluster_data when the first read operation is performance on a
compressed cluster.

The buffers are freed in .bdrv_close().  .bdrv_open() no longer has any
code paths that can allocate these buffers, so remove the free functions
in the error code path.

This patch can result in significant memory savings when many qcow2
disks are attached or backing file chains are long:

Before 12.81% (1,023,193,088B)
After   5.36% (393,893,888B)

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
 * Changed EIO to ENOMEM [Eric]
 * Added Alexey's Tested-by
---
 block/qcow2-cluster.c | 17 +++++++++++++++++
 block/qcow2.c         | 12 ------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f06c08f64c..8538533102 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1516,6 +1516,23 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
         nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
         sector_offset = coffset & 511;
         csize = nb_csectors * 512 - sector_offset;
+
+        /* Allocate buffers on first decompress operation, most images are
+         * uncompressed and the memory overhead can be avoided.  The buffers
+         * are freed in .bdrv_close().
+         */
+        if (!s->cluster_data) {
+            /* one more sector for decompressed data alignment */
+            s->cluster_data = qemu_try_blockalign(bs->file->bs,
+                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
+            if (!s->cluster_data) {
+                return -ENOMEM;
+            }
+        }
+        if (!s->cluster_cache) {
+            s->cluster_cache = g_malloc(s->cluster_size);
+        }
+
         BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
         ret = bdrv_read(bs->file, coffset >> 9, s->cluster_data,
                         nb_csectors);
diff --git a/block/qcow2.c b/block/qcow2.c
index 40ba26c111..0ac201910a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1360,16 +1360,6 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    s->cluster_cache = g_malloc(s->cluster_size);
-    /* one more sector for decompressed data alignment */
-    s->cluster_data = qemu_try_blockalign(bs->file->bs, QCOW_MAX_CRYPT_CLUSTERS
-                                                    * s->cluster_size + 512);
-    if (s->cluster_data == NULL) {
-        error_setg(errp, "Could not allocate temporary cluster buffer");
-        ret = -ENOMEM;
-        goto fail;
-    }
-
     s->cluster_cache_offset = -1;
     s->flags = flags;
 
@@ -1507,8 +1497,6 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     if (s->refcount_block_cache) {
         qcow2_cache_destroy(bs, s->refcount_block_cache);
     }
-    g_free(s->cluster_cache);
-    qemu_vfree(s->cluster_data);
     qcrypto_block_free(s->crypto);
     qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
     return ret;
-- 
2.13.5
