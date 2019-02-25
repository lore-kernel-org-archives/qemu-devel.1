Received: from eggs.gnu.org ([209.51.188.92]:37360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4p-0000J4-C3
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4h-0000uY-5g
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:02 +0100
Message-Id: <20190225152053.15976-21-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/71] block: Use normal drain for
 bdrv_set_aio_context()
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

Now that bdrv_set_aio_context() works inside drained sections, it can
also use the real drain function instead of open coding something
similar.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/block.c b/block.c
index aefb5701f5..375a216f76 100644
--- a/block.c
+++ b/block.c
@@ -5268,18 +5268,16 @@ void bdrv_attach_aio_context(BlockDriverState *bs=
,
     bs->walking_aio_notifiers =3D false;
 }
=20
+/* The caller must own the AioContext lock for the old AioContext of bs,=
 but it
+ * must not own the AioContext lock for new_context (unless new_context =
is
+ * the same as the current context of bs). */
 void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
 {
-    AioContext *ctx =3D bdrv_get_aio_context(bs);
-
-    if (ctx =3D=3D new_context) {
+    if (bdrv_get_aio_context(bs) =3D=3D new_context) {
         return;
     }
=20
-    aio_disable_external(ctx);
-    bdrv_parent_drained_begin(bs, NULL, false);
-    bdrv_drain(bs); /* ensure there are no in-flight requests */
-
+    bdrv_drained_begin(bs);
     bdrv_detach_aio_context(bs);
=20
     /* This function executes in the old AioContext so acquire the new o=
ne in
@@ -5287,8 +5285,7 @@ void bdrv_set_aio_context(BlockDriverState *bs, Aio=
Context *new_context)
      */
     aio_context_acquire(new_context);
     bdrv_attach_aio_context(bs, new_context);
-    bdrv_parent_drained_end(bs, NULL, false);
-    aio_enable_external(ctx);
+    bdrv_drained_end(bs);
     aio_context_release(new_context);
 }
=20
--=20
2.20.1
