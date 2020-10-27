Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D48CC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AE5206FA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nwi5zr1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AE5206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPs9-0007JL-Nj
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSa-00034r-6W
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSX-0004GA-5Y
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4p23PAiAshE1wqHPJXxubFhGilm8TUfsmi+fLR5mFU=;
 b=Nwi5zr1A5iyt7/8lizFgAOeJxTElYeZAVmwRTzbDMQyQ/zrOzqEYoQYV/WRfgc0fcucp2X
 b0UsPrScF2zKtMxeEIbhKz1O0+wMW3h4clsN1ojY4gBetm44F1SAhRczwkRQgbo+4tR0IY
 hUWNMIizRwogiwlsXpwMfvZRvjc6UBg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-FtNe1-IAMFyHwIZf3LdxtQ-1; Tue, 27 Oct 2020 09:56:18 -0400
X-MC-Unique: FtNe1-IAMFyHwIZf3LdxtQ-1
Received: by mail-ej1-f70.google.com with SMTP id c10so892977ejm.15
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W4p23PAiAshE1wqHPJXxubFhGilm8TUfsmi+fLR5mFU=;
 b=pN4uRoI3YgEMH1Gu0RAoEM7Hm6eooUFN5EE+dSAJcb/zMdRzf5kh37af7anbXNTQWf
 29MqlJgkkmMUXldhIpmvnJsQ9EBaL1HS/GhNEvinfq0AXkpCGV/ehBpiarxe4Qv95c66
 IcTls5s4NMRBnGnmPx5YZ3QkrSR1Tfd9UkHfinV3Ty/KVFk+Wip09DJXPt8Mv8IXIu2c
 Ho7FHa2kx7dbmdkeiQO2RUZZ5g8aGGXvyDiUDav1XVffkDkQmSjyeArfVOxofB6AE0tc
 bWexu5H7VFmQUWfKB5n28zBPJhJLXt5hY+rXWx44dgi4rfGv4fi3kKSTm5StA8gO8K6j
 3/iw==
X-Gm-Message-State: AOAM533hEqJ7r8CCYFzMGXg/8rQ+42ikNhCRu6qzLgy4JtYxgWHrOhPE
 lyyYOjkGSzc9Q9b1Lvv+nWZ3mkJM5l5HPOIAtu6nWkelSlGo0ZzuJYZOyZMXoirOD6UlvWVq5O2
 yx1FYtBI59r4P1Lw=
X-Received: by 2002:a05:6402:1597:: with SMTP id
 c23mr2333562edv.155.1603806977127; 
 Tue, 27 Oct 2020 06:56:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCRg3m9AjyyZc8sVf3hr531fxX8NHAcXcVOzmNdPiFosGkCCMbuKs3qZZhGAqy2IGvrMhbIw==
X-Received: by 2002:a05:6402:1597:: with SMTP id
 c23mr2333537edv.155.1603806976927; 
 Tue, 27 Oct 2020 06:56:16 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id ce15sm1179509ejc.39.2020.10.27.06.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:56:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/25] block/nvme: Trace nvme_poll_queue() per queue
Date: Tue, 27 Oct 2020 14:55:27 +0100
Message-Id: <20201027135547.374946-6-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As we want to enable multiple queues, report the event
in each nvme_poll_queue() call, rather than once in
the callback calling nvme_poll_queues().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 2 +-
 block/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 361b5772b7a..8d74401ae7a 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -594,6 +594,7 @@ static bool nvme_poll_queue(NVMeQueuePair *q)
     const size_t cqe_offset = q->cq.head * NVME_CQ_ENTRY_BYTES;
     NvmeCqe *cqe = (NvmeCqe *)&q->cq.queue[cqe_offset];
 
+    trace_nvme_poll_queue(q->s, q->index);
     /*
      * Do an early check for completions. q->lock isn't needed because
      * nvme_process_completion() only runs in the event loop thread and
@@ -684,7 +685,6 @@ static bool nvme_poll_cb(void *opaque)
     BDRVNVMeState *s = container_of(e, BDRVNVMeState,
                                     irq_notifier[MSIX_SHARED_IRQ_IDX]);
 
-    trace_nvme_poll_cb(s);
     return nvme_poll_queues(s);
 }
 
diff --git a/block/trace-events b/block/trace-events
index b90b07b15fa..86292f3312b 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -145,7 +145,7 @@ nvme_complete_command(void *s, int index, int cid) "s %p queue %d cid %d"
 nvme_submit_command(void *s, int index, int cid) "s %p queue %d cid %d"
 nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6, int c7) "%02x %02x %02x %02x %02x %02x %02x %02x"
 nvme_handle_event(void *s) "s %p"
-nvme_poll_cb(void *s) "s %p"
+nvme_poll_queue(void *s, unsigned q_index) "s %p q #%u"
 nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, int flags, int niov) "s %p is_write %d offset 0x%"PRIx64" bytes %"PRId64" flags %d niov %d"
 nvme_write_zeroes(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offset 0x%"PRIx64" bytes %"PRId64" flags %d"
 nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
-- 
2.26.2


