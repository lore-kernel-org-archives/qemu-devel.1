Received: from eggs.gnu.org ([208.118.235.92]:59215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gf3iF-0006eH-FO
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gf3iE-0000Cu-11
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:11:07 -0500
Received: from trasno.trasno.org ([83.165.45.250]:43306 helo=mail.trasno.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@trasno.org>) id 1gf3iC-00008l-3o
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:11:04 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  3 Jan 2019 15:10:11 +0100
Message-Id: <20190103141013.18019-15-quintela@redhat.com>
In-Reply-To: <20190103141013.18019-1-quintela@redhat.com>
References: <20190103141013.18019-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 14/16] virtio: split virtio gpu bits from
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/display/virtio-gpu-pci.c | 14 ++++++++++++++
 hw/display/virtio-vga.c     |  1 +
 hw/virtio/virtio-pci.h      | 14 --------------
 3 files changed, 15 insertions(+), 14 deletions(-)

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
-- 
2.20.1
