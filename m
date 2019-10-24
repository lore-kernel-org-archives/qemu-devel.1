Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B576FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696B721925
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696B721925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNe7t-0007sN-Nt
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckJ-0005Gy-MU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckE-0002Oi-Eu
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:40489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iNckD-0002NX-W9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="210156167"
Received: from iov.bj.intel.com ([10.238.145.67])
 by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 06:01:15 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v2 03/22] intel_iommu: modify x-scalable-mode to be string option
Date: Thu, 24 Oct 2019 08:34:24 -0400
Message-Id: <1571920483-3382-4-git-send-email-yi.l.liu@intel.com>
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

Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
related to scalable mode translation, thus there are multiple combinations.
While this vIOMMU implementation wants simplify it for user by providing
typical combinations. User could config it by "x-scalable-mode" option. The
usage is as below:

"-device intel-iommu,x-scalable-mode=["legacy"|"modern"]"

 - "legacy": gives support for SL page table
 - "modern": gives support for FL page table, pasid, virtual command
 -  if not configured, means no scalable mode support, if not proper
    configured, will throw error

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 hw/i386/intel_iommu.c          | 15 +++++++++++++--
 hw/i386/intel_iommu_internal.h |  3 +++
 include/hw/i386/intel_iommu.h  |  2 +-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 771bed2..4a1a07a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3019,7 +3019,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
-    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
+    DEFINE_PROP_STRING("x-scalable-mode", IntelIOMMUState, scalable_mode),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -3581,7 +3581,12 @@ static void vtd_init(IntelIOMMUState *s)
 
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
     if (s->scalable_mode) {
-        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
+        if (!strcmp(s->scalable_mode, "legacy")) {
+            s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
+        } else if (!strcmp(s->scalable_mode, "modern")) {
+            s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_PASID
+                       | VTD_ECAP_FLTS | VTD_ECAP_PSS;
+        }
     }
 
     vtd_reset_caches(s);
@@ -3700,6 +3705,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         return false;
     }
 
+    if (s->scalable_mode &&
+        (strcmp(s->scalable_mode, "modern") &&
+         strcmp(s->scalable_mode, "legacy"))) {
+            error_setg(errp, "Invalid x-scalable-mode config");
+    }
+
     return true;
 }
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index c1235a7..be7b30a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -190,8 +190,11 @@
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_PSS                (19ULL << 35)
+#define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
+#define VTD_ECAP_FLTS               (1ULL << 47)
 
 /* CAP_REG */
 /* (offset >> 4) << 24 */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 66b931e..6062588 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -231,7 +231,7 @@ struct IntelIOMMUState {
     uint32_t version;
 
     bool caching_mode;              /* RO - is cap CM enabled? */
-    bool scalable_mode;             /* RO - is Scalable Mode supported? */
+    char *scalable_mode;            /* RO - Scalable Mode model */
 
     dma_addr_t root;                /* Current root table pointer */
     bool root_scalable;             /* Type of root table (scalable or not) */
-- 
2.7.4


