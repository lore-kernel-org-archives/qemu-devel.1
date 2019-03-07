Received: from eggs.gnu.org ([209.51.188.92]:39427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqg-00033C-F4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqf-00080t-9y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:26 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqf-000800-05
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:25 -0500
Received: by mail-wr1-x443.google.com with SMTP id g12so18405556wrm.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:23 +0100
Message-Id: <1551979804-6060-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/57] tests/libqos: pci-spapr driver and
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
Cc: thuth@redhat.com, lviver@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add pci-bus-spapr node, that produces pci-bus. Move QPCIBusSPAPR struct
declaration in its header (since it will be needed by other drivers)
and introduce a setter method for drivers that do not need to allocate
but have to initialize QPCIBusSPAPR.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include   |   2 +-
 tests/libqos/pci-spapr.c | 116 +++++++++++++++++++++++++----------------------
 tests/libqos/pci-spapr.h |  24 ++++++++++
 3 files changed, 88 insertions(+), 54 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4391b7f..37ca530 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -748,7 +748,7 @@ libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virt
 
 # Devices
 qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
-qos-test-obj-y += $(libqos-pc-obj-y)
+qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 qos-test-obj-y += tests/libqos/sdhci.o
 
 # Machines
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index 59679f6..d9b87a7 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -9,33 +9,13 @@
 #include "libqtest.h"
 #include "libqos/pci-spapr.h"
 #include "libqos/rtas.h"
+#include "libqos/qgraph.h"
 
 #include "hw/pci/pci_regs.h"
 
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
 
-
-/* From include/hw/pci-host/spapr.h */
-
-typedef struct QPCIWindow {
-    uint64_t pci_base;    /* window address in PCI space */
-    uint64_t size;        /* window size */
-} QPCIWindow;
-
-typedef struct QPCIBusSPAPR {
-    QPCIBus bus;
-    QGuestAllocator *alloc;
-
-    uint64_t buid;
-
-    uint64_t pio_cpu_base;
-    QPCIWindow pio;
-
-    uint64_t mmio32_cpu_base;
-    QPCIWindow mmio32;
-} QPCIBusSPAPR;
-
 /*
  * PCI devices are always little-endian
  * SPAPR by default is big-endian
@@ -160,60 +140,90 @@ static void qpci_spapr_config_writel(QPCIBus *bus, int devfn, uint8_t offset,
 #define SPAPR_PCI_MMIO32_WIN_SIZE    0x80000000 /* 2 GiB */
 #define SPAPR_PCI_IO_WIN_SIZE        0x10000
 
-QPCIBus *qpci_new_spapr(QTestState *qts, QGuestAllocator *alloc)
+static void *qpci_spapr_get_driver(void *obj, const char *interface)
 {
-    QPCIBusSPAPR *ret = g_new0(QPCIBusSPAPR, 1);
+    QPCIBusSPAPR *qpci = obj;
+    if (!g_strcmp0(interface, "pci-bus")) {
+        return &qpci->bus;
+    }
+    fprintf(stderr, "%s not present in pci-bus-spapr", interface);
+    g_assert_not_reached();
+}
 
+void qpci_init_spapr(QPCIBusSPAPR *qpci, QTestState *qts,
+                     QGuestAllocator *alloc)
+{
     assert(qts);
 
-    ret->alloc = alloc;
+    qpci->alloc = alloc;
 
-    ret->bus.pio_readb = qpci_spapr_pio_readb;
-    ret->bus.pio_readw = qpci_spapr_pio_readw;
-    ret->bus.pio_readl = qpci_spapr_pio_readl;
-    ret->bus.pio_readq = qpci_spapr_pio_readq;
+    qpci->bus.pio_readb = qpci_spapr_pio_readb;
+    qpci->bus.pio_readw = qpci_spapr_pio_readw;
+    qpci->bus.pio_readl = qpci_spapr_pio_readl;
+    qpci->bus.pio_readq = qpci_spapr_pio_readq;
 
-    ret->bus.pio_writeb = qpci_spapr_pio_writeb;
-    ret->bus.pio_writew = qpci_spapr_pio_writew;
-    ret->bus.pio_writel = qpci_spapr_pio_writel;
-    ret->bus.pio_writeq = qpci_spapr_pio_writeq;
+    qpci->bus.pio_writeb = qpci_spapr_pio_writeb;
+    qpci->bus.pio_writew = qpci_spapr_pio_writew;
+    qpci->bus.pio_writel = qpci_spapr_pio_writel;
+    qpci->bus.pio_writeq = qpci_spapr_pio_writeq;
 
-    ret->bus.memread = qpci_spapr_memread;
-    ret->bus.memwrite = qpci_spapr_memwrite;
+    qpci->bus.memread = qpci_spapr_memread;
+    qpci->bus.memwrite = qpci_spapr_memwrite;
 
-    ret->bus.config_readb = qpci_spapr_config_readb;
-    ret->bus.config_readw = qpci_spapr_config_readw;
-    ret->bus.config_readl = qpci_spapr_config_readl;
+    qpci->bus.config_readb = qpci_spapr_config_readb;
+    qpci->bus.config_readw = qpci_spapr_config_readw;
+    qpci->bus.config_readl = qpci_spapr_config_readl;
 
-    ret->bus.config_writeb = qpci_spapr_config_writeb;
-    ret->bus.config_writew = qpci_spapr_config_writew;
-    ret->bus.config_writel = qpci_spapr_config_writel;
+    qpci->bus.config_writeb = qpci_spapr_config_writeb;
+    qpci->bus.config_writew = qpci_spapr_config_writew;
+    qpci->bus.config_writel = qpci_spapr_config_writel;
 
     /* FIXME: We assume the default location of the PHB for now.
      * Ideally we'd parse the device tree deposited in the guest to
      * get the window locations */
-    ret->buid = 0x800000020000000ULL;
+    qpci->buid = 0x800000020000000ULL;
 
-    ret->pio_cpu_base = SPAPR_PCI_BASE;
-    ret->pio.pci_base = 0;
-    ret->pio.size = SPAPR_PCI_IO_WIN_SIZE;
+    qpci->pio_cpu_base = SPAPR_PCI_BASE;
+    qpci->pio.pci_base = 0;
+    qpci->pio.size = SPAPR_PCI_IO_WIN_SIZE;
 
     /* 32-bit portion of the MMIO window is at PCI address 2..4 GiB */
-    ret->mmio32_cpu_base = SPAPR_PCI_BASE;
-    ret->mmio32.pci_base = SPAPR_PCI_MMIO32_WIN_SIZE;
-    ret->mmio32.size = SPAPR_PCI_MMIO32_WIN_SIZE;
+    qpci->mmio32_cpu_base = SPAPR_PCI_BASE;
+    qpci->mmio32.pci_base = SPAPR_PCI_MMIO32_WIN_SIZE;
+    qpci->mmio32.size = SPAPR_PCI_MMIO32_WIN_SIZE;
 
-    ret->bus.qts = qts;
-    ret->bus.pio_alloc_ptr = 0xc000;
-    ret->bus.mmio_alloc_ptr = ret->mmio32.pci_base;
-    ret->bus.mmio_limit = ret->mmio32.pci_base + ret->mmio32.size;
+    qpci->bus.qts = qts;
+    qpci->bus.pio_alloc_ptr = 0xc000;
+    qpci->bus.mmio_alloc_ptr = qpci->mmio32.pci_base;
+    qpci->bus.mmio_limit = qpci->mmio32.pci_base + qpci->mmio32.size;
 
-    return &ret->bus;
+    qpci->obj.get_driver = qpci_spapr_get_driver;
+}
+
+QPCIBus *qpci_new_spapr(QTestState *qts, QGuestAllocator *alloc)
+{
+    QPCIBusSPAPR *qpci = g_new0(QPCIBusSPAPR, 1);
+    qpci_init_spapr(qpci, qts, alloc);
+
+    return &qpci->bus;
 }
 
 void qpci_free_spapr(QPCIBus *bus)
 {
-    QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
+    QPCIBusSPAPR *s;
+
+    if (!bus) {
+        return;
+    }
+    s = container_of(bus, QPCIBusSPAPR, bus);
 
     g_free(s);
 }
+
+static void qpci_spapr_register_nodes(void)
+{
+    qos_node_create_driver("pci-bus-spapr", NULL);
+    qos_node_produces("pci-bus-spapr", "pci-bus");
+}
+
+libqos_init(qpci_spapr_register_nodes);
diff --git a/tests/libqos/pci-spapr.h b/tests/libqos/pci-spapr.h
index 177e8c0..d9e2563 100644
--- a/tests/libqos/pci-spapr.h
+++ b/tests/libqos/pci-spapr.h
@@ -10,7 +10,31 @@
 
 #include "libqos/malloc.h"
 #include "libqos/pci.h"
+#include "libqos/qgraph.h"
 
+/* From include/hw/pci-host/spapr.h */
+
+typedef struct QPCIWindow {
+    uint64_t pci_base;    /* window address in PCI space */
+    uint64_t size;        /* window size */
+} QPCIWindow;
+
+typedef struct QPCIBusSPAPR {
+    QOSGraphObject obj;
+    QPCIBus bus;
+    QGuestAllocator *alloc;
+
+    uint64_t buid;
+
+    uint64_t pio_cpu_base;
+    QPCIWindow pio;
+
+    uint64_t mmio32_cpu_base;
+    QPCIWindow mmio32;
+} QPCIBusSPAPR;
+
+void qpci_init_spapr(QPCIBusSPAPR *ret, QTestState *qts,
+                     QGuestAllocator *alloc);
 QPCIBus *qpci_new_spapr(QTestState *qts, QGuestAllocator *alloc);
 void     qpci_free_spapr(QPCIBus *bus);
 
-- 
1.8.3.1
