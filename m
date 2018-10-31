Received: from eggs.gnu.org ([2001:4830:134:3::10]:57723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHyTv-0004bi-S9
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 17:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHyTn-0008EE-SI
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 17:56:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 31 Oct 2018 22:56:17 +0100
Message-Id: <20181031215622.27690-8-kwolf@redhat.com>
In-Reply-To: <20181031215622.27690-1-kwolf@redhat.com>
References: <20181031215622.27690-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/12] file-posix: Avoid aio_worker() for
 QEMU_AIO_FLUSH
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

aio_worker() doesn't add anything interesting, it's only a useless
indirection. Call the handler function directly instead.

As we know that this handler function is only called from coroutine
context and the coroutine stays around until the worker thread finishes,
we can keep RawPosixAIOData on the stack.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 291ffaeded..074848ed1f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1143,8 +1143,9 @@ static ssize_t handle_aiocb_ioctl(RawPosixAIOData *=
aiocb)
     return 0;
 }
=20
-static ssize_t handle_aiocb_flush(RawPosixAIOData *aiocb)
+static int handle_aiocb_flush(void *opaque)
 {
+    RawPosixAIOData *aiocb =3D opaque;
     BDRVRawState *s =3D aiocb->bs->opaque;
     int ret;
=20
@@ -1777,12 +1778,10 @@ static int aio_worker(void *arg)
             ret =3D -EINVAL;
         }
         break;
-    case QEMU_AIO_FLUSH:
-        ret =3D handle_aiocb_flush(aiocb);
-        break;
     case QEMU_AIO_IOCTL:
         ret =3D handle_aiocb_ioctl(aiocb);
         break;
+    case QEMU_AIO_FLUSH:
     case QEMU_AIO_DISCARD:
     case QEMU_AIO_WRITE_ZEROES:
     case QEMU_AIO_WRITE_ZEROES | QEMU_AIO_DISCARD:
@@ -1910,6 +1909,7 @@ static void raw_aio_unplug(BlockDriverState *bs)
 static int raw_co_flush_to_disk(BlockDriverState *bs)
 {
     BDRVRawState *s =3D bs->opaque;
+    RawPosixAIOData acb;
     int ret;
=20
     ret =3D fd_open(bs);
@@ -1917,7 +1917,13 @@ static int raw_co_flush_to_disk(BlockDriverState *=
bs)
         return ret;
     }
=20
-    return paio_submit_co(bs, s->fd, 0, NULL, 0, QEMU_AIO_FLUSH);
+    acb =3D (RawPosixAIOData) {
+        .bs             =3D bs,
+        .aio_fildes     =3D s->fd,
+        .aio_type       =3D QEMU_AIO_FLUSH,
+    };
+
+    return raw_thread_pool_submit(bs, handle_aiocb_flush, &acb);
 }
=20
 static void raw_aio_attach_aio_context(BlockDriverState *bs,
--=20
2.19.1
