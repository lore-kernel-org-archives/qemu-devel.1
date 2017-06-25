Received: from eggs.gnu.org ([2001:4830:134:3::10]:55511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dPB4R-0008Ov-D8
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 13:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dPB4Q-0007rF-5l
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 13:11:35 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dPB4P-0007qX-RL
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 13:11:34 -0400
Received: by mail-lf0-x241.google.com with SMTP id f28so10996150lfi.3
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 10:11:33 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 25 Jun 2017 20:11:00 +0300
Message-Id: <1498410660-15762-2-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1498410660-15762-1-git-send-email-zuban32s@gmail.com>
References: <1498410660-15762-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH RFC] hw/pci-bridge: implement pcie-pci-bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, imammedo@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/pci-bridge/Makefile.objs     |   2 +-
 hw/pci-bridge/pcie_pci_bridge.c | 152 ++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h            |   1 +
 3 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 hw/pci-bridge/pcie_pci_bridge.c

diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
index c4683cf..666db37 100644
--- a/hw/pci-bridge/Makefile.objs
+++ b/hw/pci-bridge/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += pci_bridge_dev.o
+common-obj-y += pci_bridge_dev.o pcie_pci_bridge.o
 common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o
 common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
 common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
new file mode 100644
index 0000000..06b19d6
--- /dev/null
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -0,0 +1,152 @@
+/*
+ * QEMU Generic PCIE-PCI Bridge
+ *
+ * Copyright (c) 2017 Aleksandr Bezzubikov
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/slotid_cap.h"
+
+typedef struct PCIEPCIBridge {
+    /*< private >*/
+    PCIBridge parent_obj;
+
+#define PCI_BRIDGE_DEV_F_SHPC_REQ 0
+    uint32_t flags;
+    /*< public >*/
+} PCIEPCIBridge;
+
+#define TYPE_PCIE_PCI_BRIDGE_DEV      "pcie-pci-bridge"
+#define PCIE_PCI_BRIDGE_DEV(obj) \
+        OBJECT_CHECK(PCIEPCIBridge, (obj), TYPE_PCIE_PCI_BRIDGE_DEV)
+
+static void pciepci_bridge_realize(PCIDevice *d, Error **errp)
+{
+    int rc, pos;
+    Error *local_err = NULL;
+
+    pci_bridge_initfn(d, TYPE_PCI_BUS);
+
+    rc = pci_bridge_ssvid_init(d, 0, 0, 0x32);
+    if (rc < 0) {
+        error_setg(errp, "Can't add SSVID, error %d", rc);
+        goto error;
+    }
+
+    rc = pcie_cap_init(d, 0, PCI_EXP_TYPE_PCI_BRIDGE, 0);
+    if (rc < 0) {
+        error_setg(errp, "Can't add PCIE-PCI bridge capability, error %d", rc);
+        goto error;
+    }
+
+    pos = pci_add_capability(d, PCI_CAP_ID_PM, 0, PCI_PM_SIZEOF);
+    assert(pos > 0);
+    d->exp.pm_cap = pos;
+    pci_set_word(d->config + pos + PCI_PM_PMC, 0x3);
+
+    pcie_cap_arifwd_init(d);
+    pcie_cap_deverr_init(d);
+
+    rc = pcie_aer_init(d, PCI_ERR_VER, 0x100, PCI_ERR_SIZEOF, &local_err);
+    if (rc < 0) {
+        error_propagate(errp, local_err);
+        goto error;
+    }
+
+    rc = msi_init(d, 0, 1, 1, 1, &local_err);
+    if (rc < 0) {
+        error_propagate(errp, local_err);
+    }
+
+    return;
+
+    error:
+    pci_bridge_exitfn(d);
+}
+
+static void pciepci_bridge_exit(PCIDevice *d)
+{
+    pcie_cap_exit(d);
+    pci_bridge_exitfn(d);
+}
+
+static void pciepci_bridge_reset(DeviceState *qdev)
+{
+    pci_bridge_reset(qdev);
+}
+
+static void pcie_pci_bridge_write_config(PCIDevice *d,
+        uint32_t address, uint32_t val, int len)
+{
+    pci_bridge_write_config(d, address, val, len);
+    msi_write_config(d, address, val, len);
+}
+
+
+static Property pcie_pci_bridge_dev_properties[] = {
+        DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription pciepci_bridge_dev_vmstate = {
+        .name = TYPE_PCIE_PCI_BRIDGE_DEV,
+        .fields = (VMStateField[]) {
+            VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
+            VMSTATE_END_OF_LIST()
+        }
+};
+
+static void pciepci_bridge_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    k->is_express = 1;
+    k->is_bridge = 1;
+    k->vendor_id = PCI_VENDOR_ID_REDHAT;
+    k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
+    k->realize = pciepci_bridge_realize;
+    k->exit = pciepci_bridge_exit;
+    k->config_write = pcie_pci_bridge_write_config;
+    dc->vmsd = &pciepci_bridge_dev_vmstate;
+    dc->props = pcie_pci_bridge_dev_properties;
+    dc->vmsd = &pciepci_bridge_dev_vmstate;
+    dc->reset = &pciepci_bridge_reset;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+}
+
+static const TypeInfo pciepci_bridge_info = {
+        .name = TYPE_PCIE_PCI_BRIDGE_DEV,
+        .parent = TYPE_PCI_BRIDGE,
+        .instance_size = sizeof(PCIEPCIBridge),
+        .class_init = pciepci_bridge_class_init
+};
+
+static void pciepci_register(void)
+{
+    type_register_static(&pciepci_bridge_info);
+}
+
+type_init(pciepci_register);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a37a2d5..47bf8da 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -98,6 +98,7 @@
 #define PCI_DEVICE_ID_REDHAT_PXB_PCIE    0x000b
 #define PCI_DEVICE_ID_REDHAT_PCIE_RP     0x000c
 #define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
+#define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.7.4
