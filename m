Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2372A2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2372A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uAK-0004r4-F3
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1k0u8U-0003MB-1B; Wed, 29 Jul 2020 18:01:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:41645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1k0u8R-0007sQ-Rq; Wed, 29 Jul 2020 18:01:17 -0400
IronPort-SDR: MB5b+XRbQjzbICVQf/RfnTvVc4XrTneChKAdCy0YRaE1SmwUwSDj9wKuw/Gr9RTvtyUpyph4U0
 faIOP8bhk0Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="149342744"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; d="scan'208";a="149342744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 15:01:12 -0700
IronPort-SDR: XoXL8ddi1CVpHk3zW9KHX5qvPCBJsTTESVnDkd4nxAgE8JiYBJ8CheCUjFrSZ23fxrFF6ummwS
 fNLE8xvC4fCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; d="scan'208";a="304361602"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.209.191.249])
 by orsmga002.jf.intel.com with ESMTP; 29 Jul 2020 15:01:11 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v6 1/2] nvme: indicate CMB support through controller
 capabilities register
Date: Wed, 29 Jul 2020 15:01:06 -0700
Message-Id: <20200729220107.37758-2-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729220107.37758-1-andrzej.jakowski@linux.intel.com>
References: <20200729220107.37758-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.93;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 18:01:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Klaus Jensen <k.jensen@samsung.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Maxim Levitsky <mlevitsky@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch sets CMBS bit in controller capabilities register when user
configures NVMe driver with CMB support, so capabilites are correctly
reported to guest OS.

Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsky@gmail.com>
---
 hw/block/nvme.c      |  1 +
 include/block/nvme.h | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 841c18920c..43866b744f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2198,6 +2198,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
     NVME_CAP_SET_CSS(n->bar.cap, 1);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
+    NVME_CAP_SET_CMBS(n->bar.cap, n->params.cmb_size_mb ? 1 : 0);
 
     n->bar.vs = NVME_SPEC_VER;
     n->bar.intmc = n->bar.intms = 0;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 370df7fc05..d641ca6649 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -36,6 +36,7 @@ enum NvmeCapShift {
     CAP_MPSMIN_SHIFT   = 48,
     CAP_MPSMAX_SHIFT   = 52,
     CAP_PMR_SHIFT      = 56,
+    CAP_CMB_SHIFT      = 57,
 };
 
 enum NvmeCapMask {
@@ -49,6 +50,7 @@ enum NvmeCapMask {
     CAP_MPSMIN_MASK    = 0xf,
     CAP_MPSMAX_MASK    = 0xf,
     CAP_PMR_MASK       = 0x1,
+    CAP_CMB_MASK       = 0x1,
 };
 
 #define NVME_CAP_MQES(cap)  (((cap) >> CAP_MQES_SHIFT)   & CAP_MQES_MASK)
@@ -78,9 +80,11 @@ enum NvmeCapMask {
 #define NVME_CAP_SET_MPSMIN(cap, val) (cap |= (uint64_t)(val & CAP_MPSMIN_MASK)\
                                                            << CAP_MPSMIN_SHIFT)
 #define NVME_CAP_SET_MPSMAX(cap, val) (cap |= (uint64_t)(val & CAP_MPSMAX_MASK)\
-                                                            << CAP_MPSMAX_SHIFT)
-#define NVME_CAP_SET_PMRS(cap, val) (cap |= (uint64_t)(val & CAP_PMR_MASK)\
-                                                            << CAP_PMR_SHIFT)
+                                                           << CAP_MPSMAX_SHIFT)
+#define NVME_CAP_SET_PMRS(cap, val)   (cap |= (uint64_t)(val & CAP_PMR_MASK)   \
+                                                           << CAP_PMR_SHIFT)
+#define NVME_CAP_SET_CMBS(cap, val)   (cap |= (uint64_t)(val & CAP_CMB_MASK)   \
+                                                           << CAP_CMB_SHIFT)
 
 enum NvmeCcShift {
     CC_EN_SHIFT     = 0,
-- 
2.25.4


