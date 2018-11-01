Received: from eggs.gnu.org ([2001:4830:134:3::10]:55897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHhA-0002Ye-Fx
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHh9-0007jn-9E
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  1 Nov 2018 21:27:34 +0300
Message-Id: <20181101182738.70462-4-vsementsov@virtuozzo.com>
In-Reply-To: <20181101182738.70462-1-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/7] qcow2: move decompression from
 qcow2-cluster.c to qcow2.c
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

Compression is done in threads in qcow2.c. We want to do decompression
in the same way, so, firstly, move it to the same file.

The only change is braces around if-body in decompress_buffer, to
satisfy checkpatch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
 
-static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
-                             const uint8_t *buf, int buf_size)
-{
-    z_stream strm1, *strm = &strm1;
-    int ret, out_len;
-
-    memset(strm, 0, sizeof(*strm));
-
-    strm->next_in = (uint8_t *)buf;
-    strm->avail_in = buf_size;
-    strm->next_out = out_buf;
-    strm->avail_out = out_buf_size;
-
-    ret = inflateInit2(strm, -12);
-    if (ret != Z_OK)
-        return -1;
-    ret = inflate(strm, Z_FINISH);
-    out_len = strm->next_out - out_buf;
-    if ((ret != Z_STREAM_END && ret != Z_BUF_ERROR) ||
-        out_len != out_buf_size) {
-        inflateEnd(strm);
-        return -1;
-    }
-    inflateEnd(strm);
-    return 0;
-}
-
-int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
-{
-    BDRVQcow2State *s = bs->opaque;
-    int ret, csize, nb_csectors, sector_offset;
-    uint64_t coffset;
-
-    coffset = cluster_offset & s->cluster_offset_mask;
-    if (s->cluster_cache_offset != coffset) {
-        nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
-        sector_offset = coffset & 511;
-        csize = nb_csectors * 512 - sector_offset;
-
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
-
-        BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-        ret = bdrv_read(bs->file, coffset >> 9, s->cluster_data,
-                        nb_csectors);
-        if (ret < 0) {
-            return ret;
-        }
-        if (decompress_buffer(s->cluster_cache, s->cluster_size,
-                              s->cluster_data + sector_offset, csize) < 0) {
-            return -EIO;
-        }
-        s->cluster_cache_offset = coffset;
-    }
-    return 0;
-}
-
 /*
  * This discards as many clusters of nb_clusters as possible at once (i.e.
  * all clusters in the same L2 slice) and returns the number of discarded
diff --git a/block/qcow2.c b/block/qcow2.c
index 9eab2dbfb6..b45a6c4135 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3758,6 +3758,34 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
     return ret;
 }
 
+static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
+                             const uint8_t *buf, int buf_size)
+{
+    z_stream strm1, *strm = &strm1;
+    int ret, out_len;
+
+    memset(strm, 0, sizeof(*strm));
+
+    strm->next_in = (uint8_t *)buf;
+    strm->avail_in = buf_size;
+    strm->next_out = out_buf;
+    strm->avail_out = out_buf_size;
+
+    ret = inflateInit2(strm, -12);
+    if (ret != Z_OK) {
+        return -1;
+    }
+    ret = inflate(strm, Z_FINISH);
+    out_len = strm->next_out - out_buf;
+    if ((ret != Z_STREAM_END && ret != Z_BUF_ERROR) ||
+        out_len != out_buf_size) {
+        inflateEnd(strm);
+        return -1;
+    }
+    inflateEnd(strm);
+    return 0;
+}
+
 #define MAX_COMPRESS_THREADS 4
 
 typedef struct Qcow2CompressData {
@@ -3911,6 +3939,49 @@ fail:
     return ret;
 }
 
+int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret, csize, nb_csectors, sector_offset;
+    uint64_t coffset;
+
+    coffset = cluster_offset & s->cluster_offset_mask;
+    if (s->cluster_cache_offset != coffset) {
+        nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
+        sector_offset = coffset & 511;
+        csize = nb_csectors * 512 - sector_offset;
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
+        BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
+        ret = bdrv_read(bs->file, coffset >> 9, s->cluster_data,
+                        nb_csectors);
+        if (ret < 0) {
+            return ret;
+        }
+        if (decompress_buffer(s->cluster_cache, s->cluster_size,
+                              s->cluster_data + sector_offset, csize) < 0) {
+            return -EIO;
+        }
+        s->cluster_cache_offset = coffset;
+    }
+    return 0;
+}
+
 static int make_completely_empty(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
-- 
2.18.0
