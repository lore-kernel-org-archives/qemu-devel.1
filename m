Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37961C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E95B21582
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E95B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7zC-0003SW-Ja
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.widawsky@intel.com>)
 id 1kT7lm-0002Jw-SP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:14:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:40428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.widawsky@intel.com>)
 id 1kT7lg-0003MU-CD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:14:29 -0400
IronPort-SDR: mWKAJIUFK4bU1gtVibTAEeH2ldOJf3j5Nus20eUbCd9nF/6ZhJDvdB7hBBJLXbs30iybOAoTi/
 A+FGoLsaY27A==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="183973981"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; d="scan'208";a="183973981"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 11:14:17 -0700
IronPort-SDR: lON+zjDK8JPfKrghzIU6Eit2RNmzNWo4QxC1wgG1p0i69aiS7wExMdq2RKQRR53ng88hVbBJ1Y
 pUW8RgTuiNRA==
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; d="scan'208";a="300351665"
Received: from skzaman-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local)
 ([10.252.132.166])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 11:14:16 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] pci: Disallow improper BAR registration for type 1
Date: Thu, 15 Oct 2020 11:14:11 -0700
Message-Id: <20201015181411.89104-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015181411.89104-1-ben.widawsky@intel.com>
References: <20201015181411.89104-1-ben.widawsky@intel.com>
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

Prevent future developers working on root complexes, root ports, or
bridges that also wish to implement a BAR for those, from shooting
themselves in the foot. PCI type 1 headers only support 2 base address
registers. It is incorrect and difficult to figure out what is wrong
with the device when this mistake is made. With this, it is immediate
and obvious what has gone wrong.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2c7d6dd352..14fce10132 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1141,11 +1141,17 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     uint32_t addr; /* offset in pci config space */
     uint64_t wmask;
     pcibus_t size = memory_region_size(memory);
+    uint8_t hdr_type;
 
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
     assert(is_power_of_2(size));
 
+    /* A PCI bridge device (with Type 1 header) may only have at most 2 BARs */
+    hdr_type =
+        pci_dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_FUNCTION;
+    assert(hdr_type != PCI_HEADER_TYPE_BRIDGE || region_num < 2);
+
     r = &pci_dev->io_regions[region_num];
     r->addr = PCI_BAR_UNMAPPED;
     r->size = size;
-- 
2.28.0


