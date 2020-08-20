Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF25C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C15208A9
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gabB4xoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C15208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nzk-0003Yz-09
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nv3-0004j1-CC
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:00:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51907
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nv1-0006HG-4P
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JiBIb64BlS2pxwIv33N7yG3by1OM78D/kYXYdLYCac=;
 b=gabB4xoTZoqgT1xqNIdDqNu18XE1XfWf2u2velVmRpIKJMv+BRTxpuUYfohNoUtmj/xhjl
 nt+LiOa79/APA1vJvjnLlu0nxYEkDB6IQImhvL3IdOFfV2yFcaA/JkCgwKw6/aqi5VcO4o
 fSdYDFaLs6uYMADJTW7o9kyXNsOYBb8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-p66U97jGMGqx2FBt1qoBLA-1; Thu, 20 Aug 2020 12:59:58 -0400
X-MC-Unique: p66U97jGMGqx2FBt1qoBLA-1
Received: by mail-wm1-f72.google.com with SMTP id p184so1175409wmp.7
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3JiBIb64BlS2pxwIv33N7yG3by1OM78D/kYXYdLYCac=;
 b=OiM4RE5kP3rIAxhMjvkQhpU/7nU0InxpcG1jGY+Nt/NQwpsiFksrHLpUOxztIKPxeU
 su7iIcsDAAIBPz0GpbZvEUKoPBuOWxxb7xsObJEBBTtf55E8PJVXnikBrygJkBlv4xIK
 F2g12JHHDGwv/bu6hEF5k3EPFW+21rs/uP44jnS6vPdw6G+C1YJsw8Z+p8YRiNNhj0yT
 rswzOqLMpqgfVjUHRC/z3b8EC2j3t2PzM9Lbba0tZxQ/a2kC8nqDfeFZoRIHO9l0xzzD
 jK69ekfQWPcb29750Cqh4AwLgMcHW2np5kzR3OEa6JqV/xBDlIoMsqTEKEhscXC2urEU
 3+0Q==
X-Gm-Message-State: AOAM530DGbe6i5fY4l4BSr3v5bmTTeaiNKI74FQOHpkkMYnQZXjVueyC
 XxsVWqrmb8oB/wXckodf3iEOs4ArqbFymk50Pcas2TFpPFi5C0lvpe7lAtTIG5Zd0S7FlRdSaBZ
 b5tYfv1xm/+J39F0=
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr3948208wrx.49.1597942797239; 
 Thu, 20 Aug 2020 09:59:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyir+vLjLTY13DTXVIfwhUyrPcued8OQIEB638O91sIhwHNgIpIS8lB2Ol9hwBa9EEt2hF2Xg==
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr3948200wrx.49.1597942797024; 
 Thu, 20 Aug 2020 09:59:57 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g18sm5594311wru.27.2020.08.20.09.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 09:59:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/15] block/nvme: Replace qemu_try_blockalign(bs) by
 qemu_try_memalign(pg_sz)
Date: Thu, 20 Aug 2020 18:58:56 +0200
Message-Id: <20200820165901.1139109-11-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820165901.1139109-1-philmd@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index ac6bb52043d..f180078e781 100644
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
2.26.2


