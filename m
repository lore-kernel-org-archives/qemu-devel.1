Received: from eggs.gnu.org ([2001:4830:134:3::10]:35120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihl-0002vW-Ms
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihk-0007Ca-My
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:45 -0400
Received: from mail.kernel.org ([198.145.29.136]:38742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihk-0007C8-H1
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:44 -0400
Date: Wed, 22 Mar 2017 18:01:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490198476-12244-2-git-send-email-mst@redhat.com>
References: <1490198476-12244-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490198476-12244-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] virtio: Fix error handling in
 virtio_bus_device_plugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Andrew Jones <drjones@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Fam Zheng <famz@redhat.com>

For one thing we shouldn't continue if an error happened, for the other
two steps failing can cause an abort() in error_setg because we reuse
the same errp blindly.

Add error handling checks to fix both issues.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/virtio/virtio-bus.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index a886011..3042232 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "hw/qdev.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio.h"
@@ -48,20 +49,33 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Er=
ror **errp)
     VirtioBusClass *klass =3D VIRTIO_BUS_GET_CLASS(bus);
     VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
     bool has_iommu =3D virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLAT=
FORM);
+    Error *local_err =3D NULL;
=20
     DPRINTF("%s: plug device.\n", qbus->name);
=20
     if (klass->pre_plugged !=3D NULL) {
-        klass->pre_plugged(qbus->parent, errp);
+        klass->pre_plugged(qbus->parent, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
=20
     /* Get the features of the plugged device. */
     assert(vdc->get_features !=3D NULL);
     vdev->host_features =3D vdc->get_features(vdev, vdev->host_features,
-                                            errp);
+                                            &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
     if (klass->device_plugged !=3D NULL) {
-        klass->device_plugged(qbus->parent, errp);
+        klass->device_plugged(qbus->parent, &local_err);
+    }
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
     }
=20
     if (klass->get_dma_as !=3D NULL && has_iommu) {
--=20
MST
