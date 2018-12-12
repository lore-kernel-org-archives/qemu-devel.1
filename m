Received: from eggs.gnu.org ([2001:4830:134:3::10]:46337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Ys-00034u-Ah
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yr-0001Qn-8p
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:12 +0100
Message-Id: <20181212132735.16080-19-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/41] file-posix: Avoid aio_worker() for
 QEMU_AIO_WRITE_ZEROES
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
 block/file-posix.c | 53 +++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index e502ba7e15..16f2b202c6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1464,8 +1464,9 @@ static ssize_t handle_aiocb_write_zeroes_block(RawP=
osixAIOData *aiocb)
     return ret;
 }
=20
-static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
+static int handle_aiocb_write_zeroes(void *opaque)
 {
+    RawPosixAIOData *aiocb =3D opaque;
 #if defined(CONFIG_FALLOCATE) || defined(CONFIG_XFS)
     BDRVRawState *s =3D aiocb->bs->opaque;
 #endif
@@ -1529,8 +1530,9 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAI=
OData *aiocb)
     return -ENOTSUP;
 }
=20
-static ssize_t handle_aiocb_write_zeroes_unmap(RawPosixAIOData *aiocb)
+static int handle_aiocb_write_zeroes_unmap(void *opaque)
 {
+    RawPosixAIOData *aiocb =3D opaque;
     BDRVRawState *s G_GNUC_UNUSED =3D aiocb->bs->opaque;
     int ret;
=20
@@ -1805,11 +1807,7 @@ static int aio_worker(void *arg)
         ret =3D handle_aiocb_discard(aiocb);
         break;
     case QEMU_AIO_WRITE_ZEROES:
-        ret =3D handle_aiocb_write_zeroes(aiocb);
-        break;
     case QEMU_AIO_WRITE_ZEROES | QEMU_AIO_DISCARD:
-        ret =3D handle_aiocb_write_zeroes_unmap(aiocb);
-        break;
     case QEMU_AIO_COPY_RANGE:
     case QEMU_AIO_TRUNCATE:
         g_assert_not_reached();
@@ -2631,18 +2629,41 @@ raw_co_pdiscard(BlockDriverState *bs, int64_t off=
set, int bytes)
     return paio_submit_co(bs, s->fd, offset, NULL, bytes, QEMU_AIO_DISCA=
RD);
 }
=20
-static int coroutine_fn raw_co_pwrite_zeroes(
-    BlockDriverState *bs, int64_t offset,
-    int bytes, BdrvRequestFlags flags)
+static int coroutine_fn
+raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
+                     BdrvRequestFlags flags, bool blkdev)
 {
     BDRVRawState *s =3D bs->opaque;
-    int operation =3D QEMU_AIO_WRITE_ZEROES;
+    RawPosixAIOData acb;
+    ThreadPoolFunc *handler;
+
+    acb =3D (RawPosixAIOData) {
+        .bs             =3D bs,
+        .aio_fildes     =3D s->fd,
+        .aio_type       =3D QEMU_AIO_WRITE_ZEROES,
+        .aio_offset     =3D offset,
+        .aio_nbytes     =3D bytes,
+    };
+
+    if (blkdev) {
+        acb.aio_type |=3D QEMU_AIO_BLKDEV;
+    }
=20
     if (flags & BDRV_REQ_MAY_UNMAP) {
-        operation |=3D QEMU_AIO_DISCARD;
+        acb.aio_type |=3D QEMU_AIO_DISCARD;
+        handler =3D handle_aiocb_write_zeroes_unmap;
+    } else {
+        handler =3D handle_aiocb_write_zeroes;
     }
=20
-    return paio_submit_co(bs, s->fd, offset, NULL, bytes, operation);
+    return raw_thread_pool_submit(bs, handler, &acb);
+}
+
+static int coroutine_fn raw_co_pwrite_zeroes(
+    BlockDriverState *bs, int64_t offset,
+    int bytes, BdrvRequestFlags flags)
+{
+    return raw_do_pwrite_zeroes(bs, offset, bytes, flags, false);
 }
=20
 static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
@@ -3147,8 +3168,6 @@ hdev_co_pdiscard(BlockDriverState *bs, int64_t offs=
et, int bytes)
 static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
-    BDRVRawState *s =3D bs->opaque;
-    int operation =3D QEMU_AIO_WRITE_ZEROES | QEMU_AIO_BLKDEV;
     int rc;
=20
     rc =3D fd_open(bs);
@@ -3156,11 +3175,7 @@ static coroutine_fn int hdev_co_pwrite_zeroes(Bloc=
kDriverState *bs,
         return rc;
     }
=20
-    if (flags & BDRV_REQ_MAY_UNMAP) {
-        operation |=3D QEMU_AIO_DISCARD;
-    }
-
-    return paio_submit_co(bs, s->fd, offset, NULL, bytes, operation);
+    return raw_do_pwrite_zeroes(bs, offset, bytes, flags, true);
 }
=20
 static int coroutine_fn hdev_co_create_opts(const char *filename, QemuOp=
ts *opts,
--=20
2.19.2
