Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B096C47E49
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224C42166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224C42166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdot-0001CK-Ko
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckx-00065y-F8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iNcks-00031d-4Q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:40489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iNckr-0002NX-7m
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="210156326"
Received: from iov.bj.intel.com ([10.238.145.67])
 by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 06:02:01 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v2 18/22] intel_iommu: do not passdown pasid bind for PASID #0
Date: Thu, 24 Oct 2019 08:34:39 -0400
Message-Id: <1571920483-3382-19-git-send-email-yi.l.liu@intel.com>
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

RID_PASID field was introduced in VT-d 3.0 spec, it is used for DMA
requests w/o PASID in scalable mode VT-d. It is also known as IOVA.
And in VT-d 3.1 spec, there is further definition on it:

"Implementations not supporting RID_PASID capability (ECAP_REG.RPS is
0b), use a PASID value of 0 to perform address translation for requests
without PASID."

This patch adds a check on the PASIDs which are going to be bound to
device. For PASID #0, no need to passdown pasid binding since PASID #0
is used as RID_PASID for requests without pasid. Reason is current Intel
vIOMMU supports guest IOVA by shadowing guest 2nd level page table.
However, in future, if guest OS uses 1st level page table to store IOVA
mappings, thus guest IOVA support will also be done via nested translation.
Then vIOMMU could passdown the pasid binding for PASID #0 to host with a
special PASID value to indicate host to bind the guest page table to a
proper PASID. e.g PASID value from RID_PASID field for PF/VF if ECAP_REG.RPS
is clear or default PASID for ADI (Assignable Device Interface in Scalable
IOV solution).

IOVA over FLPT support on Intel VT-d: https://lkml.org/lkml/2019/9/23/297

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6bceb7f..d621455 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1880,6 +1880,16 @@ static void vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
     IOMMUCTXPASIDBindData bind;
     struct iommu_gpasid_bind_data *g_bind_data;
 
+    if (pasid < VTD_MIN_HPASID) {
+        /*
+         * If pasid < VTD_HPASID_MIN, this pasid is not allocated
+         * from host. No need to passdown the changes on it to host.
+         * TODO: when IOVA over FLPT is ready, this switch should be
+         * refined.
+         */
+        return;
+    }
+
     vtd_ic = vtd_bus->dev_ic[devfn];
     if (!vtd_ic) {
         return;
-- 
2.7.4


