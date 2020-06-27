Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF35C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F169820775
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e6PB4Obd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F169820775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEQQ-00087L-7j
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELZ-0008K5-FL
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELW-00079d-JI
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH2ana172570;
 Sat, 27 Jun 2020 17:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=l+7gfyV68JQOk8h/tWymxftbgp+GxipuiOLfq0mxBuo=;
 b=e6PB4ObdyV9XuDmToN24dPL9oYkSOmeMnNHaked8GKTKeTgoHrmonXvycXf1Wv/Z7KYJ
 XXFeDI9zyIF9ZJ0TTIBnkccSyNJoKjTJ4uKs0K4ijZhRDMaf+cMdOSAfe0r0QZ6ELzvt
 YmKJXpzzzjo+J8+TjLI4gRjZx4GojVHaEEe9gjgBwMHXADOxpy06vvxMVn4YR8yhNjqS
 2OEHo97Oja/VhLiY2xok7Es6B+xCpzFoj/XBAWTB+pHMYQiOe0ckCmatLgdB82Sz3dPM
 lLa2l/UgZcUcXt4r95g6LPqug6mxK8UyfrwKSwsCy709bcyYZGLbqCttKpe84UVjBspf TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 31wxrms98g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:10:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8JiC081218;
 Sat, 27 Jun 2020 17:10:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 31wv59aws6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:10:21 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RHAKNL024367;
 Sat, 27 Jun 2020 17:10:20 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:10:20 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 16/21] multi-process: create IOHUB object to handle irq
Date: Sat, 27 Jun 2020 10:09:38 -0700
Message-Id: <be2466be0c94a172ecb5060ea35244f6af5bd3af.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=1 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270123
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:10:10
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

IOHUB object is added to manage PCI IRQs. It uses KVM_IRQFD
ioctl to create irqfd to injecting PCI interrupts to the guest.
IOHUB object forwards the irqfd to the remote process. Remote process
uses this fd to directly send interrupts to the guest, bypassing QEMU.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS               |   2 +
 hw/Makefile.objs          |   1 +
 hw/i386/remote-msg.c      |   4 +
 hw/i386/remote.c          |  15 ++++
 hw/pci/proxy.c            |  52 +++++++++++++
 hw/remote/Makefile.objs   |   1 +
 hw/remote/iohub.c         | 153 ++++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote.h  |   2 +
 include/hw/pci/pci_ids.h  |   3 +
 include/hw/pci/proxy.h    |   8 ++
 include/hw/remote/iohub.h |  50 +++++++++++++
 include/io/mpqemu-link.h  |   6 ++
 io/mpqemu-link.c          |   1 +
 13 files changed, 298 insertions(+)
 create mode 100644 hw/remote/Makefile.objs
 create mode 100644 hw/remote/iohub.c
 create mode 100644 include/hw/remote/iohub.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 38d605445e..f9ede7e094 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2956,6 +2956,8 @@ F: hw/pci/proxy.c
 F: include/hw/pci/proxy.h
 F: hw/pci/memory-sync.c
 F: include/hw/pci/memory-sync.h
+F: hw/remote/iohub.c
+F: include/hw/remote/iohub.h
 
 Build and test automation
 -------------------------
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 4cbe5e4e57..8caf659de0 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -40,6 +40,7 @@ devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += semihosting/
 devices-dirs-y += smbios/
+devices-dirs-y += remote/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 48b153eaae..67fee4bb57 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -10,6 +10,7 @@
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "hw/i386/remote-memory.h"
+#include "hw/remote/iohub.h"
 
 static void process_connect_dev_msg(MPQemuMsg *msg, QIOChannel *com,
                                     Error **errp);
@@ -67,6 +68,9 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
     case SYNC_SYSMEM:
         remote_sysmem_reconfig(&msg, &local_err);
         break;
+    case SET_IRQFD:
+        process_set_irqfd_msg(pci_dev, &msg);
+        break;
     default:
         error_setg(&local_err, "Unknown command (%d) received from proxy \
                    in remote process pid=%d", msg.cmd, getpid());
diff --git a/hw/i386/remote.c b/hw/i386/remote.c
index 5342e884ad..8e74a6f1af 100644
--- a/hw/i386/remote.c
+++ b/hw/i386/remote.c
@@ -17,12 +17,16 @@
 #include "qapi/error.h"
 #include "io/channel-util.h"
 #include "io/channel.h"
+#include "hw/pci/pci_host.h"
+#include "hw/remote/iohub.h"
 
 static void remote_machine_init(MachineState *machine)
 {
     MemoryRegion *system_memory, *system_io, *pci_memory;
     RemMachineState *s = REMOTE_MACHINE(machine);
     RemotePCIHost *rem_host;
+    PCIHostState *pci_host;
+    PCIDevice *pci_dev;
 
     system_memory = get_system_memory();
     system_io = get_system_io();
@@ -42,6 +46,17 @@ static void remote_machine_init(MachineState *machine)
     memory_region_add_subregion_overlap(system_memory, 0x0, pci_memory, -1);
 
     qdev_realize(DEVICE(rem_host), sysbus_get_default(), &error_fatal);
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
 
 static void remote_set_socket(Object *obj, const char *str, Error **errp)
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 5ecbdd2dcf..9d8559b6d4 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -19,6 +19,9 @@
 #include "qemu/error-report.h"
 #include "hw/pci/memory-sync.h"
 #include "qom/object.h"
+#include "qemu/event_notifier.h"
+#include "sysemu/kvm.h"
+#include "util/event_notifier-posix.c"
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -57,6 +60,53 @@ static Property proxy_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
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
+    MPQemuMsg msg;
+
+    event_notifier_init(&dev->intr, 0);
+    event_notifier_init(&dev->resample, 0);
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+    msg.cmd = SET_IRQFD;
+    msg.num_fds = 2;
+    msg.fds[0] = event_notifier_get_fd(&dev->intr);
+    msg.fds[1] = event_notifier_get_fd(&dev->resample);
+    msg.data1.set_irqfd.intx =
+        pci_get_byte(pci_dev->config + PCI_INTERRUPT_PIN) - 1;
+    msg.size = sizeof(msg.data1);
+
+    mpqemu_msg_send(&msg, dev->dev);
+
+    memset(&dev->irqfd, 0, sizeof(struct kvm_irqfd));
+
+    proxy_intx_update(pci_dev);
+
+    pci_device_set_intx_routing_notifier(pci_dev, proxy_intx_update);
+}
+
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 {
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
@@ -72,6 +122,8 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     }
 
     configure_memory_sync(&dev->sync, dev->com);
+
+    setup_irqfd(dev);
 }
 
 static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
diff --git a/hw/remote/Makefile.objs b/hw/remote/Makefile.objs
new file mode 100644
index 0000000000..635ce5e0ab
--- /dev/null
+++ b/hw/remote/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_MPQEMU) += iohub.o
diff --git a/hw/remote/iohub.c b/hw/remote/iohub.c
new file mode 100644
index 0000000000..9c6cfaecd4
--- /dev/null
+++ b/hw/remote/iohub.c
@@ -0,0 +1,153 @@
+/*
+ * Remote IO Hub
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_ids.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/remote/iohub.h"
+#include "qemu/thread.h"
+#include "hw/boards.h"
+#include "hw/i386/remote.h"
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
+        event_notifier_init_fd(&iohub->irqfds[pirq], -1);
+        event_notifier_init_fd(&iohub->resamplefds[pirq], -1);
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
+    int pirq, s;
+
+    pirq = token->pirq;
+
+    s = event_notifier_test_and_clear(&iohub->resamplefds[pirq]);
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
+void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg)
+{
+    RemMachineState *machine = REMOTE_MACHINE(current_machine);
+    RemoteIOHubState *iohub = machine->iohub;
+    int pirq;
+
+    g_assert(msg->data1.set_irqfd.intx < 4);
+    g_assert(msg->num_fds == 2);
+
+    pirq = remote_iohub_map_irq(pci_dev, msg->data1.set_irqfd.intx);
+
+    if (event_notifier_get_fd(&iohub->irqfds[pirq]) != -1) {
+        event_notifier_cleanup(&iohub->irqfds[pirq]);
+        event_notifier_cleanup(&iohub->resamplefds[pirq]);
+        memset(&iohub->token[pirq], 0, sizeof(ResampleToken));
+    }
+
+    event_notifier_init_fd(&iohub->irqfds[pirq], msg->fds[0]);
+    event_notifier_init_fd(&iohub->resamplefds[pirq], msg->fds[1]);
+
+    iohub->token[pirq].iohub = iohub;
+    iohub->token[pirq].pirq = pirq;
+
+    qemu_set_fd_handler(msg->fds[1], intr_resample_handler, NULL,
+                        &iohub->token[pirq]);
+}
diff --git a/include/hw/i386/remote.h b/include/hw/i386/remote.h
index c3890e57ab..6af423ab54 100644
--- a/include/hw/i386/remote.h
+++ b/include/hw/i386/remote.h
@@ -18,12 +18,14 @@
 #include "hw/boards.h"
 #include "hw/pci-host/remote.h"
 #include "io/channel.h"
+#include "hw/remote/iohub.h"
 
 typedef struct RemMachineState {
     MachineState parent_obj;
 
     RemotePCIHost *host;
     QIOChannel *ioc;
+    RemoteIOHubState *iohub;
 } RemMachineState;
 
 #define TYPE_REMOTE_MACHINE "remote-machine"
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 11f8ab7149..bd0c17dc78 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -192,6 +192,9 @@
 #define PCI_DEVICE_ID_SUN_SIMBA          0x5000
 #define PCI_DEVICE_ID_SUN_SABRE          0xa000
 
+#define PCI_VENDOR_ID_ORACLE             0x108e
+#define PCI_DEVICE_ID_REMOTE_IOHUB       0xb000
+
 #define PCI_VENDOR_ID_CMD                0x1095
 #define PCI_DEVICE_ID_CMD_646            0x0646
 
diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
index a41a6aeaa5..e6f076ae95 100644
--- a/include/hw/pci/proxy.h
+++ b/include/hw/pci/proxy.h
@@ -12,9 +12,12 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
+#include <linux/kvm.h>
+
 #include "hw/pci/pci.h"
 #include "io/channel.h"
 #include "hw/pci/memory-sync.h"
+#include "qemu/event_notifier.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
@@ -45,6 +48,11 @@ struct PCIProxyDev {
 
     RemoteMemSync sync;
 
+    struct kvm_irqfd irqfd;
+
+    EventNotifier intr;
+    EventNotifier resample;
+
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
 };
 
diff --git a/include/hw/remote/iohub.h b/include/hw/remote/iohub.h
new file mode 100644
index 0000000000..9aacf3e04c
--- /dev/null
+++ b/include/hw/remote/iohub.h
@@ -0,0 +1,50 @@
+/*
+ * IO Hub for remote device
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_IOHUB_H
+#define REMOTE_IOHUB_H
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "hw/pci/pci.h"
+#include "qemu/event_notifier.h"
+#include "qemu/thread-posix.h"
+#include "io/mpqemu-link.h"
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
+typedef struct ResampleToken {
+    void *iohub;
+    int pirq;
+} ResampleToken;
+
+typedef struct RemoteIOHubState {
+    PCIDevice d;
+    uint8_t irq_num[PCI_SLOT_MAX][PCI_NUM_PINS];
+    EventNotifier irqfds[REMOTE_IOHUB_NB_PIRQS];
+    EventNotifier resamplefds[REMOTE_IOHUB_NB_PIRQS];
+    unsigned int irq_level[REMOTE_IOHUB_NB_PIRQS];
+    ResampleToken token[REMOTE_IOHUB_NB_PIRQS];
+    QemuMutex irq_level_lock[REMOTE_IOHUB_NB_PIRQS];
+} RemoteIOHubState;
+
+int remote_iohub_map_irq(PCIDevice *pci_dev, int intx);
+void remote_iohub_set_irq(void *opaque, int pirq, int level);
+void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg);
+
+#endif
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 0422213863..a563b557ce 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -42,6 +42,7 @@ typedef enum {
     PCI_CONFIG_READ,
     BAR_WRITE,
     BAR_READ,
+    SET_IRQFD,
     MAX = INT_MAX,
 } MPQemuCmd;
 
@@ -64,6 +65,10 @@ typedef struct {
     bool memory;
 } BarAccessMsg;
 
+typedef struct {
+    int intx;
+} SetIrqFdMsg;
+
 /**
  * Maximum size of data2 field in the message to be transmitted.
  */
@@ -92,6 +97,7 @@ typedef struct {
         uint64_t u64;
         SyncSysmemMsg sync_sysmem;
         BarAccessMsg bar_access;
+        SetIrqFdMsg set_irqfd;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 026e25dca4..561ac0576f 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -258,6 +258,7 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
         break;
     case BAR_WRITE:
     case BAR_READ:
+    case SET_IRQFD:
         if (msg->size != sizeof(msg->data1)) {
             return false;
         }
-- 
2.25.GIT


