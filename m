Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E4EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EC920FC3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wKmCq0Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EC920FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPVmQ-0002fN-E8
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 15:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVaR-0006tm-Tx
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVaL-00085W-K7
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095IoQS2039545;
 Mon, 5 Oct 2020 18:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GpV2lAUrPJUU4XvNRZlffmZBmtJzz0uHvG8SQmhgZr8=;
 b=wKmCq0Iex9nJKFsVy8Kka93qHmaVfrVxa06AUofGpHfDpJiQxeNU6JOBztbRwezZjsBP
 kUjS2Ylb9VSMT3WHakQD2/bg6YTe8T0O6Qu6HbHFapW7loouxLWi/YFEr0sLnj9ouZpN
 bkGuEbUKKcxkvidbr3Ah0i7Q817gnwBAuzpjCU95pq1XuFf/Q8oxo+dxjUg3ysemd1uP
 kr79Ws1u09DTUjCeBoVRP2rTu9gS+XnuhhRP9+x6+4dNOsTLNuBsGFXh8Mm4EXSveY64
 5n/VADt7jsFm+SOrbO0CpDAK262RDdA/FG0b5OwqInOXehmU3YGswj7lQ5rNsIeLcc4t oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 33xetaqckt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 05 Oct 2020 18:51:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095Ip65R026204;
 Mon, 5 Oct 2020 18:51:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 33yyje8pjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Oct 2020 18:51:37 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 095IpZZn032246;
 Mon, 5 Oct 2020 18:51:36 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 05 Oct 2020 11:51:35 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v10 15/19] multi-process: create IOHUB object to handle irq
Date: Mon,  5 Oct 2020 11:51:03 -0700
Message-Id: <255012a409adb37b59199eb080c8a197b2b8699f.1601923020.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1601923020.git.elena.ufimtseva@oracle.com>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=1 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 14:51:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS                    |   2 +
 hw/i386/meson.build            |   1 +
 hw/i386/remote-iohub.c         | 123 +++++++++++++++++++++++++++++++++
 hw/i386/remote-msg.c           |   4 ++
 hw/i386/remote.c               |  10 +++
 hw/pci/proxy.c                 |  58 ++++++++++++++++
 include/hw/i386/remote-iohub.h |  42 +++++++++++
 include/hw/i386/remote.h       |   3 +
 include/hw/pci/pci_ids.h       |   3 +
 include/hw/pci/proxy.h         |   5 ++
 include/io/mpqemu-link.h       |   1 +
 io/mpqemu-link.c               |   5 ++
 12 files changed, 257 insertions(+)
 create mode 100644 hw/i386/remote-iohub.c
 create mode 100644 include/hw/i386/remote-iohub.h

diff --git a/MAINTAINERS b/MAINTAINERS
index aa18f4fe86..084a82232a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3056,6 +3056,8 @@ F: hw/pci/proxy.c
 F: include/hw/pci/proxy.h
 F: hw/pci/memory-sync.c
 F: include/hw/pci/memory-sync.h
+F: hw/i386/remote-iohub.c
+F: include/hw/i386/remote-iohub.h
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 36e151c80a..1adfce948a 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -27,6 +27,7 @@ i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote.c'))
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-msg.c'))
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-obj.c'))
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-memory.c'))
+i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-iohub.c'))
 
 subdir('kvm')
 subdir('xen')
diff --git a/hw/i386/remote-iohub.c b/hw/i386/remote-iohub.c
new file mode 100644
index 0000000000..e59424ea32
--- /dev/null
+++ b/hw/i386/remote-iohub.c
@@ -0,0 +1,123 @@
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
+#include "qemu/thread.h"
+#include "hw/boards.h"
+#include "hw/i386/remote.h"
+#include "hw/i386/remote-iohub.h"
+#include "qemu/main-loop.h"
+
+void remote_iohub_init(RemoteIOHubState *iohub)
+{
+    int pirq;
+
+    memset(&iohub->irqfds, 0, sizeof(iohub->irqfds));
+    memset(&iohub->resamplefds, 0, sizeof(iohub->resamplefds));
+
+    for (pirq = 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
+        qemu_mutex_init(&iohub->irq_level_lock[pirq]);
+        iohub->irq_level[pirq] = 0;
+        event_notifier_init_fd(&iohub->irqfds[pirq], -1);
+        event_notifier_init_fd(&iohub->resamplefds[pirq], -1);
+    }
+}
+
+void remote_iohub_finalize(RemoteIOHubState *iohub)
+{
+    int pirq;
+
+    for (pirq = 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
+        qemu_set_fd_handler(event_notifier_get_fd(&iohub->resamplefds[pirq]),
+                            NULL, NULL, NULL);
+        event_notifier_cleanup(&iohub->irqfds[pirq]);
+        event_notifier_cleanup(&iohub->resamplefds[pirq]);
+        qemu_mutex_destroy(&iohub->irq_level_lock[pirq]);
+    }
+}
+
+int remote_iohub_map_irq(PCIDevice *pci_dev, int intx)
+{
+    return pci_dev->devfn;
+}
+
+void remote_iohub_set_irq(void *opaque, int pirq, int level)
+{
+    RemoteIOHubState *iohub = opaque;
+
+    assert(pirq >= 0);
+    assert(pirq < PCI_DEVFN_MAX);
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
+    RemoteMachineState *machine = REMOTE_MACHINE(current_machine);
+    RemoteIOHubState *iohub = &machine->iohub;
+    int pirq, intx;
+
+    intx = pci_get_byte(pci_dev->config + PCI_INTERRUPT_PIN) - 1;
+
+    pirq = remote_iohub_map_irq(pci_dev, intx);
+
+    if (event_notifier_get_fd(&iohub->irqfds[pirq]) != -1) {
+        qemu_set_fd_handler(event_notifier_get_fd(&iohub->resamplefds[pirq]),
+                            NULL, NULL, NULL);
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
diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 3465a9ddd6..a318a9ff91 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -18,6 +18,7 @@
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "hw/i386/remote-memory.h"
+#include "hw/i386/remote-iohub.h"
 
 static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
                                  MPQemuMsg *msg);
@@ -68,6 +69,9 @@ void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
         case SYNC_SYSMEM:
             remote_sysmem_reconfig(&msg, &local_err);
             break;
+        case SET_IRQFD:
+            process_set_irqfd_msg(pci_dev, &msg);
+            break;
 
         default:
             error_setg(&local_err,
diff --git a/hw/i386/remote.c b/hw/i386/remote.c
index a67be33396..95de652e79 100644
--- a/hw/i386/remote.c
+++ b/hw/i386/remote.c
@@ -20,12 +20,15 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "qapi/error.h"
+#include "hw/pci/pci_host.h"
+#include "hw/i386/remote-iohub.h"
 
 static void remote_machine_init(MachineState *machine)
 {
     MemoryRegion *system_memory, *system_io, *pci_memory;
     RemoteMachineState *s = REMOTE_MACHINE(machine);
     RemotePCIHost *rem_host;
+    PCIHostState *pci_host;
 
     system_memory = get_system_memory();
     system_io = get_system_io();
@@ -45,6 +48,13 @@ static void remote_machine_init(MachineState *machine)
     memory_region_add_subregion_overlap(system_memory, 0x0, pci_memory, -1);
 
     qdev_realize(DEVICE(rem_host), sysbus_get_default(), &error_fatal);
+
+    pci_host = PCI_HOST_BRIDGE(rem_host);
+
+    remote_iohub_init(&s->iohub);
+
+    pci_bus_irqs(pci_host->bus, remote_iohub_set_irq, remote_iohub_map_irq,
+                 &s->iohub, REMOTE_IOHUB_NB_PIRQS);
 }
 
 static void remote_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 008af7e8f5..029e78e85f 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -20,6 +20,9 @@
 #include "qemu/error-report.h"
 #include "hw/pci/memory-sync.h"
 #include "qom/object.h"
+#include "qemu/event_notifier.h"
+#include "sysemu/kvm.h"
+#include "util/event_notifier-posix.c"
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -31,6 +34,56 @@ static Property proxy_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void proxy_intx_update(PCIDevice *pci_dev)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(pci_dev);
+    PCIINTxRoute route;
+    int pin = pci_get_byte(pci_dev->config + PCI_INTERRUPT_PIN) - 1;
+
+    if (dev->virq != -1) {
+        kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &dev->intr, dev->virq);
+        dev->virq = -1;
+    }
+
+    route = pci_device_route_intx_to_irq(pci_dev, pin);
+
+    dev->virq = route.irq;
+
+    if (dev->virq != -1) {
+        kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, &dev->intr,
+                                           &dev->resample, dev->virq);
+    }
+}
+
+static void setup_irqfd(PCIProxyDev *dev)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    MPQemuMsg msg;
+    Error *local_err = NULL;
+
+    event_notifier_init(&dev->intr, 0);
+    event_notifier_init(&dev->resample, 0);
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+    msg.cmd = SET_IRQFD;
+    msg.num_fds = 2;
+    msg.fds[0] = event_notifier_get_fd(&dev->intr);
+    msg.fds[1] = event_notifier_get_fd(&dev->resample);
+    msg.size = 0;
+
+    mpqemu_msg_send(&msg, dev->ioc, &local_err);
+    if (local_err) {
+        error_report("Error to send cmd to remote process %d",
+                     msg.cmd);
+    }
+
+    dev->virq = -1;
+
+    proxy_intx_update(pci_dev);
+
+    pci_device_set_intx_routing_notifier(pci_dev, proxy_intx_update);
+}
+
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 {
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
@@ -62,6 +115,8 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     qio_channel_set_blocking(dev->ioc, true, NULL);
 
     configure_memory_sync(&dev->sync, dev->ioc);
+
+    setup_irqfd(dev);
 }
 
 static void pci_proxy_dev_exit(PCIDevice *pdev)
@@ -71,6 +126,9 @@ static void pci_proxy_dev_exit(PCIDevice *pdev)
     qio_channel_close(dev->ioc, NULL);
 
     deconfigure_memory_sync(&dev->sync);
+
+    event_notifier_cleanup(&dev->intr);
+    event_notifier_cleanup(&dev->resample);
 }
 
 static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
diff --git a/include/hw/i386/remote-iohub.h b/include/hw/i386/remote-iohub.h
new file mode 100644
index 0000000000..cd59476cb7
--- /dev/null
+++ b/include/hw/i386/remote-iohub.h
@@ -0,0 +1,42 @@
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
+#include "hw/pci/pci.h"
+#include "qemu/event_notifier.h"
+#include "qemu/thread-posix.h"
+#include "io/mpqemu-link.h"
+
+#define REMOTE_IOHUB_NB_PIRQS    PCI_DEVFN_MAX
+
+typedef struct ResampleToken {
+    void *iohub;
+    int pirq;
+} ResampleToken;
+
+typedef struct RemoteIOHubState {
+    PCIDevice d;
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
+void remote_iohub_init(RemoteIOHubState *iohub);
+void remote_iohub_finalize(RemoteIOHubState *iohub);
+
+#endif
diff --git a/include/hw/i386/remote.h b/include/hw/i386/remote.h
index e21bd5f68f..65396d48db 100644
--- a/include/hw/i386/remote.h
+++ b/include/hw/i386/remote.h
@@ -15,11 +15,14 @@
 #include "hw/boards.h"
 #include "hw/pci-host/remote.h"
 #include "io/channel.h"
+#include "hw/i386/remote-iohub.h"
 
 typedef struct RemoteMachineState {
     MachineState parent_obj;
 
     RemotePCIHost *host;
+
+    RemoteIOHubState iohub;
 } RemoteMachineState;
 
 /* Used to pass to co-routine device and ioc. */
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
index d52e2cad8a..8e582d4432 100644
--- a/include/hw/pci/proxy.h
+++ b/include/hw/pci/proxy.h
@@ -12,6 +12,7 @@
 #include "hw/pci/pci.h"
 #include "io/channel.h"
 #include "hw/pci/memory-sync.h"
+#include "qemu/event_notifier.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
@@ -42,6 +43,10 @@ struct PCIProxyDev {
     QIOChannel *ioc;
     Error *migration_blocker;
     RemoteMemSync sync;
+    int virq;
+    EventNotifier intr;
+    EventNotifier resample;
+
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
 };
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 234ac82d39..4cf81f5237 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -38,6 +38,7 @@ typedef enum {
     PCI_CONFIG_READ,
     BAR_WRITE,
     BAR_READ,
+    SET_IRQFD,
     MPQEMU_CMD_MAX,
 } MPQemuCmd;
 
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 44c2875a13..86f2e61ab8 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -283,6 +283,11 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case SET_IRQFD:
+        if (msg->size || (msg->num_fds != 2)) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
2.25.GIT


