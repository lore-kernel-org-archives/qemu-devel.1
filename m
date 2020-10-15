Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41421C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8211F2073A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8211F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT84P-0000GU-Da
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.widawsky@intel.com>)
 id 1kT7lg-0002DU-2W
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:14:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:40428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.widawsky@intel.com>)
 id 1kT7ld-0003MU-IB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:14:23 -0400
IronPort-SDR: M1ulG4zMgLiXxdNEkfQJEPHVhABvhpcrhfTBkdhgbhz7O5GsbZCh6/PmG596+d2cGN7vU4Xy4R
 nbOA5AVhndQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="183973980"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; d="scan'208";a="183973980"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 11:14:16 -0700
IronPort-SDR: YDoUAKVSg38kIpLA/QYF+nHR77PZcvD/Ht2QKCP4Jpo+ygBDCUjicNYbTGBHsf6MfpsZhXGYRJ
 ca5Hg+yAJKfg==
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; d="scan'208";a="300351581"
Received: from skzaman-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local)
 ([10.252.132.166])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 11:14:16 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] pci: Change error_report to assert(3)
Date: Thu, 15 Oct 2020 11:14:10 -0700
Message-Id: <20201015181411.89104-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=ben.widawsky@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 14:14:17
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ben Widawsky <ben.widawsky@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Asserts are used for developer bugs. As registering a bar of the wrong
size is not something that should be possible for a user to achieve,
this is a developer bug.

While here, use the more obvious helper function.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/pci/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 100c9381c2..2c7d6dd352 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1144,11 +1144,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
 
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
-    if (size & (size-1)) {
-        error_report("ERROR: PCI region size must be pow2 "
-                    "type=0x%x, size=0x%"FMT_PCIBUS"", type, size);
-        exit(1);
-    }
+    assert(is_power_of_2(size));
 
     r = &pci_dev->io_regions[region_num];
     r->addr = PCI_BAR_UNMAPPED;
-- 
2.28.0


