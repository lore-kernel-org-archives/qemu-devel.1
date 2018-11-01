Received: from eggs.gnu.org ([2001:4830:134:3::10]:55884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHhA-0002XV-8F
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHh6-0007iA-V0
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  1 Nov 2018 21:27:33 +0300
Message-Id: <20181101182738.70462-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181101182738.70462-1-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/7] qcow2: make more generic interface for
 qcow2_compress
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

Give explicit size both for source and destination buffers, to make it
similar with decompression path and than cleanly reuse parameter
structure for decompression threads.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3e9367c449..9eab2dbfb6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3718,14 +3718,15 @@ fail:
 /*
  * qcow2_compress()
  *
- * @dest - destination buffer, at least of @size-1 bytes
- * @src - source buffer, @size bytes
+ * @dest - destination buffer, @dest_size bytes
+ * @src - source buffer, @src_size bytes
  *
  * Returns: compressed size on success
- *          -1 if compression is inefficient
+ *          -1 destination buffer is not enough to store compressed data
  *          -2 on any other error
  */
-static ssize_t qcow2_compress(void *dest, const void *src, size_t size)
+static ssize_t qcow2_compress(void *dest, size_t dest_size,
+                              const void *src, size_t src_size)
 {
     ssize_t ret;
     z_stream strm;
@@ -3740,14 +3741,14 @@ static ssize_t qcow2_compress(void *dest, const void *src, size_t size)
 
     /* strm.next_in is not const in old zlib versions, such as those used on
      * OpenBSD/NetBSD, so cast the const away */
-    strm.avail_in = size;
+    strm.avail_in = src_size;
     strm.next_in = (void *) src;
-    strm.avail_out = size - 1;
+    strm.avail_out = dest_size;
     strm.next_out = dest;
 
     ret = deflate(&strm, Z_FINISH);
     if (ret == Z_STREAM_END) {
-        ret = size - 1 - strm.avail_out;
+        ret = dest_size - strm.avail_out;
     } else {
         ret = (ret == Z_OK ? -1 : -2);
     }
@@ -3761,8 +3762,9 @@ static ssize_t qcow2_compress(void *dest, const void *src, size_t size)
 
 typedef struct Qcow2CompressData {
     void *dest;
+    size_t dest_size;
     const void *src;
-    size_t size;
+    size_t src_size;
     ssize_t ret;
 } Qcow2CompressData;
 
@@ -3770,7 +3772,8 @@ static int qcow2_compress_pool_func(void *opaque)
 {
     Qcow2CompressData *data = opaque;
 
-    data->ret = qcow2_compress(data->dest, data->src, data->size);
+    data->ret = qcow2_compress(data->dest, data->dest_size,
+                               data->src, data->src_size);
 
     return 0;
 }
@@ -3782,15 +3785,17 @@ static void qcow2_compress_complete(void *opaque, int ret)
 
 /* See qcow2_compress definition for parameters description */
 static ssize_t qcow2_co_compress(BlockDriverState *bs,
-                                 void *dest, const void *src, size_t size)
+                                 void *dest, size_t dest_size,
+                                 const void *src, size_t src_size)
 {
     BDRVQcow2State *s = bs->opaque;
     BlockAIOCB *acb;
     ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     Qcow2CompressData arg = {
         .dest = dest,
+        .dest_size = dest_size,
         .src = src,
-        .size = size,
+        .src_size = src_size,
     };
 
     while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
@@ -3857,7 +3862,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 
     out_buf = g_malloc(s->cluster_size);
 
-    out_len = qcow2_co_compress(bs, out_buf, buf, s->cluster_size);
+    out_len = qcow2_co_compress(bs, out_buf, s->cluster_size - 1,
+                                buf, s->cluster_size);
     if (out_len == -2) {
         ret = -EINVAL;
         goto fail;
-- 
2.18.0
