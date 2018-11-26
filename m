Received: from eggs.gnu.org ([2001:4830:134:3::10]:52715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5e-0007Hm-TJ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5c-0008Fh-VL
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRN5c-0008FB-Nw
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94F2D45CD2
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 20:02:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 26 Nov 2018 21:00:08 +0100
Message-Id: <20181126200009.862-16-quintela@redhat.com>
In-Reply-To: <20181126200009.862-1-quintela@redhat.com>
References: <20181126200009.862-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/16] virtio: split virtio crypto bits rom
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
 hw/virtio/virtio-crypto-pci.c | 14 ++++++++++++++
 hw/virtio/virtio-pci.h        | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.=
c
index bf64996e48..1b242d3037 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -19,6 +19,20 @@
 #include "hw/virtio/virtio-crypto.h"
 #include "qapi/error.h"
=20
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
 static Property virtio_crypto_pci_properties[] =3D {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 91981b39f9..bead9e5fa5 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -17,10 +17,8 @@
=20
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-crypto.h"
=20
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
-typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
=20
 /* virtio-pci-bus */
=20
@@ -182,18 +180,6 @@ static inline void virtio_pci_disable_modern(VirtIOP=
CIProxy *proxy)
  */
 #define TYPE_VIRTIO_INPUT_PCI "virtio-input-pci"
=20
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
 /* Virtio ABI version, if we increment this, we break the guest driver. =
*/
 #define VIRTIO_PCI_ABI_VERSION          0
=20
--=20
2.19.1
