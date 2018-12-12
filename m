Received: from eggs.gnu.org ([2001:4830:134:3::10]:46472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z1-0003C7-2Y
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z0-0001Z3-4c
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:35 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:16 +0100
Message-Id: <20181212132735.16080-23-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/41] file-posix: Avoid aio_worker() for
 QEMU_AIO_READ/WRITE
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
 block/file-posix.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 877c0700e1..0f64c83639 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1300,8 +1300,9 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIODa=
ta *aiocb, char *buf)
     return offset;
 }
=20
-static ssize_t handle_aiocb_rw(RawPosixAIOData *aiocb)
+static int handle_aiocb_rw(void *opaque)
 {
+    RawPosixAIOData *aiocb =3D opaque;
     ssize_t nbytes;
     char *buf;
=20
@@ -1793,15 +1794,11 @@ static int aio_worker(void *arg)
     ssize_t ret =3D 0;
=20
     switch (aiocb->aio_type & QEMU_AIO_TYPE_MASK) {
-    case QEMU_AIO_READ:
-        ret =3D handle_aiocb_rw(aiocb);
-        break;
-    case QEMU_AIO_WRITE:
-        ret =3D handle_aiocb_rw(aiocb);
-        break;
     case QEMU_AIO_IOCTL:
         ret =3D handle_aiocb_ioctl(aiocb);
         break;
+    case QEMU_AIO_READ:
+    case QEMU_AIO_WRITE:
     case QEMU_AIO_FLUSH:
     case QEMU_AIO_DISCARD:
     case QEMU_AIO_WRITE_ZEROES:
@@ -1865,6 +1862,7 @@ static int coroutine_fn raw_co_prw(BlockDriverState=
 *bs, uint64_t offset,
                                    uint64_t bytes, QEMUIOVector *qiov, i=
nt type)
 {
     BDRVRawState *s =3D bs->opaque;
+    RawPosixAIOData acb;
=20
     if (fd_open(bs) < 0)
         return -EIO;
@@ -1887,7 +1885,20 @@ static int coroutine_fn raw_co_prw(BlockDriverStat=
e *bs, uint64_t offset,
         }
     }
=20
-    return paio_submit_co(bs, s->fd, offset, qiov, bytes, type);
+    acb =3D (RawPosixAIOData) {
+        .bs             =3D bs,
+        .aio_fildes     =3D s->fd,
+        .aio_type       =3D type,
+        .aio_offset     =3D offset,
+        .aio_nbytes     =3D bytes,
+        .io             =3D {
+            .iov            =3D qiov->iov,
+            .niov           =3D qiov->niov,
+        },
+    };
+
+    assert(qiov->size =3D=3D bytes);
+    return raw_thread_pool_submit(bs, handle_aiocb_rw, &acb);
 }
=20
 static int coroutine_fn raw_co_preadv(BlockDriverState *bs, uint64_t off=
set,
--=20
2.19.2
