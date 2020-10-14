Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95046206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gf8wNxsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95046206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjJb-0004cW-9l
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAs-0004QY-GS
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAq-0000v5-Sd
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghmcDakaPsk2ezFRlfrYLZqRji466VE/3yOqwiiBZsA=;
 b=gf8wNxsJHKHdCOwmDqbYW7d8Xss2ujUAgYfbKrOWPkMS78WfVK7lsulamsBsw3TjYn8PL+
 74xUUikxT9H/ayF3BTyB9VUK/JCoOPSLa4NZhFw1wjsC/efYoH/T6RE9uUVHi03Vh7qe14
 xhXw8anjTscAgJUDxc3HnZm9upFNytw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-6MWdQrssNSSms-fwWaVeyQ-1; Wed, 14 Oct 2020 11:58:39 -0400
X-MC-Unique: 6MWdQrssNSSms-fwWaVeyQ-1
Received: by mail-wr1-f69.google.com with SMTP id t3so1559528wrq.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ghmcDakaPsk2ezFRlfrYLZqRji466VE/3yOqwiiBZsA=;
 b=YzDork2Fu+50p6QBBVaYVMrgR/kSgj4+HgGjAf7kppgFUiidYSruDccOJsr+2kBivA
 86Y2ZOzuMlxuIpGWh5L9/bxhUuMxk0GC4L7iMsSGb6dhEz5VA5u99BCARSrQfEW5PU5h
 /wId1MUe9tXexx4V3bNX+PUDiTA8ZE955V4ilrx1Bb7bGqE5P2Y11XMQY6tUTuWLvtDe
 6vj9NnA3Qgmmx2y8mGigT+QB/zCXWIHbG5OvVpZp69OCUvxJzXZv/LuDAMyaFiRhA1ZB
 XWq4wS9tZ2FuFw7HetiYWsgfzJjALpeq8LEyk8LYuVD5mUQo5wbUl4tnrzBAMHj91nFv
 eN0w==
X-Gm-Message-State: AOAM530GU16b6VlEbN2dHqb7t9JOBbYgfceoiClRNexlp6OhI7pBOAiV
 cvL2Z7o0ilcrwrBXZTwcX+9CS32t1L4V83fvLwCo+UWNdMQIz9hv9p3bxRPDvA5j26zqEp9d9Zy
 PeuyGhmeTGrQMzOw=
X-Received: by 2002:adf:82f7:: with SMTP id 110mr6213039wrc.261.1602691118068; 
 Wed, 14 Oct 2020 08:58:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsoswR7KcyjOGRJR/+Nr8CZeH4vwy4J2qv5fpShJ2TYeI77QnSRCmu5EvZXnfuQBvWs164Kg==
X-Received: by 2002:adf:82f7:: with SMTP id 110mr6213022wrc.261.1602691117854; 
 Wed, 14 Oct 2020 08:58:37 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 88sm5869224wrl.76.2020.10.14.08.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:58:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/15] block/nvme: Trace queue pair creation/deletion
Date: Wed, 14 Oct 2020 17:58:00 +0200
Message-Id: <20201014155810.102841-6-philmd@redhat.com>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 3 +++
 block/trace-events | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index e9410f2e0eb..95f19e12cd6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -175,6 +175,7 @@ static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
 
 static void nvme_free_queue_pair(NVMeQueuePair *q)
 {
+    trace_nvme_free_queue_pair(q->index, q);
     if (q->completion_bh) {
         qemu_bh_delete(q->completion_bh);
     }
@@ -210,6 +211,8 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
     if (!q) {
         return NULL;
     }
+    trace_nvme_create_queue_pair(idx, q, size, aio_context,
+                                 event_notifier_get_fd(s->irq_notifier));
     q->prp_list_pages = qemu_try_memalign(s->page_size,
                                           s->page_size * NVME_NUM_REQS);
     if (!q->prp_list_pages) {
diff --git a/block/trace-events b/block/trace-events
index 410789188cc..6694c23e1c1 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -153,6 +153,8 @@ nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset %"PRId64" bytes
 nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset %"PRId64" bytes %"PRId64" ret %d"
 nvme_dma_map_flush(void *s) "s %p"
 nvme_free_req_queue_wait(void *s, unsigned q_index) "s %p q #%u"
+nvme_create_queue_pair(unsigned q_index, void *q, unsigned size, void *aio_context, int fd) "index %u q %p size %u aioctx %p fd %d"
+nvme_free_queue_pair(unsigned q_index, void *q) "index %u q %p"
 nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
 nvme_cmd_map_qiov_pages(void *s, int i, uint64_t page) "s %p page[%d] 0x%"PRIx64
 nvme_cmd_map_qiov_iov(void *s, int i, void *page, int pages) "s %p iov[%d] %p pages %d"
-- 
2.26.2


