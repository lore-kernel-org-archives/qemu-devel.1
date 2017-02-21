Received: from eggs.gnu.org ([2001:4830:134:3::10]:56603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBFd-0002Mz-TM
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBFY-0004j9-TX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:17:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBFY-0004ie-FQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:17:04 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31FA7C04BD23
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:17:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:49 +0400
Message-Id: <20170221141451.28305-29-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 28/30] tests: add specialized device_find
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Allows to specify which slot to look for the device.

This will be used in the following patch to avoid leaking when multiple
devices exists and we want to lookup the hotplug one.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/libqos/virtio-pci.h |  4 ++--
 tests/libqos/virtio-pci.c | 31 ++++++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 0fab916cf8..6ef19094cb 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -31,9 +31,9 @@ typedef struct QVirtQueuePCI {
=20
 extern const QVirtioBus qvirtio_pci;
=20
-void qvirtio_pci_foreach(QPCIBus *bus, uint16_t device_type,
-                void (*func)(QVirtioDevice *d, void *data), void *data);
 QVirtioPCIDevice *qvirtio_pci_device_find(QPCIBus *bus, uint16_t device_=
type);
+QVirtioPCIDevice *qvirtio_pci_device_find_slot(QPCIBus *bus,
+                                               uint16_t device_type, int=
 slot);
 void qvirtio_pci_device_free(QVirtioPCIDevice *dev);
=20
 void qvirtio_pci_device_enable(QVirtioPCIDevice *d);
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 456cccdc7b..8a0904bbf0 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -24,6 +24,8 @@
 typedef struct QVirtioPCIForeachData {
     void (*func)(QVirtioDevice *d, void *data);
     uint16_t device_type;
+    bool has_slot;
+    int slot;
     void *user_data;
 } QVirtioPCIForeachData;
=20
@@ -55,10 +57,11 @@ static void qvirtio_pci_foreach_callback(
     QVirtioPCIForeachData *d =3D data;
     QVirtioPCIDevice *vpcidev =3D qpcidevice_to_qvirtiodevice(dev);
=20
-    if (vpcidev->vdev.device_type =3D=3D d->device_type) {
+    if (vpcidev->vdev.device_type =3D=3D d->device_type &&
+        (!d->has_slot || vpcidev->pdev->devfn =3D=3D d->slot << 3)) {
         d->func(&vpcidev->vdev, d->user_data);
     } else {
-        g_free(vpcidev);
+        qvirtio_pci_device_free(vpcidev);
     }
 }
=20
@@ -290,21 +293,39 @@ const QVirtioBus qvirtio_pci =3D {
     .virtqueue_kick =3D qvirtio_pci_virtqueue_kick,
 };
=20
-void qvirtio_pci_foreach(QPCIBus *bus, uint16_t device_type,
+static void qvirtio_pci_foreach(QPCIBus *bus, uint16_t device_type,
+                bool has_slot, int slot,
                 void (*func)(QVirtioDevice *d, void *data), void *data)
 {
     QVirtioPCIForeachData d =3D { .func =3D func,
                                 .device_type =3D device_type,
+                                .has_slot =3D has_slot,
+                                .slot =3D slot,
                                 .user_data =3D data };
=20
     qpci_device_foreach(bus, PCI_VENDOR_ID_REDHAT_QUMRANET, -1,
-                                qvirtio_pci_foreach_callback, &d);
+                        qvirtio_pci_foreach_callback, &d);
 }
=20
 QVirtioPCIDevice *qvirtio_pci_device_find(QPCIBus *bus, uint16_t device_=
type)
 {
     QVirtioPCIDevice *dev =3D NULL;
-    qvirtio_pci_foreach(bus, device_type, qvirtio_pci_assign_device, &de=
v);
+
+    qvirtio_pci_foreach(bus, device_type, false, 0,
+                        qvirtio_pci_assign_device, &dev);
+
+    dev->vdev.bus =3D &qvirtio_pci;
+
+    return dev;
+}
+
+QVirtioPCIDevice *qvirtio_pci_device_find_slot(QPCIBus *bus,
+                                               uint16_t device_type, int=
 slot)
+{
+    QVirtioPCIDevice *dev =3D NULL;
+
+    qvirtio_pci_foreach(bus, device_type, true, slot,
+                        qvirtio_pci_assign_device, &dev);
=20
     dev->vdev.bus =3D &qvirtio_pci;
=20
--=20
2.11.0.295.gd7dffce1c.dirty
