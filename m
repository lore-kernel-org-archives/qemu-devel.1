Received: from eggs.gnu.org ([209.51.188.92]:48777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUur-000833-Kf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUup-00025l-2Y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:32 +0200
Message-Id: <20190430154244.30083-16-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/27] qcow2: Fix error handling in the
 compression code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This patch fixes a few things in the way error codes are handled in
the qcow2 compression code:

a) qcow2_co_pwritev_compressed() expects qcow2_co_compress() to only
   return -1 or -2 on failure, but this is not correct. Since the
   change from qcow2_compress() to qcow2_co_compress() in commit
   ceb029cd6feccf9f7607 the new code can also return -EINVAL (although
   there does not seem to exist any code path that would cause that
   error in the current implementation).

b) -1 and -2 are ad-hoc error codes defined in qcow2_compress().
   This patch replaces them with standard constants from errno.h.

c) Both qcow2_compress() and qcow2_co_do_compress() return a negative
   value on failure, but qcow2_co_pwritev_compressed() stores the
   value in an unsigned data type.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 840f289a48..c5c17734d7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3929,8 +3929,8 @@ fail:
  * @src - source buffer, @src_size bytes
  *
  * Returns: compressed size on success
- *          -1 destination buffer is not enough to store compressed data
- *          -2 on any other error
+ *          -ENOMEM destination buffer is not enough to store compressed=
 data
+ *          -EIO    on any other error
  */
 static ssize_t qcow2_compress(void *dest, size_t dest_size,
                               const void *src, size_t src_size)
@@ -3943,7 +3943,7 @@ static ssize_t qcow2_compress(void *dest, size_t de=
st_size,
     ret =3D deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
                        -12, 9, Z_DEFAULT_STRATEGY);
     if (ret !=3D Z_OK) {
-        return -2;
+        return -EIO;
     }
=20
     /* strm.next_in is not const in old zlib versions, such as those use=
d on
@@ -3957,7 +3957,7 @@ static ssize_t qcow2_compress(void *dest, size_t de=
st_size,
     if (ret =3D=3D Z_STREAM_END) {
         ret =3D dest_size - strm.avail_out;
     } else {
-        ret =3D (ret =3D=3D Z_OK ? -1 : -2);
+        ret =3D (ret =3D=3D Z_OK ? -ENOMEM : -EIO);
     }
=20
     deflateEnd(&strm);
@@ -4096,7 +4096,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
     BDRVQcow2State *s =3D bs->opaque;
     QEMUIOVector hd_qiov;
     int ret;
-    size_t out_len;
+    ssize_t out_len;
     uint8_t *buf, *out_buf;
     uint64_t cluster_offset;
=20
@@ -4135,16 +4135,16 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs,=
 uint64_t offset,
=20
     out_len =3D qcow2_co_compress(bs, out_buf, s->cluster_size - 1,
                                 buf, s->cluster_size);
-    if (out_len =3D=3D -2) {
-        ret =3D -EINVAL;
-        goto fail;
-    } else if (out_len =3D=3D -1) {
+    if (out_len =3D=3D -ENOMEM) {
         /* could not compress: write normal cluster */
         ret =3D qcow2_co_pwritev(bs, offset, bytes, qiov, 0);
         if (ret < 0) {
             goto fail;
         }
         goto success;
+    } else if (out_len < 0) {
+        ret =3D -EINVAL;
+        goto fail;
     }
=20
     qemu_co_mutex_lock(&s->lock);
--=20
2.20.1
