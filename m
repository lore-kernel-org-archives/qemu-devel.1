Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB9FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1D32076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPa57C0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1D32076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4LZ-0008E6-5s
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4JW-00062D-PR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4JT-0006SF-O7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cs1C0obG4nToPrEZSg1uNXVjaS/D+BwTncjleFbCDLw=;
 b=bPa57C0/jDxvyyRIZnFb5WmL3M48Ize6sVvdGl3irDLek8o8FpE2iawWbsLE4q9RGq1zMk
 gkrfv+NR9QbP2w3G1Y5JJbAnTc3CdKOhPaRK8r9abtbIr+unMROforwz+4xfW4tyBxEEL1
 m6OsEwi4idvBp5n0fFHx7g0TKzv1XKI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-cAg8LfxcNA-oUxqRT57UPw-1; Thu, 29 Oct 2020 05:33:38 -0400
X-MC-Unique: cAg8LfxcNA-oUxqRT57UPw-1
Received: by mail-ed1-f72.google.com with SMTP id ay19so917778edb.23
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cs1C0obG4nToPrEZSg1uNXVjaS/D+BwTncjleFbCDLw=;
 b=Wu4lUL6Mn+/lvvWTC5mOLs+fFwH6aMcTtB37OxxDaXVOXWm8UlFdgcz1NgJmo5R6TS
 hwwoicJibHDx+KNDLcsI/z7RnUHkI4T1t/IZyzjwmnDBpoyOFjbH9SAbPPTHCNpgFyeF
 VtEc3DXn8cVcNkcChGUwuzqoG0WmhaJHriCAXqrqGTzU32QB+WINp0Gq4s/YCcPMZDbh
 Lm8p3IaKy3HCYAXeCzt3XCq1M9iktpFMq70l/tEWG27f6S2muDQ/GjfoKgHH+Jw+eDOR
 hmDVg35318tmTZfA0m4wGFLtmD1+9KMJh3Ik+V1Jxz2Nwxs3D5QboNhd21+IUq3+xk+J
 netA==
X-Gm-Message-State: AOAM533mhCZKgp0gzBcX+Szi1wSJJRp4RASHHVM++k0lN016VvfTT+t/
 qcDYanG0fgAh2hF4+OW15piTlBIwRlKQBxffLq0eJTaDpwzLp/Qb6Ar6OJubQTtUuQVyu8hc2mC
 wbC4m5U1hoOwju3E=
X-Received: by 2002:a17:906:1989:: with SMTP id
 g9mr1528541ejd.62.1603964016494; 
 Thu, 29 Oct 2020 02:33:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBI0FYASgwJnrVETq5oEFCOqMrX+j4zrUx/mZmzqhHhAAQ31wYwUzNeRp/NjdnFvFxuh3Xjg==
X-Received: by 2002:a17:906:1989:: with SMTP id
 g9mr1528523ejd.62.1603964016282; 
 Thu, 29 Oct 2020 02:33:36 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id d24sm1163692edq.34.2020.10.29.02.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:33:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 05/25] block/nvme: Trace nvme_poll_queue() per queue
Date: Thu, 29 Oct 2020 10:32:46 +0100
Message-Id: <20201029093306.1063879-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029093306.1063879-1-philmd@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to enable multiple queues, report the event
in each nvme_poll_queue() call, rather than once in
the callback calling nvme_poll_queues().

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
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


