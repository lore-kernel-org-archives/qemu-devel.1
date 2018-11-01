Received: from eggs.gnu.org ([2001:4830:134:3::10]:55894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHhA-0002Xg-92
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHh9-0007je-3F
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  1 Nov 2018 21:27:35 +0300
Message-Id: <20181101182738.70462-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181101182738.70462-1-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/7] qcow2: refactor decompress_buffer
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

- make it look more like a pair of qcow2_compress - rename the function
  and its parameters
- drop extra out_len variable, check filling of output buffer by strm
  structure itself
- fix code style
- add some documentation

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 56 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b45a6c4135..e9d24b801e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3758,32 +3758,46 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
     return ret;
 }
 
-static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
-                             const uint8_t *buf, int buf_size)
+/* qcow2_decompress()
+ *
+ * Decompress some data (not more than @src_size bytes) to produce exactly
+ * @dest_size bytes.
+ *
+ * @dest - destination buffer, @dest_size bytes
+ * @src - source buffer, @src_size bytes
+ *
+ * Returns: 0 on success
+ *          -1 on fail
+ */
+static ssize_t qcow2_decompress(void *dest, size_t dest_size,
+                                const void *src, size_t src_size)
 {
-    z_stream strm1, *strm = &strm1;
-    int ret, out_len;
-
-    memset(strm, 0, sizeof(*strm));
+    int ret = 0;
+    z_stream strm;
 
-    strm->next_in = (uint8_t *)buf;
-    strm->avail_in = buf_size;
-    strm->next_out = out_buf;
-    strm->avail_out = out_buf_size;
+    memset(&strm, 0, sizeof(strm));
+    strm.avail_in = src_size;
+    strm.next_in = (void *) src;
+    strm.avail_out = dest_size;
+    strm.next_out = dest;
 
-    ret = inflateInit2(strm, -12);
+    ret = inflateInit2(&strm, -12);
     if (ret != Z_OK) {
         return -1;
     }
-    ret = inflate(strm, Z_FINISH);
-    out_len = strm->next_out - out_buf;
-    if ((ret != Z_STREAM_END && ret != Z_BUF_ERROR) ||
-        out_len != out_buf_size) {
-        inflateEnd(strm);
-        return -1;
+
+    ret = inflate(&strm, Z_FINISH);
+    if ((ret != Z_STREAM_END && ret != Z_BUF_ERROR) || strm.avail_out != 0) {
+        /* We approve Z_BUF_ERROR because we need @dest buffer to be filled, but
+         * @src buffer may be processed partly (because in qcow2 we know size of
+         * compressed data with precision of one sector)
+         */
+        ret = -1;
     }
-    inflateEnd(strm);
-    return 0;
+
+    inflateEnd(&strm);
+
+    return ret;
 }
 
 #define MAX_COMPRESS_THREADS 4
@@ -3973,8 +3987,8 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
         if (ret < 0) {
             return ret;
         }
-        if (decompress_buffer(s->cluster_cache, s->cluster_size,
-                              s->cluster_data + sector_offset, csize) < 0) {
+        if (qcow2_decompress(s->cluster_cache, s->cluster_size,
+                             s->cluster_data + sector_offset, csize) < 0) {
             return -EIO;
         }
         s->cluster_cache_offset = coffset;
-- 
2.18.0
