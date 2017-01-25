Received: from eggs.gnu.org ([2001:4830:134:3::10]:39185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cWSrZ-0002oT-JY
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cWSrY-0007XZ-63
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:04:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cWSrX-0007WJ-UD
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:04:08 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23D9E4E02A
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 19:04:08 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 25 Jan 2017 21:03:56 +0200
Message-Id: <1485371038-737-2-git-send-email-marcel@redhat.com>
In-Reply-To: <1485371038-737-1-git-send-email-marcel@redhat.com>
References: <1485371038-737-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V4 1/3] hw/pcie: Introduce a base class for PCI
 Express Root Ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, abologna@redhat.com

The 'base' PCI Express Root Port includes
the common code to be re-used for all
Root Ports implementations. Most of the code
was taken from the current implementation
of Intel's IOH 3420 Root Port.

Tested-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 default-configs/arm-softmmu.mak    |   1 +
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/pci-bridge/Makefile.objs        |   1 +
 hw/pci-bridge/pcie_root_port.c     | 171 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie_port.h         |  19 +++++
 6 files changed, 194 insertions(+)
 create mode 100644 hw/pci-bridge/pcie_root_port.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 6de3e16..6f2a180 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -108,6 +108,7 @@ CONFIG_FSL_IMX25=y
 
 CONFIG_IMX_I2C=y
 
+CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 0b51360..9288838 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -51,6 +51,7 @@ CONFIG_PVPANIC=y
 CONFIG_MEM_HOTPLUG=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
+CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 7f89503..7d2c2d4 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -51,6 +51,7 @@ CONFIG_PVPANIC=y
 CONFIG_MEM_HOTPLUG=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
+CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
index f2adfe3..4f2039f 100644
--- a/hw/pci-bridge/Makefile.objs
+++ b/hw/pci-bridge/Makefile.objs
@@ -1,5 +1,6 @@
 common-obj-y += pci_bridge_dev.o
 common-obj-y += pci_expander_bridge.o
+common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o
 common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
 common-obj-$(CONFIG_IOH3420) += ioh3420.o
 common-obj-$(CONFIG_I82801B11) += i82801b11.o
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
new file mode 100644
index 0000000..cf36318
--- /dev/null
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -0,0 +1,171 @@
+/*
+ * Base class for PCI Express Root Ports
+ *
+ * Copyright (C) 2017 Red Hat Inc
+ *
+ * Authors:
+ *   Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * Most of the code was migrated from hw/pci-bridge/ioh3420.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/pci/pcie_port.h"
+
+static void rp_aer_vector_update(PCIDevice *d)
+{
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
+
+    if (rpc->aer_vector) {
+        pcie_aer_root_set_vector(d, rpc->aer_vector(d));
+    }
+}
+
+static void rp_write_config(PCIDevice *d, uint32_t address,
+                            uint32_t val, int len)
+{
+    uint32_t root_cmd =
+        pci_get_long(d->config + d->exp.aer_cap + PCI_ERR_ROOT_COMMAND);
+
+    pci_bridge_write_config(d, address, val, len);
+    rp_aer_vector_update(d);
+    pcie_cap_slot_write_config(d, address, val, len);
+    pcie_aer_write_config(d, address, val, len);
+    pcie_aer_root_write_config(d, address, val, len, root_cmd);
+}
+
+static void rp_reset(DeviceState *qdev)
+{
+    PCIDevice *d = PCI_DEVICE(qdev);
+
+    rp_aer_vector_update(d);
+    pcie_cap_root_reset(d);
+    pcie_cap_deverr_reset(d);
+    pcie_cap_slot_reset(d);
+    pcie_cap_arifwd_reset(d);
+    pcie_aer_root_reset(d);
+    pci_bridge_reset(qdev);
+    pci_bridge_disable_base_limit(d);
+}
+
+static void rp_realize(PCIDevice *d, Error **errp)
+{
+    PCIEPort *p = PCIE_PORT(d);
+    PCIESlot *s = PCIE_SLOT(d);
+    PCIDeviceClass *dc = PCI_DEVICE_GET_CLASS(d);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
+    int rc;
+    Error *local_err = NULL;
+
+    pci_config_set_interrupt_pin(d->config, 1);
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pcie_port_init_reg(d);
+
+    rc = pci_bridge_ssvid_init(d, rpc->ssvid_offset, dc->vendor_id, rpc->ssid);
+    if (rc < 0) {
+        error_setg(errp, "Can't init SSV ID, error %d", rc);
+        goto err_bridge;
+    }
+
+    if (rpc->interrupts_init) {
+        rc = rpc->interrupts_init(d, &local_err);
+        if (rc < 0) {
+            error_propagate(errp, local_err);
+            goto err_bridge;
+        }
+    }
+
+    rc = pcie_cap_init(d, rpc->exp_offset, PCI_EXP_TYPE_ROOT_PORT, p->port);
+    if (rc < 0) {
+        error_setg(errp, "Can't add Root Port capability, error %d", rc);
+        goto err_int;
+    }
+
+    pcie_cap_arifwd_init(d);
+    pcie_cap_deverr_init(d);
+    pcie_cap_slot_init(d, s->slot);
+    pcie_cap_root_init(d);
+
+    pcie_chassis_create(s->chassis);
+    rc = pcie_chassis_add_slot(s);
+    if (rc < 0) {
+        error_setg(errp, "Can't add chassis slot, error %d", rc);
+        goto err_pcie_cap;
+    }
+
+    rc = pcie_aer_init(d, PCI_ERR_VER, rpc->aer_offset,
+                       PCI_ERR_SIZEOF, &local_err);
+    if (rc < 0) {
+        error_propagate(errp, local_err);
+        goto err;
+    }
+    pcie_aer_root_init(d);
+    rp_aer_vector_update(d);
+
+    return;
+
+err:
+    pcie_chassis_del_slot(s);
+err_pcie_cap:
+    pcie_cap_exit(d);
+err_int:
+    if (rpc->interrupts_uninit) {
+        rpc->interrupts_uninit(d);
+    }
+err_bridge:
+    pci_bridge_exitfn(d);
+}
+
+static void rp_exit(PCIDevice *d)
+{
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
+    PCIESlot *s = PCIE_SLOT(d);
+
+    pcie_aer_exit(d);
+    pcie_chassis_del_slot(s);
+    pcie_cap_exit(d);
+    if (rpc->interrupts_uninit) {
+        rpc->interrupts_uninit(d);
+    }
+    pci_bridge_exitfn(d);
+}
+
+static Property rp_props[] = {
+    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
+                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void rp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->is_express = 1;
+    k->is_bridge = 1;
+    k->config_write = rp_write_config;
+    k->realize = rp_realize;
+    k->exit = rp_exit;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->reset = rp_reset;
+    dc->props = rp_props;
+}
+
+static const TypeInfo rp_info = {
+    .name          = TYPE_PCIE_ROOT_PORT,
+    .parent        = TYPE_PCIE_SLOT,
+    .class_init    = rp_class_init,
+    .abstract      = true,
+    .class_size = sizeof(PCIERootPortClass),
+};
+
+static void rp_register_types(void)
+{
+    type_register_static(&rp_info);
+}
+
+type_init(rp_register_types)
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index f7b64db..1333266 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -57,4 +57,23 @@ PCIESlot *pcie_chassis_find_slot(uint8_t chassis, uint16_t slot);
 int pcie_chassis_add_slot(struct PCIESlot *slot);
 void pcie_chassis_del_slot(PCIESlot *s);
 
+#define TYPE_PCIE_ROOT_PORT         "pcie-root-port-base"
+#define PCIE_ROOT_PORT_CLASS(klass) \
+     OBJECT_CLASS_CHECK(PCIERootPortClass, (klass), TYPE_PCIE_ROOT_PORT)
+#define PCIE_ROOT_PORT_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(PCIERootPortClass, (obj), TYPE_PCIE_ROOT_PORT)
+
+typedef struct PCIERootPortClass {
+    PCIDeviceClass parent_class;
+
+    uint8_t (*aer_vector)(const PCIDevice *dev);
+    int (*interrupts_init)(PCIDevice *dev, Error **errp);
+    void (*interrupts_uninit)(PCIDevice *dev);
+
+    int exp_offset;
+    int aer_offset;
+    int ssvid_offset;
+    int ssid;
+} PCIERootPortClass;
+
 #endif /* QEMU_PCIE_PORT_H */
-- 
2.5.5
