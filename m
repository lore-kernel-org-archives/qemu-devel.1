Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA715C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FAD22B4B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JeFqmhWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FAD22B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMPn-0002E2-U0
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOP-0000cX-Gj
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:12:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMON-0007B9-C1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:12:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI5LRM074576;
 Thu, 27 Aug 2020 18:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=l5u52zClrterffntDEYYrIYcvH2Wt/T+koORkbvH8gY=;
 b=JeFqmhWCLTuiaNe/+67jc75Bztsf6yRak30K702oKIqmnDxwPzdrXxaCOf8noJDp0qT2
 oQzmDX/3DHLY5D5Sb36nV7f5LEkx6i9yJ2NX/JWatBqXk5f4cn6vW+QZCAUNergKfBCH
 lsITeJuc8JLFqjIgoDmu9kCnEPi1+qLO47qBD0tdfMB3vcRNbE4lWPwjG+rF6KLkFI4i
 6qe6oILAxns2JNd9ngh1C0FZ+j2oUNVGPNYXNXSlAiXzK3bh1CoSdXOLyd3HlGTGFZhV
 3vc4z25fSQrBcRGJ5dvFD9GTzhXQWaeSYlTU2r9QiYIluPRDYorwgd7/bZuD5IwR1ss1 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 333w6u6hgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Aug 2020 18:12:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI6KU0157339;
 Thu, 27 Aug 2020 18:12:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 333rudn5sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 18:12:46 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07RICjgm025203;
 Thu, 27 Aug 2020 18:12:45 GMT
Received: from flaka.hsd1.ca.comcast.net (/10.159.136.159)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Aug 2020 11:12:45 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v9 03/20] multi-process: setup PCI host bridge for remote
 device
Date: Thu, 27 Aug 2020 11:12:14 -0700
Message-Id: <20200827181231.22778-4-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 bulkscore=0 suspectscore=1 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270136
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 14:08:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
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
 MAINTAINERS                  |  8 ++++
 hw/pci-host/meson.build      |  1 +
 hw/pci-host/remote.c         | 75 ++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/remote.h | 30 +++++++++++++++
 4 files changed, 114 insertions(+)
 create mode 100644 hw/pci-host/remote.c
 create mode 100644 include/hw/pci-host/remote.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a22c8be42..76cff0fc12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3036,6 +3036,14 @@ S: Maintained
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
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index cd52f6ff1c..85d8b3db3d 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -8,6 +8,7 @@ pci_ss.add(when: 'CONFIG_PCI_EXPRESS_XILINX', if_true: files('xilinx-pcie.c'))
 pci_ss.add(when: 'CONFIG_PCI_I440FX', if_true: files('i440fx.c'))
 pci_ss.add(when: 'CONFIG_PCI_SABRE', if_true: files('sabre.c'))
 pci_ss.add(when: 'CONFIG_XEN_IGD_PASSTHROUGH', if_true: files('xen_igd_pt.c'))
+pci_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote.c'))
 
 # PPC devices
 pci_ss.add(when: 'CONFIG_PREP_PCI', if_true: files('prep.c'))
diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
new file mode 100644
index 0000000000..11325e2207
--- /dev/null
+++ b/hw/pci-host/remote.c
@@ -0,0 +1,75 @@
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
+ * accessing it. Its job is just to provide the environment that QEMU
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
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    RemotePCIHost *s = REMOTE_HOST_DEVICE(dev);
+
+    pci->bus = pci_root_bus_new(DEVICE(s), "remote-pci",
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
index 0000000000..bab6d3c4f0
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
2.25.GIT


