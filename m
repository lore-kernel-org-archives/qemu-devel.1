Received: from eggs.gnu.org ([2001:4830:134:3::10]:46333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Ys-00034s-5L
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yr-0001Qc-7t
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:11 +0100
Message-Id: <20181212132735.16080-18-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/41] file-posix: Avoid aio_worker() for
 QEMU_AIO_COPY_RANGE
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
 block/file-posix.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 7c5121efc9..e502ba7e15 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1572,8 +1572,9 @@ static off_t copy_file_range(int in_fd, off_t *in_o=
ff, int out_fd,
 }
 #endif
=20
-static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
+static int handle_aiocb_copy_range(void *opaque)
 {
+    RawPosixAIOData *aiocb =3D opaque;
     uint64_t bytes =3D aiocb->aio_nbytes;
     off_t in_off =3D aiocb->aio_offset;
     off_t out_off =3D aiocb->copy_range.aio_offset2;
@@ -1810,8 +1811,6 @@ static int aio_worker(void *arg)
         ret =3D handle_aiocb_write_zeroes_unmap(aiocb);
         break;
     case QEMU_AIO_COPY_RANGE:
-        ret =3D handle_aiocb_copy_range(aiocb);
-        break;
     case QEMU_AIO_TRUNCATE:
         g_assert_not_reached();
     default:
@@ -2714,6 +2713,7 @@ static int coroutine_fn raw_co_copy_range_to(BlockD=
riverState *bs,
                                              BdrvRequestFlags read_flags=
,
                                              BdrvRequestFlags write_flag=
s)
 {
+    RawPosixAIOData acb;
     BDRVRawState *s =3D bs->opaque;
     BDRVRawState *src_s;
=20
@@ -2726,8 +2726,20 @@ static int coroutine_fn raw_co_copy_range_to(Block=
DriverState *bs,
     if (fd_open(src->bs) < 0 || fd_open(dst->bs) < 0) {
         return -EIO;
     }
-    return paio_submit_co_full(bs, src_s->fd, src_offset, s->fd, dst_off=
set,
-                               NULL, bytes, QEMU_AIO_COPY_RANGE);
+
+    acb =3D (RawPosixAIOData) {
+        .bs             =3D bs,
+        .aio_type       =3D QEMU_AIO_COPY_RANGE,
+        .aio_fildes     =3D src_s->fd,
+        .aio_offset     =3D src_offset,
+        .aio_nbytes     =3D bytes,
+        .copy_range     =3D {
+            .aio_fd2        =3D s->fd,
+            .aio_offset2    =3D dst_offset,
+        },
+    };
+
+    return raw_thread_pool_submit(bs, handle_aiocb_copy_range, &acb);
 }
=20
 BlockDriver bdrv_file =3D {
--=20
2.19.2
