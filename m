Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A70C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC73620B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P93v6MK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC73620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjGv-0000yD-NP
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAh-0004Jo-7g
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAZ-0000sH-Hq
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JeYSuq0H+8peHPSJMmoLpbQOjUcL6gucQf6bz7s5d5I=;
 b=P93v6MK5hu0KGffiAFWEj6m7G57uegjc4iWWJVYg7nQeCERis4XHbFodDJs4UVshh8wDF9
 7mw1UkOj/1Tj8QFjWfnf0r7ivvpdvKGjUG9vQATi98YH6mlmcw0vUDpK4ena0UQCp0OmEw
 BqlD1E7wUjH8hZfjkGr5s1rSH9IoWpU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-CAoYrL1zObuKU1SL7lCAqQ-1; Wed, 14 Oct 2020 11:58:24 -0400
X-MC-Unique: CAoYrL1zObuKU1SL7lCAqQ-1
Received: by mail-wr1-f69.google.com with SMTP id 47so1539516wrc.19
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JeYSuq0H+8peHPSJMmoLpbQOjUcL6gucQf6bz7s5d5I=;
 b=GHsOIzjkhO/dnTBHngNydojnIKM5Tyn5+/xyQTS73AslzRMFdfELEw1AiMTgWMGFyH
 lkjK+3E+p1olmIs7JLiLmyzGOuuNYVetkTY+zSVupeBQCSW7xNOaBg3s9pxrud94FVgl
 LHCO+C9I0RYcksEC8jLpbnkmn3jYSoCMHmFHEHR9/Et8VPkwB0FV4Cfks4WgISBrr37K
 8o8CRqesejIbynvWcEbqULgG0mseTHZz4EFZxLA05OLg1N3d/w5DpzRQnipW4Xt4RMPA
 CA/sLkrYj1xtz8x/XkQyCaPnf1ACAFi98VJTAXt7lQtyOdGz9mr48E893P1rGRyDHX+I
 Bw3Q==
X-Gm-Message-State: AOAM531pyPNuuTu1d3H1bBuaQYEU+V/y3VgVYMecLs1cE5MMAw0RlHhR
 2T2pVdpuM3c6AcZ1Ts1mSdXaMXPjZa+/joJ0rzlymUo3SF5SqI5V8BlWEFgZkAT6geIrGBsXIWt
 tbZw5q9FUUWtVMjY=
X-Received: by 2002:a1c:f417:: with SMTP id z23mr87591wma.57.1602691102846;
 Wed, 14 Oct 2020 08:58:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR60g/fSQn3Nj8owevItZNx/z8AFsCZ5ovI0u8RwaA8S/Ehr08qjvVfjbS+y0l+iyfHRazlA==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr87577wma.57.1602691102654;
 Wed, 14 Oct 2020 08:58:22 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a199sm135830wmd.8.2020.10.14.08.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:58:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/15] block/nvme: Trace nvme_poll_queue() per queue
Date: Wed, 14 Oct 2020 17:57:57 +0200
Message-Id: <20201014155810.102841-3-philmd@redhat.com>
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
index a534c61b6b6..7c253eafa7f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -585,6 +585,7 @@ static bool nvme_poll_queue(NVMeQueuePair *q)
     const size_t cqe_offset = q->cq.head * NVME_CQ_ENTRY_BYTES;
     NvmeCqe *cqe = (NvmeCqe *)&q->cq.queue[cqe_offset];
 
+    trace_nvme_poll_queue(q->s, q->index);
     /*
      * Do an early check for completions. q->lock isn't needed because
      * nvme_process_completion() only runs in the event loop thread and
@@ -633,7 +634,6 @@ static bool nvme_poll_cb(void *opaque)
     BDRVNVMeState *s = container_of(e, BDRVNVMeState,
                                     irq_notifier[MSIX_SHARED_IRQ_IDX]);
 
-    trace_nvme_poll_cb(s);
     return nvme_poll_queues(s);
 }
 
diff --git a/block/trace-events b/block/trace-events
index 0e351c3fa3d..fa50af6b6f3 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -143,7 +143,7 @@ nvme_complete_command(void *s, int index, int cid) "s %p queue %d cid %d"
 nvme_submit_command(void *s, int index, int cid) "s %p queue %d cid %d"
 nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6, int c7) "%02x %02x %02x %02x %02x %02x %02x %02x"
 nvme_handle_event(void *s) "s %p"
-nvme_poll_cb(void *s) "s %p"
+nvme_poll_queue(void *s, unsigned q_index) "s %p q #%u"
 nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, int flags, int niov) "s %p is_write %d offset %"PRId64" bytes %"PRId64" flags %d niov %d"
 nvme_write_zeroes(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offset %"PRId64" bytes %"PRId64" flags %d"
 nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
-- 
2.26.2


