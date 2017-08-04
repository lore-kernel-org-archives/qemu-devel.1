Received: from eggs.gnu.org ([2001:4830:134:3::10]:52194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dddsH-0002fm-3L
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddanl-0003MZ-RO
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddanl-0003L8-DX
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:29:57 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 Aug 2017 13:29:38 +0200
Message-Id: <20170804112946.5247-2-cohuck@redhat.com>
In-Reply-To: <20170804112946.5247-1-cohuck@redhat.com>
References: <20170804112946.5247-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/9] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

The msi routing code in kvm calls some pci functions: provide
some stubs to enable builds without pci.

Also, to make this more obvious, guard them via a pci_available boolean
(which also can be reused in other places).

Fixes: e1d4fb2de ("kvm-irqchip: x86: add msi route notify fn")
Fixes: 767a554a0 ("kvm-all: Pass requester ID to MSI routing functions")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 accel/kvm/kvm-all.c  |  6 +++---
 hw/pci/pci-stub.c    | 13 +++++++++++++
 hw/pci/pci.c         |  2 ++
 include/hw/pci/pci.h |  2 ++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 46ce479dc3..f85553a851 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1248,7 +1248,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
     int virq;
     MSIMessage msg = {0, 0};
 
-    if (dev) {
+    if (pci_available && dev) {
         msg = pci_get_msi_message(dev, vector);
     }
 
@@ -1271,7 +1271,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
     kroute.u.msi.address_lo = (uint32_t)msg.address;
     kroute.u.msi.address_hi = msg.address >> 32;
     kroute.u.msi.data = le32_to_cpu(msg.data);
-    if (kvm_msi_devid_required()) {
+    if (pci_available && kvm_msi_devid_required()) {
         kroute.flags = KVM_MSI_VALID_DEVID;
         kroute.u.msi.devid = pci_requester_id(dev);
     }
@@ -1309,7 +1309,7 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
     kroute.u.msi.address_lo = (uint32_t)msg.address;
     kroute.u.msi.address_hi = msg.address >> 32;
     kroute.u.msi.data = le32_to_cpu(msg.data);
-    if (kvm_msi_devid_required()) {
+    if (pci_available && kvm_msi_devid_required()) {
         kroute.flags = KVM_MSI_VALID_DEVID;
         kroute.u.msi.devid = pci_requester_id(dev);
     }
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index ecad664946..877c5d165e 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -23,10 +23,12 @@
 #include "monitor/monitor.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/msi.h"
 #include "qmp-commands.h"
 #include "hw/pci/msi.h"
 
 bool msi_nonbroken;
+bool pci_available;
 
 PciInfoList *qmp_query_pci(Error **errp)
 {
@@ -38,3 +40,14 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "PCI devices not supported\n");
 }
+
+/* kvm-all wants this */
+MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
+{
+    assert(false);
+}
+
+uint16_t pci_requester_id(PCIDevice *dev)
+{
+    assert(false);
+}
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 258fbe51e2..26f346db2c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -49,6 +49,8 @@
 # define PCI_DPRINTF(format, ...)       do { } while (0)
 #endif
 
+bool pci_available = true;
+
 static void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent);
 static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e598b095eb..8bb6449dd7 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -10,6 +10,8 @@
 
 #include "hw/pci/pcie.h"
 
+extern bool pci_available;
+
 /* PCI bus */
 
 #define PCI_DEVFN(slot, func)   ((((slot) & 0x1f) << 3) | ((func) & 0x07))
-- 
2.13.3
