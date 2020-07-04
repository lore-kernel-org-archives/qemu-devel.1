Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52DEC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DACD20724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ0iSRUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DACD20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrprN-0006Wj-Qj
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrplF-0003DA-4G
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrplD-00045i-GR
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfmX4SsthOp0qVQWfh38S15QI3pmZ2xeD0V8kh7HNfQ=;
 b=iZ0iSRURgj5jhYWbCk92qSK0FMPJ0IXFZ2kKxvWrdMh+csjXdqV2AVF0wXmbbEiUOot60X
 b026p5JSoOKckcg2iichzNVStAYR75nqnztf6zq6K75CAY5GX1t66rmt2JNOq4W81pnEe4
 nePhev/0FYvUJ+wOkfeHtQc77pTNrUM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-rcugwG5yPRu31As_bkkGsw-1; Sat, 04 Jul 2020 17:31:43 -0400
X-MC-Unique: rcugwG5yPRu31As_bkkGsw-1
Received: by mail-wr1-f70.google.com with SMTP id c6so17797057wru.7
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FfmX4SsthOp0qVQWfh38S15QI3pmZ2xeD0V8kh7HNfQ=;
 b=B6NSoDPPhiNcP8IT3sqYT6VK/wswzKpmdNA0mYo7/gyKONvs9Lv7ESD95Ki71BlP07
 p7srlN3W04PRwK3FaAE90GFujwTkS8YYMmb+Hd5GYtIVXN8CWG9ENJgHu09uU3qNdf9O
 5VKHtmDP7hax48by957v/n+aBzaqolOjG5vd+ny5DSGLaSIaO1BNDgj7LyHZ3MjlBPoa
 3V/Mtdgvs+1W5q9KUnZsa322CVxSxx/76l/scx5O6Fx9eA5B03B5iScf1MUGCKckq/0r
 VsGCEa/0Aqes7cTTpjqKMefGYIzYVCjtZWiNd7GxePeR8fJv5y1vwE9jHG+Eh8MEAiWV
 evJg==
X-Gm-Message-State: AOAM530qYIqdibBx4FE4HlTDgm58ChQuUnwNf76wOfGadOm/k39GQeM6
 if182NxuUpb0886Nb56zrA9Jvgp69b+urynAQEIMjF0f5rdTMDvUJ0Ma5y1aPAYJCvTLG/MYqrE
 jGtnpGHcqo8GrRSw=
X-Received: by 2002:a5d:420e:: with SMTP id n14mr44738237wrq.164.1593898301913; 
 Sat, 04 Jul 2020 14:31:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoZQ4+kKdjV7wZ7Te170gV8axwINWctID0EAxSSncar08/17BXChfDuFnemnKkw698BOnE+w==
X-Received: by 2002:a5d:420e:: with SMTP id n14mr44738224wrq.164.1593898301757; 
 Sat, 04 Jul 2020 14:31:41 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v9sm9897771wri.3.2020.07.04.14.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:31:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 10/16] block/nvme: Replace qemu_try_blockalign(bs) by
 qemu_try_memalign(pg_sz)
Date: Sat,  4 Jul 2020 23:30:45 +0200
Message-Id: <20200704213051.19749-11-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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

qemu_try_blockalign() is a generic API that call back to the
block driver to return its page alignment. As we call from
within the very same driver, we already know to page alignment
stored in our state. Remove indirections and use the value from
BDRVNVMeState.
This change is required to later remove the BlockDriverState
argument, to make nvme_init_queue() per hardware, and not per
block driver.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 9c118c000d..9566001ba6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -174,7 +174,7 @@ static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
 
     bytes = ROUND_UP(nentries * entry_bytes, s->page_size);
     q->head = q->tail = 0;
-    q->queue = qemu_try_blockalign(bs, bytes);
+    q->queue = qemu_try_memalign(s->page_size, bytes);
     if (!q->queue) {
         error_setg(errp, "Cannot allocate queue");
         return;
@@ -223,7 +223,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
     if (!q) {
         return NULL;
     }
-    q->prp_list_pages = qemu_try_blockalign(bs,
+    q->prp_list_pages = qemu_try_memalign(s->page_size,
                                           s->page_size * NVME_QUEUE_SIZE);
     if (!q->prp_list_pages) {
         goto fail;
@@ -522,7 +522,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         .cdw10 = cpu_to_le32(0x1),
     };
 
-    id = qemu_try_blockalign(bs, sizeof(*id));
+    id = qemu_try_memalign(s->page_size, sizeof(*id));
     if (!id) {
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
@@ -1141,7 +1141,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         return nvme_co_prw_aligned(bs, offset, bytes, qiov, is_write, flags);
     }
     trace_nvme_prw_buffered(s, offset, bytes, qiov->niov, is_write);
-    buf = qemu_try_blockalign(bs, bytes);
+    buf = qemu_try_memalign(s->page_size, bytes);
 
     if (!buf) {
         return -ENOMEM;
@@ -1285,7 +1285,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
 
     assert(s->nr_queues > 1);
 
-    buf = qemu_try_blockalign(bs, s->page_size);
+    buf = qemu_try_memalign(s->page_size, s->page_size);
     if (!buf) {
         return -ENOMEM;
     }
-- 
2.21.3


