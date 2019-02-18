Received: from eggs.gnu.org ([209.51.188.92]:59832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gvjYY-0001cB-A5
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gvjYV-0005KH-UI
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:02 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 18 Feb 2019 15:02:57 +0100
Message-Id: <20190218140301.197408-7-sgarzare@redhat.com>
In-Reply-To: <20190218140301.197408-1-sgarzare@redhat.com>
References: <20190218140301.197408-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 06/10] virtio-blk: add DISCARD and
 WRITE_ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>

This patch adds the support of DISCARD and WRITE_ZEROES commands,
that have been introduced in the virtio-blk protocol to have
better performance when using SSD backend.

We support only one segment per request since multiple segments
are not widely used and there are no userspace APIs that allow
applications to submit multiple segments in a single call.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/block/virtio-blk.c          | 184 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-blk.h |   2 +
 2 files changed, 186 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 8798d13bc4..c159a3d5f7 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -169,6 +169,30 @@ out:
     aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
=20
+static void virtio_blk_discard_write_zeroes_complete(void *opaque, int r=
et)
+{
+    VirtIOBlockReq *req =3D opaque;
+    VirtIOBlock *s =3D req->dev;
+    bool is_write_zeroes =3D (virtio_ldl_p(VIRTIO_DEVICE(s), &req->out.t=
ype) &
+                            ~VIRTIO_BLK_T_BARRIER) =3D=3D VIRTIO_BLK_T_W=
RITE_ZEROES;
+
+    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
+    if (ret) {
+        if (virtio_blk_handle_rw_error(req, -ret, false, is_write_zeroes=
)) {
+            goto out;
+        }
+    }
+
+    virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
+    if (is_write_zeroes) {
+        block_acct_done(blk_get_stats(s->blk), &req->acct);
+    }
+    virtio_blk_free_request(req);
+
+out:
+    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
+}
+
 #ifdef __linux__
=20
 typedef struct {
@@ -502,6 +526,84 @@ static bool virtio_blk_sect_range_ok(VirtIOBlock *de=
v,
     return true;
 }
=20
+static uint8_t virtio_blk_handle_discard_write_zeroes(VirtIOBlockReq *re=
q,
+    struct virtio_blk_discard_write_zeroes *dwz_hdr, bool is_write_zeroe=
s)
+{
+    VirtIOBlock *s =3D req->dev;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
+    uint64_t sector;
+    uint32_t num_sectors, flags, max_sectors;
+    uint8_t err_status;
+    int bytes;
+
+    sector =3D virtio_ldq_p(vdev, &dwz_hdr->sector);
+    num_sectors =3D virtio_ldl_p(vdev, &dwz_hdr->num_sectors);
+    flags =3D virtio_ldl_p(vdev, &dwz_hdr->flags);
+    max_sectors =3D is_write_zeroes ? s->conf.max_write_zeroes_sectors :
+                  s->conf.max_discard_sectors;
+
+    /*
+     * max_sectors is at most BDRV_REQUEST_MAX_SECTORS, this check
+     * make us sure that "num_sectors << BDRV_SECTOR_BITS" can fit in
+     * the integer variable.
+     */
+    if (unlikely(num_sectors > max_sectors)) {
+        err_status =3D VIRTIO_BLK_S_IOERR;
+        goto err;
+    }
+
+    bytes =3D num_sectors << BDRV_SECTOR_BITS;
+
+    if (unlikely(!virtio_blk_sect_range_ok(s, sector, bytes))) {
+        err_status =3D VIRTIO_BLK_S_IOERR;
+        goto err;
+    }
+
+    /*
+     * The device MUST set the status byte to VIRTIO_BLK_S_UNSUPP for di=
scard
+     * and write zeroes commands if any unknown flag is set.
+     */
+    if (unlikely(flags & ~VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP)) {
+        err_status =3D VIRTIO_BLK_S_UNSUPP;
+        goto err;
+    }
+
+    if (is_write_zeroes) { /* VIRTIO_BLK_T_WRITE_ZEROES */
+        int blk_aio_flags =3D 0;
+
+        if (flags & VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP) {
+            blk_aio_flags |=3D BDRV_REQ_MAY_UNMAP;
+        }
+
+        block_acct_start(blk_get_stats(s->blk), &req->acct, bytes,
+                         BLOCK_ACCT_WRITE);
+
+        blk_aio_pwrite_zeroes(s->blk, sector << BDRV_SECTOR_BITS,
+                              bytes, blk_aio_flags,
+                              virtio_blk_discard_write_zeroes_complete, =
req);
+    } else { /* VIRTIO_BLK_T_DISCARD */
+        /*
+         * The device MUST set the status byte to VIRTIO_BLK_S_UNSUPP fo=
r
+         * discard commands if the unmap flag is set.
+         */
+        if (unlikely(flags & VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP)) {
+            err_status =3D VIRTIO_BLK_S_UNSUPP;
+            goto err;
+        }
+
+        blk_aio_pdiscard(s->blk, sector << BDRV_SECTOR_BITS, bytes,
+                         virtio_blk_discard_write_zeroes_complete, req);
+    }
+
+    return VIRTIO_BLK_S_OK;
+
+err:
+    if (is_write_zeroes) {
+        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
+    }
+    return err_status;
+}
+
 static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer=
 *mrb)
 {
     uint32_t type;
@@ -603,6 +705,47 @@ static int virtio_blk_handle_request(VirtIOBlockReq =
*req, MultiReqBuffer *mrb)
         virtio_blk_free_request(req);
         break;
     }
+    /*
+     * VIRTIO_BLK_T_DISCARD and VIRTIO_BLK_T_WRITE_ZEROES are defined wi=
th
+     * VIRTIO_BLK_T_OUT flag set. We masked this flag in the switch stat=
ement,
+     * so we must mask it for these requests, then we will check if it i=
s set.
+     */
+    case VIRTIO_BLK_T_DISCARD & ~VIRTIO_BLK_T_OUT:
+    case VIRTIO_BLK_T_WRITE_ZEROES & ~VIRTIO_BLK_T_OUT:
+    {
+        struct virtio_blk_discard_write_zeroes dwz_hdr;
+        size_t out_len =3D iov_size(out_iov, out_num);
+        bool is_write_zeroes =3D (type & ~VIRTIO_BLK_T_BARRIER) =3D=3D
+                               VIRTIO_BLK_T_WRITE_ZEROES;
+        uint8_t err_status;
+
+        /*
+         * Unsupported if VIRTIO_BLK_T_OUT is not set or the request con=
tains
+         * more than one segment.
+         */
+        if (unlikely(!(type & VIRTIO_BLK_T_OUT) ||
+                     out_len > sizeof(dwz_hdr))) {
+            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
+            virtio_blk_free_request(req);
+            return 0;
+        }
+
+        if (unlikely(iov_to_buf(out_iov, out_num, 0, &dwz_hdr,
+                                sizeof(dwz_hdr)) !=3D sizeof(dwz_hdr))) =
{
+            virtio_error(vdev, "virtio-blk discard/write_zeroes header"
+                         " too short");
+            return -1;
+        }
+
+        err_status =3D virtio_blk_handle_discard_write_zeroes(req, &dwz_=
hdr,
+                                                            is_write_zer=
oes);
+        if (err_status !=3D VIRTIO_BLK_S_OK) {
+            virtio_blk_req_complete(req, err_status);
+            virtio_blk_free_request(req);
+        }
+
+        break;
+    }
     default:
         virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
         virtio_blk_free_request(req);
@@ -782,6 +925,24 @@ static void virtio_blk_update_config(VirtIODevice *v=
dev, uint8_t *config)
     blkcfg.alignment_offset =3D 0;
     blkcfg.wce =3D blk_enable_write_cache(s->blk);
     virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
+    if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_DISCARD)) {
+        virtio_stl_p(vdev, &blkcfg.max_discard_sectors,
+                     s->conf.max_discard_sectors);
+        virtio_stl_p(vdev, &blkcfg.discard_sector_alignment,
+                     blk_size >> BDRV_SECTOR_BITS);
+        /*
+         * We support only one segment per request since multiple segmen=
ts
+         * are not widely used and there are no userspace APIs that allo=
w
+         * applications to submit multiple segments in a single call.
+         */
+        virtio_stl_p(vdev, &blkcfg.max_discard_seg, 1);
+    }
+    if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_WRITE_ZEROES))=
 {
+        virtio_stl_p(vdev, &blkcfg.max_write_zeroes_sectors,
+                     s->conf.max_write_zeroes_sectors);
+        blkcfg.write_zeroes_may_unmap =3D 1;
+        virtio_stl_p(vdev, &blkcfg.max_write_zeroes_seg, 1);
+    }
     memcpy(config, &blkcfg, s->config_size);
 }
=20
@@ -973,6 +1134,25 @@ static void virtio_blk_device_realize(DeviceState *=
dev, Error **errp)
         return;
     }
=20
+    if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_DISCARD) &&
+        (!conf->max_discard_sectors ||
+         conf->max_discard_sectors > BDRV_REQUEST_MAX_SECTORS)) {
+        error_setg(errp, "invalid max-discard-sectors property (%" PRIu3=
2 ")"
+                   ", must be between 1 and %d",
+                   conf->max_discard_sectors, (int)BDRV_REQUEST_MAX_SECT=
ORS);
+        return;
+    }
+
+    if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_WRITE_ZEROES) =
&&
+        (!conf->max_write_zeroes_sectors ||
+         conf->max_write_zeroes_sectors > BDRV_REQUEST_MAX_SECTORS)) {
+        error_setg(errp, "invalid max-write-zeroes-sectors property (%" =
PRIu32
+                   "), must be between 1 and %d",
+                   conf->max_write_zeroes_sectors,
+                   (int)BDRV_REQUEST_MAX_SECTORS);
+        return;
+    }
+
     virtio_blk_set_config_size(s, s->host_features);
=20
     virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK, s->config_size);
@@ -1050,6 +1230,10 @@ static Property virtio_blk_properties[] =3D {
                       VIRTIO_BLK_F_DISCARD, true),
     DEFINE_PROP_BIT64("write-zeroes", VirtIOBlock, host_features,
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
+    DEFINE_PROP_UINT32("max-discard-sectors", VirtIOBlock,
+                       conf.max_discard_sectors, BDRV_REQUEST_MAX_SECTOR=
S),
+    DEFINE_PROP_UINT32("max-write-zeroes-sectors", VirtIOBlock,
+                       conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_S=
ECTORS),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-bl=
k.h
index 7877ae67ae..cddcfbebe9 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -38,6 +38,8 @@ struct VirtIOBlkConf
     uint32_t request_merging;
     uint16_t num_queues;
     uint16_t queue_size;
+    uint32_t max_discard_sectors;
+    uint32_t max_write_zeroes_sectors;
 };
=20
 struct VirtIOBlockDataPlane;
--=20
2.20.1
