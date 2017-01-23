Received: from eggs.gnu.org ([2001:4830:134:3::10]:58278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cVkAc-00061n-KV
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cVkAb-0007h2-Ci
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:20:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cVkAb-0007gw-4V
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:20:49 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 531E6635EA
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 19:20:49 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 23 Jan 2017 21:20:20 +0200
Message-Id: <1485199220-3298-4-git-send-email-marcel@redhat.com>
In-Reply-To: <1485199220-3298-1-git-send-email-marcel@redhat.com>
References: <1485199220-3298-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V3 3/3] hw/pcie: Introduce Generic PCI Express
 Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, kraxel@redhat.com, abologna@redhat.com

The Generic Root Port behaves almost the same as the
Intel's IOH device with id 3420, without having
Intel specific attributes.

The device has two purposes:
 (1) Can be used on both X86 and ARM machines.
 (2) It will allow us to tweak the behaviour
    (e.g add vendor-specific PCI capabilities)
     - something that obviously cannot be done
       on a known device.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-bridge/Makefile.objs        |  2 +-
 hw/pci-bridge/gen_pcie_root_port.c | 88 ++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h               |  1 +
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 hw/pci-bridge/gen_pcie_root_port.c

diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
index 4f2039f..85e8e39 100644
--- a/hw/pci-bridge/Makefile.objs
+++ b/hw/pci-bridge/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-y += pci_bridge_dev.o
 common-obj-y += pci_expander_bridge.o
-common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o
+common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o
 common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
 common-obj-$(CONFIG_IOH3420) += ioh3420.o
 common-obj-$(CONFIG_I82801B11) += i82801b11.o
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
new file mode 100644
index 0000000..42bbe34
--- /dev/null
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -0,0 +1,88 @@
+/*
+ * Generic PCI Express Root Port emulation
+ *
+ * Copyright (C) 2017 Red Hat Inc
+ *
+ * Authors:
+ *   Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pcie_port.h"
+
+#define TYPE_GEN_PCIE_ROOT_PORT                "pcie-root-port"
+
+#define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
+#define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
+
+static uint8_t gen_rp_aer_vector(const PCIDevice *d)
+{
+    return 0;
+}
+
+static int gen_rp_interrupts_init(PCIDevice *d, Error **errp)
+{
+    int rc;
+
+    rc = msix_init_exclusive_bar(d, GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR, 0);
+
+    if (rc < 0) {
+        assert(rc == -ENOTSUP);
+        error_setg(errp, "Unable to init msix vectors");
+    } else {
+        msix_vector_use(d, 0);
+    }
+
+    return rc;
+}
+
+static void gen_rp_interrupts_uninit(PCIDevice *d)
+{
+    msix_uninit_exclusive_bar(d);
+}
+
+static const VMStateDescription vmstate_rp_dev = {
+    .name = "pcie-root-port",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = pcie_cap_slot_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
+        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
+                       PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
+
+    k->vendor_id = PCI_VENDOR_ID_REDHAT;
+    k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_RP;
+    dc->desc = "PCI Express Root Port";
+    dc->vmsd = &vmstate_rp_dev;
+    rpc->aer_vector = gen_rp_aer_vector;
+    rpc->interrupts_init = gen_rp_interrupts_init;
+    rpc->interrupts_uninit = gen_rp_interrupts_uninit;
+    rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
+}
+
+static const TypeInfo gen_rp_dev_info = {
+    .name          = TYPE_GEN_PCIE_ROOT_PORT,
+    .parent        = TYPE_PCIE_ROOT_PORT,
+    .class_init    = gen_rp_dev_class_init,
+};
+
+ static void gen_rp_register_types(void)
+ {
+    type_register_static(&gen_rp_dev_info);
+ }
+ type_init(gen_rp_register_types)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 772692f..cbc1fdf 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -96,6 +96,7 @@
 #define PCI_DEVICE_ID_REDHAT_PXB         0x0009
 #define PCI_DEVICE_ID_REDHAT_BRIDGE_SEAT 0x000a
 #define PCI_DEVICE_ID_REDHAT_PXB_PCIE    0x000b
+#define PCI_DEVICE_ID_REDHAT_PCIE_RP     0x000c
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.5.5
