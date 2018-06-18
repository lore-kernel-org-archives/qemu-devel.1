Received: from eggs.gnu.org ([2001:4830:134:3::10]:43795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqh-0001nG-Bk
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqf-0004y0-P2
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fUwqf-0004xg-If
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 356454000B74
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 16:17:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 18:17:07 +0200
Message-Id: <20180618161729.334-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180618161729.334-1-marcandre.lureau@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 04/26] vhost-user: simplify
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
Cc: berrange@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Take a VhostUserState* that can be pre-allocated, and initialize it
with the associated chardev.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/vhost-user-blk.h  |  2 +-
 include/hw/virtio/vhost-user-scsi.h |  2 +-
 include/hw/virtio/vhost-user.h      |  2 +-
 backends/cryptodev-vhost-user.c     | 18 ++++--------------
 hw/block/vhost-user-blk.c           | 22 ++++------------------
 hw/scsi/vhost-user-scsi.c           | 20 ++++----------------
 hw/virtio/vhost-stub.c              |  2 +-
 hw/virtio/vhost-user.c              | 16 ++++++++++++----
 net/vhost-user.c                    |  8 ++++----
 9 files changed, 32 insertions(+), 60 deletions(-)

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
index 3ec34ae867..7c22bdc957 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -31,7 +31,7 @@
 typedef struct VHostUserSCSI {
     VHostSCSICommon parent_obj;
     uint64_t host_features;
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
index d52daccfcd..63573e211e 100644
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
@@ -187,7 +187,6 @@ static void cryptodev_vhost_user_init(
     size_t i;
     Error *local_err =3D NULL;
     Chardev *chr;
-    VhostUserState *user;
     CryptoDevBackendClient *cc;
     CryptoDevBackendVhostUser *s =3D
                       CRYPTODEV_BACKEND_VHOST_USER(backend);
@@ -218,15 +217,10 @@ static void cryptodev_vhost_user_init(
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
@@ -312,11 +306,7 @@ static void cryptodev_vhost_user_cleanup(
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
index d755223643..5a2c6fe5f3 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -224,7 +224,6 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
-    VhostUserState *user;
     int i, ret;
=20
     if (!s->chardev.chr) {
@@ -242,15 +241,10 @@ static void vhost_user_blk_device_realize(DeviceSta=
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
@@ -266,7 +260,7 @@ static void vhost_user_blk_device_realize(DeviceState=
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
@@ -291,10 +285,7 @@ vhost_err:
 virtio_err:
     g_free(s->dev.vqs);
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
@@ -306,12 +297,7 @@ static void vhost_user_blk_device_unrealize(DeviceSt=
ate *dev, Error **errp)
     vhost_dev_cleanup(&s->dev);
     g_free(s->dev.vqs);
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
index 9355cfdf07..b620725bc2 100644
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
@@ -129,12 +122,7 @@ static void vhost_user_scsi_unrealize(DeviceState *d=
ev, Error **errp)
     g_free(vsc->dev.vqs);
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
 static uint64_t vhost_user_scsi_get_features(VirtIODevice *vdev,
diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
index 049089b5e2..323dfcc46a 100644
--- a/hw/virtio/vhost-stub.c
+++ b/hw/virtio/vhost-stub.c
@@ -7,7 +7,7 @@ bool vhost_has_free_slot(void)
     return true;
 }
=20
-VhostUserState *vhost_user_init(void)
+bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **err=
p)
 {
     return NULL;
 }
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b041343632..44795880d6 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1743,17 +1743,24 @@ static bool vhost_user_mem_section_filter(struct =
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
@@ -1761,6 +1768,7 @@ void vhost_user_cleanup(VhostUserState *user)
             user->notifier[i].addr =3D NULL;
         }
     }
+    user->chr =3D NULL;
 }
=20
 const VhostOps user_ops =3D {
diff --git a/net/vhost-user.c b/net/vhost-user.c
index a39f9c9974..5e5b8f3fc9 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -291,14 +291,14 @@ static int net_vhost_user_init(NetClientState *peer=
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
+    user =3D g_new0(struct VhostUserState, 1);
     if (!user) {
         error_report("failed to init vhost_user");
         goto err;
@@ -312,11 +312,11 @@ static int net_vhost_user_init(NetClientState *peer=
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
2.18.0.rc1
