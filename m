Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A0EC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 12:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22C72073C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 12:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWmpXepV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22C72073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAZ19-00056U-Rl
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 07:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jAZ05-0003se-GA
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuval.shaia.ml@gmail.com>) id 1jAZ04-00087T-6u
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:56:17 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1jAZ04-00080R-0g
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:56:16 -0500
Received: by mail-wm1-x344.google.com with SMTP id p9so5310213wmc.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 04:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=z3Ifd089BHeJaz+ELR8wOOn0T0YnIODfyTUWjMwnS9s=;
 b=XWmpXepV+68qC0KsFWfLiEKM9U/Sj/ybr9WkVUayhXheI6Q3XCRq2sfW7cJSVfGfe2
 nTiaF2YMq/89fg5ia34HMcBvnLEkNGfCqKt59dvqIoFyBxXW5IyLPK3GL4W3UtMYEwk/
 o8uCt1mF2VGbisyNfwXoO4/Fc1pDJUf5MqYIT38XsCa/qiEPixEv/hrTSlR3WtzzcM8A
 a0HnRm6EYSFfARu6Yfa3yKsKO0EfXVDoV8Xx8ZfhQZmGYQIwW3LJsNBZuPypCvbz95l6
 ORMcf/h/taBGQ+26xlH8wUDZjSbY1TDT9shnvNvKe+Xau7PGYqw2Z8HWbvAkLUvnIlS8
 CFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z3Ifd089BHeJaz+ELR8wOOn0T0YnIODfyTUWjMwnS9s=;
 b=mGRJ+GOP+wtOp1e54wMYCVNTVJ6U6dIqb3Bgbs9R/CCaeeSwcQAslOJcJ9ydnTUh5F
 m3ZeEZVqO32y9F5BbAgaPDibhrmOn4dAzcVtrtWUnrxNoP13iZMT475t2jveGaGJNOE9
 OP7UTyj5VX5ms3pqfrVZCYyZ7QriNYdLlMM1YiMKtRkF6sypnkA5PLQNe3VoV0HpaPLK
 rBBn8G5VkzGGr4niLxTQFRO/AsIq4ZN1ckuo8Cd3LzZBHegkTcudlmrOO5U9tOTh9m/3
 ONqDMX8WTiUeGoP4XhiiUmq9b6zuT2NVowRQhvzLEX6175i1IAZ1w132Gow+RT/x0x5+
 Dy3Q==
X-Gm-Message-State: ANhLgQ2Lr7TVjHSDsKqpb1/DHmC1O0nQfOUSqAHFHzjQLtK3rnENTXGb
 KpURtjCU6GApGZ470ktLFcwxsISD
X-Google-Smtp-Source: ADFU+vvmkoVuLx5Ggkiz/R7M8hLzYwOMQ8+1rDpT6qWxCxjrW/Q6L/+lXqECiL6/2qhdzls9nToVdQ==
X-Received: by 2002:a05:600c:2292:: with SMTP id
 18mr10239847wmf.13.1583585774696; 
 Sat, 07 Mar 2020 04:56:14 -0800 (PST)
Received: from localhost.localdomain ([2a00:a040:186:a1ad:5254:ff:fe84:1be0])
 by smtp.gmail.com with ESMTPSA id
 19sm19690289wma.3.2020.03.07.04.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 04:56:14 -0800 (PST)
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
To: qemu-devel@nongnu.org, yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com
Subject: [PATCH 1/2] hw/rdma: Cosmetic change - no need for two sge arrays
Date: Sat,  7 Mar 2020 14:56:07 +0200
Message-Id: <20200307125608.2476-2-yuval.shaia.ml@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200307125608.2476-1-yuval.shaia.ml@gmail.com>
References: <20200307125608.2476-1-yuval.shaia.ml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 hw/rdma/rdma_backend.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index c346407cd3..79b9cfb487 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -378,30 +378,27 @@ static void ah_cache_init(void)
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
+        sge[idx].addr = (uintptr_t)mr->virt + sge[idx].addr - mr->start;
 #else
-        dsge->addr = ssge[ssge_idx].addr;
+        sge[idx].addr = sge[idx].addr;
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
@@ -484,7 +481,6 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
                             void *ctx)
 {
     BackendCtx *bctx;
-    struct ibv_sge new_sge[MAX_SGE];
     uint32_t bctx_id;
     int rc;
     struct ibv_send_wr wr = {}, *bad_wr;
@@ -518,7 +514,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
 
     rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
 
-    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.tx_len);
     if (rc) {
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
@@ -538,7 +534,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     wr.num_sge = num_sge;
     wr.opcode = IBV_WR_SEND;
     wr.send_flags = IBV_SEND_SIGNALED;
-    wr.sg_list = new_sge;
+    wr.sg_list = sge;
     wr.wr_id = bctx_id;
 
     rc = ibv_post_send(qp->ibqp, &wr, &bad_wr);
@@ -601,7 +597,6 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
                             struct ibv_sge *sge, uint32_t num_sge, void *ctx)
 {
     BackendCtx *bctx;
-    struct ibv_sge new_sge[MAX_SGE];
     uint32_t bctx_id;
     int rc;
     struct ibv_recv_wr wr = {}, *bad_wr;
@@ -635,7 +630,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
 
     rdma_protected_gslist_append_int32(&qp->cqe_ctx_list, bctx_id);
 
-    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.rx_bufs_len);
     if (rc) {
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
@@ -643,7 +638,7 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     }
 
     wr.num_sge = num_sge;
-    wr.sg_list = new_sge;
+    wr.sg_list = sge;
     wr.wr_id = bctx_id;
     rc = ibv_post_recv(qp->ibqp, &wr, &bad_wr);
     if (rc) {
@@ -671,7 +666,6 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
                                 uint32_t num_sge, void *ctx)
 {
     BackendCtx *bctx;
-    struct ibv_sge new_sge[MAX_SGE];
     uint32_t bctx_id;
     int rc;
     struct ibv_recv_wr wr = {}, *bad_wr;
@@ -688,7 +682,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
 
     rdma_protected_gslist_append_int32(&srq->cqe_ctx_list, bctx_id);
 
-    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
+    rc = build_host_sge_array(backend_dev->rdma_dev_res, sge, num_sge,
                               &backend_dev->rdma_dev_res->stats.rx_bufs_len);
     if (rc) {
         complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
@@ -696,7 +690,7 @@ void rdma_backend_post_srq_recv(RdmaBackendDev *backend_dev,
     }
 
     wr.num_sge = num_sge;
-    wr.sg_list = new_sge;
+    wr.sg_list = sge;
     wr.wr_id = bctx_id;
     rc = ibv_post_srq_recv(srq->ibsrq, &wr, &bad_wr);
     if (rc) {
-- 
2.20.1


