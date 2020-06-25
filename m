Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BEEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4BD206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baxh4CP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4BD206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWzU-0004vZ-RY
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvt-00081f-TF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvr-0000xh-KI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D25/qK3jouvb6CaMBWXVBrYPJJAal8XQQt3oaNzllJ4=;
 b=baxh4CP2HMXHBtjjhAilTauf3Bx4Id22YBhM+IMh5C8M7x8+4xXmsqvkE4zRdgP1i/pmA4
 fnruajdm3SLzr9Sc4ES22TDs9Z3DlwvkKbOmx5HDNCEWszRyFvH5EQe6b49C9WqpnR4/mx
 V392xxbwpHq6Knd/lop6wNyztF+8WKQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-54AGoQVyO_mYYq6HDTjO8g-1; Thu, 25 Jun 2020 14:49:05 -0400
X-MC-Unique: 54AGoQVyO_mYYq6HDTjO8g-1
Received: by mail-wm1-f72.google.com with SMTP id v6so5725498wmg.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D25/qK3jouvb6CaMBWXVBrYPJJAal8XQQt3oaNzllJ4=;
 b=VSmun/5CU2BsARU7KW0EN/+mK5ubqSR2ltGbZZO5OliOAGwmQz09J7gtt+UDXBWA2b
 hYBpGQDg4In6/D6cqmad8f4ucnwzb8oiSdvN3SXShf1NG5pVOX85sX2aVUKEhBf+YHu1
 DqvWF1Vix9+evDP7KAmMRJ4FKQEgityfLqd5uRi2GDkMGnThxJGU7HpLfyg+gRFabNVb
 6RMwpCe0V2C7OYVumfYjtYRZbWKnPMDmMpjU+Mf0OvDIIVBjQjAJTKsR8ixM5AIlxtpO
 HnetuNdX2Tg7KHxUdEZ/Jb5/CwUDD8kADVXpVlZh7e2Qj6vv/w+EDteN4pr2/xXsvru2
 kClw==
X-Gm-Message-State: AOAM531S4qLS6xezYb1rh2hVmsyOohlNkWa7xgHVE1l2tMCxd3utoT1r
 Xcu9Oobc/Wbs4LgjPBcWjOWeyoClbi9TRtxn63I3kTopPwjuTJ8vNBpsygTreWzyaFTKttaf7uB
 1UV+5k5zAJIA6xyI=
X-Received: by 2002:adf:ed02:: with SMTP id a2mr21006371wro.110.1593110944037; 
 Thu, 25 Jun 2020 11:49:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWhDJ6tss58s/bIUrcVvTbA3/T8YxyahSOQxXh9LEF89jgu5T9YuMy4CKKr/sUQwSeV1DHkA==
X-Received: by 2002:adf:ed02:: with SMTP id a2mr21006362wro.110.1593110943859; 
 Thu, 25 Jun 2020 11:49:03 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k185sm10423085wmk.47.2020.06.25.11.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 05/17] block/nvme: Replace qemu_try_blockalign0 by
 qemu_try_blockalign/memset
Date: Thu, 25 Jun 2020 20:48:26 +0200
Message-Id: <20200625184838.28172-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the next commit we'll get ride of qemu_try_blockalign().
To ease review, first replace qemu_try_blockalign0() by explicit
calls to qemu_try_blockalign() and memset().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index ffda804a8e..bdddcd975d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -158,12 +158,12 @@ static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
 
     bytes = ROUND_UP(nentries * entry_bytes, s->page_size);
     q->head = q->tail = 0;
-    q->queue = qemu_try_blockalign0(bs, bytes);
-
+    q->queue = qemu_try_blockalign(bs, bytes);
     if (!q->queue) {
         error_setg(errp, "Cannot allocate queue");
         return;
     }
+    memset(q->queue, 0, bytes);
     r = qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova);
     if (r) {
         error_setg(errp, "Cannot map queue");
@@ -204,11 +204,12 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
     if (!q) {
         return NULL;
     }
-    q->prp_list_pages = qemu_try_blockalign0(bs,
+    q->prp_list_pages = qemu_try_blockalign(bs,
                                           s->page_size * NVME_QUEUE_SIZE);
     if (!q->prp_list_pages) {
         goto fail;
     }
+    memset(q->prp_list_pages, 0, s->page_size * NVME_QUEUE_SIZE);
     qemu_mutex_init(&q->lock);
     q->index = idx;
     qemu_co_queue_init(&q->free_req_queue);
@@ -450,7 +451,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     };
 
     idsz_max = MAX_CONST(sizeof(NvmeIdCtrl), sizeof(NvmeIdNs));
-    resp = qemu_try_blockalign0(bs, idsz_max);
+    resp = qemu_try_blockalign(bs, idsz_max);
     if (!resp) {
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
@@ -462,6 +463,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
     }
+
+    memset(resp, 0, sizeof(NvmeIdCtrl));
     cmd.prp1 = cpu_to_le64(iova);
 
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
@@ -484,7 +487,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
     s->supports_discard = !!(oncs & NVME_ONCS_DSM);
 
-    memset(resp, 0, 4096);
+    memset(resp, 0, sizeof(NvmeIdNs));
 
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
@@ -1202,11 +1205,11 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
 
     assert(s->nr_queues > 1);
 
-    buf = qemu_try_blockalign0(bs, s->page_size);
+    buf = qemu_try_blockalign(bs, s->page_size);
     if (!buf) {
         return -ENOMEM;
     }
-
+    memset(buf, 0, s->page_size);
     buf->nlb = cpu_to_le32(bytes >> s->blkshift);
     buf->slba = cpu_to_le64(offset >> s->blkshift);
     buf->cattr = 0;
-- 
2.21.3


