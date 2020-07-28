Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE15C433EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 06:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96830207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 06:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96830207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0JEX-00057Z-Q7
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 02:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1k0J5m-0001Fl-Ta
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 02:28:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:37274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1k0J5c-0002BC-Ly
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 02:28:02 -0400
IronPort-SDR: tSl3tZWnHy0E1paGzoQt5j/IAbrgvQaML/SrMwWRW5jM7sP+ioe5ued+YlDi3O9k/vd/Bndjuc
 QdjhXKyNg0lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="152412050"
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; d="scan'208";a="152412050"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 23:27:49 -0700
IronPort-SDR: 6DS9mDtWVpDyN/YjL2UcaTMoBaSIgm9xjCZp2S9r7XA7gpGi9HQg6ZiuMUvXnZgnc87+8ExXGe
 n5hdDI7RU/Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; d="scan'208";a="394232980"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2020 23:27:48 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com,
 jasowang@redhat.com
Subject: [RFC v9 16/25] vfio: add bind stage-1 page table support
Date: Mon, 27 Jul 2020 23:34:09 -0700
Message-Id: <1595918058-33392-17-git-send-email-yi.l.liu@intel.com>
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

This patch adds bind_stage1_pgtbl() definition in HostIOMMUContextClass,
also adds corresponding implementation in VFIO. This is to expose a way
for vIOMMU to setup dual stage DMA translation for passthru devices on
hardware.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/iommu/host_iommu_context.c         | 57 +++++++++++++++++++++++++++++++++-
 hw/vfio/common.c                      | 58 ++++++++++++++++++++++++++++++++++-
 include/hw/iommu/host_iommu_context.h | 19 +++++++++++-
 3 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/hw/iommu/host_iommu_context.c b/hw/iommu/host_iommu_context.c
index 5fb2223..c43965c 100644
--- a/hw/iommu/host_iommu_context.c
+++ b/hw/iommu/host_iommu_context.c
@@ -69,23 +69,78 @@ int host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx, uint32_t pasid)
     return hicxc->pasid_free(iommu_ctx, pasid);
 }
 
+int host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                     struct iommu_gpasid_bind_data *bind)
+{
+    HostIOMMUContextClass *hicxc;
+
+    if (!iommu_ctx) {
+        return -EINVAL;
+    }
+
+    hicxc = HOST_IOMMU_CONTEXT_GET_CLASS(iommu_ctx);
+    if (!hicxc) {
+        return -EINVAL;
+    }
+
+    if (!(iommu_ctx->flags & HOST_IOMMU_NESTING) ||
+        !hicxc->bind_stage1_pgtbl) {
+        return -EINVAL;
+    }
+
+    return hicxc->bind_stage1_pgtbl(iommu_ctx, bind);
+}
+
+int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                 struct iommu_gpasid_bind_data *unbind)
+{
+    HostIOMMUContextClass *hicxc;
+
+    if (!iommu_ctx) {
+        return -EINVAL;
+    }
+
+    hicxc = HOST_IOMMU_CONTEXT_GET_CLASS(iommu_ctx);
+    if (!hicxc) {
+        return -EINVAL;
+    }
+
+    if (!(iommu_ctx->flags & HOST_IOMMU_NESTING) ||
+        !hicxc->unbind_stage1_pgtbl) {
+        return -EINVAL;
+    }
+
+    return hicxc->unbind_stage1_pgtbl(iommu_ctx, unbind);
+}
+
 void host_iommu_ctx_init(void *_iommu_ctx, size_t instance_size,
                          const char *mrtypename,
-                         uint64_t flags)
+                         uint64_t flags,
+                         struct iommu_nesting_info *info)
 {
     HostIOMMUContext *iommu_ctx;
 
     object_initialize(_iommu_ctx, instance_size, mrtypename);
     iommu_ctx = HOST_IOMMU_CONTEXT(_iommu_ctx);
     iommu_ctx->flags = flags;
+    iommu_ctx->info = g_malloc0(info->argsz);
+    memcpy(iommu_ctx->info, info, info->argsz);
     iommu_ctx->initialized = true;
 }
 
+static void host_iommu_ctx_finalize_fn(Object *obj)
+{
+    HostIOMMUContext *iommu_ctx = HOST_IOMMU_CONTEXT(obj);
+
+    g_free(iommu_ctx->info);
+}
+
 static const TypeInfo host_iommu_context_info = {
     .parent             = TYPE_OBJECT,
     .name               = TYPE_HOST_IOMMU_CONTEXT,
     .class_size         = sizeof(HostIOMMUContextClass),
     .instance_size      = sizeof(HostIOMMUContext),
+    .instance_finalize  = host_iommu_ctx_finalize_fn,
     .abstract           = true,
 };
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9d90732..3f09e74 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1227,6 +1227,54 @@ static int vfio_host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx,
     return ret;
 }
 
+static int vfio_host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                         struct iommu_gpasid_bind_data *bind)
+{
+    VFIOContainer *container = container_of(iommu_ctx,
+                                            VFIOContainer, iommu_ctx);
+    struct vfio_iommu_type1_nesting_op *op;
+    unsigned long argsz;
+    int ret = 0;
+
+    argsz = sizeof(*op) + sizeof(*bind);
+    op = g_malloc0(argsz);
+    op->argsz = argsz;
+    op->flags = VFIO_IOMMU_NESTING_OP_BIND_PGTBL;
+    memcpy(&op->data, bind, sizeof(*bind));
+
+    if (ioctl(container->fd, VFIO_IOMMU_NESTING_OP, op)) {
+        ret = -errno;
+        error_report("%s: pasid (%llu) bind failed: %m",
+                      __func__, bind->hpasid);
+    }
+    g_free(op);
+    return ret;
+}
+
+static int vfio_host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                         struct iommu_gpasid_bind_data *unbind)
+{
+    VFIOContainer *container = container_of(iommu_ctx,
+                                            VFIOContainer, iommu_ctx);
+    struct vfio_iommu_type1_nesting_op *op;
+    unsigned long argsz;
+    int ret = 0;
+
+    argsz = sizeof(*op) + sizeof(*unbind);
+    op = g_malloc0(argsz);
+    op->argsz = argsz;
+    op->flags = VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL;
+    memcpy(&op->data, unbind, sizeof(*unbind));
+
+    if (ioctl(container->fd, VFIO_IOMMU_NESTING_OP, op)) {
+        ret = -errno;
+        error_report("%s: pasid (%llu) unbind failed: %m",
+                      __func__, unbind->hpasid);
+    }
+    g_free(op);
+    return ret;
+}
+
 /**
  * Get iommu info from host. Caller of this funcion should free
  * the memory pointed by the returned pointer stored in @info
@@ -1364,10 +1412,16 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
         nest_info = (struct iommu_nesting_info *) &nesting->info;
         flags |= (nest_info->features & IOMMU_NESTING_FEAT_SYSWIDE_PASID) ?
                  HOST_IOMMU_PASID_REQUEST : 0;
+        if ((nest_info->features & IOMMU_NESTING_FEAT_BIND_PGTBL) &&
+            (nest_info->features & IOMMU_NESTING_FEAT_CACHE_INVLD)) {
+            flags |= HOST_IOMMU_NESTING;
+        }
+
         host_iommu_ctx_init(&container->iommu_ctx,
                             sizeof(container->iommu_ctx),
                             TYPE_VFIO_HOST_IOMMU_CONTEXT,
-                            flags);
+                            flags,
+                            nest_info);
         g_free(nesting);
     }
 
@@ -1967,6 +2021,8 @@ static void vfio_host_iommu_context_class_init(ObjectClass *klass,
 
     hicxc->pasid_alloc = vfio_host_iommu_ctx_pasid_alloc;
     hicxc->pasid_free = vfio_host_iommu_ctx_pasid_free;
+    hicxc->bind_stage1_pgtbl = vfio_host_iommu_ctx_bind_stage1_pgtbl;
+    hicxc->unbind_stage1_pgtbl = vfio_host_iommu_ctx_unbind_stage1_pgtbl;
 }
 
 static const TypeInfo vfio_host_iommu_context_info = {
diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/host_iommu_context.h
index 227c433..2883ed8 100644
--- a/include/hw/iommu/host_iommu_context.h
+++ b/include/hw/iommu/host_iommu_context.h
@@ -54,6 +54,16 @@ typedef struct HostIOMMUContextClass {
     /* Reclaim pasid from HostIOMMUContext (a.k.a. host software) */
     int (*pasid_free)(HostIOMMUContext *iommu_ctx,
                       uint32_t pasid);
+    /*
+     * Bind stage-1 page table to a hostIOMMU w/ dual stage
+     * DMA translation capability.
+     * @bind specifies the bind configurations.
+     */
+    int (*bind_stage1_pgtbl)(HostIOMMUContext *iommu_ctx,
+                             struct iommu_gpasid_bind_data *bind);
+    /* Undo a previous bind. @unbind specifies the unbind info. */
+    int (*unbind_stage1_pgtbl)(HostIOMMUContext *iommu_ctx,
+                               struct iommu_gpasid_bind_data *unbind);
 } HostIOMMUContextClass;
 
 /*
@@ -62,17 +72,24 @@ typedef struct HostIOMMUContextClass {
 struct HostIOMMUContext {
     Object parent_obj;
 #define HOST_IOMMU_PASID_REQUEST (1ULL << 0)
+#define HOST_IOMMU_NESTING       (1ULL << 1)
     uint64_t flags;
+    struct iommu_nesting_info *info;
     bool initialized;
 };
 
 int host_iommu_ctx_pasid_alloc(HostIOMMUContext *iommu_ctx, uint32_t min,
                                uint32_t max, uint32_t *pasid);
 int host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx, uint32_t pasid);
+int host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                     struct iommu_gpasid_bind_data *bind);
+int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                 struct iommu_gpasid_bind_data *unbind);
 
 void host_iommu_ctx_init(void *_iommu_ctx, size_t instance_size,
                          const char *mrtypename,
-                         uint64_t flags);
+                         uint64_t flags,
+                         struct iommu_nesting_info *info);
 void host_iommu_ctx_destroy(HostIOMMUContext *iommu_ctx);
 
 #endif
-- 
2.7.4


