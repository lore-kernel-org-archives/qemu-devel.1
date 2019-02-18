Received: from eggs.gnu.org ([209.51.188.92]:34851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldQ-0006K3-MD
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldP-0002QP-DK
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Feb 2019 17:18:19 +0100
Message-Id: <20190218161822.3573-10-kwolf@redhat.com>
In-Reply-To: <20190218161822.3573-1-kwolf@redhat.com>
References: <20190218161822.3573-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/12] block: Fix AioContext switch for drained
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
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

When a drained node changes its AioContext, we need to move its
aio_disable_external() to the new context, too.

Without this fix, drain_end will try to reenable the new context, which
has never been disabled, so an assertion failure is triggered.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
