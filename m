Received: from eggs.gnu.org ([2001:4830:134:3::10]:55885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHhA-0002XW-8G
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHh8-0007jO-Rq
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  1 Nov 2018 21:27:37 +0300
Message-Id: <20181101182738.70462-7-vsementsov@virtuozzo.com>
In-Reply-To: <20181101182738.70462-1-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 6/7] qcow2: aio support for compressed cluster
 read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Allocate buffers locally and release qcow2 lock. Than, reads inside
qcow2_co_preadv_compressed may be done in parallel, however all
decompression is still done synchronously. Let's improve it in the
following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h |  4 ---
 block/qcow2.c | 93 ++++++++++++++++++++++++++-------------------------
 2 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 29c98d87a0..8495d2efbe 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -272,9 +272,6 @@ typedef struct BDRVQcow2State {
     QEMUTimer *cache_clean_timer;
     unsigned cache_clean_interval;
 
-    uint8_t *cluster_cache;
-    uint8_t *cluster_data;
-    uint64_t cluster_cache_offset;
     QLIST_HEAD(QCowClusterAlloc, QCowL2Meta) cluster_allocs;
 
     uint64_t *refcount_table;
@@ -610,7 +607,6 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
                         bool exact_size);
 int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size);
 int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
-int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset);
 int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
                           uint8_t *buf, int nb_sectors, bool enc, Error **errp);
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 950b9f7ec6..678d737044 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -74,6 +74,12 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
 
+static int qcow2_co_preadv_compressed(BlockDriverState *bs,
+                                      uint64_t file_cluster_offset,
+                                      uint64_t offset,
+                                      uint64_t bytes,
+                                      QEMUIOVector *qiov);
+
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
     const QCowHeader *cow_header = (const void *)buf;
@@ -1410,7 +1416,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         goto fail;
     }
 
-    s->cluster_cache_offset = -1;
     s->flags = flags;
 
     ret = qcow2_refcount_init(bs);
@@ -1910,15 +1915,15 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             break;
 
         case QCOW2_CLUSTER_COMPRESSED:
-            /* add AIO support for compressed blocks ? */
-            ret = qcow2_decompress_cluster(bs, cluster_offset);
+            qemu_co_mutex_unlock(&s->lock);
+            ret = qcow2_co_preadv_compressed(bs, cluster_offset,
+                                             offset, cur_bytes,
+                                             &hd_qiov);
+            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 goto fail;
             }
 
-            qemu_iovec_from_buf(&hd_qiov, 0,
-                                s->cluster_cache + offset_in_cluster,
-                                cur_bytes);
             break;
 
         case QCOW2_CLUSTER_NORMAL:
@@ -2054,8 +2059,6 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
-    s->cluster_cache_offset = -1; /* disable compressed cache */
-
     qemu_co_mutex_lock(&s->lock);
 
     while (bytes != 0) {
@@ -2219,8 +2222,6 @@ static void qcow2_close(BlockDriverState *bs)
     g_free(s->image_backing_file);
     g_free(s->image_backing_format);
 
-    g_free(s->cluster_cache);
-    qemu_vfree(s->cluster_data);
     qcow2_refcount_close(bs);
     qcow2_free_snapshots(bs);
 }
@@ -3397,7 +3398,6 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
     QCowL2Meta *l2meta = NULL;
 
     assert(!bs->encrypted);
-    s->cluster_cache_offset = -1; /* disable compressed cache */
 
     qemu_co_mutex_lock(&s->lock);
 
@@ -3953,51 +3953,52 @@ fail:
     return ret;
 }
 
-int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
+static int qcow2_co_preadv_compressed(BlockDriverState *bs,
+                                      uint64_t file_cluster_offset,
+                                      uint64_t offset,
+                                      uint64_t bytes,
+                                      QEMUIOVector *qiov)
 {
     BDRVQcow2State *s = bs->opaque;
-    int ret, csize, nb_csectors;
+    int ret = 0, csize, nb_csectors;
     uint64_t coffset;
+    uint8_t *buf, *out_buf;
     struct iovec iov;
     QEMUIOVector local_qiov;
+    int offset_in_cluster = offset_into_cluster(s, offset);
 
-    coffset = cluster_offset & s->cluster_offset_mask;
-    if (s->cluster_cache_offset != coffset) {
-        nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
-        csize = nb_csectors * 512 - (coffset & 511);
+    coffset = file_cluster_offset & s->cluster_offset_mask;
+    nb_csectors = ((file_cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
+    csize = nb_csectors * 512 - (coffset & 511);
 
-        /* Allocate buffers on first decompress operation, most images are
-         * uncompressed and the memory overhead can be avoided.  The buffers
-         * are freed in .bdrv_close().
-         */
-        if (!s->cluster_data) {
-            /* one more sector for decompressed data alignment */
-            s->cluster_data = qemu_try_blockalign(bs->file->bs,
-                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
-            if (!s->cluster_data) {
-                return -ENOMEM;
-            }
-        }
-        if (!s->cluster_cache) {
-            s->cluster_cache = g_malloc(s->cluster_size);
-        }
+    buf = g_try_malloc(csize);
+    if (!buf) {
+        return -ENOMEM;
+    }
+    iov.iov_base = buf;
+    iov.iov_len = csize;
+    qemu_iovec_init_external(&local_qiov, &iov, 1);
 
-        iov.iov_base = s->cluster_data;
-        iov.iov_len = csize;
-        qemu_iovec_init_external(&local_qiov, &iov, 1);
+    out_buf = qemu_blockalign(bs, s->cluster_size);
 
-        BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-        ret = bdrv_co_preadv(bs->file, coffset, csize, &local_qiov, 0);
-        if (ret < 0) {
-            return ret;
-        }
-        if (qcow2_decompress(s->cluster_cache, s->cluster_size,
-                             s->cluster_data, csize) < 0) {
-            return -EIO;
-        }
-        s->cluster_cache_offset = coffset;
+    BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
+    ret = bdrv_co_preadv(bs->file, coffset, csize, &local_qiov, 0);
+    if (ret < 0) {
+        goto fail;
     }
-    return 0;
+
+    if (qcow2_decompress(out_buf, s->cluster_size, buf, csize) < 0) {
+        ret = -EIO;
+        goto fail;
+    }
+
+    qemu_iovec_from_buf(qiov, 0, out_buf + offset_in_cluster, bytes);
+
+fail:
+    qemu_vfree(out_buf);
+    g_free(buf);
+
+    return ret;
 }
 
 static int make_completely_empty(BlockDriverState *bs)
-- 
2.18.0
