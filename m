Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324EBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEEF4221E7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEv9ElFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEF4221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrpu6-0001sK-5J
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrplS-0003iS-DV
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:32:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrplP-00047H-O4
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWF/iZSCqkrI9PNeUzMaBp9Bso6oHE9Q+64iOjLLb68=;
 b=GEv9ElFH8ZEbJmWWmc2oRDr9TGW9gKhe+Lpsb9+uKgDj221++3HWBtUPnX17vjxQpuUCX5
 brBJdd9kDoI+pZdgoM9+HfkfbIGBIy74XBs+r2+w0AqxkUeht+jDLiqXvtz5zY09yi4anL
 XhRJn5zlWjC9q5lGzZKtU5cIEVKE8mc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-h-wxi8CNNK-eXyNBa3o70w-1; Sat, 04 Jul 2020 17:31:57 -0400
X-MC-Unique: h-wxi8CNNK-eXyNBa3o70w-1
Received: by mail-wr1-f69.google.com with SMTP id g14so36900868wrp.8
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rWF/iZSCqkrI9PNeUzMaBp9Bso6oHE9Q+64iOjLLb68=;
 b=D8+GWJxoxBl4RTkuMQuJ0iGZXLClf5uhK2atXyGV64FJJS1Z1ASNyD9FsrjIkXz++5
 k6ENHl1VyXo2blKC1trZxory7vZy1/U/0d8SPu8AHETKE/JpPnovL5YKKgevd04u6bAa
 UQbPhlKEF0pUmtg/Fc9xSFGntWSIXKpwABtwWthOc/mD+5Hd32PpA/ZSwbGqoxjY5KAj
 1p3em1ZAwbl351aTRb8kAnk+9N9ohJhwuu8d7r1fr6PRhOrLiD1+rwfRRfgHOWVJSM83
 UHYlVTCRLImuCZKJlV6W0UfYFETbZNC1d5e7AChk4KD6U/AWa6SmpPQ/Ew8fj5RCGYSM
 d0aA==
X-Gm-Message-State: AOAM530FfncxJclWfITKTE59ZIsYe4WP8HuPp7OVyszWmIxsOfYmL8qp
 C32t/M9rHrf0rgHAEnOzz61uMkfsFn8zYwkCVCZuGLcM5uzDgpO3x6S1Ek2BSOEQqxfxDzoldsC
 vRCwDCgSgcxeDjH4=
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr43930005wrw.2.1593898316089;
 Sat, 04 Jul 2020 14:31:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMzQXemqBEpGS2i3o6bqPBlU7wAV8G/iuaqyst6Z+WbkeyxmJtiU0uhjbA1ymr6rdzL/GPAA==
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr43929999wrw.2.1593898315931;
 Sat, 04 Jul 2020 14:31:55 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f186sm17347039wmf.29.2020.07.04.14.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:31:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 13/16] block/nvme: Simplify nvme_create_queue_pair()
 arguments
Date: Sat,  4 Jul 2020 23:30:48 +0200
Message-Id: <20200704213051.19749-14-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704213051.19749-1-philmd@redhat.com>
References: <20200704213051.19749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:28:03
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
index b2fc3c300a..51ac36dc4f 100644
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
-    s->queues[QUEUE_INDEX_ADMIN] = nvme_create_queue_pair(bs, 0,
+    s->queues[QUEUE_INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
                                                           NVME_QUEUE_SIZE,
                                                           errp);
     if (!s->queues[QUEUE_INDEX_ADMIN]) {
-- 
2.21.3


