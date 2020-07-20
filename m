Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3C7C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184622070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="Vze2og37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184622070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUH0-0005FU-9c
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7m-00085T-Gw; Mon, 20 Jul 2020 07:38:26 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7k-0005Br-AI; Mon, 20 Jul 2020 07:38:26 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 44AF6BF84E;
 Mon, 20 Jul 2020 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595245082;
 bh=dCGKH1NnyTyFTCLf6rhm40KuiTdjn+/POy9IhSQZWnY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vze2og370lnnueJJPkjTwD21LPyXTkJSP7fEW9qwabHUQhT2NjoRP2tNKovvt5jVK
 ZmgQCOxOitIFnXt6bfTlkywbX6ROsA/PqF08d985RPiOzfFFQyCj5AE7JibJfMEIw2
 Ycjn2nwTj55v+n3CljDe4cRcArj3dVNBf67xj7FwmSitcKwBUMuTJClvl5AwFEQlj6
 4ulPZXXdWrrQK7sNTaxGAksuVoI4VMrHZvD9TdZhtEjoXKt4HqXsBuJgnNusm5RzRb
 1k8maAH/tXBMM5QHBmwasdVmjoKzBus/iumBwRyEbqLVXUuhcdzqn9dooT6CPQTvod
 cX6hmrz/ZmW9w==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/16] hw/block/nvme: consolidate qsg/iov clearing
Date: Mon, 20 Jul 2020 13:37:46 +0200
Message-Id: <20200720113748.322965-15-its@irrelevant.dk>
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Always destroy the request qsg/iov at the end of request use.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 48 +++++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 54cd20f1ce22..b53afdeb3fb6 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -213,6 +213,14 @@ static void nvme_req_clear(NvmeRequest *req)
 {
     req->ns = NULL;
     memset(&req->cqe, 0x0, sizeof(req->cqe));
+
+    if (req->qsg.sg) {
+        qemu_sglist_destroy(&req->qsg);
+    }
+
+    if (req->iov.iov) {
+        qemu_iovec_destroy(&req->iov);
+    }
 }
 
 static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
@@ -297,15 +305,14 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
 
     status = nvme_map_addr(n, qsg, iov, prp1, trans_len);
     if (status) {
-        goto unmap;
+        return status;
     }
 
     len -= trans_len;
     if (len) {
         if (unlikely(!prp2)) {
             trace_pci_nvme_err_invalid_prp2_missing();
-            status = NVME_INVALID_FIELD | NVME_DNR;
-            goto unmap;
+            return NVME_INVALID_FIELD | NVME_DNR;
         }
 
         if (len > n->page_size) {
@@ -326,13 +333,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
                 if (i == n->max_prp_ents - 1 && len > n->page_size) {
                     if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
                         trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
-                        status = NVME_INVALID_FIELD | NVME_DNR;
-                        goto unmap;
+                        return NVME_INVALID_FIELD | NVME_DNR;
                     }
 
                     if (prp_list_in_cmb != nvme_addr_is_cmb(n, prp_ent)) {
-                        status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
-                        goto unmap;
+                        return NVME_INVALID_USE_OF_CMB | NVME_DNR;
                     }
 
                     i = 0;
@@ -345,14 +350,13 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
 
                 if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
                     trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
-                    status = NVME_INVALID_FIELD | NVME_DNR;
-                    goto unmap;
+                    return NVME_INVALID_FIELD | NVME_DNR;
                 }
 
                 trans_len = MIN(len, n->page_size);
                 status = nvme_map_addr(n, qsg, iov, prp_ent, trans_len);
                 if (status) {
-                    goto unmap;
+                    return status;
                 }
 
                 len -= trans_len;
@@ -361,27 +365,16 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
         } else {
             if (unlikely(prp2 & (n->page_size - 1))) {
                 trace_pci_nvme_err_invalid_prp2_align(prp2);
-                status = NVME_INVALID_FIELD | NVME_DNR;
-                goto unmap;
+                return NVME_INVALID_FIELD | NVME_DNR;
             }
             status = nvme_map_addr(n, qsg, iov, prp2, len);
             if (status) {
-                goto unmap;
+                return status;
             }
         }
     }
+
     return NVME_SUCCESS;
-
-unmap:
-    if (iov && iov->iov) {
-        qemu_iovec_destroy(iov);
-    }
-
-    if (qsg && qsg->sg) {
-        qemu_sglist_destroy(qsg);
-    }
-
-    return status;
 }
 
 static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
@@ -601,13 +594,6 @@ static void nvme_rw_cb(void *opaque, int ret)
         req->status = NVME_INTERNAL_DEV_ERROR;
     }
 
-    if (req->qsg.nalloc) {
-        qemu_sglist_destroy(&req->qsg);
-    }
-    if (req->iov.nalloc) {
-        qemu_iovec_destroy(&req->iov);
-    }
-
     nvme_enqueue_req_completion(cq, req);
 }
 
-- 
2.27.0


