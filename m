Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF3C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B782076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/QtvrlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B782076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4c3-0005xz-Mi
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Ku-0007Vi-3F
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Kp-0006sm-6p
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubWiemzbTn6vqYXI00YAYHXkMl8cmZxlbdS4QE+huSY=;
 b=N/QtvrlERwoLZ5nrtTQzX3FUfs6LlYu8bGVLfKEUFNB+X4ROKcl1kBCzbo4PgKW42dw0mt
 0LOz0QoonNrMDGEP0hezE0aV74/hrQGD7b0zDLCh2YCnVQdJ1sP2Yb21wgL2Lsbq/ceJ5B
 SUROrybT1558h4HvsS+qwMStijBv4a0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-cEItcgB9MRWL25b4t9mjNA-1; Thu, 29 Oct 2020 05:35:03 -0400
X-MC-Unique: cEItcgB9MRWL25b4t9mjNA-1
Received: by mail-ej1-f72.google.com with SMTP id p18so939670ejl.14
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ubWiemzbTn6vqYXI00YAYHXkMl8cmZxlbdS4QE+huSY=;
 b=NAphbz4z0F1o4XCV/wF9BESVOZwLPbd329v4MepTrLZ3nV8NSVuOWy4mgwCcH5aFmj
 nvouQ/nuVhWxXHXUdTxh70mZlhGa5hlMyaqlC5wmrM4INB1JwL6HR56ehfee+YDYvmKE
 Gvs1bQ7iJO07nM5T2zU5jlzXBHR1KrxfLwUl4KoU6MbVepOdC8z8l5DZAhvqLgVdp+Ts
 EnU6FW/EiuYcAiuh7xSrikeQ9iIB/TEJtPgkokKNaZpnIjDlEXMOO1Fhl+UM98MkpIMO
 LgMxigcni+P0yWBbzWA/UaxuP4CArZbqH66WOEMhy/KynrLwoWfksvdQrbCNz01CPO7I
 5MJw==
X-Gm-Message-State: AOAM532HJddz/UWSrQlLFkt0uaqtEZlF83hPmGPYj8sGWQAgdv+vpRPO
 KhzrP1zyn//5z5rDQ2M+fH6zoy67fxqorvd7uLSDh9dOabYuUbpSmrE2JxoKz/ObmZmGmvjUURD
 XXP0tmdGCLNZUoks=
X-Received: by 2002:a50:e705:: with SMTP id a5mr3025233edn.29.1603964101963;
 Thu, 29 Oct 2020 02:35:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj7AU9r302XYl0o0JrbIYdM6n4Tgtrrcvc5eHp/Ce/n3dgfajSbx0/WUJb1zx5rdqTrrQNUw==
X-Received: by 2002:a50:e705:: with SMTP id a5mr3025225edn.29.1603964101828;
 Thu, 29 Oct 2020 02:35:01 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f13sm1145307ejf.42.2020.10.29.02.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:35:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 21/25] block/nvme: Change size and alignment of
 prp_list_pages
Date: Thu, 29 Oct 2020 10:33:02 +0100
Message-Id: <20201029093306.1063879-22-philmd@redhat.com>
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

From: Eric Auger <eric.auger@redhat.com>

In preparation of 64kB host page support, let's change the size
and alignment of the prp_list_pages so that the VFIO DMA MAP succeeds
with 64kB host page size. We align on the host page size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 4a8589d2d29..e807dd56dfe 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -215,6 +215,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
     int i, r;
     NVMeQueuePair *q;
     uint64_t prp_list_iova;
+    size_t bytes;
 
     q = g_try_new0(NVMeQueuePair, 1);
     if (!q) {
@@ -222,19 +223,19 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
     }
     trace_nvme_create_queue_pair(idx, q, size, aio_context,
                                  event_notifier_get_fd(s->irq_notifier));
-    q->prp_list_pages = qemu_try_memalign(s->page_size,
-                                          s->page_size * NVME_NUM_REQS);
+    bytes = QEMU_ALIGN_UP(s->page_size * NVME_NUM_REQS,
+                          qemu_real_host_page_size);
+    q->prp_list_pages = qemu_try_memalign(qemu_real_host_page_size, bytes);
     if (!q->prp_list_pages) {
         goto fail;
     }
-    memset(q->prp_list_pages, 0, s->page_size * NVME_NUM_REQS);
+    memset(q->prp_list_pages, 0, bytes);
     qemu_mutex_init(&q->lock);
     q->s = s;
     q->index = idx;
     qemu_co_queue_init(&q->free_req_queue);
     q->completion_bh = aio_bh_new(aio_context, nvme_process_completion_bh, q);
-    r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
-                          s->page_size * NVME_NUM_REQS,
+    r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages, bytes,
                           false, &prp_list_iova);
     if (r) {
         goto fail;
-- 
2.26.2


