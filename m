Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B541C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DDC206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vYigjTGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DDC206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLONt-00070p-HO
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGf-0001mz-FW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGe-0002D7-6e
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGd-0002CI-U8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369dobT089398;
 Mon, 6 Apr 2020 09:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=E2poaPXRq0thx+nOqFvdQBZjmW7W6xIxA/hOatXPaB4=;
 b=vYigjTGiwcZ2D3+QqSsvm1lUuTI4e3gVIRcQ01ymWHRN3eJROF/lXC67BTdVaDPFhndZ
 PpxXzzWvLL6uQS35JyObMiIl5HIebg8bHZAQ1astlZDPMFkQwCNyb6bZRV0O6Tub0zHZ
 NIJgMYBc5obN0VWXtRIPzlnwL4/OdkJzUnSYF/mCYqHhx2QfWEYuRqFcME33xlZZ8fTl
 W4Ruh8BJFBrutQTD+J1rJMTVnKPeO3mLxydU7gEY+oJ0iaTChyeFLtGMK4qk4HQFBWQH
 ifbcbnEevlbwFhjl2PruXcHTW7tRuKnY/l1/Infiao0McKtd02qjx06HwVVhzBuuhnVl 0g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 306hnqwtx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cghc092199;
 Mon, 6 Apr 2020 09:42:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3073spk64f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369g0P6031832;
 Mon, 6 Apr 2020 09:42:00 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:00 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 17/36] multi-process: introduce proxy object
Date: Mon,  6 Apr 2020 02:41:07 -0700
Message-Id: <b2517f3d54c086fbc7269a632c1f6f7216b1d99a.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=1 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=1
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 0369dobT089398
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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

PCI Proxy Object registers as a PCI device with QEMU and forwards all
PCI accesses to the remote process using the communication channel.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 MAINTAINERS                   |  3 ++
 hw/Makefile.objs              |  2 ++
 hw/proxy/Makefile.objs        |  1 +
 hw/proxy/qemu-proxy.c         | 56 +++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h | 46 ++++++++++++++++++++++++++++
 include/io/mpqemu-link.h      |  1 +
 6 files changed, 109 insertions(+)
 create mode 100644 hw/proxy/Makefile.objs
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/qemu-proxy.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b46ec2e71..e2ac5b08a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2825,6 +2825,9 @@ F: include/remote/machine.h
 F: remote/machine.c
 F: include/remote/memory.h
 F: remote/memory.c
+F: hw/proxy/Makefile.objs
+F: hw/proxy/qemu-proxy.c
+F: include/hw/proxy/qemu-proxy.h
=20
 Build and test automation
 -------------------------
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index af9235b6f2..7b489b12a5 100644
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
index 0000000000..eb81624cf8
--- /dev/null
+++ b/hw/proxy/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_MPQEMU) +=3D qemu-proxy.o
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
new file mode 100644
index 0000000000..bf6c4117ef
--- /dev/null
+++ b/hw/proxy/qemu-proxy.c
@@ -0,0 +1,56 @@
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
+#include "qemu-common.h"
+
+#include "qapi/error.h"
+#include "io/mpqemu-link.h"
+#include "hw/proxy/qemu-proxy.h"
+#include "hw/pci/pci.h"
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
+}
+
+static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->realize =3D pci_proxy_dev_realize;
+}
+
+static const TypeInfo pci_proxy_dev_type_info =3D {
+    .name          =3D TYPE_PCI_PROXY_DEV,
+    .parent        =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(PCIProxyDev),
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
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.=
h
new file mode 100644
index 0000000000..d7eaf26f29
--- /dev/null
+++ b/include/hw/proxy/qemu-proxy.h
@@ -0,0 +1,46 @@
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
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "io/mpqemu-link.h"
+#include "hw/pci/pci.h"
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
+    int socket;
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
index d46cb81058..73cc59b874 100644
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
--=20
2.25.GIT


