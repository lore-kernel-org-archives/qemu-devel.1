Received: from eggs.gnu.org ([2001:4830:134:3::10]:53667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmiK-0001eY-Bd
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmiB-00046b-9e
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:56 -0500
Received: from mail.kernel.org ([198.145.29.136]:38682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmiA-00045w-Vp
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:47 -0500
Date: Thu, 26 Jan 2017 18:15:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485447262-27014-11-git-send-email-mst@redhat.com>
References: <1485447262-27014-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485447262-27014-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 10/18] hw/pcie: Introduce Generic PCI Express
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Andrea Bolognani <abologna@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Andrea Bolognani <abologna@redhat.com>
---
 include/hw/pci/pci.h               |  1 +
 hw/pci-bridge/gen_pcie_root_port.c | 88 ++++++++++++++++++++++++++++++++++++++
 hw/pci-bridge/Makefile.objs        |  2 +-
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 hw/pci-bridge/gen_pcie_root_port.c

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
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
new file mode 100644
index 0000000..185fd90
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
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
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
-- 
MST
