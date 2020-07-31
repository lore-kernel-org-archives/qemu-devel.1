Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88751C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FC222B3F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hxd85FVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FC222B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Zg5-0003Sx-L5
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeN-0001k8-9b
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:20:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeI-0005JX-9E
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:20:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VID2kN110735;
 Fri, 31 Jul 2020 18:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=esnuSUsw+zutTCesko7PBcHnqXd9qZSK/UE6b2zHDZA=;
 b=Hxd85FVUOy5pQ9zjstVOVcMYmhTbwB9hKb/742BenP+sjJ1gmFtcbsZKZ+4wwEEmRgYC
 pSCTACb1lXN/IP78ZyUEDWYJdaLwrM/sXQZ6lDi1jjDPmNgbbX1guE9R2wBqoO7GJdpg
 EG1csCWptAKJCzxtQgOzikSogV9HYH0m7jeNspp6DOruj93FWyuGc4431Aq1OqwZoKKp
 WA27NZ0berMU105sj60jJX5WiK5m+Xyc1EGss2KEA2A4wzLwTUBFrL6kvoShePaUyQFc
 oMRP9hjDpaAkcjMeZF/RKkJHb4hk/4dW3TBBo+vWeZVxYLqcdTm7fa1GFQxgd1zK5biW Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 32hu1jtfy0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:20:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIIjVe080443;
 Fri, 31 Jul 2020 18:20:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 32mf70vdug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:20:42 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VIKfj7013242;
 Fri, 31 Jul 2020 18:20:41 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:20:40 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 03/20] multi-process: setup PCI host bridge for remote
 device
Date: Fri, 31 Jul 2020 14:20:10 -0400
Message-Id: <cd3a20960062081d7c911879f509c26aedee89b4.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=1 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310136
Received-SPF: pass client-ip=156.151.31.86; envelope-from=jag.raman@oracle.com;
 helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:51:59
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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

PCI host bridge is setup for the remote device process. It is
implemented using remote-pcihost object. It is an extension of the PCI
host bridge setup by QEMU.
Remote-pcihost configures a PCI bus which could be used by the remote
PCI device to latch on to.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS                  |  8 +++++
 hw/pci-host/Makefile.objs    |  1 +
 hw/pci-host/remote.c         | 76 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/remote.h | 30 +++++++++++++++++
 4 files changed, 115 insertions(+)
 create mode 100644 hw/pci-host/remote.c
 create mode 100644 include/hw/pci-host/remote.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3..d781a28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3035,6 +3035,14 @@ S: Maintained
 F: hw/semihosting/
 F: include/hw/semihosting/
 
+Multi-process QEMU
+M: Jagannathan Raman <jag.raman@oracle.com>
+M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
+M: John G Johnson <john.g.johnson@oracle.com>
+S: Maintained
+F: hw/pci-host/remote.c
+F: include/hw/pci-host/remote.h
+
 Build and test automation
 -------------------------
 Build and test automation
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index e422e0a..daf9007 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -18,6 +18,7 @@ common-obj-$(CONFIG_XEN_IGD_PASSTHROUGH) += xen_igd_pt.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) += gpex.o
 common-obj-$(CONFIG_PCI_EXPRESS_XILINX) += xilinx-pcie.o
+common-obj-$(CONFIG_MPQEMU) += remote.o
 
 common-obj-$(CONFIG_PCI_EXPRESS_DESIGNWARE) += designware.o
 obj-$(CONFIG_POWERNV) += pnv_phb4.o pnv_phb4_pec.o
diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
new file mode 100644
index 0000000..03c8e99
--- /dev/null
+++ b/hw/pci-host/remote.c
@@ -0,0 +1,76 @@
+/*
+ * Remote PCI host device
+ *
+ * Unlike PCI host devices that model physical hardware, the purpose
+ * of this PCI host is to host multi-process QEMU devices.
+ *
+ * Multi-process QEMU extends the PCI host of a QEMU machine into a
+ * remote process. Any PCI device attached to the remote process is
+ * visible in the QEMU guest. This allows existing QEMU device models
+ * to be reused in the remote process.
+ *
+ * This PCI host is purely a container for PCI devices. It's fake in the
+ * sense that the guest never sees this PCI host and has no way of
+ * accessing it. It's job is just to provide the environment that QEMU
+ * PCI device models need when running in a remote process.
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
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_host.h"
+#include "hw/qdev-properties.h"
+#include "hw/pci-host/remote.h"
+#include "exec/memory.h"
+
+static const char *remote_pcihost_root_bus_path(PCIHostState *host_bridge,
+                                                PCIBus *rootbus)
+{
+    return "0000:00";
+}
+
+static void remote_pcihost_realize(DeviceState *dev, Error **errp)
+{
+    char *busname = g_strdup_printf("remote-pci-%ld", (unsigned long)getpid());
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    RemotePCIHost *s = REMOTE_HOST_DEVICE(dev);
+
+    pci->bus = pci_root_bus_new(DEVICE(s), busname,
+                                s->mr_pci_mem, s->mr_sys_io,
+                                0, TYPE_PCIE_BUS);
+}
+
+static void remote_pcihost_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
+
+    hc->root_bus_path = remote_pcihost_root_bus_path;
+    dc->realize = remote_pcihost_realize;
+
+    dc->user_creatable = false;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+}
+
+static const TypeInfo remote_pcihost_info = {
+    .name = TYPE_REMOTE_HOST_DEVICE,
+    .parent = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(RemotePCIHost),
+    .class_init = remote_pcihost_class_init,
+};
+
+static void remote_pcihost_register(void)
+{
+    type_register_static(&remote_pcihost_info);
+}
+
+type_init(remote_pcihost_register)
diff --git a/include/hw/pci-host/remote.h b/include/hw/pci-host/remote.h
new file mode 100644
index 0000000..bab6d3c
--- /dev/null
+++ b/include/hw/pci-host/remote.h
@@ -0,0 +1,30 @@
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
+#include "exec/memory.h"
+#include "hw/pci/pcie_host.h"
+
+#define TYPE_REMOTE_HOST_DEVICE "remote-pcihost"
+#define REMOTE_HOST_DEVICE(obj) \
+    OBJECT_CHECK(RemotePCIHost, (obj), TYPE_REMOTE_HOST_DEVICE)
+
+typedef struct RemotePCIHost {
+    /*< private >*/
+    PCIExpressHost parent_obj;
+    /*< public >*/
+
+    MemoryRegion *mr_pci_mem;
+    MemoryRegion *mr_sys_io;
+} RemotePCIHost;
+
+#endif
-- 
1.8.3.1


