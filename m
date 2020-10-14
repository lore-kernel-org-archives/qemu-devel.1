Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F58C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBB820B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgtO1jWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBB820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjOb-0004Yl-7b
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBi-0004oh-9E
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBZ-00010K-Bf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLxkAx2Y6NEXeaia5IYrWdVkNlawKHl6NTNLCcRm+HM=;
 b=EgtO1jWPAtRgMXw5vmguPte6QxYPRYGzkCQyKBGR/Rcpwav1nxTIoi+w+f7Lu9obRi1Wxa
 Nq/YJTAhsJ96mn6/k2mBrt2pHEmGef8spL4oO1JNn1VxcBGPkZa2Apv3OPvs38o1RxJEDT
 E/EBfQXGy5rh03NVmaEUtdZuUlWFN7s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-nMaUIel9PaKaVK_fUEfICQ-1; Wed, 14 Oct 2020 11:59:24 -0400
X-MC-Unique: nMaUIel9PaKaVK_fUEfICQ-1
Received: by mail-wr1-f69.google.com with SMTP id t3so1560675wrq.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YLxkAx2Y6NEXeaia5IYrWdVkNlawKHl6NTNLCcRm+HM=;
 b=DlxBlwzE+0IelqLjOV33k7mlcI3ANGJXaRl1+7j4kMrEmMN4t5eJ1EPWlq2VmlUtZZ
 NVvufp7fmxWELK/awgkMlJSYjL4iR7D06eKkuSygaQqU1TW2zp3XjaJMS0lnpLLPa6GH
 cCa49iDi+VQgJ1XsPETzy70Vkbb550QFYu9jXJ/1bN8E6tVSmY+qGkJHrzJz0zVGFGfn
 YBDAnzPaGse+scoxAYbfYlwnts15Ls5rXp408jTf+KdYPQJvDQFCbUFgdiblPvtVV9aB
 u65YdpOCNu4//wKwd42ztcOrJl4BLOKZgsVOqMIePGxjKzxQStpa8E3+kUMDHvVSMjWf
 jFKg==
X-Gm-Message-State: AOAM532pWeIMM6t02CUaWTs3Zm94TOUnpNxloDiwTP8Dh0vhKRQ9oumu
 ZskxR0tFt7jkbGuN+ZuMY9LPFXSLnE9FdJB0Ecd7SzD8HlaTuLXDlERo1PokMlmRPcT7jvjbSME
 EDHp6j2nyLh5hNGo=
X-Received: by 2002:adf:fc51:: with SMTP id e17mr6110750wrs.45.1602691157631; 
 Wed, 14 Oct 2020 08:59:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAAwx+uTHoB0/5UNZAAiU8ffhFaePPO/3N56ZhAQ7f9v+cQmbMDDmAHAii2DzE/YyqdXlApA==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr6110732wrs.45.1602691157409; 
 Wed, 14 Oct 2020 08:59:17 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b63sm140620wme.9.2020.10.14.08.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:59:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/15] block/nvme: Simplify ADMIN queue access
Date: Wed, 14 Oct 2020 17:58:08 +0200
Message-Id: <20201014155810.102841-14-philmd@redhat.com>
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

We don't need to dereference from BDRVNVMeState each time.
Use a NVMeQueuePair pointer to the admin queue and use it.
The nvme_init() becomes easier to review, matching the style
of nvme_add_io_queue().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 299fc82f40f..ea5180d8a27 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -690,6 +690,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                      Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
+    NVMeQueuePair *q;
     AioContext *aio_context = bdrv_get_aio_context(bs);
     int ret;
     uint64_t cap;
@@ -769,19 +770,20 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
-    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
+    q = nvme_create_queue_pair(s, aio_context, 0,
                                                           NVME_QUEUE_SIZE,
                                                           errp);
-    if (!s->queues[INDEX_ADMIN]) {
+    if (!q) {
         ret = -EINVAL;
         goto out;
     }
+    s->queues[INDEX_ADMIN] = q;
     s->nr_queues = 1;
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
     regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << AQA_ACQS_SHIFT) |
                             (NVME_QUEUE_SIZE << AQA_ASQS_SHIFT));
-    regs->asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
-    regs->acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
+    regs->asq = cpu_to_le64(q->sq.iova);
+    regs->acq = cpu_to_le64(q->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
     regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
-- 
2.26.2


