Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC99FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F252076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7cDZZdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F252076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4Us-0005vY-0o
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4KJ-00078q-Jo
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4KH-0006iR-Sa
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aD6wOmxyFdCPV49Ruw6nu+GcSa7FrFcv+dDSPChtcUc=;
 b=E7cDZZdEqBtdvmhxy/0xngaGQghmmL6PBsSI0DXuh8gJe+wYlabvtTyTaEt2XSvFROFb43
 cdVgIv/sun03VLKnzwSnLJIWoS1+RlWwdlgjlrk3NDNWMuZVkO3R/OK22r37XkcJL7V+BR
 93GndoWN+ywTiN4T0EiS8xqjCAInj7c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-dP4ZnUFeMYSj6RL_EqrjkA-1; Thu, 29 Oct 2020 05:34:31 -0400
X-MC-Unique: dP4ZnUFeMYSj6RL_EqrjkA-1
Received: by mail-ej1-f69.google.com with SMTP id z9so937586ejg.10
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aD6wOmxyFdCPV49Ruw6nu+GcSa7FrFcv+dDSPChtcUc=;
 b=s6U0XQjGj2T6vDUxy+5rbjXy6C2VzPqTWPSB+OXe0BSrLuZnZJvUSnMIE1ge8YiIl0
 VILxRc4U+Zt7pC43hVN6Hr1njIeCN6d0euo8AyhSCnveJ6KcEf3oJ8HXveLtXDBHlXd+
 DfseNHAvynLsWVxi1L06/r11nHoRSbmlRszscWcQQ7yZ+KiKJQ+v66L0fEvawpQXCy7+
 1F/o531rx3dzCvnOgnD3fPF6HlqBOsJ6aEfqe92R5GrKLdohrl1B/0zF/frDhHRXe1cO
 sm0BS24lpzCa908JZEm41mOeYV0Fiwz6PFJKZqysXXgY7ugOXkBVV3iWrMr4EQ56IcEq
 G/Qg==
X-Gm-Message-State: AOAM531CDLlYrrVp2ap3CE9cYr8UUO3+eCqwiwaMC/qem0aQLgT1nJDz
 ITd6FTj21nQqmz3HW1KYxNFvHPB4g/5oqlLqyyE15eGCp7Mv6LnZ5KO8cWGv2MeNk7bu7cjqO6e
 oCHzLh+j14RDKteo=
X-Received: by 2002:aa7:d690:: with SMTP id d16mr58180edr.329.1603964069879;
 Thu, 29 Oct 2020 02:34:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3DhRtBm+GvI0yKAKWEkk39Y/cLInIsq1r9fw+4b+rgY9MXGQl6MTc6JoOv5dc7NmbuD9zgQ==
X-Received: by 2002:aa7:d690:: with SMTP id d16mr58160edr.329.1603964069720;
 Thu, 29 Oct 2020 02:34:29 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f13sm1144515ejf.42.2020.10.29.02.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:34:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 15/25] block/nvme: Simplify ADMIN queue access
Date: Thu, 29 Oct 2020 10:32:56 +0100
Message-Id: <20201029093306.1063879-16-philmd@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to dereference from BDRVNVMeState each time.
Use a NVMeQueuePair pointer on the admin queue.
The nvme_init() becomes easier to review, matching the style
of nvme_add_io_queue().

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 0902aa55428..eed12f4933c 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -700,6 +700,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                      Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
+    NVMeQueuePair *q;
     AioContext *aio_context = bdrv_get_aio_context(bs);
     int ret;
     uint64_t cap;
@@ -781,19 +782,18 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
-    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
-                                                          NVME_QUEUE_SIZE,
-                                                          errp);
-    if (!s->queues[INDEX_ADMIN]) {
+    q = nvme_create_queue_pair(s, aio_context, 0, NVME_QUEUE_SIZE, errp);
+    if (!q) {
         ret = -EINVAL;
         goto out;
     }
+    s->queues[INDEX_ADMIN] = q;
     s->queue_count = 1;
     QEMU_BUILD_BUG_ON((NVME_QUEUE_SIZE - 1) & 0xF000);
     regs->aqa = cpu_to_le32(((NVME_QUEUE_SIZE - 1) << AQA_ACQS_SHIFT) |
                             ((NVME_QUEUE_SIZE - 1) << AQA_ASQS_SHIFT));
-    regs->asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
-    regs->acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
+    regs->asq = cpu_to_le64(q->sq.iova);
+    regs->acq = cpu_to_le64(q->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
     regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
-- 
2.26.2


