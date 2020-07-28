Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6918C433F1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 06:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECD0207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 06:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECD0207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0JEc-0005Kd-PX
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 02:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1k0J5q-0001N2-9Q
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 02:28:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:37270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1k0J5o-0002B0-9s
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 02:28:05 -0400
IronPort-SDR: 1LexbXZzBZp0DA2pVHbv4Kdm4TxJOXzYFRSYlEqOOgW09N648YQ2XWuPYnNuv4W+9jjkcUsx2B
 s5a5L6R2zZPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="152412067"
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; d="scan'208";a="152412067"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 23:27:55 -0700
IronPort-SDR: ejMU6DzdEDW/ABSoGRiipppTxqc9OzO7XfaQxChOAC7EQJFA5skIXq+AIvA81uV11Q6WgEXI9m
 S2V3TpLbWJQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; d="scan'208";a="394233075"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2020 23:27:54 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com,
 jasowang@redhat.com
Subject: [RFC v9 21/25] vfio: add support for flush iommu stage-1 cache
Date: Mon, 27 Jul 2020 23:34:14 -0700
Message-Id: <1595918058-33392-22-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595918058-33392-1-git-send-email-yi.l.liu@intel.com>
References: <1595918058-33392-1-git-send-email-yi.l.liu@intel.com>
Received-SPF: pass client-ip=134.134.136.24; envelope-from=yi.l.liu@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 02:27:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/iommu/host_iommu_context.c         | 19 +++++++++++++++++++
 hw/vfio/common.c                      | 24 ++++++++++++++++++++++++
 include/hw/iommu/host_iommu_context.h |  8 ++++++++
 3 files changed, 51 insertions(+)

diff --git a/hw/iommu/host_iommu_context.c b/hw/iommu/host_iommu_context.c
index c43965c..a3f7706 100644
--- a/hw/iommu/host_iommu_context.c
+++ b/hw/iommu/host_iommu_context.c
@@ -113,6 +113,25 @@ int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
     return hicxc->unbind_stage1_pgtbl(iommu_ctx, unbind);
 }
 
+int host_iommu_ctx_flush_stage1_cache(HostIOMMUContext *iommu_ctx,
+                                 struct iommu_cache_invalidate_info *cache)
+{
+    HostIOMMUContextClass *hicxc;
+
+    hicxc = HOST_IOMMU_CONTEXT_GET_CLASS(iommu_ctx);
+
+    if (!hicxc) {
+        return -EINVAL;
+    }
+
+    if (!(iommu_ctx->flags & HOST_IOMMU_NESTING) ||
+        !hicxc->flush_stage1_cache) {
+        return -EINVAL;
+    }
+
+    return hicxc->flush_stage1_cache(iommu_ctx, cache);
+}
+
 void host_iommu_ctx_init(void *_iommu_ctx, size_t instance_size,
                          const char *mrtypename,
                          uint64_t flags,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3f09e74..97b8200 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1275,6 +1275,29 @@ static int vfio_host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
     return ret;
 }
 
+static int vfio_host_iommu_ctx_flush_stage1_cache(HostIOMMUContext *iommu_ctx,
+                                    struct iommu_cache_invalidate_info *cache)
+{
+    VFIOContainer *container = container_of(iommu_ctx,
+                                            VFIOContainer, iommu_ctx);
+    struct vfio_iommu_type1_nesting_op *op;
+    unsigned long argsz;
+    int ret = 0;
+
+    argsz = sizeof(*op) + sizeof(*cache);
+    op = g_malloc0(argsz);
+    op->argsz = argsz;
+    op->flags = VFIO_IOMMU_NESTING_OP_CACHE_INVLD;
+    memcpy(&op->data, cache, sizeof(*cache));
+
+    if (ioctl(container->fd, VFIO_IOMMU_NESTING_OP, op)) {
+        ret = -errno;
+        error_report("%s: iommu cache flush failed: %m", __func__);
+    }
+    g_free(op);
+    return ret;
+}
+
 /**
  * Get iommu info from host. Caller of this funcion should free
  * the memory pointed by the returned pointer stored in @info
@@ -2023,6 +2046,7 @@ static void vfio_host_iommu_context_class_init(ObjectClass *klass,
     hicxc->pasid_free = vfio_host_iommu_ctx_pasid_free;
     hicxc->bind_stage1_pgtbl = vfio_host_iommu_ctx_bind_stage1_pgtbl;
     hicxc->unbind_stage1_pgtbl = vfio_host_iommu_ctx_unbind_stage1_pgtbl;
+    hicxc->flush_stage1_cache = vfio_host_iommu_ctx_flush_stage1_cache;
 }
 
 static const TypeInfo vfio_host_iommu_context_info = {
diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/host_iommu_context.h
index 2883ed8..40e860a 100644
--- a/include/hw/iommu/host_iommu_context.h
+++ b/include/hw/iommu/host_iommu_context.h
@@ -64,6 +64,12 @@ typedef struct HostIOMMUContextClass {
     /* Undo a previous bind. @unbind specifies the unbind info. */
     int (*unbind_stage1_pgtbl)(HostIOMMUContext *iommu_ctx,
                                struct iommu_gpasid_bind_data *unbind);
+    /*
+     * Propagate stage-1 cache flush to host IOMMU, cache
+     * info specifid in @cache
+     */
+    int (*flush_stage1_cache)(HostIOMMUContext *iommu_ctx,
+                              struct iommu_cache_invalidate_info *cache);
 } HostIOMMUContextClass;
 
 /*
@@ -85,6 +91,8 @@ int host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
                                      struct iommu_gpasid_bind_data *bind);
 int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
                                  struct iommu_gpasid_bind_data *unbind);
+int host_iommu_ctx_flush_stage1_cache(HostIOMMUContext *iommu_ctx,
+                               struct iommu_cache_invalidate_info *cache);
 
 void host_iommu_ctx_init(void *_iommu_ctx, size_t instance_size,
                          const char *mrtypename,
-- 
2.7.4


