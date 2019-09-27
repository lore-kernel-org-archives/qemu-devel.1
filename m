Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2C1C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 05:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A834D21783
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 05:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A834D21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDiW6-0005ZV-L7
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 01:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qi1.zhang@intel.com>) id 1iDiUz-0004rd-Ua
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qi1.zhang@intel.com>) id 1iDiUx-0000vY-QO
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:08:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:34928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qi1.zhang@intel.com>) id 1iDiUx-0000pp-Ej
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 01:08:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 22:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,554,1559545200"; d="scan'208";a="391039130"
Received: from a23004-02.sh.intel.com ([10.239.9.19])
 by fmsmga006.fm.intel.com with ESMTP; 26 Sep 2019 22:08:47 -0700
From: qi1.zhang@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH V2] intel_iommu: TM field should not be in reserved bits
Date: Fri, 27 Sep 2019 12:58:38 +0800
Message-Id: <20190927045838.2968-1-qi1.zhang@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: qi1.zhang@intel.com, ehabkost@redhat.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Zhang, Qi" <qi1.zhang@intel.com>

When dt is supported, TM field should not be Reserved(0).

Refer to VT-d Spec 9.8

Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
Signed-off-by: Qi, Yadong <yadong.qi@intel.com>
---
 hw/i386/intel_iommu.c          | 12 ++++++------
 hw/i386/intel_iommu_internal.h | 25 +++++++++++++++++++------
 2 files changed, 25 insertions(+), 12 deletions(-)
---
Changelog V2:
 move dt_supported flag to VTD_SPTE_PAGE_LX_RSVD_MASK and VTD_SPTE_LPAGE_LX_RSVD_MASK

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f1de8fdb75..35222cf55c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3548,13 +3548,13 @@ static void vtd_init(IntelIOMMUState *s)
      * Rsvd field masks for spte
      */
     vtd_paging_entry_rsvd_field[0] = ~0ULL;
-    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
+    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
+    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
     vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
+    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
+    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits, x86_iommu->dt_supported);
     vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
 
     if (x86_iommu_ir_supported(x86_iommu)) {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index c1235a7063..01f1aa6c86 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -387,19 +387,31 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
 
 /* Rsvd field masks for spte */
-#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw) \
+#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
+        dt_supported? \
+        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
+#define VTD_SPTE_PAGE_L2_RSVD_MASK(aw, dt_supported) \
+        dt_supported? \
+        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_PAGE_L3_RSVD_MASK(aw) \
+#define VTD_SPTE_PAGE_L3_RSVD_MASK(aw, dt_supported) \
+        dt_supported? \
+        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
         (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw) \
+#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw, dt_supported) \
+        dt_supported? \
+        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
+#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
+        dt_supported? \
+        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
+#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
+        dt_supported? \
+        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
         (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
@@ -506,5 +518,6 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SL_W                    (1ULL << 1)
 #define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
 #define VTD_SL_IGN_COM              0xbff0000000000000ULL
+#define VTD_SL_TM                   (1ULL << 62)
 
 #endif
-- 
2.20.1


