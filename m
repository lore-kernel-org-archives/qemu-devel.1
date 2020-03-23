Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF4C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B3820736
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IxKd0egv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B3820736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGIoT-0006zf-FB
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2351ca747f=bbhushan2@marvell.com>)
 id 1jGIjn-00009P-JQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2351ca747f=bbhushan2@marvell.com>)
 id 1jGIjm-0003F4-BD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:47:11 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:10634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2351ca747f=bbhushan2@marvell.com>)
 id 1jGIji-0003CP-Jq; Mon, 23 Mar 2020 04:47:06 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02N8ePfP013763; Mon, 23 Mar 2020 01:47:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=6uTNrZsOxWL293QbnMDHDEcZhVh+4bvO0bI5PoXuaQw=;
 b=IxKd0egvumpqD+jjivEF0CZQiDPWXIU5qb2XL+zYpDUwtN2m4q8tQHcTbHztHx2fQ0gw
 DN8DBbZKzU5962T9kqfPxj61B0ob78zzdcc2M+Dl+fDAB/gukga9LTeWdA5i541adS/0
 6vdkFpsPmP+zPcsKp+4CXX8zTrb8h8vmpApaXt+HfZkvPs39iGpp8u5y7hv7JCxMHNm+
 gGzrHk4YJ8rvEfrl4YfZjzat3XFLjK6+RsdxU1fz5mzL6syuHeGJv5lfPOD5x52cDGM1
 KdvIPSOn+f9VnaVYQLD3ONfXSUvg9qhriQRAm8PdpHoKfIHf6JN1wKshZznjREh5w6tQ Gg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0b-0016f401.pphosted.com with ESMTP id 2ywvkqkxcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2020 01:47:04 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 23 Mar 2020 01:47:01 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 23 Mar 2020 01:47:01 -0700
Received: from bbhushan2.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Mar 2020 01:46:56 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <peter.maydell@linaro.org>, <peterx@redhat.com>,
 <eric.auger.pro@gmail.com>, <alex.williamson@redhat.com>,
 <kevin.tian@intel.com>, <mst@redhat.com>, <tnowicki@marvell.com>,
 <drjones@redhat.com>, <linuc.decode@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <bharatb.linux@gmail.com>, <jean-philippe@linaro.org>,
 <yang.zhong@intel.com>
Subject: [PATCH v9 6/9] virtio-iommu: Call iommu notifier for attach/detach
Date: Mon, 23 Mar 2020 14:16:14 +0530
Message-ID: <20200323084617.1782-7-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323084617.1782-1-bbhushan2@marvell.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-23_02:2020-03-21,
 2020-03-23 signatures=0
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
index bd464d4fb3..88849aa7b9 100644
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
 
@@ -872,6 +920,7 @@ static gboolean reconstruct_endpoints(gpointer key, gpointer value,
 
     QLIST_FOREACH(iter, &d->endpoint_list, next) {
         iter->domain = d;
+        iter->viommu = s;
         g_tree_insert(s->endpoints, GUINT_TO_POINTER(iter->id), iter);
     }
     return false; /* continue the domain traversal */
-- 
2.17.1


