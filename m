Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076B5C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBA42064C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBA42064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmNl-0002cU-0q
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCz-0000Pw-Nu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCy-0003nv-9J
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:58702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iwmCx-0001NW-VM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:11:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="314071318"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 04:11:53 -0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v3 22/25] vfio: add support for flush iommu stage-1 cache
Date: Wed, 29 Jan 2020 04:16:53 -0800
Message-Id: <1580300216-86172-23-git-send-email-yi.l.liu@intel.com>
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

This patch adds flush_stage1_cache() definition in DualStageIOMMUOops.
And adds corresponding implementation in VFIO. This is to expose a way
for vIOMMU to flush stage-1 cache in host side since guest owns stage-1
translation structures in dual stage DMA translation.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/iommu/dual_stage_iommu.c         | 13 +++++++++++++
 hw/vfio/common.c                    | 24 ++++++++++++++++++++++++
 include/hw/iommu/dual_stage_iommu.h | 14 ++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/hw/iommu/dual_stage_iommu.c b/hw/iommu/dual_stage_iommu.c
index 9d99e9e..abbd2f7 100644
--- a/hw/iommu/dual_stage_iommu.c
+++ b/hw/iommu/dual_stage_iommu.c
@@ -73,6 +73,19 @@ int ds_iommu_unbind_stage1_pgtbl(DualStageIOMMUObject *dsi_obj,
     return -ENOENT;
 }
 
+int ds_iommu_flush_stage1_cache(DualStageIOMMUObject *dsi_obj,
+                                DualIOMMUStage1Cache *cache)
+{
+    if (!dsi_obj) {
+        return -ENOENT;
+    }
+
+    if (dsi_obj->ops && dsi_obj->ops->flush_stage1_cache) {
+        return dsi_obj->ops->flush_stage1_cache(dsi_obj, cache);
+    }
+    return -ENOENT;
+}
+
 void ds_iommu_object_init(DualStageIOMMUObject *dsi_obj,
                           DualStageIOMMUOps *ops,
                           DualStageIOMMUInfo *uinfo)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index d84bdc9..6f0933c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1265,11 +1265,35 @@ static int vfio_ds_iommu_unbind_stage1_pgtbl(DualStageIOMMUObject *dsi_obj,
     return ret;
 }
 
+static int vfio_ds_iommu_flush_stage1_cache(DualStageIOMMUObject *dsi_obj,
+                                            DualIOMMUStage1Cache *cache)
+{
+    VFIOContainer *container = container_of(dsi_obj, VFIOContainer, dsi_obj);
+    struct vfio_iommu_type1_cache_invalidate *cache_inv;
+    unsigned long argsz;
+    int ret = 0;
+
+    argsz = sizeof(*cache_inv) + sizeof(cache->cache_info);
+    cache_inv = g_malloc0(argsz);
+    cache_inv->argsz = argsz;
+    cache_inv->flags = 0;
+    memcpy(&cache_inv->cache_info, &cache->cache_info,
+           sizeof(cache->cache_info));
+
+    if (ioctl(container->fd, VFIO_IOMMU_CACHE_INVALIDATE, cache_inv)) {
+        error_report("%s: iommu cache flush failed: %d", __func__, -errno);
+        ret = -errno;
+    }
+    g_free(cache_inv);
+    return ret;
+}
+
 static struct DualStageIOMMUOps vfio_ds_iommu_ops = {
     .pasid_alloc = vfio_ds_iommu_pasid_alloc,
     .pasid_free = vfio_ds_iommu_pasid_free,
     .bind_stage1_pgtbl = vfio_ds_iommu_bind_stage1_pgtbl,
     .unbind_stage1_pgtbl = vfio_ds_iommu_unbind_stage1_pgtbl,
+    .flush_stage1_cache = vfio_ds_iommu_flush_stage1_cache,
 };
 
 static int vfio_get_iommu_info(VFIOContainer *container,
diff --git a/include/hw/iommu/dual_stage_iommu.h b/include/hw/iommu/dual_stage_iommu.h
index 0eb983c..7daeb72 100644
--- a/include/hw/iommu/dual_stage_iommu.h
+++ b/include/hw/iommu/dual_stage_iommu.h
@@ -32,6 +32,7 @@ typedef struct DualStageIOMMUObject DualStageIOMMUObject;
 typedef struct DualStageIOMMUOps DualStageIOMMUOps;
 typedef struct DualStageIOMMUInfo DualStageIOMMUInfo;
 typedef struct DualIOMMUStage1BindData DualIOMMUStage1BindData;
+typedef struct DualIOMMUStage1Cache DualIOMMUStage1Cache;
 
 struct DualStageIOMMUOps {
     /* Allocate pasid from DualStageIOMMU (a.k.a. host IOMMU) */
@@ -52,6 +53,12 @@ struct DualStageIOMMUOps {
     /* Undo a previous bind. @bind_data specifies the unbind info. */
     int (*unbind_stage1_pgtbl)(DualStageIOMMUObject *dsi_obj,
                               DualIOMMUStage1BindData *bind_data);
+    /*
+     * Propagate stage-1 cache flush to DualStageIOMMU (a.k.a.
+     * host IOMMU), cache info specifid in @cache
+     */
+    int (*flush_stage1_cache)(DualStageIOMMUObject *dsi_obj,
+                              DualIOMMUStage1Cache *cache);
 };
 
 struct DualStageIOMMUInfo {
@@ -73,6 +80,11 @@ struct DualIOMMUStage1BindData {
     } bind_data;
 };
 
+struct DualIOMMUStage1Cache {
+    uint32_t pasid;
+    struct iommu_cache_invalidate_info cache_info;
+};
+
 int ds_iommu_pasid_alloc(DualStageIOMMUObject *dsi_obj, uint32_t min,
                          uint32_t max, uint32_t *pasid);
 int ds_iommu_pasid_free(DualStageIOMMUObject *dsi_obj, uint32_t pasid);
@@ -80,6 +92,8 @@ int ds_iommu_bind_stage1_pgtbl(DualStageIOMMUObject *dsi_obj,
                                DualIOMMUStage1BindData *bind_data);
 int ds_iommu_unbind_stage1_pgtbl(DualStageIOMMUObject *dsi_obj,
                                  DualIOMMUStage1BindData *bind_data);
+int ds_iommu_flush_stage1_cache(DualStageIOMMUObject *dsi_obj,
+                                DualIOMMUStage1Cache *cache);
 
 void ds_iommu_object_init(DualStageIOMMUObject *dsi_obj,
                           DualStageIOMMUOps *ops,
-- 
2.7.4


