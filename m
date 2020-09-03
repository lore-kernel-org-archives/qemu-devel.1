Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE84C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E28206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="io1Oyw5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E28206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoSK-0000d3-09
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMJ-0000SZ-Ex
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20333
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMH-0007sK-2G
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCC5Fw+MiUlqW0HMIIfQxzi+31vZOBfq2qQvazw+mlU=;
 b=io1Oyw5PeGHl85/1bZLXXIWOSnnjN+DgAEFg1rtN9lNoO2prRLgUWO9POgWc+StNLxdwCR
 IT3NvLo7mUcJ1QvF8u+EGG4XoTXuAjtmLvP12kxYCCL3DVbRCfNiqrvxEd9K6fZjIr30+o
 SoSiSNa6u7QW7opGq9u7AN9JEzKiviY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-CynDEYHkNdeEAFIRcoyJUA-1; Thu, 03 Sep 2020 08:28:51 -0400
X-MC-Unique: CynDEYHkNdeEAFIRcoyJUA-1
Received: by mail-wr1-f69.google.com with SMTP id y3so1010215wrl.21
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BCC5Fw+MiUlqW0HMIIfQxzi+31vZOBfq2qQvazw+mlU=;
 b=pdBBU0d5idJqJiNNApyu3OpsqBdE53QBsP1d03FrPrbViXJOM+oJ+Nrk7PxAJiSWLa
 u0Om8H7l0ar6HuxleSiubrDtzltHGasiiXZTnVvCdjrAoOoCn90egogEhWMVoQMbH+7L
 pTXfWZXCbjOnR+91bI4h06XX0vTJESeONMmU3EptzcpQvXa66pFP9m/o+9rur0myoZze
 izfvx3/8UxrIAZVeyO68As+wzdEG7/1M/6v3ZvsOnYdneoRmhQB8tCgr42KHbdxn0Lah
 nhy7y8zDu/RdlkILR7+pT5Vbh+GJVXaD57qA8JcFCJIQe4IUuJ1nSuJOrUyq0QaE+NHw
 VYkQ==
X-Gm-Message-State: AOAM532q6ZCAjZ4cPR2jzAQNeETxH+WD3pQyG6pF3s2iRvHpHFLRMpeB
 DZqUxaBogz1fzGq+MPEcbBOlvvUqEduZFzXyuD7lzLR8zj8BoF3kGW5iqDllBpZkezePJoHYxE5
 VIaohYt139b3wImU=
X-Received: by 2002:adf:f984:: with SMTP id f4mr2244790wrr.102.1599136129568; 
 Thu, 03 Sep 2020 05:28:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSQ+MU+mHMCK0Ymds2uyXemBfkA9hatSDOQRDvUt5dpj6d430q2JtIhNwlBnkXhCDWfzcZxQ==
X-Received: by 2002:adf:f984:: with SMTP id f4mr2244772wrr.102.1599136129408; 
 Thu, 03 Sep 2020 05:28:49 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q186sm4451819wma.45.2020.09.03.05.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/15] block/nvme: Replace qemu_try_blockalign0 by
 qemu_try_blockalign/memset
Date: Thu,  3 Sep 2020 14:27:57 +0200
Message-Id: <20200903122803.405265-10-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the next commit we'll get rid of qemu_try_blockalign().
To ease review, first replace qemu_try_blockalign0() by explicit
calls to qemu_try_blockalign() and memset().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index b0d55ecfb25..60e39b69a23 100644
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
                                           s->page_size * NVME_NUM_REQS);
     if (!q->prp_list_pages) {
         goto fail;
     }
+    memset(q->prp_list_pages, 0, s->page_size * NVME_NUM_REQS);
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
-    cmd.dptr.prp1 = cpu_to_le64(iova);
 
+    memset(id, 0, sizeof(*id));
+    cmd.dptr.prp1 = cpu_to_le64(iova);
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


