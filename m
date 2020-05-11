Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94387C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFD7206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFD7206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDxl-0005GB-Mq
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 15:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jYDvg-0001hK-4t
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:17:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:15020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jYDve-0001Yf-JA
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:17:31 -0400
IronPort-SDR: UmWxfTJi9+JGAbgCCKy8U7dRxwsFWcATeS0AsoduDY3PvJMZUq7HGE7S6H2LAArJdwgWTjB5Ru
 2DacLNDkdsYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 12:17:21 -0700
IronPort-SDR: gX6s2I+xvu25lTfrvc9VVp+S/yrqlBXmbMfI0HTgFWAq92SJ/DiAQ0/Syae+h9aifloYXAd5EY
 cJX/Yuy7wvyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; d="scan'208";a="463494242"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
 by fmsmga006.fm.intel.com with ESMTP; 11 May 2020 12:17:20 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Date: Mon, 11 May 2020 15:01:28 -0400
Message-Id: <20200511190129.9313-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200511190129.9313-1-jonathan.derrick@intel.com>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=jonathan.derrick@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 15:17:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 virtualization@lists.linux-foundation.org,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jon Derrick <jonathan.derrick@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Versions of VMD with the Host Physical Address shadow register use this
register to calculate the bus address offset needed to do guest
passthrough of the domain. This register shadows the Host Physical
Address registers including the resource type bits. After calculating
the offset, the extra resource type bits lead to the VMD resources being
over-provisioned at the front and under-provisioned at the back.

Example:
pci 10000:80:02.0: reg 0x10: [mem 0xf801fffc-0xf803fffb 64bit]

Expected:
pci 10000:80:02.0: reg 0x10: [mem 0xf8020000-0xf803ffff 64bit]

If other devices are mapped in the over-provisioned front, it could lead
to resource conflict issues with VMD or those devices.

Fixes: a1a30170138c9 ("PCI: vmd: Fix shadow offsets to reflect spec changes")
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index dac91d60701d..e386d4eac407 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -445,9 +445,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			if (!membar2)
 				return -ENOMEM;
 			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
-					readq(membar2 + MB2_SHADOW_OFFSET);
+					(readq(membar2 + MB2_SHADOW_OFFSET) &
+					 PCI_BASE_ADDRESS_MEM_MASK);
 			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
-					readq(membar2 + MB2_SHADOW_OFFSET + 8);
+					(readq(membar2 + MB2_SHADOW_OFFSET + 8) &
+					 PCI_BASE_ADDRESS_MEM_MASK);
 			pci_iounmap(vmd->dev, membar2);
 		}
 	}
-- 
2.18.1


