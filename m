Received: from eggs.gnu.org ([2001:4830:134:3::10]:46228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yj-0002mt-TL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yi-0001K1-JO
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:06 +0100
Message-Id: <20181212132735.16080-13-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/41] qcow2: aio support for compressed cluster
 read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Allocate buffers locally and release qcow2 lock. Than, reads inside
qcow2_co_preadv_compressed may be done in parallel, however all
decompression is still done synchronously. Let's improve it in the
following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h |  4 ---
 block/qcow2.c | 96 ++++++++++++++++++++++++++-------------------------
 2 files changed, 49 insertions(+), 51 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 8662b68575..a98d24500b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -278,9 +278,6 @@ typedef struct BDRVQcow2State {
     QEMUTimer *cache_clean_timer;
     unsigned cache_clean_interval;
=20
-    uint8_t *cluster_cache;
-    uint8_t *cluster_data;
-    uint64_t cluster_cache_offset;
     QLIST_HEAD(QCowClusterAlloc, QCowL2Meta) cluster_allocs;
=20
     uint64_t *refcount_table;
@@ -616,7 +613,6 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_=
t min_size,
                         bool exact_size);
 int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size);
 int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
-int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offs=
et);
 int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
                           uint8_t *buf, int nb_sectors, bool enc, Error =
**errp);
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index d4b25d88b5..c1886c46e3 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -74,6 +74,13 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
=20
+static int coroutine_fn
+qcow2_co_preadv_compressed(BlockDriverState *bs,
+                           uint64_t file_cluster_offset,
+                           uint64_t offset,
+                           uint64_t bytes,
+                           QEMUIOVector *qiov);
+
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *fil=
ename)
 {
     const QCowHeader *cow_header =3D (const void *)buf;
@@ -1414,7 +1421,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
         goto fail;
     }
=20
-    s->cluster_cache_offset =3D -1;
     s->flags =3D flags;
=20
     ret =3D qcow2_refcount_init(bs);
@@ -1914,15 +1920,15 @@ static coroutine_fn int qcow2_co_preadv(BlockDriv=
erState *bs, uint64_t offset,
             break;
=20
         case QCOW2_CLUSTER_COMPRESSED:
-            /* add AIO support for compressed blocks ? */
-            ret =3D qcow2_decompress_cluster(bs, cluster_offset);
+            qemu_co_mutex_unlock(&s->lock);
+            ret =3D qcow2_co_preadv_compressed(bs, cluster_offset,
+                                             offset, cur_bytes,
+                                             &hd_qiov);
+            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 goto fail;
             }
=20
-            qemu_iovec_from_buf(&hd_qiov, 0,
-                                s->cluster_cache + offset_in_cluster,
-                                cur_bytes);
             break;
=20
         case QCOW2_CLUSTER_NORMAL:
@@ -2058,8 +2064,6 @@ static coroutine_fn int qcow2_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
=20
     qemu_iovec_init(&hd_qiov, qiov->niov);
=20
-    s->cluster_cache_offset =3D -1; /* disable compressed cache */
-
     qemu_co_mutex_lock(&s->lock);
=20
     while (bytes !=3D 0) {
@@ -2223,8 +2227,6 @@ static void qcow2_close(BlockDriverState *bs)
     g_free(s->image_backing_file);
     g_free(s->image_backing_format);
=20
-    g_free(s->cluster_cache);
-    qemu_vfree(s->cluster_data);
     qcow2_refcount_close(bs);
     qcow2_free_snapshots(bs);
 }
@@ -3401,7 +3403,6 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
     QCowL2Meta *l2meta =3D NULL;
=20
     assert(!bs->encrypted);
-    s->cluster_cache_offset =3D -1; /* disable compressed cache */
=20
     qemu_co_mutex_lock(&s->lock);
=20
@@ -3957,52 +3958,53 @@ fail:
     return ret;
 }
=20
-int coroutine_fn
-qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
+static int coroutine_fn
+qcow2_co_preadv_compressed(BlockDriverState *bs,
+                           uint64_t file_cluster_offset,
+                           uint64_t offset,
+                           uint64_t bytes,
+                           QEMUIOVector *qiov)
 {
     BDRVQcow2State *s =3D bs->opaque;
-    int ret, csize, nb_csectors;
+    int ret =3D 0, csize, nb_csectors;
     uint64_t coffset;
+    uint8_t *buf, *out_buf;
     struct iovec iov;
     QEMUIOVector local_qiov;
+    int offset_in_cluster =3D offset_into_cluster(s, offset);
=20
-    coffset =3D cluster_offset & s->cluster_offset_mask;
-    if (s->cluster_cache_offset !=3D coffset) {
-        nb_csectors =3D ((cluster_offset >> s->csize_shift) & s->csize_m=
ask) + 1;
-        csize =3D nb_csectors * 512 - (coffset & 511);
+    coffset =3D file_cluster_offset & s->cluster_offset_mask;
+    nb_csectors =3D ((file_cluster_offset >> s->csize_shift) & s->csize_=
mask) + 1;
+    csize =3D nb_csectors * 512 - (coffset & 511);
=20
-        /* Allocate buffers on first decompress operation, most images a=
re
-         * uncompressed and the memory overhead can be avoided.  The buf=
fers
-         * are freed in .bdrv_close().
-         */
-        if (!s->cluster_data) {
-            /* one more sector for decompressed data alignment */
-            s->cluster_data =3D qemu_try_blockalign(bs->file->bs,
-                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
-            if (!s->cluster_data) {
-                return -ENOMEM;
-            }
-        }
-        if (!s->cluster_cache) {
-            s->cluster_cache =3D g_malloc(s->cluster_size);
-        }
+    buf =3D g_try_malloc(csize);
+    if (!buf) {
+        return -ENOMEM;
+    }
+    iov.iov_base =3D buf;
+    iov.iov_len =3D csize;
+    qemu_iovec_init_external(&local_qiov, &iov, 1);
=20
-        iov.iov_base =3D s->cluster_data;
-        iov.iov_len =3D csize;
-        qemu_iovec_init_external(&local_qiov, &iov, 1);
+    out_buf =3D qemu_blockalign(bs, s->cluster_size);
=20
-        BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-        ret =3D bdrv_co_preadv(bs->file, coffset, csize, &local_qiov, 0)=
;
-        if (ret < 0) {
-            return ret;
-        }
-        if (qcow2_decompress(s->cluster_cache, s->cluster_size,
-                             s->cluster_data, csize) < 0) {
-            return -EIO;
-        }
-        s->cluster_cache_offset =3D coffset;
+    BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
+    ret =3D bdrv_co_preadv(bs->file, coffset, csize, &local_qiov, 0);
+    if (ret < 0) {
+        goto fail;
     }
-    return 0;
+
+    if (qcow2_decompress(out_buf, s->cluster_size, buf, csize) < 0) {
+        ret =3D -EIO;
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
=20
 static int make_completely_empty(BlockDriverState *bs)
--=20
2.19.2
