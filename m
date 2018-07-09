Received: from eggs.gnu.org ([2001:4830:134:3::10]:38410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fcSDz-0005RB-W0
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fcSDy-0007IX-Fi
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:51 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:38462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fcSDx-0007I4-Vf
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:12:50 -0400
Received: by mail-ed1-x543.google.com with SMTP id a5-v6so13346650edt.5
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 02:12:49 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  9 Jul 2018 11:11:32 +0200
Message-Id: <20180709091136.28849-4-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 3/7] tests/qgraph: sdhci driver and interface
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

Add qgraph nodes for sdhci-pci and generic-sdhci (memory mapped) drivers.
Both drivers implement (produce) the same interface sdhci, that provides the
readw - readq - writeq functions.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include |   1 +
 tests/libqos/sdhci.c   | 142 +++++++++++++++++++++++++++++++++++++++++
 tests/libqos/sdhci.h   |  68 ++++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 tests/libqos/sdhci.c
 create mode 100644 tests/libqos/sdhci.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b16bbd55df..acbf704a8a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -770,6 +770,7 @@ libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
 
 libqgraph-obj-y = tests/libqos/qgraph.o
+libqgraph-pc-obj-y = $(libqos-pc-obj-y) tests/libqos/sdhci.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
diff --git a/tests/libqos/sdhci.c b/tests/libqos/sdhci.c
new file mode 100644
index 0000000000..213c2657c3
--- /dev/null
+++ b/tests/libqos/sdhci.c
@@ -0,0 +1,142 @@
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
+#include "pci.h"
+#include "pci-pc.h"
+#include "qgraph.h"
+#include "sdhci.h"
+#include "hw/pci/pci.h"
+
+static void set_qsdhci_fields(QSDHCI *s, uint8_t version, uint8_t baseclock,
+                        bool sdma, uint64_t reg)
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
+    QSDHCI_MemoryMapped *spci = obj;
+    if (!g_strcmp0(interface, "sdhci")) {
+        return &spci->sdhci;
+    }
+    printf("%s not present in generic-sdhci\n", interface);
+    abort();
+}
+
+void qos_create_sdhci_mm(QSDHCI_MemoryMapped *sdhci, uint32_t addr,
+                            QSDHCIProperties *common)
+{
+    sdhci->obj.get_driver = sdhci_mm_get_driver;
+    sdhci->sdhci.sdhci_readw = sdhci_mm_readw;
+    sdhci->sdhci.sdhci_readq = sdhci_mm_readq;
+    sdhci->sdhci.sdhci_writeq = sdhci_mm_writeq;
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
+static uint64_t sdhci_readq(QSDHCI *s, uint32_t reg)
+{
+    QSDHCI_PCI *spci = container_of(s, QSDHCI_PCI, sdhci);
+    return qpci_io_readq(&spci->dev, spci->mem_bar, reg);
+}
+
+static void sdhci_writeq(QSDHCI *s, uint32_t reg, uint64_t val)
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
+    printf("%s not present in sdhci-pci\n", interface);
+    abort();
+}
+
+static void sdhci_destroy(QOSGraphObject *obj)
+{
+    g_free(obj);
+}
+
+static void *sdhci_pci_create(void *pci_bus, QOSGraphObject *alloc)
+{
+    QSDHCI_PCI *spci = g_new0(QSDHCI_PCI, 1);
+    QPCIBus *bus = pci_bus;
+    uint64_t barsize;
+
+    qpci_device_init(&spci->dev, bus, QPCI_DEVFN(4, 0));
+    if (bus) {
+        spci->mem_bar = qpci_iomap(&spci->dev, 0, &barsize);
+    }
+    spci->obj.get_driver = sdhci_pci_get_driver;
+    spci->obj.destructor = sdhci_destroy;
+    spci->sdhci.sdhci_readw = sdhci_pci_readw;
+    spci->sdhci.sdhci_readq = sdhci_readq;
+    spci->sdhci.sdhci_writeq = sdhci_writeq;
+    set_qsdhci_fields(&spci->sdhci, 2, 0, 1, 0x057834b4);
+    return &spci->obj;
+}
+
+static void qsdhci(void)
+{
+    qos_node_create_interface("sdhci");
+    qos_node_create_driver("generic-sdhci", NULL);
+    qos_node_produces("generic-sdhci", "sdhci");
+    qos_node_create_driver("sdhci-pci", sdhci_pci_create);
+    qos_node_produces("sdhci-pci", "sdhci");
+    qos_node_consumes_arg("sdhci-pci", "pci-bus", "addr=04.0");
+}
+
+libqos_init(qsdhci);
diff --git a/tests/libqos/sdhci.h b/tests/libqos/sdhci.h
new file mode 100644
index 0000000000..dfd043f160
--- /dev/null
+++ b/tests/libqos/sdhci.h
@@ -0,0 +1,68 @@
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
+    QOSGraphObject obj;
+    uint16_t (*sdhci_readw)(QSDHCI *s, uint32_t reg);
+    uint64_t (*sdhci_readq)(QSDHCI *s, uint32_t reg);
+    void (*sdhci_writeq)(QSDHCI *s, uint32_t reg, uint64_t val);
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
+ * qos_create_sdhci_mm(): external constructor used by all drivers/machines
+ * that "contain" a #QSDHCI_MemoryMapped driver
+ */
+void qos_create_sdhci_mm(QSDHCI_MemoryMapped *sdhci, uint32_t addr,
+                            QSDHCIProperties *common);
+
+#endif
-- 
2.17.1
