Received: from eggs.gnu.org ([209.51.188.92]:34499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEXHv-0001ma-2Y
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEXHt-0006fX-W5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:50:35 -0400
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 11 Apr 2019 12:50:25 +0200
Message-Id: <20190411105025.97397-2-sgarzare@redhat.com>
In-Reply-To: <20190411105025.97397-1-sgarzare@redhat.com>
References: <20190411105025.97397-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC 1/1] block/rbd: increase dynamically the
 image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Kevin Wolf <kwolf@redhat.com>

RBD APIs don't allow us to write more than the size set with rbd_create()
or rbd_resize().
In order to support growing images (eg. qcow2), we resize the image
before RW operations that exceed the current size.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1171007
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/rbd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 0c549c9935..228658e20a 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -102,6 +102,7 @@ typedef struct BDRVRBDState {
     rbd_image_t image;
     char *image_name;
     char *snap;
+    uint64_t image_size;
 } BDRVRBDState;
=20
 static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
@@ -777,6 +778,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict=
 *options, int flags,
         goto failed_open;
     }
=20
+    r =3D rbd_get_size(s->image, &s->image_size);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "error reading image size from %s",
+                         s->image_name);
+        rbd_close(s->image);
+        goto failed_open;
+    }
+
     /* If we are using an rbd snapshot, we must be r/o, otherwise
      * leave as-is */
     if (s->snap !=3D NULL) {
@@ -921,6 +930,20 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *b=
s,
         rcb->buf =3D acb->bounce;
     }
=20
+    /*
+     * RBD APIs don't allow us to write more than actual size, so in ord=
er
+     * to support growing images, we resize the image before RW operatio=
ns
+     * that exceed the current size.
+     */
+    if (s->image_size < off + size) {
+        r =3D rbd_resize(s->image, off + size);
+        if (r < 0) {
+            goto failed;
+        }
+
+        s->image_size =3D off + size;
+    }
+
     acb->ret =3D 0;
     acb->error =3D 0;
     acb->s =3D s;
@@ -1066,6 +1089,8 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockD=
riverState *bs,
         return r;
     }
=20
+    s->image_size =3D offset;
+
     return 0;
 }
=20
--=20
2.20.1
