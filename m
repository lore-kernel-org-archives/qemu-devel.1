Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAD0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D418C206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbDaR9FZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D418C206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLqX-0003Ju-In
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLi0-00072Q-VQ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:14:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhz-0005aj-8C
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593544456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lvVHFOutT4xNyLe5+eXbBjp3teTx1IVF01y815xjeo=;
 b=XbDaR9FZ0wzuzZ3DQ7G7ZF+XFICF+5K5tf4cQ1Cal9ZR5Vb8b2Y46NdUq+AiCBDQN3JSqr
 tp/KhoM3/4HaZzGkc27ngduk/HuAiLDw6pgyJ1fdMJd5qptaT+iJFMHDF/SONqmw3+YIsA
 14thS5RokKyAxtDb+Qs8JLyxB41lTzA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-2WH3npdbOAGMT_5ruAF77Q-1; Tue, 30 Jun 2020 15:14:14 -0400
X-MC-Unique: 2WH3npdbOAGMT_5ruAF77Q-1
Received: by mail-wm1-f71.google.com with SMTP id a21so21154546wmd.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2lvVHFOutT4xNyLe5+eXbBjp3teTx1IVF01y815xjeo=;
 b=r5CSkxGfStpnRekocxcSafgC9GEqASsieGjx6ITG4nr0nNjzLL9DChRBmnWx0Ly52j
 Ckb6XrD01tNtDqqWww7sq3QO6e80WA9kEG0CdMG21gZ7HohugHNLbjAkifA0Y1/mLxth
 RHxNopocV/gvC7J0IVNzze3rsG17A4TsKVkeU1XzZ0xCha2E1JN6KkoYoPU8DDx63Brw
 fbuA5vDwQ2Umg9ZsOwEHZcg/Vgr2QptiFs7kL53Vlh0jRufsnpDVRw7zyrBwFayju0+z
 vLcNFfw9RGHAtg+3EXFKBIF1rgXg3EngA2JtKPxW9uPaiEzH0hh3OgcZFYDuTYTTW3xD
 ds5g==
X-Gm-Message-State: AOAM533pFrbDdaYIzYq0ZhFhdKzL1yqfK640KO0nfPSWzyybJ6Bgz0z1
 q+Kyhit79OlxORMtXAOrk7fJk1jFFQlYGg1/YbPxWfr2yNlADuT8rZrMUPQUicxHMEvwnewwdbx
 6l4bjt+w84FDshZ4=
X-Received: by 2002:a7b:c775:: with SMTP id x21mr7981681wmk.34.1593544453477; 
 Tue, 30 Jun 2020 12:14:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGZM7NxTJSQKKuMFFlvtMBFSlO59hmL8uK6jk8OfYAQMXly4R54KczyTR9KdpmWogkyRkb3w==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr7981658wmk.34.1593544453216; 
 Tue, 30 Jun 2020 12:14:13 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f14sm5135901wro.90.2020.06.30.12.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:14:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/12] block/nvme: Simplify nvme_create_queue_pair()
 arguments
Date: Tue, 30 Jun 2020 21:13:17 +0200
Message-Id: <20200630191318.30021-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630191318.30021-1-philmd@redhat.com>
References: <20200630191318.30021-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nvme_create_queue_pair() doesn't require BlockDriverState anymore.
Replace it by BDRVNVMeState and AioContext to simplify.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 010286e8ad..90b2e00e8d 100644
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
@@ -682,6 +682,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                      Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
+    AioContext *aio_context = bdrv_get_aio_context(bs);
     int ret;
     uint64_t cap;
     uint64_t timeout_ms;
@@ -742,7 +743,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
-    s->queues[QUEUE_INDEX_ADMIN] = nvme_create_queue_pair(bs, 0,
+    s->queues[QUEUE_INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
                                                           NVME_QUEUE_SIZE,
                                                           errp);
     if (!s->queues[QUEUE_INDEX_ADMIN]) {
-- 
2.21.3


