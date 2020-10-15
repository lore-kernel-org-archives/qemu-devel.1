Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11220C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEFA22240
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VezYsWuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEFA22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7hX-0004qb-6D
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dL-0008Ds-AB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dJ-0002LH-2n
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI4RrI104469;
 Thu, 15 Oct 2020 18:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=sqH7F7m1a3mLRdRAN3zvvJ+huKz5125FnfJIdyHz9uo=;
 b=VezYsWuGexuaMOjWR0rVXTQdfyIwc2GCZKAM0mm6drxE6W0jlzHDUXGI1jKATbmJndc3
 cJSGxxKTUYt8kI1WL+RyRsZIwCP/XjiOzgzqLO4gNmvYoh0jOBFnAW7EUvGk/VJFt8Rt
 U5X31pwd4YAKtnd8zT2rPefHCAkOJ+CXcePkugqiFvpO8R1gscn8uwD607OytT0rpXBR
 JDV2/zc79vap/HHfyCujIEV1z8i9ycBbHczZyEOPKTEMATT6bVWJRKxE3THxi48QRjxk
 J/o34CyfZ8ampf/DLmu6nbNIse8k8DqeDlZGbfwBE/WBYACkvjqCGw/NOGRBMv7ORvgy Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 343vaemhmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:05:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI4eKV184648;
 Thu, 15 Oct 2020 18:05:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 343pw0qha2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 18:05:37 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FI5aSR007901;
 Thu, 15 Oct 2020 18:05:36 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 11:05:36 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 10/19] multi-process: introduce proxy object
Date: Thu, 15 Oct 2020 14:05:03 -0400
Message-Id: <d761d6e7baeb6b848241effcd98fd5e42da1974a.1602784930.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=4 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=4 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 14:05:35
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
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
 hw/pci/meson.build     |  1 +
 hw/pci/proxy.c         | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/proxy.h | 36 +++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 hw/pci/proxy.c
 create mode 100644 include/hw/pci/proxy.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4aa00ec..202db86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3111,6 +3111,8 @@ F: include/hw/i386/remote-obj.h
 F: hw/i386/remote-obj.c
 F: include/hw/i386/remote-memory.h
 F: hw/i386/remote-memory.c
+F: hw/pci/proxy.c
+F: include/hw/pci/proxy.h
 
 Build and test automation
 -------------------------
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index 5c4bbac..0df3017 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -12,6 +12,7 @@ pci_ss.add(files(
 # allow plugging PCIe devices into PCI buses, include them even if
 # CONFIG_PCI_EXPRESS=n.
 pci_ss.add(files('pcie.c', 'pcie_aer.c'))
+pci_ss.add(when: 'CONFIG_MPQEMU', if_true: files('proxy.c'))
 softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
 softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
new file mode 100644
index 0000000..7a12f23
--- /dev/null
+++ b/hw/pci/proxy.c
@@ -0,0 +1,98 @@
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
+#include "migration/blocker.h"
+
+static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
+{
+    pdev->ioc = qio_channel_new_fd(fd, errp);
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
+    int fd;
+
+    if (dev->fd) {
+        fd = monitor_fd_param(monitor_cur(), dev->fd, errp);
+        if (fd == -1) {
+            error_prepend(errp, "proxy: unable to parse fd: ");
+            return;
+        }
+        proxy_set_socket(dev, fd, errp);
+    } else {
+        error_setg(errp, "fd parameter not specified for %s",
+                   DEVICE(device)->id);
+        return;
+    }
+
+    error_setg(&dev->migration_blocker, "%s does not support migration",
+               TYPE_PCI_PROXY_DEV);
+    if (migrate_add_blocker(dev->migration_blocker, errp)) {
+        error_free(dev->migration_blocker);
+        error_free(*errp);
+        dev->migration_blocker = NULL;
+        error_setg(errp, "Failed to set migration blocker");
+    }
+
+    qemu_mutex_init(&dev->io_mutex);
+    qio_channel_set_blocking(dev->ioc, true, NULL);
+}
+
+static void pci_proxy_dev_exit(PCIDevice *pdev)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(pdev);
+
+    qio_channel_close(dev->ioc, NULL);
+
+    migrate_del_blocker(dev->migration_blocker);
+
+    error_free(dev->migration_blocker);
+}
+
+static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = pci_proxy_dev_realize;
+    k->exit = pci_proxy_dev_exit;
+    device_class_set_props(dc, proxy_properties);
+}
+
+static const TypeInfo pci_proxy_dev_type_info = {
+    .name          = TYPE_PCI_PROXY_DEV,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIProxyDev),
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
index 0000000..923432a
--- /dev/null
+++ b/include/hw/pci/proxy.h
@@ -0,0 +1,36 @@
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
+#include "hw/pci/pci.h"
+#include "io/channel.h"
+
+#define TYPE_PCI_PROXY_DEV "x-pci-proxy-dev"
+
+#define PCI_PROXY_DEV(obj) \
+            OBJECT_CHECK(PCIProxyDev, (obj), TYPE_PCI_PROXY_DEV)
+typedef struct PCIProxyDev PCIProxyDev;
+
+struct PCIProxyDev {
+    PCIDevice parent_dev;
+    char *fd;
+
+    /*
+     * Mutex used to protect the QIOChannel fd from
+     * the concurrent access by the VCPUs since proxy
+     * blocks while awaiting for the replies from the
+     * process remote.
+     */
+    QemuMutex io_mutex;
+    QIOChannel *ioc;
+    Error *migration_blocker;
+};
+
+#endif /* PROXY_H */
-- 
1.8.3.1


