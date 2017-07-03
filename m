Received: from eggs.gnu.org ([2001:4830:134:3::10]:47187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7IB-0008WI-K4
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7I6-0003UZ-Pe
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS7I6-0003Tf-JD
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:50 -0400
Date: Mon, 3 Jul 2017 22:45:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-18-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/21] vhost: ensure vhost_ops are set before
 calling iotlb callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch fixes a crash that happens when vhost-user iommu
support is enabled and vhost-user socket is closed.

When it happens, if an IOTLB invalidation notification is sent
by the IOMMU, vhost_ops's NULL pointer is dereferenced.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-backend.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 4e31de1..cb055e8 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -309,7 +309,10 @@ int vhost_backend_update_device_iotlb(struct vhost_d=
ev *dev,
         return -EINVAL;
     }
=20
-    return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+    if (dev->vhost_ops && dev->vhost_ops->vhost_send_device_iotlb_msg)
+        return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+
+    return -ENODEV;
 }
=20
 int vhost_backend_invalidate_device_iotlb(struct vhost_dev *dev,
@@ -321,7 +324,10 @@ int vhost_backend_invalidate_device_iotlb(struct vho=
st_dev *dev,
     imsg.size =3D len;
     imsg.type =3D VHOST_IOTLB_INVALIDATE;
=20
-    return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+    if (dev->vhost_ops && dev->vhost_ops->vhost_send_device_iotlb_msg)
+        return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+
+    return -ENODEV;
 }
=20
 int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
--=20
MST
