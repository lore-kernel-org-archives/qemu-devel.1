Received: from eggs.gnu.org ([2001:4830:134:3::10]:46411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yw-00037F-M9
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yv-0001V9-KG
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:13 +0100
Message-Id: <20181212132735.16080-20-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/41] file-posix: Avoid aio_worker() for
 QEMU_AIO_DISCARD
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

aio_worker() doesn't add anything interesting, it's only a useless
indirection. Call the handler function directly instead.

As we know that this handler function is only called from coroutine
context and the coroutine stays around until the worker thread finishes,
we can keep RawPosixAIOData on the stack.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 16f2b202c6..88887108a7 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1608,8 +1608,9 @@ static int handle_aiocb_copy_range(void *opaque)
     return 0;
 }
=20
-static ssize_t handle_aiocb_discard(RawPosixAIOData *aiocb)
+static int handle_aiocb_discard(void *opaque)
 {
+    RawPosixAIOData *aiocb =3D opaque;
     int ret =3D -EOPNOTSUPP;
     BDRVRawState *s =3D aiocb->bs->opaque;
=20
@@ -1804,8 +1805,6 @@ static int aio_worker(void *arg)
         ret =3D handle_aiocb_ioctl(aiocb);
         break;
     case QEMU_AIO_DISCARD:
-        ret =3D handle_aiocb_discard(aiocb);
-        break;
     case QEMU_AIO_WRITE_ZEROES:
     case QEMU_AIO_WRITE_ZEROES | QEMU_AIO_DISCARD:
     case QEMU_AIO_COPY_RANGE:
@@ -2622,11 +2621,30 @@ static void coroutine_fn raw_co_invalidate_cache(=
BlockDriverState *bs,
 }
=20
 static coroutine_fn int
-raw_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
+raw_do_pdiscard(BlockDriverState *bs, int64_t offset, int bytes, bool bl=
kdev)
 {
     BDRVRawState *s =3D bs->opaque;
+    RawPosixAIOData acb;
+
+    acb =3D (RawPosixAIOData) {
+        .bs             =3D bs,
+        .aio_fildes     =3D s->fd,
+        .aio_type       =3D QEMU_AIO_DISCARD,
+        .aio_offset     =3D offset,
+        .aio_nbytes     =3D bytes,
+    };
=20
-    return paio_submit_co(bs, s->fd, offset, NULL, bytes, QEMU_AIO_DISCA=
RD);
+    if (blkdev) {
+        acb.aio_type |=3D QEMU_AIO_BLKDEV;
+    }
+
+    return raw_thread_pool_submit(bs, handle_aiocb_discard, &acb);
+}
+
+static coroutine_fn int
+raw_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
+{
+    return raw_do_pdiscard(bs, offset, bytes, false);
 }
=20
 static int coroutine_fn
@@ -3154,15 +3172,13 @@ static int fd_open(BlockDriverState *bs)
 static coroutine_fn int
 hdev_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
-    BDRVRawState *s =3D bs->opaque;
     int ret;
=20
     ret =3D fd_open(bs);
     if (ret < 0) {
         return ret;
     }
-    return paio_submit_co(bs, s->fd, offset, NULL, bytes,
-                          QEMU_AIO_DISCARD | QEMU_AIO_BLKDEV);
+    return raw_do_pdiscard(bs, offset, bytes, true);
 }
=20
 static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
--=20
2.19.2
