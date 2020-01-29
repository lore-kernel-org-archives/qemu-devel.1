Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43187C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACB620716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACB620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmJ4-0002ry-6i
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCT-0007rE-Lg
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCS-0001yn-Gv
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:58712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iwmCS-0001Pn-7O
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:11:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="314071033"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 04:11:48 -0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v3 12/25] vfio/common: add pasid_alloc/free support
Date: Wed, 29 Jan 2020 04:16:43 -0800
Message-Id: <1580300216-86172-13-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Yi L <yi.l.liu@intel.com>

This patch adds VFIO pasid alloc/free support to allow host intercept
in PASID allocation for VM by adding VFIO implementation of
DualStageIOMMUOps.pasid_alloc/free callbacks.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/vfio/common.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a07824b..014f4e7 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1179,7 +1179,49 @@ static int vfio_get_iommu_type(VFIOContainer *container,
     return -EINVAL;
 }
 
+static int vfio_ds_iommu_pasid_alloc(DualStageIOMMUObject *dsi_obj,
+                         uint32_t min, uint32_t max, uint32_t *pasid)
+{
+    VFIOContainer *container = container_of(dsi_obj, VFIOContainer, dsi_obj);
+    struct vfio_iommu_type1_pasid_request req;
+    unsigned long argsz;
+
+    argsz = sizeof(req);
+    req.argsz = argsz;
+    req.flags = VFIO_IOMMU_PASID_ALLOC;
+    req.alloc_pasid.min = min;
+    req.alloc_pasid.max = max;
+
+    if (ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req)) {
+        error_report("%s: %d, alloc failed", __func__, -errno);
+        return -errno;
+    }
+    *pasid = req.alloc_pasid.result;
+    return 0;
+}
+
+static int vfio_ds_iommu_pasid_free(DualStageIOMMUObject *dsi_obj,
+                                     uint32_t pasid)
+{
+    VFIOContainer *container = container_of(dsi_obj, VFIOContainer, dsi_obj);
+    struct vfio_iommu_type1_pasid_request req;
+    unsigned long argsz;
+
+    argsz = sizeof(req);
+    req.argsz = argsz;
+    req.flags = VFIO_IOMMU_PASID_FREE;
+    req.free_pasid = pasid;
+
+    if (ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req)) {
+        error_report("%s: %d, free failed", __func__, -errno);
+        return -errno;
+    }
+    return 0;
+}
+
 static struct DualStageIOMMUOps vfio_ds_iommu_ops = {
+    .pasid_alloc = vfio_ds_iommu_pasid_alloc,
+    .pasid_free = vfio_ds_iommu_pasid_free,
 };
 
 static int vfio_get_iommu_info(VFIOContainer *container,
-- 
2.7.4


