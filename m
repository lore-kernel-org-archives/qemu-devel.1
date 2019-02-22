Received: from eggs.gnu.org ([209.51.188.92]:38086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVM-0002TJ-BK
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVH-0001ya-RQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:41 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:43 +0000
Message-Id: <20190222140756.29834-15-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/27] tests/test-bdrv-drain: use
 QEMU_IOVEC_INIT_BUF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use new QEMU_IOVEC_INIT_BUF() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-15-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-15-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/test-bdrv-drain.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index ee1740ff06..821be405f0 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -204,12 +204,7 @@ static void test_drv_cb_common(enum drain_type drain=
_type, bool recursive)
     BlockAIOCB *acb;
     int aio_ret;
=20
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base =3D NULL,
-        .iov_len =3D 0,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
=20
     blk =3D blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
     bs =3D bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
@@ -670,12 +665,7 @@ static void test_iothread_common(enum drain_type dra=
in_type, int drain_thread)
     AioContext *ctx_a =3D iothread_get_aio_context(a);
     AioContext *ctx_b =3D iothread_get_aio_context(b);
=20
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base =3D NULL,
-        .iov_len =3D 0,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
=20
     /* bdrv_drain_all() may only be called from the main loop thread */
     if (drain_type =3D=3D BDRV_DRAIN_ALL && drain_thread !=3D 0) {
@@ -1148,13 +1138,7 @@ static void coroutine_fn test_co_delete_by_drain(v=
oid *opaque)
     BlockDriverState *bs =3D blk_bs(blk);
     BDRVTestTopState *tts =3D bs->opaque;
     void *buffer =3D g_malloc(65536);
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base =3D buffer,
-        .iov_len  =3D 65536,
-    };
-
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, buffer, 65536);
=20
     /* Pretend some internal write operation from parent to child.
      * Important: We have to read from the child, not from the parent!
@@ -1365,12 +1349,7 @@ static void test_detach_indirect(bool by_parent_cb=
)
     BdrvChild *child_a, *child_b;
     BlockAIOCB *acb;
=20
-    QEMUIOVector qiov;
-    struct iovec iov =3D {
-        .iov_base =3D NULL,
-        .iov_len =3D 0,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
=20
     if (!by_parent_cb) {
         detach_by_driver_cb_role =3D child_file;
--=20
2.20.1
