Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE08C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F0020716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F0020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmLM-00063j-Sv
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCp-00009D-5S
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCn-0003OK-LN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:58727)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iwmCn-0001Rn-Bq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:11:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="314071216"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 04:11:51 -0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v3 18/25] intel_iommu: bind/unbind guest page table to host
Date: Wed, 29 Jan 2020 04:16:49 -0800
Message-Id: <1580300216-86172-19-git-send-email-yi.l.liu@intel.com>
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
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Richard Henderson <rth@twiddle.net>,
 hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Yi L <yi.l.liu@intel.com>

This patch captures the guest PASID table entry modifications and
propagates the changes to host to setup dual stage DMA translation.
The guest page table is configured as 1st level page table (GVA->GPA)
whose translation result would further go through host VT-d 2nd
level page table(GPA->HPA) under nested translation mode. This is
a key part of vSVA support, and also a key to support IOVA over 1st
level page table for Intel VT-d in virtualization environment.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 83 +++++++++++++++++++++++++++++++++++++++++-
 hw/i386/intel_iommu_internal.h | 26 +++++++++++++
 2 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c75cb7b..319b3df 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -41,6 +41,7 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/jhash.h"
+#include <linux/iommu.h>
 
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -695,6 +696,16 @@ static inline uint16_t vtd_pe_get_domain_id(VTDPASIDEntry *pe)
     return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
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
@@ -1854,6 +1865,68 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
+static int vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
+              int devfn, int pasid, VTDPASIDEntry *pe, VTDPASIDOp op)
+{
+    VTDIOMMUContext *vtd_icx;
+    DualIOMMUStage1BindData bind_data;
+    struct iommu_gpasid_bind_data *g_bind_data;
+    int ret = -1;
+
+    vtd_icx = vtd_bus->dev_icx[devfn];
+    if (!vtd_icx) {
+        return ret;
+    }
+
+    if (vtd_icx->dsi_obj->uinfo.pasid_format
+             != IOMMU_PASID_FORMAT_INTEL_VTD)
+    {
+        error_report_once("Dual Stage IOMMU is not compatible!!\n");
+    }
+
+    bind_data.pasid = pasid;
+    g_bind_data = &bind_data.bind_data.gpasid_bind;
+
+    g_bind_data->flags = 0;
+    g_bind_data->vtd.flags = 0;
+    switch (op) {
+    case VTD_PASID_BIND:
+    case VTD_PASID_UPDATE:
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
+        ret = ds_iommu_bind_stage1_pgtbl(vtd_icx->dsi_obj, &bind_data);
+        break;
+    case VTD_PASID_UNBIND:
+        g_bind_data->version = IOMMU_UAPI_VERSION;
+        g_bind_data->format = IOMMU_PASID_FORMAT_INTEL_VTD;
+        g_bind_data->gpgd = 0;
+        g_bind_data->addr_width = 0;
+        g_bind_data->hpasid = pasid;
+        g_bind_data->gpasid = pasid;
+        g_bind_data->flags |= IOMMU_SVA_GPASID_VAL;
+        ret = ds_iommu_unbind_stage1_pgtbl(vtd_icx->dsi_obj, &bind_data);
+        break;
+    default:
+        error_report_once("Unknown VTDPASIDOp!!\n");
+        break;
+    }
+    return ret;
+}
+
 /* Do a context-cache device-selective invalidation.
  * @func_mask: FM field after shifting
  */
@@ -2532,18 +2605,20 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
         /* pasid entry was updated, thus update the pasid cache */
         pc_entry->pasid_entry = pe;
         pc_entry->pasid_cache_gen = s->pasid_cache_gen;
+        vtd_bind_guest_pasid(s, vtd_bus, devfn,
+                             pasid, &pe, VTD_PASID_UPDATE);
         /*
          * TODO:
-         * - send pasid bind to host for passthru devices
          * - when pasid-base-iotlb(piotlb) infrastructure is ready,
          *   should invalidate QEMU piotlb togehter with this change.
          */
     }
     return false;
 remove:
+    vtd_bind_guest_pasid(s, vtd_bus, devfn,
+                         pasid, NULL, VTD_PASID_UNBIND);
     /*
      * TODO:
-     * - send pasid unbind to host for passthru devices
      * - when pasid-base-iotlb(piotlb) infrastructure is ready,
      *   should invalidate QEMU piotlb togehter with this change.
      */
@@ -2634,6 +2709,10 @@ static inline void vtd_fill_in_pe_cache(
 
     pc_entry->pasid_entry = *pe;
     pc_entry->pasid_cache_gen = s->pasid_cache_gen;
+    vtd_bind_guest_pasid(s, vtd_pasid_as->vtd_bus,
+                         vtd_pasid_as->devfn,
+                         vtd_pasid_as->pasid,
+                         pe, VTD_PASID_BIND);
 }
 
 static int vtd_pasid_cache_psi(IntelIOMMUState *s,
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 18a9e50..833c442 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -486,6 +486,20 @@ struct VTDRootEntry {
 };
 typedef struct VTDRootEntry VTDRootEntry;
 
+enum VTD_DUAL_STAGE_UAPI {
+    UAPI_BIND_GPASID,
+    UAPI_NUM
+};
+typedef enum VTD_DUAL_STAGE_UAPI VTD_DUAL_STAGE_UAPI;
+
+enum VTDPASIDOp {
+    VTD_PASID_BIND,
+    VTD_PASID_UNBIND,
+    VTD_PASID_UPDATE,
+    VTD_OP_NUM
+};
+typedef enum VTDPASIDOp VTDPASIDOp;
+
 struct VTDPASIDCacheInfo {
 #define VTD_PASID_CACHE_GLOBAL   (1ULL << 0)
 #define VTD_PASID_CACHE_DOMSI    (1ULL << 1)
@@ -556,6 +570,18 @@ typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
 #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
 
+/* Adjusted guest-address-width */
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


