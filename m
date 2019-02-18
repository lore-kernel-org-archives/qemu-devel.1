Received: from eggs.gnu.org ([209.51.188.92]:34893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldR-0006MJ-Dx
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldQ-0002RK-8x
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Feb 2019 17:18:20 +0100
Message-Id: <20190218161822.3573-11-kwolf@redhat.com>
In-Reply-To: <20190218161822.3573-1-kwolf@redhat.com>
References: <20190218161822.3573-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/12] test-bdrv-drain: AioContext switch in
 drained section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index ee1740ff06..1b1f6c17a5 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1522,6 +1522,36 @@ static void test_append_to_drained(void)
     blk_unref(blk);
 }
=20
+static void test_set_aio_context(void)
+{
+    BlockDriverState *bs;
+    IOThread *a =3D iothread_new();
+    IOThread *b =3D iothread_new();
+    AioContext *ctx_a =3D iothread_get_aio_context(a);
+    AioContext *ctx_b =3D iothread_get_aio_context(b);
+
+    bs =3D bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
+                              &error_abort);
+
+    bdrv_drained_begin(bs);
+    bdrv_set_aio_context(bs, ctx_a);
+
+    aio_context_acquire(ctx_a);
+    bdrv_drained_end(bs);
+
+    bdrv_drained_begin(bs);
+    bdrv_set_aio_context(bs, ctx_b);
+    aio_context_release(ctx_a);
+    aio_context_acquire(ctx_b);
+    bdrv_set_aio_context(bs, qemu_get_aio_context());
+    aio_context_release(ctx_b);
+    bdrv_drained_end(bs);
+
+    bdrv_unref(bs);
+    iothread_join(a);
+    iothread_join(b);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -1603,6 +1633,8 @@ int main(int argc, char **argv)
=20
     g_test_add_func("/bdrv-drain/attach/drain", test_append_to_drained);
=20
+    g_test_add_func("/bdrv-drain/set_aio_context", test_set_aio_context)=
;
+
     ret =3D g_test_run();
     qemu_event_destroy(&done_event);
     return ret;
--=20
2.20.1
