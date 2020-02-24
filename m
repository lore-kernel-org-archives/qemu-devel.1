Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D13C38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1096920CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CdeNDz/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1096920CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KwK-0006Gx-5o
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmG-0006XM-Pq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmE-0003CM-DN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmE-0003BL-3y
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqUG3017513;
 Mon, 24 Feb 2020 20:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=XkgDiRUc9I8z5UM0uQC8o7mvfjG2UMl9TsYhUav3JBY=;
 b=CdeNDz/b2sVcahG+b04m/mAVNl3SYfIYSM4Kh+VT8aoVfMiPWcaoPIv+7GzgEedeZoiO
 QwjtU9gGaSN8V5qQ7CM200sayjF1Sqrf4YT6ldU6YVsSS+uwwCx/ZLvHk42MSviBifOw
 HegvHIjIUFSGPyVS4LG4a6hgvDdG43dzxL/5UigxMHi45poi9WTeYrR2O0LzkSvNQ/jH
 B43GO6izEsTGpn4mivcuPkrQxXEkZWYOXvJrZ2bZX9JQeRDz3Z2/7At2cIU355cAR+bS
 uZPQZNj8Cx87g4Ya7koNXVwoQNghYBQQiC6Y1OoofYFW1dooBMSnYs6rMwSAsQTapu8J XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yavxrhyf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq6LT171346;
 Mon, 24 Feb 2020 20:56:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2ybdshkrvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:24 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKuMQG028496;
 Mon, 24 Feb 2020 20:56:23 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:22 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 17/50] multi-process: create IOHUB object to handle irq
Date: Mon, 24 Feb 2020 15:55:08 -0500
Message-Id: <a6bff9c50b61d068dd5d979f940ea00259df6370.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 01OKqUG3017513
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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

IOHUB object is added to manage PCI IRQs. It uses KVM_IRQFD
ioctl to create irqfd to injecting PCI interrupts to the guest.
IOHUB object forwards the irqfd to the remote process. Remote process
uses this fd to directly send interrupts to the guest, bypassing QEMU.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v4 -> v5:
  - Using event_notifier_test_and_clear
  - Using event_notifier_cleanup()
  - The token is not malloced

 Makefile.target               |   1 +
 hw/Makefile.objs              |   2 -
 hw/proxy/Makefile.objs        |   1 -
 hw/proxy/qemu-proxy.c         |  51 +++++++++++++++
 include/hw/pci/pci_ids.h      |   3 +
 include/hw/proxy/qemu-proxy.h |   8 +++
 include/io/mpqemu-link.h      |   8 +++
 include/remote/iohub.h        |  50 ++++++++++++++
 include/remote/machine.h      |   2 +
 remote/Makefile.objs          |   1 +
 remote/iohub.c                | 148 ++++++++++++++++++++++++++++++++++++=
++++++
 remote/machine.c              |  15 +++++
 remote/remote-main.c          |   4 ++
 13 files changed, 291 insertions(+), 3 deletions(-)
 delete mode 100644 hw/proxy/Makefile.objs
 create mode 100644 include/remote/iohub.h
 create mode 100644 remote/iohub.c

diff --git a/Makefile.target b/Makefile.target
index 271d883..c621d70 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -129,6 +129,7 @@ obj-y +=3D disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) +=3D gdbstub-xml.o
 ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
 obj-$(CONFIG_MPQEMU) +=3D hw/proxy/memory-sync.o
+obj-$(CONFIG_MPQEMU) +=3D hw/proxy/qemu-proxy.o
 endif
 LIBS :=3D $(libs_cpu) $(LIBS)
=20
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 7b489b1..af9235b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -45,8 +45,6 @@ endif
 common-obj-y +=3D $(devices-dirs-y)
 obj-y +=3D $(devices-dirs-y)
=20
-common-obj-$(CONFIG_MPQEMU) +=3D proxy/
-
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D core/
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D block/
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D pci/
diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
deleted file mode 100644
index eb81624..0000000
--- a/hw/proxy/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-common-obj-$(CONFIG_MPQEMU) +=3D qemu-proxy.o
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index d3a9d38..0cf7dcc 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -18,6 +18,9 @@
 #include "hw/proxy/qemu-proxy.h"
 #include "hw/proxy/memory-sync.h"
 #include "qom/object.h"
+#include "qemu/event_notifier.h"
+#include "sysemu/kvm.h"
+#include "util/event_notifier-posix.c"
=20
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
=20
@@ -215,6 +218,53 @@ static void pci_proxy_dev_register_types(void)
=20
 type_init(pci_proxy_dev_register_types)
=20
+static void proxy_intx_update(PCIDevice *pci_dev)
+{
+    PCIProxyDev *dev =3D PCI_PROXY_DEV(pci_dev);
+    PCIINTxRoute route;
+    int pin =3D pci_get_byte(pci_dev->config + PCI_INTERRUPT_PIN) - 1;
+
+    if (dev->irqfd.fd) {
+        dev->irqfd.flags =3D KVM_IRQFD_FLAG_DEASSIGN;
+        (void) kvm_vm_ioctl(kvm_state, KVM_IRQFD, &dev->irqfd);
+        memset(&dev->irqfd, 0, sizeof(struct kvm_irqfd));
+    }
+
+    route =3D pci_device_route_intx_to_irq(pci_dev, pin);
+
+    dev->irqfd.fd =3D event_notifier_get_fd(&dev->intr);
+    dev->irqfd.resamplefd =3D event_notifier_get_fd(&dev->resample);
+    dev->irqfd.gsi =3D route.irq;
+    dev->irqfd.flags |=3D KVM_IRQFD_FLAG_RESAMPLE;
+    (void) kvm_vm_ioctl(kvm_state, KVM_IRQFD, &dev->irqfd);
+}
+
+static void setup_irqfd(PCIProxyDev *dev)
+{
+    PCIDevice *pci_dev =3D PCI_DEVICE(dev);
+    MPQemuMsg msg;
+
+    event_notifier_init(&dev->intr, 0);
+    event_notifier_init(&dev->resample, 0);
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+    msg.cmd =3D SET_IRQFD;
+    msg.num_fds =3D 2;
+    msg.fds[0] =3D event_notifier_get_fd(&dev->intr);
+    msg.fds[1] =3D event_notifier_get_fd(&dev->resample);
+    msg.data1.set_irqfd.intx =3D
+        pci_get_byte(pci_dev->config + PCI_INTERRUPT_PIN) - 1;
+    msg.size =3D sizeof(msg.data1);
+
+    mpqemu_msg_send(&msg, dev->mpqemu_link->com);
+
+    memset(&dev->irqfd, 0, sizeof(struct kvm_irqfd));
+
+    proxy_intx_update(pci_dev);
+
+    pci_device_set_intx_routing_notifier(pci_dev, proxy_intx_update);
+}
+
 static void init_proxy(PCIDevice *dev, char *command, char *exec_name,
                        bool need_spawn, Error **errp)
 {
@@ -247,6 +297,7 @@ static void init_proxy(PCIDevice *dev, char *command,=
 char *exec_name,
                         pdev->socket);
=20
     configure_memory_sync(pdev->sync, pdev->mpqemu_link);
+    setup_irqfd(pdev);
 }
=20
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 11f8ab7..bd0c17d 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -192,6 +192,9 @@
 #define PCI_DEVICE_ID_SUN_SIMBA          0x5000
 #define PCI_DEVICE_ID_SUN_SABRE          0xa000
=20
+#define PCI_VENDOR_ID_ORACLE             0x108e
+#define PCI_DEVICE_ID_REMOTE_IOHUB       0xb000
+
 #define PCI_VENDOR_ID_CMD                0x1095
 #define PCI_DEVICE_ID_CMD_646            0x0646
=20
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.=
h
index c93ffe3..56aec0e 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -9,8 +9,11 @@
 #ifndef QEMU_PROXY_H
 #define QEMU_PROXY_H
=20
+#include <linux/kvm.h>
+
 #include "io/mpqemu-link.h"
 #include "hw/proxy/memory-sync.h"
+#include "qemu/event_notifier.h"
=20
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
=20
@@ -44,6 +47,11 @@ struct PCIProxyDev {
     MPQemuLinkState *mpqemu_link;
=20
     RemoteMemSync *sync;
+    struct kvm_irqfd irqfd;
+
+    EventNotifier intr;
+    EventNotifier resample;
+
     pid_t remote_pid;
     int socket;
=20
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 1a7738e..13c4b80 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -40,6 +40,8 @@
  * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
  * BAR_WRITE        Writes to PCI BAR region
  * BAR_READ         Reads from PCI BAR region
+ * SET_IRQFD        Sets the IRQFD to be used to raise interrupts direct=
ly
+ *                  from remote device
  *
  * proc_cmd_t enum type to specify the command to be executed on the rem=
ote
  * device.
@@ -51,6 +53,7 @@ typedef enum {
     SYNC_SYSMEM,
     BAR_WRITE,
     BAR_READ,
+    SET_IRQFD,
     MAX,
 } mpqemu_cmd_t;
=20
@@ -81,6 +84,10 @@ typedef struct {
 } bar_access_msg_t;
=20
 typedef struct {
+    int intx;
+} set_irqfd_msg_t;
+
+typedef struct {
     mpqemu_cmd_t cmd;
     int bytestream;
     size_t size;
@@ -89,6 +96,7 @@ typedef struct {
         uint64_t u64;
         sync_sysmem_msg_t sync_sysmem;
         bar_access_msg_t bar_access;
+        set_irqfd_msg_t set_irqfd;
     } data1;
=20
     int fds[REMOTE_MAX_FDS];
diff --git a/include/remote/iohub.h b/include/remote/iohub.h
new file mode 100644
index 0000000..7a488a8
--- /dev/null
+++ b/include/remote/iohub.h
@@ -0,0 +1,50 @@
+/*
+ * IO Hub for remote device
+ *
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
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
diff --git a/include/remote/machine.h b/include/remote/machine.h
index 7e9bdbe..300394a 100644
--- a/include/remote/machine.h
+++ b/include/remote/machine.h
@@ -16,11 +16,13 @@
 #include "hw/boards.h"
 #include "remote/pcihost.h"
 #include "qemu/notify.h"
+#include "remote/iohub.h"
=20
 typedef struct RemMachineState {
     MachineState parent_obj;
=20
     RemPCIHost *host;
+    RemoteIOHubState *iohub;
 } RemMachineState;
=20
 #define TYPE_REMOTE_MACHINE "remote-machine"
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index 13d4c48..cbb3065 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,3 +1,4 @@
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-main.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D pcihost.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D machine.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D iohub.o
diff --git a/remote/iohub.c b/remote/iohub.c
new file mode 100644
index 0000000..a991a4e
--- /dev/null
+++ b/remote/iohub.c
@@ -0,0 +1,148 @@
+/*
+ * Remote IO Hub
+ *
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
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
+    RemoteIOHubState *iohub =3D REMOTE_IOHUB_DEVICE(obj);
+    int slot, intx, pirq;
+
+    memset(&iohub->irqfds, 0, sizeof(iohub->irqfds));
+    memset(&iohub->resamplefds, 0, sizeof(iohub->resamplefds));
+
+    for (slot =3D 0; slot < PCI_SLOT_MAX; slot++) {
+        for (intx =3D 0; intx < PCI_NUM_PINS; intx++) {
+            iohub->irq_num[slot][intx] =3D (slot + intx) % 4 + 4;
+        }
+    }
+
+    for (pirq =3D 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
+        qemu_mutex_init(&iohub->irq_level_lock[pirq]);
+        iohub->irq_level[pirq] =3D 0;
+    }
+}
+
+static void remote_iohub_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+    k->vendor_id =3D PCI_VENDOR_ID_ORACLE;
+    k->device_id =3D PCI_DEVICE_ID_REMOTE_IOHUB;
+}
+
+static const TypeInfo remote_iohub_info =3D {
+    .name       =3D TYPE_REMOTE_IOHUB_DEVICE,
+    .parent     =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(RemoteIOHubState),
+    .instance_init =3D remote_iohub_initfn,
+    .class_init  =3D remote_iohub_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
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
+    BusState *bus =3D qdev_get_parent_bus(&pci_dev->qdev);
+    PCIBus *pci_bus =3D PCI_BUS(bus);
+    PCIDevice *pci_iohub =3D
+        pci_bus->devices[PCI_DEVFN(REMOTE_IOHUB_DEV, REMOTE_IOHUB_FUNC)]=
;
+    RemoteIOHubState *iohub =3D REMOTE_IOHUB_DEVICE(pci_iohub);
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
+    RemoteIOHubState *iohub =3D opaque;
+
+    assert(pirq >=3D 0);
+    assert(pirq < REMOTE_IOHUB_NB_PIRQS);
+
+    qemu_mutex_lock(&iohub->irq_level_lock[pirq]);
+
+    if (level) {
+        if (++iohub->irq_level[pirq] =3D=3D 1) {
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
+    ResampleToken *token =3D opaque;
+    RemoteIOHubState *iohub =3D token->iohub;
+    int pirq, s;
+
+    pirq =3D token->pirq;
+
+    s =3D event_notifier_test_and_clear(&iohub->resamplefds[pirq]);
+
+    assert(s >=3D 0);
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
+    RemMachineState *machine =3D REMOTE_MACHINE(current_machine);
+    RemoteIOHubState *iohub =3D machine->iohub;
+    int pirq =3D remote_iohub_map_irq(pci_dev, msg->data1.set_irqfd.intx=
);
+
+    assert(msg->num_fds =3D=3D 2);
+
+    if (event_notifier_get_fd(&iohub->irqfds[pirq]) !=3D -1) {
+        event_notifier_cleanup(&iohub->irqfds[pirq]);
+        event_notifier_cleanup(&iohub->resamplefds[pirq]);
+        memset(&iohub->token[pirq], 0, sizeof(ResampleToken));
+    }
+
+    event_notifier_init_fd(&iohub->irqfds[pirq], msg->fds[0]);
+    event_notifier_init_fd(&iohub->resamplefds[pirq], msg->fds[1]);
+
+    iohub->token[pirq].iohub =3D iohub;
+    iohub->token[pirq].pirq =3D pirq;
+
+    qemu_set_fd_handler(msg->fds[1], intr_resample_handler, NULL,
+                        &iohub->token[pirq]);
+}
diff --git a/remote/machine.c b/remote/machine.c
index 97e4f19..d529f68 100644
--- a/remote/machine.c
+++ b/remote/machine.c
@@ -25,12 +25,16 @@
 #include "qemu-common.h"
 #include "sysemu/sysemu.h"
 #include "qemu/notify.h"
+#include "hw/pci/pci_host.h"
+#include "remote/iohub.h"
=20
 static void remote_machine_init(Object *obj)
 {
     RemMachineState *s =3D REMOTE_MACHINE(obj);
     RemPCIHost *rem_host;
     MemoryRegion *system_memory, *system_io, *pci_memory;
+    PCIHostState *pci_host;
+    PCIDevice *pci_dev;
=20
     Error *error_abort =3D NULL;
=20
@@ -67,6 +71,17 @@ static void remote_machine_init(Object *obj)
     qemu_mutex_unlock_iothread();
=20
     qdev_init_nofail(DEVICE(rem_host));
+
+    pci_host =3D PCI_HOST_BRIDGE(rem_host);
+    pci_dev =3D pci_create_simple_multifunction(pci_host->bus,
+                                              PCI_DEVFN(REMOTE_IOHUB_DEV=
,
+                                                        REMOTE_IOHUB_FUN=
C),
+                                              true, TYPE_REMOTE_IOHUB_DE=
VICE);
+
+    s->iohub =3D REMOTE_IOHUB_DEVICE(pci_dev);
+
+    pci_bus_irqs(pci_host->bus, remote_iohub_set_irq, remote_iohub_map_i=
rq,
+                 s->iohub, REMOTE_IOHUB_NB_PIRQS);
 }
=20
 static const TypeInfo remote_machine =3D {
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 9512a3b..02d78a4 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -35,6 +35,7 @@
 #include "exec/ramlist.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
+#include "remote/iohub.h"
=20
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
@@ -172,6 +173,9 @@ static void process_msg(GIOCondition cond, MPQemuChan=
nel *chan)
             goto finalize_loop;
         }
         break;
+    case SET_IRQFD:
+        process_set_irqfd_msg(remote_pci_dev, msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
--=20
1.8.3.1


