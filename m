Received: from eggs.gnu.org ([2001:4830:134:3::10]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gXY7C-0001gA-9L
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gXY7B-0004fF-38
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:50 -0500
Received: from trasno.trasno.org ([83.165.45.250]:42312 helo=mail.trasno.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@trasno.org>) id 1gXY7A-0004BU-Ps
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:49 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Dec 2018 22:00:56 +0100
Message-Id: <20181213210057.3676-16-quintela@redhat.com>
In-Reply-To: <20181213210057.3676-1-quintela@redhat.com>
References: <20181213210057.3676-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 15/16] virtio: split virtio crypto bits rom
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/virtio-crypto-pci.c | 14 ++++++++++++++
 hw/virtio/virtio-pci.h        | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index bf64996e48..1b242d3037 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -19,6 +19,20 @@
 #include "hw/virtio/virtio-crypto.h"
 #include "qapi/error.h"
 
+typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
+
+/*
+ * virtio-crypto-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_CRYPTO_PCI "virtio-crypto-pci"
+#define VIRTIO_CRYPTO_PCI(obj) \
+        OBJECT_CHECK(VirtIOCryptoPCI, (obj), TYPE_VIRTIO_CRYPTO_PCI)
+
+struct VirtIOCryptoPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOCrypto vdev;
+};
+
 static Property virtio_crypto_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 91981b39f9..bead9e5fa5 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -17,10 +17,8 @@
 
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-crypto.h"
 
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
-typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
 /* virtio-pci-bus */
 
@@ -182,18 +180,6 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
  */
 #define TYPE_VIRTIO_INPUT_PCI "virtio-input-pci"
 
-/*
- * virtio-crypto-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_CRYPTO_PCI "virtio-crypto-pci"
-#define VIRTIO_CRYPTO_PCI(obj) \
-        OBJECT_CHECK(VirtIOCryptoPCI, (obj), TYPE_VIRTIO_CRYPTO_PCI)
-
-struct VirtIOCryptoPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIOCrypto vdev;
-};
-
 /* Virtio ABI version, if we increment this, we break the guest driver. */
 #define VIRTIO_PCI_ABI_VERSION          0
 
-- 
2.19.2
