Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5a-0007FL-Bs
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5Y-0008Dv-9g
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRN5Y-0008Dh-3P
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44CE13E2D2
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 20:02:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 26 Nov 2018 21:00:07 +0100
Message-Id: <20181126200009.862-15-quintela@redhat.com>
In-Reply-To: <20181126200009.862-1-quintela@redhat.com>
References: <20181126200009.862-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/16] virtio: split virtio gpu bits rom
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/display/virtio-gpu-pci.c | 14 ++++++++++++++
 hw/display/virtio-vga.c     |  1 +
 hw/virtio/virtio-pci.h      | 14 --------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index cece4aa495..fa126cf3e4 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -19,6 +19,20 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-gpu.h"
=20
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
 static Property virtio_gpu_pci_properties[] =3D {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index ab2e369b28..797994cf00 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -3,6 +3,7 @@
 #include "hw/pci/pci.h"
 #include "vga_int.h"
 #include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-gpu.h"
 #include "qapi/error.h"
=20
 /*
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 59016d553b..91981b39f9 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -17,11 +17,9 @@
=20
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
=20
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
-typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
=20
 /* virtio-pci-bus */
@@ -184,18 +182,6 @@ static inline void virtio_pci_disable_modern(VirtIOP=
CIProxy *proxy)
  */
 #define TYPE_VIRTIO_INPUT_PCI "virtio-input-pci"
=20
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
--=20
2.19.1
