Received: from eggs.gnu.org ([209.51.188.92]:48780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMb51-0003Ln-6V
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMb50-0005Iv-9D
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:30:35 -0400
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri,  3 May 2019 18:30:28 +0200
Message-Id: <20190503163028.213823-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] block/rbd: increase dynamically the image
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Josh Durgin <jdurgin@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

RBD APIs don't allow us to write more than the size set with
rbd_create() or rbd_resize().
In order to support growing images (eg. qcow2), we resize the
image before write operations that exceed the current size.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
  - use bs->total_sectors instead of adding a new field [Kevin]
  - resize the image only during write operation [Kevin]
    for read operation, the bdrv_aligned_preadv() already handles reads
    that exceed the length returned by bdrv_getlength(), so IMHO we can
    avoid to handle it in the rbd driver
---
 block/rbd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/rbd.c b/block/rbd.c
index 0c549c9935..613e8f4982 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -934,13 +934,25 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *=
bs,
     }
=20
     switch (cmd) {
-    case RBD_AIO_WRITE:
+    case RBD_AIO_WRITE: {
+        /*
+         * RBD APIs don't allow us to write more than actual size, so in=
 order
+         * to support growing images, we resize the image before write
+         * operations that exceed the current size.
+         */
+        if (off + size > bs->total_sectors * BDRV_SECTOR_SIZE) {
+            r =3D rbd_resize(s->image, off + size);
+            if (r < 0) {
+                goto failed_completion;
+            }
+        }
 #ifdef LIBRBD_SUPPORTS_IOVEC
             r =3D rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c=
);
 #else
             r =3D rbd_aio_write(s->image, off, size, rcb->buf, c);
 #endif
         break;
+    }
     case RBD_AIO_READ:
 #ifdef LIBRBD_SUPPORTS_IOVEC
             r =3D rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c)=
;
--=20
2.20.1
