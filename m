Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29559C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2C0206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="o6hGZQ8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2C0206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uEn-00005b-4G
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uDn-0006oL-87; Wed, 29 Jul 2020 18:06:47 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uDl-0008U6-7i; Wed, 29 Jul 2020 18:06:46 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 6750CBFAB3;
 Wed, 29 Jul 2020 22:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596060403;
 bh=s+3GwpffDUyM2zAU6NIPG+bARhXR6wqmuJDvWfqlYUk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o6hGZQ8rBTOF/4htVKvePeImiDgsRHzaSmRoPuGy5T1kTMkhjDjF+dcZxEj+9oMrF
 xIbsW+Zchpn97Z/eb98dhHPpNIX2JJityRsessqNwRfWtmtsSwGOuk04hQMN6hhkyc
 qFo+KQaZd/QV7BHUdZydQqEy2Vst8NGcObIZTV9++gSgzmT5glT9R7Reisz1XLGIjk
 p/NQKJjYgQpftTvWZRpqA9nqqma7IjembB7JeAhCuDLBA/d8Fey7czIKC6hwwlRxg0
 YsAkcS/B3OyEjIsQ28MKJjLjwmyREmyrGouHXGH6iQFwhuCu3zbX9bMR2a66ni5LUO
 2SdkfpHYnpdqg==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/16] hw/block/nvme: memset preallocated requests
 structures
Date: Thu, 30 Jul 2020 00:06:23 +0200
Message-Id: <20200729220638.344477-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729220638.344477-1-its@irrelevant.dk>
References: <20200729220638.344477-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 14:23:15
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This is preparatory to subsequent patches that change how QSGs/IOVs are
handled. It is important that the qsg and iov members of the NvmeRequest
are initially zeroed.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a1fd1fe14ba7..25b87486ea5a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -653,7 +653,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
     sq->size = size;
     sq->cqid = cqid;
     sq->head = sq->tail = 0;
-    sq->io_req = g_new(NvmeRequest, sq->size);
+    sq->io_req = g_new0(NvmeRequest, sq->size);
 
     QTAILQ_INIT(&sq->req_list);
     QTAILQ_INIT(&sq->out_req_list);
-- 
2.27.0


