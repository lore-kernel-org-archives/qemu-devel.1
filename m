Received: from eggs.gnu.org ([209.51.188.92]:59597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLR-0001o9-B4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLQ-0004sg-5R
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLP-0004r5-Rq
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:32 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:17 -0800
Message-Id: <20190307072117.8474-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 09/37] multi-process: setup
 PCI host bridge for remote device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, mst@redhat.com, marcel.apfelbaum@gmail.com

From: Jagannathan Raman <jag.raman@oracle.com>

PCI host bridge is setup for the remote device process. It is
implemented using remote-pcihost object. It is an extension of the PCI
host bridge setup by QEMU.
Remote-pcihost configures a PCI bus which could be used by the remote
 PCI device to latch on to.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hw/pci/Makefile.objs     |  2 +-
 include/remote/pcihost.h | 58 +++++++++++++++++++++++++++++++++
 remote/Makefile.objs     |  1 +
 remote/pcihost.c         | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 include/remote/pcihost.h
 create mode 100644 remote/pcihost.c

diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index f62025c..ad50634 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -8,6 +8,6 @@ common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
 
-remote-pci-obj-$(CONFIG_MPQEMU) += pci.o pci_bridge.o
+remote-pci-obj-$(CONFIG_MPQEMU) += pci.o pci_bridge.o pci_host.o pcie_host.o
 remote-pci-obj-$(CONFIG_MPQEMU) += msi.o msix.o
 remote-pci-obj-$(CONFIG_MPQEMU) += pcie.o
diff --git a/include/remote/pcihost.h b/include/remote/pcihost.h
new file mode 100644
index 0000000..4a40f04
--- /dev/null
+++ b/include/remote/pcihost.h
@@ -0,0 +1,58 @@
+/*
+ * PCI Host for remote device
+ *
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
+#ifndef REMOTE_PCIHOST_H
+#define REMOTE_PCIHOST_H
+
+#include <stddef.h>
+#include <stdint.h>
+
+#include "exec/memory.h"
+#include "hw/pci/pcie_host.h"
+
+#define TYPE_REMOTE_HOST_DEVICE "remote-pcihost"
+#define REMOTE_HOST_DEVICE(obj) \
+    OBJECT_CHECK(RemPCIHost, (obj), TYPE_REMOTE_HOST_DEVICE)
+
+typedef struct RemPCIHost {
+    /*< private >*/
+    PCIExpressHost parent_obj;
+    /*< public >*/
+
+    /* Memory Controller Hub (MCH) may not be necessary for the emulation
+     * program. The two important reasons for implementing a PCI host in the
+     * emulation program are:
+     * - Provide a PCI bus for IO devices
+     * - Enable translation of guest PA to the PCI bar regions
+     *
+     * For both the above mentioned purposes, it doesn't look like we would
+     * need the MCH
+     */
+
+    MemoryRegion *mr_pci_mem;
+    MemoryRegion *mr_sys_mem;
+    MemoryRegion *mr_sys_io;
+} RemPCIHost;
+
+#endif
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index a9b2256..2757f5a 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1 +1,2 @@
 remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
+remote-pci-obj-$(CONFIG_MPQEMU) += pcihost.o
diff --git a/remote/pcihost.c b/remote/pcihost.c
new file mode 100644
index 0000000..74b74b4
--- /dev/null
+++ b/remote/pcihost.c
@@ -0,0 +1,84 @@
+/*
+ * Remote PCI host device
+ *
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
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_host.h"
+#include "remote/pcihost.h"
+#include "exec/memory.h"
+
+static const char *remote_host_root_bus_path(PCIHostState *host_bridge,
+                                             PCIBus *rootbus)
+{
+    return "0000:00";
+}
+
+static void remote_host_realize(DeviceState *dev, Error **errp)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    RemPCIHost *s = REMOTE_HOST_DEVICE(dev);
+
+    /*
+     * TODO: the name of the bus would be provided by QEMU. Use
+     * "pcie.0" for now.
+     */
+    pci->bus = pci_root_bus_new(DEVICE(s), "pcie.0",
+                                s->mr_pci_mem, s->mr_sys_io,
+                                0, TYPE_PCIE_BUS);
+}
+
+static Property remote_host_props[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void remote_host_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
+
+    hc->root_bus_path = remote_host_root_bus_path;
+    dc->realize = remote_host_realize;
+    dc->props = remote_host_props;
+
+    dc->user_creatable = false;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+}
+
+static const TypeInfo remote_host_info = {
+    .name = TYPE_REMOTE_HOST_DEVICE,
+    .parent = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(RemPCIHost),
+    .class_init = remote_host_class_init,
+};
+
+static void remote_machine_register(void)
+{
+    type_register_static(&remote_host_info);
+}
+
+type_init(remote_machine_register)
-- 
1.8.3.1
