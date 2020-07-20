Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFDCC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251992070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="GJUqqUjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251992070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUJU-0008Aj-Bw
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7n-000875-8e; Mon, 20 Jul 2020 07:38:27 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7l-0005CE-ET; Mon, 20 Jul 2020 07:38:26 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 496D7BFB31;
 Mon, 20 Jul 2020 11:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595245083;
 bh=wHaa8HyTfJxh0YQo3rTdxLUJaJBvexX6EfS6uOQItgw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GJUqqUjztaDMw8tZK7sq4mRQiwQodMhrHixD2p4udzsUSpzzW0ep691OwW55czvft
 B5KhyTW+ynVoBwk6aFei+fjlVmbEgUY+3aRvmkwuwVBFqjE/OQR3aJp4YB7gKGf6pA
 uRE4n2Lbzx68YKxBqK/1L2l4mlSN5pzfgRJUue1mbrL6aaRRu+jAqR2fyjp3iyx4zT
 gERoa/THa+8dm4P606v9jQYwr8DHNwkW0Em53/NeShXaGVuqvj6Ad1A3xXwM/w1/SN
 w9bEAdM0GuK6YRqf6zQINYSXXngiUG/TC24Mo2YrlOHDn6jt/QhjmLPQIlF3frt+Ui
 Xg9eatrw2NPbQ==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/16] hw/block/nvme: use preallocated qsg/iov in nvme_dma_prp
Date: Mon, 20 Jul 2020 13:37:48 +0200
Message-Id: <20200720113748.322965-17-its@irrelevant.dk>
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

Since clean up of the request qsg/iov is now always done post-use, there
is no need to use a stack-allocated qsg/iov in nvme_dma_prp.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0b3dceccc89b..b6da5a9f3fc6 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -381,45 +381,39 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
                              uint64_t prp1, uint64_t prp2, DMADirection dir,
                              NvmeRequest *req)
 {
-    QEMUSGList qsg;
-    QEMUIOVector iov;
     uint16_t status = NVME_SUCCESS;
 
-    status = nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
+    status = nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
     if (status) {
         return status;
     }
 
-    if (qsg.nsg > 0) {
+    if (req->qsg.nsg > 0) {
         uint64_t residual;
 
         if (dir == DMA_DIRECTION_TO_DEVICE) {
-            residual = dma_buf_write(ptr, len, &qsg);
+            residual = dma_buf_write(ptr, len, &req->qsg);
         } else {
-            residual = dma_buf_read(ptr, len, &qsg);
+            residual = dma_buf_read(ptr, len, &req->qsg);
         }
 
         if (unlikely(residual)) {
             trace_pci_nvme_err_invalid_dma();
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
-
-        qemu_sglist_destroy(&qsg);
     } else {
         size_t bytes;
 
         if (dir == DMA_DIRECTION_TO_DEVICE) {
-            bytes = qemu_iovec_to_buf(&iov, 0, ptr, len);
+            bytes = qemu_iovec_to_buf(&req->iov, 0, ptr, len);
         } else {
-            bytes = qemu_iovec_from_buf(&iov, 0, ptr, len);
+            bytes = qemu_iovec_from_buf(&req->iov, 0, ptr, len);
         }
 
         if (unlikely(bytes != len)) {
             trace_pci_nvme_err_invalid_dma();
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
-
-        qemu_iovec_destroy(&iov);
     }
 
     return status;
-- 
2.27.0


