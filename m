Received: from eggs.gnu.org ([2001:4830:134:3::10]:34523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpXD-0007zx-Hl
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpXC-0006RO-MS
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGpXC-0006R2-DN
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:46 -0400
Date: Fri, 2 Jun 2017 19:34:41 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496421247-857-7-git-send-email-mst@redhat.com>
References: <1496421247-857-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1496421247-857-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/8] vhost-user: add vhost_user to hold the chr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Next patches will add more fields to the structure

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index dde094a..bd13b23 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -110,6 +110,10 @@ static VhostUserMsg m __attribute__ ((unused));
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
@@ -117,7 +121,8 @@ static bool ioeventfd_enabled(void)
=20
 static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
 {
-    CharBackend *chr =3D dev->opaque;
+    struct vhost_user *u =3D dev->opaque;
+    CharBackend *chr =3D u->chr;
     uint8_t *p =3D (uint8_t *) msg;
     int r, size =3D VHOST_USER_HDR_SIZE;
=20
@@ -202,7 +207,8 @@ static bool vhost_user_one_time_request(VhostUserRequ=
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
@@ -575,11 +581,14 @@ static int vhost_user_reset_device(struct vhost_dev=
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
@@ -624,8 +633,12 @@ static int vhost_user_init(struct vhost_dev *dev, vo=
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
MST
