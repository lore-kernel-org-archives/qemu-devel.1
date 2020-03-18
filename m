Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AA6C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99442076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kAWHuSTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99442076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEVkQ-0008QH-4t
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 06:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEVgs-0002gi-IE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEVgr-0004vs-4Z
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:12:46 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34020
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEVgn-0004pz-Tq; Wed, 18 Mar 2020 06:12:42 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02IAAjAF008560; Wed, 18 Mar 2020 03:12:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=XN0LjRF171QI39m3Xi7A3dpjV78hP1L4kv6vlWXZQ1s=;
 b=kAWHuSTFuGBqDl+qT7hAMZwLkcamCRIKJP79gBKaXX6Q77wZdgoFverwikGTSh8rNmpZ
 vJDZz4FAZlL/uCOwKj9EQckZy90NTLhJkIV69JQsXvO3+llKh4osvJSrRcW3OrkL9lui
 0Ud8gfEYZ2OjYUQXhRivsLQKHmjIT87X/somwVC+rcpfXh8FNdyk1lBY7Rzr8GR2p+oz
 tPaS7Y2CHuxlmPbr9OLRT0iKi/iGbABywckQK3Em4Bv5ouTiqJ+wrnrzU5gSsok2vcIz
 tH6JNU+exbuz2lGDLK1ceYlaHhMmkjbK21Kr3yuHNfGByEFG/cFXsBPMUnWMprkrnSgU Yw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 2yu8pqj4pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2020 03:12:38 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 18 Mar 2020 03:12:36 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 18 Mar 2020 03:12:36 -0700
Received: from bbhushan2.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Mar 2020 03:12:30 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <peter.maydell@linaro.org>, <peterx@redhat.com>,
 <eric.auger.pro@gmail.com>, <alex.williamson@redhat.com>,
 <kevin.tian@intel.com>, <mst@redhat.com>, <tnowicki@marvell.com>,
 <drjones@redhat.com>, <linuc.decode@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <bharatb.linux@gmail.com>, <jean-philippe@linaro.org>,
 <yang.zhong@intel.com>
Subject: [PATCH v8 5/8] virtio-iommu: Add iommu notifier for map/unmap
Date: Wed, 18 Mar 2020 15:41:56 +0530
Message-ID: <20200318101159.8767-6-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318101159.8767-1-bbhushan2@marvell.com>
References: <20200318101159.8767-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_04:2020-03-18,
 2020-03-18 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.148.174
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
Cc: Eric Auger <eric.auger@redhat.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Bharat Bhushan <Bharat.Bhushan@nxp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch extends VIRTIO_IOMMU_T_MAP/UNMAP request to
notify registered iommu-notifier. Which will call vfio
notifier to map/unmap region in iommu.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  2 +
 hw/virtio/virtio-iommu.c         | 67 +++++++++++++++++++++++++++++++-
 hw/virtio/trace-events           |  2 +
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 6f67f1020a..65ad3bf4ee 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -37,6 +37,7 @@ typedef struct IOMMUDevice {
     int           devfn;
     IOMMUMemoryRegion  iommu_mr;
     AddressSpace  as;
+    QLIST_ENTRY(IOMMUDevice) next;
 } IOMMUDevice;
 
 typedef struct IOMMUPciBus {
@@ -56,6 +57,7 @@ typedef struct VirtIOIOMMU {
     GTree *domains;
     QemuMutex mutex;
     GTree *endpoints;
+    QLIST_HEAD(, IOMMUDevice) notifiers_list;
 } VirtIOIOMMU;
 
 #endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index c00a55348d..623b477b9c 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -123,6 +123,38 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
     }
 }
 
+static void virtio_iommu_notify_map(IOMMUMemoryRegion *mr, hwaddr iova,
+                                    hwaddr paddr, hwaddr size)
+{
+    IOMMUTLBEntry entry;
+
+    entry.target_as = &address_space_memory;
+    entry.addr_mask = size - 1;
+
+    entry.iova = iova;
+    trace_virtio_iommu_notify_map(mr->parent_obj.name, iova, paddr, size);
+    entry.perm = IOMMU_RW;
+    entry.translated_addr = paddr;
+
+    memory_region_notify_iommu(mr, 0, entry);
+}
+
+static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
+                                      hwaddr size)
+{
+    IOMMUTLBEntry entry;
+
+    entry.target_as = &address_space_memory;
+    entry.addr_mask = size - 1;
+
+    entry.iova = iova;
+    trace_virtio_iommu_notify_unmap(mr->parent_obj.name, iova, size);
+    entry.perm = IOMMU_NONE;
+    entry.translated_addr = 0;
+
+    memory_region_notify_iommu(mr, 0, entry);
+}
+
 static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
 {
     if (!ep->domain) {
@@ -307,9 +339,12 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
     uint64_t virt_start = le64_to_cpu(req->virt_start);
     uint64_t virt_end = le64_to_cpu(req->virt_end);
     uint32_t flags = le32_to_cpu(req->flags);
+    hwaddr size = virt_end - virt_start + 1;
     VirtIOIOMMUDomain *domain;
     VirtIOIOMMUInterval *interval;
     VirtIOIOMMUMapping *mapping;
+    VirtIOIOMMUEndpoint *ep;
+    IOMMUDevice *sdev;
 
     if (flags & ~VIRTIO_IOMMU_MAP_F_MASK) {
         return VIRTIO_IOMMU_S_INVAL;
@@ -339,9 +374,38 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
 
     g_tree_insert(domain->mappings, interval, mapping);
 
+    /* All devices in an address-space share mapping */
+    QLIST_FOREACH(sdev, &s->notifiers_list, next) {
+        QLIST_FOREACH(ep, &domain->endpoint_list, next) {
+            if (ep->id == sdev->devfn) {
+                virtio_iommu_notify_map(&sdev->iommu_mr,
+                                        virt_start, phys_start, size);
+            }
+        }
+    }
+
     return VIRTIO_IOMMU_S_OK;
 }
 
+static void virtio_iommu_remove_mapping(VirtIOIOMMU *s,
+                                        VirtIOIOMMUDomain *domain,
+                                        VirtIOIOMMUInterval *interval)
+{
+    VirtIOIOMMUEndpoint *ep;
+    IOMMUDevice *sdev;
+
+    QLIST_FOREACH(sdev, &s->notifiers_list, next) {
+        QLIST_FOREACH(ep, &domain->endpoint_list, next) {
+            if (ep->id == sdev->devfn) {
+                virtio_iommu_notify_unmap(&sdev->iommu_mr,
+                                          interval->low,
+                                          interval->high - interval->low + 1);
+            }
+        }
+    }
+    g_tree_remove(domain->mappings, (gpointer)(interval));
+}
+
 static int virtio_iommu_unmap(VirtIOIOMMU *s,
                               struct virtio_iommu_req_unmap *req)
 {
@@ -368,7 +432,7 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
         uint64_t current_high = iter_key->high;
 
         if (interval.low <= current_low && interval.high >= current_high) {
-            g_tree_remove(domain->mappings, iter_key);
+            virtio_iommu_remove_mapping(s, domain, iter_key);
             trace_virtio_iommu_unmap_done(domain_id, current_low, current_high);
         } else {
             ret = VIRTIO_IOMMU_S_RANGE;
@@ -664,6 +728,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
 
+    QLIST_INIT(&s->notifiers_list);
     virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
                 sizeof(struct virtio_iommu_config));
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e83500bee9..d94a1cd8a3 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -73,3 +73,5 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
 virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
 virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
+virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t paddr, uint64_t map_size) "mr=%s iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64
+virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map_size) "mr=%s iova=0x%"PRIx64" size=0x%"PRIx64
-- 
2.17.1


