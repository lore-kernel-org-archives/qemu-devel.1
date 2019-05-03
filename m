Received: from eggs.gnu.org ([209.51.188.92]:56199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMVxH-0002LC-9z
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMVxG-0002hs-CK
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:02:15 -0400
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri,  3 May 2019 13:02:06 +0200
Message-Id: <20190503110206.42811-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] block/rbd: implement
 .bdrv_get_allocated_file_size callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Jason Dillaman <jdillama@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, qemu-block@nongnu.org

This patch allows 'qemu-img info' to show the 'disk size' for
rbd images. We use the rbd_diff_iterate2() API to calculate the
allocated size for the image.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/rbd.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 0c549c9935..61447bc0cb 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1046,6 +1046,38 @@ static int64_t qemu_rbd_getlength(BlockDriverState=
 *bs)
     return info.size;
 }
=20
+static int rbd_allocated_size_cb(uint64_t offset, size_t len, int exists=
,
+                                 void *arg)
+{
+    int64_t *alloc_size =3D (int64_t *) arg;
+
+    if (exists) {
+        (*alloc_size) +=3D len;
+    }
+
+    return 0;
+}
+
+static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *bs)
+{
+    BDRVRBDState *s =3D bs->opaque;
+    int64_t alloc_size =3D 0;
+    int r;
+
+    /*
+     * rbd_diff_iterate2(), if the source snapshot name is NULL, invokes
+     * the callback on all allocated regions of the image.
+     */
+    r =3D rbd_diff_iterate2(s->image, NULL, 0,
+                          bs->total_sectors * BDRV_SECTOR_SIZE, 0, 1,
+                          &rbd_allocated_size_cb, &alloc_size);
+    if (r < 0) {
+        return r;
+    }
+
+    return alloc_size;
+}
+
 static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
                                              int64_t offset,
                                              PreallocMode prealloc,
@@ -1254,6 +1286,7 @@ static BlockDriver bdrv_rbd =3D {
     .bdrv_get_info          =3D qemu_rbd_getinfo,
     .create_opts            =3D &qemu_rbd_create_opts,
     .bdrv_getlength         =3D qemu_rbd_getlength,
+    .bdrv_get_allocated_file_size =3D qemu_rbd_get_allocated_file_size,
     .bdrv_co_truncate       =3D qemu_rbd_co_truncate,
     .protocol_name          =3D "rbd",
=20
--=20
2.20.1
