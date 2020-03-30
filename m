Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26165C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2BB206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2BB206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIm1c-00082p-4E
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 00:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jIlty-00021s-Pe
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jIltx-0008Jv-ES
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:12564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jIltx-0007lr-4b
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:53 -0400
IronPort-SDR: Mi516NdkQhHDBX7i1JAjVz0ebkr5tE13UDCYGsXZJrvlLJR/SEYnVoYaDqYYixNrDSqQjxnm8P
 AIYHEfjkFLZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 21:19:16 -0700
IronPort-SDR: 5wXW8PikPRmt9jWZPfyttUQ97i4sEEdSI7WEtgLxvlTU7G1KfFdi5WO6+mATpk4doYtDzEhpTr
 QHi0rV4f+Zcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,322,1580803200"; d="scan'208";a="327632069"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 29 Mar 2020 21:19:16 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [PATCH v2 19/22] intel_iommu: process PASID-based iotlb invalidation
Date: Sun, 29 Mar 2020 21:24:58 -0700
Message-Id: <1585542301-84087-20-git-send-email-yi.l.liu@intel.com>
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
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 hao.wu@intel.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds the basic PASID-based iotlb (piotlb) invalidation
support. piotlb is used during walking Intel VT-d 1st level page
table. This patch only adds the basic processing. Detailed handling
will be added in next patch.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 53 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h | 13 +++++++++++
 2 files changed, 66 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 074d966..6114dd8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3045,6 +3045,55 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
     return true;
 }
 
+static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
+                                        uint16_t domain_id,
+                                        uint32_t pasid)
+{
+}
+
+static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
+                                       uint32_t pasid, hwaddr addr, uint8_t am,
+                                       bool ih)
+{
+}
+
+static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
+                                    VTDInvDesc *inv_desc)
+{
+    uint16_t domain_id;
+    uint32_t pasid;
+    uint8_t am;
+    hwaddr addr;
+
+    if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
+        (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1)) {
+        error_report_once("non-zero-field-in-piotlb_inv_desc hi: 0x%" PRIx64
+                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0]);
+        return false;
+    }
+
+    domain_id = VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
+    pasid = VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
+    switch (inv_desc->val[0] & VTD_INV_DESC_IOTLB_G) {
+    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
+        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
+        break;
+
+    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
+        am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
+        addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
+        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
+                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
+        break;
+
+    default:
+        error_report_once("Invalid granularity in P-IOTLB desc hi: 0x%" PRIx64
+                  " lo: 0x%" PRIx64, inv_desc->val[1], inv_desc->val[0]);
+        return false;
+    }
+    return true;
+}
+
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
@@ -3159,6 +3208,10 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         break;
 
     case VTD_INV_DESC_PIOTLB:
+        trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
+        if (!vtd_process_piotlb_desc(s, &inv_desc)) {
+            return false;
+        }
         break;
 
     case VTD_INV_DESC_WAIT:
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 9122601..5a49d5b 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -457,6 +457,19 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
 #define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)
 
+#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
+#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
+
+#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000ffc0ULL
+#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
+
+#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & \
+                                             VTD_DOMAIN_ID_MASK)
+#define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
+#define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
+#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
-- 
2.7.4


