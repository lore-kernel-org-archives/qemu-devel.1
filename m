Received: from eggs.gnu.org ([209.51.188.92]:60593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guann-00086E-TR
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guanl-0004Ta-EK
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:33:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1guanl-000440-0N
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:33:01 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Feb 2019 10:32:38 +0000
Message-Id: <20190215103239.28640-2-berrange@redhat.com>
In-Reply-To: <20190215103239.28640-1-berrange@redhat.com>
References: <20190215103239.28640-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] hw: report invalid
 disable-legacy|modern usage for virtio-1-only devs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

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
 hw/core/machine.c             | 23 ++++++++++++++++++++---
 hw/display/virtio-gpu-pci.c   |  4 +++-
 hw/display/virtio-vga.c       |  4 +++-
 hw/virtio/virtio-crypto-pci.c |  4 +++-
 hw/virtio/virtio-input-pci.c  |  4 +++-
 hw/virtio/virtio-pci.c        | 26 ++++++++++++++++----------
 hw/virtio/virtio-pci.h        | 31 +++++++++++++++++++++++++------
 7 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 077fbd182a..61fb791e6a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -96,9 +96,26 @@ const size_t hw_compat_2_7_len =3D G_N_ELEMENTS(hw_com=
pat_2_7);
=20
 GlobalProperty hw_compat_2_6[] =3D {
     { "virtio-mmio", "format_transport_address", "off" },
-    /* Optional because not all virtio-pci devices support legacy mode *=
/
-    { "virtio-pci", "disable-modern", "on",  .optional =3D true },
-    { "virtio-pci", "disable-legacy", "off", .optional =3D true },
+    /*
+     * don't include devices which are modern-only
+     * ie keyboard, mouse, tablet, gpu, vga & crypto
+     */
+    { "virtio-9p-pci", "disable-modern", "on" },
+    { "virtio-9p-pci", "disable-legacy", "off" },
+    { "virtio-balloon-pci", "disable-modern", "on" },
+    { "virtio-balloon-pci", "disable-legacy", "off" },
+    { "virtio-blk-pci", "disable-modern", "on" },
+    { "virtio-blk-pci", "disable-legacy", "off" },
+    { "virtio-input-host-pci", "disable-modern", "on" },
+    { "virtio-input-host-pci", "disable-legacy", "off" },
+    { "virtio-net-pci", "disable-modern", "on" },
+    { "virtio-net-pci", "disable-legacy", "off" },
+    { "virtio-rng-pci", "disable-modern", "on" },
+    { "virtio-rng-pci", "disable-legacy", "off" },
+    { "virtio-scsi-pci", "disable-modern", "on" },
+    { "virtio-scsi-pci", "disable-legacy", "off" },
+    { "virtio-serial-pci", "disable-modern", "on" },
+    { "virtio-serial-pci", "disable-legacy", "off" },
 };
 const size_t hw_compat_2_6_len =3D G_N_ELEMENTS(hw_compat_2_6);
=20
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index bdcd33c925..0bc4d9d424 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -47,7 +47,9 @@ static void virtio_gpu_pci_realize(VirtIOPCIProxy *vpci=
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
index 1e48009b74..d63fe8c345 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -145,7 +145,9 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_d=
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
index 90a6e0dc2e..13807e538b 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -51,7 +51,9 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *v=
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
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index 2c1397842b..28477729a3 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -48,7 +48,9 @@ static void virtio_input_pci_realize(VirtIOPCIProxy *vp=
ci_dev, Error **errp)
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
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e978bfe760..ec31ec6cf3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1721,16 +1721,22 @@ static void virtio_pci_realize(PCIDevice *pci_dev=
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
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index bd223a6e3b..16ef4c0a3f 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -15,6 +15,7 @@
 #ifndef QEMU_VIRTIO_PCI_H
 #define QEMU_VIRTIO_PCI_H
=20
+#include "qapi/error.h"
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-bus.h"
=20
@@ -118,6 +119,12 @@ typedef struct VirtIOPCIQueue {
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
@@ -142,6 +149,7 @@ struct VirtIOPCIProxy {
     bool disable_modern;
     bool ignore_backend_features;
     OnOffAuto disable_legacy;
+    VirtIOPCIMode mode;
     uint32_t class_code;
     uint32_t nvectors;
     uint32_t dfselect;
@@ -156,23 +164,34 @@ struct VirtIOPCIProxy {
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
