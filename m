Received: from eggs.gnu.org ([2001:4830:134:3::10]:42942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60u-0007Tm-7G
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60r-00021K-3s
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Aug 2018 20:43:07 +0300
Message-Id: <20180807174311.32454-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180807174311.32454-1-vsementsov@virtuozzo.com>
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/7] qcow2: split out reading normal clusters
 from qcow2_co_preadv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Memory allocation may become less efficient for encrypted case. It's a
payment for further asynchronous scheme.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 114 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 50 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 65e3ca00e2..5e7f2ee318 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1808,6 +1808,67 @@ out:
     return ret;
 }
 
+static coroutine_fn int qcow2_co_preadv_normal(BlockDriverState *bs,
+                                               uint64_t file_cluster_offset,
+                                               uint64_t offset,
+                                               uint64_t bytes,
+                                               QEMUIOVector *qiov,
+                                               uint64_t qiov_offset)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    void *crypt_buf = NULL;
+    QEMUIOVector hd_qiov;
+    int offset_in_cluster = offset_into_cluster(s, offset);
+
+    if ((file_cluster_offset & 511) != 0) {
+        return -EIO;
+    }
+
+    qemu_iovec_init(&hd_qiov, qiov->niov);
+
+    if (bs->encrypted) {
+        assert(s->crypto);
+        assert(bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
+
+        crypt_buf = qemu_try_blockalign(bs->file->bs, bytes);
+        qemu_iovec_add(&hd_qiov, crypt_buf, bytes);
+    } else {
+        qemu_iovec_concat(&hd_qiov, qiov, qiov_offset, bytes);
+    }
+
+    BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+    ret = bdrv_co_preadv(bs->file,
+                         file_cluster_offset + offset_in_cluster,
+                         bytes, &hd_qiov, 0);
+    if (ret < 0) {
+        goto out;
+    }
+
+    if (bs->encrypted) {
+        assert(s->crypto);
+        assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
+        assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+        if (qcrypto_block_decrypt(s->crypto,
+                                  (s->crypt_physical_offset ?
+                                   file_cluster_offset + offset_in_cluster :
+                                   offset),
+                                  crypt_buf,
+                                  bytes,
+                                  NULL) < 0) {
+            ret = -EIO;
+            goto out;
+        }
+        qemu_iovec_from_buf(qiov, qiov_offset, crypt_buf, bytes);
+    }
+
+out:
+    qemu_vfree(crypt_buf);
+    qemu_iovec_destroy(&hd_qiov);
+
+    return ret;
+}
+
 static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                                         uint64_t bytes, QEMUIOVector *qiov,
                                         int flags)
@@ -1819,7 +1880,6 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
     uint64_t cluster_offset = 0;
     uint64_t bytes_done = 0;
     QEMUIOVector hd_qiov;
-    uint8_t *cluster_data = NULL;
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
@@ -1882,57 +1942,12 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
         case QCOW2_CLUSTER_NORMAL:
             qemu_co_mutex_unlock(&s->lock);
 
-            if ((cluster_offset & 511) != 0) {
-                ret = -EIO;
-                goto fail_nolock;
-            }
-
-            if (bs->encrypted) {
-                assert(s->crypto);
-
-                /*
-                 * For encrypted images, read everything into a temporary
-                 * contiguous buffer on which the AES functions can work.
-                 */
-                if (!cluster_data) {
-                    cluster_data =
-                        qemu_try_blockalign(bs->file->bs,
-                                            QCOW_MAX_CRYPT_CLUSTERS
-                                            * s->cluster_size);
-                    if (cluster_data == NULL) {
-                        ret = -ENOMEM;
-                        goto fail_nolock;
-                    }
-                }
-
-                assert(cur_bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
-                qemu_iovec_reset(&hd_qiov);
-                qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
-            }
-
-            BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-            ret = bdrv_co_preadv(bs->file,
-                                 cluster_offset + offset_in_cluster,
-                                 cur_bytes, &hd_qiov, 0);
+            ret = qcow2_co_preadv_normal(bs, cluster_offset,
+                                         offset, cur_bytes, qiov, bytes_done);
             if (ret < 0) {
                 goto fail_nolock;
             }
-            if (bs->encrypted) {
-                assert(s->crypto);
-                assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-                assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-                if (qcrypto_block_decrypt(s->crypto,
-                                          (s->crypt_physical_offset ?
-                                           cluster_offset + offset_in_cluster :
-                                           offset),
-                                          cluster_data,
-                                          cur_bytes,
-                                          NULL) < 0) {
-                    ret = -EIO;
-                    goto fail_nolock;
-                }
-                qemu_iovec_from_buf(qiov, bytes_done, cluster_data, cur_bytes);
-            }
+
             qemu_co_mutex_lock(&s->lock);
             break;
 
@@ -1953,7 +1968,6 @@ fail:
 
 fail_nolock:
     qemu_iovec_destroy(&hd_qiov);
-    qemu_vfree(cluster_data);
 
     return ret;
 }
-- 
2.11.1
