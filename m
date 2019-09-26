Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C979ECE589
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637BC21655
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637BC21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWlJ-0003ML-R9
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qi1.zhang@intel.com>) id 1iDMoa-0002do-BI
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 01:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qi1.zhang@intel.com>) id 1iDMoX-0001d0-VL
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 01:59:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:6144)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qi1.zhang@intel.com>) id 1iDMoX-0001OC-NB
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 01:59:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 22:59:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,550,1559545200"; d="scan'208";a="189900932"
Received: from a23004-02.sh.intel.com ([10.239.9.19])
 by fmsmga007.fm.intel.com with ESMTP; 25 Sep 2019 22:59:31 -0700
From: qi1.zhang@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] intel_iommu: TM field should not be in reserved bits
Date: Thu, 26 Sep 2019 13:49:22 +0800
Message-Id: <20190926054922.21110-1-qi1.zhang@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
X-Mailman-Approved-At: Thu, 26 Sep 2019 12:31:53 -0400
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
 hw/i386/intel_iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f1de8fdb75..2696ceeb9d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3567,6 +3567,13 @@ static void vtd_init(IntelIOMMUState *s)
 
     if (x86_iommu->dt_supported) {
         s->ecap |= VTD_ECAP_DT;
+        vtd_paging_entry_rsvd_field[1] &= ~(1ULL << 62);
+        vtd_paging_entry_rsvd_field[2] &= ~(1ULL << 62);
+        vtd_paging_entry_rsvd_field[3] &= ~(1ULL << 62);
+
+        vtd_paging_entry_rsvd_field[5] &= ~(1ULL << 62);
+        vtd_paging_entry_rsvd_field[6] &= ~(1ULL << 62);
+        vtd_paging_entry_rsvd_field[7] &= ~(1ULL << 62);
     }
 
     if (x86_iommu->pt_supported) {
-- 
2.20.1


