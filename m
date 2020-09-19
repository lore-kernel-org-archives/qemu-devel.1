Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D48DC43465
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5EBE20866
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eV4daqrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EBE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJezX-0005vI-Sr
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 11:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kJet5-0007gK-Bc; Sat, 19 Sep 2020 11:34:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25988
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kJet2-0003pF-Mo; Sat, 19 Sep 2020 11:34:54 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08JFWRYG122440; Sat, 19 Sep 2020 11:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=/uc5WBSYJUB6XxgPHOWmrzW618TOWPAV+9x9rca0D+c=;
 b=eV4daqrc7CCpRVBE5elRMS/Vx0TbnogThM4RrbS+xDbdYgoPw27tXAR6J6KdZnQrglf6
 ARMhpBlI7zAjUZqeARe5FCLB/TYv5VENnRsCD/dqePqSIG9/+JPl4G5vGis8yrE0dtzn
 9J4aWQYp03MKVbeBSld6WhS5kb3EEq21EQe06iSMVZdLUAhMB/4u2XWY14mM1y1m98lJ
 kLr+cfw7U+I5/RCg/i/asmnFZ8HEovHJpsLQ+UAhL6ROVwD2CIQCLJZnzQfubVOh815L
 W4zcaAPQMyrxZRXWCeBVBF4wFjuxlHQbishfy/zs5LObFqYuZ7n+e+8HeVVIa7HzZH1m Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33ng7h4t9n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 11:34:51 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08JFXFxe125055;
 Sat, 19 Sep 2020 11:34:51 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33ng7h4t9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 11:34:50 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08JFQqlM003307;
 Sat, 19 Sep 2020 15:34:50 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma02dal.us.ibm.com with ESMTP id 33n9m8c1c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Sep 2020 15:34:50 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08JFYmZt54657526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Sep 2020 15:34:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98A0B7805C;
 Sat, 19 Sep 2020 15:34:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 058427805E;
 Sat, 19 Sep 2020 15:34:47 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.74.107])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 19 Sep 2020 15:34:46 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com, thuth@redhat.com
Subject: [PATCH 7/7] s390x/pci: get zPCI function info from host
Date: Sat, 19 Sep 2020 11:34:32 -0400
Message-Id: <1600529672-10243-8-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
References: <1600529672-10243-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-19_05:2020-09-16,
 2020-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=2 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009190131
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:34:41
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, pmorel@linux.ibm.com, david@redhat.com,
 schnelle@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use the VFIO_REGION_SUBTYPE_ZDEV_CLP subregion of PCI_VENDOR_ID_IBM to
retrieve the CLP information the kernel exports.

To be compatible with previous kernel versions we fall back on previous
predefined values, same as the emulation values, when the region is not
found.  If individual CLP feature(s) are not found in the region, we fall
back on default values for only those features missing from the region.

This patch is based on work previously done by Pierre Morel.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/meson.build     |   1 +
 hw/s390x/s390-pci-bus.c  |  10 +-
 hw/s390x/s390-pci-bus.h  |   1 +
 hw/s390x/s390-pci-clp.h  |  12 ++-
 hw/s390x/s390-pci-vfio.c | 235 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-pci-vfio.h |  19 ++++
 6 files changed, 271 insertions(+), 7 deletions(-)
 create mode 100644 hw/s390x/s390-pci-vfio.c
 create mode 100644 hw/s390x/s390-pci-vfio.h

diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index b63782d..ed2f66b 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -10,6 +10,7 @@ s390x_ss.add(files(
   's390-ccw.c',
   's390-pci-bus.c',
   's390-pci-inst.c',
+  's390-pci-vfio.c',
   's390-skeys.c',
   's390-stattrib.c',
   's390-virtio-hcall.c',
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index d5255ba..f1a9cd8 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -17,6 +17,7 @@
 #include "cpu.h"
 #include "s390-pci-bus.h"
 #include "s390-pci-inst.h"
+#include "s390-pci-vfio.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
@@ -737,7 +738,7 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     object_unref(OBJECT(iommu));
 }
 
-static S390PCIGroup *s390_grp_create(int ug)
+S390PCIGroup *s390_grp_create(int ug)
 {
     S390PCIGroup *grp;
     S390pciState *s = s390_get_phb();
@@ -782,7 +783,7 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
     pbdev->zpci_fn.sdma = ZPCI_SDMA_ADDR;
     pbdev->zpci_fn.edma = ZPCI_EDMA_ADDR;
     pbdev->zpci_fn.pchid = 0;
-    pbdev->zpci_fn.ug = ZPCI_DEFAULT_FN_GRP;
+    pbdev->zpci_fn.pfgid = ZPCI_DEFAULT_FN_GRP;
     pbdev->zpci_fn.fid = pbdev->fid;
     pbdev->zpci_fn.uid = pbdev->uid;
     pbdev->pci_grp = s390_grp_find(ZPCI_DEFAULT_FN_GRP);
@@ -861,7 +862,8 @@ static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
     name = g_strdup_printf("msix-s390-%04x", pbdev->uid);
     memory_region_init_io(&pbdev->msix_notify_mr, OBJECT(pbdev),
                           &s390_msi_ctrl_ops, pbdev, name, PAGE_SIZE);
-    memory_region_add_subregion(&pbdev->iommu->mr, ZPCI_MSI_ADDR,
+    memory_region_add_subregion(&pbdev->iommu->mr,
+                                pbdev->pci_grp->zpci_grp.msia,
                                 &pbdev->msix_notify_mr);
     g_free(name);
 
@@ -1013,6 +1015,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             pbdev->fh |= FH_SHM_VFIO;
+            /* Fill in CLP information passed via the vfio region */
+            s390_pci_get_clp_info(pbdev);
         } else {
             pbdev->fh |= FH_SHM_EMUL;
         }
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 7821856..5c0519b 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -322,6 +322,7 @@ typedef struct S390PCIGroup {
     int ug;
     QTAILQ_ENTRY(S390PCIGroup) link;
 } S390PCIGroup;
+S390PCIGroup *s390_grp_create(int ug);
 S390PCIGroup *s390_grp_find(int ug);
 
 struct S390PCIBusDevice {
diff --git a/hw/s390x/s390-pci-clp.h b/hw/s390x/s390-pci-clp.h
index e442307..5dd87c8 100644
--- a/hw/s390x/s390-pci-clp.h
+++ b/hw/s390x/s390-pci-clp.h
@@ -79,6 +79,7 @@ typedef struct ClpFhListEntry {
 #define CLP_SET_DISABLE_PCI_FN 1 /* Yes, 1 disables it */
 
 #define CLP_UTIL_STR_LEN 64
+#define CLP_PFIP_NR_SEGMENTS 4
 
 #define CLP_MASK_FMT 0xf0000000
 
@@ -120,14 +121,17 @@ typedef struct ClpRspQueryPci {
     uint32_t fmt;
     uint64_t reserved1;
     uint16_t vfn; /* virtual fn number */
-#define CLP_RSP_QPCI_MASK_UTIL  0x100
-#define CLP_RSP_QPCI_MASK_PFGID 0xff
-    uint16_t ug;
+#define CLP_RSP_QPCI_MASK_UTIL  0x01
+    uint8_t flags;
+    uint8_t pfgid;
     uint32_t fid; /* pci function id */
     uint8_t bar_size[PCI_BAR_COUNT];
     uint16_t pchid;
     uint32_t bar[PCI_BAR_COUNT];
-    uint64_t reserved2;
+    uint8_t pfip[CLP_PFIP_NR_SEGMENTS];
+    uint16_t reserved2;
+    uint8_t fmbl;
+    uint8_t pft;
     uint64_t sdma; /* start dma as */
     uint64_t edma; /* end dma as */
     uint32_t reserved3[11];
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
new file mode 100644
index 0000000..a18da63
--- /dev/null
+++ b/hw/s390x/s390-pci-vfio.c
@@ -0,0 +1,235 @@
+/*
+ * s390 vfio-pci interfaces
+ *
+ * Copyright 2020 IBM Corp.
+ * Author(s): Matthew Rosato <mjrosato@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include <linux/vfio_zdev.h>
+
+#include "qemu/osdep.h"
+#include "s390-pci-bus.h"
+#include "s390-pci-clp.h"
+#include "s390-pci-vfio.h"
+#include "hw/vfio/pci.h"
+
+#ifndef DEBUG_S390PCI_VFIO
+#define DEBUG_S390PCI_VFIO  0
+#endif
+
+#define DPRINTF(fmt, ...)                                          \
+    do {                                                           \
+        if (DEBUG_S390PCI_VFIO) {                                  \
+            fprintf(stderr, "S390pci-vfio: " fmt, ## __VA_ARGS__); \
+        }                                                          \
+    } while (0)
+
+static void *get_next_clp_buf(struct vfio_region_zpci_info *zpci_info,
+                              struct vfio_region_zpci_info_hdr *hdr)
+{
+    /* If the next payload would be beyond the region, we're done */
+    if (zpci_info->argsz <= hdr->next) {
+        return NULL;
+    }
+
+    return (void *)zpci_info + hdr->next;
+}
+
+static void *find_clp_data(struct vfio_region_zpci_info *zpci_info, int id)
+{
+    struct vfio_region_zpci_info_hdr *hdr;
+    void *clp;
+
+    assert(zpci_info);
+
+    /* Jump to the first CLP feature, which starts with header information */
+    clp = (void *)zpci_info + zpci_info->offset;
+    hdr = (struct vfio_region_zpci_info_hdr *)clp;
+
+    while (hdr != NULL) {
+        if (hdr->id == id) {
+            return hdr;
+        }
+        hdr = get_next_clp_buf(zpci_info, hdr);
+    }
+
+    return NULL;
+}
+
+static void s390_pci_read_qpci(S390PCIBusDevice *pbdev,
+                               struct vfio_region_zpci_info *zpci_info)
+{
+    struct vfio_region_zpci_info_qpci *clp;
+
+    clp = find_clp_data(zpci_info, VFIO_REGION_ZPCI_INFO_QPCI);
+
+    /* If CLP feature not provided, just leave the defaults in place */
+    if (clp == NULL) {
+        DPRINTF("QPCI clp feature not found\n");
+        return;
+    }
+
+    pbdev->zpci_fn.sdma = clp->start_dma;
+    pbdev->zpci_fn.edma = clp->end_dma;
+    pbdev->zpci_fn.pchid = clp->pchid;
+    pbdev->zpci_fn.vfn = clp->vfn;
+    pbdev->zpci_fn.pfgid = clp->gid;
+    /* The following values remain 0 until we support other FMB formats */
+    pbdev->zpci_fn.fmbl = 0;
+    pbdev->zpci_fn.pft = 0;
+}
+
+static void s390_pci_read_qpcifg(S390PCIBusDevice *pbdev,
+                                 struct vfio_region_zpci_info *zpci_info)
+{
+    struct vfio_region_zpci_info_qpcifg *clp;
+    ClpRspQueryPciGrp *resgrp;
+
+    clp = find_clp_data(zpci_info, VFIO_REGION_ZPCI_INFO_QPCIFG);
+
+    /* If CLP feature not provided, just use the default group */
+    if (clp == NULL) {
+        DPRINTF("QPCIFG clp feature not found\n");
+        pbdev->zpci_fn.pfgid = ZPCI_DEFAULT_FN_GRP;
+        pbdev->pci_grp = s390_grp_find(ZPCI_DEFAULT_FN_GRP);
+        return;
+    }
+
+    /* See if the PCI group is already defined, create if not */
+    pbdev->pci_grp = s390_grp_find(pbdev->zpci_fn.pfgid);
+
+    if (!pbdev->pci_grp) {
+        pbdev->pci_grp = s390_grp_create(pbdev->zpci_fn.pfgid);
+
+        resgrp = &pbdev->pci_grp->zpci_grp;
+        if (clp->flags & VFIO_PCI_ZDEV_FLAGS_REFRESH) {
+            resgrp->fr = 1;
+        }
+        stq_p(&resgrp->dasm, clp->dasm);
+        stq_p(&resgrp->msia, clp->msi_addr);
+        stw_p(&resgrp->mui, clp->mui);
+        stw_p(&resgrp->i, clp->noi);
+        stw_p(&resgrp->maxstbl, clp->maxstbl);
+        stb_p(&resgrp->version, clp->version);
+    }
+}
+
+static void s390_pci_read_util(S390PCIBusDevice *pbdev,
+                               struct vfio_region_zpci_info *zpci_info)
+{
+    struct vfio_region_zpci_info_util *clp;
+
+    clp = find_clp_data(zpci_info, VFIO_REGION_ZPCI_INFO_UTIL);
+
+    /* If CLP feature not provided or unusable, leave the defaults in place */
+    if (clp == NULL) {
+        DPRINTF("UTIL clp feature not found\n");
+        return;
+    }
+    if (clp->size > CLP_UTIL_STR_LEN) {
+        DPRINTF("UTIL clp feature unexpected size\n");
+        return;
+    }
+
+    pbdev->zpci_fn.flags |= CLP_RSP_QPCI_MASK_UTIL;
+    memcpy(pbdev->zpci_fn.util_str, clp->util_str, CLP_UTIL_STR_LEN);
+}
+
+static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
+                               struct vfio_region_zpci_info *zpci_info)
+{
+    struct vfio_region_zpci_info_pfip *clp;
+
+    clp = find_clp_data(zpci_info, VFIO_REGION_ZPCI_INFO_PFIP);
+
+    /* If CLP feature not provided or unusable, leave the defaults in place */
+    if (clp == NULL) {
+        DPRINTF("PFIP clp feature not found\n");
+        return;
+    }
+    if (clp->size > CLP_PFIP_NR_SEGMENTS) {
+        DPRINTF("PFIP clp feature unexpected size\n");
+        return;
+    }
+
+    memcpy(pbdev->zpci_fn.pfip, clp->pfip, CLP_PFIP_NR_SEGMENTS);
+}
+
+/*
+ * This function will look for the VFIO_REGION_SUBTYPE_IBM_ZPCI_CLP vfio device
+ * region, which has information about CLP features provided by the underlying
+ * host.  On entry, defaults have already been placed into the guest CLP
+ * response buffers.  On exit, defaults will have been overwritten for any CLP
+ * features found in the region; defaults will remain for any CLP features not
+ * found in the region.
+ */
+void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
+{
+    VFIOPCIDevice *vfio_pci;
+    VFIODevice *vdev;
+    struct vfio_region_info *info;
+    struct vfio_region_zpci_info *zpci_info;
+    int size, argsz;
+    int ret;
+
+    vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    vdev = &vfio_pci->vbasedev;
+
+    if (vdev->num_regions < VFIO_PCI_NUM_REGIONS + 1) {
+        /* Fall back to old handling */
+        DPRINTF("No zPCI vfio region available\n");
+        return;
+    }
+
+    ret = vfio_get_dev_region_info(vdev,
+                                   PCI_VENDOR_ID_IBM |
+                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
+                                   VFIO_REGION_SUBTYPE_IBM_ZPCI_CLP, &info);
+    if (ret) {
+        /* Fall back to old handling */
+        DPRINTF("zPCI vfio region not found\n");
+        return;
+    }
+
+    /* Start by determining the region size */
+    zpci_info = g_malloc(sizeof(*zpci_info));
+    size = pread(vdev->fd, zpci_info, sizeof(*zpci_info), info->offset);
+    if (size != sizeof(*zpci_info)) {
+        DPRINTF("Failed to read vfio zPCI device region header\n");
+        goto end;
+    }
+
+    /* Allocate a buffer for the entire region */
+    argsz = zpci_info->argsz;
+    zpci_info = g_realloc(zpci_info, argsz);
+
+    /* Read the entire region now */
+    size = pread(vdev->fd, zpci_info, argsz, info->offset);
+    if (size != argsz) {
+        DPRINTF("Failed to read vfio zPCI device region\n");
+        goto end;
+    }
+
+    /*
+     * Find the CLP features provided and fill in the guest CLP responses.
+     * Always call s390_pci_read_qpci first as information from this could
+     * determine which function group is used in s390_pci_read_qpcifg.
+     * For any feature not found, the default values will remain in the CLP
+     * response.
+     */
+    s390_pci_read_qpci(pbdev, zpci_info);
+    s390_pci_read_qpcifg(pbdev, zpci_info);
+    s390_pci_read_util(pbdev, zpci_info);
+    s390_pci_read_pfip(pbdev, zpci_info);
+
+end:
+    g_free(info);
+    g_free(zpci_info);
+    return;
+}
diff --git a/hw/s390x/s390-pci-vfio.h b/hw/s390x/s390-pci-vfio.h
new file mode 100644
index 0000000..d3ca1d1
--- /dev/null
+++ b/hw/s390x/s390-pci-vfio.h
@@ -0,0 +1,19 @@
+/*
+ * s390 vfio-pci interfaces
+ *
+ * Copyright 2020 IBM Corp.
+ * Author(s): Matthew Rosato <mjrosato@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_PCI_VFIO_H
+#define HW_S390_PCI_VFIO_H
+
+#include "s390-pci-bus.h"
+
+void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
+
+#endif
-- 
1.8.3.1


