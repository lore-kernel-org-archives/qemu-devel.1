Received: from eggs.gnu.org ([209.51.188.92]:39267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqX-0002tD-GC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqV-0007tD-W0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:17 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:35869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqV-0007sN-Ky
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:15 -0500
Received: by mail-wr1-x42c.google.com with SMTP id o17so18418897wrw.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:15 +0100
Message-Id: <1551979804-6060-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/57] tests/libqos: sdhci driver and interface
 nodes
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

Add qgraph nodes for sdhci-pci and generic-sdhci (memory mapped) drivers.
Both drivers implement (produce) the same interface sdhci, that provides the
readw - readq - writeq functions.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |   1 +
 tests/libqos/sdhci.c   | 163 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/libqos/sdhci.h   |  70 +++++++++++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 tests/libqos/sdhci.c
 create mode 100644 tests/libqos/sdhci.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8a760bd..b1b03e6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -752,6 +752,7 @@ libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virt
 # Devices
 qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y += $(libqos-pc-obj-y)
+qos-test-obj-y += tests/libqos/sdhci.o
 
 # Machines
 qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
diff --git a/tests/libqos/sdhci.c b/tests/libqos/sdhci.c
new file mode 100644
index 0000000..22c33de
--- /dev/null
+++ b/tests/libqos/sdhci.c
@@ -0,0 +1,163 @@
+/*
+ * libqos driver framework
+ *
+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "pci.h"
+#include "sdhci.h"
+#include "hw/pci/pci.h"
+
+static void set_qsdhci_fields(QSDHCI *s, uint8_t version, uint8_t baseclock,
+                              bool sdma, uint64_t reg)
+{
+    s->props.version = version;
+    s->props.baseclock = baseclock;
+    s->props.capab.sdma = sdma;
+    s->props.capab.reg = reg;
+}
+
+/* Memory mapped implementation of QSDHCI */
+
+static uint16_t sdhci_mm_readw(QSDHCI *s, uint32_t reg)
+{
+    QSDHCI_MemoryMapped *smm = container_of(s, QSDHCI_MemoryMapped, sdhci);
+    return qtest_readw(smm->qts, smm->addr + reg);
+}
+
+static uint64_t sdhci_mm_readq(QSDHCI *s, uint32_t reg)
+{
+    QSDHCI_MemoryMapped *smm = container_of(s, QSDHCI_MemoryMapped, sdhci);
+    return qtest_readq(smm->qts, smm->addr + reg);
+}
+
+static void sdhci_mm_writeq(QSDHCI *s, uint32_t reg, uint64_t val)
+{
+    QSDHCI_MemoryMapped *smm = container_of(s, QSDHCI_MemoryMapped, sdhci);
+    qtest_writeq(smm->qts, smm->addr + reg, val);
+}
+
+static void *sdhci_mm_get_driver(void *obj, const char *interface)
+{
+    QSDHCI_MemoryMapped *smm = obj;
+    if (!g_strcmp0(interface, "sdhci")) {
+        return &smm->sdhci;
+    }
+    fprintf(stderr, "%s not present in generic-sdhci\n", interface);
+    g_assert_not_reached();
+}
+
+void qos_init_sdhci_mm(QSDHCI_MemoryMapped *sdhci, QTestState *qts,
+                       uint32_t addr, QSDHCIProperties *common)
+{
+    sdhci->obj.get_driver = sdhci_mm_get_driver;
+    sdhci->sdhci.readw = sdhci_mm_readw;
+    sdhci->sdhci.readq = sdhci_mm_readq;
+    sdhci->sdhci.writeq = sdhci_mm_writeq;
+    memcpy(&sdhci->sdhci.props, common, sizeof(QSDHCIProperties));
+    sdhci->addr = addr;
+    sdhci->qts = qts;
+}
+
+/* PCI implementation of QSDHCI */
+
+static uint16_t sdhci_pci_readw(QSDHCI *s, uint32_t reg)
+{
+    QSDHCI_PCI *spci = container_of(s, QSDHCI_PCI, sdhci);
+    return qpci_io_readw(&spci->dev, spci->mem_bar, reg);
+}
+
+static uint64_t sdhci_pci_readq(QSDHCI *s, uint32_t reg)
+{
+    QSDHCI_PCI *spci = container_of(s, QSDHCI_PCI, sdhci);
+    return qpci_io_readq(&spci->dev, spci->mem_bar, reg);
+}
+
+static void sdhci_pci_writeq(QSDHCI *s, uint32_t reg, uint64_t val)
+{
+    QSDHCI_PCI *spci = container_of(s, QSDHCI_PCI, sdhci);
+    return qpci_io_writeq(&spci->dev, spci->mem_bar, reg, val);
+}
+
+static void *sdhci_pci_get_driver(void *object, const char *interface)
+{
+    QSDHCI_PCI *spci = object;
+    if (!g_strcmp0(interface, "sdhci")) {
+        return &spci->sdhci;
+    }
+
+    fprintf(stderr, "%s not present in sdhci-pci\n", interface);
+    g_assert_not_reached();
+}
+
+static void sdhci_pci_start_hw(QOSGraphObject *obj)
+{
+    QSDHCI_PCI *spci = (QSDHCI_PCI *)obj;
+    qpci_device_enable(&spci->dev);
+}
+
+static void sdhci_destructor(QOSGraphObject *obj)
+{
+    QSDHCI_PCI *spci = (QSDHCI_PCI *)obj;
+    qpci_iounmap(&spci->dev, spci->mem_bar);
+}
+
+static void *sdhci_pci_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
+{
+    QSDHCI_PCI *spci = g_new0(QSDHCI_PCI, 1);
+    QPCIBus *bus = pci_bus;
+    uint64_t barsize;
+
+    qpci_device_init(&spci->dev, bus, addr);
+    spci->mem_bar = qpci_iomap(&spci->dev, 0, &barsize);
+    spci->sdhci.readw = sdhci_pci_readw;
+    spci->sdhci.readq = sdhci_pci_readq;
+    spci->sdhci.writeq = sdhci_pci_writeq;
+    set_qsdhci_fields(&spci->sdhci, 2, 0, 1, 0x057834b4);
+
+    spci->obj.get_driver = sdhci_pci_get_driver;
+    spci->obj.start_hw = sdhci_pci_start_hw;
+    spci->obj.destructor = sdhci_destructor;
+    return &spci->obj;
+}
+
+static void qsdhci_register_nodes(void)
+{
+    QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(4, 0),
+        .vendor_id = PCI_VENDOR_ID_REDHAT,
+        .device_id = PCI_DEVICE_ID_REDHAT_SDHCI,
+    };
+
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
+
+    /* generic-sdhci */
+    qos_node_create_driver("generic-sdhci", NULL);
+    qos_node_produces("generic-sdhci", "sdhci");
+
+    /* sdhci-pci */
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("sdhci-pci", sdhci_pci_create);
+    qos_node_produces("sdhci-pci", "sdhci");
+    qos_node_consumes("sdhci-pci", "pci-bus", &opts);
+
+}
+
+libqos_init(qsdhci_register_nodes);
diff --git a/tests/libqos/sdhci.h b/tests/libqos/sdhci.h
new file mode 100644
index 0000000..032d815
--- /dev/null
+++ b/tests/libqos/sdhci.h
@@ -0,0 +1,70 @@
+/*
+ * libqos driver framework
+ *
+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#ifndef QGRAPH_QSDHCI
+#define QGRAPH_QSDHCI
+
+#include "libqos/qgraph.h"
+#include "pci.h"
+
+typedef struct QSDHCI QSDHCI;
+typedef struct QSDHCI_MemoryMapped QSDHCI_MemoryMapped;
+typedef struct QSDHCI_PCI  QSDHCI_PCI;
+typedef struct QSDHCIProperties QSDHCIProperties;
+
+/* Properties common to all QSDHCI devices */
+struct QSDHCIProperties {
+    uint8_t version;
+    uint8_t baseclock;
+    struct {
+        bool sdma;
+        uint64_t reg;
+    } capab;
+};
+
+struct QSDHCI {
+    uint16_t (*readw)(QSDHCI *s, uint32_t reg);
+    uint64_t (*readq)(QSDHCI *s, uint32_t reg);
+    void (*writeq)(QSDHCI *s, uint32_t reg, uint64_t val);
+    QSDHCIProperties props;
+};
+
+/* Memory Mapped implementation of QSDHCI */
+struct QSDHCI_MemoryMapped {
+    QOSGraphObject obj;
+    QTestState *qts;
+    QSDHCI sdhci;
+    uint64_t addr;
+};
+
+/* PCI implementation of QSDHCI */
+struct QSDHCI_PCI {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+    QSDHCI sdhci;
+    QPCIBar mem_bar;
+};
+
+/**
+ * qos_init_sdhci_mm(): external constructor used by all drivers/machines
+ * that "contain" a #QSDHCI_MemoryMapped driver
+ */
+void qos_init_sdhci_mm(QSDHCI_MemoryMapped *sdhci, QTestState *qts,
+                       uint32_t addr, QSDHCIProperties *common);
+
+#endif
-- 
1.8.3.1
