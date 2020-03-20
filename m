Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536F9C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1AE20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfQmQ71l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1AE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFIkE-0002BK-5A
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jFIjP-0001Ct-7O
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jFIjN-00070q-TC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:34:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jFIjN-00070I-N8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:34:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id a25so7785135wrd.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=izsjuPvFCwqcf0hTr6C/OKdh9vNSdRz4RAKvPm3nOGE=;
 b=KfQmQ71l30aZ4zg3BAqD/caXcDUdUBhIF/TJn/lyLqnLKzY1NlvUgBC5xADOOxB5jw
 JMJo8gCXGcfWV7lewyMEp6oN5/6uUEGuJ02FAnXnOmOtC3wqtmGzJD16AbypGYnuJHTw
 zo8tczWUg8cRJtnzXTfWve1wNpAI1mV5OjJbB0Kfg+a0BbizB2GjcGMAWAMDn+1TNseo
 W+z0cwO+XavOniXkM7gXSZA4u52m8uwBpYqQSR66KpCZJmbjWweyer50GQ5M3jcF84KD
 IqH8veQS8xAfo8fPKi180k/Cxhopz249FgVS5CYGHpe3nwGY8aaJm/v3OngEo5Fp6NVU
 rmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=izsjuPvFCwqcf0hTr6C/OKdh9vNSdRz4RAKvPm3nOGE=;
 b=i7hncAM1Ja2DbG9gPNdr4DPNpJPQKirAoCvwZK/JKXaAzwQtNjm6JNwMpylEU5x1J9
 Gz9ZY7pl3mHyCCCzEhLHMxXgu98Ghl/drCzQgI2hybnEjbp/P3KWZ8tRakr852pYVw4u
 P8dpFYbaGQlObR+ovIEr1+aAPRSWflF5qvCdTNphKvACTgogdnWPxm1U8pPMw7lTUsTN
 CKZ7rb4N7a+0eCsAQc7vWsUK2B0+A11LgSiMEMPctH22/T0ge17fStVP00SE4++EZGhy
 R5NgXuadHAu/4BHwFt2J3ys3S1yj9aRCa1iSQMOUck0vFZHog7QrdmfAIPUQqZrsF49C
 Su/g==
X-Gm-Message-State: ANhLgQ38Pqidxic59Epjp2gnQBhbIDzveQOXDNn7SqSknG4Ne96kmkN6
 Ji7WlzDZmLygb0lToQNsNXz5ddYr
X-Google-Smtp-Source: ADFU+vuPU8r/qtKrkH+N0wHWkeYPxn5QKsKjyD3I0Tfc27KRAmHmBDsZPNVWuIHPDjLs7o6Njn7NEg==
X-Received: by 2002:a5d:644c:: with SMTP id d12mr11690041wrw.54.1584714875717; 
 Fri, 20 Mar 2020 07:34:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a040:186:a1ad:5254:ff:fe84:1be0])
 by smtp.gmail.com with ESMTPSA id
 s22sm7336694wmc.16.2020.03.20.07.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 07:34:35 -0700 (PDT)
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
To: qemu-devel@nongnu.org, yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com
Subject: [PATCH v1 1/2] hw/rdma: Cosmetic change - no need for two sge arrays
Date: Fri, 20 Mar 2020 16:34:28 +0200
Message-Id: <20200320143429.9490-2-yuval.shaia.ml@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320143429.9490-1-yuval.shaia.ml@gmail.com>
References: <20200320143429.9490-1-yuval.shaia.ml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function build_host_sge_array uses two sge arrays, one for input and
one for output.
Since the size of the two arrays is the same, the function can write
directly to the given source array (i.e. input/output argument).

Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
---
 hw/rdma/rdma_backend.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index c346407cd3..b7ffbef9c0 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -378,30 +378,25 @@ static void ah_cache_init(void)
 }
 
 static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
-                                struct ibv_sge *dsge, struct ibv_sge *ssge,
-                                uint8_t num_sge, uint64_t *total_length)
+                                struct ibv_sge *sge, uint8_t num_sge,
+                                uint64_t *total_length)
 {
     RdmaRmMR *mr;
-    int ssge_idx;
+    int idx;
 
-    for (ssge_idx = 0; ssge_idx < num_sge; ssge_idx++) {
-        mr = rdma_rm_get_mr(rdma_dev_res, ssge[ssge_idx].lkey);
+    for (idx = 0; idx < num_sge; idx++) {
+        mr = rdma_rm_get_mr(rdma_dev_res, sge[idx].lkey);
         if (unlikely(!mr)) {
-            rdma_error_report("Invalid lkey 0x%x", ssge[ssge_idx].lkey);
-            return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
+            rdma_error_report("Invalid lkey 0x%x", sge[idx].lkey);
+            return VENDOR_ERR_INVLKEY | sge[idx].lkey;
         }
 
 #ifdef LEGACY_RDMA_REG_MR
-        dsge->addr = (uintptr_t)mr->virt + ssge[ssge_idx].addr - mr->start;
-#else
-        dsge->addr = ssge[ssge_idx].addr;
+        sge[idx].addr = (uintptr_t)mr->virt + sge[idx].addr - mr->start;
 #endif
-        dsge->length = ssge[ssge_idx].length;
-        dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
-
-        *total_length += dsge->length;
+        sge[idx].lkey = rdma_backend_mr_lkey(&mr->backend_mr);
 
-        dsge++;
+        *total_length += sge[idx].length;
     }
 
     return 0;
@@ -484,7 +479,6 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
                             void *ctx)
 {
     BackendCtx *bctx;
-    struct ibv_sge new_sge[MAX_SGE];
     uint32_t bctx_id;
     int rc;
     struct ibv_send_wr wr = {}, *bad_wr;
@@ -518,7 +512,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
 
     rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
 
-    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.tx_len);
     if (rc) {
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
@@ -538,7 +532,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     wr.num_sge = num_sge;
     wr.opcode = IBV_WR_SEND;
     wr.send_flags = IBV_SEND_SIGNALED;
-    wr.sg_list = new_sge;
+    wr.sg_list = sge;
     wr.wr_id = bctx_id;
 
     rc = ibv_post_send(qp->ibqp, &wr, &bad_wr);
@@ -601,7 +595,6 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
                             struct ibv_sge *sge, uint32_t num_sge, void *ctx)
 {
     BackendCtx *bctx;
-    struct ibv_sge new_sge[MAX_SGE];
     uint32_t bctx_id;
     int rc;
     struct ibv_recv_wr wr = {}, *bad_wr;
@@ -635,7 +628,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
 
     rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
 
-    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.rx_bufs_len);
     if (rc) {
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
@@ -643,7 +636,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     }
 
     wr.num_sge = num_sge;
-    wr.sg_list = new_sge;
+    wr.sg_list = sge;
     wr.wr_id = bctx_id;
     rc = ibv_post_recv(qp->ibqp, &wr, &bad_wr);
     if (rc) {
@@ -671,7 +664,6 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
                                 uint32_t num_sge, void *ctx)
 {
     BackendCtx *bctx;
-    struct ibv_sge new_sge[MAX_SGE];
     uint32_t bctx_id;
     int rc;
     struct ibv_recv_wr wr = {}, *bad_wr;
@@ -688,7 +680,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
 
     rdma_protected_gslist_append_int32(&srq->cqe_ctx_list, bctx_id);
 
-    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.rx_bufs_len);
     if (rc) {
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
@@ -696,7 +688,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
     }
 
     wr.num_sge = num_sge;
-    wr.sg_list = new_sge;
+    wr.sg_list = sge;
     wr.wr_id = bctx_id;
     rc = ibv_post_srq_recv(srq->ibsrq, &wr, &bad_wr);
     if (rc) {
-- 
2.20.1


