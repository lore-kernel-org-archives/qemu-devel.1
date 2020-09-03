Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BDAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29D920639
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibyWX22c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29D920639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoQ7-00057R-6C
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLr-00082Z-1K
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLn-0007oX-GI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTj5ygyvl3m9X8aG/OG5RYyWnVD4Y1B5IoiAdEvQLwI=;
 b=ibyWX22cTGDGjhcbJFsD+QSRXysy7FG1eXrVIk5ZsufNErqi3wtq+FD7ZoO8plBMdFF5PB
 v+2zVFHO4BSAUBnvS32yOEjHmzGZNyt6PW71nWCzs3IXexmEAEj1MljXh3kDeWyBUmuf6K
 Aa5+hgA61v+zrrYUU6Hazcc4ta+qXL8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-2ofADi2CN8q5gzvL5BVIyw-1; Thu, 03 Sep 2020 08:28:21 -0400
X-MC-Unique: 2ofADi2CN8q5gzvL5BVIyw-1
Received: by mail-wr1-f72.google.com with SMTP id r16so1008802wrm.18
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TTj5ygyvl3m9X8aG/OG5RYyWnVD4Y1B5IoiAdEvQLwI=;
 b=NwoEzlVvyN74l9bJTBIpwqfLYweayml0ucJr57Gdg9mafa9O0rt7SXcAX8GCHl/5kk
 lSwSJGgcpkDR7kmyVPI0SBPAhaAVLt2s/SqiMlCrezdChd077bNlbsIs463fWUctVyQR
 /dBgDE4KL48eICz49jFvpwrxG0ATxzF0nuKB8z1EM/yvZOq/HDcYFjW80Hk5rWzSNHCF
 KBdzZo8e/TsH4TSspCk0Zqtw0gGBlPwReG62ndPoKoAjp+12CfF3IJSEc4ql2oA2Sr/J
 iAr03LaYbDNNKVwTd23Xet2Yv/C9KSmZICcPe2Lqsu/c7ii3j9iFibP4l83a0ltPH/St
 Fv3g==
X-Gm-Message-State: AOAM532NeIo8ux2OR5TY9cAg3KW5Q+UIGBWsr8YK76SKdK3BLn1Asslg
 XH2DDAhTb3uWeYFLyuRTN4Ls1qzfJR1Js7+EEEUmjMwgWoUSnN4Q1xZROvov78csiFPMuPyfAn1
 bK7lhdR9Jsg46aE4=
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr2357962wrx.16.1599136100147; 
 Thu, 03 Sep 2020 05:28:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6TjWq2xPKpms8KeArySKub5jzPn0mKbR3uB3ouuy30yqVmvG0PwgipO5rYv7AaDwkLgFDSg==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr2357944wrx.16.1599136099996; 
 Thu, 03 Sep 2020 05:28:19 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id j7sm4496117wrw.35.2020.09.03.05.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/15] block/nvme: Let nvme_create_queue_pair() fail
 gracefully
Date: Thu,  3 Sep 2020 14:27:51 +0200
Message-Id: <20200903122803.405265-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As nvme_create_queue_pair() is allowed to fail, replace the
alloc() calls by try_alloc() to avoid aborting QEMU.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 4d4f728159f..ca8b039f4f0 100644
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
+                                          s->page_size * NVME_NUM_REQS);
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


