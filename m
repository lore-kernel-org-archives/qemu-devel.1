Received: from eggs.gnu.org ([209.51.188.92]:43630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmxq-00047p-57
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmxi-00031o-Vs
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:55:50 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  7 Feb 2019 17:54:39 +0100
Message-Id: <20190207165449.6125-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190207165449.6125-1-marcandre.lureau@redhat.com>
References: <20190207165449.6125-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/12] vhost-user: simplify
 vhost_user_init/vhost_user_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Take a VhostUserState* that can be pre-allocated, and initialize it
with the associated chardev.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Tiwei Bie <tiwei.bie@intel.com>
---
 include/hw/virtio/vhost-user-blk.h  |  2 +-
 include/hw/virtio/vhost-user-scsi.h |  2 +-
 include/hw/virtio/vhost-user.h      |  2 +-
 backends/cryptodev-vhost-user.c     | 18 ++++--------------
 hw/block/vhost-user-blk.c           | 22 ++++------------------
 hw/scsi/vhost-user-scsi.c           | 20 ++++----------------
 hw/virtio/vhost-stub.c              |  4 ++--
 hw/virtio/vhost-user.c              | 16 ++++++++++++----
 net/vhost-user.c                    | 13 ++++---------
 9 files changed, 33 insertions(+), 66 deletions(-)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
index d52944aeeb..a8a106eecb 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -36,7 +36,7 @@ typedef struct VHostUserBlk {
     uint32_t queue_size;
     uint32_t config_wce;
     struct vhost_dev dev;
-    VhostUserState *vhost_user;
+    VhostUserState vhost_user;
 } VHostUserBlk;
=20
 #endif
diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhos=
t-user-scsi.h
index e429cacd8e..738f9288bd 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -30,7 +30,7 @@
=20
 typedef struct VHostUserSCSI {
     VHostSCSICommon parent_obj;
-    VhostUserState *vhost_user;
+    VhostUserState vhost_user;
 } VHostUserSCSI;
=20
 #endif /* VHOST_USER_SCSI_H */
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
index fd660393a0..811e325f42 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -22,7 +22,7 @@ typedef struct VhostUserState {
     VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
 } VhostUserState;
=20
-VhostUserState *vhost_user_init(void);
+bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **err=
p);
 void vhost_user_cleanup(VhostUserState *user);
=20
 #endif
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-u=
ser.c
index d539f14d59..1052a5d0e9 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -47,7 +47,7 @@
 typedef struct CryptoDevBackendVhostUser {
     CryptoDevBackend parent_obj;
=20
-    VhostUserState *vhost_user;
+    VhostUserState vhost_user;
     CharBackend chr;
     char *chr_name;
     bool opened;
@@ -104,7 +104,7 @@ cryptodev_vhost_user_start(int queues,
             continue;
         }
=20
-        options.opaque =3D s->vhost_user;
+        options.opaque =3D &s->vhost_user;
         options.backend_type =3D VHOST_BACKEND_TYPE_USER;
         options.cc =3D b->conf.peers.ccs[i];
         s->vhost_crypto[i] =3D cryptodev_vhost_init(&options);
@@ -182,7 +182,6 @@ static void cryptodev_vhost_user_init(
     size_t i;
     Error *local_err =3D NULL;
     Chardev *chr;
-    VhostUserState *user;
     CryptoDevBackendClient *cc;
     CryptoDevBackendVhostUser *s =3D
                       CRYPTODEV_BACKEND_VHOST_USER(backend);
@@ -213,15 +212,10 @@ static void cryptodev_vhost_user_init(
         }
     }
=20
-    user =3D vhost_user_init();
-    if (!user) {
-        error_setg(errp, "Failed to init vhost_user");
+    if (!vhost_user_init(&s->vhost_user, &s->chr, errp)) {
         return;
     }
=20
-    user->chr =3D &s->chr;
-    s->vhost_user =3D user;
-
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
                      cryptodev_vhost_user_event, NULL, s, NULL, true);
=20
@@ -307,11 +301,7 @@ static void cryptodev_vhost_user_cleanup(
         }
     }
=20
-    if (s->vhost_user) {
-        vhost_user_cleanup(s->vhost_user);
-        g_free(s->vhost_user);
-        s->vhost_user =3D NULL;
-    }
+    vhost_user_cleanup(&s->vhost_user);
 }
=20
 static void cryptodev_vhost_user_set_chardev(Object *obj,
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 44ac814016..767c734a81 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -253,7 +253,6 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
-    VhostUserState *user;
     struct vhost_virtqueue *vqs =3D NULL;
     int i, ret;
=20
@@ -272,15 +271,10 @@ static void vhost_user_blk_device_realize(DeviceSta=
te *dev, Error **errp)
         return;
     }
=20
-    user =3D vhost_user_init();
-    if (!user) {
-        error_setg(errp, "vhost-user-blk: failed to init vhost_user");
+    if (!vhost_user_init(&s->vhost_user, &s->chardev, errp)) {
         return;
     }
=20
-    user->chr =3D &s->chardev;
-    s->vhost_user =3D user;
-
     virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
                 sizeof(struct virtio_blk_config));
=20
@@ -297,7 +291,7 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
=20
     vhost_dev_set_config_notifier(&s->dev, &blk_ops);
=20
-    ret =3D vhost_dev_init(&s->dev, s->vhost_user, VHOST_BACKEND_TYPE_US=
ER, 0);
+    ret =3D vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_U=
SER, 0);
     if (ret < 0) {
         error_setg(errp, "vhost-user-blk: vhost initialization failed: %=
s",
                    strerror(-ret));
@@ -322,10 +316,7 @@ vhost_err:
 virtio_err:
     g_free(vqs);
     virtio_cleanup(vdev);
-
-    vhost_user_cleanup(user);
-    g_free(user);
-    s->vhost_user =3D NULL;
+    vhost_user_cleanup(&s->vhost_user);
 }
=20
 static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **er=
rp)
@@ -338,12 +329,7 @@ static void vhost_user_blk_device_unrealize(DeviceSt=
ate *dev, Error **errp)
     vhost_dev_cleanup(&s->dev);
     g_free(vqs);
     virtio_cleanup(vdev);
-
-    if (s->vhost_user) {
-        vhost_user_cleanup(s->vhost_user);
-        g_free(s->vhost_user);
-        s->vhost_user =3D NULL;
-    }
+    vhost_user_cleanup(&s->vhost_user);
 }
=20
 static void vhost_user_blk_instance_init(Object *obj)
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 6728878a52..8b1e6876db 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -69,7 +69,6 @@ static void vhost_user_scsi_realize(DeviceState *dev, E=
rror **errp)
     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
     VHostUserSCSI *s =3D VHOST_USER_SCSI(dev);
     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
-    VhostUserState *user;
     Error *err =3D NULL;
     int ret;
=20
@@ -86,30 +85,24 @@ static void vhost_user_scsi_realize(DeviceState *dev,=
 Error **errp)
         return;
     }
=20
-    user =3D vhost_user_init();
-    if (!user) {
-        error_setg(errp, "vhost-user-scsi: failed to init vhost_user");
+    if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev, errp)) {
         return;
     }
-    user->chr =3D &vs->conf.chardev;
=20
     vsc->dev.nvqs =3D 2 + vs->conf.num_queues;
     vsc->dev.vqs =3D g_new(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vq_index =3D 0;
     vsc->dev.backend_features =3D 0;
=20
-    ret =3D vhost_dev_init(&vsc->dev, user,
+    ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0);
     if (ret < 0) {
         error_setg(errp, "vhost-user-scsi: vhost initialization failed: =
%s",
                    strerror(-ret));
-        vhost_user_cleanup(user);
-        g_free(user);
+        vhost_user_cleanup(&s->vhost_user);
         return;
     }
=20
-    s->vhost_user =3D user;
-
     /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
     vsc->channel =3D 0;
     vsc->lun =3D 0;
@@ -130,12 +123,7 @@ static void vhost_user_scsi_unrealize(DeviceState *d=
ev, Error **errp)
     g_free(vqs);
=20
     virtio_scsi_common_unrealize(dev, errp);
-
-    if (s->vhost_user) {
-        vhost_user_cleanup(s->vhost_user);
-        g_free(s->vhost_user);
-        s->vhost_user =3D NULL;
-    }
+    vhost_user_cleanup(&s->vhost_user);
 }
=20
 static Property vhost_user_scsi_properties[] =3D {
diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
index 049089b5e2..c175148fce 100644
--- a/hw/virtio/vhost-stub.c
+++ b/hw/virtio/vhost-stub.c
@@ -7,9 +7,9 @@ bool vhost_has_free_slot(void)
     return true;
 }
=20
-VhostUserState *vhost_user_init(void)
+bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **err=
p)
 {
-    return NULL;
+    return false;
 }
=20
 void vhost_user_cleanup(VhostUserState *user)
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 564a31d12c..a0e8a81857 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1739,17 +1739,24 @@ static bool vhost_user_mem_section_filter(struct =
vhost_dev *dev,
     return result;
 }
=20
-VhostUserState *vhost_user_init(void)
+bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **err=
p)
 {
-    VhostUserState *user =3D g_new0(struct VhostUserState, 1);
-
-    return user;
+    if (user->chr) {
+        error_setg(errp, "Cannot initialize vhost-user state");
+        return false;
+    }
+    user->chr =3D chr;
+    return true;
 }
=20
 void vhost_user_cleanup(VhostUserState *user)
 {
     int i;
=20
+    if (!user->chr) {
+        return;
+    }
+
     for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
         if (user->notifier[i].addr) {
             object_unparent(OBJECT(&user->notifier[i].mr));
@@ -1757,6 +1764,7 @@ void vhost_user_cleanup(VhostUserState *user)
             user->notifier[i].addr =3D NULL;
         }
     }
+    user->chr =3D NULL;
 }
=20
 const VhostOps user_ops =3D {
diff --git a/net/vhost-user.c b/net/vhost-user.c
index a39f9c9974..cea78b81f6 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -291,19 +291,14 @@ static int net_vhost_user_init(NetClientState *peer=
, const char *device,
 {
     Error *err =3D NULL;
     NetClientState *nc, *nc0 =3D NULL;
-    VhostUserState *user =3D NULL;
     NetVhostUserState *s =3D NULL;
+    VhostUserState *user;
     int i;
=20
     assert(name);
     assert(queues > 0);
=20
-    user =3D vhost_user_init();
-    if (!user) {
-        error_report("failed to init vhost_user");
-        goto err;
-    }
-
+    user =3D g_new0(struct VhostUserState, 1);
     for (i =3D 0; i < queues; i++) {
         nc =3D qemu_new_net_client(&net_vhost_user_info, peer, device, n=
ame);
         snprintf(nc->info_str, sizeof(nc->info_str), "vhost-user%d to %s=
",
@@ -312,11 +307,11 @@ static int net_vhost_user_init(NetClientState *peer=
, const char *device,
         if (!nc0) {
             nc0 =3D nc;
             s =3D DO_UPCAST(NetVhostUserState, nc, nc);
-            if (!qemu_chr_fe_init(&s->chr, chr, &err)) {
+            if (!qemu_chr_fe_init(&s->chr, chr, &err) ||
+                !vhost_user_init(user, &s->chr, &err)) {
                 error_report_err(err);
                 goto err;
             }
-            user->chr =3D &s->chr;
         }
         s =3D DO_UPCAST(NetVhostUserState, nc, nc);
         s->vhost_user =3D user;
--=20
2.20.1.519.g8feddda32c
