Received: from eggs.gnu.org ([2001:4830:134:3::10]:35577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgav-0004wo-Qf
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgau-0000qI-P9
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:49 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgau-0000ot-FB
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:48 -0400
Received: by mail-ed1-x541.google.com with SMTP id f23-v6so5237143edr.11
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:34:48 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:33:47 +0200
Message-Id: <20180806143412.27722-10-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 09/34] tests/qgraph: pci-spapr driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add pci-bus-spapr node, that produces pci-bus. Move QPCIBusSPAPR struct
declaration in its header (since it will be needed by other drivers)
and introduce a setter method for drivers that do not need to allocate
but have to initialize QPCIBusSPAPR.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include   |  2 +-
 tests/libqos/pci-spapr.c | 57 ++++++++++++++++++++++++----------------
 tests/libqos/pci-spapr.h | 24 +++++++++++++++++
 3 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d826a09919..5ce905bd82 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -771,7 +771,7 @@ libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virt
 libqgraph-machines-obj-y = tests/libqos/x86_64_pc-machine.o
 libqgraph-machines-obj-y += tests/libqos/raspi2-machine.o
 
-libqgraph-pci-obj-y = $(libqos-pc-obj-y)
+libqgraph-pci-obj-y = $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
 libqgraph-pci-obj-y += tests/libqos/sdhci.o
 
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index 30b6d5b5a7..108db6c9b6 100644
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
@@ -160,12 +140,23 @@ static void qpci_spapr_config_writel(QPCIBus *bus, int devfn, uint8_t offset,
 #define SPAPR_PCI_MMIO32_WIN_SIZE    0x80000000 /* 2 GiB */
 #define SPAPR_PCI_IO_WIN_SIZE        0x10000
 
-QPCIBus *qpci_spapr_new(QTestState *qts, QGuestAllocator *alloc)
+static void *qspapr_get_driver(void *obj, const char *interface)
 {
-    QPCIBusSPAPR *ret = g_new0(QPCIBusSPAPR, 1);
+    QPCIBusSPAPR *qpci = obj;
+    if (!g_strcmp0(interface, "pci-bus")) {
+        return &qpci->bus;
+    }
+    printf("%s not present in pci-bus-spapr", interface);
+    abort();
+}
 
+void qpci_init_spapr(QPCIBusSPAPR *ret, QTestState *qts, QGuestAllocator *alloc)
+{
     assert(qts);
 
+    /* tests cannot use spapr, needs to be fixed first */
+    ret->bus.has_buggy_msi = TRUE;
+
     ret->alloc = alloc;
 
     ret->bus.pio_readb = qpci_spapr_pio_readb;
@@ -208,12 +199,32 @@ QPCIBus *qpci_spapr_new(QTestState *qts, QGuestAllocator *alloc)
     ret->bus.mmio_alloc_ptr = ret->mmio32.pci_base;
     ret->bus.mmio_limit = ret->mmio32.pci_base + ret->mmio32.size;
 
+    ret->obj.get_driver = qspapr_get_driver;
+}
+
+QPCIBus *qpci_spapr_new(QTestState *qts, QGuestAllocator *alloc)
+{
+    QPCIBusSPAPR *ret = g_new0(QPCIBusSPAPR, 1);
+    qpci_init_spapr(ret, qts, alloc);
+
     return &ret->bus;
 }
 
 void qpci_free_spapr(QPCIBus *bus)
 {
+    if (!bus) {
+        return;
+    }
+
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
 
     g_free(s);
 }
+
+static void qpci_spapr(void)
+{
+    qos_node_create_driver("pci-bus-spapr", NULL);
+    qos_node_produces("pci-bus-spapr", "pci-bus");
+}
+
+libqos_init(qpci_spapr);
diff --git a/tests/libqos/pci-spapr.h b/tests/libqos/pci-spapr.h
index d5305d16f8..74cd183c9a 100644
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
 QPCIBus *qpci_spapr_new(QTestState *qts, QGuestAllocator *alloc);
 void     qpci_free_spapr(QPCIBus *bus);
 
-- 
2.17.1
