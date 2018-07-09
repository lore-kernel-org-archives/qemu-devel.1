Received: from eggs.gnu.org ([2001:4830:134:3::10]:38408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fcSDz-0005R9-NG
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fcSDw-0007Hk-QW
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:51 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:33780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fcSDw-0007HK-JI
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:48 -0400
Received: by mail-ed1-x544.google.com with SMTP id x5-v6so9676238edr.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 02:12:48 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  9 Jul 2018 11:11:31 +0200
Message-Id: <20180709091136.28849-3-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 2/7] tests/qgraph: pci-pc driver and interface
 nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add pci-bus-pc node and pci-bus interface, moved QPCIBusPC struct
declaration in its header (since it will be needed by other drivers)
and introduced a setter method for drivers that do not need to allocate
but have to initialize QPCIBusPC.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/libqos/pci-pc.c | 53 ++++++++++++++++++++++++++++++++++++-------
 tests/libqos/pci-pc.h |  8 +++++++
 tests/libqos/pci.c    |  8 +++++++
 3 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index a7803308b7..f1c1741279 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -18,15 +18,9 @@
 
 #include "qemu-common.h"
 
-
 #define ACPI_PCIHP_ADDR         0xae00
 #define PCI_EJ_BASE             0x0008
 
-typedef struct QPCIBusPC
-{
-    QPCIBus bus;
-} QPCIBusPC;
-
 static uint8_t qpci_pc_pio_readb(QPCIBus *bus, uint32_t addr)
 {
     return inb(addr);
@@ -115,10 +109,33 @@ static void qpci_pc_config_writel(QPCIBus *bus, int devfn, uint8_t offset, uint3
     outl(0xcfc, value);
 }
 
-QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
+static void *qpci_get_driver(void *obj, const char *interface)
 {
-    QPCIBusPC *ret = g_new0(QPCIBusPC, 1);
+    QPCIBusPC *qpci = obj;
+    if (!g_strcmp0(interface, "pci-bus")) {
+        return &qpci->bus;
+    }
+    printf("%s not present in pci-bus-pc", interface);
+    abort();
+}
 
+void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, int devfn)
+{
+    if (!bus) {
+        return;
+    }
+    dev->bus = bus;
+    dev->devfn = devfn;
+
+    if (qpci_config_readw(dev, PCI_VENDOR_ID) == 0xFFFF) {
+        printf("PCI Device not found\n");
+        abort();
+    }
+    qpci_device_enable(dev);
+}
+
+void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *alloc)
+{
     assert(qts);
 
     ret->bus.pio_readb = qpci_pc_pio_readb;
@@ -147,11 +164,23 @@ QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
     ret->bus.mmio_alloc_ptr = 0xE0000000;
     ret->bus.mmio_limit = 0x100000000ULL;
 
+    ret->obj.get_driver = qpci_get_driver;
+}
+
+QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
+{
+    QPCIBusPC *ret = g_new0(QPCIBusPC, 1);
+    qpci_set_pc(ret, qts, alloc);
+
     return &ret->bus;
 }
 
 void qpci_free_pc(QPCIBus *bus)
 {
+    if (!bus) {
+        return;
+    }
+
     QPCIBusPC *s = container_of(bus, QPCIBusPC, bus);
 
     g_free(s);
@@ -176,3 +205,11 @@ void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
 
     qmp_eventwait("DEVICE_DELETED");
 }
+
+static void qpci_pc(void)
+{
+    qos_node_create_driver("pci-bus-pc", NULL);
+    qos_node_produces("pci-bus-pc", "pci-bus");
+}
+
+libqos_init(qpci_pc);
diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
index 491eeac756..ee381c5667 100644
--- a/tests/libqos/pci-pc.h
+++ b/tests/libqos/pci-pc.h
@@ -15,7 +15,15 @@
 
 #include "libqos/pci.h"
 #include "libqos/malloc.h"
+#include "qgraph.h"
 
+typedef struct QPCIBusPC {
+    QOSGraphObject obj;
+    QPCIBus bus;
+} QPCIBusPC;
+
+void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, int devfn);
+void qpci_set_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *alloc);
 QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
 void     qpci_free_pc(QPCIBus *bus);
 
diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 0b73cb23d0..c51c186867 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -15,6 +15,7 @@
 
 #include "hw/pci/pci_regs.h"
 #include "qemu/host-utils.h"
+#include "qgraph.h"
 
 void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
                          void (*func)(QPCIDevice *dev, int devfn, void *data),
@@ -402,3 +403,10 @@ void qpci_plug_device_test(const char *driver, const char *id,
     qtest_qmp_device_add(driver, id, "'addr': '%d'%s%s", slot,
                          opts ? ", " : "", opts ? opts : "");
 }
+
+static void qpci(void)
+{
+    qos_node_create_interface("pci-bus");
+}
+
+libqos_init(qpci);
-- 
2.17.1
