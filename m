Received: from eggs.gnu.org ([2001:4830:134:3::10]:50746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1diULU-00017G-GS
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1diULR-0001mt-QE
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:37:00 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1diULR-0001mD-Es
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:36:57 -0400
Received: by mail-lf0-x244.google.com with SMTP id f7so435147lfg.0
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 16:36:57 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 18 Aug 2017 02:36:47 +0300
Message-Id: <1503013010-11500-2-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1503013010-11500-1-git-send-email-zuban32s@gmail.com>
References: <1503013010-11500-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH v7 1/4] hw/pci: introduce pcie-pci-bridge device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, lersek@redhat.com, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

Introduce a new PCIExpress-to-PCI Bridge device,
which is a hot-pluggable PCI Express device and
supports devices hot-plug with SHPC.

This device is intended to replace the DMI-to-PCI Bridge.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-bridge/Makefile.objs     |   2 +-
 hw/pci-bridge/pcie_pci_bridge.c | 192 ++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h            |   1 +
 3 files changed, 194 insertions(+), 1 deletion(-)
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
index 0000000..9aa5cc3
--- /dev/null
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -0,0 +1,192 @@
+/*
+ * QEMU Generic PCIE-PCI Bridge
+ *
+ * Copyright (c) 2017 Aleksandr Bezzubikov
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/shpc.h"
+#include "hw/pci/slotid_cap.h"
+
+typedef struct PCIEPCIBridge {
+    /*< private >*/
+    PCIBridge parent_obj;
+
+    OnOffAuto msi;
+    MemoryRegion shpc_bar;
+    /*< public >*/
+} PCIEPCIBridge;
+
+#define TYPE_PCIE_PCI_BRIDGE_DEV "pcie-pci-bridge"
+#define PCIE_PCI_BRIDGE_DEV(obj) \
+        OBJECT_CHECK(PCIEPCIBridge, (obj), TYPE_PCIE_PCI_BRIDGE_DEV)
+
+static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
+{
+    PCIBridge *br = PCI_BRIDGE(d);
+    PCIEPCIBridge *pcie_br = PCIE_PCI_BRIDGE_DEV(d);
+    int rc, pos;
+
+    pci_bridge_initfn(d, TYPE_PCI_BUS);
+
+    d->config[PCI_INTERRUPT_PIN] = 0x1;
+    memory_region_init(&pcie_br->shpc_bar, OBJECT(d), "shpc-bar",
+                       shpc_bar_size(d));
+    rc = shpc_init(d, &br->sec_bus, &pcie_br->shpc_bar, 0, errp);
+    if (rc) {
+        goto error;
+    }
+
+    rc = pcie_cap_init(d, 0, PCI_EXP_TYPE_PCI_BRIDGE, 0, errp);
+    if (rc < 0) {
+        goto cap_error;
+    }
+
+    pos = pci_add_capability(d, PCI_CAP_ID_PM, 0, PCI_PM_SIZEOF, errp);
+    if (pos < 0) {
+        goto pm_error;
+    }
+    d->exp.pm_cap = pos;
+    pci_set_word(d->config + pos + PCI_PM_PMC, 0x3);
+
+    pcie_cap_arifwd_init(d);
+    pcie_cap_deverr_init(d);
+
+    rc = pcie_aer_init(d, PCI_ERR_VER, 0x100, PCI_ERR_SIZEOF, errp);
+    if (rc < 0) {
+        goto aer_error;
+    }
+
+    if (pcie_br->msi != ON_OFF_AUTO_OFF) {
+        rc = msi_init(d, 0, 1, true, true, errp);
+        if (rc < 0) {
+            goto msi_error;
+        }
+    }
+    pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64, &pcie_br->shpc_bar);
+    return;
+
+msi_error:
+    pcie_aer_exit(d);
+aer_error:
+pm_error:
+    pcie_cap_exit(d);
+cap_error:
+    shpc_free(d);
+error:
+    pci_bridge_exitfn(d);
+}
+
+static void pcie_pci_bridge_exit(PCIDevice *d)
+{
+    PCIEPCIBridge *bridge_dev = PCIE_PCI_BRIDGE_DEV(d);
+    pcie_cap_exit(d);
+    shpc_cleanup(d, &bridge_dev->shpc_bar);
+    pci_bridge_exitfn(d);
+}
+
+static void pcie_pci_bridge_reset(DeviceState *qdev)
+{
+    PCIDevice *d = PCI_DEVICE(qdev);
+    pci_bridge_reset(qdev);
+    msi_reset(d);
+    shpc_reset(d);
+}
+
+static void pcie_pci_bridge_write_config(PCIDevice *d,
+        uint32_t address, uint32_t val, int len)
+{
+    pci_bridge_write_config(d, address, val, len);
+    msi_write_config(d, address, val, len);
+    shpc_cap_write_config(d, address, val, len);
+}
+
+static Property pcie_pci_bridge_dev_properties[] = {
+        DEFINE_PROP_ON_OFF_AUTO("msi", PCIEPCIBridge, msi, ON_OFF_AUTO_ON),
+        DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
+        .name = TYPE_PCIE_PCI_BRIDGE_DEV,
+        .fields = (VMStateField[]) {
+            VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
+            SHPC_VMSTATE(shpc, PCIDevice, NULL),
+            VMSTATE_END_OF_LIST()
+        }
+};
+
+static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
+{
+    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
+
+    if (!shpc_present(pci_hotplug_dev)) {
+        error_setg(errp, "standard hotplug controller has been disabled for "
+                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
+        return;
+    }
+    shpc_device_hotplug_cb(hotplug_dev, dev, errp);
+}
+
+static void pcie_pci_bridge_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
+                                                 DeviceState *dev,
+                                                 Error **errp)
+{
+    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
+
+    if (!shpc_present(pci_hotplug_dev)) {
+        error_setg(errp, "standard hotplug controller has been disabled for "
+                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
+        return;
+    }
+    shpc_device_hot_unplug_request_cb(hotplug_dev, dev, errp);
+}
+
+static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+
+    k->is_express = 1;
+    k->is_bridge = 1;
+    k->vendor_id = PCI_VENDOR_ID_REDHAT;
+    k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
+    k->realize = pcie_pci_bridge_realize;
+    k->exit = pcie_pci_bridge_exit;
+    k->config_write = pcie_pci_bridge_write_config;
+    dc->vmsd = &pcie_pci_bridge_dev_vmstate;
+    dc->props = pcie_pci_bridge_dev_properties;
+    dc->vmsd = &pcie_pci_bridge_dev_vmstate;
+    dc->reset = &pcie_pci_bridge_reset;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    hc->plug = pcie_pci_bridge_hotplug_cb;
+    hc->unplug_request = pcie_pci_bridge_hot_unplug_request_cb;
+}
+
+static const TypeInfo pcie_pci_bridge_info = {
+        .name = TYPE_PCIE_PCI_BRIDGE_DEV,
+        .parent = TYPE_PCI_BRIDGE,
+        .instance_size = sizeof(PCIEPCIBridge),
+        .class_init = pcie_pci_bridge_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_HOTPLUG_HANDLER },
+            { },
+        }
+};
+
+static void pciepci_register(void)
+{
+    type_register_static(&pcie_pci_bridge_info);
+}
+
+type_init(pciepci_register);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e598b09..b33a34f 100644
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
