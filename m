Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707A9C35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4317B2071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4317B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5PqF-0005UR-DU
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1j5Pjl-0002BE-83
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1j5Pji-00081T-Q3
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:49238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1j5Pji-0007tq-EA
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 00:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; d="scan'208";a="240547689"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 22 Feb 2020 00:01:57 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [RFC v3.1 13/22] vfio: add bind stage-1 page table support
Date: Sat, 22 Feb 2020 00:07:14 -0800
Message-Id: <1582358843-51931-14-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582358843-51931-1-git-send-email-yi.l.liu@intel.com>
References: <1582358843-51931-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds bind_stage1_pgtbl() definition in HostIOMMUOops, also
adds corresponding implementation in VFIO. This is to expose a way for
vIOMMU to setup dual stage DMA translation for passthru devices on hardware.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
---
 hw/iommu/host_iommu_context.c         | 20 ++++++++++++++
 hw/vfio/common.c                      | 49 +++++++++++++++++++++++++++++++++++
 include/hw/iommu/host_iommu_context.h | 23 ++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/hw/iommu/host_iommu_context.c b/hw/iommu/host_iommu_context.c
index 689a087..5f7eb92 100644
--- a/hw/iommu/host_iommu_context.c
+++ b/hw/iommu/host_iommu_context.c
@@ -41,6 +41,26 @@ int host_iommu_ctx_pasid_free(HostIOMMUContext *host_icx, uint32_t pasid)
     return -ENOENT;
 }
 
+int host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *host_icx,
+                                     DualIOMMUStage1BindData *data)
+{
+    if (host_icx && (host_icx->flags & HOST_IOMMU_NESTING) &&
+        host_icx->ops && host_icx->ops->bind_stage1_pgtbl) {
+        return host_icx->ops->bind_stage1_pgtbl(host_icx, data);
+    }
+    return -ENOENT;
+}
+
+int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *host_icx,
+                                       DualIOMMUStage1BindData *data)
+{
+    if (host_icx && (host_icx->flags & HOST_IOMMU_NESTING) &&
+        host_icx->ops && host_icx->ops->unbind_stage1_pgtbl) {
+        return host_icx->ops->unbind_stage1_pgtbl(host_icx, data);
+    }
+    return -ENOENT;
+}
+
 void host_iommu_ctx_init(HostIOMMUContext *host_icx,
                          uint64_t flags, HostIOMMUOps *ops,
                          HostIOMMUInfo *uinfo)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8f30a52..b560fdb 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1223,9 +1223,57 @@ static int vfio_host_icx_pasid_free(HostIOMMUContext *host_icx,
     return 0;
 }
 
+static int vfio_host_icx_bind_stage1_pgtbl(HostIOMMUContext *host_icx,
+                                           DualIOMMUStage1BindData *bind_data)
+{
+    VFIOContainer *container = container_of(host_icx, VFIOContainer, host_icx);
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
+static int vfio_host_icx_unbind_stage1_pgtbl(HostIOMMUContext *host_icx,
+                                        DualIOMMUStage1BindData *bind_data)
+{
+    VFIOContainer *container = container_of(host_icx, VFIOContainer, host_icx);
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
 static struct HostIOMMUOps vfio_host_icx_ops = {
     .pasid_alloc = vfio_host_icx_pasid_alloc,
     .pasid_free = vfio_host_icx_pasid_free,
+    .bind_stage1_pgtbl = vfio_host_icx_bind_stage1_pgtbl,
+    .unbind_stage1_pgtbl = vfio_host_icx_unbind_stage1_pgtbl,
 };
 
 /**
@@ -1354,6 +1402,7 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
         uinfo.stage1_format = nesting.stage1_format;
         flags |= (nesting.nesting_capabilities & VFIO_IOMMU_PASID_REQS) ?
                  HOST_IOMMU_PASID_REQUEST : 0;
+        flags |= HOST_IOMMU_NESTING;
         host_iommu_ctx_init(&container->host_icx, flags,
                             &vfio_host_icx_ops, &uinfo);
     }
diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/host_iommu_context.h
index 6797f6d..660fab8 100644
--- a/include/hw/iommu/host_iommu_context.h
+++ b/include/hw/iommu/host_iommu_context.h
@@ -31,6 +31,7 @@
 typedef struct HostIOMMUContext HostIOMMUContext;
 typedef struct HostIOMMUOps HostIOMMUOps;
 typedef struct HostIOMMUInfo HostIOMMUInfo;
+typedef struct DualIOMMUStage1BindData DualIOMMUStage1BindData;
 
 struct HostIOMMUOps {
     /* Allocate pasid from HostIOMMUContext (a.k.a. host software) */
@@ -41,6 +42,16 @@ struct HostIOMMUOps {
     /* Reclaim pasid from HostIOMMUContext (a.k.a. host software) */
     int (*pasid_free)(HostIOMMUContext *host_icx,
                       uint32_t pasid);
+    /*
+     * Bind stage-1 page table to a hostIOMMU w/ dual stage
+     * DMA translation capability.
+     * @bind_data specifies the bind configurations.
+     */
+    int (*bind_stage1_pgtbl)(HostIOMMUContext *dsi_obj,
+                             DualIOMMUStage1BindData *bind_data);
+    /* Undo a previous bind. @bind_data specifies the unbind info. */
+    int (*unbind_stage1_pgtbl)(HostIOMMUContext *dsi_obj,
+                               DualIOMMUStage1BindData *bind_data);
 };
 
 struct HostIOMMUInfo {
@@ -52,14 +63,26 @@ struct HostIOMMUInfo {
  */
 struct HostIOMMUContext {
 #define HOST_IOMMU_PASID_REQUEST (1ULL << 0)
+#define HOST_IOMMU_NESTING       (1ULL << 1)
     uint64_t flags;
     HostIOMMUOps *ops;
     HostIOMMUInfo uinfo;
 };
 
+struct DualIOMMUStage1BindData {
+    uint32_t pasid;
+    union {
+        struct iommu_gpasid_bind_data gpasid_bind;
+    } bind_data;
+};
+
 int host_iommu_ctx_pasid_alloc(HostIOMMUContext *host_icx, uint32_t min,
                                uint32_t max, uint32_t *pasid);
 int host_iommu_ctx_pasid_free(HostIOMMUContext *host_icx, uint32_t pasid);
+int host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *host_icx,
+                                     DualIOMMUStage1BindData *data);
+int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *host_icx,
+                                       DualIOMMUStage1BindData *data);
 
 void host_iommu_ctx_init(HostIOMMUContext *host_icx,
                          uint64_t flags, HostIOMMUOps *ops,
-- 
2.7.4


