Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A137C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BF5206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWbhnHYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BF5206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoYo-0002cS-TP
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMN-0000YN-SV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoML-0007sf-Qy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BnPRrVeAnWqBsNzNwsX+5XPQmBcv+SY5NaSBhpbVhLQ=;
 b=TWbhnHYi/vo0hWDgaIpDL5Y3kgKE//2FDhwnMT0d1tR7ny87iiRDddJtNGPNWzCE+odkwG
 KhPq3Edg1hNS1g+eRbZQK/E7BIbN7Qs38kc5n2xmChxaHifZCuPTk8jMV41R56gHaWOa0Y
 Qz5yKuPWOQybcm0WvRKA9rtSBR9VhRA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-sc8NE1-EO6GK_Wn6uH7pCA-1; Thu, 03 Sep 2020 08:28:55 -0400
X-MC-Unique: sc8NE1-EO6GK_Wn6uH7pCA-1
Received: by mail-wr1-f69.google.com with SMTP id m7so1008880wrb.20
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BnPRrVeAnWqBsNzNwsX+5XPQmBcv+SY5NaSBhpbVhLQ=;
 b=TKc2aOrTIwyzXYe/gC1gJze//i0l3RcZeL+oRTZPcbG0lL804NX63jA/x9tcoXA45A
 PH2ONo3MI7drfFZ5niD+batXQpzKB43t0FIHh0ePr110S7nG6PcRjiZYn3F1UDwD0tLU
 kgaNJw/bwx6Ic0Von/57l287+PYUR63Eytg5Z7I6+5PoKFQIn0PODtQXpNUxGGf0bQHi
 YolEwfeL1uOlQngmAJTLz9OkqA94psNsas543UYmwp6tsPFRh3NkzUYYIUJ9b6oo9VRz
 QDkj5Ck4fAwtLz59gUdOic2qmklY3c2A8sS3HtkeegKUwZaI7mH2IR0Qb+TsdLfgU0df
 aiMQ==
X-Gm-Message-State: AOAM5327yqOE0znoHhI6J9pxDR/xBc1m0w9HnwnmkECH4mxvzREquZwg
 pYQXk21d8NLpF/Lc7FkICnoWqF/vmudPmiHHA6u/PsXTOCTHOPycNFed4hD0fl4fEr0PbmUgR8P
 VgWZ2xXzcrUJynII=
X-Received: by 2002:a05:600c:4104:: with SMTP id
 j4mr2216240wmi.36.1599136134374; 
 Thu, 03 Sep 2020 05:28:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1P3xKCkdotZ0ihxXbFO5u+kzSZKJ7KrT0DsSjzP8T2WwFaB08L3C0krZVqlKTXYKNziB4Ig==
X-Received: by 2002:a05:600c:4104:: with SMTP id
 j4mr2216219wmi.36.1599136134193; 
 Thu, 03 Sep 2020 05:28:54 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id c205sm4141814wmd.33.2020.09.03.05.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 10/15] block/nvme: Replace qemu_try_blockalign(bs) by
 qemu_try_memalign(pg_sz)
Date: Thu,  3 Sep 2020 14:27:58 +0200
Message-Id: <20200903122803.405265-11-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
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

qemu_try_blockalign() is a generic API that call back to the
block driver to return its page alignment. As we call from
within the very same driver, we already know to page alignment
stored in our state. Remove indirections and use the value from
BDRVNVMeState.
This change is required to later remove the BlockDriverState
argument, to make nvme_init_queue() per hardware, and not per
block driver.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 60e39b69a23..0c8ad1d60b6 100644
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
                                           s->page_size * NVME_NUM_REQS);
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
2.26.2


