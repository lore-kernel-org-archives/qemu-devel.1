Received: from eggs.gnu.org ([209.51.188.92]:53811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtYoB-0007Um-D4
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtYo9-0005jd-23
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:13:11 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 12 Feb 2019 22:12:30 +0800
Message-Id: <20190212141234.2814-3-stefanha@redhat.com>
In-Reply-To: <20190212141234.2814-1-stefanha@redhat.com>
References: <20190212141234.2814-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PULL 2/6] virtio-blk: add host_features field in
 VirtIOBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: sgarzare@redhat.com, qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Pankaj Gupta <pagupta@redhat.com>

From: Stefano Garzarella <sgarzare@redhat.com>

Since configurable features for virtio-blk are growing, this patch
adds host_features field in the struct VirtIOBlock. (as in virtio-net)
In this way, we can avoid to add new fields for new properties and
we can directly set VIRTIO_BLK_F* flags in the host_features.

We update "config-wce" and "scsi" property definition to use the new
host_features field without change the behaviour.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Pankaj Gupta <pagupta@redhat.com>
Message-id: 20190208134950.187665-3-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio-blk.h |  3 +--
 hw/block/virtio-blk.c          | 16 +++++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-bl=
k.h
index 5117431d96..f7345b0511 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -35,8 +35,6 @@ struct VirtIOBlkConf
     BlockConf conf;
     IOThread *iothread;
     char *serial;
-    uint32_t scsi;
-    uint32_t config_wce;
     uint32_t request_merging;
     uint16_t num_queues;
     uint16_t queue_size;
@@ -57,6 +55,7 @@ typedef struct VirtIOBlock {
     bool dataplane_disabled;
     bool dataplane_started;
     struct VirtIOBlockDataPlane *dataplane;
+    uint64_t host_features;
 } VirtIOBlock;
=20
 typedef struct VirtIOBlockReq {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b2bb129efa..938273c63c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -242,7 +242,7 @@ static int virtio_blk_handle_scsi_req(VirtIOBlockReq =
*req)
      */
     scsi =3D (void *)elem->in_sg[elem->in_num - 2].iov_base;
=20
-    if (!blk->conf.scsi) {
+    if (!virtio_has_feature(blk->host_features, VIRTIO_BLK_F_SCSI)) {
         status =3D VIRTIO_BLK_S_UNSUPP;
         goto fail;
     }
@@ -783,12 +783,15 @@ static uint64_t virtio_blk_get_features(VirtIODevic=
e *vdev, uint64_t features,
 {
     VirtIOBlock *s =3D VIRTIO_BLK(vdev);
=20
+    /* Firstly sync all virtio-blk possible supported features */
+    features |=3D s->host_features;
+
     virtio_add_feature(&features, VIRTIO_BLK_F_SEG_MAX);
     virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
     virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
     if (virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
-        if (s->conf.scsi) {
+        if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_SCSI)) {
             error_setg(errp, "Please set scsi=3Doff for virtio-blk devic=
es in order to use virtio 1.0");
             return 0;
         }
@@ -797,9 +800,6 @@ static uint64_t virtio_blk_get_features(VirtIODevice =
*vdev, uint64_t features,
         virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
     }
=20
-    if (s->conf.config_wce) {
-        virtio_add_feature(&features, VIRTIO_BLK_F_CONFIG_WCE);
-    }
     if (blk_enable_write_cache(s->blk)) {
         virtio_add_feature(&features, VIRTIO_BLK_F_WCE);
     }
@@ -1014,9 +1014,11 @@ static Property virtio_blk_properties[] =3D {
     DEFINE_BLOCK_ERROR_PROPERTIES(VirtIOBlock, conf.conf),
     DEFINE_BLOCK_CHS_PROPERTIES(VirtIOBlock, conf.conf),
     DEFINE_PROP_STRING("serial", VirtIOBlock, conf.serial),
-    DEFINE_PROP_BIT("config-wce", VirtIOBlock, conf.config_wce, 0, true)=
,
+    DEFINE_PROP_BIT64("config-wce", VirtIOBlock, host_features,
+                      VIRTIO_BLK_F_CONFIG_WCE, true),
 #ifdef __linux__
-    DEFINE_PROP_BIT("scsi", VirtIOBlock, conf.scsi, 0, false),
+    DEFINE_PROP_BIT64("scsi", VirtIOBlock, host_features,
+                      VIRTIO_BLK_F_SCSI, false),
 #endif
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging=
, 0,
                     true),
--=20
2.20.1
