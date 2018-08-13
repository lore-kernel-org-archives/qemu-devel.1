Received: from eggs.gnu.org ([2001:4830:134:3::10]:43437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9sb-00077Z-3e
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9sZ-0001xP-Cv
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:17 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:25 +0200
Message-Id: <20180813101453.10200-6-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 05/33] tests/qgraph: sdhci driver and interface
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Add qgraph nodes for sdhci-pci and generic-sdhci (memory mapped) drivers.
Both drivers implement (produce) the same interface sdhci, that provides the
readw - readq - writeq functions.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |   1 +
 tests/libqos/sdhci.c   | 163 +++++++++++++++++++++++++++++++++++++++++
 tests/libqos/sdhci.h   |  69 +++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 tests/libqos/sdhci.c
 create mode 100644 tests/libqos/sdhci.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2154e53944..90a74854b8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -775,6 +775,7 @@ libqgraph-machines-obj-y = tests/libqos/x86_64_pc-machine.o
 
 libqgraph-pci-obj-y = $(libqos-pc-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
+libqgraph-pci-obj-y += tests/libqos/sdhci.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
diff --git a/tests/libqos/sdhci.c b/tests/libqos/sdhci.c
new file mode 100644
index 0000000000..65b407d741
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
+    return qtest_readw(global_qtest, smm->addr + reg);
+}
+
+static uint64_t sdhci_mm_readq(QSDHCI *s, uint32_t reg)
+{
+    QSDHCI_MemoryMapped *smm = container_of(s, QSDHCI_MemoryMapped, sdhci);
+    return qtest_readq(global_qtest, smm->addr + reg);
+}
+
+static void sdhci_mm_writeq(QSDHCI *s, uint32_t reg, uint64_t val)
+{
+    QSDHCI_MemoryMapped *smm = container_of(s, QSDHCI_MemoryMapped, sdhci);
+    qtest_writeq(global_qtest, smm->addr + reg, val);
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
+void qos_init_sdhci_smm(QSDHCI_MemoryMapped *sdhci, uint32_t addr,
+                       QSDHCIProperties *common)
+{
+    sdhci->obj.get_driver = sdhci_mm_get_driver;
+    sdhci->sdhci.readw = sdhci_mm_readw;
+    sdhci->sdhci.readq = sdhci_mm_readq;
+    sdhci->sdhci.writeq = sdhci_mm_writeq;
+    memcpy(&sdhci->sdhci.props, common, sizeof(QSDHCIProperties));
+    sdhci->addr = addr;
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
+    g_free(spci);
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
index 0000000000..d8d2b2eecf
--- /dev/null
+++ b/tests/libqos/sdhci.h
@@ -0,0 +1,69 @@
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
+ * qos_init_sdhci_smm(): external constructor used by all drivers/machines
+ * that "contain" a #QSDHCI_MemoryMapped driver
+ */
+void qos_init_sdhci_smm(QSDHCI_MemoryMapped *sdhci, uint32_t addr,
+                       QSDHCIProperties *common);
+
+#endif
-- 
2.17.1
