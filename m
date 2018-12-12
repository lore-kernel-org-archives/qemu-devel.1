Received: from eggs.gnu.org ([2001:4830:134:3::10]:46200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yi-0002hk-Eu
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yh-0001Fh-HL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:16 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:07 +0100
Message-Id: <20181212132735.16080-14-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/41] qcow2: do decompression in threads
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

Do decompression in threads, like it is already done for compression.
This improves asynchronous compressed reads performance.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c1886c46e3..0b5ad13006 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3807,20 +3807,24 @@ static ssize_t qcow2_decompress(void *dest, size_=
t dest_size,
=20
 #define MAX_COMPRESS_THREADS 4
=20
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
=20
 static int qcow2_compress_pool_func(void *opaque)
 {
     Qcow2CompressData *data =3D opaque;
=20
-    data->ret =3D qcow2_compress(data->dest, data->dest_size,
-                               data->src, data->src_size);
+    data->ret =3D data->func(data->dest, data->dest_size,
+                           data->src, data->src_size);
=20
     return 0;
 }
@@ -3830,10 +3834,9 @@ static void qcow2_compress_complete(void *opaque, =
int ret)
     qemu_coroutine_enter(opaque);
 }
=20
-/* See qcow2_compress definition for parameters description */
-static ssize_t qcow2_co_compress(BlockDriverState *bs,
-                                 void *dest, size_t dest_size,
-                                 const void *src, size_t src_size)
+static ssize_t coroutine_fn
+qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
+                     const void *src, size_t src_size, Qcow2CompressFunc=
 func)
 {
     BDRVQcow2State *s =3D bs->opaque;
     BlockAIOCB *acb;
@@ -3843,6 +3846,7 @@ static ssize_t qcow2_co_compress(BlockDriverState *=
bs,
         .dest_size =3D dest_size,
         .src =3D src,
         .src_size =3D src_size,
+        .func =3D func,
     };
=20
     while (s->nb_compress_threads >=3D MAX_COMPRESS_THREADS) {
@@ -3865,6 +3869,22 @@ static ssize_t qcow2_co_compress(BlockDriverState =
*bs,
     return arg.ret;
 }
=20
+static ssize_t coroutine_fn
+qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
+                  const void *src, size_t src_size)
+{
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
+                                qcow2_compress);
+}
+
+static ssize_t coroutine_fn
+qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
+                    const void *src, size_t src_size)
+{
+    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
+                                qcow2_decompress);
+}
+
 /* XXX: put compressed sectors first, then all the cluster aligned
    tables to avoid losing bytes in alignment */
 static coroutine_fn int
@@ -3993,7 +4013,7 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
         goto fail;
     }
=20
-    if (qcow2_decompress(out_buf, s->cluster_size, buf, csize) < 0) {
+    if (qcow2_co_decompress(bs, out_buf, s->cluster_size, buf, csize) < =
0) {
         ret =3D -EIO;
         goto fail;
     }
--=20
2.19.2
