Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B210C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D22206CA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBQmWQSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D22206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNkIo-0003rv-Jt
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 18:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD7-0005Sn-3D; Wed, 30 Sep 2020 18:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD5-0007w4-DA; Wed, 30 Sep 2020 18:04:28 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 59CD220719;
 Wed, 30 Sep 2020 22:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601503465;
 bh=mMc68FIh8W0+zRlwRlchGGSCuLIK+a02janutn/ldHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZBQmWQSAVEWv70Se9onvBb/HWIVgnZuMkyv6trBgbTiYH3Bhg2RXgRY2yIIkFR/FH
 x9uphVeHE0T/iByOxt7hUVk4//qbjjCYiLwJ03wCbct6k9gyxuLrPaiDofYvKzlFaK
 09ECLceUxhgse/lJySymOhEMQcutgwmoPRP8/dMk=
From: Keith Busch <kbusch@kernel.org>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 6/9] hw/block/nvme: reject io commands if only admin command
 set selected
Date: Wed, 30 Sep 2020 15:04:11 -0700
Message-Id: <20200930220414.562527-7-kbusch@kernel.org>
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

From: Klaus Jensen <k.jensen@samsung.com>

If the host sets CC.CSS to 111b, all commands submitted to I/O queues
should be completed with status Invalid Command Opcode.

Note that this is technically a v1.4 feature, but it does not hurt to
implement before we finally bump the reported version implemented.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c      | 4 ++++
 include/block/nvme.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ec7363ea40..80730e1c03 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1026,6 +1026,10 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
                           req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
 
+    if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_ADMIN_ONLY) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
     if (!nvme_nsid_valid(n, nsid)) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 521533fd2a..6de2d5aa75 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -115,6 +115,11 @@ enum NvmeCcMask {
 #define NVME_CC_IOSQES(cc) ((cc >> CC_IOSQES_SHIFT) & CC_IOSQES_MASK)
 #define NVME_CC_IOCQES(cc) ((cc >> CC_IOCQES_SHIFT) & CC_IOCQES_MASK)
 
+enum NvmeCcCss {
+    NVME_CC_CSS_NVM        = 0x0,
+    NVME_CC_CSS_ADMIN_ONLY = 0x7,
+};
+
 enum NvmeCstsShift {
     CSTS_RDY_SHIFT      = 0,
     CSTS_CFS_SHIFT      = 1,
-- 
2.24.1


