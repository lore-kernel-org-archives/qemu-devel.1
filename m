Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F0FC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E1220663
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj4pl9j4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E1220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFjbA-0000IC-Ok
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 15:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFjYf-0005RE-Pg
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFjYe-0005nH-Em
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jFjYe-0005mk-8V
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id j17so8194953wru.13
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9WcigWUnLHfXhXyLoz7lUzEcGO8vLAxIfw1iSBHyvI4=;
 b=Hj4pl9j4shIQnskpqwUaOjpWyPpISN3fijSdZLQBi+YhNggk3eyH2fRKVtA824ddNM
 Eg+c9wmAGbwAqXAibuaPM9Rfs4TLx9vzLfQDih3nwYG1wI0CNeD9d2MP2HHj4w+IYSDR
 YUfsDk/ZF11p7K/LDr1Y62e1K9rPZ1iKdYrhE2BmzJWNtQ7ATXGneP5n9RCjba3Ysoks
 YCkvb0X2bONM4c+BZ9rv2QaXgxWwm0YFNDR2wiQ6E6eldbr0p1uFStf6YjTun2fzSey9
 PRRifPDtDbNzA4P3+R2tXyIyR5/pmTpdzdv1xg+XOt/Ahc7Qk12aSZrSDiJ6N4cAE1So
 zzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9WcigWUnLHfXhXyLoz7lUzEcGO8vLAxIfw1iSBHyvI4=;
 b=qK5nmpnp2rkiK4JM3PAP2FEQKUELm7MfvYAjDLEXzrelbjMjAz04yTY4OtjQW4fKtV
 no5EQjTpmi0gryVK65SQ8bW5tgGN/u0rce2hHTACs6LYbQEnMN/u6Lm4MvOuf9Elc1i/
 uUtF3q6/LSXWs7vBeVsvaMSDI+do4bLhD8CxLE5Ucd9LUGojKUlWpLPPRVs6x5QLK4Iv
 2FY6NxNsOozaYXjwASwyzd8tqAsoD1NTyGjYG9Ky0vZ1EbZ31H+MG4sj6kztskQ6TU5X
 Ydx+UCJF5tK3DqaefadwMIUwcRiod44WBilx+lQUvUszOvn3F6gCYK8Gh3tAVr1CDn4v
 TXSg==
X-Gm-Message-State: ANhLgQ39Vhl2hrB2FpvbwA2xFq854AfRO+7OSRaNw2MiIfm7uzMntkSa
 XLdfb1Hf6NsTeof6CDiaW+aqKhLn
X-Google-Smtp-Source: ADFU+vs77amrZMIzWmc1ciNWrtCrZXTd3DzY20GTrnLqnKtZjogN4b8zqwktfxM4hDuV2gU4PxAY7w==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr3926356wrl.397.1584817998978; 
 Sat, 21 Mar 2020 12:13:18 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id i1sm15226252wrs.18.2020.03.21.12.13.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 21 Mar 2020 12:13:18 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [Qemu-devel] [PATCH PULL 2/4] hw/rdma: Cosmetic change - no need for
 two sge arrays
Date: Sat, 21 Mar 2020 21:13:09 +0200
Message-Id: <20200321191311.31537-3-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
References: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: jusual@redhat.com, stefanha@redhat.com, yuval.shaia.ml@gmail.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuval Shaia <yuval.shaia.ml@gmail.com>

The function build_host_sge_array uses two sge arrays, one for input and
one for output.
Since the size of the two arrays is the same, the function can write
directly to the given source array (i.e. input/output argument).

Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20200320143429.9490-2-yuval.shaia.ml@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
+        sge[idx].lkey = rdma_backend_mr_lkey(&mr->backend_mr);
 
-        *total_length += dsge->length;
-
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
2.17.2


