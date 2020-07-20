Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96C5C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795122070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="VVuBk5tF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795122070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUAO-0003Eh-Kh
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7O-0007Gc-Gs; Mon, 20 Jul 2020 07:38:02 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7K-00059S-Mc; Mon, 20 Jul 2020 07:38:01 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 99543BF84E;
 Mon, 20 Jul 2020 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595245077;
 bh=FQUG7SN5myaTmELU/Rt7LHax/XkYZh+TsiCbref9H6w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VVuBk5tFz7d7h5qWcbsl/Tldc2XYPhmMxfLoEbF6jMrNUjic7XytTy9LmY8wpZ2vC
 ZOj7tXw8ujVHHk2zEX97VMW7SGPyyPfnL+U3OVU/vge8cfg6alXvcA249VXF21+J2S
 XaPGhxbh4ZOs2WbEWIeAa6tviBqc5Ml/0wY5lx9bvdD2OcgxalsCohX4fwN2rupxBu
 dhAqm1tValJvplLRW8HhzASU2TLtC/t2OurWhsWshV9/xQdvpBP7faPNEAfScxfubU
 ILb7X6shja3e0XIMDgDc1+G84izLwrJN9R1l/QUzAjeKRouExm0GiRrxlQnrXckH3Z
 K8ESorwZLpwIw==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/16] hw/block/nvme: replace dma_acct with blk_acct equivalent
Date: Mon, 20 Jul 2020 13:37:35 +0200
Message-Id: <20200720113748.322965-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720113748.322965-1-its@irrelevant.dk>
References: <20200720113748.322965-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 07:37:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The QSG isn't always initialized, so accounting could be wrong. Issue a
call to blk_acct_start instead with the size taken from the QSG or IOV
depending on the kind of I/O.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9b1a080cdc70..cb236d1c8c46 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -620,9 +620,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
     if (req->qsg.nsg > 0) {
         req->has_sg = true;
+        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
+                         acct);
         req->aiocb = is_write ?
             dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
                           nvme_rw_cb, req) :
@@ -630,6 +631,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
                          nvme_rw_cb, req);
     } else {
         req->has_sg = false;
+        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->iov.size,
+                         acct);
         req->aiocb = is_write ?
             blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
                             req) :
-- 
2.27.0


