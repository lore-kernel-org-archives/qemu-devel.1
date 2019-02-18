Received: from eggs.gnu.org ([209.51.188.92]:59651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gvjXz-00019P-1A
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gvjXy-00055N-0X
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:05:26 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 18 Feb 2019 15:02:56 +0100
Message-Id: <20190218140301.197408-6-sgarzare@redhat.com>
In-Reply-To: <20190218140301.197408-1-sgarzare@redhat.com>
References: <20190218140301.197408-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 05/10] virtio-blk: set config size depending
 on the features enabled
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

Starting from DISABLE and WRITE_ZEROES features, we use an array of
VirtIOFeature (as virtio-net) to properly set the config size
depending on the features enabled.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/block/virtio-blk.c          | 31 +++++++++++++++++++++++++------
 include/hw/virtio/virtio-blk.h |  1 +
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index f7cd322811..8798d13bc4 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -28,9 +28,28 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
=20
-/* We don't support discard yet, hide associated config fields. */
+/* Config size before the discard support (hide associated config fields=
) */
 #define VIRTIO_BLK_CFG_SIZE offsetof(struct virtio_blk_config, \
                                      max_discard_sectors)
+/*
+ * Starting from the discard feature, we can use this array to properly
+ * set the config size depending on the features enabled.
+ */
+static VirtIOFeature feature_sizes[] =3D {
+    {.flags =3D 1ULL << VIRTIO_BLK_F_DISCARD,
+     .end =3D virtio_endof(struct virtio_blk_config, discard_sector_alig=
nment)},
+    {.flags =3D 1ULL << VIRTIO_BLK_F_WRITE_ZEROES,
+     .end =3D virtio_endof(struct virtio_blk_config, write_zeroes_may_un=
map)},
+    {}
+};
+
+static void virtio_blk_set_config_size(VirtIOBlock *s, uint64_t host_fea=
tures)
+{
+    s->config_size =3D MAX(VIRTIO_BLK_CFG_SIZE,
+        virtio_feature_get_config_size(feature_sizes, host_features));
+
+    assert(s->config_size <=3D sizeof(struct virtio_blk_config));
+}
=20
 static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
                                     VirtIOBlockReq *req)
@@ -763,8 +782,7 @@ static void virtio_blk_update_config(VirtIODevice *vd=
ev, uint8_t *config)
     blkcfg.alignment_offset =3D 0;
     blkcfg.wce =3D blk_enable_write_cache(s->blk);
     virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
-    memcpy(config, &blkcfg, VIRTIO_BLK_CFG_SIZE);
-    QEMU_BUILD_BUG_ON(VIRTIO_BLK_CFG_SIZE > sizeof(blkcfg));
+    memcpy(config, &blkcfg, s->config_size);
 }
=20
 static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *con=
fig)
@@ -772,8 +790,7 @@ static void virtio_blk_set_config(VirtIODevice *vdev,=
 const uint8_t *config)
     VirtIOBlock *s =3D VIRTIO_BLK(vdev);
     struct virtio_blk_config blkcfg;
=20
-    memcpy(&blkcfg, config, VIRTIO_BLK_CFG_SIZE);
-    QEMU_BUILD_BUG_ON(VIRTIO_BLK_CFG_SIZE > sizeof(blkcfg));
+    memcpy(&blkcfg, config, s->config_size);
=20
     aio_context_acquire(blk_get_aio_context(s->blk));
     blk_set_enable_write_cache(s->blk, blkcfg.wce !=3D 0);
@@ -956,7 +973,9 @@ static void virtio_blk_device_realize(DeviceState *de=
v, Error **errp)
         return;
     }
=20
-    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK, VIRTIO_BLK_CFG_SIZE=
);
+    virtio_blk_set_config_size(s, s->host_features);
+
+    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK, s->config_size);
=20
     s->blk =3D conf->conf.blk;
     s->rq =3D NULL;
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-bl=
k.h
index f7345b0511..7877ae67ae 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -56,6 +56,7 @@ typedef struct VirtIOBlock {
     bool dataplane_started;
     struct VirtIOBlockDataPlane *dataplane;
     uint64_t host_features;
+    size_t config_size;
 } VirtIOBlock;
=20
 typedef struct VirtIOBlockReq {
--=20
2.20.1
