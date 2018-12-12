Received: from eggs.gnu.org ([2001:4830:134:3::10]:42969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1Cl-0004Cu-6S
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1Ck-0003t1-3G
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:53:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 12 Dec 2018 09:52:51 +0000
Message-Id: <20181212095252.20349-2-stefanha@redhat.com>
In-Reply-To: <20181212095252.20349-1-stefanha@redhat.com>
References: <20181212095252.20349-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] virtio-blk: rename iov to out_iov in
 virtio_blk_handle_request()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Dongli Zhang <dongli.zhang@oracle.com>

From: Dongli Zhang <dongli.zhang@oracle.com>

In virtio_blk_handle_request(), in_iov is used for input header while iov
is used for output header. Rename iov to out_iov to pair output header's
name with in_iov to avoid confusing people when reading source code.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Message-id: 1541520556-8334-1-git-send-email-dongli.zhang@oracle.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 83cf5c01f9..fb0d74da07 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -482,7 +482,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *=
req, MultiReqBuffer *mrb)
 {
     uint32_t type;
     struct iovec *in_iov =3D req->elem.in_sg;
-    struct iovec *iov =3D req->elem.out_sg;
+    struct iovec *out_iov =3D req->elem.out_sg;
     unsigned in_num =3D req->elem.in_num;
     unsigned out_num =3D req->elem.out_num;
     VirtIOBlock *s =3D req->dev;
@@ -493,13 +493,13 @@ static int virtio_blk_handle_request(VirtIOBlockReq=
 *req, MultiReqBuffer *mrb)
         return -1;
     }
=20
-    if (unlikely(iov_to_buf(iov, out_num, 0, &req->out,
+    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req->out,
                             sizeof(req->out)) !=3D sizeof(req->out))) {
         virtio_error(vdev, "virtio-blk request outhdr too short");
         return -1;
     }
=20
-    iov_discard_front(&iov, &out_num, sizeof(req->out));
+    iov_discard_front(&out_iov, &out_num, sizeof(req->out));
=20
     if (in_iov[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
         virtio_error(vdev, "virtio-blk request inhdr too short");
@@ -526,7 +526,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *=
req, MultiReqBuffer *mrb)
                                        &req->out.sector);
=20
         if (is_write) {
-            qemu_iovec_init_external(&req->qiov, iov, out_num);
+            qemu_iovec_init_external(&req->qiov, out_iov, out_num);
             trace_virtio_blk_handle_write(vdev, req, req->sector_num,
                                           req->qiov.size / BDRV_SECTOR_S=
IZE);
         } else {
--=20
2.19.2
