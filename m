Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E783C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D622076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0kDhgnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D622076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4Zh-00047F-4q
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Kr-0007Ts-EI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Kn-0006sW-4R
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JwHFa3n4K0MRNvY+MTlxR5FZfku0vELlzpKB46QufT0=;
 b=J0kDhgnnPRuricAZf6foSuYBsNxfM+yo65xybsKMuntrAbanoURIHVGitS7tb4FDMrZIS3
 cywsqfewokinSEzLImoR4IK7tIMJKHafkwL+4sO30kKDjGQ7wqUZMnQSHyfX06eZR3rqD7
 guf2JCBeFyBxmjVQec47LjM5HU1y2lA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-lffEFtLRMfGxpkRHUCmckA-1; Thu, 29 Oct 2020 05:34:58 -0400
X-MC-Unique: lffEFtLRMfGxpkRHUCmckA-1
Received: by mail-ed1-f70.google.com with SMTP id h6so931805edt.12
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JwHFa3n4K0MRNvY+MTlxR5FZfku0vELlzpKB46QufT0=;
 b=dV4QgIVc+sJOLSIgtoY1p9I1QyIw8AfkaKcsZkavpnY+1381UEKcIc3HS0qHUyt5Nc
 Lo7n8i7dmVVtMrsZiUoFKxGvnimGtA7T92/4hW3F6jaHVtMogEQFtfH57b1rhBQOHVNB
 CPOlZEOi3zpxv+O9pRUHp5Asac4h5FgVUSsXPjLFsy8Vt9ITw7oxR0wXA1xKNASNLfC/
 crPoWTqb9I+WhWpK4H88yvW13AJNIk3Ti3/RexhIBr0+HmhJYSpeX1+WouXKcMKR74Fh
 nsh8PMeaQRzOIFIJDqs7n1vxM7JkYr3jDhAYw5Kw18l8FdaIO4o+TTgkVbi9QYTiZt1T
 GKQQ==
X-Gm-Message-State: AOAM5338pCKRKa+85NGK6nVkA8uUQA+s5uFxnwHnY40+RnBH/CI+mX0l
 xl5uS7RlYUE/vfY+J+0BkgeqTL/1M88dNCykN0jB+8cHpcIkmUuJqQmF7qzFsMER/1bZVOYIQkp
 4ABa6Xf3Y6gw0EkI=
X-Received: by 2002:a05:6402:141:: with SMTP id
 s1mr2886713edu.87.1603964096570; 
 Thu, 29 Oct 2020 02:34:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7QAuuOGe2dK1cCwBgfqi+eBk4CBwAgMYE63Wgmr/SVWtbmU6rBBDo3gwwXt1muWGhPX8cjA==
X-Received: by 2002:a05:6402:141:: with SMTP id
 s1mr2886692edu.87.1603964096391; 
 Thu, 29 Oct 2020 02:34:56 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m16sm1185758edj.37.2020.10.29.02.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:34:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 20/25] block/nvme: Change size and alignment of
 queue
Date: Thu, 29 Oct 2020 10:33:01 +0100
Message-Id: <20201029093306.1063879-21-philmd@redhat.com>
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

From: Eric Auger <eric.auger@redhat.com>

In preparation of 64kB host page support, let's change the size
and alignment of the queue so that the VFIO DMA MAP succeeds.
We align on the host page size.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 7628623c05a..4a8589d2d29 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -167,9 +167,9 @@ static bool nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
     size_t bytes;
     int r;
 
-    bytes = ROUND_UP(nentries * entry_bytes, s->page_size);
+    bytes = ROUND_UP(nentries * entry_bytes, qemu_real_host_page_size);
     q->head = q->tail = 0;
-    q->queue = qemu_try_memalign(s->page_size, bytes);
+    q->queue = qemu_try_memalign(qemu_real_host_page_size, bytes);
     if (!q->queue) {
         error_setg(errp, "Cannot allocate queue");
         return false;
-- 
2.26.2


