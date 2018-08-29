Received: from eggs.gnu.org ([2001:4830:134:3::10]:42829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuyqf-0001cf-Ue
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuync-0007a6-TX
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:38:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49654 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuync-0007XV-NL
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:38:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E03140241C0
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 11:38:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 29 Aug 2018 13:37:29 +0200
Message-Id: <20180829113730.14992-16-quintela@redhat.com>
In-Reply-To: <20180829113730.14992-1-quintela@redhat.com>
References: <20180829113730.14992-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 15/16] virtio: split virtio crypto bits rom
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
2.17.1
