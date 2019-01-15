Received: from eggs.gnu.org ([209.51.188.92]:35305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyV-0007cP-Ra
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyP-0003Nw-RN
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyO-0002ts-32
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:09 -0500
Date: Tue, 15 Jan 2019 15:05:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-20-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 19/49] virtio: split virtio input host bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

From: Juan Quintela <quintela@redhat.com>

For consistency with other devices, rename
virtio_host_{initfn,pci_info} to virtio_input_host_{initfn,info}.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 default-configs/virtio.mak        |  1 +
 hw/virtio/virtio-pci.h            | 14 ---------
 hw/virtio/virtio-input-host-pci.c | 48 +++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c            | 23 ---------------
 hw/virtio/Makefile.objs           |  1 +
 5 files changed, 50 insertions(+), 37 deletions(-)
 create mode 100644 hw/virtio/virtio-input-host-pci.c

diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index 1304849018..5ae4a61018 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -12,3 +12,4 @@ CONFIG_VIRTIO_RNG=y
 CONFIG_SCSI=y
 CONFIG_VIRTIO_SCSI=y
 CONFIG_VIRTIO_SERIAL=y
+CONFIG_VIRTIO_INPUT_HOST=$(CONFIG_LINUX)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 2109d002df..fb10afe160 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -50,7 +50,6 @@ typedef struct VHostUserBlkPCI VHostUserBlkPCI;
 typedef struct VirtIORngPCI VirtIORngPCI;
 typedef struct VirtIOInputPCI VirtIOInputPCI;
 typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
-typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
@@ -359,19 +358,6 @@ struct VirtIOInputHIDPCI {
     VirtIOInputHID vdev;
 };
 
-#ifdef CONFIG_LINUX
-
-#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci-base"
-#define VIRTIO_INPUT_HOST_PCI(obj) \
-        OBJECT_CHECK(VirtIOInputHostPCI, (obj), TYPE_VIRTIO_INPUT_HOST_PCI)
-
-struct VirtIOInputHostPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIOInputHost vdev;
-};
-
-#endif
-
 /*
  * virtio-gpu-pci: This extends VirtioPCIProxy.
  */
diff --git a/hw/virtio/virtio-input-host-pci.c b/hw/virtio/virtio-input-host-pci.c
new file mode 100644
index 0000000000..725a51ad30
--- /dev/null
+++ b/hw/virtio/virtio-input-host-pci.c
@@ -0,0 +1,48 @@
+/*
+ * Virtio input host PCI Bindings
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "virtio-pci.h"
+#include "hw/virtio/virtio-input.h"
+
+typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
+
+#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci-base"
+#define VIRTIO_INPUT_HOST_PCI(obj) \
+        OBJECT_CHECK(VirtIOInputHostPCI, (obj), TYPE_VIRTIO_INPUT_HOST_PCI)
+
+struct VirtIOInputHostPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOInputHost vdev;
+};
+
+static void virtio_host_initfn(Object *obj)
+{
+    VirtIOInputHostPCI *dev = VIRTIO_INPUT_HOST_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_INPUT_HOST);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_input_host_pci_info = {
+    .base_name             = TYPE_VIRTIO_INPUT_HOST_PCI,
+    .generic_name          = "virtio-input-host-pci",
+    .transitional_name     = "virtio-input-host-pci-transitional",
+    .non_transitional_name = "virtio-input-host-pci-non-transitional",
+    .parent        = TYPE_VIRTIO_INPUT_PCI,
+    .instance_size = sizeof(VirtIOInputHostPCI),
+    .instance_init = virtio_host_initfn,
+};
+
+static void virtio_input_host_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_input_host_pci_info);
+}
+
+type_init(virtio_input_host_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4312d95fe9..d951f278a2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2707,26 +2707,6 @@ static const VirtioPCIDeviceTypeInfo virtio_tablet_pci_info = {
     .instance_init = virtio_tablet_initfn,
 };
 
-#ifdef CONFIG_LINUX
-static void virtio_host_initfn(Object *obj)
-{
-    VirtIOInputHostPCI *dev = VIRTIO_INPUT_HOST_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_INPUT_HOST);
-}
-
-static const VirtioPCIDeviceTypeInfo virtio_host_pci_info = {
-    .base_name             = TYPE_VIRTIO_INPUT_HOST_PCI,
-    .generic_name          = "virtio-input-host-pci",
-    .transitional_name     = "virtio-input-host-pci-transitional",
-    .non_transitional_name = "virtio-input-host-pci-non-transitional",
-    .parent        = TYPE_VIRTIO_INPUT_PCI,
-    .instance_size = sizeof(VirtIOInputHostPCI),
-    .instance_init = virtio_host_initfn,
-};
-#endif
-
 /* virtio-pci-bus */
 
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2785,9 +2765,6 @@ static void virtio_pci_register_types(void)
     virtio_pci_types_register(&virtio_keyboard_pci_info);
     virtio_pci_types_register(&virtio_mouse_pci_info);
     virtio_pci_types_register(&virtio_tablet_pci_info);
-#ifdef CONFIG_LINUX
-    virtio_pci_types_register(&virtio_host_pci_info);
-#endif
 #ifdef CONFIG_VIRTFS
     virtio_pci_types_register(&virtio_9p_pci_info);
 #endif
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 39884c5f7b..a6b850ed09 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -13,6 +13,7 @@ obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
+obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 endif
 endif
 
-- 
MST
