Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADD1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6426204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJrusOAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6426204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nvh-00050M-Qh
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nuP-00031A-U6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nuO-0006CY-Bx
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KbIetA1xjsM5ok0/Mv80e7mGjv4Ge5UwAtigSYtZimQ=;
 b=dJrusOAzkyM/PL3nr5u3hWpqyHng2qL98SQiXJ28TTPM2JSc7thiEBqdtCiWnO5o/mr69L
 QNB4LTWdg8VTLXqHM2QAptPj23jJvGYkrVh0aS47ddxAZMWN1MlFqOnJyTNRaIbcJEdOzo
 TZmyCFFL824SX/O6PdPF6FEmy0Ll9JM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-Q_UtJ66KNHS6glteT6tsmg-1; Thu, 20 Aug 2020 12:59:21 -0400
X-MC-Unique: Q_UtJ66KNHS6glteT6tsmg-1
Received: by mail-wm1-f72.google.com with SMTP id q15so997906wmj.6
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KbIetA1xjsM5ok0/Mv80e7mGjv4Ge5UwAtigSYtZimQ=;
 b=lCh7beFyijgMP1MpUFGwBWYvCmyoGp3QmH9U5zGdFRDYLlGR04RvR0o+aZLoLXsgxu
 icxhJpZhIk9Kx4uB1LEWuTec86firw3fEMciJYkv27+GbiVGktRXZqM70LuRCjUD0YOU
 5+Om599yqhXxid4JgKznl74Hn6LHZR3IQGec5dfo0HC1HKQ1IrukhC+BGaqQEF0v39e9
 7hcGCLW1HkzwGoZjs59IgVWMf/ivh5FhJRa03CwEEdM5QHFHOjc/VPNuhZPYQarq3ovK
 MVJBtRxmStbGNC6jem8Kr1xPZp64VhHKFwaV3JShaoGWEpK/oN6U0hEay2ditFlQsnon
 aHHw==
X-Gm-Message-State: AOAM5338X9xKANij5JdS6VTzMxjeuSOaf7mWOPLvwVvzSvxHCAQPtabh
 P8HIlbIgXFfbxCMXVWKIE5E71wsO7ptnRDBvXW9yT5frDi+o7ltSehug8iEdSzdolErXpUcaYFg
 oEKoSHLL/duPiUQw=
X-Received: by 2002:a1c:e0d7:: with SMTP id x206mr4705432wmg.91.1597942759905; 
 Thu, 20 Aug 2020 09:59:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfhuXkork9oCk1z5RQZ1T4jotPzmNRJLdwynYwdl8g2pK77ZGpr5Q92AuP+5OB99ZYNQix/Q==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206mr4705415wmg.91.1597942759770; 
 Thu, 20 Aug 2020 09:59:19 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v12sm5191196wri.47.2020.08.20.09.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 09:59:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/15] block/nvme: Let nvme_create_queue_pair() fail
 gracefully
Date: Thu, 20 Aug 2020 18:58:49 +0200
Message-Id: <20200820165901.1139109-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820165901.1139109-1-philmd@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As nvme_create_queue_pair() is allowed to fail, replace the
alloc() calls by try_alloc() to avoid aborting QEMU.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 8c30a5fee28..e1893b4e792 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -213,14 +213,22 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
     int i, r;
     BDRVNVMeState *s = bs->opaque;
     Error *local_err = NULL;
-    NVMeQueuePair *q = g_new0(NVMeQueuePair, 1);
+    NVMeQueuePair *q;
     uint64_t prp_list_iova;
 
+    q = g_try_new0(NVMeQueuePair, 1);
+    if (!q) {
+        return NULL;
+    }
+    q->prp_list_pages = qemu_try_blockalign0(bs,
+                                          s->page_size * NVME_QUEUE_SIZE);
+    if (!q->prp_list_pages) {
+        goto fail;
+    }
     qemu_mutex_init(&q->lock);
     q->s = s;
     q->index = idx;
     qemu_co_queue_init(&q->free_req_queue);
-    q->prp_list_pages = qemu_blockalign0(bs, s->page_size * NVME_NUM_REQS);
     q->completion_bh = aio_bh_new(bdrv_get_aio_context(bs),
                                   nvme_process_completion_bh, q);
     r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
-- 
2.26.2


