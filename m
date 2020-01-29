Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2F4C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BA22064C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BA22064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmMb-00006o-M3
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCp-00008u-27
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCn-0003O9-KY
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:58712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iwmCn-0001Pn-AW
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:11:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="314071178"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 04:11:51 -0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v3 17/25] vfio: add bind stage-1 page table support
Date: Wed, 29 Jan 2020 04:16:48 -0800
Message-Id: <1580300216-86172-18-git-send-email-yi.l.liu@intel.com>
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

This patch adds bind_stage1_pgtbl() definition in DualStageIOMMUOops,
also adds corresponding implementation in VFIO. This is to expose a
way for vIOMMU to setup dual stage DMA translation for passthru devices
on hardware.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/iommu/dual_stage_iommu.c         | 26 ++++++++++++++++++++
 hw/vfio/common.c                    | 48 +++++++++++++++++++++++++++++++++++++
 include/hw/iommu/dual_stage_iommu.h | 22 +++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/hw/iommu/dual_stage_iommu.c b/hw/iommu/dual_stage_iommu.c
index d5a7168..9d99e9e 100644
--- a/hw/iommu/dual_stage_iommu.c
+++ b/hw/iommu/dual_stage_iommu.c
@@ -47,6 +47,32 @@ int ds_iommu_pasid_free(DualStageIOMMUObject *dsi_obj, uint32_t pasid)
     return -ENOENT;
 }
 
+int ds_iommu_bind_stage1_pgtbl(DualStageIOMMUObject *dsi_obj,
+                               DualIOMMUStage1BindData *data)
+{
+    if (!dsi_obj) {
+        return -ENOENT;
+    }
+
+    if (dsi_obj->ops && dsi_obj->ops->bind_stage1_pgtbl) {
+        return dsi_obj->ops->bind_stage1_pgtbl(dsi_obj, data);
+    }
+    return -ENOENT;
+}
+
+int ds_iommu_unbind_stage1_pgtbl(DualStageIOMMUObject *dsi_obj,
+                                 DualIOMMUStage1BindData *data)
+{
+    if (!dsi_obj) {
+        return -ENOENT;
+    }
+
+    if (dsi_obj->ops && dsi_obj->ops->unbind_stage1_pgtbl) {
+        return dsi_obj->ops->unbind_stage1_pgtbl(dsi_obj, data);
+    }
+    return -ENOENT;
+}
+
 void ds_iommu_object_init(DualStageIOMMUObject *dsi_obj,
                           DualStageIOMMUOps *ops,
                           DualStageIOMMUInfo *uinfo)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 014f4e7..d84bdc9 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1219,9 +1219,57 @@ static int vfio_ds_iommu_pasid_free(DualStageIOMMUObject *dsi_obj,
     return 0;
 }
 
+static int vfio_ds_iommu_bind_stage1_pgtbl(DualStageIOMMUObject *dsi_obj,
+                                           DualIOMMUStage1BindData *bind_data)
+{
+    VFIOContainer *container = container_of(dsi_obj, VFIOContainer, dsi_obj);
+    struct vfio_iommu_type1_bind *bind;
+    unsigned long argsz;
+    int ret = 0;
+
+    argsz = sizeof(*bind) + sizeof(bind_data->bind_data);
+    bind = g_malloc0(argsz);
+    bind->argsz = argsz;
+    bind->flags = VFIO_IOMMU_BIND_GUEST_PGTBL;
+    memcpy(&bind->data, &bind_data->bind_data, sizeof(bind_data->bind_data));
+
+    if (ioctl(container->fd, VFIO_IOMMU_BIND, bind)) {
+        error_report("%s: pasid (%u) bind failed: %d",
+                      __func__, bind_data->pasid, -errno);
+        ret = -errno;
+    }
+    g_free(bind);
+    return ret;
+}
+
+static int vfio_ds_iommu_unbind_stage1_pgtbl(DualStageIOMMUObject *dsi_obj,
+                                        DualIOMMUStage1BindData *bind_data)
+{
+    VFIOContainer *container = container_of(dsi_obj, VFIOContainer, dsi_obj);
+    struct vfio_iommu_type1_bind *bind;
+    unsigned long argsz;
+    int ret = 0;
+
+    argsz = sizeof(*bind) + sizeof(bind_data->bind_data);
+    bind = g_malloc0(argsz);
+    bind->argsz = argsz;
+    bind->flags = VFIO_IOMMU_UNBIND_GUEST_PGTBL;
+    memcpy(&bind->data, &bind_data->bind_data, sizeof(bind_data->bind_data));
+
+    if (ioctl(container->fd, VFIO_IOMMU_BIND, bind)) {
+        error_report("%s: pasid (%u) unbind failed: %d",
+                      __func__, bind_data->pasid, -errno);
+        ret = -errno;
+    }
+    g_free(bind);
+    return ret;
+}
+
 static struct DualStageIOMMUOps vfio_ds_iommu_ops = {
     .pasid_alloc = vfio_ds_iommu_pasid_alloc,
     .pasid_free = vfio_ds_iommu_pasid_free,
+    .bind_stage1_pgtbl = vfio_ds_iommu_bind_stage1_pgtbl,
+    .unbind_stage1_pgtbl = vfio_ds_iommu_unbind_stage1_pgtbl,
 };
 
 static int vfio_get_iommu_info(VFIOContainer *container,
diff --git a/include/hw/iommu/dual_stage_iommu.h b/include/hw/iommu/dual_stage_iommu.h
index c6100b4..0eb983c 100644
--- a/include/hw/iommu/dual_stage_iommu.h
+++ b/include/hw/iommu/dual_stage_iommu.h
@@ -31,6 +31,7 @@
 typedef struct DualStageIOMMUObject DualStageIOMMUObject;
 typedef struct DualStageIOMMUOps DualStageIOMMUOps;
 typedef struct DualStageIOMMUInfo DualStageIOMMUInfo;
+typedef struct DualIOMMUStage1BindData DualIOMMUStage1BindData;
 
 struct DualStageIOMMUOps {
     /* Allocate pasid from DualStageIOMMU (a.k.a. host IOMMU) */
@@ -41,6 +42,16 @@ struct DualStageIOMMUOps {
     /* Reclaim a pasid from DualStageIOMMU (a.k.a. host IOMMU) */
     int (*pasid_free)(DualStageIOMMUObject *dsi_obj,
                       uint32_t pasid);
+    /*
+     * Bind stage-1 page table to a DualStageIOMMU (a.k.a. host
+     * IOMMU which has dual stage DMA translation capability.
+     * @bind_data specifies the bind configurations.
+     */
+    int (*bind_stage1_pgtbl)(DualStageIOMMUObject *dsi_obj,
+                            DualIOMMUStage1BindData *bind_data);
+    /* Undo a previous bind. @bind_data specifies the unbind info. */
+    int (*unbind_stage1_pgtbl)(DualStageIOMMUObject *dsi_obj,
+                              DualIOMMUStage1BindData *bind_data);
 };
 
 struct DualStageIOMMUInfo {
@@ -55,9 +66,20 @@ struct DualStageIOMMUObject {
     DualStageIOMMUInfo uinfo;
 };
 
+struct DualIOMMUStage1BindData {
+    uint32_t pasid;
+    union {
+        struct iommu_gpasid_bind_data gpasid_bind;
+    } bind_data;
+};
+
 int ds_iommu_pasid_alloc(DualStageIOMMUObject *dsi_obj, uint32_t min,
                          uint32_t max, uint32_t *pasid);
 int ds_iommu_pasid_free(DualStageIOMMUObject *dsi_obj, uint32_t pasid);
+int ds_iommu_bind_stage1_pgtbl(DualStageIOMMUObject *dsi_obj,
+                               DualIOMMUStage1BindData *bind_data);
+int ds_iommu_unbind_stage1_pgtbl(DualStageIOMMUObject *dsi_obj,
+                                 DualIOMMUStage1BindData *bind_data);
 
 void ds_iommu_object_init(DualStageIOMMUObject *dsi_obj,
                           DualStageIOMMUOps *ops,
-- 
2.7.4


