Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69418C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD320206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D21m9eqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD320206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjOZ-0004U4-Qr
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBL-0004gl-Tc
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBA-0000wg-Hy
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ajyUIBZhYcYMjtG3GzX+aV0rxCP2KwW8xZEaitynopk=;
 b=D21m9eqr2clKbHeyP9L0o3kuxmFzRr3GQ58BxdYsd9nwH3fn4GMRCXvt1RFaX7msix3Jdj
 H7mkskNjGnDVZRQWZVJDnW6z1Eq1TFrqaIl8Ydj2Ex6POiU7VaBlFvS9S3v9x0TfDl9L5E
 W/1hJm8ybFZLJ3oZl3N1Z8iBR6WnYfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-OCcVr3u4MW2-8V4jXM7wdw-1; Wed, 14 Oct 2020 11:58:54 -0400
X-MC-Unique: OCcVr3u4MW2-8V4jXM7wdw-1
Received: by mail-wm1-f69.google.com with SMTP id u207so6979wmu.4
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ajyUIBZhYcYMjtG3GzX+aV0rxCP2KwW8xZEaitynopk=;
 b=bNnui+MlhiJKGDBhPyIiOWd+6Jr8Q4Q0MbPmMxPbH3NXtuY2fuSJbdiHR94gfw9bdP
 hFEIJXy6kRCr7yVVsEjtT5z13+7v4bnMf551Uoqk2YZKOK0JawCl8Pxl7s/MV2fVBroO
 bc9HGJgJRW/IQDzWf3rt7yxxQP2SisRaDI0nvDEFL4Ik2nP3yVSwB6I7Gh9IVf9eqGT+
 PQW6gOa6FBcZnyVKEuoto4tWrWcQH5h0IBP8k1nn78g5rBPCMkc6yTHHR+Nga0WMP6SW
 j/1EQWr9WKTsBGJv956MiXrciSAErlKD5GQpje2fDLydDTbXGeNBpn9GuQICMzc1bAgr
 ZKBQ==
X-Gm-Message-State: AOAM531mpqdVGcpzt42ynQNdw8l1z/Pyxa+Mq8MQKdWIF25QfFbnf1SZ
 jayOllHka4/0ojgOdFaW9TGMObtViDyA7duWe823TPPAAmLzZI+TjcZKy9JfC/g/TvPgTB0H0vA
 1SHJjF9ofLRSC1LM=
X-Received: by 2002:a1c:2d8f:: with SMTP id t137mr137410wmt.26.1602691133190; 
 Wed, 14 Oct 2020 08:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXyQI3UJlkRk7SVnqrRiqNE3ZWWlwAPgp9jjgzAaj6Euzj4X8XBL3WnLoAJfzDmC/zX+njug==
X-Received: by 2002:a1c:2d8f:: with SMTP id t137mr137385wmt.26.1602691132884; 
 Wed, 14 Oct 2020 08:58:52 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id m12sm6058664wrs.92.2020.10.14.08.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:58:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/15] block/nvme: Pass AioContext argument to
 nvme_add_io_queue()
Date: Wed, 14 Oct 2020 17:58:03 +0200
Message-Id: <20201014155810.102841-9-philmd@redhat.com>
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

We want to get ride of the BlockDriverState pointer at some point,
so pass aio_context along.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 523814a1243..b841c5950c5 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -642,7 +642,9 @@ static bool nvme_poll_cb(void *opaque)
     return nvme_poll_queues(s);
 }
 
-static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
+/* Returns true on success, false on failure. */
+static bool nvme_add_io_queue(BlockDriverState *bs,
+                              AioContext *aio_context, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
     unsigned n = s->nr_queues;
@@ -650,8 +652,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     NvmeCmd cmd;
     unsigned queue_size = NVME_QUEUE_SIZE;
 
-    q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
-                               n, queue_size, errp);
+    q = nvme_create_queue_pair(s, aio_context, n, queue_size, errp);
     if (!q) {
         return false;
     }
@@ -805,7 +806,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
 
     /* Set up command queues. */
-    if (!nvme_add_io_queue(bs, errp)) {
+    if (!nvme_add_io_queue(bs, aio_context, errp)) {
         ret = -EIO;
     }
 out:
-- 
2.26.2


