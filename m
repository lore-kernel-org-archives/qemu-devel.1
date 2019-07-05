Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39747C0650E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110C220989
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110C220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjilm-0004u1-8S
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 07:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52351)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hjiie-0002pC-Ej
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hjiid-0005rA-9H
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:2961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hjiid-0005e0-0i
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jul 2019 04:19:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,458,1557212400"; d="scan'208";a="363354982"
Received: from yiliu-dev.bj.intel.com ([10.238.156.139])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2019 04:18:59 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Date: Fri,  5 Jul 2019 19:01:37 +0800
Message-Id: <1562324511-2910-5-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [RFC v1 04/18] intel_iommu: add "sm_model" option
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
 eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Intel VT-d 3.0 introduces scalable mode, and it has a bunch of
capabilities related to scalable mode translation, thus there
are multiple combinations. While this vIOMMU implementation
wants simplify it for user by providing typical combinations.
User could config it by "sm_model" option. The usage is as
below:

"-device intel-iommu,x-scalable-mode=on,sm_model=["legacy"|"scalable"]"

 - "legacy": gives support for SL page table
 - "scalable": gives support for FL page table, pasid, virtual command
 - default to be "legacy" if "x-scalable-mode=on while no sm_model is
   configured

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 hw/i386/intel_iommu.c          | 28 +++++++++++++++++++++++++++-
 hw/i386/intel_iommu_internal.h |  2 ++
 include/hw/i386/intel_iommu.h  |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 44b1231..3160a05 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3014,6 +3014,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
+    DEFINE_PROP_STRING("sm_model", IntelIOMMUState, sm_model),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -3489,6 +3490,14 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     return;
 }
 
+const char sm_model_manual[] =
+        "\"-device intel-iommu,x-scalable-mode=on,"
+        "sm_model=[\"legacy\"|\"scalable\"]\"\n"
+        " - \"legacy\" gives support for SL page table based IOVA\n"
+        " - \"scalable\" gives support for FL page table based IOVA and SVA\n"
+        " - default to be \"legacy\" if \"x-scalable-mode=on\""
+        " while no sm_model is configured\n";
+
 /* Do the initialization. It will also be called when reset, so pay
  * attention when adding new initialization stuff.
  */
@@ -3557,9 +3566,26 @@ static void vtd_init(IntelIOMMUState *s)
         s->cap |= VTD_CAP_CM;
     }
 
+    if (s->sm_model && !s->scalable_mode) {
+        printf("\n\"sm_model\" depends on \"x-scalable-mode\"\n"
+               "please check if \"x-scalable-mode\" is expected\n"
+               "\"sm_model\" manual:\n%s", sm_model_manual);
+        exit(1);
+    }
+
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
     if (s->scalable_mode) {
-        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
+        if (!s->sm_model || !strcmp(s->sm_model, "legacy")) {
+            s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
+        } else if (!strcmp(s->sm_model, "scalable")) {
+            s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_PASID
+                       | VTD_ECAP_FLTS;
+        } else {
+            printf("\n!!!!! Invalid sm_model config !!!!!\n"
+                "Please config sm_model=[\"legacy\"|\"scalable\"]\n"
+                "\"sm_model\" manual:\n%s", sm_model_manual);
+            exit(1);
+        }
     }
 
     vtd_reset_caches(s);
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index c1235a7..adae198 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -190,8 +190,10 @@
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
+#define VTD_ECAP_FLTS               (1ULL << 47)
 
 /* CAP_REG */
 /* (offset >> 4) << 24 */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 12f3d26..b51cc9f 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -270,6 +270,7 @@ struct IntelIOMMUState {
     bool buggy_eim;                 /* Force buggy EIM unless eim=off */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
+    char *sm_model;          /* identify actual scalable mode iommu model*/
 
     /*
      * Protects IOMMU states in general.  Currently it protects the
-- 
2.7.4


