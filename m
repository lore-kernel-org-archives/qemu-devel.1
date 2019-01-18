Received: from eggs.gnu.org ([209.51.188.92]:49304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkUM9-0006md-Ub
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkUM8-0002zm-8A
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:38:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gkUM7-0002v2-BE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:38:44 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 18 Jan 2019 13:38:26 +0000
Message-Id: <20190118133826.22447-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw: report invalid disable-legacy|modern usage
 for virtio-1-only devs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

A number of virtio devices (gpu, crypto, mouse, keyboard, tablet) only
support the virtio-1 (aka modern) mode. Currently if the user launches
QEMU, setting those devices to enable legacy mode, QEMU will silently
create them in modern mode, ignoring the user's (mistaken) request.

This patch introduces proper data validation so that an attempt to
configure a virtio-1-only devices in legacy mode gets reported as an
error to the user.

Checking this required introduction of a new field to explicitly track
what operating model is to be used for a device, separately from the
disable_modern and disable_legacy fields that record the user's
requested configuration.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/display/virtio-gpu-pci.c   |  4 +++-
 hw/display/virtio-vga.c       |  4 +++-
 hw/virtio/virtio-crypto-pci.c |  4 +++-
 hw/virtio/virtio-pci.c        | 30 +++++++++++++++++++-----------
 hw/virtio/virtio-pci.h        | 31 +++++++++++++++++++++++++------
 5 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index faf76a8bc4..a5b5ce5755 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -33,7 +33,9 @@ static void virtio_gpu_pci_realize(VirtIOPCIProxy *vpci=
_dev, Error **errp)
     Error *local_error =3D NULL;
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    virtio_pci_force_virtio_1(vpci_dev);
+    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
+        return;
+    }
     object_property_set_bool(OBJECT(vdev), true, "realized", &local_erro=
r);
=20
     if (local_error) {
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 8db4d916f2..ae3604c576 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -144,7 +144,9 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_d=
ev, Error **errp)
=20
     /* init virtio bits */
     qdev_set_parent_bus(DEVICE(g), BUS(&vpci_dev->bus));
-    virtio_pci_force_virtio_1(vpci_dev);
+    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
+        return;
+    }
     object_property_set_bool(OBJECT(g), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.=
c
index 8cc3fa3ef7..177b720458 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -37,7 +37,9 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
     }
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    virtio_pci_force_virtio_1(vpci_dev);
+    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
+        return;
+    }
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
     object_property_set_link(OBJECT(vcrypto),
                  OBJECT(vcrypto->vdev.conf.cryptodev), "cryptodev",
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index d05066deb8..75fdee40a8 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1778,16 +1778,22 @@ static void virtio_pci_realize(PCIDevice *pci_dev=
, Error **errp)
                        /* PCI BAR regions must be powers of 2 */
                        pow2ceil(proxy->notify.offset + proxy->notify.siz=
e));
=20
-    if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) {
-        proxy->disable_legacy =3D pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AU=
TO_OFF;
-    }
-
-    if (!virtio_pci_modern(proxy) && !virtio_pci_legacy(proxy)) {
-        error_setg(errp, "device cannot work as neither modern nor legac=
y mode"
-                   " is enabled");
-        error_append_hint(errp, "Set either disable-modern or disable-le=
gacy"
-                          " to off\n");
-        return;
+    if ((proxy->disable_legacy =3D=3D ON_OFF_AUTO_ON) ||
+        ((proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) && pcie_port)) =
{
+        if (proxy->disable_modern) {
+            error_setg(errp, "device cannot work as neither modern nor "
+                       "legacy mode is enabled");
+            error_append_hint(errp, "Set either disable-modern or "
+                              "disable-legacy to off\n");
+            return;
+        }
+        proxy->mode =3D VIRTIO_PCI_MODE_MODERN;
+    } else {
+        if (proxy->disable_modern) {
+            proxy->mode =3D VIRTIO_PCI_MODE_LEGACY;
+        } else {
+            proxy->mode =3D VIRTIO_PCI_MODE_TRANSITIONAL;
+        }
     }
=20
     if (pcie_port && pci_is_express(pci_dev)) {
@@ -2663,7 +2669,9 @@ static void virtio_input_pci_realize(VirtIOPCIProxy=
 *vpci_dev, Error **errp)
     DeviceState *vdev =3D DEVICE(&vinput->vdev);
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    virtio_pci_force_virtio_1(vpci_dev);
+    if (!virtio_pci_force_virtio_1(vpci_dev, errp)) {
+        return;
+    }
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
 }
=20
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 29b4216107..d21c382702 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -15,6 +15,7 @@
 #ifndef QEMU_VIRTIO_PCI_H
 #define QEMU_VIRTIO_PCI_H
=20
+#include "qapi/error.h"
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
@@ -156,6 +157,12 @@ typedef struct VirtIOPCIQueue {
   uint32_t used[2];
 } VirtIOPCIQueue;
=20
+typedef enum {
+    VIRTIO_PCI_MODE_LEGACY,
+    VIRTIO_PCI_MODE_TRANSITIONAL,
+    VIRTIO_PCI_MODE_MODERN,
+} VirtIOPCIMode;
+
 struct VirtIOPCIProxy {
     PCIDevice pci_dev;
     MemoryRegion bar;
@@ -180,6 +187,7 @@ struct VirtIOPCIProxy {
     bool disable_modern;
     bool ignore_backend_features;
     OnOffAuto disable_legacy;
+    VirtIOPCIMode mode;
     uint32_t class_code;
     uint32_t nvectors;
     uint32_t dfselect;
@@ -194,23 +202,34 @@ struct VirtIOPCIProxy {
=20
 static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)
 {
-    return !proxy->disable_modern;
+    return proxy->mode !=3D VIRTIO_PCI_MODE_LEGACY;
 }
=20
 static inline bool virtio_pci_legacy(VirtIOPCIProxy *proxy)
 {
-    return proxy->disable_legacy =3D=3D ON_OFF_AUTO_OFF;
+    return proxy->mode !=3D VIRTIO_PCI_MODE_MODERN;
 }
=20
-static inline void virtio_pci_force_virtio_1(VirtIOPCIProxy *proxy)
+static inline bool virtio_pci_force_virtio_1(VirtIOPCIProxy *proxy,
+                                             Error **errp)
 {
-    proxy->disable_modern =3D false;
-    proxy->disable_legacy =3D ON_OFF_AUTO_ON;
+    if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_OFF) {
+        error_setg(errp, "Unable to set disable-legacy=3Doff on a virtio=
-1.0 "
+                   "only device");
+        return false;
+    }
+    if (proxy->disable_modern =3D=3D true) {
+        error_setg(errp, "Unable to set disable-modern=3Don on a virtio-=
1.0 "
+                   "only device");
+        return false;
+    }
+    proxy->mode =3D VIRTIO_PCI_MODE_MODERN;
+    return true;
 }
=20
 static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
 {
-    proxy->disable_modern =3D true;
+    proxy->mode =3D VIRTIO_PCI_MODE_LEGACY;
 }
=20
 /*
--=20
2.20.1
