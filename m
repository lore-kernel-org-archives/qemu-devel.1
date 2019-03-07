Received: from eggs.gnu.org ([209.51.188.92]:59827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLv-0002AJ-6k
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLt-0005Am-RE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLt-0005A8-HU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:01 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:50 -0800
Message-Id: <20190307072151.8830-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 16/37] multi-process: Add LSI
 device proxy object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org

From: Jagannathan Raman <jag.raman@oracle.com>

Adds proxy-lsi53c895a object, as a derivative of the pci-proxy-dev
object. This object is the proxy for the lsi53c895a object
instantiated by the remote process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hw/proxy/Makefile.objs              |   1 +
 hw/proxy/proxy-lsi53c895a.c         | 162 ++++++++++++++++++++++++++++++++++++
 include/hw/proxy/proxy-lsi53c895a.h |  42 ++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 hw/proxy/proxy-lsi53c895a.c
 create mode 100644 include/hw/proxy/proxy-lsi53c895a.h

diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
index eb81624..f562f5a 100644
--- a/hw/proxy/Makefile.objs
+++ b/hw/proxy/Makefile.objs
@@ -1 +1,2 @@
 common-obj-$(CONFIG_MPQEMU) += qemu-proxy.o
+common-obj-$(CONFIG_MPQEMU) += proxy-lsi53c895a.o
diff --git a/hw/proxy/proxy-lsi53c895a.c b/hw/proxy/proxy-lsi53c895a.c
new file mode 100644
index 0000000..9a9eb52
--- /dev/null
+++ b/hw/proxy/proxy-lsi53c895a.c
@@ -0,0 +1,162 @@
+/*
+ * Copyright 2019, Oracle and/or its affiliates. All rights reserved.
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
+
+#include <sys/types.h>
+
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+#include "qemu/bitops.h"
+#include "hw/pci/pci.h"
+#include "hw/proxy/qemu-proxy.h"
+#include "hw/proxy/proxy-lsi53c895a.h"
+#include "exec/memory.h"
+
+static uint64_t proxy_lsi_io_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    return proxy_default_bar_read(PCI_PROXY_DEV(s), &s->io_io, addr, size,
+                                  false);
+}
+
+static void proxy_lsi_io_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    proxy_default_bar_write(PCI_PROXY_DEV(s), &s->io_io, addr, val, size,
+                            false);
+}
+
+static const MemoryRegionOps proxy_lsi_io_ops = {
+    .read = proxy_lsi_io_read,
+    .write = proxy_lsi_io_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static uint64_t proxy_lsi_ram_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    return proxy_default_bar_read(PCI_PROXY_DEV(s), &s->ram_io, addr, size,
+                                  true);
+}
+
+static void proxy_lsi_ram_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    proxy_default_bar_write(PCI_PROXY_DEV(s), &s->ram_io, addr, val, size,
+                            true);
+}
+
+static const MemoryRegionOps proxy_lsi_ram_ops = {
+    .read = proxy_lsi_ram_read,
+    .write = proxy_lsi_ram_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static uint64_t proxy_lsi_mmio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    return proxy_default_bar_read(PCI_PROXY_DEV(s), &s->mmio_io, addr, size,
+                                  true);
+}
+
+static void proxy_lsi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
+                                 unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    proxy_default_bar_write(PCI_PROXY_DEV(s), &s->mmio_io, addr, val, size,
+                            true);
+}
+
+static const MemoryRegionOps proxy_lsi_mmio_ops = {
+    .read = proxy_lsi_mmio_read,
+    .write = proxy_lsi_mmio_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void proxy_lsi_realize(PCIProxyDev *dev, Error **errp)
+{
+    ProxyLSIState *s = LSI_PROXY_DEV(dev);
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    uint8_t *pci_conf = pci_dev->config;
+
+    pci_conf[PCI_LATENCY_TIMER] = 0xff;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01;
+
+    memory_region_init_io(&s->mmio_io, OBJECT(s), &proxy_lsi_mmio_ops, s,
+                          "proxy-lsi-mmio", 0x400);
+    memory_region_init_io(&s->ram_io, OBJECT(s), &proxy_lsi_ram_ops, s,
+                          "proxy-lsi-ram", 0x2000);
+    memory_region_init_io(&s->io_io, OBJECT(s), &proxy_lsi_io_ops, s,
+                          "proxy-lsi-io", 256);
+
+    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io_io);
+    pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio_io);
+    pci_register_bar(pci_dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->ram_io);
+}
+
+static void proxy_lsi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pci_class = PCI_DEVICE_CLASS(klass);
+    PCIProxyDevClass *proxy_class = PCI_PROXY_DEV_CLASS(klass);
+
+    proxy_class->realize = proxy_lsi_realize;
+    proxy_class->command = g_strdup("qemu-scsi-dev");
+
+    pci_class->vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
+    pci_class->device_id = PCI_DEVICE_ID_LSI_53C895A;
+    pci_class->class_id = PCI_CLASS_STORAGE_SCSI;
+    pci_class->subsystem_id = 0x1000;
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    dc->desc = "LSI Proxy Device";
+}
+
+static const TypeInfo lsi_proxy_dev_type_info = {
+    .name          = TYPE_PROXY_LSI53C895A,
+    .parent        = TYPE_PCI_PROXY_DEV,
+    .instance_size = sizeof(ProxyLSIState),
+    .class_init    = proxy_lsi_class_init,
+};
+
+static void lsi_proxy_dev_register_types(void)
+{
+    type_register_static(&lsi_proxy_dev_type_info);
+}
+
+type_init(lsi_proxy_dev_register_types)
diff --git a/include/hw/proxy/proxy-lsi53c895a.h b/include/hw/proxy/proxy-lsi53c895a.h
new file mode 100644
index 0000000..6368a4e
--- /dev/null
+++ b/include/hw/proxy/proxy-lsi53c895a.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2019, Oracle and/or its affiliates. All rights reserved.
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
+
+#ifndef LSI_PROXY_H
+#define LSI_PROXY_H
+
+#include "hw/proxy/qemu-proxy.h"
+
+#define TYPE_PROXY_LSI53C895A "proxy-lsi53c895a"
+
+#define LSI_PROXY_DEV(obj) \
+            OBJECT_CHECK(ProxyLSIState, (obj), TYPE_PROXY_LSI53C895A)
+
+typedef struct ProxyLSIState {
+    PCIProxyDev parent_dev;
+
+    MemoryRegion mmio_io;
+    MemoryRegion ram_io;
+    MemoryRegion io_io;
+
+} ProxyLSIState;
+
+#endif
-- 
1.8.3.1
