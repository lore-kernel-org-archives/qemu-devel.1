Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2614EC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC66206CA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh4u1lv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC66206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNkH7-0001ih-Q9
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 18:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD5-0005Pk-Pt; Wed, 30 Sep 2020 18:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD3-0007vb-Rx; Wed, 30 Sep 2020 18:04:27 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C70222075F;
 Wed, 30 Sep 2020 22:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601503464;
 bh=6vOfCl0cPNOBq9BzvEp/FihBm827xY1zLVzTTbpSz8g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rh4u1lv8kPz86Y3Y2YZ9k9QfT36E/lJBHKLlrhvoHwTnGtkrh3s+lBuOIjI11smv4
 xv6bqMGpiTDW5PLGRVL/ef8hKn3flp7k+okOk6HLpQwUY3V78DlcXsSYhtrrgW0dsC
 AKOvooh1XQ4WGkHcsuKTvIDpT2/KKa/MQMYbbSfk=
From: Keith Busch <kbusch@kernel.org>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 4/9] hw/block/nvme: validate command set selected
Date: Wed, 30 Sep 2020 15:04:09 -0700
Message-Id: <20200930220414.562527-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930220414.562527-1-kbusch@kernel.org>
References: <20200930220414.562527-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 18:04:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fail to start the controller if the user requests a command set that the
controller does not support.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 6 +++++-
 hw/block/trace-events | 1 +
 include/block/nvme.h  | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 41389b2b09..6c582e6874 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2049,6 +2049,10 @@ static int nvme_start_ctrl(NvmeCtrl *n)
         trace_pci_nvme_err_startfail_acq_misaligned(n->bar.acq);
         return -1;
     }
+    if (unlikely(!(NVME_CAP_CSS(n->bar.cap) & (1 << NVME_CC_CSS(n->bar.cc))))) {
+        trace_pci_nvme_err_startfail_css(NVME_CC_CSS(n->bar.cc));
+        return -1;
+    }
     if (unlikely(NVME_CC_MPS(n->bar.cc) <
                  NVME_CAP_MPSMIN(n->bar.cap))) {
         trace_pci_nvme_err_startfail_page_too_small(
@@ -2750,7 +2754,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
     NVME_CAP_SET_CQR(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
-    NVME_CAP_SET_CSS(n->bar.cap, 1);
+    NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_NVM);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
 
     n->bar.vs = NVME_SPEC_VER;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 446cca08e9..7720e1b4d9 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -133,6 +133,7 @@ pci_nvme_err_startfail_cqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nvme_
 pci_nvme_err_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the completion queue entry size is too large: log2size=%u, max=%u"
 pci_nvme_err_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the submission queue entry size is too small: log2size=%u, min=%u"
 pci_nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nvme_start_ctrl failed because the submission queue entry size is too large: log2size=%u, max=%u"
+pci_nvme_err_startfail_css(uint8_t css) "nvme_start_ctrl failed because invalid command set selected:%u"
 pci_nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because the admin submission queue size is zero"
 pci_nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because the admin completion queue size is zero"
 pci_nvme_err_startfail(void) "setting controller enable bit failed"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 868cf53f0b..bc20a2ba5e 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -82,6 +82,10 @@ enum NvmeCapMask {
 #define NVME_CAP_SET_PMRS(cap, val) (cap |= (uint64_t)(val & CAP_PMR_MASK)\
                                                             << CAP_PMR_SHIFT)
 
+enum NvmeCapCss {
+    NVME_CAP_CSS_NVM = 1 << 0,
+};
+
 enum NvmeCcShift {
     CC_EN_SHIFT     = 0,
     CC_CSS_SHIFT    = 4,
-- 
2.24.1


