Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EB0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8CD206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItSOUFUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8CD206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDob3-0004X9-5X
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMc-0000wM-GM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMa-0007u4-KL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5/xQskK0Ke2FAX64uYiLcx+1Sf83WT/CYfOUHG+VA0=;
 b=ItSOUFUpyVZDtg+PuPZTdcCU/nbuuqp92CddQpK31/jWLgH3zVOox0BwKNuOCVn33W8Y+y
 Zpw/L7WHQVPmHwpsTiPtw0Z5PUFMDTpkRCuQuwU0YeRimmvJiUnjAk3he4LZn/Yys/ML93
 8LPCFxuCLHcyGWA+gd/NF9UcaR0aJW4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-Vokkc50dNYObjF-6MCDx0Q-1; Thu, 03 Sep 2020 08:29:10 -0400
X-MC-Unique: Vokkc50dNYObjF-6MCDx0Q-1
Received: by mail-wm1-f69.google.com with SMTP id a144so900627wme.9
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x5/xQskK0Ke2FAX64uYiLcx+1Sf83WT/CYfOUHG+VA0=;
 b=IYEJhtubYlaw7Pwbnvf+G0ZgZkdDiuMH2K1s5EIg99hsny968h1m2O8zLr91DXmA11
 udzC+Ct8IX22N6IvWUfHjHrilh6YqwbtD5Q3897u+6u8UFCP8dXKX47R7aXUP/lFXWQU
 9ApXWAYygAqg1Qg1YmAIlfVtAiq6PGoumfnIO6yD9b7ivi3u7ebLJpczgp5yrZ7vj0fJ
 /w86V0WdXjIJwjjsFHX2aGRVzvfhsuvBURh9BmwcDWvicQToBc3jWzk6A1aMLQ0z15Ty
 vkDA6WgeLS8/fDxcyLBMkXUJt0jbSo1H+x/GAIv0OfQKcngnsjp/5FjKDNdbVmNQnZ5R
 xcWg==
X-Gm-Message-State: AOAM533wgpdqZHfuwGsvpbm+0GHB3QAuS2E5EehZU2LYJIv/JpeeSCP/
 2HngthczcjM5NDZOMqN2bJanZyvfM+Gsd6KbRjPc3seuOW2Da3KYKV6GpAxu0HYbkXZ3fynTfxH
 D4BU5OZe9fOE5AUw=
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr2227573wml.139.1599136149186; 
 Thu, 03 Sep 2020 05:29:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5NMKKDbITg75Dhbnj9Yb4GEJg7u7c/HGsjaFHbKZce9YPq+wSot8h//t4GqgNxa6X9ZnlFQ==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr2227549wml.139.1599136149031; 
 Thu, 03 Sep 2020 05:29:09 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id f17sm4442865wru.13.2020.09.03.05.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:29:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 13/15] block/nvme: Simplify nvme_create_queue_pair()
 arguments
Date: Thu,  3 Sep 2020 14:28:01 +0200
Message-Id: <20200903122803.405265-14-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nvme_create_queue_pair() doesn't require BlockDriverState anymore.
Replace it by BDRVNVMeState and AioContext to simplify.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index b03735129d3..914a3c4ab31 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -208,12 +208,12 @@ static void nvme_free_req_queue_cb(void *opaque)
     qemu_mutex_unlock(&q->lock);
 }
 
-static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
+static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
+                                             AioContext *aio_context,
                                              int idx, int size,
                                              Error **errp)
 {
     int i, r;
-    BDRVNVMeState *s = bs->opaque;
     Error *local_err = NULL;
     NVMeQueuePair *q;
     uint64_t prp_list_iova;
@@ -232,8 +232,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
     q->s = s;
     q->index = idx;
     qemu_co_queue_init(&q->free_req_queue);
-    q->completion_bh = aio_bh_new(bdrv_get_aio_context(bs),
-                                  nvme_process_completion_bh, q);
+    q->completion_bh = aio_bh_new(aio_context, nvme_process_completion_bh, q);
     r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
                           s->page_size * NVME_NUM_REQS,
                           false, &prp_list_iova);
@@ -637,7 +636,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     NvmeCmd cmd;
     int queue_size = NVME_QUEUE_SIZE;
 
-    q = nvme_create_queue_pair(bs, n, queue_size, errp);
+    q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
+                               n, queue_size, errp);
     if (!q) {
         return false;
     }
@@ -683,6 +683,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                      Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
+    AioContext *aio_context = bdrv_get_aio_context(bs);
     int ret;
     uint64_t cap;
     uint64_t timeout_ms;
@@ -743,7 +744,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
-    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(bs, 0,
+    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
                                                           NVME_QUEUE_SIZE,
                                                           errp);
     if (!s->queues[INDEX_ADMIN]) {
-- 
2.26.2


