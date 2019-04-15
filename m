Received: from eggs.gnu.org ([209.51.188.92]:47703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hG3x5-0007fq-7o
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hG3x3-0003Ug-1l
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:55:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 15 Apr 2019 17:54:50 +0200
Message-Id: <20190415155452.5115-3-kwolf@redhat.com>
In-Reply-To: <20190415155452.5115-1-kwolf@redhat.com>
References: <20190415155452.5115-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0? 2/4] qcow2: Fix preallocation
 bdrv_pwrite to wrong file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

With an external data file, preallocate_co() must write the final byte
to the external data file, not to the qcow2 image file.

This is harmless for preallocation of newly created images (only the
qcow2 file size is increased to the virtual disk size while it should be
much smaller), but with preallocated resize, it could in theory cause
visible corruption if the metadata of the image is larger than the data
(e.g. lots of bitmaps).

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c8400e9712..dfac74c264 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2772,7 +2772,7 @@ static int coroutine_fn preallocate_co(BlockDriverS=
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
