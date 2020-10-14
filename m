Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A645214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZ15a+h7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A645214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjGr-0000pn-8J
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAr-0004Oz-TE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAk-0000uP-Tv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfEKR3p99JyOaZvgGZWXrkDwRPOMspGtYOhIXhe9jTI=;
 b=bZ15a+h7aFwzAdxTRHUionGjE4E5DBQ0wUHOoLbm8WP090E6UZU6D0lqZC+dgmKlfB/5+z
 Ukfmryn70Hg9dMjkT+rtmOD2UpcvD22QpXnMMkTxU1nnGChbrFs4kug6Bh5eD5OFg0gcLL
 L1C3d8Ua5wlRD/PQyVf3MJIogmtf8eM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-YereZKAiPf6NgzvlQRIDGA-1; Wed, 14 Oct 2020 11:58:34 -0400
X-MC-Unique: YereZKAiPf6NgzvlQRIDGA-1
Received: by mail-wm1-f69.google.com with SMTP id f26so39035wml.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zfEKR3p99JyOaZvgGZWXrkDwRPOMspGtYOhIXhe9jTI=;
 b=e3IS1C/2LUCPWtw3cB7kp0Yx6QSamsWMoIdXA/ptfcn+uK9dO8VcXYLqeIGtTw8CCv
 grfwEtt+7vGRNt9CLXZaD1RKy2w3NVqAV3zUTyAXTt36HRW9fiamYQxNV1XJf7GS6rIX
 hkCm2U6ViYUhroBBHzUpWoyLR6FyWqLzY0F3SXDExdkSgXpHkAkmdsebBm+r0aLaHFXQ
 W8gMoyQn/HHqnn0Ym5PLbwhH3mMy5ECEk4Z6RGFLSqxEceMqBtpG1OPUpONfgAhD2iQT
 rNX4kbfkKjkzin0Dv9ZxyQucP3UFjaq3vwgGpoqbvIHVtQlJoXazmQq6E8cv4tg/B9ei
 PPnw==
X-Gm-Message-State: AOAM5328NGBBNMNSULNt/iS8bOftg9thrkx6myu970+9U/w+igYnN7Qs
 kWMVKn3X/WMknrf8nDqKZNOkWrrfOpJgWdaUAxshpcvd4l95p0hBDOWNh3ujJzT8HU+DWoKS068
 GbTaWyT+4uxEjucI=
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr67115wme.153.1602691113182; 
 Wed, 14 Oct 2020 08:58:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+wzLSNx1WXbyrQnSXUZ/Fm8q0mCBza+O54nO/s2n807EFJcwLeA/naZ07D8S1HRzw1rzTaA==
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr67095wme.153.1602691113017; 
 Wed, 14 Oct 2020 08:58:33 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a3sm54032wmb.46.2020.10.14.08.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:58:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/15] block/nvme: Improve nvme_free_req_queue_wait() trace
 information
Date: Wed, 14 Oct 2020 17:57:59 +0200
Message-Id: <20201014155810.102841-5-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

What we want to trace is the block driver state and the queue index.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 2 +-
 block/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index d84206b598d..e9410f2e0eb 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -286,7 +286,7 @@ static NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)
 
     while (q->free_req_head == -1) {
         if (qemu_in_coroutine()) {
-            trace_nvme_free_req_queue_wait(q);
+            trace_nvme_free_req_queue_wait(q->s, q->index);
             qemu_co_queue_wait(&q->free_req_queue, &q->lock);
         } else {
             qemu_mutex_unlock(&q->lock);
diff --git a/block/trace-events b/block/trace-events
index 3bb5a238601..410789188cc 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -152,7 +152,7 @@ nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s
 nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset %"PRId64" bytes %"PRId64""
 nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset %"PRId64" bytes %"PRId64" ret %d"
 nvme_dma_map_flush(void *s) "s %p"
-nvme_free_req_queue_wait(void *q) "q %p"
+nvme_free_req_queue_wait(void *s, unsigned q_index) "s %p q #%u"
 nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
 nvme_cmd_map_qiov_pages(void *s, int i, uint64_t page) "s %p page[%d] 0x%"PRIx64
 nvme_cmd_map_qiov_iov(void *s, int i, void *page, int pages) "s %p iov[%d] %p pages %d"
-- 
2.26.2


