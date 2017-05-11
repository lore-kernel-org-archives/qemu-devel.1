Received: from eggs.gnu.org ([2001:4830:134:3::10]:55334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d8nHl-0002jo-VB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d8nHi-0004vU-SA
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:33:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1d8nHi-0004uU-IZ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:33:34 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 11 May 2017 14:32:44 +0200
Message-Id: <20170511123246.31308-5-maxime.coquelin@redhat.com>
In-Reply-To: <20170511123246.31308-1-maxime.coquelin@redhat.com>
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/6] vhost-user: add vhost_user to hold the chr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Next patches will add more fields to the structure

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/virtio/vhost-user.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9334a8a..f0e10d0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -111,6 +111,10 @@ static VhostUserMsg m __attribute__ ((unused));
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    (0x1)
=20
+struct vhost_user {
+    CharBackend *chr;
+};
+
 static bool ioeventfd_enabled(void)
 {
     return kvm_enabled() && kvm_eventfds_enabled();
@@ -118,7 +122,8 @@ static bool ioeventfd_enabled(void)
=20
 static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
 {
-    CharBackend *chr =3D dev->opaque;
+    struct vhost_user *u =3D dev->opaque;
+    CharBackend *chr =3D u->chr;
     uint8_t *p =3D (uint8_t *) msg;
     int r, size =3D VHOST_USER_HDR_SIZE;
=20
@@ -199,7 +204,8 @@ static bool vhost_user_one_time_request(VhostUserRequ=
est request)
 static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
                             int *fds, int fd_num)
 {
-    CharBackend *chr =3D dev->opaque;
+    struct vhost_user *u =3D dev->opaque;
+    CharBackend *chr =3D u->chr;
     int ret, size =3D VHOST_USER_HDR_SIZE + msg->size;
=20
     /*
@@ -571,11 +577,14 @@ static int vhost_user_reset_device(struct vhost_dev=
 *dev)
 static int vhost_user_init(struct vhost_dev *dev, void *opaque)
 {
     uint64_t features;
+    struct vhost_user *u;
     int err;
=20
     assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
=20
-    dev->opaque =3D opaque;
+    u =3D g_new0(struct vhost_user, 1);
+    u->chr =3D opaque;
+    dev->opaque =3D u;
=20
     err =3D vhost_user_get_features(dev, &features);
     if (err < 0) {
@@ -620,8 +629,12 @@ static int vhost_user_init(struct vhost_dev *dev, vo=
id *opaque)
=20
 static int vhost_user_cleanup(struct vhost_dev *dev)
 {
+    struct vhost_user *u;
+
     assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
=20
+    u =3D dev->opaque;
+    g_free(u);
     dev->opaque =3D 0;
=20
     return 0;
--=20
2.9.3
