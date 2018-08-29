Received: from eggs.gnu.org ([2001:4830:134:3::10]:42857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuyqk-0001gO-QE
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuynb-0007V3-9L
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:38:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuynb-0007Tj-0n
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:38:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A776440216E7
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 11:38:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 29 Aug 2018 13:37:28 +0200
Message-Id: <20180829113730.14992-15-quintela@redhat.com>
In-Reply-To: <20180829113730.14992-1-quintela@redhat.com>
References: <20180829113730.14992-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 14/16] virtio: split virtio gpu bits rom
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, mst@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/display/virtio-gpu-pci.c | 14 ++++++++++++++
 hw/display/virtio-vga.c     |  1 +
 hw/virtio/virtio-pci.h      | 14 --------------
 tests/Makefile.include      |  4 ++--
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index cece4aa495..fa126cf3e4 100644
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
index 701d980872..15576be290 100644
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
index 59016d553b..91981b39f9 100644
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
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2c36afe7d9..30c493190d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -246,8 +246,8 @@ check-qtest-pci-y += tests/display-vga-test$(EXESUF)
 gcov-files-pci-y += hw/display/vga.c
 gcov-files-pci-y += hw/display/cirrus_vga.c
 gcov-files-pci-y += hw/display/vga-pci.c
-gcov-files-pci-y += hw/display/virtio-gpu.c
-gcov-files-pci-y += hw/display/virtio-gpu-pci.c
+gcov-files-pci-$(CONFIG_VIRTIO_GPU) += hw/display/virtio-gpu.c
+gcov-files-pci-$(CONFIG_VIRTIO_GPU) += hw/display/virtio-gpu-pci.c
 gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
 check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
 gcov-files-pci-$(CONFIG_HDA) += hw/audio/intel-hda.c hw/audio/hda-codec.c
-- 
2.17.1
