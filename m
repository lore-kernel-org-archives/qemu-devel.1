Received: from eggs.gnu.org ([209.51.188.92]:43471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu8iu-0005p8-FS
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu8iq-0003bz-OS
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:34:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 14 Feb 2019 12:33:22 +0800
Message-Id: <20190214043322.2354-2-stefanha@redhat.com>
In-Reply-To: <20190214043322.2354-1-stefanha@redhat.com>
References: <20190214043322.2354-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] virtio-blk: set correct config size for the
 host driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>

From: Changpeng Liu <changpeng.liu@intel.com>

Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features
support" added fields to struct virtio_blk_config. This changes
the size of the config space and breaks migration from QEMU 3.1
and older:

qemu-system-ppc64: get_pci_config_device: Bad config data: i=3D0x10 read:=
 41 device: 1 cmask: ff wmask: 80 w1cmask:0
qemu-system-ppc64: Failed to load PCIDevice:config
qemu-system-ppc64: Failed to load virtio-blk:virtio
qemu-system-ppc64: error while loading state for instance 0x0 of device '=
pci@800000020000000:01.0/virtio-blk'
qemu-system-ppc64: load of migration failed: Invalid argument

Since virtio-blk doesn't support the "discard" and "write zeroes"
features, it shouldn't even expose the associated fields in the
config space actually. Just include all fields up to num_queues to
match QEMU 3.1 and older.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 1550022537-27565-1-git-send-email-changpeng.liu@intel.com
Message-Id: <1550022537-27565-1-git-send-email-changpeng.liu@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 843bb2bec8..cf7f47eaba 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -28,6 +28,10 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
=20
+/* We don't support discard yet, hide associated config fields. */
+#define VIRTIO_BLK_CFG_SIZE offsetof(struct virtio_blk_config, \
+                                     max_discard_sectors)
+
 static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
                                     VirtIOBlockReq *req)
 {
@@ -757,7 +761,8 @@ static void virtio_blk_update_config(VirtIODevice *vd=
ev, uint8_t *config)
     blkcfg.alignment_offset =3D 0;
     blkcfg.wce =3D blk_enable_write_cache(s->blk);
     virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
-    memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
+    memcpy(config, &blkcfg, VIRTIO_BLK_CFG_SIZE);
+    QEMU_BUILD_BUG_ON(VIRTIO_BLK_CFG_SIZE > sizeof(blkcfg));
 }
=20
 static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *con=
fig)
@@ -765,7 +770,8 @@ static void virtio_blk_set_config(VirtIODevice *vdev,=
 const uint8_t *config)
     VirtIOBlock *s =3D VIRTIO_BLK(vdev);
     struct virtio_blk_config blkcfg;
=20
-    memcpy(&blkcfg, config, sizeof(blkcfg));
+    memcpy(&blkcfg, config, VIRTIO_BLK_CFG_SIZE);
+    QEMU_BUILD_BUG_ON(VIRTIO_BLK_CFG_SIZE > sizeof(blkcfg));
=20
     aio_context_acquire(blk_get_aio_context(s->blk));
     blk_set_enable_write_cache(s->blk, blkcfg.wce !=3D 0);
@@ -948,8 +954,7 @@ static void virtio_blk_device_realize(DeviceState *de=
v, Error **errp)
         return;
     }
=20
-    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
-                sizeof(struct virtio_blk_config));
+    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK, VIRTIO_BLK_CFG_SIZE=
);
=20
     s->blk =3D conf->conf.blk;
     s->rq =3D NULL;
--=20
2.20.1
