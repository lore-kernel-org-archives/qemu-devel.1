Received: from eggs.gnu.org ([2001:4830:134:3::10]:46539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z4-0003FY-1X
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Z3-0001bW-0h
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:37 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:19 +0100
Message-Id: <20181212132735.16080-26-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/41] file-posix: Avoid aio_worker() for
 QEMU_AIO_IOCTL
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

This was the last user of aio_worker(), so the function goes away now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 55 +++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 40 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9c15bbe429..a2ab2c19b8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1152,8 +1152,9 @@ static int hdev_probe_geometry(BlockDriverState *bs=
, HDGeometry *geo)
 }
 #endif
=20
-static ssize_t handle_aiocb_ioctl(RawPosixAIOData *aiocb)
+static int handle_aiocb_ioctl(void *opaque)
 {
+    RawPosixAIOData *aiocb =3D opaque;
     int ret;
=20
     ret =3D ioctl(aiocb->aio_fildes, aiocb->ioctl.cmd, aiocb->ioctl.buf)=
;
@@ -1788,34 +1789,6 @@ out:
     return result;
 }
=20
-static int aio_worker(void *arg)
-{
-    RawPosixAIOData *aiocb =3D arg;
-    ssize_t ret =3D 0;
-
-    switch (aiocb->aio_type & QEMU_AIO_TYPE_MASK) {
-    case QEMU_AIO_IOCTL:
-        ret =3D handle_aiocb_ioctl(aiocb);
-        break;
-    case QEMU_AIO_READ:
-    case QEMU_AIO_WRITE:
-    case QEMU_AIO_FLUSH:
-    case QEMU_AIO_DISCARD:
-    case QEMU_AIO_WRITE_ZEROES:
-    case QEMU_AIO_WRITE_ZEROES | QEMU_AIO_DISCARD:
-    case QEMU_AIO_COPY_RANGE:
-    case QEMU_AIO_TRUNCATE:
-        g_assert_not_reached();
-    default:
-        error_report("invalid aio request (0x%x)", aiocb->aio_type);
-        ret =3D -EINVAL;
-        break;
-    }
-
-    g_free(aiocb);
-    return ret;
-}
-
 static int coroutine_fn raw_thread_pool_submit(BlockDriverState *bs,
                                                ThreadPoolFunc func, void=
 *arg)
 {
@@ -3113,8 +3086,7 @@ static int coroutine_fn
 hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
 {
     BDRVRawState *s =3D bs->opaque;
-    RawPosixAIOData *acb;
-    ThreadPool *pool;
+    RawPosixAIOData acb;
     int ret;
=20
     ret =3D fd_open(bs);
@@ -3131,15 +3103,18 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long=
 int req, void *buf)
         }
     }
=20
-    acb =3D g_new(RawPosixAIOData, 1);
-    acb->bs =3D bs;
-    acb->aio_type =3D QEMU_AIO_IOCTL;
-    acb->aio_fildes =3D s->fd;
-    acb->aio_offset =3D 0;
-    acb->ioctl.buf =3D buf;
-    acb->ioctl.cmd =3D req;
-    pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
-    return thread_pool_submit_co(pool, aio_worker, acb);
+    acb =3D (RawPosixAIOData) {
+        .bs         =3D bs,
+        .aio_type   =3D QEMU_AIO_IOCTL,
+        .aio_fildes =3D s->fd,
+        .aio_offset =3D 0,
+        .ioctl      =3D {
+            .buf        =3D buf,
+            .cmd        =3D req,
+        },
+    };
+
+    return raw_thread_pool_submit(bs, handle_aiocb_ioctl, &acb);
 }
 #endif /* linux */
=20
--=20
2.19.2
