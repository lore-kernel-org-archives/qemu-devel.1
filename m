Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51424C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DE621D42
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yx4K5jG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DE621D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPVl-0005ka-Vv
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSm-0003D3-CB
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSj-0004Is-LO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTNKxaQwF4QN5Qm5IVyY35OwN1rDPq29NQ3lg6jSg14=;
 b=Yx4K5jG+RMU1t8vONfY2eiBvulIVGXVHI7/Ip7oH4RPfbmG4f2WojyY5yBT8CP3sCPO0Tq
 inpFzmyYZHFQJ5lbV47t488s3fsX0nt8/L1mDuT43NsyApSbP2HcAf5j0QiLEhPuPkWAzF
 EP7xK7tf4H7ZVH7lPn/LADBrvp4xcsI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-C604_w8kMzil-TUDQC79ww-1; Tue, 27 Oct 2020 09:56:30 -0400
X-MC-Unique: C604_w8kMzil-TUDQC79ww-1
Received: by mail-ed1-f72.google.com with SMTP id 28so718023edv.9
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WTNKxaQwF4QN5Qm5IVyY35OwN1rDPq29NQ3lg6jSg14=;
 b=Cx2egbSijMdDn3L03k+t7xytGpMMbiTMKbcn0ewxHUdzEX0JJ8hXdJmTsQbKnsYSwE
 emPPEn2IOwO87yJKsRPuDjXIsmOPdRJyeXMygx6W6AZSd89alAZZ1rNc/VsK3gQsPbnI
 Udi49hddSofm1Eq5cR/fCofE2z3AYL+HttvPBy4JfNa+jHBiJjazgKi3gjWs0YFQmA+G
 C356YbRXwBA13HwlVBGNZ2JGTqe9bJaEwge0Lhqz32lYLoeBX5gDxLudwkIPeXtwSqEy
 gOQ8hlswmhlYrDmfM0m7odbZ7dkyTh6uXOaNG54hzybvqUuRgFQF+dD/Z7tMetb/DZMg
 QJGg==
X-Gm-Message-State: AOAM531aH/xuuIizmGz1bGXiamVO73oRrGa3peJwDyeiAx7ghQ+uGRgp
 94JFEONEyhgOSO6ZzPsX40cRwAX3Hk0dNi7vy4c/fOedLvx4/wTvJo15qu1r7JiL9f/KTGrhbt2
 Dr0NHofNuz7ox5bY=
X-Received: by 2002:a17:906:383:: with SMTP id
 b3mr2438569eja.351.1603806988534; 
 Tue, 27 Oct 2020 06:56:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1GxBVUWTaaRofwrnmQgxs4Lw24I6NgzGnpAE7MCbszHDz/c7vUniMMGK4M9jVN3Z39g/66A==
X-Received: by 2002:a17:906:383:: with SMTP id
 b3mr2438554eja.351.1603806988329; 
 Tue, 27 Oct 2020 06:56:28 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v18sm1154105ejj.10.2020.10.27.06.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:56:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/25] block/nvme: Trace queue pair creation/deletion
Date: Tue, 27 Oct 2020 14:55:29 +0100
Message-Id: <20201027135547.374946-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
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
index 29d2541b911..e95d59d3126 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -181,6 +181,7 @@ static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
 
 static void nvme_free_queue_pair(NVMeQueuePair *q)
 {
+    trace_nvme_free_queue_pair(q->index, q);
     if (q->completion_bh) {
         qemu_bh_delete(q->completion_bh);
     }
@@ -216,6 +217,8 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
     if (!q) {
         return NULL;
     }
+    trace_nvme_create_queue_pair(idx, q, size, aio_context,
+                                 event_notifier_get_fd(s->irq_notifier));
     q->prp_list_pages = qemu_try_memalign(s->page_size,
                                           s->page_size * NVME_NUM_REQS);
     if (!q->prp_list_pages) {
diff --git a/block/trace-events b/block/trace-events
index cc5e2b55cb5..f6a0f99df1a 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -155,6 +155,8 @@ nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset 0x%"PRIx64" byte
 nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset 0x%"PRIx64" bytes %"PRId64" ret %d"
 nvme_dma_map_flush(void *s) "s %p"
 nvme_free_req_queue_wait(void *s, unsigned q_index) "s %p q #%u"
+nvme_create_queue_pair(unsigned q_index, void *q, unsigned size, void *aio_context, int fd) "index %u q %p size %u aioctx %p fd %d"
+nvme_free_queue_pair(unsigned q_index, void *q) "index %u q %p"
 nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
 nvme_cmd_map_qiov_pages(void *s, int i, uint64_t page) "s %p page[%d] 0x%"PRIx64
 nvme_cmd_map_qiov_iov(void *s, int i, void *page, int pages) "s %p iov[%d] %p pages %d"
-- 
2.26.2


