Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411D2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEC5230F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hwsjcZXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEC5230F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5FlH-0000Ia-Dv
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fa1-0007cP-UM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZx-0000RY-Et
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZx-0000QW-7B
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXpB6053654;
 Tue, 3 Sep 2019 20:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=hLyMTkblEUSPt1ZVApwjHOCduPKjVD3wHdaigiVLbE0=;
 b=hwsjcZXJzz4eYkgBgq11ihbE4Mjy4SFW7cGm4aRxjFVJaJG93njq9KMnoNLRiqyuvNg+
 3nDmfc09NdR3jD/oeo/uoFKUXA49N5YcLCv4Zau0W//DfKpBkCJfXtwNhBO8Bt8MtyrQ
 OjTjuPPr2xj6JLq75zr6bkYVaT1J0zYAMoRs7b/j5TdiqHx6Se1zzXRSG51v8ku+eN3L
 KO/7sxAziB7yuauNZwW7db9wzPydpG13ckYDhTccX0o94T5sgrO0PYeV+9cHVm2e5Xyv
 N/0ZzXU9yr9jxSl/dzhWO7X/NrurkfvuQwCyDHBqeulN3cxXPa6JGik+qYzSLjOtCCRt Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2usy6n020d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcAkt025388;
 Tue, 3 Sep 2019 20:38:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2us5pha0bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:56 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83KctiR023032;
 Tue, 3 Sep 2019 20:38:55 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:55 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:47 -0400
Message-Id: <077c0cd5b70123a5105f1f0d143dbf306815b964.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC v3 PATCH 21/45] multi-process: create IOHUB
 object to handle irq
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

IOHUB object is added to manage PCI IRQs. It uses KVM_IRQFD
ioctl to create irqfd to injecting PCI interrupts to the guest.
IOHUB object forwards the irqfd to the remote process. Remote process
uses this fd to directly send interrupts to the guest, bypassing QEMU.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 Makefile.target               |   1 +
 hw/proxy/Makefile.objs        |   1 -
 hw/proxy/qemu-proxy.c         |  64 +++++++++++++++++
 include/hw/pci/pci_ids.h      |   3 +
 include/hw/proxy/qemu-proxy.h |   5 ++
 include/io/proxy-link.h       |   8 +++
 include/remote/iohub.h        |  63 +++++++++++++++++
 include/remote/machine.h      |   2 +
 remote/Makefile.objs          |   1 +
 remote/iohub.c                | 159 ++++++++++++++++++++++++++++++++++++++++++
 remote/machine.c              |  15 ++++
 remote/remote-main.c          |   4 ++
 12 files changed, 325 insertions(+), 1 deletion(-)
 create mode 100644 include/remote/iohub.h
 create mode 100644 remote/iohub.c

diff --git a/Makefile.target b/Makefile.target
index 3aa2ac8..a0c00c6 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -126,6 +126,7 @@ obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 obj-$(CONFIG_MPQEMU) += hw/proxy/memory-sync.o
+obj-$(CONFIG_MPQEMU) += hw/proxy/qemu-proxy.o
 LIBS := $(libs_cpu) $(LIBS)
 
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/kvm-stub.o
diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
index f562f5a..ca89109 100644
--- a/hw/proxy/Makefile.objs
+++ b/hw/proxy/Makefile.objs
@@ -1,2 +1 @@
-common-obj-$(CONFIG_MPQEMU) += qemu-proxy.o
 common-obj-$(CONFIG_MPQEMU) += proxy-lsi53c895a.o
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 158d8d7..f92d29a 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -27,6 +27,9 @@
 #include <unistd.h>
 #include <assert.h>
 #include <string.h>
+#include <linux/kvm.h>
+#include <errno.h>
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "io/proxy-link.h"
@@ -44,6 +47,9 @@
 #include "hw/proxy/qemu-proxy.h"
 #include "hw/proxy/memory-sync.h"
 #include "qom/object.h"
+#include "qemu/event_notifier.h"
+#include "sysemu/kvm.h"
+#include "util/event_notifier-posix.c"
 
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 
@@ -251,6 +257,63 @@ static void pci_proxy_dev_register_types(void)
 
 type_init(pci_proxy_dev_register_types)
 
+static void proxy_intx_update(PCIDevice *pci_dev)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(pci_dev);
+    PCIINTxRoute route;
+    int pin = pci_get_byte(pci_dev->config + PCI_INTERRUPT_PIN) - 1;
+
+    if (dev->irqfd.fd) {
+        dev->irqfd.flags = KVM_IRQFD_FLAG_DEASSIGN;
+        (void) kvm_vm_ioctl(kvm_state, KVM_IRQFD, &dev->irqfd);
+        memset(&dev->irqfd, 0, sizeof(struct kvm_irqfd));
+    }
+
+    route = pci_device_route_intx_to_irq(pci_dev, pin);
+
+    dev->irqfd.fd = event_notifier_get_fd(&dev->intr);
+    dev->irqfd.resamplefd = event_notifier_get_fd(&dev->resample);
+    dev->irqfd.gsi = route.irq;
+    dev->irqfd.flags |= KVM_IRQFD_FLAG_RESAMPLE;
+    (void) kvm_vm_ioctl(kvm_state, KVM_IRQFD, &dev->irqfd);
+}
+
+static void setup_irqfd(PCIProxyDev *dev)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    ProcMsg msg;
+
+    if (!dev->dev_id) {
+        fprintf(stderr, "Cannot setup IRQFD. No dev_id\n");
+        return;
+    }
+
+    event_notifier_init(&dev->intr, 0);
+    event_notifier_init(&dev->resample, 0);
+
+    memset(&msg, 0, sizeof(ProcMsg));
+    msg.cmd = SET_IRQFD;
+    msg.num_fds = 2;
+    msg.fds[0] = event_notifier_get_fd(&dev->intr);
+    msg.fds[1] = event_notifier_get_fd(&dev->resample);
+    msg.data1.set_irqfd.intx =
+        pci_get_byte(pci_dev->config + PCI_INTERRUPT_PIN) - 1;
+    msg.size = sizeof(msg.data1);
+
+    if (dev->dev_id) {
+        msg.id = (uint8_t *)dev->dev_id;
+        msg.size_id = strlen((char *)dev->dev_id) + 1;
+    }
+
+    proxy_proc_send(dev->proxy_link, &msg, dev->proxy_link->com);
+
+    memset(&dev->irqfd, 0, sizeof(struct kvm_irqfd));
+
+    proxy_intx_update(pci_dev);
+
+    pci_device_set_intx_routing_notifier(pci_dev, proxy_intx_update);
+}
+
 static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **errp)
 {
     PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
@@ -281,6 +344,7 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
                             pdev->socket);
 
     configure_memory_sync(pdev->sync, pdev->proxy_link);
+    setup_irqfd(pdev);
 }
 
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 0abe27a..9cc5e28 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -191,6 +191,9 @@
 #define PCI_DEVICE_ID_SUN_SIMBA          0x5000
 #define PCI_DEVICE_ID_SUN_SABRE          0xa000
 
+#define PCI_VENDOR_ID_ORACLE             0x108e
+#define PCI_DEVICE_ID_REMOTE_IOHUB       0xb000
+
 #define PCI_VENDOR_ID_CMD                0x1095
 #define PCI_DEVICE_ID_CMD_646            0x0646
 
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index cf8e006..e73835e 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -23,8 +23,11 @@
 #ifndef QEMU_PROXY_H
 #define QEMU_PROXY_H
 
+#include <linux/kvm.h>
+
 #include "io/proxy-link.h"
 #include "hw/proxy/memory-sync.h"
+#include "qemu/event_notifier.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
@@ -46,6 +49,8 @@ typedef struct PCIProxyDev {
     ProxyLinkState *proxy_link;
 
     RemoteMemSync *sync;
+    struct kvm_irqfd irqfd;
+
     EventNotifier intr;
     EventNotifier resample;
 
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 2c290b2..e70bf50 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -58,6 +58,8 @@ typedef struct ProxyLinkState ProxyLinkState;
  * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
  * BAR_WRITE        Writes to PCI BAR region
  * BAR_READ         Reads from PCI BAR region
+ * SET_IRQFD        Sets the IRQFD to be used to raise interrupts directly
+ *                  from remote device
  *
  */
 typedef enum {
@@ -67,6 +69,7 @@ typedef enum {
     SYNC_SYSMEM,
     BAR_WRITE,
     BAR_READ,
+    SET_IRQFD,
     MAX,
 } proc_cmd_t;
 
@@ -96,6 +99,10 @@ typedef struct {
 } bar_access_msg_t;
 
 typedef struct {
+    int intx;
+} set_irqfd_msg_t;
+
+typedef struct {
     proc_cmd_t cmd;
     int bytestream;
     size_t size;
@@ -105,6 +112,7 @@ typedef struct {
         uint64_t u64;
         sync_sysmem_msg_t sync_sysmem;
         bar_access_msg_t bar_access;
+        set_irqfd_msg_t set_irqfd;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/include/remote/iohub.h b/include/remote/iohub.h
new file mode 100644
index 0000000..0a799d6
--- /dev/null
+++ b/include/remote/iohub.h
@@ -0,0 +1,63 @@
+/*
+ * IO Hub for remote device
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
+#ifndef REMOTE_IOHUB_H
+#define REMOTE_IOHUB_H
+
+#include <sys/types.h>
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "qemu/event_notifier.h"
+#include "qemu/thread-posix.h"
+#include "io/proxy-link.h"
+
+#define REMOTE_IOHUB_NB_PIRQS    8
+
+#define REMOTE_IOHUB_DEV         31
+#define REMOTE_IOHUB_FUNC        0
+
+#define TYPE_REMOTE_IOHUB_DEVICE "remote-iohub"
+#define REMOTE_IOHUB_DEVICE(obj) \
+    OBJECT_CHECK(RemoteIOHubState, (obj), TYPE_REMOTE_IOHUB_DEVICE)
+
+typedef struct RemoteIOHubState {
+    PCIDevice d;
+    uint8_t irq_num[PCI_SLOT_MAX][PCI_NUM_PINS];
+    EventNotifier irqfds[REMOTE_IOHUB_NB_PIRQS];
+    EventNotifier resamplefds[REMOTE_IOHUB_NB_PIRQS];
+    unsigned int irq_level[REMOTE_IOHUB_NB_PIRQS];
+    QemuMutex irq_level_lock[REMOTE_IOHUB_NB_PIRQS];
+} RemoteIOHubState;
+
+typedef struct ResampleToken {
+    RemoteIOHubState *iohub;
+    int pirq;
+} ResampleToken;
+
+int remote_iohub_map_irq(PCIDevice *pci_dev, int intx);
+void remote_iohub_set_irq(void *opaque, int pirq, int level);
+void process_set_irqfd_msg(PCIDevice *pci_dev, ProcMsg *msg);
+
+#endif
diff --git a/include/remote/machine.h b/include/remote/machine.h
index a00732d..0a16cc6 100644
--- a/include/remote/machine.h
+++ b/include/remote/machine.h
@@ -30,11 +30,13 @@
 #include "hw/boards.h"
 #include "remote/pcihost.h"
 #include "qemu/notify.h"
+#include "remote/iohub.h"
 
 typedef struct RemMachineState {
     MachineState parent_obj;
 
     RemPCIHost *host;
+    RemoteIOHubState *iohub;
 } RemMachineState;
 
 #define TYPE_REMOTE_MACHINE "remote-machine"
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index 13d4c48..cbb3065 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,3 +1,4 @@
 remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
 remote-pci-obj-$(CONFIG_MPQEMU) += pcihost.o
 remote-pci-obj-$(CONFIG_MPQEMU) += machine.o
+remote-pci-obj-$(CONFIG_MPQEMU) += iohub.o
diff --git a/remote/iohub.c b/remote/iohub.c
new file mode 100644
index 0000000..c292269
--- /dev/null
+++ b/remote/iohub.c
@@ -0,0 +1,159 @@
+/*
+ * Remote IO Hub
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
+#include "hw/pci/pci_ids.h"
+#include "hw/pci/pci_bus.h"
+#include "remote/iohub.h"
+#include "qemu/thread.h"
+#include "hw/boards.h"
+#include "remote/machine.h"
+#include "qemu/main-loop.h"
+
+static void remote_iohub_initfn(Object *obj)
+{
+    RemoteIOHubState *iohub = REMOTE_IOHUB_DEVICE(obj);
+    int slot, intx, pirq;
+
+    memset(&iohub->irqfds, 0, sizeof(iohub->irqfds));
+    memset(&iohub->resamplefds, 0, sizeof(iohub->resamplefds));
+
+    for (slot = 0; slot < PCI_SLOT_MAX; slot++) {
+        for (intx = 0; intx < PCI_NUM_PINS; intx++) {
+            iohub->irq_num[slot][intx] = (slot + intx) % 4 + 4;
+        }
+    }
+
+    for (pirq = 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
+        qemu_mutex_init(&iohub->irq_level_lock[pirq]);
+        iohub->irq_level[pirq] = 0;
+    }
+}
+
+static void remote_iohub_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    k->vendor_id = PCI_VENDOR_ID_ORACLE;
+    k->device_id = PCI_DEVICE_ID_REMOTE_IOHUB;
+}
+
+static const TypeInfo remote_iohub_info = {
+    .name       = TYPE_REMOTE_IOHUB_DEVICE,
+    .parent     = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(RemoteIOHubState),
+    .instance_init = remote_iohub_initfn,
+    .class_init  = remote_iohub_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    }
+};
+
+static void remote_iohub_register(void)
+{
+    type_register_static(&remote_iohub_info);
+}
+
+type_init(remote_iohub_register);
+
+int remote_iohub_map_irq(PCIDevice *pci_dev, int intx)
+{
+    BusState *bus = qdev_get_parent_bus(&pci_dev->qdev);
+    PCIBus *pci_bus = PCI_BUS(bus);
+    PCIDevice *pci_iohub =
+        pci_bus->devices[PCI_DEVFN(REMOTE_IOHUB_DEV, REMOTE_IOHUB_FUNC)];
+    RemoteIOHubState *iohub = REMOTE_IOHUB_DEVICE(pci_iohub);
+
+    return iohub->irq_num[PCI_SLOT(pci_dev->devfn)][intx];
+}
+
+/*
+ * TODO: Using lock to set the interrupt level could become a
+ *       performance bottleneck. Check if atomic arithmetic
+ *       is possible.
+ */
+void remote_iohub_set_irq(void *opaque, int pirq, int level)
+{
+    RemoteIOHubState *iohub = opaque;
+
+    assert(pirq >= 0);
+    assert(pirq < REMOTE_IOHUB_NB_PIRQS);
+
+    qemu_mutex_lock(&iohub->irq_level_lock[pirq]);
+
+    if (level) {
+        if (++iohub->irq_level[pirq] == 1) {
+            event_notifier_set(&iohub->irqfds[pirq]);
+        }
+    } else if (iohub->irq_level[pirq] > 0) {
+        iohub->irq_level[pirq]--;
+    }
+
+    qemu_mutex_unlock(&iohub->irq_level_lock[pirq]);
+}
+
+static void intr_resample_handler(void *opaque)
+{
+    ResampleToken *token = opaque;
+    RemoteIOHubState *iohub = token->iohub;
+    uint64_t val;
+    int pirq, s;
+
+    pirq = token->pirq;
+
+    s = read(event_notifier_get_fd(&iohub->resamplefds[pirq]), &val,
+             sizeof(uint64_t));
+
+    assert(s >= 0);
+
+    qemu_mutex_lock(&iohub->irq_level_lock[pirq]);
+
+    if (iohub->irq_level[pirq]) {
+        event_notifier_set(&iohub->irqfds[pirq]);
+    }
+
+    qemu_mutex_unlock(&iohub->irq_level_lock[pirq]);
+}
+
+void process_set_irqfd_msg(PCIDevice *pci_dev, ProcMsg *msg)
+{
+    RemMachineState *machine = REMOTE_MACHINE(current_machine);
+    RemoteIOHubState *iohub = machine->iohub;
+    ResampleToken *token;
+    int pirq = remote_iohub_map_irq(pci_dev, msg->data1.set_irqfd.intx);
+
+    assert(msg->num_fds == 2);
+
+    event_notifier_init_fd(&iohub->irqfds[pirq], msg->fds[0]);
+    event_notifier_init_fd(&iohub->resamplefds[pirq], msg->fds[1]);
+
+    token = g_malloc0(sizeof(ResampleToken));
+    token->iohub = iohub;
+    token->pirq = pirq;
+
+    qemu_set_fd_handler(msg->fds[1], intr_resample_handler, NULL, token);
+}
diff --git a/remote/machine.c b/remote/machine.c
index 4ce197d..5b03167 100644
--- a/remote/machine.c
+++ b/remote/machine.c
@@ -40,6 +40,8 @@
 #include "qemu-common.h"
 #include "sysemu/sysemu.h"
 #include "qemu/notify.h"
+#include "hw/pci/pci_host.h"
+#include "remote/iohub.h"
 
 static NotifierList machine_init_done_notifiers =
     NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
@@ -70,6 +72,8 @@ static void remote_machine_init(Object *obj)
     RemMachineState *s = REMOTE_MACHINE(obj);
     RemPCIHost *rem_host;
     MemoryRegion *system_memory, *system_io, *pci_memory;
+    PCIHostState *pci_host;
+    PCIDevice *pci_dev;
 
     Error *error_abort = NULL;
 
@@ -101,6 +105,17 @@ static void remote_machine_init(Object *obj)
     qemu_mutex_unlock_iothread();
 
     qdev_init_nofail(DEVICE(rem_host));
+
+    pci_host = PCI_HOST_BRIDGE(rem_host);
+    pci_dev = pci_create_simple_multifunction(pci_host->bus,
+                                              PCI_DEVFN(REMOTE_IOHUB_DEV,
+                                                        REMOTE_IOHUB_FUNC),
+                                              true, TYPE_REMOTE_IOHUB_DEVICE);
+
+    s->iohub = REMOTE_IOHUB_DEVICE(pci_dev);
+
+    pci_bus_irqs(pci_host->bus, remote_iohub_set_irq, remote_iohub_map_irq,
+                 s->iohub, REMOTE_IOHUB_NB_PIRQS);
 }
 
 static const TypeInfo remote_machine = {
diff --git a/remote/remote-main.c b/remote/remote-main.c
index bf2a77c..8af284e 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -47,6 +47,7 @@
 #include "block/block.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
+#include "remote/iohub.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -185,6 +186,9 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
             goto finalize_loop;
         }
         break;
+    case SET_IRQFD:
+        process_set_irqfd_msg(remote_pci_dev, msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1


