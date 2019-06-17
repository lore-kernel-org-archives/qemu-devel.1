Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF62C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AA320863
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BhTeUtkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AA320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwUK-0006i1-KO
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58757)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwB5-0005Yy-CA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwB1-0001ot-1z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwAy-0001lb-Tp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8wYD149305;
 Mon, 17 Jun 2019 18:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=1ZwVqQ+C9S/mfS2DjmonBx9P2Aj+vwsjsrWFSRP93mk=;
 b=BhTeUtkq54R+C0kbkN1/n8d4+NF4vJfkpMiH9mg3hsDySP4sOfIPAB8vmf2M3RzVspDt
 XpE10F8T9OamsWcMras1zAmm+vzdHgkKu0TfjMaAXkjO7g1OUYcqLCoNWa7GmlS0MJaj
 E5C3lcMjiKAnTeBjCIQUJIvXJ376tmL/SktftryNd8BetPwtKHR18zfoPwVW7m6Cavqt
 5ap3AJZIcxrSO200oWtDjt+bOUo47HzDGrPH+REIhTF8g6/zn8fuKKdlTE6KCayHX/xP
 onLUEBYi7vr38j/qhjqkUSCdGPYaV2KDByssJX3NabSPkhT0DcYkMM4C7G30ZrL5ipGH dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2t4r3tg2vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF5ui050139;
 Mon, 17 Jun 2019 18:16:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t5h5t9fjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:06 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIFxiM024922;
 Mon, 17 Jun 2019 18:15:59 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:15:58 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:15:55 -0700
Message-Id: <20190617181555.29725-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC PATCH v2 13/35] multi-process: introduce proxy
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, thuth@redhat.com,
 jag.raman@oracle.com, konrad.wilk@oracle.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 kanth.ghatraju@oracle.com, david@gibson.dropbear.id.au
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
 hw/proxy/qemu-proxy.c         | 250 ++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  79 +++++++++++
 remote/remote-main.c          |  28 ++++
 5 files changed, 360 insertions(+)
 create mode 100644 hw/proxy/Makefile.objs
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/qemu-proxy.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 80e0a6ab14..11121c0cef 100644
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
index 0000000000..eb81624cf8
--- /dev/null
+++ b/hw/proxy/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_MPQEMU) += qemu-proxy.o
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
new file mode 100644
index 0000000000..6ae584b5ad
--- /dev/null
+++ b/hw/proxy/qemu-proxy.c
@@ -0,0 +1,250 @@
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
+    if (fd[1] != -1) {
+        close(fd[1]);
+        return -1;
+    }
+
+    return 0;
+
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
+    proxy_link_set_sock(pdev->proxy_link, pdev->rsocket);
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
index 0000000000..911da6a306
--- /dev/null
+++ b/include/hw/proxy/qemu-proxy.h
@@ -0,0 +1,79 @@
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
+
+    char *rid;
+
+    bool managed;
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
index f36483b3ae..bb0d5f5178 100644
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
2.17.1


