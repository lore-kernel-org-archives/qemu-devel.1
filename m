Received: from eggs.gnu.org ([2001:4830:134:3::10]:55888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHhA-0002XZ-8L
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHh8-0007jE-Nq
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  1 Nov 2018 21:27:38 +0300
Message-Id: <20181101182738.70462-8-vsementsov@virtuozzo.com>
In-Reply-To: <20181101182738.70462-1-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 7/7] qcow2: do decompression in threads
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

Do decompression in threads, like it is already done for compression.
This improves asynchronous compressed reads performance.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 678d737044..3f1c773b13 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3802,20 +3802,24 @@ static ssize_t qcow2_decompress(void *dest, size_t dest_size,
 
 #define MAX_COMPRESS_THREADS 4
 
+typedef ssize_t (*Qcow2CompressFunc)(void *dest, size_t dest_size,
+                                     const void *src, size_t src_size);
 typedef struct Qcow2CompressData {
     void *dest;
     size_t dest_size;
     const void *src;
     size_t src_size;
     ssize_t ret;
+
+    Qcow2CompressFunc func;
 } Qcow2CompressData;
 
 static int qcow2_compress_pool_func(void *opaque)
 {
     Qcow2CompressData *data = opaque;
 
-    data->ret = qcow2_compress(data->dest, data->dest_size,
-                               data->src, data->src_size);
+    data->ret = data->func(data->dest, data->dest_size,
+                           data->src, data->src_size);
 
     return 0;
 }
@@ -3825,10 +3829,10 @@ static void qcow2_compress_complete(void *opaque, int ret)
     qemu_coroutine_enter(opaque);
 }
 
-/* See qcow2_compress definition for parameters description */
-static ssize_t qcow2_co_compress(BlockDriverState *bs,
-                                 void *dest, size_t dest_size,
-                                 const void *src, size_t src_size)
+static ssize_t qcow2_co_do_compress(BlockDriverState *bs,
+                                    void *dest, size_t dest_size,
+                                    const void *src, size_t src_size,
+                                    Qcow2CompressFunc func)
 {
     BDRVQcow2State *s = bs->opaque;
     BlockAIOCB *acb;
@@ -3838,6 +3842,7 @@ static ssize_t qcow2_co_compress(BlockDriverState *bs,
         .dest_size = dest_size,
         .src = src,
         .src_size = src_size,
+        .func = func,
     };
 
     while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
@@ -3860,6 +3865,22 @@ static ssize_t qcow2_co_compress(BlockDriverState *bs,
     return arg.ret;
 }
 
+static ssize_t qcow2_co_compress(BlockDriverState *bs,
+                                 void *dest, size_t dest_size,
+                                 const void *src, size_t src_size)
+{
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
+                                qcow2_compress);
+}
+
+static ssize_t qcow2_co_decompress(BlockDriverState *bs,
+                                   void *dest, size_t dest_size,
+                                   const void *src, size_t src_size)
+{
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
+                                qcow2_decompress);
+}
+
 /* XXX: put compressed sectors first, then all the cluster aligned
    tables to avoid losing bytes in alignment */
 static coroutine_fn int
@@ -3987,7 +4008,7 @@ static int qcow2_co_preadv_compressed(BlockDriverState *bs,
         goto fail;
     }
 
-    if (qcow2_decompress(out_buf, s->cluster_size, buf, csize) < 0) {
+    if (qcow2_co_decompress(bs, out_buf, s->cluster_size, buf, csize) < 0) {
         ret = -EIO;
         goto fail;
     }
-- 
2.18.0
