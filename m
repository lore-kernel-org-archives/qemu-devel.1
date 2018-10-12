Received: from eggs.gnu.org ([2001:4830:134:3::10]:60829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Ax-0008C4-P1
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Aq-0006UN-6S
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gB7Ao-0006Sg-3h
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w9CNjFLV088799
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:48 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp2120.oracle.com with ESMTP id 2mxnprndsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:48 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNml1Z009587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:48 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmlfx008537
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:47 GMT
From: Jagannathan Raman <jag.raman@oracle.com>
Date: Fri, 12 Oct 2018 19:48:34 -0400
Message-Id: <9b117184511df4ff6b0571a814387b8bd33646a1.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
Subject: [Qemu-devel] [RFC PATCH v1 7/8] multi-process QEMU: introduce proxy
 object
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Define PCI Device proxy object as a parent of TYPE_PCI_DEVICE.
PCI Proxy Object will register PCI BARs, MemoryRegionOps to handle
access to the BARs and forward those to the remote device.
PCI Proxy object intercepts config space reads and writes. In case
of pci config write it forwards it to the remote device using
communication channel.

TODO:
- Handle interrupt messages from the emulation program and implement
  DMA operations.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hw/Makefile.objs        |   2 +
 hw/qemu-proxy.c         | 215 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/qemu-proxy.h |  56 +++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 hw/qemu-proxy.c
 create mode 100644 include/hw/qemu-proxy.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 9c99c29..6bb2eb0 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -44,3 +44,5 @@ scsi-dev-obj-y += scsi/
 scsi-dev-obj-y += block/
 scsi-dev-obj-y += pci/
 scsi-dev-obj-y += nvram/
+
+common-obj-y += qemu-proxy.o
diff --git a/hw/qemu-proxy.c b/hw/qemu-proxy.c
new file mode 100644
index 0000000..1712b41
--- /dev/null
+++ b/hw/qemu-proxy.c
@@ -0,0 +1,215 @@
+/*
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <unistd.h>
+#include <assert.h>
+#include <string.h>
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "io/proxy-link.h"
+#include "exec/memory.h"
+#include "exec/cpu-common.h"
+#include "exec/address-spaces.h"
+#include "qemu/int128.h"
+#include "qemu/range.h"
+#include "hw/pci/pci.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
+#include "sysemu/sysemu.h"
+#include "hw/qemu-proxy.h"
+
+char command[] = "qemu-scsi-dev";
+
+static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
+
+int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t val, int l,
+                                                        unsigned int op)
+{
+    ProcMsg msg;
+    struct conf_data_msg conf_data;
+
+    conf_data.addr = addr;
+    conf_data.val = val;
+    conf_data.l = l;
+
+
+    msg.data2 = (uint8_t *)malloc(sizeof(conf_data));
+    if (!msg.data2) {
+        printf("Failed to allocate memory for msg.data2\n");
+        return -ENOMEM;
+    }
+    memcpy(msg.data2, (const uint8_t *)&conf_data, sizeof(conf_data));
+    msg.size = sizeof(conf_data);
+    msg.num_fds = 0;
+    msg.cmd = op;
+    msg.bytestream = 1;
+
+    proxy_proc_send(dev->proxy_dev.proxy_link, &msg);
+    free(msg.data2);
+
+    return 0;
+}
+
+static uint32_t pci_proxy_read_config(PCIDevice *d,
+                                       uint32_t addr, int len)
+{
+    config_op_send(PCI_PROXY_DEV(d), addr, 0, 0, CONF_READ);
+    return pci_default_read_config(d, addr, len);
+}
+
+static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
+                                    int l)
+{
+    pci_default_write_config(d, addr, val, l);
+    config_op_send(PCI_PROXY_DEV(d), addr, val, l, CONF_WRITE);
+}
+
+
+static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = pci_proxy_dev_realize;
+    k->class_id = PCI_CLASS_SYSTEM_OTHER;
+    k->vendor_id = PCI_VENDOR_ID_REDHAT;
+    k->device_id = PCI_DEVICE_ID_REDHAT_TEST;
+    k->config_read = pci_proxy_read_config;
+    k->config_write = pci_proxy_write_config;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "PCI Proxy Device";
+}
+
+static const TypeInfo pci_proxy_dev_type_info = {
+    .name          = TYPE_PCI_PROXY_DEV,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIProxyDev),
+    .class_init    = pci_proxy_dev_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    }
+};
+
+static void pci_proxy_mmio_write(void *opaque, hwaddr addr, uint64_t val,
+                                    unsigned size)
+{
+    return;
+}
+
+static uint64_t pci_proxy_mmio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static const MemoryRegionOps proxy_device_mmio_ops = {
+    .read = pci_proxy_mmio_read,
+    .write = pci_proxy_mmio_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+    }
+};
+
+static void pci_proxy_dev_register_types(void)
+{
+    type_register_static(&pci_proxy_dev_type_info);
+}
+
+static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(device);
+    uint8_t *pci_conf;
+
+    pci_conf = device->config;
+
+    init_emulation_process(dev, command, errp);
+    if (*errp) {
+        printf("Process did not start\n");
+        error_report_err(*errp);
+    }
+
+    if (!dev->proxy_dev.proxy_link) {
+        printf("Proxy link is not set\n");
+    }
+
+    pci_conf[PCI_LATENCY_TIMER] = 0xff;
+
+    memory_region_init_io(&dev->mmio_io, OBJECT(dev), &proxy_device_mmio_ops,
+                          dev, "proxy-device-mmio", 0x400);
+
+    pci_register_bar(device, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &dev->mmio_io);
+
+}
+
+void init_emulation_process(PCIProxyDev *pdev, char *command, Error **errp)
+{
+    char *args[2];
+    pid_t rpid;
+    int fd[2];
+
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
+        error_setg(errp, "Unable to create unix socket.");
+        return;
+    }
+
+    rpid = qemu_fork(errp);
+
+    if (rpid == -1) {
+        error_setg(errp, "Unable to spawn emulation program.");
+        return;
+    }
+
+    if (rpid == 0) {
+        if (dup2(fd[1], STDIN_FILENO) != STDIN_FILENO) {
+            perror("Failed to acquire socket.");
+            exit(1);
+        }
+
+        close(fd[0]);
+        close(fd[1]);
+
+        args[0] = command;
+        args[1] = NULL;
+        execvp(args[0], (char *const *)args);
+        exit(1);
+    }
+
+    pdev->proxy_dev.proxy_link = proxy_link_create();
+
+    if (!pdev->proxy_dev.proxy_link) {
+        return;
+    }
+
+    proxy_link_set_sock(pdev->proxy_dev.proxy_link, fd[0]);
+    close(fd[1]);
+
+}
+
+type_init(pci_proxy_dev_register_types)
diff --git a/include/hw/qemu-proxy.h b/include/hw/qemu-proxy.h
new file mode 100644
index 0000000..0903626
--- /dev/null
+++ b/include/hw/qemu-proxy.h
@@ -0,0 +1,56 @@
+/*
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
+#ifndef QEMU_PROXY_H
+#define QEMU_PROXY_H
+
+#include "io/proxy-link.h"
+
+#define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
+#define PCI_PROXY_DEV(obj) \
+            OBJECT_CHECK(PCIProxyDev, (obj), TYPE_PCI_PROXY_DEV)
+
+typedef struct proxy_device {
+       int n_mr_sections;
+        MemoryRegionSection *mr_sections;
+        ProxyLinkState *proxy_link;
+        int link_up;
+} proxy_device;
+
+typedef struct PCIProxyDev {
+        PCIDevice parent_dev;
+        struct proxy_device proxy_dev;
+
+        MemoryRegion bar;
+        MemoryRegion mmio_io;
+        MemoryRegion ram_io;
+
+        void (*proxy_read_config)(void);
+        void (*proxy_write_config) (void);
+
+} PCIProxyDev;
+
+void init_emulation_process(PCIProxyDev *pdev, char *command, Error **errp);
+int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t val, int l,
+                                                       unsigned int op);
+
+#endif
-- 
1.8.3.1
