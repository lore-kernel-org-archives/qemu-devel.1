Received: from eggs.gnu.org ([209.51.188.92]:60174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2IlE-0003Uw-8s
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2IlA-00060x-IW
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:54:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  8 Mar 2019 16:53:39 +0000
Message-Id: <20190308165344.10685-3-stefanha@redhat.com>
In-Reply-To: <20190308165344.10685-1-stefanha@redhat.com>
References: <20190308165344.10685-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] hw/block/virtio-blk: Clean req->dev
 repetitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Anastasiia Rusakova <arusakova917@gmail.com>

From: Anastasiia Rusakova <arusakova917@gmail.com>

Some functions sometimes uses req->dev even though a local variable
VirtIOBlock* s =3D req->dev has already been defined.
Updated places to use s everywhere in the file.

Signed-off-by: Anastasiia Rusakova <arusakova917@gmail.com>
Message-id: 20190307161925.4158-1-rusakova.nastasia@icloud.com
Message-Id: <20190307161925.4158-1-rusakova.nastasia@icloud.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 0cc3c590b9..06e57a4d39 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -127,7 +127,7 @@ static void virtio_blk_rw_complete(void *opaque, int =
ret)
         }
=20
         if (ret) {
-            int p =3D virtio_ldl_p(VIRTIO_DEVICE(req->dev), &req->out.ty=
pe);
+            int p =3D virtio_ldl_p(VIRTIO_DEVICE(s), &req->out.type);
             bool is_read =3D !(p & VIRTIO_BLK_T_OUT);
             /* Note that memory may be dirtied on read failure.  If the
              * virtio request is not completed here, as is the case for
@@ -143,7 +143,7 @@ static void virtio_blk_rw_complete(void *opaque, int =
ret)
         }
=20
         virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
-        block_acct_done(blk_get_stats(req->dev->blk), &req->acct);
+        block_acct_done(blk_get_stats(s->blk), &req->acct);
         virtio_blk_free_request(req);
     }
     aio_context_release(blk_get_aio_context(s->conf.conf.blk));
@@ -260,9 +260,9 @@ static int virtio_blk_handle_scsi_req(VirtIOBlockReq =
*req)
 {
     int status =3D VIRTIO_BLK_S_OK;
     struct virtio_scsi_inhdr *scsi =3D NULL;
-    VirtIODevice *vdev =3D VIRTIO_DEVICE(req->dev);
-    VirtQueueElement *elem =3D &req->elem;
     VirtIOBlock *blk =3D req->dev;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(blk);
+    VirtQueueElement *elem =3D &req->elem;
=20
 #ifdef __linux__
     int i;
@@ -492,16 +492,18 @@ static void virtio_blk_submit_multireq(BlockBackend=
 *blk, MultiReqBuffer *mrb)
=20
 static void virtio_blk_handle_flush(VirtIOBlockReq *req, MultiReqBuffer =
*mrb)
 {
-    block_acct_start(blk_get_stats(req->dev->blk), &req->acct, 0,
+    VirtIOBlock *s =3D req->dev;
+
+    block_acct_start(blk_get_stats(s->blk), &req->acct, 0,
                      BLOCK_ACCT_FLUSH);
=20
     /*
      * Make sure all outstanding writes are posted to the backing device=
.
      */
     if (mrb->is_write && mrb->num_reqs > 0) {
-        virtio_blk_submit_multireq(req->dev->blk, mrb);
+        virtio_blk_submit_multireq(s->blk, mrb);
     }
-    blk_aio_flush(req->dev->blk, virtio_blk_flush_complete, req);
+    blk_aio_flush(s->blk, virtio_blk_flush_complete, req);
 }
=20
 static bool virtio_blk_sect_range_ok(VirtIOBlock *dev,
--=20
2.20.1
