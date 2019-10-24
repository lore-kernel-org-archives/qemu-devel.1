Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65848CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3674120679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3674120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeEf-0001PA-Ba
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckl-0005rf-W0
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckh-0002qG-55
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:40489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iNckg-0002NX-K2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="210156302"
Received: from iov.bj.intel.com ([10.238.145.67])
 by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 06:01:52 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v2 15/22] intel_iommu: bind/unbind guest page table to host
Date: Thu, 24 Oct 2019 08:34:36 -0400
Message-Id: <1571920483-3382-16-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, jun.j.tian@intel.com,
 eric.auger@redhat.com, yi.y.sun@intel.com, jacob.jun.pan@linux.intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch captures the guest PASID table entry modifications and
propagates the changes to host to setup nested translation. The
guest page table is configured as 1st level page table (GVA->GPA)
whose translation result would further go through host VT-d 2nd
level page table(GPA->HPA) under nested translation mode. This is
a key part of vSVA support.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 81 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h | 20 +++++++++++
 2 files changed, 101 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d8827c9..793b0de 100644
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
@@ -1850,6 +1861,67 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
+static void vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
+            int devfn, int pasid, VTDPASIDEntry *pe, VTDPASIDOp op)
+{
+#ifdef __linux__
+    VTDIOMMUContext *vtd_ic;
+    IOMMUCTXEventData event_data;
+    IOMMUCTXPASIDBindData bind;
+    struct iommu_gpasid_bind_data *g_bind_data;
+
+    vtd_ic = vtd_bus->dev_ic[devfn];
+    if (!vtd_ic) {
+        return;
+    }
+
+    g_bind_data = g_malloc0(sizeof(*g_bind_data));
+    bind.flag = 0;
+    g_bind_data->flags = 0;
+    g_bind_data->vtd.flags = 0;
+    switch (op) {
+    case VTD_PASID_BIND:
+    case VTD_PASID_UPDATE:
+        g_bind_data->version = IOMMU_GPASID_BIND_VERSION_1;
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
+        bind.flag |= IOMMU_CTX_BIND_PASID;
+        break;
+
+    case VTD_PASID_UNBIND:
+        g_bind_data->gpgd = 0;
+        g_bind_data->addr_width = 0;
+        g_bind_data->hpasid = pasid;
+        bind.flag |= IOMMU_CTX_UNBIND_PASID;
+        break;
+
+    default:
+        printf("Unknown VTDPASIDOp!!\n");
+        break;
+    }
+    if (bind.flag) {
+        event_data.event = IOMMU_CTX_EVENT_PASID_BIND;
+        bind.data = g_bind_data;
+        event_data.data = &bind;
+        iommu_ctx_event_notify(&vtd_ic->iommu_context, &event_data);
+    }
+    g_free(g_bind_data);
+#endif
+}
+
 /* Do a context-cache device-selective invalidation.
  * @func_mask: FM field after shifting
  */
@@ -2528,12 +2600,17 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
                 pc_entry->pasid_cache_gen = s->pasid_cache_gen;
                 if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
                     pc_entry->pasid_entry = pe;
+                    vtd_bind_guest_pasid(s, vtd_bus, devfn,
+                                     pasid, &pe, VTD_PASID_UPDATE);
                     /*
                      * TODO: when pasid-base-iotlb(piotlb) infrastructure is
                      * ready, should invalidate QEMU piotlb togehter with this
                      * change.
                      */
                 }
+            } else {
+                vtd_bind_guest_pasid(s, vtd_bus, devfn,
+                                  pasid, NULL, VTD_PASID_UNBIND);
             }
         }
     }
@@ -2623,6 +2700,10 @@ static inline void vtd_fill_in_pe_cache(
 
     pc_entry->pasid_entry = *pe;
     pc_entry->pasid_cache_gen = s->pasid_cache_gen;
+    vtd_bind_guest_pasid(s, vtd_pasid_as->vtd_bus,
+                         vtd_pasid_as->devfn,
+                         vtd_pasid_as->pasid,
+                         pe, VTD_PASID_UPDATE);
 }
 
 static int vtd_pasid_cache_psi(IntelIOMMUState *s,
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 12873e1..13e02e8 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -483,6 +483,14 @@ struct VTDRootEntry {
 };
 typedef struct VTDRootEntry VTDRootEntry;
 
+enum VTDPASIDOp {
+    VTD_PASID_BIND,
+    VTD_PASID_UNBIND,
+    VTD_PASID_UPDATE,
+    VTD_OP_NUM
+};
+typedef enum VTDPASIDOp VTDPASIDOp;
+
 struct VTDPASIDCacheInfo {
 #define VTD_PASID_CACHE_DOMSI   (1ULL << 0);
 #define VTD_PASID_CACHE_PASIDSI (1ULL << 1);
@@ -549,6 +557,18 @@ typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
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


