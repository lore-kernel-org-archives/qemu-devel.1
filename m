Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1DFC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B92206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B92206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIm0V-0006HA-BA
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 00:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jIlto-0001eK-7E
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jIltm-0008A1-IS
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:12574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jIltm-0007ph-6q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:42 -0400
IronPort-SDR: 6mPZk9vo915ScVXfKOGzYBg4vLGsIFihdXSeOprtHEbw2DnyJ+p86RHzpGlsInd7dirpLCB+FO
 mer9M0RnjjQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 21:19:16 -0700
IronPort-SDR: GbJrcBr/HNsaPw+ZZqLIV7AQfQvuokwoD+cJyMjbMC2nNjlXE5nLJ2ChG87se9OwxSkje+PgSN
 CUKpYsfRYwsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,322,1580803200"; d="scan'208";a="327632054"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 29 Mar 2020 21:19:16 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [PATCH v2 14/22] vfio: add bind stage-1 page table support
Date: Sun, 29 Mar 2020 21:24:53 -0700
Message-Id: <1585542301-84087-15-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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
 hw/iommu/host_iommu_context.c         | 47 +++++++++++++++++++++++++++++-
 hw/vfio/common.c                      | 55 ++++++++++++++++++++++++++++++++++-
 include/hw/iommu/host_iommu_context.h | 26 ++++++++++++++++-
 3 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/hw/iommu/host_iommu_context.c b/hw/iommu/host_iommu_context.c
index 5fb2223..8ae20fe 100644
--- a/hw/iommu/host_iommu_context.c
+++ b/hw/iommu/host_iommu_context.c
@@ -69,15 +69,60 @@ int host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx, uint32_t pasid)
     return hicxc->pasid_free(iommu_ctx, pasid);
 }
 
+int host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                     DualIOMMUStage1BindData *data)
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
+    return hicxc->bind_stage1_pgtbl(iommu_ctx, data);
+}
+
+int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                       DualIOMMUStage1BindData *data)
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
+    return hicxc->unbind_stage1_pgtbl(iommu_ctx, data);
+}
+
 void host_iommu_ctx_init(void *_iommu_ctx, size_t instance_size,
                          const char *mrtypename,
-                         uint64_t flags)
+                         uint64_t flags, uint32_t formats)
 {
     HostIOMMUContext *iommu_ctx;
 
     object_initialize(_iommu_ctx, instance_size, mrtypename);
     iommu_ctx = HOST_IOMMU_CONTEXT(_iommu_ctx);
     iommu_ctx->flags = flags;
+    iommu_ctx->stage1_formats = formats;
     iommu_ctx->initialized = true;
 }
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 44b142c..465e4d8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1226,6 +1226,54 @@ static int vfio_host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx,
     return 0;
 }
 
+static int vfio_host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                          DualIOMMUStage1BindData *bind_data)
+{
+    VFIOContainer *container = container_of(iommu_ctx,
+                                            VFIOContainer, iommu_ctx);
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
+        ret = -errno;
+        error_report("%s: pasid (%u) bind failed: %d",
+                      __func__, bind_data->pasid, ret);
+    }
+    g_free(bind);
+    return ret;
+}
+
+static int vfio_host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                            DualIOMMUStage1BindData *bind_data)
+{
+    VFIOContainer *container = container_of(iommu_ctx,
+                                            VFIOContainer, iommu_ctx);
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
+        ret = -errno;
+        error_report("%s: pasid (%u) unbind failed: %d",
+                      __func__, bind_data->pasid, ret);
+    }
+    g_free(bind);
+    return ret;
+}
+
 /**
  * Get iommu info from host. Caller of this funcion should free
  * the memory pointed by the returned pointer stored in @info
@@ -1350,10 +1398,13 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
 
         flags |= (nesting.nesting_capabilities & VFIO_IOMMU_PASID_REQS) ?
                  HOST_IOMMU_PASID_REQUEST : 0;
+        flags |= HOST_IOMMU_NESTING;
+
         host_iommu_ctx_init(&container->iommu_ctx,
                             sizeof(container->iommu_ctx),
                             TYPE_VFIO_HOST_IOMMU_CONTEXT,
-                            flags);
+                            flags,
+                            nesting.stage1_formats);
     }
 
     container->iommu_type = iommu_type;
@@ -1945,6 +1996,8 @@ static void vfio_host_iommu_context_class_init(ObjectClass *klass,
 
     hicxc->pasid_alloc = vfio_host_iommu_ctx_pasid_alloc;
     hicxc->pasid_free = vfio_host_iommu_ctx_pasid_free;
+    hicxc->bind_stage1_pgtbl = vfio_host_iommu_ctx_bind_stage1_pgtbl;
+    hicxc->unbind_stage1_pgtbl = vfio_host_iommu_ctx_unbind_stage1_pgtbl;
 }
 
 static const TypeInfo vfio_host_iommu_context_info = {
diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/host_iommu_context.h
index 227c433..44daca9 100644
--- a/include/hw/iommu/host_iommu_context.h
+++ b/include/hw/iommu/host_iommu_context.h
@@ -41,6 +41,7 @@
                          TYPE_HOST_IOMMU_CONTEXT)
 
 typedef struct HostIOMMUContext HostIOMMUContext;
+typedef struct DualIOMMUStage1BindData DualIOMMUStage1BindData;
 
 typedef struct HostIOMMUContextClass {
     /* private */
@@ -54,6 +55,16 @@ typedef struct HostIOMMUContextClass {
     /* Reclaim pasid from HostIOMMUContext (a.k.a. host software) */
     int (*pasid_free)(HostIOMMUContext *iommu_ctx,
                       uint32_t pasid);
+    /*
+     * Bind stage-1 page table to a hostIOMMU w/ dual stage
+     * DMA translation capability.
+     * @bind_data specifies the bind configurations.
+     */
+    int (*bind_stage1_pgtbl)(HostIOMMUContext *iommu_ctx,
+                             DualIOMMUStage1BindData *bind_data);
+    /* Undo a previous bind. @bind_data specifies the unbind info. */
+    int (*unbind_stage1_pgtbl)(HostIOMMUContext *iommu_ctx,
+                               DualIOMMUStage1BindData *bind_data);
 } HostIOMMUContextClass;
 
 /*
@@ -62,17 +73,30 @@ typedef struct HostIOMMUContextClass {
 struct HostIOMMUContext {
     Object parent_obj;
 #define HOST_IOMMU_PASID_REQUEST (1ULL << 0)
+#define HOST_IOMMU_NESTING       (1ULL << 1)
     uint64_t flags;
+    uint32_t stage1_formats;
     bool initialized;
 };
 
+struct DualIOMMUStage1BindData {
+    uint32_t pasid;
+    union {
+        struct iommu_gpasid_bind_data gpasid_bind;
+    } bind_data;
+};
+
 int host_iommu_ctx_pasid_alloc(HostIOMMUContext *iommu_ctx, uint32_t min,
                                uint32_t max, uint32_t *pasid);
 int host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx, uint32_t pasid);
+int host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                     DualIOMMUStage1BindData *data);
+int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *iommu_ctx,
+                                       DualIOMMUStage1BindData *data);
 
 void host_iommu_ctx_init(void *_iommu_ctx, size_t instance_size,
                          const char *mrtypename,
-                         uint64_t flags);
+                         uint64_t flags, uint32_t formats);
 void host_iommu_ctx_destroy(HostIOMMUContext *iommu_ctx);
 
 #endif
-- 
2.7.4


