Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D94C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 11:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042B320720
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 11:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042B320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juaGm-0000Qi-8q
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 07:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jua2k-0005CY-PA
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 07:21:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:51220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jua2i-0004uR-OI
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 07:21:14 -0400
IronPort-SDR: juo7uKcbYwqYX/S7q7FT8TIt0MgphBYyTlSH2QyzMMY73sani4RqC4n4RLEHeiFAOeRq8n3syY
 R+vncMEr7ITA==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="148490206"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="148490206"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2020 04:19:56 -0700
IronPort-SDR: uTsXBBHeVketl5+9iAuEVtbB1yUlYyVt+grYOAidblNm2nazWt2lTKIxfsCYgtI5Uu1KQGgddm
 yehsf/7ZuCCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="307121492"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 04:19:55 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [RFC v8 25/25] intel_iommu: modify x-scalable-mode to be string option
Date: Sun, 12 Jul 2020 04:26:21 -0700
Message-Id: <1594553181-55810-26-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594553181-55810-1-git-send-email-yi.l.liu@intel.com>
References: <1594553181-55810-1-git-send-email-yi.l.liu@intel.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=yi.l.liu@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 07:19:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 hao.wu@intel.com, jasowang@redhat.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
related to scalable mode translation, thus there are multiple combinations.
While this vIOMMU implementation wants simplify it for user by providing
typical combinations. User could config it by "x-scalable-mode" option. The
usage is as below:

"-device intel-iommu,x-scalable-mode=["legacy"|"modern"|"off"]"

 - "legacy": gives support for SL page table
 - "modern": gives support for FL page table, pasid, virtual command
 - "off": no scalable mode support
 -  if not configured, means no scalable mode support, if not proper
    configured, will throw error

Note: this patch is supposed to be merged when the whole vSVA patch series
were merged.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
rfcv5 (v2) -> rfcv6:
*) reports want_nested to VFIO;
*) assert iommu_set/unset_iommu_context() if vIOMMU is not scalable modern.
---
 hw/i386/intel_iommu.c          | 39 +++++++++++++++++++++++++++++++++++----
 hw/i386/intel_iommu_internal.h |  3 +++
 include/hw/i386/intel_iommu.h  |  2 ++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2bbb4b1..d807484 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4050,7 +4050,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
-    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
+    DEFINE_PROP_STRING("x-scalable-mode", IntelIOMMUState, scalable_mode_str),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -4420,6 +4420,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
 static int vtd_dev_get_iommu_attr(PCIBus *bus, void *opaque, int32_t devfn,
                                    IOMMUAttr attr, void *data)
 {
+    IntelIOMMUState *s = opaque;
     int ret = 0;
 
     assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
@@ -4429,8 +4430,7 @@ static int vtd_dev_get_iommu_attr(PCIBus *bus, void *opaque, int32_t devfn,
     {
         bool *pdata = data;
 
-        /* return false until vSVA is ready */
-        *pdata = false;
+        *pdata = s->scalable_modern ? true : false;
         break;
     }
     default:
@@ -4526,6 +4526,8 @@ static int vtd_dev_set_iommu_context(PCIBus *bus, void *opaque,
     VTDHostIOMMUContext *vtd_dev_icx;
 
     assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+    /* only modern scalable supports set_ioimmu_context */
+    assert(s->scalable_modern);
 
     vtd_bus = vtd_find_add_bus(s, bus);
 
@@ -4560,6 +4562,8 @@ static void vtd_dev_unset_iommu_context(PCIBus *bus, void *opaque, int devfn)
     VTDHostIOMMUContext *vtd_dev_icx;
 
     assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+    /* only modern scalable supports unset_ioimmu_context */
+    assert(s->scalable_modern);
 
     vtd_bus = vtd_find_add_bus(s, bus);
 
@@ -4787,8 +4791,13 @@ static void vtd_init(IntelIOMMUState *s)
     }
 
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
-    if (s->scalable_mode) {
+    if (s->scalable_mode && !s->scalable_modern) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
+    } else if (s->scalable_mode && s->scalable_modern) {
+        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_PASID |
+                   VTD_ECAP_FLTS | VTD_ECAP_PSS(VTD_PASID_SS) |
+                   VTD_ECAP_VCS;
+        s->vccap |= VTD_VCCAP_PAS;
     }
 
     if (!s->cap_finalized) {
@@ -4929,6 +4938,28 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         return false;
     }
 
+    if (s->scalable_mode_str &&
+        (strcmp(s->scalable_mode_str, "off") &&
+         strcmp(s->scalable_mode_str, "modern") &&
+         strcmp(s->scalable_mode_str, "legacy"))) {
+        error_setg(errp, "Invalid x-scalable-mode config,"
+                         "Please use \"modern\", \"legacy\" or \"off\"");
+        return false;
+    }
+
+    if (s->scalable_mode_str &&
+        !strcmp(s->scalable_mode_str, "legacy")) {
+        s->scalable_mode = true;
+        s->scalable_modern = false;
+    } else if (s->scalable_mode_str &&
+        !strcmp(s->scalable_mode_str, "modern")) {
+        s->scalable_mode = true;
+        s->scalable_modern = true;
+    } else {
+        s->scalable_mode = false;
+        s->scalable_modern = false;
+    }
+
     return true;
 }
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 9b4fc67..afb4c6a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -197,7 +197,9 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_SMTS               (1ULL << 43)
+#define VTD_ECAP_VCS                (1ULL << 44)
 #define VTD_ECAP_SLTS               (1ULL << 46)
+#define VTD_ECAP_FLTS               (1ULL << 47)
 
 /* 1st level related caps */
 #define VTD_CAP_FL1GP               (1ULL << 56)
@@ -209,6 +211,7 @@
 #define VTD_ECAP_PSS(val)           (((val) & 0x1fULL) << 35)
 #define VTD_ECAP_PASID              (1ULL << 40)
 
+#define VTD_PASID_SS                (19)
 #define VTD_GET_PSS(val)            (((val) >> 35) & 0x1f)
 #define VTD_ECAP_PSS_MASK           (0x1fULL << 35)
 
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 1aab882..fd64364 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -263,6 +263,8 @@ struct IntelIOMMUState {
 
     bool caching_mode;              /* RO - is cap CM enabled? */
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
+    char *scalable_mode_str;        /* RO - admin's Scalable Mode config */
+    bool scalable_modern;           /* RO - is modern SM supported? */
 
     dma_addr_t root;                /* Current root table pointer */
     bool root_scalable;             /* Type of root table (scalable or not) */
-- 
2.7.4


