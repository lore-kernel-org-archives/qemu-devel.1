Received: from eggs.gnu.org ([2001:4830:134:3::10]:46146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yc-0002Sh-PP
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yb-00015t-K7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:04 +0100
Message-Id: <20181212132735.16080-11-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/41] qcow2: refactor decompress_buffer
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

- make it look more like a pair of qcow2_compress - rename the function
  and its parameters
- drop extra out_len variable, check filling of output buffer by strm
  structure itself
- fix code style
- add some documentation

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 56 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d4d141c495..ac9bb3a225 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3762,32 +3762,46 @@ static ssize_t qcow2_compress(void *dest, size_t =
dest_size,
     return ret;
 }
=20
-static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
-                             const uint8_t *buf, int buf_size)
+/*
+ * qcow2_decompress()
+ *
+ * Decompress some data (not more than @src_size bytes) to produce exact=
ly
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
-    z_stream strm1, *strm =3D &strm1;
-    int ret, out_len;
-
-    memset(strm, 0, sizeof(*strm));
+    int ret =3D 0;
+    z_stream strm;
=20
-    strm->next_in =3D (uint8_t *)buf;
-    strm->avail_in =3D buf_size;
-    strm->next_out =3D out_buf;
-    strm->avail_out =3D out_buf_size;
+    memset(&strm, 0, sizeof(strm));
+    strm.avail_in =3D src_size;
+    strm.next_in =3D (void *) src;
+    strm.avail_out =3D dest_size;
+    strm.next_out =3D dest;
=20
-    ret =3D inflateInit2(strm, -12);
+    ret =3D inflateInit2(&strm, -12);
     if (ret !=3D Z_OK) {
         return -1;
     }
-    ret =3D inflate(strm, Z_FINISH);
-    out_len =3D strm->next_out - out_buf;
-    if ((ret !=3D Z_STREAM_END && ret !=3D Z_BUF_ERROR) ||
-        out_len !=3D out_buf_size) {
-        inflateEnd(strm);
-        return -1;
+
+    ret =3D inflate(&strm, Z_FINISH);
+    if ((ret !=3D Z_STREAM_END && ret !=3D Z_BUF_ERROR) || strm.avail_ou=
t !=3D 0) {
+        /* We approve Z_BUF_ERROR because we need @dest buffer to be fil=
led, but
+         * @src buffer may be processed partly (because in qcow2 we know=
 size of
+         * compressed data with precision of one sector) */
+        ret =3D -1;
     }
-    inflateEnd(strm);
-    return 0;
+
+    inflateEnd(&strm);
+
+    return ret;
 }
=20
 #define MAX_COMPRESS_THREADS 4
@@ -3977,8 +3991,8 @@ int qcow2_decompress_cluster(BlockDriverState *bs, =
uint64_t cluster_offset)
         if (ret < 0) {
             return ret;
         }
-        if (decompress_buffer(s->cluster_cache, s->cluster_size,
-                              s->cluster_data + sector_offset, csize) < =
0) {
+        if (qcow2_decompress(s->cluster_cache, s->cluster_size,
+                             s->cluster_data + sector_offset, csize) < 0=
) {
             return -EIO;
         }
         s->cluster_cache_offset =3D coffset;
--=20
2.19.2
