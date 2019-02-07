Received: from eggs.gnu.org ([209.51.188.92]:44172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmzF-0005Ju-G9
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmzD-0004Cb-RW
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:57:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grmzD-0004C7-Hz
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:57:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C58B540F30
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 16:57:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  7 Feb 2019 17:54:49 +0100
Message-Id: <20190207165449.6125-13-marcandre.lureau@redhat.com>
In-Reply-To: <20190207165449.6125-1-marcandre.lureau@redhat.com>
References: <20190207165449.6125-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/12] RFC: add explicit can_migrate to
 vhost_user_backend_dev_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

In general, there is not much support for migrating a vhost-user slave
process. Many virtio devices however implement vmsd, and the
vhost-user instances (as child objects) may be migrated.

Since there is no other support at this point, the slave is assumed to
be state less (outside of VM state), or using a migration method
outside of qemu migration stream.

Since this is not well specified, add a common blocker for the
VhostUserBackend users (vhost-user-input and upcoming gpu will use
it).

RFC since I am not sure that's what Michael had in mind when
requesting such blocker.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/vhost-user-backend.h | 2 +-
 backends/vhost-user.c               | 7 ++++++-
 hw/input/vhost-user-input.c         | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/vhost-user-backend.h b/include/sysemu/vhost-u=
ser-backend.h
index 60f811cae7..feb331288f 100644
--- a/include/sysemu/vhost-user-backend.h
+++ b/include/sysemu/vhost-user-backend.h
@@ -53,7 +53,7 @@ struct VhostUserBackend {
 };
=20
 int vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
-                                unsigned nvqs, Error **errp);
+                                unsigned nvqs, bool can_migrate, Error *=
*errp);
 void vhost_user_backend_start(VhostUserBackend *b);
 void vhost_user_backend_stop(VhostUserBackend *b);
=20
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index bf39c0751d..4e0af8952a 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -30,7 +30,7 @@ ioeventfd_enabled(void)
=20
 int
 vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
-                            unsigned nvqs, Error **errp)
+                            unsigned nvqs, bool can_migrate, Error **err=
p)
 {
     int ret;
=20
@@ -49,6 +49,11 @@ vhost_user_backend_dev_init(VhostUserBackend *b, VirtI=
ODevice *vdev,
     b->dev.nvqs =3D nvqs;
     b->dev.vqs =3D g_new(struct vhost_virtqueue, nvqs);
=20
+    if (!can_migrate && !b->dev.migration_blocker) {
+        error_setg(&b->dev.migration_blocker,
+                   "Migration disabled: vhost-user device can't migrate"=
);
+    }
+
     ret =3D vhost_dev_init(&b->dev, &b->vhost_user, VHOST_BACKEND_TYPE_U=
SER, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "vhost initialization failed");
diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
index ef1b23a8b2..360a2ff618 100644
--- a/hw/input/vhost-user-input.c
+++ b/hw/input/vhost-user-input.c
@@ -24,7 +24,7 @@ static void vhost_input_realize(DeviceState *dev, Error=
 **errp)
         return;
     }
=20
-    if (vhost_user_backend_dev_init(vhi->vhost, vdev, 2, errp) =3D=3D -1=
) {
+    if (vhost_user_backend_dev_init(vhi->vhost, vdev, 2, false, errp) =3D=
=3D -1) {
         return;
     }
=20
--=20
2.20.1.519.g8feddda32c
