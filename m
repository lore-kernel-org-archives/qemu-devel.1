Received: from eggs.gnu.org ([209.51.188.92]:55791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hGP4K-0008To-38
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hGP4J-00035Y-8L
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:28:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 16 Apr 2019 16:28:02 +0200
Message-Id: <20190416142802.11990-2-kwolf@redhat.com>
In-Reply-To: <20190416142802.11990-1-kwolf@redhat.com>
References: <20190416142802.11990-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] qcow2: Fix preallocation bdrv_pwrite to
 wrong file
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

With an external data file, preallocate_co() must write the final byte
to the external data file, not to the qcow2 image file.

This is harmless for preallocation of newly created images (only the
qcow2 file size is increased to the virtual disk size while it should be
much smaller), but with preallocated resize, it could in theory cause
visible corruption if the metadata of the image is larger than the data
(e.g. lots of bitmaps).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d507ee0686..3ace3b2209 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2723,6 +2723,7 @@ static int qcow2_set_up_encryption(BlockDriverState=
 *bs,
 static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t of=
fset,
                                        uint64_t new_length)
 {
+    BDRVQcow2State *s =3D bs->opaque;
     uint64_t bytes;
     uint64_t host_offset =3D 0;
     unsigned int cur_bytes;
@@ -2771,7 +2772,7 @@ static int coroutine_fn preallocate_co(BlockDriverS=
tate *bs, uint64_t offset,
      */
     if (host_offset !=3D 0) {
         uint8_t data =3D 0;
-        ret =3D bdrv_pwrite(bs->file, (host_offset + cur_bytes) - 1,
+        ret =3D bdrv_pwrite(s->data_file, (host_offset + cur_bytes) - 1,
                           &data, 1);
         if (ret < 0) {
             return ret;
--=20
2.20.1
