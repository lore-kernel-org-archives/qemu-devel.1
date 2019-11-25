Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4130AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 02:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1090320718
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 02:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1090320718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ47t-0003a6-7y
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 21:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yadong.qi@intel.com>) id 1iZ47F-00038Z-QR
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 21:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yadong.qi@intel.com>) id 1iZ47E-0002CY-26
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 21:28:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:7097)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yadong.qi@intel.com>) id 1iZ47D-0002By-Qz
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 21:28:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Nov 2019 18:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; d="scan'208";a="216826002"
Received: from caas-nuc7i7dnhe.sh.intel.com ([10.239.158.159])
 by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2019 18:28:28 -0800
From: yadong.qi@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Refine Second-Level Paging Entries reserved fields
 checking
Date: Mon, 25 Nov 2019 08:21:32 +0800
Message-Id: <20191125002134.5390-1-yadong.qi@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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

The following patches are to refine/fix issues of reserved fields checking logic
of Second-Level Paging Entries of VT-d:
- split the resevred fields arrays into two ones,
- large page only effect for L2(2M) and L3(1G), so remove
  checking of L1 and L4 for large page,
- when dt is supported, TM filed should not be Reserved(0).

Changes in v3:
- large page only effect for L2(2M) and L3(1G), so remove
  checking of L1 and L4 for large page

Qi, Yadong (2):
  intel_iommu: refine SL-PEs reserved fields checking
  intel_iommu: TM field should not be in reserved bits

 hw/i386/intel_iommu.c          | 40 +++++++++++++++++++---------------
 hw/i386/intel_iommu_internal.h | 18 +++++++++------
 2 files changed, 34 insertions(+), 24 deletions(-)

-- 
2.17.1


