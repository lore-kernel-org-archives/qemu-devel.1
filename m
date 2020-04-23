Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54924C55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2234F2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bqjjutzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2234F2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTJW-00059A-9C
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGM-0000It-Vb
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGM-00076N-7C
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTGL-00074H-MJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4D96b052365;
 Thu, 23 Apr 2020 04:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AiQ1RpYaFlOBHYDF/bu6VaFRmP7GikM6S+vOB2axAb0=;
 b=bqjjutzi6bYNmreqTP4y7pTgky2FDQH5sW5awTOltplem/c3gm8k7LeuUinM8JgpeRZ3
 ZFycIKOL+A23NfDbNzl0WreXPHfDhPO+/BhPsfbBk216EIB5NAxDczl6gHdbROBI3bSN
 0o4h13DkL1mEe8W2pXg3xuwYVQIKa0Teg8oRDrmHfdMq1Gx/5den1EPZJI3AQymU8oEA
 6lBFhpEzuxfqlIKBmMbTEDOMyt3QF9pRsnQxO8sqkwJdl5Vq5VCElv4nYBFKEA2pupMN
 90NUeRh0ppWxFMjWIBUXE4iGn+nDHOfbOLeo/8DAqcUHWbHVc/1RDHISc6Qx/v6DSubT Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 30jhyc542c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DWN7168832;
 Thu, 23 Apr 2020 04:14:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 30gb942guj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:50 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4Enai017657;
 Thu, 23 Apr 2020 04:14:49 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:48 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 13/36] multi-process: setup PCI host bridge for
 remote device
Date: Wed, 22 Apr 2020 21:13:48 -0700
Message-Id: <ef096f6770e86ca13fe364cdab292927e8cef829.1587614626.git.elena.ufimtseva@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 clxscore=1015 suspectscore=1 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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

From: Jagannathan Raman <jag.raman@oracle.com>

PCI host bridge is setup for the remote device process. It is
implemented using remote-pcihost object. It is an extension of the PCI
host bridge setup by QEMU.
Remote-pcihost configures a PCI bus which could be used by the remote
 PCI device to latch on to.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS              |  2 ++
 hw/pci/Makefile.objs     |  2 +-
 include/remote/pcihost.h | 45 ++++++++++++++++++++++++++++
 remote/Makefile.objs     |  1 +
 remote/pcihost.c         | 64 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 include/remote/pcihost.h
 create mode 100644 remote/pcihost.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 93ad693da4..0cda5ee06a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2859,6 +2859,8 @@ F: remote/Makefile.objs
 F: remote/remote-main.c
 F: include/io/mpqemu-link.h
 F: io/mpqemu-link.c
+F: include/remote/pcihost.h
+F: remote/pcihost.c
 
 Build and test automation
 -------------------------
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index 955be54472..90693a7695 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -13,6 +13,6 @@ common-obj-$(CONFIG_PCI_EXPRESS) += pcie_port.o pcie_host.o
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
 
-remote-pci-obj-$(CONFIG_MPQEMU) += pci.o pci_bridge.o
+remote-pci-obj-$(CONFIG_MPQEMU) += pci.o pci_bridge.o pci_host.o pcie_host.o
 remote-pci-obj-$(CONFIG_MPQEMU) += msi.o msix.o
 remote-pci-obj-$(CONFIG_MPQEMU) += pcie.o
diff --git a/include/remote/pcihost.h b/include/remote/pcihost.h
new file mode 100644
index 0000000000..7aca9ccaf1
--- /dev/null
+++ b/include/remote/pcihost.h
@@ -0,0 +1,45 @@
+/*
+ * PCI Host for remote device
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_PCIHOST_H
+#define REMOTE_PCIHOST_H
+
+#include <stddef.h>
+#include <stdint.h>
+
+#include "exec/memory.h"
+#include "hw/pci/pcie_host.h"
+
+#define TYPE_REMOTE_HOST_DEVICE "remote-pcihost"
+#define REMOTE_HOST_DEVICE(obj) \
+    OBJECT_CHECK(RemPCIHost, (obj), TYPE_REMOTE_HOST_DEVICE)
+
+typedef struct RemPCIHost {
+    /*< private >*/
+    PCIExpressHost parent_obj;
+    /*< public >*/
+
+    /*
+     * Memory Controller Hub (MCH) may not be necessary for the emulation
+     * program. The two important reasons for implementing a PCI host in the
+     * emulation program are:
+     * - Provide a PCI bus for IO devices
+     * - Enable translation of guest PA to the PCI bar regions
+     *
+     * For both the above mentioned purposes, it doesn't look like we would
+     * need the MCH
+     */
+
+    MemoryRegion *mr_pci_mem;
+    MemoryRegion *mr_sys_mem;
+    MemoryRegion *mr_sys_io;
+} RemPCIHost;
+
+#endif
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index a9b2256b2a..2757f5a265 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1 +1,2 @@
 remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
+remote-pci-obj-$(CONFIG_MPQEMU) += pcihost.o
diff --git a/remote/pcihost.c b/remote/pcihost.c
new file mode 100644
index 0000000000..dbe081903e
--- /dev/null
+++ b/remote/pcihost.c
@@ -0,0 +1,64 @@
+/*
+ * Remote PCI host device
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_host.h"
+#include "hw/qdev-properties.h"
+#include "remote/pcihost.h"
+#include "exec/memory.h"
+
+static const char *remote_host_root_bus_path(PCIHostState *host_bridge,
+                                             PCIBus *rootbus)
+{
+    return "0000:00";
+}
+
+static void remote_host_realize(DeviceState *dev, Error **errp)
+{
+    char *busname = g_strdup_printf("remote-pci-%ld", (unsigned long)getpid());
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    RemPCIHost *s = REMOTE_HOST_DEVICE(dev);
+
+    pci->bus = pci_root_bus_new(DEVICE(s), busname,
+                                s->mr_pci_mem, s->mr_sys_io,
+                                0, TYPE_PCIE_BUS);
+}
+
+static void remote_host_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
+
+    hc->root_bus_path = remote_host_root_bus_path;
+    dc->realize = remote_host_realize;
+
+    dc->user_creatable = false;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+}
+
+static const TypeInfo remote_host_info = {
+    .name = TYPE_REMOTE_HOST_DEVICE,
+    .parent = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(RemPCIHost),
+    .class_init = remote_host_class_init,
+};
+
+static void remote_machine_register(void)
+{
+    type_register_static(&remote_host_info);
+}
+
+type_init(remote_machine_register)
-- 
2.25.GIT


