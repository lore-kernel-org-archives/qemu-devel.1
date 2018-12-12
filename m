Received: from eggs.gnu.org ([2001:4830:134:3::10]:46280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Ym-0002vF-Ck
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yl-0001Mi-HD
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:10 +0100
Message-Id: <20181212132735.16080-17-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/41] file-posix: Avoid aio_worker() for
 QEMU_AIO_TRUNCATE
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
 block/file-posix.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 27be94cfe5..7c5121efc9 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1645,8 +1645,9 @@ static ssize_t handle_aiocb_discard(RawPosixAIOData=
 *aiocb)
     return ret;
 }
=20
-static int handle_aiocb_truncate(RawPosixAIOData *aiocb)
+static int handle_aiocb_truncate(void *opaque)
 {
+    RawPosixAIOData *aiocb =3D opaque;
     int result =3D 0;
     int64_t current_length =3D 0;
     char *buf =3D NULL;
@@ -1812,8 +1813,7 @@ static int aio_worker(void *arg)
         ret =3D handle_aiocb_copy_range(aiocb);
         break;
     case QEMU_AIO_TRUNCATE:
-        ret =3D handle_aiocb_truncate(aiocb);
-        break;
+        g_assert_not_reached();
     default:
         error_report("invalid aio request (0x%x)", aiocb->aio_type);
         ret =3D -EINVAL;
@@ -1981,9 +1981,9 @@ static int coroutine_fn
 raw_regular_truncate(BlockDriverState *bs, int fd, int64_t offset,
                      PreallocMode prealloc, Error **errp)
 {
-    RawPosixAIOData *acb =3D g_new(RawPosixAIOData, 1);
+    RawPosixAIOData acb;
=20
-    *acb =3D (RawPosixAIOData) {
+    acb =3D (RawPosixAIOData) {
         .bs             =3D bs,
         .aio_fildes     =3D fd,
         .aio_type       =3D QEMU_AIO_TRUNCATE,
@@ -1994,7 +1994,7 @@ raw_regular_truncate(BlockDriverState *bs, int fd, =
int64_t offset,
         },
     };
=20
-    return raw_thread_pool_submit(bs, aio_worker, acb);
+    return raw_thread_pool_submit(bs, handle_aiocb_truncate, &acb);
 }
=20
 static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t of=
fset,
--=20
2.19.2
