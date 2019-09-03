Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCA1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EE72168B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ioCNBaL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EE72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Ffy-0004Md-Km
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZm-0007Gx-I5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZk-0000Cu-Gt
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZk-0000BA-8o
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXih7062336;
 Tue, 3 Sep 2019 20:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=g7trl9l/lqPtxD+uWVpo+Oo5xZyKHP5RvCUDnClcG2E=;
 b=ioCNBaL+OkIqMHV+erwdYXcDPIXyYbareHdhp1Nj4+UThi0POxwOFQk2p6nV26h43o4U
 WnW2tEIBiVDzvPFxt1/eP8RdUvV5IOySZV4Vg73qQpzIkTmy3NLQhsA5K3VJ8SuwLf0H
 Cf66RQyhC2074cBcNR2IrwlUOu5dtXTVB2CtEJ5qP7pa/hgbsJ2QU/tZEsI2osyXV5Qe
 r/GpEwRfqYayffo9GPlxUulVHkylpZ13UzawIoxwcNuDWpD0SC5FRXHv+69oeXElyC1h
 qCsO4mtPpfvJuP8PjEH4pNFmJFA7+aM7ceWqX4wcfM5aSBZhii7+dMvbHjP6Jdw3a+HV kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2usy66r2dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcJZu094939;
 Tue, 3 Sep 2019 20:38:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2usu51u1qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:44 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83KchS3022927;
 Tue, 3 Sep 2019 20:38:43 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:43 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:39 -0400
Message-Id: <c8f35d8b996dd9c32350123accf69e8e82ca235e.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 13/45] multi-process: introduce proxy
 object
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
 hw/proxy/qemu-proxy.c         | 247 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  81 ++++++++++++++
 remote/remote-main.c          |  28 +++++
 5 files changed, 359 insertions(+)
 create mode 100644 hw/proxy/Makefile.objs
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/qemu-proxy.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 4e28053..e016100 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -44,6 +44,8 @@ endif
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
index 0000000..0ec7bb6
--- /dev/null
+++ b/hw/proxy/qemu-proxy.c
@@ -0,0 +1,247 @@
+/*
+ * Copyright 2019, Oracle and/or its affiliates.
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
+int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
+{
+    char *args[3];
+    pid_t rpid;
+    int fd[2] = {-1, -1};
+    Error *local_error = NULL;
+
+    if (pdev->managed) {
+        /* Child is forked by external program (such as libvirt). */
+        return -1;
+    }
+
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
+        error_setg(errp, "Unable to create unix socket.");
+        return -1;
+    }
+    /* TODO: Restrict the forked process' permissions and capabilities. */
+    rpid = qemu_fork(&local_error);
+
+    if (rpid == -1) {
+        error_setg(errp, "Unable to spawn emulation program.");
+        close(fd[0]);
+        close(fd[1]);
+        return -1;
+    }
+
+    if (rpid == 0) {
+        close(fd[0]);
+
+        args[0] = g_strdup(command);
+        args[1] = g_strdup_printf("%d", fd[1]);
+        args[2] = NULL;
+        execvp(args[0], (char *const *)args);
+        exit(1);
+    }
+    pdev->remote_pid = rpid;
+    pdev->rsocket = fd[0];
+
+    close(fd[1]);
+
+    return 0;
+}
+
+static int get_proxy_sock(PCIDevice *dev)
+{
+    PCIProxyDev *pdev;
+
+    pdev = PCI_PROXY_DEV(dev);
+
+    return pdev->rsocket;
+}
+
+static void set_proxy_sock(PCIDevice *dev, int socket)
+{
+    PCIProxyDev *pdev;
+
+    pdev = PCI_PROXY_DEV(dev);
+
+    pdev->rsocket = socket;
+    pdev->managed = true;
+
+}
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
+    proxy_proc_send(dev->proxy_link, &msg, dev->proxy_link->com);
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
+static void init_proxy(PCIDevice *dev, char *command, Error **errp)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    Error *local_error = NULL;
+
+    if (!pdev->managed) {
+        if (command) {
+            remote_spawn(pdev, command, &local_error);
+        } else {
+            return;
+        }
+    } else {
+        pdev->remote_pid = atoi(pdev->rid);
+        if (pdev->remote_pid == -1) {
+            error_setg(errp, "Remote PID is -1");
+            return;
+        }
+    }
+
+    pdev->proxy_link = proxy_link_create();
+
+    if (!pdev->proxy_link) {
+        error_setg(errp, "Failed to create proxy link");
+        return;
+    }
+
+    proxy_link_init_channel(pdev->proxy_link, &pdev->proxy_link->com,
+                            pdev->socket);
+}
+
+static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(device);
+    PCIProxyDevClass *k = PCI_PROXY_DEV_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    if (k->realize) {
+        k->realize(dev, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+        }
+    }
+
+    dev->set_proxy_sock = set_proxy_sock;
+    dev->get_proxy_sock = get_proxy_sock;
+    dev->init_proxy = init_proxy;
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
new file mode 100644
index 0000000..ee21818
--- /dev/null
+++ b/include/hw/proxy/qemu-proxy.h
@@ -0,0 +1,81 @@
+/*
+ * Copyright 2019, Oracle and/or its affiliates.
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
+    int rsocket;
+    int socket;
+
+    char *rid;
+
+    bool managed;
+    char *dev_id;
+
+    QLIST_ENTRY(PCIProxyDev) next;
+
+    void (*set_proxy_sock) (PCIDevice *dev, int socket);
+    int (*get_proxy_sock) (PCIDevice *dev);
+
+    void (*set_remote_opts) (PCIDevice *dev, QDict *qdict, unsigned int cmd);
+    void (*proxy_ready) (PCIDevice *dev);
+    void (*init_proxy) (PCIDevice *pdev, char *command, Error **errp);
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
+int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp);
+
+
+#endif /* QEMU_PROXY_H */
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 72866ec..93b2d36 100644
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
 static void process_msg(GIOCondition cond, ProcChannel *chan)
 {
     ProcMsg *msg = NULL;
@@ -70,8 +96,10 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
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


