Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88A6C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD421214DB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj61B2PX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD421214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrpmi-0005kb-UD
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpki-0002LY-5k
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24948
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpke-0003yx-Dv
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KdE6JsIw8dAhfeVIz93JjPSKDmry/14DEkZ0JE7PkKI=;
 b=Bj61B2PXYnELutvjATNHou5qAYUymd9F/+Wz0U+iT3Hoo+oGCYIEis9YwjrRC660xZqgwJ
 Ejb9ShEJXxYJSUnk3JNdxR50Bm8ImXvvfMsAqU8OBGEZDrgmoV81rTtfwHs6KlZ0FD6fQg
 27HyJis2aXfueRwDsGX9OXP9xFEWbxE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-lzGuhFVhNTKBxzivTKyPpg-1; Sat, 04 Jul 2020 17:31:09 -0400
X-MC-Unique: lzGuhFVhNTKBxzivTKyPpg-1
Received: by mail-wm1-f70.google.com with SMTP id g6so34941125wmk.4
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KdE6JsIw8dAhfeVIz93JjPSKDmry/14DEkZ0JE7PkKI=;
 b=R9VeSymSJy59j3/UVafR1NCStCnpC13B+f4YhwoxcfvZG0+RQ6vmkEl0pHufr4iCND
 Pg8mXzGjh+XpqPsDo8L130XhLQ2wsxpEW4H6jP/SfaRBNHXKETFubd9KmTPbcMnsrltp
 6i6T2HhSZKr8C4sINMOuDD5mIgYY7hh4qAlt9pWIYdOQBMZ74EES1BdPl/sVkY+g5VmG
 0Xn8B2AoJJDb0bIYZIQ9zuX9hQzng9X+lz9GVJjfwO0RGWAG0JJcxrWh92gMkn60QkoQ
 O28/l9Oh2YPp+7a+IGQ6qL3/z8h4D1Fks0r/1jeTjbg6wBrO4THbLxZSOmvR/sJ7xwwN
 ZrBg==
X-Gm-Message-State: AOAM531uuDguS2JWBWYMgDo8MYVVV0zo/QVsw9T6FZyO/cmijAFyHLvO
 VzUg6324LSo4+gO1tNZFQyIiqRynqBwrOuCXaSpKE7xgNtRTHQyxNDM3O6E7OKOARck9WzaAmni
 4vtcaJFseyw70qeY=
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr42060947wrw.197.1593898268461; 
 Sat, 04 Jul 2020 14:31:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9Y4R53C3Xdv4shoYf5J4ZzSJabEiVfoOQrOIWG5F0SfS5JkNTuZL3roDMpmGjvGfWPxiMHQ==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr42060934wrw.197.1593898268303; 
 Sat, 04 Jul 2020 14:31:08 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id a3sm16953570wmb.7.2020.07.04.14.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:31:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 03/16] block/nvme: Let nvme_create_queue_pair() fail
 gracefully
Date: Sat,  4 Jul 2020 23:30:38 +0200
Message-Id: <20200704213051.19749-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704213051.19749-1-philmd@redhat.com>
References: <20200704213051.19749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 17:30:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
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
index 8c30a5fee2..e1893b4e79 100644
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
2.21.3


