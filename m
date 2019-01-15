Received: from eggs.gnu.org ([209.51.188.92]:34591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUy9-0007Cn-Oa
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUy7-00035o-LC
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUy5-000329-LM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:49 -0500
Date: Tue, 15 Jan 2019 15:05:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-32-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 31/49] virtio: split virtio gpu bits from
 virtio-pci.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h      | 14 --------------
 hw/display/virtio-gpu-pci.c | 14 ++++++++++++++
 hw/display/virtio-vga.c     |  1 +
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index d4491e2544..2f7605590d 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -17,11 +17,9 @@
 
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
 
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
-typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
 /* virtio-pci-bus */
@@ -184,18 +182,6 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
  */
 #define TYPE_VIRTIO_INPUT_PCI "virtio-input-pci"
 
-/*
- * virtio-gpu-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_GPU_PCI "virtio-gpu-pci"
-#define VIRTIO_GPU_PCI(obj) \
-        OBJECT_CHECK(VirtIOGPUPCI, (obj), TYPE_VIRTIO_GPU_PCI)
-
-struct VirtIOGPUPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIOGPU vdev;
-};
-
 /*
  * virtio-crypto-pci: This extends VirtioPCIProxy.
  */
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index faf76a8bc4..bdcd33c925 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -19,6 +19,20 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-gpu.h"
 
+typedef struct VirtIOGPUPCI VirtIOGPUPCI;
+
+/*
+ * virtio-gpu-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_GPU_PCI "virtio-gpu-pci"
+#define VIRTIO_GPU_PCI(obj) \
+        OBJECT_CHECK(VirtIOGPUPCI, (obj), TYPE_VIRTIO_GPU_PCI)
+
+struct VirtIOGPUPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOGPU vdev;
+};
+
 static Property virtio_gpu_pci_properties[] = {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 8db4d916f2..1e48009b74 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -3,6 +3,7 @@
 #include "hw/pci/pci.h"
 #include "vga_int.h"
 #include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-gpu.h"
 #include "qapi/error.h"
 
 /*
-- 
MST
