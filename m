Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A0C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 22:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E93208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 22:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gW1BH+6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E93208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHx0U-0004fd-HO
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 18:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kHwyo-0003fS-9A; Mon, 14 Sep 2020 18:29:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kHwyl-0002ri-6X; Mon, 14 Sep 2020 18:29:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08EM1Zsl032110; Mon, 14 Sep 2020 18:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=jpOYTdtLU3gE6lh5GcVNIu82TuH5cKkBPjxPH9WNNDA=;
 b=gW1BH+6WG1gMa7KHIRKQIXbZ2nyOBrpBgxs3W2jVih1hXP2JCB4jBYaj1LpMiKwPRs4H
 qncdroL5fXXbHBvzN8vAlhxudP6wK1a2pR9BCRuCryH0NlU95LkgVdfFnEx+EAZKiVny
 ++9ZW/q2H/mrgRYUpa3O54KTqcmRrxZUFKdYAU+ont9euIbMQQHTuMqvTlL1OhE00MGT
 p0VZWr5fa6VYs7ESlq6faORazqfw/K3Nb4CaB61JtL3XVWmzUu2EdV049z/UHIDtYQK7
 alkogifaLXFkA9BaXclQ9EXiEo++GPpWhQ/2PLweLUQjj4zDT79pLsBI25/1XtqG5+Ws 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jb7ba4nb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 18:29:41 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08EMM1BT120195;
 Mon, 14 Sep 2020 18:29:40 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jb7ba4n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 18:29:40 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08EMRfv0023230;
 Mon, 14 Sep 2020 22:29:39 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma05wdc.us.ibm.com with ESMTP id 33gny8u009-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2020 22:29:39 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08EMTXQi1769990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2020 22:29:33 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52671BE04F;
 Mon, 14 Sep 2020 22:29:38 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0A7FBE051;
 Mon, 14 Sep 2020 22:29:36 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.51])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2020 22:29:36 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: alex.williamson@redhat.com, cohuck@redhat.com
Subject: [PATCH v2 2/3] s390x/pci: Honor DMA limits set by vfio
Date: Mon, 14 Sep 2020 18:29:29 -0400
Message-Id: <1600122570-12941-3-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-14_09:2020-09-14,
 2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=2 bulkscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140166
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 18:29:41
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 schnelle@linux.ibm.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
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
 hw/s390x/s390-pci-bus.c  | 99 +++++++++++++++++++++++++++++++++++++++++++++---
 hw/s390x/s390-pci-bus.h  |  9 +++++
 hw/s390x/s390-pci-inst.c | 29 +++++++++++---
 hw/s390x/s390-pci-inst.h |  3 ++
 4 files changed, 129 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 92146a2..23474cd 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -11,6 +11,8 @@
  * directory.
  */
 
+#include <sys/ioctl.h>
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
@@ -24,6 +26,9 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 
+#include "hw/vfio/pci.h"
+#include "hw/vfio/vfio-common.h"
+
 #ifndef DEBUG_S390PCI_BUS
 #define DEBUG_S390PCI_BUS  0
 #endif
@@ -737,6 +742,82 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     object_unref(OBJECT(iommu));
 }
 
+static bool s390_sync_dma_avail(int fd, unsigned int *avail)
+{
+    struct vfio_iommu_type1_info *info;
+    uint32_t argsz;
+    bool rval = false;
+    int ret;
+
+    if (avail == NULL) {
+        return false;
+    }
+
+    argsz = sizeof(struct vfio_iommu_type1_info);
+    info = g_malloc0(argsz);
+    info->argsz = argsz;
+    /*
+     * If the specified argsz is not large enough to contain all
+     * capabilities it will be updated upon return.  In this case
+     * use the updated value to get the entire capability chain.
+     */
+    ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
+    if (argsz != info->argsz) {
+        argsz = info->argsz;
+        info = g_realloc(info, argsz);
+        info->argsz = argsz;
+        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
+    }
+
+    if (ret) {
+        goto out;
+    }
+
+    /* If the capability exists, update with the current value */
+    rval = vfio_get_info_dma_avail(info, avail);
+
+out:
+    g_free(info);
+    return rval;
+}
+
+static S390PCIDMACount *s390_start_dma_count(S390pciState *s, VFIODevice *vdev)
+{
+    int id = vdev->group->container->fd;
+    S390PCIDMACount *cnt;
+    uint32_t avail;
+
+    if (!s390_sync_dma_avail(id, &avail)) {
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
+    if (cnt == NULL) {
+        return;
+    }
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
@@ -764,6 +845,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     s->bus_no = 0;
     QTAILQ_INIT(&s->pending_sei);
     QTAILQ_INIT(&s->zpci_devs);
+    QTAILQ_INIT(&s->zpci_dma_limit);
 
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
@@ -902,6 +984,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
     PCIDevice *pdev = NULL;
+    VFIOPCIDevice *vpdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
@@ -941,17 +1024,20 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
@@ -1004,6 +1090,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
index 2f7a7d7..6af9af4 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -32,6 +32,9 @@
         }                                                          \
     } while (0)
 
+#define INC_DMA_AVAIL(iommu) if (iommu->dma_limit) iommu->dma_limit->avail++;
+#define DEC_DMA_AVAIL(iommu) if (iommu->dma_limit) iommu->dma_limit->avail--;
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
+        INC_DMA_AVAIL(iommu);
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
+        DEC_DMA_AVAIL(iommu);
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
@@ -675,8 +685,9 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         }
 
         start += entry.len;
-        while (entry.iova < start && entry.iova < end) {
-            s390_pci_update_iotlb(iommu, &entry);
+        dma_avail = 1; /* Assume non-zero dma_avail to start */
+        while (entry.iova < start && entry.iova < end && dma_avail > 0) {
+            dma_avail = s390_pci_update_iotlb(iommu, &entry);
             entry.iova += PAGE_SIZE;
             entry.translated_addr += PAGE_SIZE;
         }
@@ -689,7 +700,13 @@ err:
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


