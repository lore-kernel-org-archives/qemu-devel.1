Received: from eggs.gnu.org ([209.51.188.92]:59707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLg-00021C-A0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLe-0004xu-Qx
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLe-0004xd-Ij
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:46 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:34 -0800
Message-Id: <20190307072134.8687-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 13/37] multi-process:
 introduce proxy object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Defines a PCI Device proxy object as a parent of TYPE_PCI_DEVICE.
PCI Proxy Object is responsible for registering PCI BARs,i
MemoryRegionOps to handle access to the BARs and forwarding those
to the remote device.
PCI Proxy object intercepts config space reads and writes. In case
of pci config write it forwards it to the remote device using
communication channel set by proxy-link object.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/Makefile.objs              |   2 +
 hw/proxy/Makefile.objs        |   1 +
 hw/proxy/qemu-proxy.c         | 203 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  68 ++++++++++++++
 remote/remote-main.c          |  28 ++++++
 5 files changed, 302 insertions(+)
 create mode 100644 hw/proxy/Makefile.objs
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/qemu-proxy.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 4cbfdff..7449c50 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -40,6 +40,8 @@ devices-dirs-y += core/
 common-obj-y += $(devices-dirs-y)
 obj-y += $(devices-dirs-y)
 
+common-obj-$(CONFIG_MPQEMU) += proxy/
+
 remote-pci-obj-$(CONFIG_MPQEMU) += core/
 remote-pci-obj-$(CONFIG_MPQEMU) += block/
 remote-pci-obj-$(CONFIG_MPQEMU) += pci/
diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
new file mode 100644
index 0000000..eb81624
--- /dev/null
+++ b/hw/proxy/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_MPQEMU) += qemu-proxy.o
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
new file mode 100644
index 0000000..91cc82b
--- /dev/null
+++ b/hw/proxy/qemu-proxy.c
@@ -0,0 +1,203 @@
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
+#include "hw/proxy/qemu-proxy.h"
+
+static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
+
+static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
+                          unsigned int op)
+{
+    ProcMsg msg;
+    struct conf_data_msg conf_data;
+    int wait;
+
+    memset(&msg, 0, sizeof(ProcMsg));
+    conf_data.addr = addr;
+    conf_data.val = (op == CONF_WRITE) ? *val : 0;
+    conf_data.l = l;
+
+    msg.data2 = (uint8_t *)malloc(sizeof(conf_data));
+    if (!msg.data2) {
+        printf("Failed to allocate memory for msg.data2.");
+        return -ENOMEM;
+    }
+
+    memcpy(msg.data2, (const uint8_t *)&conf_data, sizeof(conf_data));
+    msg.size = sizeof(conf_data);
+    msg.cmd = op;
+    msg.bytestream = 1;
+
+    if (op == CONF_WRITE) {
+        msg.num_fds = 0;
+    } else {
+        wait = GET_REMOTE_WAIT;
+        msg.num_fds = 1;
+        msg.fds[0] = wait;
+    }
+
+    proxy_proc_send(dev->proxy_link, &msg);
+
+    if (op == CONF_READ) {
+        *val = (uint32_t)wait_for_remote(wait);
+        PUT_REMOTE_WAIT(wait);
+    }
+
+    free(msg.data2);
+
+    return 0;
+}
+
+static uint32_t pci_proxy_read_config(PCIDevice *d, uint32_t addr, int len)
+{
+    uint32_t val;
+
+    (void)pci_default_read_config(d, addr, len);
+
+    config_op_send(PCI_PROXY_DEV(d), addr, &val, len, CONF_READ);
+
+    return val;
+}
+
+static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
+                                   int l)
+{
+    pci_default_write_config(d, addr, val, l);
+
+    config_op_send(PCI_PROXY_DEV(d), addr, &val, l, CONF_WRITE);
+}
+
+static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = pci_proxy_dev_realize;
+    k->config_read = pci_proxy_read_config;
+    k->config_write = pci_proxy_write_config;
+}
+
+static const TypeInfo pci_proxy_dev_type_info = {
+    .name          = TYPE_PCI_PROXY_DEV,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIProxyDev),
+    .abstract      = true,
+    .class_size    = sizeof(PCIProxyDevClass),
+    .class_init    = pci_proxy_dev_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void pci_proxy_dev_register_types(void)
+{
+    type_register_static(&pci_proxy_dev_type_info);
+}
+
+type_init(pci_proxy_dev_register_types)
+
+static void init_emulation_process(PCIProxyDev *pdev, const char *command, Error **errp)
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
+    /* TODO: Restrict the forked process' permissions and capabilities. */
+    rpid = qemu_fork(errp);
+
+    if (rpid == -1) {
+        error_setg(errp, "Unable to spawn emulation program.");
+        close(fd[0]);
+        close(fd[1]);
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
+        args[0] = g_strdup(command);
+        args[1] = NULL;
+        execvp(args[0], (char *const *)args);
+        exit(1);
+    }
+
+    pdev->proxy_link = proxy_link_create();
+
+    if (!pdev->proxy_link) {
+        error_setg(errp, "Failed to create proxy link");
+        close(fd[0]);
+        close(fd[1]);
+        return;
+    }
+
+    proxy_link_set_sock(pdev->proxy_link, fd[0]);
+
+    close(fd[1]);
+}
+
+static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(device);
+    PCIProxyDevClass *k = PCI_PROXY_DEV_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    init_emulation_process(dev, k->command, errp);
+
+    if (k->realize) {
+        k->realize(dev, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+        }
+    }
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
new file mode 100644
index 0000000..0b0d94a
--- /dev/null
+++ b/include/hw/proxy/qemu-proxy.h
@@ -0,0 +1,68 @@
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
+#ifndef QEMU_PROXY_H
+#define QEMU_PROXY_H
+
+#include "io/proxy-link.h"
+
+#define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
+
+#define PCI_PROXY_DEV(obj) \
+            OBJECT_CHECK(PCIProxyDev, (obj), TYPE_PCI_PROXY_DEV)
+
+#define PCI_PROXY_DEV_CLASS(klass) \
+            OBJECT_CLASS_CHECK(PCIProxyDevClass, (klass), TYPE_PCI_PROXY_DEV)
+
+#define PCI_PROXY_DEV_GET_CLASS(obj) \
+            OBJECT_GET_CLASS(PCIProxyDevClass, (obj), TYPE_PCI_PROXY_DEV)
+
+typedef struct PCIProxyDev {
+    PCIDevice parent_dev;
+
+    int n_mr_sections;
+    MemoryRegionSection *mr_sections;
+
+    ProxyLinkState *proxy_link;
+
+    EventNotifier intr;
+    EventNotifier resample;
+
+    pid_t remote_pid;
+    char *rid;
+
+    QLIST_ENTRY(PCIProxyDev) next;
+
+    void (*set_remote_opts) (PCIDevice *dev, QDict *qdict, unsigned int cmd);
+    void (*proxy_ready) (PCIDevice *dev);
+
+} PCIProxyDev;
+
+typedef struct PCIProxyDevClass {
+    PCIDeviceClass parent_class;
+
+    void (*realize)(PCIProxyDev *dev, Error **errp);
+
+    char *command;
+} PCIProxyDevClass;
+
+#endif /* QEMU_PROXY_H */
diff --git a/remote/remote-main.c b/remote/remote-main.c
index b15e299..f708be2 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -49,6 +49,32 @@
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
 
+static void process_config_write(ProcMsg *msg)
+{
+    struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
+
+    qemu_mutex_lock_iothread();
+    pci_default_write_config(remote_pci_dev, conf->addr, conf->val, conf->l);
+    qemu_mutex_unlock_iothread();
+}
+
+static void process_config_read(ProcMsg *msg)
+{
+    struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
+    uint32_t val;
+    int wait;
+
+    wait = msg->fds[0];
+
+    qemu_mutex_lock_iothread();
+    val = pci_default_read_config(remote_pci_dev, conf->addr, conf->l);
+    qemu_mutex_unlock_iothread();
+
+    notify_proxy(wait, val);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
@@ -70,8 +96,10 @@ static void process_msg(GIOCondition cond)
     case INIT:
         break;
     case CONF_WRITE:
+        process_config_write(msg);
         break;
     case CONF_READ:
+        process_config_read(msg);
         break;
     default:
         error_setg(&err, "Unknown command");
-- 
1.8.3.1
