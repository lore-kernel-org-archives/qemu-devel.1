Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A8C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C632071C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mVWWlq7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C632071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTX7-0002J4-7g
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIP-0003jp-RY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIP-0002sI-2z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTIO-0002rS-JQ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4D662131726;
 Thu, 23 Apr 2020 04:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0x+eW1mXSMBhr3TOWb46bj3MEZQ2/IfA95/xykZgdDk=;
 b=mVWWlq7l+FK9xwjvWMBSokvekJEla2dRKDJeTxwtb+ynZJQ/hr6bPK5CIgMKm08Wgcwu
 kzQF0BHMhFrojedXqGSz65FnhAmJT46AxXtoez8G6YBpO5p2F8LTwIuTKiT//VrMbCNR
 eoaOIYgzFo5C6oelK27PdpruxBGZaY6VirVRWXsRNQOqu4aoJeP04Om/1F7HMAGzMh+m
 tzRN6j8HstTu9Z1OlMtDg7howjc38df86cbMTB8IAFxiM61eTdCMxUNFhyoMdg11Ngby
 HYe1ZaRKw78gd86gusMCOz8eQbrjlxvA8tmTrhBiI6OoAdkeegFQjpBBIFXqPfPEFXTU 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 30jvq4s94n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:16:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DbbI168988;
 Thu, 23 Apr 2020 04:14:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 30gb942gyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:58 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03N4EuCw020821;
 Thu, 23 Apr 2020 04:14:56 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:56 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 17/36] multi-process: introduce proxy object
Date: Wed, 22 Apr 2020 21:13:52 -0700
Message-Id: <53e7ef183df66e34aa20c026b6bf299b1726ad75.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 suspectscore=1 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
index 96f8d7ff19..3da3dcd311 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2866,6 +2866,9 @@ F: include/remote/machine.h
 F: remote/machine.c
 F: include/remote/memory.h
 F: remote/memory.c
+F: hw/proxy/Makefile.objs
+F: hw/proxy/qemu-proxy.c
+F: include/hw/proxy/qemu-proxy.h
 
 Build and test automation
 -------------------------
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index af9235b6f2..7b489b12a5 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -45,6 +45,8 @@ endif
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
index 0000000000..bf6c4117ef
--- /dev/null
+++ b/hw/proxy/qemu-proxy.c
@@ -0,0 +1,56 @@
+/*
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
+#include "qapi/error.h"
+#include "io/mpqemu-link.h"
+#include "hw/proxy/qemu-proxy.h"
+#include "hw/pci/pci.h"
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
+}
+
+static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = pci_proxy_dev_realize;
+}
+
+static const TypeInfo pci_proxy_dev_type_info = {
+    .name          = TYPE_PCI_PROXY_DEV,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIProxyDev),
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
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
new file mode 100644
index 0000000000..d7eaf26f29
--- /dev/null
+++ b/include/hw/proxy/qemu-proxy.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+            OBJECT_CLASS_CHECK(PCIProxyDevClass, (klass), TYPE_PCI_PROXY_DEV)
+
+#define PCI_PROXY_DEV_GET_CLASS(obj) \
+            OBJECT_GET_CLASS(PCIProxyDevClass, (obj), TYPE_PCI_PROXY_DEV)
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
 
+#include "sys/eventfd.h"
 #include "qom/object.h"
 #include "qemu/thread.h"
 #include "exec/cpu-common.h"
-- 
2.25.GIT


