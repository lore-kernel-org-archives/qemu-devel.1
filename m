Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9692BC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFA024762
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0AjkyLlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFA024762
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmIg-0001g9-Ud
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kXmGg-0008P5-GL
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:17:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kXmGY-0006aF-Er
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:17:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SEFGNP184130;
 Wed, 28 Oct 2020 14:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=2jWhxRAAeo7FA5r8MyZFsleSWTDh0MrueMSJbLE2EG8=;
 b=0AjkyLlqtmFReqLPSjVm55ja8vOTn8/HfEqX5YTSeniVOHiyEl3/cuWbgkvR4+CkO2W8
 MSD6tc1vvWc35NDecJVLzz4wgzWRF8eirUAQ55CTR+2Qg0DjowUx35TDDXCuciKex951
 elwtZxI/Uqx99yW7EUdai4UOT6yaxrtqdqn68dydBeXySglxDCZkFmUUvFsPiTlVlmn+
 FJ1ClKioRC1+sEjC8gTa5ezEhDVwIiIouwqSCIS5yUVvJBpESPp03oSBHJvTxtds+VCV
 XyxU/SS1ylDJEkbeb8ziLeP1HcdgU3ATO1FizqW35aEcpf6frIAwFmKOtXbNXHm3ztgJ Vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 34c9sayt51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Oct 2020 14:17:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SEA6pN027626;
 Wed, 28 Oct 2020 14:15:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 34cx5yces1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2020 14:15:28 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09SEFRhh011481;
 Wed, 28 Oct 2020 14:15:27 GMT
Received: from mihai.localdomain (/10.153.73.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 28 Oct 2020 07:15:27 -0700
From: Mihai Carabas <mihai.carabas@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] hw/misc/pvpanic: Add the PCI interface
Date: Wed, 28 Oct 2020 15:32:56 +0200
Message-Id: <1603891979-11961-4-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603891979-11961-1-git-send-email-mihai.carabas@oracle.com>
References: <1603891979-11961-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=999
 suspectscore=2 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=2
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280097
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=mihai.carabas@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 10:17:29
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
Cc: Mihai Carabas <mihai.carabas@oracle.com>, Peng Hao <peng.hao2@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peng Hao <peng.hao2@zte.com.cn>

Add pvpanic new type "TYPE_PVPANIC_PCI".

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 hw/misc/pvpanic.c         | 64 ++++++++++++++++++++++++++++++++++++++++++++---
 include/hw/misc/pvpanic.h |  1 +
 include/hw/pci/pci.h      |  1 +
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 2e085f4..b0bf7d4 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -2,10 +2,12 @@
  * QEMU simulated pvpanic device.
  *
  * Copyright Fujitsu, Corp. 2013
+ * Copyright (c) 2018 ZTE Ltd.
  *
  * Authors:
  *     Wen Congyang <wency@cn.fujitsu.com>
  *     Hu Tao <hutao@cn.fujitsu.com>
+ *     Peng Hao <peng.hao2@zte.com.cn>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -21,6 +23,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
+#include "hw/pci/pci.h"
 
 /* The bit of supported pv event, TODO: include uapi header and remove this */
 #define PVPANIC_F_PANICKED      0
@@ -34,6 +37,10 @@ typedef struct PVPanicISAState PVPanicISAState;
 DECLARE_INSTANCE_CHECKER(PVPanicISAState, PVPANIC_ISA_DEVICE,
                          TYPE_PVPANIC_ISA)
 
+typedef struct PVPanicPCIState PVPanicPCIState;
+DECLARE_INSTANCE_CHECKER(PVPanicPCIState, PVPANIC_PCI_DEVICE,
+                         TYPE_PVPANIC_PCI)
+
 static void handle_event(int event)
 {
     static bool logged;
@@ -67,21 +74,32 @@ struct PVPanicISAState {
     uint16_t ioport;
 };
 
+/* PVPanicPCIState for PCI device and
+ * use mmio.
+ */
+typedef struct PVPanicPCIState {
+    /*< private>*/
+    PCIDevice dev;
+
+    /*<public>*/
+    MemoryRegion mr;
+} PVPanicPCIState;
+
 /* return supported events on read */
-static uint64_t pvpanic_ioport_read(void *opaque, hwaddr addr, unsigned size)
+static uint64_t pvpanic_read(void *opaque, hwaddr addr, unsigned size)
 {
     return PVPANIC_PANICKED;
 }
 
-static void pvpanic_ioport_write(void *opaque, hwaddr addr, uint64_t val,
+static void pvpanic_write(void *opaque, hwaddr addr, uint64_t val,
                                  unsigned size)
 {
     handle_event(val);
 }
 
 static const MemoryRegionOps pvpanic_ops = {
-    .read = pvpanic_ioport_read,
-    .write = pvpanic_ioport_write,
+    .read = pvpanic_read,
+    .write = pvpanic_write,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -136,9 +154,47 @@ static TypeInfo pvpanic_isa_info = {
     .class_init    = pvpanic_isa_class_init,
 };
 
+/* pvpanic pci device*/
+
+static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
+{
+    PVPanicPCIState *s = DO_UPCAST(PVPanicPCIState, dev, dev);
+
+    memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_ops, s,
+                          TYPE_PVPANIC_PCI, 2);
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mr);
+}
+
+static void pvpanic_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+
+    pc->realize = pvpanic_pci_realizefn;
+    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
+    pc->device_id = PCI_DEVICE_ID_REDHAT_PVPANIC;
+    pc->revision = 1;
+    pc->class_id = PCI_CLASS_SYSTEM_OTHER;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static TypeInfo pvpanic_pci_info = {
+    .name          = TYPE_PVPANIC_PCI,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PVPanicPCIState),
+    .class_init    = pvpanic_pci_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    }
+};
+
 static void pvpanic_register_types(void)
 {
     type_register_static(&pvpanic_isa_info);
+    type_register_static(&pvpanic_pci_info);
 }
 
 type_init(pvpanic_register_types)
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 30e9f8f..6fa6a62 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -18,6 +18,7 @@
 #include "qom/object.h"
 
 #define TYPE_PVPANIC_ISA "pvpanic"
+#define TYPE_PVPANIC_PCI "pvpanic-pci"
 
 #define PVPANIC_IOPORT_PROP "ioport"
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 0a59a06..ce68c90 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -107,6 +107,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
 #define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
+#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0101
 
 #define FMT_PCIBUS                      PRIx64
 
-- 
1.8.3.1


