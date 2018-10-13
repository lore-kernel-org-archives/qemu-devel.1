Received: from eggs.gnu.org ([2001:4830:134:3::10]:57670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBDTB-0000dw-HG
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBDT4-0002zs-2z
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:32:13 -0400
Received: from m12-16.163.com ([220.181.12.16]:57228)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBDT2-0002xP-5v
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:32:05 -0400
From: Li Qiang <liq3ea@163.com>
Date: Fri, 12 Oct 2018 23:31:53 -0700
Message-Id: <20181013063153.54423-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] hw: ne2000: make it more QOMconventional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/net/ne2000.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 07d79e317f..ab71ad49cb 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -33,6 +33,10 @@
 
 #define MAX_ETH_FRAME_SIZE 1514
 
+#define TYPE_NE2000 "ne2k_pci"
+#define NE2000(obj) \
+    OBJECT_CHECK(PCINE2000State, (obj), TYPE_NE2000)
+
 #define E8390_CMD	0x00  /* The command register (for all pages) */
 /* Page 0 register offsets. */
 #define EN0_CLDALO	0x01	/* Low byte of current local dma addr  RD */
@@ -720,7 +724,7 @@ static NetClientInfo net_ne2000_info = {
 
 static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
 {
-    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
+    PCINE2000State *d = NE2000(pci_dev);
     NE2000State *s;
     uint8_t *pci_conf;
 
@@ -742,7 +746,7 @@ static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
 
 static void pci_ne2000_exit(PCIDevice *pci_dev)
 {
-    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
+    PCINE2000State *d = NE2000(pci_dev);
     NE2000State *s = &d->ne2000;
 
     qemu_del_nic(s->nic);
@@ -751,13 +755,12 @@ static void pci_ne2000_exit(PCIDevice *pci_dev)
 
 static void ne2000_instance_init(Object *obj)
 {
-    PCIDevice *pci_dev = PCI_DEVICE(obj);
-    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
+    PCINE2000State *d = NE2000(obj);
     NE2000State *s = &d->ne2000;
 
     device_add_bootindex_property(obj, &s->c.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  &pci_dev->qdev, NULL);
+                                  DEVICE(obj), NULL);
 }
 
 static Property ne2000_properties[] = {
@@ -782,7 +785,7 @@ static void ne2000_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ne2000_info = {
-    .name          = "ne2k_pci",
+    .name          = TYPE_NE2000,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCINE2000State),
     .class_init    = ne2000_class_init,
-- 
2.17.1
