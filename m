Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22414C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8C620CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KftiRQgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8C620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KyU-0001D6-15
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmB-0006JO-0v
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km8-00034t-Pk
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Km8-00033s-Fe
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrgcg164180;
 Mon, 24 Feb 2020 20:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=yKz45Eb+loFnirKzQAZdSGDq5E8OjxdEbf9hqkMJUVY=;
 b=KftiRQgAiBB3G4PqQCtCQ2UqI4y/Rp88L7HFMznptNHLHNGRFr7suQdbPVCapC8G/d6O
 nKDWsO80JrEQ1xH2d+pgrgD7iHKngYXzF0BJU/2w3qbnqUMSpEh9wmHenOWJU5M9aHJ6
 /UC4PeAteah+GNq7jLV26KzCg70gkZa13/UYPJ9ll6Ur2Ee5fd/jn4Jmjd4HlxwnICiw
 ntrJ4yiDX3fQeks8GjWL85q4WKfDpfYtfj1VXZ4yoC26PiL87wOmsZxdPLz8TP0xYsq/
 TD1YPeR2MPBIocQH7Syjp1JL2KyHHSadM81n7kNw2Sb9z974QiO9vhxCOWX+l42RTkqv PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p93x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqfLZ090002;
 Mon, 24 Feb 2020 20:56:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yby5dmayh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:18 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKuGX3028367;
 Mon, 24 Feb 2020 20:56:16 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:16 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/50] multi-process: introduce proxy object
Date: Mon, 24 Feb 2020 15:55:04 -0500
Message-Id: <be851ebe99e510a78fae2f9285ba528b51fca07b.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 01OKrgcg164180
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
 v4 -> v5:
  - Switched to execv

 hw/Makefile.objs              |   2 +
 hw/proxy/Makefile.objs        |   1 +
 hw/proxy/qemu-proxy.c         | 226 ++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/proxy/qemu-proxy.h |  54 ++++++++++
 include/io/mpqemu-link.h      |   1 +
 remote/remote-main.c          |  28 ++++++
 6 files changed, 312 insertions(+)
 create mode 100644 hw/proxy/Makefile.objs
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/qemu-proxy.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index af9235b..7b489b1 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -45,6 +45,8 @@ endif
 common-obj-y +=3D $(devices-dirs-y)
 obj-y +=3D $(devices-dirs-y)
=20
+common-obj-$(CONFIG_MPQEMU) +=3D proxy/
+
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D core/
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D block/
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D pci/
diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
new file mode 100644
index 0000000..eb81624
--- /dev/null
+++ b/hw/proxy/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_MPQEMU) +=3D qemu-proxy.o
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
new file mode 100644
index 0000000..828bbd7
--- /dev/null
+++ b/hw/proxy/qemu-proxy.c
@@ -0,0 +1,226 @@
+/*
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "io/mpqemu-link.h"
+#include "exec/memory.h"
+#include "exec/cpu-common.h"
+#include "exec/address-spaces.h"
+#include "hw/pci/pci.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
+#include "hw/proxy/qemu-proxy.h"
+
+static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
+
+static int remote_spawn(PCIProxyDev *pdev, const char *opts,
+                        const char *exec_name, Error **errp)
+{
+    char *args[3];
+    pid_t rpid;
+    int fd[2] =3D {-1, -1};
+    Error *local_error =3D NULL;
+    int rc =3D -EINVAL;
+
+    if (pdev->managed) {
+        /* Child is forked by external program (such as libvirt). */
+        error_setg(errp, "Remote processed is managed and launched by ex=
ternal program");
+        return -1;
+    }
+
+    if (!exec_name) {
+        error_setg(errp, "The remote exec name is NULL.");
+        return rc;
+    }
+
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
+        error_setg(errp, "Unable to create unix socket.");
+        return -1;
+    }
+    /* TODO: Restrict the forked process' permissions and capabilities. =
*/
+    rpid =3D qemu_fork(&local_error);
+
+    if (rpid =3D=3D -1) {
+        error_setg(errp, "Unable to spawn emulation program.");
+        close(fd[0]);
+        close(fd[1]);
+        return -1;
+    }
+
+    if (rpid =3D=3D 0) {
+        close(fd[0]);
+
+        args[0] =3D g_strdup(exec_name);
+        args[1] =3D g_strdup_printf("%d", fd[1]);
+        args[2] =3D NULL;
+        execvp(args[0], (char *const *)args);
+        exit(1);
+    }
+    pdev->remote_pid =3D rpid;
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
+    pdev =3D PCI_PROXY_DEV(dev);
+
+    return pdev->socket;
+}
+
+static void set_proxy_sock(PCIDevice *dev, int socket)
+{
+    PCIProxyDev *pdev;
+
+    pdev =3D PCI_PROXY_DEV(dev);
+
+    pdev->socket =3D socket;
+    pdev->managed =3D true;
+}
+
+static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val=
, int l,
+                          unsigned int op)
+{
+    MPQemuMsg msg;
+    struct conf_data_msg conf_data;
+    int wait;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+    conf_data.addr =3D addr;
+    conf_data.val =3D (op =3D=3D PCI_CONFIG_WRITE) ? *val : 0;
+    conf_data.l =3D l;
+
+    msg.data2 =3D (uint8_t *)&conf_data;
+    if (!msg.data2) {
+        return -ENOMEM;
+    }
+
+    msg.size =3D sizeof(conf_data);
+    msg.cmd =3D op;
+    msg.bytestream =3D 1;
+
+    if (op =3D=3D PCI_CONFIG_WRITE) {
+        msg.num_fds =3D 0;
+    } else {
+        /* TODO: Dont create fd each time for send. */
+        wait =3D GET_REMOTE_WAIT;
+        msg.num_fds =3D 1;
+        msg.fds[0] =3D wait;
+    }
+
+    mpqemu_msg_send(&msg, dev->mpqemu_link->com);
+
+    if (op =3D=3D PCI_CONFIG_READ) {
+        *val =3D (uint32_t)wait_for_remote(wait);
+        PUT_REMOTE_WAIT(wait);
+    }
+
+    return 0;
+}
+
+static uint32_t pci_proxy_read_config(PCIDevice *d, uint32_t addr, int l=
en)
+{
+    uint32_t val;
+
+    (void)pci_default_read_config(d, addr, len);
+
+    config_op_send(PCI_PROXY_DEV(d), addr, &val, len, PCI_CONFIG_READ);
+
+    return val;
+}
+
+static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t=
 val,
+                                   int l)
+{
+    pci_default_write_config(d, addr, val, l);
+
+    config_op_send(PCI_PROXY_DEV(d), addr, &val, l, PCI_CONFIG_WRITE);
+}
+
+static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->realize =3D pci_proxy_dev_realize;
+    k->config_read =3D pci_proxy_read_config;
+    k->config_write =3D pci_proxy_write_config;
+}
+
+static const TypeInfo pci_proxy_dev_type_info =3D {
+    .name          =3D TYPE_PCI_PROXY_DEV,
+    .parent        =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(PCIProxyDev),
+    .abstract      =3D true,
+    .class_size    =3D sizeof(PCIProxyDevClass),
+    .class_init    =3D pci_proxy_dev_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
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
+static void init_proxy(PCIDevice *dev, char *command, char *exec_name,
+                       Error **errp)
+{
+    PCIProxyDev *pdev =3D PCI_PROXY_DEV(dev);
+    Error *local_error =3D NULL;
+
+    if (!pdev->managed) {
+        if (command) {
+            remote_spawn(pdev, command, exec_name, &local_error);
+        } else {
+            return;
+        }
+    } else {
+        pdev->remote_pid =3D atoi(pdev->rid);
+        if (pdev->remote_pid =3D=3D -1) {
+            error_setg(errp, "Remote PID is -1");
+            return;
+        }
+    }
+
+    pdev->mpqemu_link =3D mpqemu_link_create();
+
+    if (!pdev->mpqemu_link) {
+        error_setg(errp, "Failed to create proxy link");
+        return;
+    }
+
+    mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
+                        pdev->socket);
+}
+
+static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
+{
+    PCIProxyDev *dev =3D PCI_PROXY_DEV(device);
+    PCIProxyDevClass *k =3D PCI_PROXY_DEV_GET_CLASS(dev);
+    Error *local_err =3D NULL;
+
+    if (k->realize) {
+        k->realize(dev, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+        }
+    }
+
+    dev->set_proxy_sock =3D set_proxy_sock;
+    dev->get_proxy_sock =3D get_proxy_sock;
+    dev->init_proxy =3D init_proxy;
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.=
h
new file mode 100644
index 0000000..28b0114
--- /dev/null
+++ b/include/hw/proxy/qemu-proxy.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_PROXY_H
+#define QEMU_PROXY_H
+
+#include "io/mpqemu-link.h"
+
+#define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
+
+#define PCI_PROXY_DEV(obj) \
+            OBJECT_CHECK(PCIProxyDev, (obj), TYPE_PCI_PROXY_DEV)
+
+#define PCI_PROXY_DEV_CLASS(klass) \
+            OBJECT_CLASS_CHECK(PCIProxyDevClass, (klass), TYPE_PCI_PROXY=
_DEV)
+
+#define PCI_PROXY_DEV_GET_CLASS(obj) \
+            OBJECT_GET_CLASS(PCIProxyDevClass, (obj), TYPE_PCI_PROXY_DEV=
)
+
+typedef struct PCIProxyDev {
+    PCIDevice parent_dev;
+
+    MPQemuLinkState *mpqemu_link;
+
+    pid_t remote_pid;
+    int socket;
+
+    char *rid;
+
+    bool managed;
+
+    void (*set_proxy_sock) (PCIDevice *dev, int socket);
+    int (*get_proxy_sock) (PCIDevice *dev);
+
+    void (*proxy_ready) (PCIDevice *dev);
+    void (*init_proxy) (PCIDevice *dev, char *command, char *exec_name,
+                        Error **errp);
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
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 78c0818..5a2be48 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
=20
+#include "sys/eventfd.h"
 #include "qom/object.h"
 #include "qemu/thread.h"
 #include "exec/cpu-common.h"
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 56315cd..7b4cf2f 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -37,6 +37,32 @@
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
=20
+static void process_config_write(MPQemuMsg *msg)
+{
+    struct conf_data_msg *conf =3D (struct conf_data_msg *)msg->data2;
+
+    qemu_mutex_lock_iothread();
+    pci_default_write_config(remote_pci_dev, conf->addr, conf->val, conf=
->l);
+    qemu_mutex_unlock_iothread();
+}
+
+static void process_config_read(MPQemuMsg *msg)
+{
+    struct conf_data_msg *conf =3D (struct conf_data_msg *)msg->data2;
+    uint32_t val;
+    int wait;
+
+    wait =3D msg->fds[0];
+
+    qemu_mutex_lock_iothread();
+    val =3D pci_default_read_config(remote_pci_dev, conf->addr, conf->l)=
;
+    qemu_mutex_unlock_iothread();
+
+    notify_proxy(wait, val);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static void process_msg(GIOCondition cond, MPQemuChannel *chan)
 {
     MPQemuMsg *msg =3D NULL;
@@ -57,8 +83,10 @@ static void process_msg(GIOCondition cond, MPQemuChann=
el *chan)
     case INIT:
         break;
     case PCI_CONFIG_WRITE:
+        process_config_write(msg);
         break;
     case PCI_CONFIG_READ:
+        process_config_read(msg);
         break;
     default:
         error_setg(&err, "Unknown command");
--=20
1.8.3.1


