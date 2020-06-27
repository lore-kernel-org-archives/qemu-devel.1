Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36158C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F5820775
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b9UG8can"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F5820775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpER3-0000v6-66
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpEN2-00026c-0i
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:12:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpEMz-0007PS-9u
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:12:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH3CdX035248;
 Sat, 27 Jun 2020 17:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8jBsexkvQxh83psMhsVyE2MFL9w6fHrXrON3V1SYqsw=;
 b=b9UG8can3i5WPminnuo10l14m3hGyGgKB71Re/Fy4qWdWZzm56icp4fFYk3aOv/Uqpa2
 k4gZiMukbulQdiYgExGuITGs3DuHUFeSr4i/0UID3b7DpdzQSPayaQ1DnXSn/PmLrGbK
 ruwTjQUFlwwHpon7JwUpc8cNp1/woHdSFGCd06rcHCu+In91F/TlK+qU7zTkDwztOTB7
 T5c/al3cGc97WozRSsQPXsvdAso9bLnX21ht5h2+TGnvD01eg63YFFV5dbD9ueGnkSVM
 xLU+NoKmKzfdMamBzpHw/x9FQb7Smc4LrDDayIRW7xV14Q37ChTuJ0FWg03RFbeLXFPB LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 31wwhr9cbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:11:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8Pch081756;
 Sat, 27 Jun 2020 17:09:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 31wv59aw9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:09:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RH9qqh024140;
 Sat, 27 Jun 2020 17:09:52 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:09:51 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/21] multi-process: setup PCI host bridge for remote
 device
Date: Sat, 27 Jun 2020 10:09:25 -0700
Message-Id: <77bf485a3bbaeac83f3db50753fe45156ae7e882.1593273671.git.elena.ufimtseva@oracle.com>
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
 MAINTAINERS                  |  8 +++++
 hw/pci-host/Makefile.objs    |  1 +
 hw/pci-host/remote.c         | 63 ++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/remote.h | 34 +++++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 hw/pci-host/remote.c
 create mode 100644 include/hw/pci-host/remote.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b40446c73..e46f1960bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2938,6 +2938,14 @@ S: Maintained
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
index e422e0aca0..daf900710d 100644
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
index 0000000000..5ea9af4154
--- /dev/null
+++ b/hw/pci-host/remote.c
@@ -0,0 +1,63 @@
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
index 0000000000..3df1b53c17
--- /dev/null
+++ b/include/hw/pci-host/remote.h
@@ -0,0 +1,34 @@
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
+#include "qemu/osdep.h"
+#include "qemu-common.h"
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
+    MemoryRegion *mr_sys_mem;
+    MemoryRegion *mr_sys_io;
+} RemotePCIHost;
+
+#endif
-- 
2.25.GIT


