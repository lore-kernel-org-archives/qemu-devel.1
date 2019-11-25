Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1136C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 02:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA4D2073F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 02:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA4D2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ4Jw-0007Tx-Ea
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 21:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yadong.qi@intel.com>) id 1iZ4IY-0006It-RH
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 21:40:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yadong.qi@intel.com>) id 1iZ4IW-0005p6-KO
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 21:40:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:43957)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yadong.qi@intel.com>) id 1iZ4IV-0005of-30
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 21:40:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Nov 2019 18:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; d="scan'208";a="220127219"
Received: from caas-nuc7i7dnhe.sh.intel.com ([10.239.158.159])
 by orsmga002.jf.intel.com with ESMTP; 24 Nov 2019 18:40:15 -0800
From: yadong.qi@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] intel_iommu: refine SL-PEs reserved fields checking
Date: Mon, 25 Nov 2019 08:33:20 +0800
Message-Id: <20191125003321.5669-2-yadong.qi@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125003321.5669-1-yadong.qi@intel.com>
References: <20191125003321.5669-1-yadong.qi@intel.com>
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
Cc: qi1.zhang@intel.com, ehabkost@redhat.com, mst@redhat.com, peterx@redhat.com,
 pbonzini@redhat.com, yadong.qi@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Qi, Yadong" <yadong.qi@intel.com>

1. split the resevred fields arrays into two ones,
2. large page only effect for L2(2M) and L3(1G), so
   remove checking of L1 and L4 for large page.

Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
Signed-off-by: Qi, Yadong <yadong.qi@intel.com>
---
 hw/i386/intel_iommu.c          | 37 ++++++++++++++++++----------------
 hw/i386/intel_iommu_internal.h |  5 +----
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 14e4e6ad62..feb9e55f87 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -910,19 +910,23 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
 
 /*
  * Rsvd field masks for spte:
- *     Index [1] to [4] 4k pages
- *     Index [5] to [8] large pages
+ *     vtd_spte_rsvd 4k pages
+ *     vtd_spte_rsvd_large large pages
  */
-static uint64_t vtd_paging_entry_rsvd_field[9];
+static uint64_t vtd_spte_rsvd[5];
+static uint64_t vtd_spte_rsvd_large[5];
 
 static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
 {
-    if (slpte & VTD_SL_PT_PAGE_SIZE_MASK) {
-        /* Maybe large page */
-        return slpte & vtd_paging_entry_rsvd_field[level + 4];
-    } else {
-        return slpte & vtd_paging_entry_rsvd_field[level];
+    uint64_t rsvd_mask = vtd_spte_rsvd[level];
+
+    if ((level == VTD_SL_PD_LEVEL || level == VTD_SL_PDP_LEVEL) &&
+        (slpte & VTD_SL_PT_PAGE_SIZE_MASK)) {
+        /* large page */
+        rsvd_mask = vtd_spte_rsvd_large[level];
     }
+
+    return slpte & rsvd_mask;
 }
 
 /* Find the VTD address space associated with a given bus number */
@@ -3549,15 +3553,14 @@ static void vtd_init(IntelIOMMUState *s)
     /*
      * Rsvd field masks for spte
      */
-    vtd_paging_entry_rsvd_field[0] = ~0ULL;
-    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[0] = ~0ULL;
+    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
+
+    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
 
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index c1235a7063..1654f746bc 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -395,14 +395,11 @@ typedef union VTDInvDesc VTDInvDesc;
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
         (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw) \
-        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+
 #define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
         (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
-        (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
-- 
2.17.1


