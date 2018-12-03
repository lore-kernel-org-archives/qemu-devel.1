Received: from eggs.gnu.org ([2001:4830:134:3::10]:51787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEb-0008Oz-JQ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEU-0004RW-RE
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEU-0004Qd-J7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:02 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:33 +0100
Message-Id: <1543851204-41186-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 20/71] tests/libqos: pci-pc driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add pci-bus-pc node, move QPCIBusPC struct declaration in its header
(since it will be needed by other drivers) and introduce a setter method
for drivers that do not need to allocate but have to initialize QPCIBusPC.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  6 +++-
 tests/libqos/pci-pc.c  | 83 ++++++++++++++++++++++++++++++++------------------
 tests/libqos/pci-pc.h  | 17 +++++++++--
 tests/libqos/pci.c     | 32 +++++++++++++++++--
 tests/libqos/pci.h     | 12 ++++++++
 5 files changed, 115 insertions(+), 35 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 905841e..93f31e8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -675,11 +675,15 @@ libqos-imx-obj-y = $(libqos-obj-y) tests/libqos/i2c-imx.o
 libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o
 
+# Devices
+qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
+qos-test-obj-y += $(libqos-pc-obj-y)
+
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
 
 check-qtest-generic-y += tests/qos-test$(EXESUF)
-tests/qos-test$(EXESUF): tests/qos-test.o $(libqgraph-obj-y)
+tests/qos-test$(EXESUF): $(qos-test-obj-y)
 
 tests/qmp-test$(EXESUF): tests/qmp-test.o
 tests/qmp-cmd-test$(EXESUF): tests/qmp-cmd-test.o
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index d21f3e8..041bfed 100644
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
@@ -115,44 +109,65 @@ static void qpci_pc_config_writel(QPCIBus *bus, int devfn, uint8_t offset, uint3
     outl(0xcfc, value);
 }
 
-QPCIBus *qpci_new_pc(QTestState *qts, QGuestAllocator *alloc)
+static void *qpci_pc_get_driver(void *obj, const char *interface)
 {
-    QPCIBusPC *ret = g_new0(QPCIBusPC, 1);
+    QPCIBusPC *qpci = obj;
+    if (!g_strcmp0(interface, "pci-bus")) {
+        return &qpci->bus;
+    }
+    fprintf(stderr, "%s not present in pci-bus-pc\n", interface);
+    g_assert_not_reached();
+}
 
+void qpci_init_pc(QPCIBusPC *qpci, QTestState *qts, QGuestAllocator *alloc)
+{
     assert(qts);
 
-    ret->bus.pio_readb = qpci_pc_pio_readb;
-    ret->bus.pio_readw = qpci_pc_pio_readw;
-    ret->bus.pio_readl = qpci_pc_pio_readl;
-    ret->bus.pio_readq = qpci_pc_pio_readq;
+    qpci->bus.pio_readb = qpci_pc_pio_readb;
+    qpci->bus.pio_readw = qpci_pc_pio_readw;
+    qpci->bus.pio_readl = qpci_pc_pio_readl;
+    qpci->bus.pio_readq = qpci_pc_pio_readq;
+
+    qpci->bus.pio_writeb = qpci_pc_pio_writeb;
+    qpci->bus.pio_writew = qpci_pc_pio_writew;
+    qpci->bus.pio_writel = qpci_pc_pio_writel;
+    qpci->bus.pio_writeq = qpci_pc_pio_writeq;
+
+    qpci->bus.memread = qpci_pc_memread;
+    qpci->bus.memwrite = qpci_pc_memwrite;
 
-    ret->bus.pio_writeb = qpci_pc_pio_writeb;
-    ret->bus.pio_writew = qpci_pc_pio_writew;
-    ret->bus.pio_writel = qpci_pc_pio_writel;
-    ret->bus.pio_writeq = qpci_pc_pio_writeq;
+    qpci->bus.config_readb = qpci_pc_config_readb;
+    qpci->bus.config_readw = qpci_pc_config_readw;
+    qpci->bus.config_readl = qpci_pc_config_readl;
 
-    ret->bus.memread = qpci_pc_memread;
-    ret->bus.memwrite = qpci_pc_memwrite;
+    qpci->bus.config_writeb = qpci_pc_config_writeb;
+    qpci->bus.config_writew = qpci_pc_config_writew;
+    qpci->bus.config_writel = qpci_pc_config_writel;
 
-    ret->bus.config_readb = qpci_pc_config_readb;
-    ret->bus.config_readw = qpci_pc_config_readw;
-    ret->bus.config_readl = qpci_pc_config_readl;
+    qpci->bus.qts = qts;
+    qpci->bus.pio_alloc_ptr = 0xc000;
+    qpci->bus.mmio_alloc_ptr = 0xE0000000;
+    qpci->bus.mmio_limit = 0x100000000ULL;
 
-    ret->bus.config_writeb = qpci_pc_config_writeb;
-    ret->bus.config_writew = qpci_pc_config_writew;
-    ret->bus.config_writel = qpci_pc_config_writel;
+    qpci->obj.get_driver = qpci_pc_get_driver;
+}
 
-    ret->bus.qts = qts;
-    ret->bus.pio_alloc_ptr = 0xc000;
-    ret->bus.mmio_alloc_ptr = 0xE0000000;
-    ret->bus.mmio_limit = 0x100000000ULL;
+QPCIBus *qpci_new_pc(QTestState *qts, QGuestAllocator *alloc)
+{
+    QPCIBusPC *qpci = g_new0(QPCIBusPC, 1);
+    qpci_init_pc(qpci, qts, alloc);
 
-    return &ret->bus;
+    return &qpci->bus;
 }
 
 void qpci_free_pc(QPCIBus *bus)
 {
-    QPCIBusPC *s = container_of(bus, QPCIBusPC, bus);
+    QPCIBusPC *s;
+
+    if (!bus) {
+        return;
+    }
+    s = container_of(bus, QPCIBusPC, bus);
 
     g_free(s);
 }
@@ -171,3 +186,11 @@ void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
 
     qmp_eventwait("DEVICE_DELETED");
 }
+
+static void qpci_pc_register_nodes(void)
+{
+    qos_node_create_driver("pci-bus-pc", NULL);
+    qos_node_produces("pci-bus-pc", "pci-bus");
+}
+
+libqos_init(qpci_pc_register_nodes);
diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
index 84cc300..7b0751d 100644
--- a/tests/libqos/pci-pc.h
+++ b/tests/libqos/pci-pc.h
@@ -15,9 +15,22 @@
 
 #include "libqos/pci.h"
 #include "libqos/malloc.h"
+#include "libqos/qgraph.h"
 
-/* qpci_new_pc():
-* this function creates a new QPCIBusPC object,
+typedef struct QPCIBusPC {
+    QOSGraphObject obj;
+    QPCIBus bus;
+} QPCIBusPC;
+
+/* qpci_init_pc():
+ * this function initialize an already allocated
+ * QPCIBusPC object.
+ *
+ * @ret must be a valid QPCIBusPC * pointer.
+ */
+void qpci_init_pc(QPCIBusPC *ret, QTestState *qts, QGuestAllocator *alloc);
+/* qpci_pc_new():
+ * this function creates a new QPCIBusPC object,
  * and properly initialize its fields.
  *
  * returns the QPCIBus *bus field of a newly
diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index e8c342c..8257904 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -15,6 +15,7 @@
 
 #include "hw/pci/pci_regs.h"
 #include "qemu/host-utils.h"
+#include "libqos/qgraph.h"
 
 void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
                          void (*func)(QPCIDevice *dev, int devfn, void *data),
@@ -50,13 +51,20 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
     }
 }
 
+static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
+{
+    g_assert(dev);
+
+    dev->bus = bus;
+    dev->devfn = devfn;
+}
+
 QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
 {
     QPCIDevice *dev;
 
     dev = g_malloc0(sizeof(*dev));
-    dev->bus = bus;
-    dev->devfn = devfn;
+    qpci_device_set(dev, bus, devfn);
 
     if (qpci_config_readw(dev, PCI_VENDOR_ID) == 0xFFFF) {
         g_free(dev);
@@ -66,6 +74,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
     return dev;
 }
 
+void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
+{
+    uint16_t vendor_id, device_id;
+
+    qpci_device_set(dev, bus, addr->devfn);
+    vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
+    device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
+    g_assert(!addr->vendor_id || vendor_id == addr->vendor_id);
+    g_assert(!addr->device_id || device_id == addr->device_id);
+}
+
 void qpci_device_enable(QPCIDevice *dev)
 {
     uint16_t cmd;
@@ -395,3 +414,12 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
     QPCIBar bar = { .addr = addr };
     return bar;
 }
+
+void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
+{
+    g_assert(addr);
+    g_assert(opts);
+
+    opts->arg = addr;
+    opts->size_arg = sizeof(QPCIAddress);
+}
diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index 0b7e936..9fd521a 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -14,6 +14,7 @@
 #define LIBQOS_PCI_H
 
 #include "libqtest.h"
+#include "libqos/qgraph.h"
 
 #define QPCI_PIO_LIMIT    0x10000
 
@@ -22,6 +23,7 @@
 typedef struct QPCIDevice QPCIDevice;
 typedef struct QPCIBus QPCIBus;
 typedef struct QPCIBar QPCIBar;
+typedef struct QPCIAddress QPCIAddress;
 
 struct QPCIBus {
     uint8_t (*pio_readb)(QPCIBus *bus, uint32_t addr);
@@ -51,6 +53,7 @@ struct QPCIBus {
     QTestState *qts;
     uint16_t pio_alloc_ptr;
     uint64_t mmio_alloc_ptr, mmio_limit;
+
 };
 
 struct QPCIBar {
@@ -66,10 +69,17 @@ struct QPCIDevice
     uint64_t msix_table_off, msix_pba_off;
 };
 
+struct QPCIAddress {
+    uint32_t devfn;
+    uint16_t vendor_id;
+    uint16_t device_id;
+};
+
 void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
                          void (*func)(QPCIDevice *dev, int devfn, void *data),
                          void *data);
 QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn);
+void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr);
 
 void qpci_device_enable(QPCIDevice *dev);
 uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id);
@@ -110,4 +120,6 @@ void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
 
 void qpci_unplug_acpi_device_test(const char *id, uint8_t slot);
+
+void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr);
 #endif
-- 
1.8.3.1
