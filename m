Received: from eggs.gnu.org ([209.51.188.92]:34681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmijB-0004pM-Nw
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmij9-0000oD-DP
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:23:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gmij9-0000hx-2z
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:23:43 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 24 Jan 2019 18:23:22 +0100
Message-Id: <20190124172323.230296-2-sgarzare@redhat.com>
In-Reply-To: <20190124172323.230296-1-sgarzare@redhat.com>
References: <20190124172323.230296-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC 1/2] virtio-blk: add DISCARD and WRITE
 ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This patch adds the support of DISCARD and WRITE ZEROES commands,
that have been introduced in the virtio-blk protocol to have
better performance when using SSD backend.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/block/virtio-blk.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index f208c6ddb9..8850957751 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -145,6 +145,25 @@ out:
     aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
=20
+static void virtio_blk_discard_wzeroes_complete(void *opaque, int ret)
+{
+    VirtIOBlockReq *req =3D opaque;
+    VirtIOBlock *s =3D req->dev;
+
+    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
+    if (ret) {
+        if (virtio_blk_handle_rw_error(req, -ret, 0)) {
+            goto out;
+        }
+    }
+
+    virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
+    virtio_blk_free_request(req);
+
+out:
+    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
+}
+
 #ifdef __linux__
=20
 typedef struct {
@@ -584,6 +603,56 @@ static int virtio_blk_handle_request(VirtIOBlockReq =
*req, MultiReqBuffer *mrb)
         virtio_blk_free_request(req);
         break;
     }
+    /*
+     * VIRTIO_BLK_T_DISCARD and VIRTIO_BLK_T_WRITE_ZEROES are defined wi=
th
+     * VIRTIO_BLK_T_OUT flag set. We masked this flag in the switch stat=
ement,
+     * so we must mask it for these requests, then we will check the typ=
e.
+     */
+    case VIRTIO_BLK_T_DISCARD & ~VIRTIO_BLK_T_OUT:
+    case VIRTIO_BLK_T_WRITE_ZEROES & ~VIRTIO_BLK_T_OUT:
+    {
+        struct virtio_blk_discard_write_zeroes dwz_hdr;
+        uint64_t sector;
+        int bytes;
+
+        if (unlikely(iov_to_buf(out_iov, out_num, 0, &dwz_hdr,
+                                sizeof(dwz_hdr)) !=3D sizeof(dwz_hdr))) =
{
+            virtio_error(vdev, "virtio-blk discard/wzeroes header too sh=
ort");
+            return -1;
+        }
+
+        sector =3D virtio_ldq_p(VIRTIO_DEVICE(req->dev), &dwz_hdr.sector=
);
+        bytes =3D virtio_ldl_p(VIRTIO_DEVICE(req->dev),
+                             &dwz_hdr.num_sectors) << BDRV_SECTOR_BITS;
+
+        if (!virtio_blk_sect_range_ok(req->dev, sector, bytes)) {
+            virtio_blk_req_complete(req, VIRTIO_BLK_S_IOERR);
+            virtio_blk_free_request(req);
+            return 0;
+        }
+
+        if ((type & ~(VIRTIO_BLK_T_BARRIER)) =3D=3D VIRTIO_BLK_T_DISCARD=
) {
+            blk_aio_pdiscard(req->dev->blk, sector << BDRV_SECTOR_BITS, =
bytes,
+                             virtio_blk_discard_wzeroes_complete, req);
+        } else if ((type & ~(VIRTIO_BLK_T_BARRIER)) =3D=3D
+                   VIRTIO_BLK_T_WRITE_ZEROES) {
+            int flags =3D 0;
+
+            if (virtio_ldl_p(VIRTIO_DEVICE(req->dev), &dwz_hdr.flags) &
+                VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP) {
+                flags |=3D BDRV_REQ_MAY_UNMAP;
+            }
+
+            blk_aio_pwrite_zeroes(req->dev->blk, sector << BDRV_SECTOR_B=
ITS,
+                                  bytes, flags,
+                                  virtio_blk_discard_wzeroes_complete, r=
eq);
+        } else { /* Unsupported if VIRTIO_BLK_T_OUT is not set */
+            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
+            virtio_blk_free_request(req);
+        }
+
+        break;
+    }
     default:
         virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
         virtio_blk_free_request(req);
@@ -763,6 +832,14 @@ static void virtio_blk_update_config(VirtIODevice *v=
dev, uint8_t *config)
     blkcfg.alignment_offset =3D 0;
     blkcfg.wce =3D blk_enable_write_cache(s->blk);
     virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
+    virtio_stl_p(vdev, &blkcfg.max_discard_sectors, BDRV_REQUEST_MAX_SEC=
TORS);
+    virtio_stl_p(vdev, &blkcfg.max_discard_seg, 1);
+    virtio_stl_p(vdev, &blkcfg.discard_sector_alignment,
+                 blk_size >> BDRV_SECTOR_BITS);
+    virtio_stl_p(vdev, &blkcfg.max_write_zeroes_sectors,
+                 BDRV_REQUEST_MAX_SECTORS);
+    virtio_stl_p(vdev, &blkcfg.max_write_zeroes_seg, 1);
+    blkcfg.write_zeroes_may_unmap =3D 1;
     memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
 }
=20
@@ -787,6 +864,8 @@ static uint64_t virtio_blk_get_features(VirtIODevice =
*vdev, uint64_t features,
     virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
     virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
+    virtio_add_feature(&features, VIRTIO_BLK_F_DISCARD);
+    virtio_add_feature(&features, VIRTIO_BLK_F_WRITE_ZEROES);
     if (virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
         if (s->conf.scsi) {
             error_setg(errp, "Please set scsi=3Doff for virtio-blk devic=
es in order to use virtio 1.0");
--=20
2.20.1
