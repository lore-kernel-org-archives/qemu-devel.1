Received: from eggs.gnu.org ([2001:4830:134:3::10]:46118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yb-0002RJ-MK
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Ya-00014E-FJ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:09 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:03 +0100
Message-Id: <20181212132735.16080-10-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/41] qcow2: move decompression from
 qcow2-cluster.c to qcow2.c
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

Compression is done in threads in qcow2.c. We want to do decompression
in the same way, so, firstly, move it to the same file.

The only change is braces around if-body in decompress_buffer, to
satisfy checkpatch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 70 ------------------------------------------
 block/qcow2.c         | 71 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 70 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index d37fe08b3d..e2737429f5 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1571,76 +1571,6 @@ again:
     return 0;
 }
=20
-static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
-                             const uint8_t *buf, int buf_size)
-{
-    z_stream strm1, *strm =3D &strm1;
-    int ret, out_len;
-
-    memset(strm, 0, sizeof(*strm));
-
-    strm->next_in =3D (uint8_t *)buf;
-    strm->avail_in =3D buf_size;
-    strm->next_out =3D out_buf;
-    strm->avail_out =3D out_buf_size;
-
-    ret =3D inflateInit2(strm, -12);
-    if (ret !=3D Z_OK)
-        return -1;
-    ret =3D inflate(strm, Z_FINISH);
-    out_len =3D strm->next_out - out_buf;
-    if ((ret !=3D Z_STREAM_END && ret !=3D Z_BUF_ERROR) ||
-        out_len !=3D out_buf_size) {
-        inflateEnd(strm);
-        return -1;
-    }
-    inflateEnd(strm);
-    return 0;
-}
-
-int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offs=
et)
-{
-    BDRVQcow2State *s =3D bs->opaque;
-    int ret, csize, nb_csectors, sector_offset;
-    uint64_t coffset;
-
-    coffset =3D cluster_offset & s->cluster_offset_mask;
-    if (s->cluster_cache_offset !=3D coffset) {
-        nb_csectors =3D ((cluster_offset >> s->csize_shift) & s->csize_m=
ask) + 1;
-        sector_offset =3D coffset & 511;
-        csize =3D nb_csectors * 512 - sector_offset;
-
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
-
-        BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-        ret =3D bdrv_read(bs->file, coffset >> 9, s->cluster_data,
-                        nb_csectors);
-        if (ret < 0) {
-            return ret;
-        }
-        if (decompress_buffer(s->cluster_cache, s->cluster_size,
-                              s->cluster_data + sector_offset, csize) < =
0) {
-            return -EIO;
-        }
-        s->cluster_cache_offset =3D coffset;
-    }
-    return 0;
-}
-
 /*
  * This discards as many clusters of nb_clusters as possible at once (i.=
e.
  * all clusters in the same L2 slice) and returns the number of discarde=
d
diff --git a/block/qcow2.c b/block/qcow2.c
index 0c1569f715..d4d141c495 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3762,6 +3762,34 @@ static ssize_t qcow2_compress(void *dest, size_t d=
est_size,
     return ret;
 }
=20
+static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
+                             const uint8_t *buf, int buf_size)
+{
+    z_stream strm1, *strm =3D &strm1;
+    int ret, out_len;
+
+    memset(strm, 0, sizeof(*strm));
+
+    strm->next_in =3D (uint8_t *)buf;
+    strm->avail_in =3D buf_size;
+    strm->next_out =3D out_buf;
+    strm->avail_out =3D out_buf_size;
+
+    ret =3D inflateInit2(strm, -12);
+    if (ret !=3D Z_OK) {
+        return -1;
+    }
+    ret =3D inflate(strm, Z_FINISH);
+    out_len =3D strm->next_out - out_buf;
+    if ((ret !=3D Z_STREAM_END && ret !=3D Z_BUF_ERROR) ||
+        out_len !=3D out_buf_size) {
+        inflateEnd(strm);
+        return -1;
+    }
+    inflateEnd(strm);
+    return 0;
+}
+
 #define MAX_COMPRESS_THREADS 4
=20
 typedef struct Qcow2CompressData {
@@ -3915,6 +3943,49 @@ fail:
     return ret;
 }
=20
+int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offs=
et)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    int ret, csize, nb_csectors, sector_offset;
+    uint64_t coffset;
+
+    coffset =3D cluster_offset & s->cluster_offset_mask;
+    if (s->cluster_cache_offset !=3D coffset) {
+        nb_csectors =3D ((cluster_offset >> s->csize_shift) & s->csize_m=
ask) + 1;
+        sector_offset =3D coffset & 511;
+        csize =3D nb_csectors * 512 - sector_offset;
+
+        /* Allocate buffers on first decompress operation, most images a=
re
+         * uncompressed and the memory overhead can be avoided.  The buf=
fers
+         * are freed in .bdrv_close().
+         */
+        if (!s->cluster_data) {
+            /* one more sector for decompressed data alignment */
+            s->cluster_data =3D qemu_try_blockalign(bs->file->bs,
+                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
+            if (!s->cluster_data) {
+                return -ENOMEM;
+            }
+        }
+        if (!s->cluster_cache) {
+            s->cluster_cache =3D g_malloc(s->cluster_size);
+        }
+
+        BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
+        ret =3D bdrv_read(bs->file, coffset >> 9, s->cluster_data,
+                        nb_csectors);
+        if (ret < 0) {
+            return ret;
+        }
+        if (decompress_buffer(s->cluster_cache, s->cluster_size,
+                              s->cluster_data + sector_offset, csize) < =
0) {
+            return -EIO;
+        }
+        s->cluster_cache_offset =3D coffset;
+    }
+    return 0;
+}
+
 static int make_completely_empty(BlockDriverState *bs)
 {
     BDRVQcow2State *s =3D bs->opaque;
--=20
2.19.2
