Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A87DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EEF206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MNWZsBMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EEF206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIGSB-0003pS-SS
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 15:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIGQ2-00025G-Eb; Tue, 15 Sep 2020 15:15:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49892
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIGQ0-000220-8L; Tue, 15 Sep 2020 15:15:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08FJ2tui071323; Tue, 15 Sep 2020 15:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=onkmqalN5bf4WfLCMBRCbTd3qt1XiWcRjwsJMt3dDFM=;
 b=MNWZsBMrclYEIPuaffbFJlRSgmqfAFA68utbfV2c22NJDHZclSAjCUYdUk5yu0G2xRYj
 ddWQqS63jWg6SON7upx7zkgjBzJoaGCfcKctfss4UV3eU6RFzWC8tbjuiTabEboJaQaS
 8Vp3Geo4o017i5HLr/vGlq5gX1Rbm2SWXmVA//mPMJtmCQhQPc69cZBmb/OVlwhpoStI
 R36BpsgY/1elPlH+fWWBbB9kb4M6fkoRbS5DVAezFuRYMHE16psrKomkFSH/AhyF54BY
 /KLV5rjXnoVYCV7BPEofY5vGXwljXlg8vFoh36wK8144KkYyr/uURuQLBIcaOshPbBRL vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33k1ncug3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 15:15:06 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FJ3AJ0073000;
 Tue, 15 Sep 2020 15:15:06 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33k1ncug38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 15:15:06 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FJ6ZXd004707;
 Tue, 15 Sep 2020 19:15:05 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03dal.us.ibm.com with ESMTP id 33gny9g41r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 19:15:05 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08FJF4S745089062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 19:15:04 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B54AB112063;
 Tue, 15 Sep 2020 19:15:04 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9720B112061;
 Tue, 15 Sep 2020 19:15:02 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.51])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 15 Sep 2020 19:15:02 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: alex.williamson@redhat.com, cohuck@redhat.com
Subject: [PATCH v3 5/5] s390x/pci: Honor DMA limits set by vfio
Date: Tue, 15 Sep 2020 15:14:43 -0400
Message-Id: <1600197283-25274-6-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600197283-25274-1-git-send-email-mjrosato@linux.ibm.com>
References: <1600197283-25274-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-15_12:2020-09-15,
 2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=2
 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150147
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 15:14:53
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When an s390 guest is using lazy unmapping, it can result in a very
large number of oustanding DMA requests, far beyond the default
limit configured for vfio.  Let's track DMA usage similar to vfio
in the host, and trigger the guest to flush their DMA mappings
before vfio runs out.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 56 +++++++++++++++++++++++++++++++++++++++++++-----
 hw/s390x/s390-pci-bus.h  |  9 ++++++++
 hw/s390x/s390-pci-inst.c | 34 +++++++++++++++++++++++------
 hw/s390x/s390-pci-inst.h |  3 +++
 4 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 92146a2..8e8398d 100644
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
@@ -24,6 +25,8 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 
+#include "hw/vfio/pci.h"
+
 #ifndef DEBUG_S390PCI_BUS
 #define DEBUG_S390PCI_BUS  0
 #endif
@@ -737,6 +740,41 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     object_unref(OBJECT(iommu));
 }
 
+static S390PCIDMACount *s390_start_dma_count(S390pciState *s, VFIODevice *vdev)
+{
+    int id = vdev->group->container->fd;
+    S390PCIDMACount *cnt;
+    uint32_t avail;
+
+    if (!s390_pci_update_dma_avail(id, &avail)) {
+        return NULL;
+    }
+
+    QTAILQ_FOREACH(cnt, &s->zpci_dma_limit, link) {
+        if (cnt->id  == id) {
+            cnt->users++;
+            return cnt;
+        }
+    }
+
+    cnt = g_new0(S390PCIDMACount, 1);
+    cnt->id = id;
+    cnt->users = 1;
+    cnt->avail = avail;
+    QTAILQ_INSERT_TAIL(&s->zpci_dma_limit, cnt, link);
+    return cnt;
+}
+
+static void s390_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
+{
+    assert(cnt);
+
+    cnt->users--;
+    if (cnt->users == 0) {
+        QTAILQ_REMOVE(&s->zpci_dma_limit, cnt, link);
+    }
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -764,6 +802,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     s->bus_no = 0;
     QTAILQ_INIT(&s->pending_sei);
     QTAILQ_INIT(&s->zpci_devs);
+    QTAILQ_INIT(&s->zpci_dma_limit);
 
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
@@ -902,6 +941,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
     PCIDevice *pdev = NULL;
+    VFIOPCIDevice *vpdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
@@ -941,17 +981,20 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             }
         }
 
+        pbdev->pdev = pdev;
+        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
+        pbdev->iommu->pbdev = pbdev;
+        pbdev->state = ZPCI_FS_DISABLED;
+
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             pbdev->fh |= FH_SHM_VFIO;
+            vpdev = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+            pbdev->iommu->dma_limit = s390_start_dma_count(s,
+                                                           &vpdev->vbasedev);
         } else {
             pbdev->fh |= FH_SHM_EMUL;
         }
 
-        pbdev->pdev = pdev;
-        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
-        pbdev->iommu->pbdev = pbdev;
-        pbdev->state = ZPCI_FS_DISABLED;
-
         if (s390_pci_msix_init(pbdev)) {
             error_setg(errp, "MSI-X support is mandatory "
                        "in the S390 architecture");
@@ -1004,6 +1047,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->fid = 0;
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
+        if (pbdev->iommu->dma_limit) {
+            s390_end_dma_count(s, pbdev->iommu->dma_limit);
+        }
         qdev_unrealize(dev);
     }
 }
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 0458059..f166fd9 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -270,6 +270,13 @@ typedef struct S390IOTLBEntry {
     uint64_t perm;
 } S390IOTLBEntry;
 
+typedef struct S390PCIDMACount {
+    int id;
+    int users;
+    uint32_t avail;
+    QTAILQ_ENTRY(S390PCIDMACount) link;
+} S390PCIDMACount;
+
 struct S390PCIIOMMU {
     Object parent_obj;
     S390PCIBusDevice *pbdev;
@@ -281,6 +288,7 @@ struct S390PCIIOMMU {
     uint64_t pba;
     uint64_t pal;
     GHashTable *iotlb;
+    S390PCIDMACount *dma_limit;
 };
 
 typedef struct S390PCIIOMMUTable {
@@ -356,6 +364,7 @@ struct S390pciState {
     GHashTable *zpci_table;
     QTAILQ_HEAD(, SeiContainer) pending_sei;
     QTAILQ_HEAD(, S390PCIBusDevice) zpci_devs;
+    QTAILQ_HEAD(, S390PCIDMACount) zpci_dma_limit;
 };
 
 S390pciState *s390_get_phb(void);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 2f7a7d7..cc34b17 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -32,6 +32,9 @@
         }                                                          \
     } while (0)
 
+#define inc_dma_avail(iommu) if (iommu->dma_limit) iommu->dma_limit->avail++;
+#define dec_dma_avail(iommu) if (iommu->dma_limit) iommu->dma_limit->avail--;
+
 static void s390_set_status_code(CPUS390XState *env,
                                  uint8_t r, uint64_t status_code)
 {
@@ -572,7 +575,8 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     return 0;
 }
 
-static void s390_pci_update_iotlb(S390PCIIOMMU *iommu, S390IOTLBEntry *entry)
+static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
+                                      S390IOTLBEntry *entry)
 {
     S390IOTLBEntry *cache = g_hash_table_lookup(iommu->iotlb, &entry->iova);
     IOMMUTLBEntry notify = {
@@ -585,14 +589,15 @@ static void s390_pci_update_iotlb(S390PCIIOMMU *iommu, S390IOTLBEntry *entry)
 
     if (entry->perm == IOMMU_NONE) {
         if (!cache) {
-            return;
+            goto out;
         }
         g_hash_table_remove(iommu->iotlb, &entry->iova);
+        inc_dma_avail(iommu);
     } else {
         if (cache) {
             if (cache->perm == entry->perm &&
                 cache->translated_addr == entry->translated_addr) {
-                return;
+                goto out;
             }
 
             notify.perm = IOMMU_NONE;
@@ -606,9 +611,13 @@ static void s390_pci_update_iotlb(S390PCIIOMMU *iommu, S390IOTLBEntry *entry)
         cache->len = PAGE_SIZE;
         cache->perm = entry->perm;
         g_hash_table_replace(iommu->iotlb, &cache->iova, cache);
+        dec_dma_avail(iommu);
     }
 
     memory_region_notify_iommu(&iommu->iommu_mr, 0, notify);
+
+out:
+    return iommu->dma_limit ? iommu->dma_limit->avail : 1;
 }
 
 int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
@@ -620,6 +629,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     S390PCIIOMMU *iommu;
     S390IOTLBEntry entry;
     hwaddr start, end;
+    uint32_t dma_avail;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
         s390_program_interrupt(env, PGM_PRIVILEGED, ra);
@@ -658,6 +668,11 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     }
 
     iommu = pbdev->iommu;
+    if (iommu->dma_limit) {
+        dma_avail = iommu->dma_limit->avail;
+    } else {
+        dma_avail = 1;
+    }
     if (!iommu->g_iota) {
         error = ERR_EVENT_INVALAS;
         goto err;
@@ -675,8 +690,9 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         }
 
         start += entry.len;
-        while (entry.iova < start && entry.iova < end) {
-            s390_pci_update_iotlb(iommu, &entry);
+        while (entry.iova < start && entry.iova < end &&
+               (dma_avail > 0 || entry.perm == IOMMU_NONE)) {
+            dma_avail = s390_pci_update_iotlb(iommu, &entry);
             entry.iova += PAGE_SIZE;
             entry.translated_addr += PAGE_SIZE;
         }
@@ -689,7 +705,13 @@ err:
         s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, start, 0);
     } else {
         pbdev->fmb.counter[ZPCI_FMB_CNT_RPCIT]++;
-        setcc(cpu, ZPCI_PCI_LS_OK);
+        if (dma_avail > 0) {
+            setcc(cpu, ZPCI_PCI_LS_OK);
+        } else {
+            /* vfio DMA mappings are exhausted, trigger a RPCIT */
+            setcc(cpu, ZPCI_PCI_LS_ERR);
+            s390_set_status_code(env, r1, ZPCI_RPCIT_ST_INSUFF_RES);
+        }
     }
     return 0;
 }
diff --git a/hw/s390x/s390-pci-inst.h b/hw/s390x/s390-pci-inst.h
index fa3bf8b..8ee3a3c 100644
--- a/hw/s390x/s390-pci-inst.h
+++ b/hw/s390x/s390-pci-inst.h
@@ -254,6 +254,9 @@ typedef struct ClpReqRspQueryPciGrp {
 #define ZPCI_STPCIFC_ST_INVAL_DMAAS   28
 #define ZPCI_STPCIFC_ST_ERROR_RECOVER 40
 
+/* Refresh PCI Translations status codes */
+#define ZPCI_RPCIT_ST_INSUFF_RES      16
+
 /* FIB function controls */
 #define ZPCI_FIB_FC_ENABLED     0x80
 #define ZPCI_FIB_FC_ERROR       0x40
-- 
1.8.3.1


