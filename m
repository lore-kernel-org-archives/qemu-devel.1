Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D84BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668B020724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XU7d8/1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668B020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrpq0-0004Cl-MJ
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpl9-0002xt-Jx
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43067
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpl6-00043s-Ol
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+f9l1P8/9tMwFIwJ8vCxS6Cv+1zykZTNOSgQEBgbIRo=;
 b=XU7d8/1gfYj399el7WyFCRdQtCnuQgECtRpJPlWj+844G4RWbzLLLDiiWeMSN04WFSEupf
 WpgPI4Wr32TFlZh8PvprOYUtJwSmNToQ3UF5jsqkr9yHEM0G85RHRSLiXLWvWvwEK5ex2p
 8PAw8anwp25W2YE4uNpt/VuEF4ZEUKs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-ID6pOcd5OVeMB4OwSgz7-g-1; Sat, 04 Jul 2020 17:31:38 -0400
X-MC-Unique: ID6pOcd5OVeMB4OwSgz7-g-1
Received: by mail-wm1-f71.google.com with SMTP id g187so40757077wme.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+f9l1P8/9tMwFIwJ8vCxS6Cv+1zykZTNOSgQEBgbIRo=;
 b=IKV348ySW7ND15AVwpASZ+OVb7x/xXmRG4gYdcaAUAhX8VpP0raQs2KVZlAaGXvMnh
 Hvn1zQiVtBTjDXGqs3+0uZUnngBNEEOzYVWHRPaYwi6ds9goar6hw9ZEk/GwkBCdmX6e
 M4JAurf5Je3acDuw23l4OOnj5GH3HqYIaYM1xaq0BNaC7u87iexKFhR6lWwyJXN7Aghj
 h0nKBDhU3dZIHdk1k9BvjtPOviU6C7QhHC44PJHW88R5rIl+fJ2RhLy9jnd89JfT8/Yu
 s2kMlWoJSk5AObjekrZx/peXu7wsHw9GwVSNJNR4GL2zPqY1ohUwvo7VhqCiNg8UIhnm
 DLhQ==
X-Gm-Message-State: AOAM532uibB9nXS87UaCbSpn8E+696UIM+yW+rPXowi8RnmnTX2Va9/j
 ViI09s7LedSTvz+fgpgfVxrrTa4oJNl4Bt09HLTod0R5Ppp9cEFMGNGVFY7P4NWVWfJCaA4pZ7/
 CDRGcIkeY2PLk7iU=
X-Received: by 2002:a05:600c:2116:: with SMTP id
 u22mr41611038wml.82.1593898297266; 
 Sat, 04 Jul 2020 14:31:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxx/Xi80qOOyDLEM/YB4VgQOKyWQiUKUeCzP1HBZzWuJA9Z59P8cXmRwbMmD83zlTUDddZahw==
X-Received: by 2002:a05:600c:2116:: with SMTP id
 u22mr41611029wml.82.1593898297051; 
 Sat, 04 Jul 2020 14:31:37 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c2sm18468552wrv.47.2020.07.04.14.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:31:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 09/16] block/nvme: Replace qemu_try_blockalign0 by
 qemu_try_blockalign/memset
Date: Sat,  4 Jul 2020 23:30:44 +0200
Message-Id: <20200704213051.19749-10-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:28:04
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

In the next commit we'll get rid of qemu_try_blockalign().
To ease review, first replace qemu_try_blockalign0() by explicit
calls to qemu_try_blockalign() and memset().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index a611fdd71e..9c118c000d 100644
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
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
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
2.21.3


