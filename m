Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98301C5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2554C20780
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjWp7+x1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2554C20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPxf-0006vr-5j
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTj-0003jD-93
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTg-0004RY-KO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGK/umoqvEVmk3LcqzdY5SU63Dd+Fo+4ZtG1Gj+fyHI=;
 b=MjWp7+x11wSvEcErzoIDnRcHEf2PhiExa1KxynIcwAIo1ohheR4fgnFwqAOgMREEjWZSza
 TytHfJH1msXIB3tRz3rSZDT21K9zG+QcDnrQ5hO8F1QjviZM6NVaHVC6Wn/AdMxEf3eim3
 MVPSa/Wm4D4pUYRSjLJdnIIPo94Gsaw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-bdVmj3FXMnSBtHYSveEvVg-1; Tue, 27 Oct 2020 09:57:29 -0400
X-MC-Unique: bdVmj3FXMnSBtHYSveEvVg-1
Received: by mail-ej1-f72.google.com with SMTP id k13so887590ejv.16
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oGK/umoqvEVmk3LcqzdY5SU63Dd+Fo+4ZtG1Gj+fyHI=;
 b=hulVUJYCAwksTyWiBokXtnY7Ke4BURPTVDMid/8/G8Ho8cQq8lG3hsVoix9XoklhM6
 oPM5qWBM332W+jAEao0+/AfzqUUs2oA1KPUuY5rjo0qiWrIln6kI+YHQHWCS3pTswy1S
 jMw07Kq6SWClfx38e9L27r4ZLQHy5gfe8LctpGYqTZTV1J8gjNacgLZA49fFA2Iti/Nk
 dvuidMnlEbNgCUpr0YUndOIpkeniL489gRjj6Bmkx+1yhu3c81+XGQa8dKht0lVe1J2u
 CJZEksWzyKJhQBdrUX+MhszAGbHNK2/zLGLUJBQ4xJhUlmRFgyF3bSEw/zALL8Krhvxa
 3/+g==
X-Gm-Message-State: AOAM530uXM9fbRw466VgMgk+pIIuGRvVo6qndXACO0kLrO4oEM4o7yt0
 L1IL5scIkqdTSgvZDStgFvj+XVxyG+qFuJrj6Ne7bFgeTPGkfrM/XI/oGY22sQhWwzajk9QU39N
 uclFiQ56sOn06JHU=
X-Received: by 2002:a17:906:3ada:: with SMTP id
 z26mr2461486ejd.151.1603807047369; 
 Tue, 27 Oct 2020 06:57:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyV+jsEMmmEP/BWFkxrP+/T2dCU1LikRGHKy/1nEwyG2qg7rEFxcSyZDKqJQ4+aSv8SKq5i9w==
X-Received: by 2002:a17:906:3ada:: with SMTP id
 z26mr2461463ejd.151.1603807047135; 
 Tue, 27 Oct 2020 06:57:27 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id n10sm1015864edo.55.2020.10.27.06.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:57:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/25] block/nvme: Pass AioContext argument to
 nvme_add_io_queue()
Date: Tue, 27 Oct 2020 14:55:40 +0100
Message-Id: <20201027135547.374946-19-philmd@redhat.com>
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to get ride of the BlockDriverState pointer at some point,
so pass aio_context along.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 68f0c3f7959..a0871fc2a81 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -644,7 +644,9 @@ static void nvme_handle_event(EventNotifier *n)
     nvme_poll_queues(s);
 }
 
-static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
+/* Returns true on success, false on failure. */
+static bool nvme_add_io_queue(BlockDriverState *bs,
+                              AioContext *aio_context, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
     unsigned n = s->queue_count;
@@ -653,8 +655,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     unsigned queue_size = NVME_QUEUE_SIZE;
 
     assert(n <= UINT16_MAX);
-    q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
-                               n, queue_size, errp);
+    q = nvme_create_queue_pair(s, aio_context, n, queue_size, errp);
     if (!q) {
         return false;
     }
@@ -830,7 +831,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
 
     /* Set up command queues. */
-    if (!nvme_add_io_queue(bs, errp)) {
+    if (!nvme_add_io_queue(bs, aio_context, errp)) {
         ret = -EIO;
     }
 out:
-- 
2.26.2


