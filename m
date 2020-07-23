Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BBDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F55207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F55207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydkX-0000S2-2k
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 12:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jydfP-0003IP-Gh; Thu, 23 Jul 2020 12:01:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:36921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jydfN-0006j0-LG; Thu, 23 Jul 2020 12:01:55 -0400
IronPort-SDR: zvjIa4CamGcESwPgtKODoesRzLdbGKusv5jjRW4aG9SgF3nZdScyd4NCLBh6aZlj0pSnk31+Cm
 r3mN46CpOuAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="150543473"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; d="scan'208";a="150543473"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 09:01:52 -0700
IronPort-SDR: 1E0oNIEvKa2hmLJfGqtr12ZR8iwtskMF9A5Pxsd7ZseL5EhkCC/hVD1n55JPwNKKOmJBZ2cQMz
 j+Bq1duXEzKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; d="scan'208";a="319033209"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.61.79])
 by orsmga008.jf.intel.com with ESMTP; 23 Jul 2020 09:01:51 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v5 2/3] nvme: indicate CMB support through controller
 capabilities register
Date: Thu, 23 Jul 2020 09:03:24 -0700
Message-Id: <20200723160325.41734-3-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200723160325.41734-1-andrzej.jakowski@linux.intel.com>
References: <20200723160325.41734-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 12:01:45
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
Cc: qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Maxim Levitsky <mlevitsky@gmail.com>, pbonzini@redhat.com
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
2.21.1


