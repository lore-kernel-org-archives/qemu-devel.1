Received: from eggs.gnu.org ([2001:4830:134:3::10]:41198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eafqa-0007wt-6a
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eafqX-0000rG-Vf
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:49:04 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41908
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eafqX-0000q9-OZ
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:49:01 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 14 Jan 2018 10:47:45 +0000
Message-Id: <20180114104751.21965-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 05/11] apb: QOMify sabre PCI host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/apb.c         |  6 +++---
 include/hw/pci-host/apb.h | 14 +++++++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 98c5f344f7..36c6251816 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -407,7 +407,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
                                      &s->pci_ioport,
                                      0, 32, TYPE_PCI_BUS);
 
-    pci_create_simple(phb->bus, 0, "pbm-pci");
+    pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
 
     /* IOMMU */
     memory_region_add_subregion_overlap(&s->apb_config, 0x200,
@@ -498,9 +498,9 @@ static void sabre_pci_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo sabre_pci_info = {
-    .name          = "pbm-pci",
+    .name          = TYPE_SABRE_PCI_DEVICE,
     .parent        = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(PCIDevice),
+    .instance_size = sizeof(SabrePCIState),
     .class_init    = sabre_pci_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index 41de012396..470863639a 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -14,9 +14,13 @@
 #define OBIO_MSE_IRQ         0x2a
 #define OBIO_SER_IRQ         0x2b
 
-#define TYPE_APB "pbm"
-#define APB_DEVICE(obj) \
-    OBJECT_CHECK(APBState, (obj), TYPE_APB)
+typedef struct SabrePCIState {
+    PCIDevice parent_obj;
+} SabrePCIState;
+
+#define TYPE_SABRE_PCI_DEVICE "sabre-pci"
+#define SABRE_PCI_DEVICE(obj) \
+    OBJECT_CHECK(SabrePCIState, (obj), TYPE_SABRE_PCI_DEVICE)
 
 typedef struct APBState {
     PCIHostState parent_obj;
@@ -41,4 +45,8 @@ typedef struct APBState {
     unsigned int nr_resets;
 } APBState;
 
+#define TYPE_APB "apb"
+#define APB_DEVICE(obj) \
+    OBJECT_CHECK(APBState, (obj), TYPE_APB)
+
 #endif
-- 
2.11.0
