Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A78FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074E4206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="BhQs9Q08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074E4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECcY-0007sm-1D
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECa0-0002Qx-6g; Fri, 04 Sep 2020 10:20:40 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECZv-0002hN-86; Fri, 04 Sep 2020 10:20:39 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 2F328BF95B;
 Fri,  4 Sep 2020 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599229232;
 bh=7LsDBtn4b9Dn/cGffRm+IPwOtbb/qoXc9QWIQ/78zlg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BhQs9Q089dWrMRmPKGkWAT+D5mvKJuGmcUAU6nX6VoFHw+ejIJyo+PX3d5vEgctoL
 /KI9oO2RvYOag4HioNikMiWvK13Gp7Aqa6+09H4JB4UkOBltyv8dE2NCfH343SlK2i
 b2MaavvWFb1vMF63MRDCeGJtpeW6kX2OjsA1CKzYVdMKHdjOaspnaMeTOmmSR/XRdE
 /AQRfquA6JrkSTYeNIZxW9mD2sGY9bdvRgs5K49g8AROGuToul+rMwYB4635fKUZNR
 FiICVMKLrNcdnxpx52U0JnD8ftRok3eADwR0zpPzKk9/pzeP+fXH2fqxjDYiBLLm1u
 7Qu+352xHXl7w==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/17] hw/block/nvme: commonize nvme_rw error handling
Date: Fri,  4 Sep 2020 16:19:42 +0200
Message-Id: <20200904141956.576630-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904141956.576630-1-its@irrelevant.dk>
References: <20200904141956.576630-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Move common error handling to a label.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 49bcdf31ced6..a94e648a80e4 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -687,20 +687,18 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     status = nvme_check_mdts(n, data_size);
     if (status) {
         trace_pci_nvme_err_mdts(nvme_cid(req), data_size);
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return status;
+        goto invalid;
     }
 
     status = nvme_check_bounds(n, ns, slba, nlb);
     if (status) {
         trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return status;
+        goto invalid;
     }
 
-    if (nvme_map_dptr(n, data_size, req)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return NVME_INVALID_FIELD | NVME_DNR;
+    status = nvme_map_dptr(n, data_size, req);
+    if (status) {
+        goto invalid;
     }
 
     if (req->qsg.nsg > 0) {
@@ -722,6 +720,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     }
 
     return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+    return status;
 }
 
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
-- 
2.28.0


