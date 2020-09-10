Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CD7C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6BF20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6BF20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKHO-0000IN-Ol
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1kGKEM-0003ie-By
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:55:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:26688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1kGKEF-0005xR-SR
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:55:06 -0400
IronPort-SDR: ep27lK+LMxZHLeAD43n1AgUKm84jaSLRRB1saCcTgm1sC2ZNuUAZmtXOuQlrlG86YryNc5YX/v
 aPt8op4xx13A==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="158545472"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="158545472"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 03:54:39 -0700
IronPort-SDR: nTr8SY+TBtvMGena53AUFdNG0zf9aEK9bGAazQR6E3pFlsJoe0FkLKjjDELdDH/mvMzbTsftZP
 +mBXEeDcGURA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="334140047"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 03:54:39 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com,
 jasowang@redhat.com
Subject: [RFC v10 05/25] intel_iommu: add get_iommu_attr() callback
Date: Thu, 10 Sep 2020 03:56:18 -0700
Message-Id: <1599735398-6829-6-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599735398-6829-1-git-send-email-yi.l.liu@intel.com>
References: <1599735398-6829-1-git-send-email-yi.l.liu@intel.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=yi.l.liu@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 06:54:39
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
 hao.wu@intel.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Return vIOMMU attribute to caller. e.g. VFIO call via PCI layer.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bf13d59..333f172 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3440,6 +3440,28 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
     return vtd_dev_as;
 }
 
+static int vtd_dev_get_iommu_attr(PCIBus *bus, void *opaque, int32_t devfn,
+                                   IOMMUAttr attr, void *data)
+{
+    int ret = 0;
+
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+
+    switch (attr) {
+    case IOMMU_WANT_NESTING:
+    {
+        bool *pdata = data;
+
+        /* return false until vSVA is ready */
+        *pdata = false;
+        break;
+    }
+    default:
+        ret = -ENOENT;
+    }
+    return ret;
+}
+
 static uint64_t get_naturally_aligned_size(uint64_t start,
                                            uint64_t size, int gaw)
 {
@@ -3735,6 +3757,7 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
+    .get_iommu_attr = vtd_dev_get_iommu_attr,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
2.7.4


