Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F222C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62795206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsYMNyV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62795206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLmX-0005ZB-51
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhu-0006vM-B6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:14:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29211
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhp-0005ZT-Ci
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593544448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tuXzLILJ7FT7I+1GOee4KI1h3HYM5KlaYdYlB+vyW7M=;
 b=ZsYMNyV/J8YqlxKW9oVXhdM6Day2Q3YidvMmM249D9ClbccU0CioPLTrgDeSGHh0VZRdfF
 rT+q9iWOg0e/g5aA12zXmcT+14MUZ0+22HbCEBaPe5qChykQFL8LdD+rlt5z4LllzS0BR9
 QUfJdWqjXrkvtub8wynajwuZ5m3N0jc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-6f-JqpFcPjC8ZCriJSM0yQ-1; Tue, 30 Jun 2020 15:14:06 -0400
X-MC-Unique: 6f-JqpFcPjC8ZCriJSM0yQ-1
Received: by mail-wm1-f72.google.com with SMTP id g6so15598977wmk.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tuXzLILJ7FT7I+1GOee4KI1h3HYM5KlaYdYlB+vyW7M=;
 b=H4/OtJn7dwmPYbhbuD/JoatVqGTEkRKiTkjzN4QyV9b6jb5PU9hde3RuK1WT0wWS47
 f50W9cA0mBvsLAk/XUxKlVObkiNzbvQ2AZN1WXIsqZy8344xsVRn+0oAYH3dthYNg9p4
 rbC4z51DS37na3hmt8npjXSxUeUrrbMXPW8cOiVcvi0A45W80YTlqZ34/AzLSY2Gnd7Y
 p47OPzHpaJZB3hZhE0Tht9wnbqPZ8vkzwiV02E4/OOG+AJkWjVY/BM2GkIMoHjHBfPt8
 hkrGg0mPtp2R3/rITJzx2vkkl6cDcg7UGTH/waggUoKT6bjLNsT52IiwkJcHs8nSDeZ4
 9gOA==
X-Gm-Message-State: AOAM532ADahivjYf5YAwxHyMzJ9jiNn/aGNLhDknUciQruJV9H7zahTd
 Gy+EucNCAO4ueLEFA35CFB/TXnjgng0BwyAfMHJaYBW8pQuekptWpQyPVq8Qw5b9Pnq01kcqi9V
 gdhC2ScqbKcRMPdg=
X-Received: by 2002:a5d:664e:: with SMTP id f14mr23197623wrw.6.1593544444112; 
 Tue, 30 Jun 2020 12:14:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuuJsDa+yK4/Rkce9dWMBX06w+o1lBpOcWhfDJnvRKOmk/YZqeeGkAtA0VFdnrGuxaxZBo9w==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr23197598wrw.6.1593544443854; 
 Tue, 30 Jun 2020 12:14:03 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id s10sm4633017wme.31.2020.06.30.12.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:14:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 09/12] block/nvme: Simplify nvme_init_queue() arguments
Date: Tue, 30 Jun 2020 21:13:15 +0200
Message-Id: <20200630191318.30021-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630191318.30021-1-philmd@redhat.com>
References: <20200630191318.30021-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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

nvme_init_queue() doesn't require BlockDriverState anymore.
Replace it by BDRVNVMeState to simplify.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 8b4d957a8e..c28c08b3e3 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -165,10 +165,9 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
+static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
                             int nentries, int entry_bytes, Error **errp)
 {
-    BDRVNVMeState *s = bs->opaque;
     size_t bytes;
     int r;
 
@@ -251,14 +250,14 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
         req->prp_list_iova = prp_list_iova + i * s->page_size;
     }
 
-    nvme_init_queue(bs, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
+    nvme_init_queue(s, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto fail;
     }
     q->sq.doorbell = &s->regs->doorbells[idx * 2 * s->doorbell_scale];
 
-    nvme_init_queue(bs, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
+    nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto fail;
-- 
2.21.3


