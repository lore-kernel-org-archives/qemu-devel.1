Received: from eggs.gnu.org ([209.51.188.92]:38211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVg-0002lo-Sh
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVf-0002N1-Q3
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:09:04 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:51 +0000
Message-Id: <20190222140756.29834-23-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/27] virtio-blk: set config size depending on
 the features enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Stefano Garzarella <sgarzare@redhat.com>

Starting from DISABLE and WRITE_ZEROES features, we use an array of
VirtIOFeature (as virtio-net) to properly set the config size
depending on the features enabled.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20190221103314.58500-6-sgarzare@redhat.com
Message-Id: <20190221103314.58500-6-sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio-blk.h |  1 +
 hw/block/virtio-blk.c          | 31 +++++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

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
--=20
2.20.1
