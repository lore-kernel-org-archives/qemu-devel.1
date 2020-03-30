Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CFEC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A6C206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A6C206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIlxL-0007Rg-59
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 00:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jIlto-0001eY-D5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jIltm-0008AN-SX
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:12573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jIltm-0007o2-Kb
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:42 -0400
IronPort-SDR: 4eGoTEg5DOEq6xt4xjrEoJTvTvrgVZ0D7TXISoklkWsXlxik0K4NGkXDqi9GTLZ+7uVBnsC8YE
 HwmkK0/MaPUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 21:19:16 -0700
IronPort-SDR: V1/iR13NcaFa1PlQS7ZGGhNzKGcVM3O1RL+u6ldKaqXgJHgFsM8ecmTVVyQpEXR8LSA0YJ0wJG
 S7vZeEaIjWSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,322,1580803200"; d="scan'208";a="327632056"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 29 Mar 2020 21:19:16 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [PATCH v2 15/22] intel_iommu: bind/unbind guest page table to host
Date: Sun, 29 Mar 2020 21:24:54 -0700
Message-Id: <1585542301-84087-16-git-send-email-yi.l.liu@intel.com>
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
 hao.wu@intel.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch captures the guest PASID table entry modifications and
propagates the changes to host to setup dual stage DMA translation.
The guest page table is configured as 1st level page table (GVA->GPA)
whose translation result would further go through host VT-d 2nd
level page table(GPA->HPA) under nested translation mode. This is the
key part of vSVA support, and also a key to support IOVA over 1st-
level page table for Intel VT-d in virtualization environment.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 98 +++++++++++++++++++++++++++++++++++++++---
 hw/i386/intel_iommu_internal.h | 18 ++++++++
 2 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a7e9973..d87f608 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -41,6 +41,7 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/jhash.h"
+#include <linux/iommu.h>
 
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -700,6 +701,16 @@ static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
     return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce->val[0]) + 7);
 }
 
+static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
+{
+    return 48 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM) * 9;
+}
+
+static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
+{
+    return pe->val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
+}
+
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
 {
     return pdire->val & 1;
@@ -1861,6 +1872,82 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
+/**
+ * Caller should hold iommu_lock.
+ */
+static int vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
+                                int devfn, int pasid, VTDPASIDEntry *pe,
+                                VTDPASIDOp op)
+{
+    VTDHostIOMMUContext *vtd_dev_icx;
+    HostIOMMUContext *iommu_ctx;
+    DualIOMMUStage1BindData *bind_data;
+    struct iommu_gpasid_bind_data *g_bind_data;
+    int ret = -1;
+
+    vtd_dev_icx = vtd_bus->dev_icx[devfn];
+    if (!vtd_dev_icx) {
+        /* means no need to go further, e.g. for emulated devices */
+        return 0;
+    }
+
+    iommu_ctx = vtd_dev_icx->iommu_ctx;
+    if (!iommu_ctx) {
+        return -EINVAL;
+    }
+
+    if (!(iommu_ctx->stage1_formats
+             & IOMMU_PASID_FORMAT_INTEL_VTD)) {
+        error_report_once("IOMMU Stage 1 format is not compatible!\n");
+        return -EINVAL;
+    }
+
+    bind_data = g_malloc0(sizeof(*bind_data));
+    bind_data->pasid = pasid;
+    g_bind_data = &bind_data->bind_data.gpasid_bind;
+
+    g_bind_data->flags = 0;
+    g_bind_data->vtd.flags = 0;
+    switch (op) {
+    case VTD_PASID_BIND:
+        g_bind_data->version = IOMMU_UAPI_VERSION;
+        g_bind_data->format = IOMMU_PASID_FORMAT_INTEL_VTD;
+        g_bind_data->gpgd = vtd_pe_get_flpt_base(pe);
+        g_bind_data->addr_width = vtd_pe_get_fl_aw(pe);
+        g_bind_data->hpasid = pasid;
+        g_bind_data->gpasid = pasid;
+        g_bind_data->flags |= IOMMU_SVA_GPASID_VAL;
+        g_bind_data->vtd.flags =
+                             (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]) ? 1 : 0)
+                           | (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]) ? 1 : 0)
+                           | (VTD_SM_PASID_ENTRY_PCD_BIT(pe->val[1]) ? 1 : 0)
+                           | (VTD_SM_PASID_ENTRY_PWT_BIT(pe->val[1]) ? 1 : 0)
+                           | (VTD_SM_PASID_ENTRY_EMTE_BIT(pe->val[1]) ? 1 : 0)
+                           | (VTD_SM_PASID_ENTRY_CD_BIT(pe->val[1]) ? 1 : 0);
+        g_bind_data->vtd.pat = VTD_SM_PASID_ENTRY_PAT(pe->val[1]);
+        g_bind_data->vtd.emt = VTD_SM_PASID_ENTRY_EMT(pe->val[1]);
+        ret = host_iommu_ctx_bind_stage1_pgtbl(iommu_ctx, bind_data);
+        break;
+    case VTD_PASID_UNBIND:
+        g_bind_data->version = IOMMU_UAPI_VERSION;
+        g_bind_data->format = IOMMU_PASID_FORMAT_INTEL_VTD;
+        g_bind_data->gpgd = 0;
+        g_bind_data->addr_width = 0;
+        g_bind_data->hpasid = pasid;
+        g_bind_data->gpasid = pasid;
+        g_bind_data->flags |= IOMMU_SVA_GPASID_VAL;
+        ret = host_iommu_ctx_unbind_stage1_pgtbl(iommu_ctx, bind_data);
+        break;
+    default:
+        error_report_once("Unknown VTDPASIDOp!!!\n");
+        break;
+    }
+
+    g_free(bind_data);
+
+    return ret;
+}
+
 /* Do a context-cache device-selective invalidation.
  * @func_mask: FM field after shifting
  */
@@ -2489,10 +2576,10 @@ static void vtd_fill_pe_in_cache(IntelIOMMUState *s,
     }
 
     pc_entry->pasid_entry = *pe;
-    /*
-     * TODO:
-     * - send pasid bind to host for passthru devices
-     */
+    vtd_bind_guest_pasid(s, vtd_pasid_as->vtd_bus,
+                         vtd_pasid_as->devfn,
+                         vtd_pasid_as->pasid,
+                         pe, VTD_PASID_BIND);
 }
 
 /**
@@ -2565,10 +2652,11 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
 remove:
     /*
      * TODO:
-     * - send pasid bind to host for passthru devices
      * - when pasid-base-iotlb(piotlb) infrastructure is ready,
      *   should invalidate QEMU piotlb togehter with this change.
      */
+    vtd_bind_guest_pasid(s, vtd_bus, devfn,
+                         pasid, NULL, VTD_PASID_UNBIND);
     return true;
 }
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 451ef4c..b9e48ab 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -517,6 +517,13 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
+enum VTDPASIDOp {
+    VTD_PASID_BIND,
+    VTD_PASID_UNBIND,
+    VTD_OP_NUM
+};
+typedef enum VTDPASIDOp VTDPASIDOp;
+
 struct VTDPASIDCacheInfo {
 #define VTD_PASID_CACHE_FORCE_RESET    (1ULL << 0)
 #define VTD_PASID_CACHE_GLOBAL         (1ULL << 1)
@@ -556,6 +563,17 @@ typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
 #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
 
+#define VTD_SM_PASID_ENTRY_FLPM          3ULL
+#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_SRE_BIT(val)  (!!((val) & 1ULL))
+#define VTD_SM_PASID_ENTRY_EAFE_BIT(val) (!!(((val) >> 7) & 1ULL))
+#define VTD_SM_PASID_ENTRY_PCD_BIT(val)  (!!(((val) >> 31) & 1ULL))
+#define VTD_SM_PASID_ENTRY_PWT_BIT(val)  (!!(((val) >> 30) & 1ULL))
+#define VTD_SM_PASID_ENTRY_EMTE_BIT(val) (!!(((val) >> 26) & 1ULL))
+#define VTD_SM_PASID_ENTRY_CD_BIT(val)   (!!(((val) >> 25) & 1ULL))
+#define VTD_SM_PASID_ENTRY_PAT(val)      (((val) >> 32) & 0xFFFFFFFFULL)
+#define VTD_SM_PASID_ENTRY_EMT(val)      (((val) >> 27) & 0x7ULL)
+
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
 
-- 
2.7.4


