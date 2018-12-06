Received: from eggs.gnu.org ([2001:4830:134:3::10]:50019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gUrSU-00034F-Is
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gUrSO-0000Jw-Nn
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:04:42 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Thu, 6 Dec 2018 19:25:58 +0800
Message-Id: <1544095560-70807-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn>
References: <1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V12 3/5] hw/misc/pvpanic: Add the PCI interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

Add pvpanic new type "TYPE_PVPANIC_PCI"

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/misc/pvpanic.c         | 62 ++++++++++++++++++++++++++++++++++++++++++++---
 include/hw/misc/pvpanic.h |  1 +
 include/hw/pci/pci.h      |  1 +
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 0f23a67..9fb9168 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -2,10 +2,12 @@
  * QEMU simulated pvpanic device.
  *
  * Copyright Fujitsu, Corp. 2013
+ * Copyright (c) 2018 ZTE Ltd.
  *
  * Authors:
  *     Wen Congyang <wency@cn.fujitsu.com>
  *     Hu Tao <hutao@cn.fujitsu.com>
+ *     Peng Hao <peng.hao2@zte.com.cn>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -18,6 +20,7 @@
 
 #include "hw/nvram/fw_cfg.h"
 #include "hw/misc/pvpanic.h"
+#include "hw/pci/pci.h"
 
 /* The bit of supported pv event */
 #define PVPANIC_F_PANICKED      0
@@ -27,6 +30,8 @@
 
 #define PVPANIC_ISA_DEVICE(obj)    \
     OBJECT_CHECK(PVPanicISAState, (obj), TYPE_PVPANIC)
+#define PVPANIC_PCI_DEVICE(obj)    \
+    OBJECT_CHECK(PVPanicPCIState, (obj), TYPE_PVPANIC_PCI)
 
 static void handle_event(int event)
 {
@@ -56,21 +61,31 @@ typedef struct PVPanicISAState {
     MemoryRegion mr;
 } PVPanicISAState;
 
+/* PVPanicPCIState for PCI device and
+ * use mmio.
+ */
+typedef struct PVPanicPCIState {
+    /*< private>*/
+    PCIDevice dev;
+
+    /*<public>*/
+    MemoryRegion mr;
+} PVPanicPCIState;
 /* return supported events on read */
-static uint64_t pvpanic_ioport_read(void *opaque, hwaddr addr, unsigned size)
+static uint64_t pvpanic_read(void *opaque, hwaddr addr, unsigned size)
 {
     return PVPANIC_PANICKED;
 }
 
-static void pvpanic_ioport_write(void *opaque, hwaddr addr, uint64_t val,
+static void pvpanic_write(void *opaque, hwaddr addr, uint64_t val,
                                  unsigned size)
 {
     handle_event(val);
 }
 
 static const MemoryRegionOps pvpanic_ops = {
-    .read = pvpanic_ioport_read,
-    .write = pvpanic_ioport_write,
+    .read = pvpanic_read,
+    .write = pvpanic_write,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -125,9 +140,48 @@ static TypeInfo pvpanic_isa_info = {
     .class_init    = pvpanic_isa_class_init,
 };
 
+/* pvpanic pci device*/
+
+static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
+{
+    PVPanicPCIState *s = DO_UPCAST(PVPanicPCIState, dev, dev);
+
+    memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_ops, s,
+                          TYPE_PVPANIC_PCI, 2);
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mr);
+}
+
+static void pvpanic_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+
+    pc->realize = pvpanic_pci_realizefn;
+    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
+    pc->device_id = PCI_DEVICE_ID_REDHAT_PVPANIC;
+    pc->revision = 1;
+    pc->class_id = PCI_CLASS_SYSTEM_OTHER;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static TypeInfo pvpanic_pci_info = {
+    .name          = TYPE_PVPANIC_PCI,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PVPanicPCIState),
+    .class_init    = pvpanic_pci_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    }
+};
+
+
 static void pvpanic_register_types(void)
 {
     type_register_static(&pvpanic_isa_info);
+    type_register_static(&pvpanic_pci_info);
 }
 
 type_init(pvpanic_register_types)
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 1ee071a..477cc36 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -15,6 +15,7 @@
 #define HW_MISC_PVPANIC_H
 
 #define TYPE_PVPANIC "pvpanic"
+#define TYPE_PVPANIC_PCI "pvpanic-pci"
 
 #define PVPANIC_IOPORT_PROP "ioport"
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6514bb..92622f7 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -103,6 +103,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
 #define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
+#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0101
 
 #define FMT_PCIBUS                      PRIx64
 
-- 
1.8.3.1
