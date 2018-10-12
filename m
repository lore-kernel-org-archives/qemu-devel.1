Received: from eggs.gnu.org ([2001:4830:134:3::10]:60827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Ax-0008C2-Os
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Aq-0006UY-6v
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gB7Ao-0006RW-0L
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w9CNibHT127381
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:46 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by userp2130.oracle.com with ESMTP id 2mxmfudn5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmj7k018509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:46 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9CNmjnF008250
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:45 GMT
From: Jagannathan Raman <jag.raman@oracle.com>
Date: Fri, 12 Oct 2018 19:48:30 -0400
Message-Id: <003ec4dd9c1988941e03bef621fa9e730c73612f.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
Subject: [Qemu-devel] [RFC PATCH v1 3/8] multi-process QEMU: setup PCI host
 bridge for remote device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: john.g.johnson@oracle.com, Kanth.Ghatraju@oracle.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com

- PCI host bridge is setup for the remote device process. It is
  implemented using remote-pcihost object. It is an extension of the PCI
  host bridge setup by QEMU.
- remote-pcihost configures a PCI bus which could be used by the remote
  PCI device to latch on to.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 Makefile                 |  1 +
 Makefile.objs            |  4 +++
 Makefile.target          |  3 ++
 hw/pci/Makefile.objs     |  2 +-
 include/remote/pcihost.h | 58 +++++++++++++++++++++++++++++++++
 remote/Makefile.objs     |  1 +
 remote/pcihost.c         | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 include/remote/pcihost.h
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/pcihost.c

diff --git a/Makefile b/Makefile
index b6cac08..fe4244a 100644
--- a/Makefile
+++ b/Makefile
@@ -429,6 +429,7 @@ dummy := $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
+                remote-obj-y \
                 scsi-dev-obj-y \
                 common-obj-m \
                 ui-obj-y \
diff --git a/Makefile.objs b/Makefile.objs
index 0a3799c..41a8c77 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -89,6 +89,10 @@ scsi-dev-obj-y += qdev-monitor.o
 scsi-dev-obj-y += bootdevice.o
 scsi-dev-obj-y += iothread.o
 
+#################################################
+# remote-obj-y is code used by all remote devices
+remote-obj-y += remote/
+
 #######################################################################
 # crypto-obj-y is code used by both qemu system emulation and qemu-img
 
diff --git a/Makefile.target b/Makefile.target
index c5feda2..74aab39 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -190,6 +190,7 @@ block-obj-y :=
 common-obj-y :=
 chardev-obj-y :=
 scsi-dev-obj-y :=
+remote-obj-y :=
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call unnest-vars,,target-obj-y)
 target-obj-y-save := $(target-obj-y)
@@ -202,6 +203,7 @@ dummy := $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
+               remote-obj-y \
                scsi-dev-obj-y \
                common-obj-m)
 target-obj-y := $(target-obj-y-save)
@@ -217,6 +219,7 @@ all-scsi-dev-obj-y += $(block-obj-y)
 all-scsi-dev-obj-y += $(crypto-obj-y)
 all-scsi-dev-obj-y += $(io-obj-y)
 all-scsi-dev-obj-y += $(chardev-obj-y)
+all-scsi-dev-obj-y += $(remote-obj-y)
 all-scsi-dev-obj-y += $(scsi-dev-obj-y)
 
 $(QEMU_PROG_BUILD): config-devices.mak
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index 46af40a..f779285 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -8,6 +8,6 @@ common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
 
-scsi-dev-obj-y += pci.o pci_bridge.o
+scsi-dev-obj-y += pci.o pci_bridge.o pci_host.o pcie_host.o
 scsi-dev-obj-y += msi.o msix.o
 scsi-dev-obj-y += pcie.o
diff --git a/include/remote/pcihost.h b/include/remote/pcihost.h
new file mode 100644
index 0000000..7357445
--- /dev/null
+++ b/include/remote/pcihost.h
@@ -0,0 +1,58 @@
+/*
+ * PCI Host for remote device
+ *
+ * Copyright 2018, Oracle and/or its affiliates. All rights reserved.
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
new file mode 100644
index 0000000..3072f95
--- /dev/null
+++ b/remote/Makefile.objs
@@ -0,0 +1 @@
+remote-obj-y += pcihost.o
diff --git a/remote/pcihost.c b/remote/pcihost.c
new file mode 100644
index 0000000..31cd7e8
--- /dev/null
+++ b/remote/pcihost.c
@@ -0,0 +1,84 @@
+/*
+ * Remote PCI host device
+ *
+ * Copyright 2018, Oracle and/or its affiliates. All rights reserved.
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
