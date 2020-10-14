Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A9C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80BC206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVN9FfgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80BC206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjJc-0004hX-N6
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBA-0004ap-PT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjB8-0000wW-JH
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiI/Pw6gOhc7zyCY4AJaHk9ZttCyA1OQsSTkGRUxoTI=;
 b=MVN9FfgR7iYX+tM/8JyT15NHJWBA4lPJq9xHIJunqAnsSPbaPSAUE1FYGPDTTwolfuFSGN
 BzcvFSng1C/LH86uDn1hjJ1Qs31CdYWDS15rl8lsUMq3PlTaRI2mBhSCAfOjFtnXZPXLDQ
 7MFsjLLlKKnLCB1E8FDufVbEC0PyD0M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-5yvTvqL6NMmA7dqdiIg_6w-1; Wed, 14 Oct 2020 11:58:49 -0400
X-MC-Unique: 5yvTvqL6NMmA7dqdiIg_6w-1
Received: by mail-wm1-f70.google.com with SMTP id y83so30929wmc.8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wiI/Pw6gOhc7zyCY4AJaHk9ZttCyA1OQsSTkGRUxoTI=;
 b=H496sr9LaTKemsDPDVQ8hEd8U/vrUWrcKegPrVaa1rslc8jfSS7hummPrpZ1K7in6J
 hm7f170MW15S3MFSbWntT2j04dvofA+13q7kUenRqPrDLOKSYTnBoXa41OyhfpjZwCHr
 RAvbmXePGwPqmaUr4Znb+/k7LqxCKbJIpkb0qbmAwDdrJa3hWqztsR4Edw6dVQeMjOJ3
 zvQ8X6lif6CpgEdxAjR1whDZYVxCIZFoJwLCbAN/bzm1p++4ZQXsVczYZO0V9IX+LciF
 ox2yoXep1zYTQZnfh8YfE9KQ59f+Ru2SuZMHcFhF53j0Cb0KeCIggncdzA5nv9LPsId6
 MhVA==
X-Gm-Message-State: AOAM530s8ACL1A2D8Pw1LcxYtc9C0TLWQBqfhd/3R2TAV4bgEPAGs5CZ
 IvRy/hsBi4/fiRlj8H4uFN+bkk4Wm8dGAIzFqG/jkSHuc2zhUiU3z+r5x/AU5gesYB1jnmzKgsK
 AlNQ1HumZ2k741LI=
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr119209wma.150.1602691128194; 
 Wed, 14 Oct 2020 08:58:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQHMAjXnvIMBcP4t8kkQfexIbI+9mLXQjTrrp/OzMu5S13aiIHObL/zS7XqNWjaLMm6rL4pQ==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr119186wma.150.1602691127970; 
 Wed, 14 Oct 2020 08:58:47 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t13sm106904wmj.15.2020.10.14.08.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:58:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/15] block/nvme: Make nvme_init_queue() return boolean
 indicating error
Date: Wed, 14 Oct 2020 17:58:02 +0200
Message-Id: <20201014155810.102841-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014155810.102841-1-philmd@redhat.com>
References: <20201014155810.102841-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just for consistency, following the example documented since
commit e3fe3988d7 ("error: Document Error API usage rules"),
return a boolean value indicating an error is set or not.
This simplifies a bit nvme_create_queue_pair().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 95f8f8b360b..523814a1243 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -153,7 +153,8 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
+/* Returns true on success, false on failure. */
+static bool nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
                             unsigned nentries, size_t entry_bytes, Error **errp)
 {
     size_t bytes;
@@ -164,13 +165,14 @@ static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
     q->queue = qemu_try_memalign(s->page_size, bytes);
     if (!q->queue) {
         error_setg(errp, "Cannot allocate queue");
-        return;
+        return false;
     }
     memset(q->queue, 0, bytes);
     r = qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova, errp);
     if (r) {
         error_prepend(errp, "Cannot map queue: ");
     }
+    return r == 0;
 }
 
 static void nvme_free_queue_pair(NVMeQueuePair *q)
@@ -203,7 +205,6 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
                                              Error **errp)
 {
     int i, r;
-    Error *local_err = NULL;
     NVMeQueuePair *q;
     uint64_t prp_list_iova;
 
@@ -240,16 +241,12 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
         req->prp_list_iova = prp_list_iova + i * s->page_size;
     }
 
-    nvme_init_queue(s, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!nvme_init_queue(s, &q->sq, size, NVME_SQ_ENTRY_BYTES, errp)) {
         goto fail;
     }
     q->sq.doorbell = &s->doorbells[idx * s->doorbell_scale].sq_tail;
 
-    nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, errp)) {
         goto fail;
     }
     q->cq.doorbell = &s->doorbells[idx * s->doorbell_scale].cq_head;
-- 
2.26.2


