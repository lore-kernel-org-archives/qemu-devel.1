Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22DFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC1320775
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="suhNdEi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC1320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEOe-0004dT-JE
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELM-0007lv-Nd
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELJ-000722-5D
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH3Cs1035251;
 Sat, 27 Jun 2020 17:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=EiS8sV+XCqIOMkkXkmdM8pLFO1eLmi3z+cRUnsXjNuU=;
 b=suhNdEi3C/Z5JcJ21folmDhesdn4cdROHXFey4mvpLTPIpX++8YtT50KTgfkTkq8sELi
 Bysm6r5YOtzRPWHodVjiCbzGHQ3OoCtNB8zkOpZMaZ1LsTTE8JTJow3EnEUCX+j28sjO
 bYjI68iqfh7Lcu2kP9HPK/bYZ88Wm4zz/UfUi0xu2MV2Agjz5NcTsP80DOrB0C7P1ky0
 49vCgxqEnnfL9BsSBsADOImQzbHarToGmcEq7i34pXZNK33W+2sFRmAa8cFzl4qb9Eid
 rD4JgUWRimWVgNDhoO33hPaAdYUbt/qv/53T67vXdE9+62Ri8Kirr7oZ/tgOOoK8YjAA XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 31wwhr9c9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:10:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH7afU195405;
 Sat, 27 Jun 2020 17:10:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 31wu7s8y31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:10:09 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05RHA7b7002851;
 Sat, 27 Jun 2020 17:10:07 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:10:07 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 11/21] multi-process: introduce proxy object
Date: Sat, 27 Jun 2020 10:09:33 -0700
Message-Id: <91d295b59735fab5b46959b489b1384cc13bdb67.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=1 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 cotscore=-2147483648
 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270123
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:03:10
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Defines a PCI Device proxy object as a child of TYPE_PCI_DEVICE.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 MAINTAINERS            |  2 ++
 hw/pci/Makefile.objs   |  1 +
 hw/pci/proxy.c         | 70 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/proxy.h | 43 ++++++++++++++++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 hw/pci/proxy.c
 create mode 100644 include/hw/pci/proxy.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 017c96eace..b48c3114c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2952,6 +2952,8 @@ F: include/io/mpqemu-link.h
 F: hw/i386/remote-msg.c
 F: include/hw/i386/remote-memory.h
 F: hw/i386/remote-memory.c
+F: hw/pci/proxy.c
+F: include/hw/pci/proxy.h
 
 Build and test automation
 -------------------------
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index c78f2fb24b..515dda506c 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -12,3 +12,4 @@ common-obj-$(CONFIG_PCI_EXPRESS) += pcie_port.o pcie_host.o
 
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
+obj-$(CONFIG_MPQEMU) += proxy.o
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
new file mode 100644
index 0000000000..6d62399c52
--- /dev/null
+++ b/hw/pci/proxy.c
@@ -0,0 +1,70 @@
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
+#include "hw/pci/proxy.h"
+#include "hw/pci/pci.h"
+#include "qapi/error.h"
+#include "io/channel-util.h"
+#include "hw/qdev-properties.h"
+#include "monitor/monitor.h"
+
+static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
+{
+    pdev->com = qio_channel_new_fd(fd, errp);
+}
+
+static Property proxy_properties[] = {
+    DEFINE_PROP_STRING("fd", PCIProxyDev, fd),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(device);
+    int proxyfd;
+
+    if (dev->fd) {
+        proxyfd = monitor_fd_param(cur_mon, dev->fd, errp);
+        if (proxyfd == -1) {
+            error_prepend(errp, "proxy: unable to parse proxyfd: ");
+            return;
+        }
+        proxy_set_socket(dev, proxyfd, errp);
+    }
+}
+
+static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = pci_proxy_dev_realize;
+    device_class_set_props(dc, proxy_properties);
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
diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
new file mode 100644
index 0000000000..c1c7142fa2
--- /dev/null
+++ b/include/hw/pci/proxy.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef PROXY_H
+#define PROXY_H
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "hw/pci/pci.h"
+#include "io/channel.h"
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
+    char *fd;
+    QIOChannel *com;
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
+#endif /* PROXY_H */
-- 
2.25.GIT


