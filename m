Received: from eggs.gnu.org ([2001:4830:134:3::10]:46766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3ot-0001wG-QI
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3or-00056U-Ui
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:03 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3or-00054T-M0
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:01 -0500
Received: by mail-pg0-x242.google.com with SMTP id f12so5368431pgo.5
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:35:01 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:34:49 -0600
Message-Id: <1512682489-4474-8-git-send-email-minyard@acm.org>
In-Reply-To: <1512682489-4474-1-git-send-email-minyard@acm.org>
References: <1512682489-4474-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 7/7] ipmi: Add PCI IPMI interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 default-configs/i386-softmmu.mak   |   2 +
 default-configs/x86_64-softmmu.mak |   2 +
 hw/ipmi/Makefile.objs              |   2 +
 hw/ipmi/pci_ipmi_bt.c              | 145 +++++++++++++++++++++++++++++++++++++
 hw/ipmi/pci_ipmi_kcs.c             | 145 +++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h               |   1 +
 6 files changed, 297 insertions(+)
 create mode 100644 hw/ipmi/pci_ipmi_bt.c
 create mode 100644 hw/ipmi/pci_ipmi_kcs.c

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 95ac4b4..07aaf77 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -14,7 +14,9 @@ CONFIG_IPMI=y
 CONFIG_IPMI_LOCAL=y
 CONFIG_IPMI_EXTERN=y
 CONFIG_ISA_IPMI_KCS=y
+CONFIG_PCI_IPMI_KCS=y
 CONFIG_ISA_IPMI_BT=y
+CONFIG_PCI_IPMI_BT=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 0221236..179ca35 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -14,7 +14,9 @@ CONFIG_IPMI=y
 CONFIG_IPMI_LOCAL=y
 CONFIG_IPMI_EXTERN=y
 CONFIG_ISA_IPMI_KCS=y
+CONFIG_PCI_IPMI_KCS=y
 CONFIG_ISA_IPMI_BT=y
+CONFIG_PCI_IPMI_BT=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
index 4ffa45a..2d7f080 100644
--- a/hw/ipmi/Makefile.objs
+++ b/hw/ipmi/Makefile.objs
@@ -2,4 +2,6 @@ common-obj-$(CONFIG_IPMI) += ipmi.o ipmi_kcs.o ipmi_bt.o
 common-obj-$(CONFIG_IPMI_LOCAL) += ipmi_bmc_sim.o
 common-obj-$(CONFIG_IPMI_EXTERN) += ipmi_bmc_extern.o
 common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
+common-obj-$(CONFIG_PCI_IPMI_KCS) += pci_ipmi_kcs.o
 common-obj-$(CONFIG_ISA_IPMI_BT) += isa_ipmi_bt.o
+common-obj-$(CONFIG_PCI_IPMI_BT) += pci_ipmi_bt.o
diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
new file mode 100644
index 0000000..8002027
--- /dev/null
+++ b/hw/ipmi/pci_ipmi_bt.c
@@ -0,0 +1,145 @@
+/*
+ * QEMU PCI IPMI BT emulation
+ *
+ * Copyright (c) 2017 Corey Minyard, MontaVista Software, LLC
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
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/ipmi/ipmi_bt.h"
+#include "hw/pci/pci.h"
+
+#define TYPE_PCI_IPMI_BT "pci-ipmi-bt"
+#define PCI_IPMI_BT(obj) OBJECT_CHECK(PCIIPMIBTDevice, (obj), \
+                                       TYPE_PCI_IPMI_BT)
+
+typedef struct PCIIPMIBTDevice {
+    PCIDevice dev;
+    IPMIBT bt;
+    bool irq_enabled;
+    uint32_t uuid;
+} PCIIPMIBTDevice;
+
+static void pci_ipmi_raise_irq(IPMIBT *ik)
+{
+    PCIIPMIBTDevice *pik = ik->opaque;
+
+    pci_set_irq(&pik->dev, true);
+}
+
+static void pci_ipmi_lower_irq(IPMIBT *ik)
+{
+    PCIIPMIBTDevice *pik = ik->opaque;
+
+    pci_set_irq(&pik->dev, false);
+}
+
+static void pci_ipmi_bt_realize(PCIDevice *pd, Error **errp)
+{
+    PCIIPMIBTDevice *pik = PCI_IPMI_BT(pd);
+    IPMIInterface *ii = IPMI_INTERFACE(pd);
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+
+    if (!pik->bt.bmc) {
+        error_setg(errp, "IPMI device requires a bmc attribute to be set");
+        return;
+    }
+
+    pik->uuid = ipmi_next_uuid();
+
+    pik->bt.bmc->intf = ii;
+    pik->bt.opaque = pik;
+
+    pci_config_set_prog_interface(pd->config, 0x02); /* BT */
+    pci_config_set_interrupt_pin(pd->config, 0x01);
+    pik->bt.use_irq = 1;
+    pik->bt.raise_irq = pci_ipmi_raise_irq;
+    pik->bt.lower_irq = pci_ipmi_lower_irq;
+
+    iic->init(ii, 8, errp);
+    if (*errp) {
+        return;
+    }
+    pci_register_bar(pd, 0, PCI_BASE_ADDRESS_SPACE_IO, &pik->bt.io);
+}
+
+const VMStateDescription vmstate_PCIIPMIBTDevice = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "pci-bt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, PCIIPMIBTDevice),
+        VMSTATE_STRUCT(bt, PCIIPMIBTDevice, 1, vmstate_IPMIBT, IPMIBT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pci_ipmi_bt_instance_init(Object *obj)
+{
+    PCIIPMIBTDevice *pik = PCI_IPMI_BT(obj);
+
+    ipmi_bmc_find_and_link(obj, (Object **) &pik->bt.bmc);
+}
+
+static void *pci_ipmi_bt_get_backend_data(IPMIInterface *ii)
+{
+    PCIIPMIBTDevice *pik = PCI_IPMI_BT(ii);
+
+    return &pik->bt;
+}
+
+static void pci_ipmi_bt_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(oc);
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
+
+    pdc->vendor_id = PCI_VENDOR_ID_QEMU;
+    pdc->device_id = PCI_DEVICE_ID_QEMU_IPMI;
+    pdc->revision = 1;
+    pdc->class_id = PCI_CLASS_SERIAL_IPMI;
+
+    dc->vmsd = &vmstate_PCIIPMIBTDevice;
+    dc->desc = "PCI IPMI BT";
+    pdc->realize = pci_ipmi_bt_realize;
+
+    iic->get_backend_data = pci_ipmi_bt_get_backend_data;
+    ipmi_bt_class_init(iic);
+}
+
+static const TypeInfo pci_ipmi_bt_info = {
+    .name          = TYPE_PCI_IPMI_BT,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIIPMIBTDevice),
+    .instance_init = pci_ipmi_bt_instance_init,
+    .class_init    = pci_ipmi_bt_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_IPMI_INTERFACE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    }
+};
+
+static void pci_ipmi_bt_register_types(void)
+{
+    type_register_static(&pci_ipmi_bt_info);
+}
+
+type_init(pci_ipmi_bt_register_types)
diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
new file mode 100644
index 0000000..02bd52f
--- /dev/null
+++ b/hw/ipmi/pci_ipmi_kcs.c
@@ -0,0 +1,145 @@
+/*
+ * QEMU PCI IPMI KCS emulation
+ *
+ * Copyright (c) 2017 Corey Minyard, MontaVista Software, LLC
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
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/ipmi/ipmi_kcs.h"
+#include "hw/pci/pci.h"
+
+#define TYPE_PCI_IPMI_KCS "pci-ipmi-kcs"
+#define PCI_IPMI_KCS(obj) OBJECT_CHECK(PCIIPMIKCSDevice, (obj), \
+                                       TYPE_PCI_IPMI_KCS)
+
+typedef struct PCIIPMIKCSDevice {
+    PCIDevice dev;
+    IPMIKCS kcs;
+    bool irq_enabled;
+    uint32_t uuid;
+} PCIIPMIKCSDevice;
+
+static void pci_ipmi_raise_irq(IPMIKCS *ik)
+{
+    PCIIPMIKCSDevice *pik = ik->opaque;
+
+    pci_set_irq(&pik->dev, true);
+}
+
+static void pci_ipmi_lower_irq(IPMIKCS *ik)
+{
+    PCIIPMIKCSDevice *pik = ik->opaque;
+
+    pci_set_irq(&pik->dev, false);
+}
+
+static void pci_ipmi_kcs_realize(PCIDevice *pd, Error **errp)
+{
+    PCIIPMIKCSDevice *pik = PCI_IPMI_KCS(pd);
+    IPMIInterface *ii = IPMI_INTERFACE(pd);
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+
+    if (!pik->kcs.bmc) {
+        error_setg(errp, "IPMI device requires a bmc attribute to be set");
+        return;
+    }
+
+    pik->uuid = ipmi_next_uuid();
+
+    pik->kcs.bmc->intf = ii;
+    pik->kcs.opaque = pik;
+
+    pci_config_set_prog_interface(pd->config, 0x01); /* KCS */
+    pci_config_set_interrupt_pin(pd->config, 0x01);
+    pik->kcs.use_irq = 1;
+    pik->kcs.raise_irq = pci_ipmi_raise_irq;
+    pik->kcs.lower_irq = pci_ipmi_lower_irq;
+
+    iic->init(ii, 8, errp);
+    if (*errp) {
+        return;
+    }
+    pci_register_bar(pd, 0, PCI_BASE_ADDRESS_SPACE_IO, &pik->kcs.io);
+}
+
+const VMStateDescription vmstate_PCIIPMIKCSDevice = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "pci-kcs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, PCIIPMIKCSDevice),
+        VMSTATE_STRUCT(kcs, PCIIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pci_ipmi_kcs_instance_init(Object *obj)
+{
+    PCIIPMIKCSDevice *pik = PCI_IPMI_KCS(obj);
+
+    ipmi_bmc_find_and_link(obj, (Object **) &pik->kcs.bmc);
+}
+
+static void *pci_ipmi_kcs_get_backend_data(IPMIInterface *ii)
+{
+    PCIIPMIKCSDevice *pik = PCI_IPMI_KCS(ii);
+
+    return &pik->kcs;
+}
+
+static void pci_ipmi_kcs_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(oc);
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
+
+    pdc->vendor_id = PCI_VENDOR_ID_QEMU;
+    pdc->device_id = PCI_DEVICE_ID_QEMU_IPMI;
+    pdc->revision = 1;
+    pdc->class_id = PCI_CLASS_SERIAL_IPMI;
+
+    dc->vmsd = &vmstate_PCIIPMIKCSDevice;
+    dc->desc = "PCI IPMI KCS";
+    pdc->realize = pci_ipmi_kcs_realize;
+
+    iic->get_backend_data = pci_ipmi_kcs_get_backend_data;
+    ipmi_kcs_class_init(iic);
+}
+
+static const TypeInfo pci_ipmi_kcs_info = {
+    .name          = TYPE_PCI_IPMI_KCS,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIIPMIKCSDevice),
+    .instance_init = pci_ipmi_kcs_instance_init,
+    .class_init    = pci_ipmi_kcs_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_IPMI_INTERFACE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    }
+};
+
+static void pci_ipmi_kcs_register_types(void)
+{
+    type_register_static(&pci_ipmi_kcs_info);
+}
+
+type_init(pci_ipmi_kcs_register_types)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 8d02a0a..e8c3e4b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -56,6 +56,7 @@ extern bool pci_available;
 /* QEMU/Bochs VGA (0x1234) */
 #define PCI_VENDOR_ID_QEMU               0x1234
 #define PCI_DEVICE_ID_QEMU_VGA           0x1111
+#define PCI_DEVICE_ID_QEMU_IPMI          0x1112
 
 /* VMWare (0x15ad) */
 #define PCI_VENDOR_ID_VMWARE             0x15ad
-- 
2.7.4
