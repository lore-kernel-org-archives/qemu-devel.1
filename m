Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE934C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98EED20656
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="WUlsjtqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EED20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uNG-0006sY-I9
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uEF-0007ol-Rn; Wed, 29 Jul 2020 18:07:15 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uEB-00006G-MO; Wed, 29 Jul 2020 18:07:15 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 73A1CBFD9F;
 Wed, 29 Jul 2020 22:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596060409;
 bh=0aZGxNIy2sKIVXnWhFQQC8kNTLa7eTsFuV5UrjAGizc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WUlsjtqNVN3TKfe7Is3Z30/6WKm6nvQDEthXxywq2RCEMsOCP3iW8KuJ69JVAn4It
 B9bPg4BHhlxwrxcHUIdK1MrWgmGFNVd2EXb9Im7QMdfEPOTihrxF2VKO2H9i0JCBhC
 I/1UCZRaaTdBZUFoY/z6lO7mvV0MDhUPi3+YarssKWNVW2WSd0N09B/nyGp0mq4fSX
 VZ3LHURuLWyhPrTqoXobBrAeLU54elzDlhwIDRPYrgq8HSuoVlPZhFBVvd9Rj83Djk
 lEn0mFMduEnGePJB32zgtKRIZUhDrdJShCEc2L8ablw8p75oczLGJTzXaI3ZV0akA8
 rO5/HYbdt66Aw==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/16] hw/block/nvme: remove explicit qsg/iov parameters
Date: Thu, 30 Jul 2020 00:06:38 +0200
Message-Id: <20200729220638.344477-17-its@irrelevant.dk>
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

Since nvme_map_prp always operate on the request-scoped qsg/iovs, just
pass a single pointer to the NvmeRequest instead of two for each of the
qsg and iov.

Suggested-by: Minwoo Im <minwoo.im.dev@gmail.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 55b1a68ced8c..aea8a8b6946c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -284,8 +284,8 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
-                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
+static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
+                             uint32_t len, NvmeRequest *req)
 {
     hwaddr trans_len = n->page_size - (prp1 % n->page_size);
     trans_len = MIN(len, trans_len);
@@ -293,6 +293,9 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
     uint16_t status;
     bool prp_list_in_cmb = false;
 
+    QEMUSGList *qsg = &req->qsg;
+    QEMUIOVector *iov = &req->iov;
+
     trace_pci_nvme_map_prp(trans_len, len, prp1, prp2, num_prps);
 
     if (unlikely(!prp1)) {
@@ -386,7 +389,7 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
 {
     uint16_t status = NVME_SUCCESS;
 
-    status = nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, len, n);
+    status = nvme_map_prp(n, prp1, prp2, len, req);
     if (status) {
         return status;
     }
@@ -431,7 +434,7 @@ static uint16_t nvme_map_dptr(NvmeCtrl *n, size_t len, NvmeRequest *req)
     uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
 
-    return nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, len, n);
+    return nvme_map_prp(n, prp1, prp2, len, req);
 }
 
 static void nvme_post_cqes(void *opaque)
-- 
2.27.0


