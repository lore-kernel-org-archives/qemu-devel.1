Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8ADC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2414A208A9
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFjVBwfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2414A208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8o0w-0006HR-C3
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nuw-0004U6-PN
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32770
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nut-0006FB-FE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6BpEV2cAZCoO+2PvXqrFXBtVGoZXhqod7yrp9Ptrs4=;
 b=dFjVBwfdfgkWmMlYNI0hWOUeTaqfFu/4MniuX7XZLR9MiEklR3EWmQbkCYgVBsMogVuT2l
 8O9ngZ3WA2ONsqlIDnO1QrLfsud6NACqSv92KE+jRv08cViLZ4qW6WzP2u5zcpEld5LEwA
 J4i3Tqw/I+r2keLKyi3VgI6LmxlkbMQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-xQVAlfBzNfWV7qaFy6veNw-1; Thu, 20 Aug 2020 12:59:53 -0400
X-MC-Unique: xQVAlfBzNfWV7qaFy6veNw-1
Received: by mail-wr1-f70.google.com with SMTP id k11so859197wrv.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z6BpEV2cAZCoO+2PvXqrFXBtVGoZXhqod7yrp9Ptrs4=;
 b=dWoOJHSMYZcF8rYQvRIm9gD1oA33FFIC38QYbS462wlDj9t+X3FhrrsXg5VYN/V4fu
 +63fwCp5aDBiAreEkvQU3UOLsf9SX4iGU7MxtNT6xms3JvG1MgYjn47yybeNj1PpBPDA
 EDq/hGSstw/TqD1TD/Ke32tuP/l74bH6u3BprwG9myW7QqcRVD/G5zfQXl7fFH3+Kb//
 snd1h7vwnwcO/n2kSTUiUXlrnlxqDVfRWUDwOcOw+h2FERA9W0iinyD94/JvC9JBCos9
 Q8GsEuvVSe+HWU16jGJ1DUG6E4Fi+7OUpLsJCIeAJ2iE5fhGLQID7E4+eJZIgRARsNjh
 ip9Q==
X-Gm-Message-State: AOAM531IyN5L8FHTu9KFMw/3OxPMOCbfJywCYtw6WWRI/Gqv0sFThycI
 b41pYYXX3We5NqpMR3DvgSbeSZwpfbioTj8wsz8HOdUj90td/1fxxr4fvt2rv3x9KVhFK8+IVJi
 T6AbqUvOUePz02cM=
X-Received: by 2002:adf:9487:: with SMTP id 7mr3916203wrr.133.1597942791779;
 Thu, 20 Aug 2020 09:59:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEpqkGZDH9TK1DCoOn36iPjQiqMxIzKxeeLBHvL1hZAk3Fq8CgkXF9pjKjyRd9q9WY/iUZfg==
X-Received: by 2002:adf:9487:: with SMTP id 7mr3916185wrr.133.1597942791548;
 Thu, 20 Aug 2020 09:59:51 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w64sm5977910wmb.26.2020.08.20.09.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 09:59:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/15] block/nvme: Replace qemu_try_blockalign0 by
 qemu_try_blockalign/memset
Date: Thu, 20 Aug 2020 18:58:55 +0200
Message-Id: <20200820165901.1139109-10-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820165901.1139109-1-philmd@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In the next commit we'll get rid of qemu_try_blockalign().
To ease review, first replace qemu_try_blockalign0() by explicit
calls to qemu_try_blockalign() and memset().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 2bd1935f951..ac6bb52043d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -174,12 +174,12 @@ static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
 
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
@@ -223,11 +223,12 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
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
     q->s = s;
     q->index = idx;
@@ -521,7 +522,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         .cdw10 = cpu_to_le32(0x1),
     };
 
-    id = qemu_try_blockalign0(bs, sizeof(*id));
+    id = qemu_try_blockalign(bs, sizeof(*id));
     if (!id) {
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
@@ -531,8 +532,9 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
     }
-    cmd.prp1 = cpu_to_le64(iova);
 
+    memset(id, 0, sizeof(*id));
+    cmd.prp1 = cpu_to_le64(iova);
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to identify controller");
         goto out;
@@ -1283,11 +1285,11 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
 
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
2.26.2


