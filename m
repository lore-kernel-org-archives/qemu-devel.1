Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A42C4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F11206F8
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F11206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFzwa-0003re-Po
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 08:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jFzl0-0001FC-5R
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jFzky-000409-Kw
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:31:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:41735)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jFzky-0003ol-CY
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:31:08 -0400
IronPort-SDR: OQu8jpe5IahkoIDU/Hulc1/SHyzoOX+PgiKSNI31HVYv0lEkvxsyUEzBiz75POIvi3tYl5CyaY
 gZOqEZ1E8JAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 05:30:39 -0700
IronPort-SDR: 9JFGenLxezvZArebX0ilx4WPN6XHUk9n6XDRyPOdH2VNlKSvn00iKYx84XGJmj6z2kEkrGFTX9
 MXsCQX+N7/pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,292,1580803200"; d="scan'208";a="239664405"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 22 Mar 2020 05:30:38 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [PATCH v1 18/22] vfio: add support for flush iommu stage-1 cache
Date: Sun, 22 Mar 2020 05:36:15 -0700
Message-Id: <1584880579-12178-19-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, yi.l.liu@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 hao.wu@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds flush_stage1_cache() definition in HostIOMUContextClass.
And adds corresponding implementation in VFIO. This is to expose a way
for vIOMMU to flush stage-1 cache in host side since guest owns stage-1
translation structures in dual stage DMA translation configuration.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/iommu/host_iommu_context.c         | 19 +++++++++++++++++++
 hw/vfio/common.c                      | 24 ++++++++++++++++++++++++
 include/hw/iommu/host_iommu_context.h | 14 ++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/hw/iommu/host_iommu_context.c b/hw/iommu/host_iommu_context.c
index 8a53376..4bff1a1 100644
--- a/hw/iommu/host_iommu_context.c
+++ b/hw/iommu/host_iommu_context.c
@@ -113,6 +113,25 @@ int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *host_icx,
     return hicxc->unbind_stage1_pgtbl(host_icx, data);
 }
 
+int host_iommu_ctx_flush_stage1_cache(HostIOMMUContext *host_icx,
+                                      DualIOMMUStage1Cache *cache)
+{
+    HostIOMMUContextClass *hicxc;
+
+    hicxc = HOST_IOMMU_CONTEXT_GET_CLASS(host_icx);
+
+    if (!hicxc) {
+        return -EINVAL;
+    }
+
+    if (!(host_icx->flags & HOST_IOMMU_NESTING) ||
+        !hicxc->flush_stage1_cache) {
+        return -EINVAL;
+    }
+
+    return hicxc->flush_stage1_cache(host_icx, cache);
+}
+
 void host_iommu_ctx_init(void *_host_icx, size_t instance_size,
                          const char *mrtypename,
                          uint64_t flags, uint32_t formats)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 770a785..e69fe94 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1269,6 +1269,29 @@ static int vfio_host_icx_unbind_stage1_pgtbl(HostIOMMUContext *host_icx,
     return ret;
 }
 
+static int vfio_host_icx_flush_stage1_cache(HostIOMMUContext *host_icx,
+                                            DualIOMMUStage1Cache *cache)
+{
+    VFIOContainer *container = container_of(host_icx, VFIOContainer, host_icx);
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
 /**
  * Get iommu info from host. Caller of this funcion should free
  * the memory pointed by the returned pointer stored in @info
@@ -1996,6 +2019,7 @@ static void vfio_host_iommu_context_class_init(ObjectClass *klass,
     hicxc->pasid_free = vfio_host_icx_pasid_free;
     hicxc->bind_stage1_pgtbl = vfio_host_icx_bind_stage1_pgtbl;
     hicxc->unbind_stage1_pgtbl = vfio_host_icx_unbind_stage1_pgtbl;
+    hicxc->flush_stage1_cache = vfio_host_icx_flush_stage1_cache;
 }
 
 static const TypeInfo vfio_host_iommu_context_info = {
diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/host_iommu_context.h
index 97c9473..6230daa 100644
--- a/include/hw/iommu/host_iommu_context.h
+++ b/include/hw/iommu/host_iommu_context.h
@@ -42,6 +42,7 @@
 
 typedef struct HostIOMMUContext HostIOMMUContext;
 typedef struct DualIOMMUStage1BindData DualIOMMUStage1BindData;
+typedef struct DualIOMMUStage1Cache DualIOMMUStage1Cache;
 
 typedef struct HostIOMMUContextClass {
     /* private */
@@ -65,6 +66,12 @@ typedef struct HostIOMMUContextClass {
     /* Undo a previous bind. @bind_data specifies the unbind info. */
     int (*unbind_stage1_pgtbl)(HostIOMMUContext *dsi_obj,
                                DualIOMMUStage1BindData *bind_data);
+    /*
+     * Propagate stage-1 cache flush to host IOMMU, cache
+     * info specifid in @cache
+     */
+    int (*flush_stage1_cache)(HostIOMMUContext *host_icx,
+                              DualIOMMUStage1Cache *cache);
 } HostIOMMUContextClass;
 
 /*
@@ -86,6 +93,11 @@ struct DualIOMMUStage1BindData {
     } bind_data;
 };
 
+struct DualIOMMUStage1Cache {
+    uint32_t pasid;
+    struct iommu_cache_invalidate_info cache_info;
+};
+
 int host_iommu_ctx_pasid_alloc(HostIOMMUContext *host_icx, uint32_t min,
                                uint32_t max, uint32_t *pasid);
 int host_iommu_ctx_pasid_free(HostIOMMUContext *host_icx, uint32_t pasid);
@@ -93,6 +105,8 @@ int host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *host_icx,
                                      DualIOMMUStage1BindData *data);
 int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *host_icx,
                                        DualIOMMUStage1BindData *data);
+int host_iommu_ctx_flush_stage1_cache(HostIOMMUContext *host_icx,
+                                      DualIOMMUStage1Cache *cache);
 
 void host_iommu_ctx_init(void *_host_icx, size_t instance_size,
                          const char *mrtypename,
-- 
2.7.4


