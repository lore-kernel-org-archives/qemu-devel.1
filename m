Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5138BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28904206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28904206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIm0P-00064D-8W
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 00:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jIlty-00021k-Pa
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jIltx-0008Jp-Cr
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:12574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jIltw-0007ph-Up
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:53 -0400
IronPort-SDR: tFqJTwRZ3Z8nGG+LOTYyafvpji8Cp0AKX9F+Oo1UBfeDj87wMtcYU5IuCG9sT+jZzAQ1R782WM
 SPfurmI0LuyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 21:19:16 -0700
IronPort-SDR: WKbxMxV4QFawnb6moNAw3onpaS6w65NuM+IE7/dlv7IdEQ8DoYLrrIw/9PFfwHlENgccAM65UK
 jNnkLEArH4mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,322,1580803200"; d="scan'208";a="327632062"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 29 Mar 2020 21:19:16 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [PATCH v2 17/22] intel_iommu: do not pass down pasid bind for PASID #0
Date: Sun, 29 Mar 2020 21:24:56 -0700
Message-Id: <1585542301-84087-18-git-send-email-yi.l.liu@intel.com>
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

RID_PASID field was introduced in VT-d 3.0 spec, it is used
for DMA requests w/o PASID in scalable mode VT-d. It is also
known as IOVA. And in VT-d 3.1 spec, there is definition on it:

"Implementations not supporting RID_PASID capability
(ECAP_REG.RPS is 0b), use a PASID value of 0 to perform
address translation for requests without PASID."

This patch adds a check against the PASIDs which are going to be
bound to device. For PASID #0, it is not necessary to pass down
pasid bind request for it since PASID #0 is used as RID_PASID for
DMA requests without pasid. Further reason is current Intel vIOMMU
supports gIOVA by shadowing guest 2nd level page table. However,
in future, if guest IOMMU driver uses 1st level page table to store
IOVA mappings, then guest IOVA support will also be done via nested
translation. When gIOVA is over FLPT, then vIOMMU should pass down
the pasid bind request for PASID #0 to host, host needs to bind the
guest IOVA page table to a proper PASID. e.g PASID value in RID_PASID
field for PF/VF if ECAP_REG.RPS is clear or default PASID for ADI
(Assignable Device Interface in Scalable IOV solution).

IOVA over FLPT support on Intel VT-d:
https://lkml.org/lkml/2019/9/23/297

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 883aeac..074d966 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1895,6 +1895,16 @@ static int vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
     struct iommu_gpasid_bind_data *g_bind_data;
     int ret = -1;
 
+    if (pasid < VTD_HPASID_MIN) {
+        /*
+         * If pasid < VTD_HPASID_MIN, this pasid is not allocated
+         * from host. No need to pass down the changes on it to host.
+         * TODO: when IOVA over FLPT is ready, this switch should be
+         * refined.
+         */
+        return 0;
+    }
+
     vtd_dev_icx = vtd_bus->dev_icx[devfn];
     if (!vtd_dev_icx) {
         /* means no need to go further, e.g. for emulated devices */
-- 
2.7.4


