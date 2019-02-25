Received: from eggs.gnu.org ([209.51.188.92]:37271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4h-00009x-A7
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4e-0000sk-UE
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:47 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:00 +0100
Message-Id: <20190225152053.15976-19-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/71] block: Fix AioContext switch for drained
 node
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

When a drained node changes its AioContext, we need to move its
aio_disable_external() to the new context, too.

Without this fix, drain_end will try to reenable the new context, which
has never been disabled, so an assertion failure is triggered.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block.c b/block.c
index 17bc1d3dca..aefb5701f5 100644
--- a/block.c
+++ b/block.c
@@ -5227,6 +5227,9 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
         bdrv_detach_aio_context(child->bs);
     }
=20
+    if (bs->quiesce_counter) {
+        aio_enable_external(bs->aio_context);
+    }
     bs->aio_context =3D NULL;
 }
=20
@@ -5240,6 +5243,10 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
         return;
     }
=20
+    if (bs->quiesce_counter) {
+        aio_disable_external(new_context);
+    }
+
     bs->aio_context =3D new_context;
=20
     QLIST_FOREACH(child, &bs->children, next) {
--=20
2.20.1
