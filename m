Received: from eggs.gnu.org ([2001:4830:134:3::10]:46114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yb-0002RE-Ka
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Ya-00013l-ED
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:09 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:02 +0100
Message-Id: <20181212132735.16080-9-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/41] qcow2: make more generic interface for
 qcow2_compress
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

Give explicit size both for source and destination buffers, to make it
similar with decompression path and than cleanly reuse parameter
structure for decompression threads.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 225fcbde67..0c1569f715 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3722,14 +3722,15 @@ fail:
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
@@ -3744,14 +3745,14 @@ static ssize_t qcow2_compress(void *dest, const v=
oid *src, size_t size)
=20
     /* strm.next_in is not const in old zlib versions, such as those use=
d on
      * OpenBSD/NetBSD, so cast the const away */
-    strm.avail_in =3D size;
+    strm.avail_in =3D src_size;
     strm.next_in =3D (void *) src;
-    strm.avail_out =3D size - 1;
+    strm.avail_out =3D dest_size;
     strm.next_out =3D dest;
=20
     ret =3D deflate(&strm, Z_FINISH);
     if (ret =3D=3D Z_STREAM_END) {
-        ret =3D size - 1 - strm.avail_out;
+        ret =3D dest_size - strm.avail_out;
     } else {
         ret =3D (ret =3D=3D Z_OK ? -1 : -2);
     }
@@ -3765,8 +3766,9 @@ static ssize_t qcow2_compress(void *dest, const voi=
d *src, size_t size)
=20
 typedef struct Qcow2CompressData {
     void *dest;
+    size_t dest_size;
     const void *src;
-    size_t size;
+    size_t src_size;
     ssize_t ret;
 } Qcow2CompressData;
=20
@@ -3774,7 +3776,8 @@ static int qcow2_compress_pool_func(void *opaque)
 {
     Qcow2CompressData *data =3D opaque;
=20
-    data->ret =3D qcow2_compress(data->dest, data->src, data->size);
+    data->ret =3D qcow2_compress(data->dest, data->dest_size,
+                               data->src, data->src_size);
=20
     return 0;
 }
@@ -3786,15 +3789,17 @@ static void qcow2_compress_complete(void *opaque,=
 int ret)
=20
 /* See qcow2_compress definition for parameters description */
 static ssize_t qcow2_co_compress(BlockDriverState *bs,
-                                 void *dest, const void *src, size_t siz=
e)
+                                 void *dest, size_t dest_size,
+                                 const void *src, size_t src_size)
 {
     BDRVQcow2State *s =3D bs->opaque;
     BlockAIOCB *acb;
     ThreadPool *pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
     Qcow2CompressData arg =3D {
         .dest =3D dest,
+        .dest_size =3D dest_size,
         .src =3D src,
-        .size =3D size,
+        .src_size =3D src_size,
     };
=20
     while (s->nb_compress_threads >=3D MAX_COMPRESS_THREADS) {
@@ -3861,7 +3866,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
=20
     out_buf =3D g_malloc(s->cluster_size);
=20
-    out_len =3D qcow2_co_compress(bs, out_buf, buf, s->cluster_size);
+    out_len =3D qcow2_co_compress(bs, out_buf, s->cluster_size - 1,
+                                buf, s->cluster_size);
     if (out_len =3D=3D -2) {
         ret =3D -EINVAL;
         goto fail;
--=20
2.19.2
