Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B128C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CDD2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WknkTaD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CDD2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEVm5-0002S3-Dp
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 06:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEVgw-0002pP-7G
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEVgu-00055w-VP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:12:50 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEVgu-00055J-QP; Wed, 18 Mar 2020 06:12:48 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02IABn5a030628; Wed, 18 Mar 2020 03:12:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=EPTWRH4j/7+vQYg4JTRs7Id0RV8zi4mhxOYnQxamw9E=;
 b=WknkTaD9KiEVbj4ysm+kpXckxeLvVwT+/C1G9Ww3cj2J8pu0BwQpnfIO6xHIv2hiYNXq
 TVbO4nhjq6MZszgcvV+aWbL1yDWyXEir3VoESYKga3dLOGIMeu0YKipRgYN404nJVJmu
 0vVaNm6DML6J/HtxXV4UIjRxfZ1Nt4mPVjq+/sU7dmp1u4uRbTCB6IKcHunS8x7TFMUU
 kSo7H+zB9Ld8o3/zQAXGVZtLqh2RoM5COwbLKTeMPZyPfi3kQHk3OC1XnoGekiiKRis0
 sudlzQd3QSwOZB5b64B1cGMgI2I6RurEPkfAW4LfekeMtgcIp6KjsZSpH4Yr3CB3NDAt rQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 2yu9rp9tvp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2020 03:12:46 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 18 Mar
 2020 03:12:41 -0700
Received: from bbhushan2.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Mar 2020 03:12:37 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <peter.maydell@linaro.org>, <peterx@redhat.com>,
 <eric.auger.pro@gmail.com>, <alex.williamson@redhat.com>,
 <kevin.tian@intel.com>, <mst@redhat.com>, <tnowicki@marvell.com>,
 <drjones@redhat.com>, <linuc.decode@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <bharatb.linux@gmail.com>, <jean-philippe@linaro.org>,
 <yang.zhong@intel.com>
Subject: [PATCH v8 6/8] virtio-iommu: Call iommu notifier for attach/detach
Date: Wed, 18 Mar 2020 15:41:57 +0530
Message-ID: <20200318101159.8767-7-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318101159.8767-1-bbhushan2@marvell.com>
References: <20200318101159.8767-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_04:2020-03-18,
 2020-03-18 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.156.173
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
Cc: Bharat Bhushan <bbhushan2@marvell.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

iommu-notifier are called when a device is attached
or detached to as address-space.
This is needed for VFIO.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 hw/virtio/virtio-iommu.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 623b477b9c..4d522a636a 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -49,6 +49,7 @@ typedef struct VirtIOIOMMUEndpoint {
     uint32_t id;
     VirtIOIOMMUDomain *domain;
     QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
+    VirtIOIOMMU *viommu;
 } VirtIOIOMMUEndpoint;
 
 typedef struct VirtIOIOMMUInterval {
@@ -155,11 +156,48 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
     memory_region_notify_iommu(mr, 0, entry);
 }
 
+static gboolean virtio_iommu_mapping_unmap(gpointer key, gpointer value,
+                                           gpointer data)
+{
+    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    virtio_iommu_notify_unmap(mr, interval->low,
+                              interval->high - interval->low + 1);
+
+    return false;
+}
+
+static gboolean virtio_iommu_mapping_map(gpointer key, gpointer value,
+                                         gpointer data)
+{
+    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
+    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    virtio_iommu_notify_map(mr, interval->low, mapping->phys_addr,
+                            interval->high - interval->low + 1);
+
+    return false;
+}
+
 static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
 {
+    VirtIOIOMMU *s = ep->viommu;
+    VirtIOIOMMUDomain *domain = ep->domain;
+    IOMMUDevice *sdev;
+
     if (!ep->domain) {
         return;
     }
+
+    QLIST_FOREACH(sdev, &s->notifiers_list, next) {
+        if (ep->id == sdev->devfn) {
+            g_tree_foreach(domain->mappings, virtio_iommu_mapping_unmap,
+                           &sdev->iommu_mr);
+        }
+    }
+
     QLIST_REMOVE(ep, next);
     ep->domain = NULL;
 }
@@ -178,6 +216,7 @@ static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
     }
     ep = g_malloc0(sizeof(*ep));
     ep->id = ep_id;
+    ep->viommu = s;
     trace_virtio_iommu_get_endpoint(ep_id);
     g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
     return ep;
@@ -274,6 +313,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
     uint32_t ep_id = le32_to_cpu(req->endpoint);
     VirtIOIOMMUDomain *domain;
     VirtIOIOMMUEndpoint *ep;
+    IOMMUDevice *sdev;
 
     trace_virtio_iommu_attach(domain_id, ep_id);
 
@@ -299,6 +339,14 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
 
     ep->domain = domain;
 
+    /* Replay domain mappings on the associated memory region */
+    QLIST_FOREACH(sdev, &s->notifiers_list, next) {
+        if (ep_id == sdev->devfn) {
+            g_tree_foreach(domain->mappings, virtio_iommu_mapping_map,
+                           &sdev->iommu_mr);
+        }
+    }
+
     return VIRTIO_IOMMU_S_OK;
 }
 
@@ -873,6 +921,7 @@ static gboolean reconstruct_endpoints(gpointer key, gpointer value,
 
     QLIST_FOREACH(iter, &d->endpoint_list, next) {
         iter->domain = d;
+        iter->viommu = s;
         g_tree_insert(s->endpoints, GUINT_TO_POINTER(iter->id), iter);
     }
     return false; /* continue the domain traversal */
-- 
2.17.1


