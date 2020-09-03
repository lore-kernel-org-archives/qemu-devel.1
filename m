Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A85C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B2C206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSzz1+0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B2C206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoO6-0002Yb-0h
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMY-0000lr-8l
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMV-0007ta-S4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bI0r63FdmYwhNblRvmKN2aGqhdP0Y0JOEVbpUaFc+z8=;
 b=WSzz1+0NNmFNYh42lWpc14h2tiAPow7HOYbQJIyq29SB4tx8pkkv32ln0AXy1xc4Z2c+9s
 LXe/vQcrdAMnzA84VIgJgLJJiEtb8/G5kEse/mSk0hUg4Yu+fmC9qZZ5QP48OPejJ9bMH/
 FD59J5uDGOSqLrqa/0wwvK6NHRwsTrg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-Va5I14IaObabuywpMjG70g-1; Thu, 03 Sep 2020 08:29:05 -0400
X-MC-Unique: Va5I14IaObabuywpMjG70g-1
Received: by mail-wm1-f71.google.com with SMTP id d5so915495wmb.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bI0r63FdmYwhNblRvmKN2aGqhdP0Y0JOEVbpUaFc+z8=;
 b=RBR7C9sfytyKfQewXDUb/0rQeKSvINViyJNSb5h1/T3hXODYvNoI8BbUXH0ApiS/uG
 lsnBF9Zf7D4Eao2vcFcJklO5qNdljPtTRLNlqZiwQLL6vzWigeU2498TrR3zz0uXZil8
 L0D291fWpxM1rMWsgUykL16IObKGUdgqLAkAFtHk7d8NE5yrmI1fpwyAcZDSqb/nTcWA
 FsETcCquqB4acnQd3uLoi2XtQ88wDOFAVkhpc7xR3GyjgPM7/J7G1E3+lhHjkWGejAUT
 7VUNOJri4hG+2pri6Gwjz70opXKK0rxJC0PCRpvNkMtdl1ahPopbijwf6NYqlAiJdPnE
 eSpA==
X-Gm-Message-State: AOAM532HRtAutC9yfPxsRmNgm/VT8cXmJVnrxpqR8SdmaVj8YE9RwFVU
 +ouhbxAUzPwBoV/nXUi43X2dqaI2ieHDVUVsyDzkJfNuS99yYkSYu6Ju3h6KJntbRjBA3pSeqLX
 oKO6SjN+cpZsEKc4=
X-Received: by 2002:adf:db8b:: with SMTP id u11mr2324784wri.143.1599136144279; 
 Thu, 03 Sep 2020 05:29:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3bP8rcDPxsSDvpTH3+9l4mfbHBSy4lu4/3lw6Lgqy/8W+o/PZz+GYuTalcxE+st4zRRuQdw==
X-Received: by 2002:adf:db8b:: with SMTP id u11mr2324752wri.143.1599136144061; 
 Thu, 03 Sep 2020 05:29:04 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id g143sm3894220wme.0.2020.09.03.05.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:29:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/15] block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
Date: Thu,  3 Sep 2020 14:28:00 +0200
Message-Id: <20200903122803.405265-13-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BDRV_POLL_WHILE() is defined as:

  #define BDRV_POLL_WHILE(bs, cond) ({          \
      BlockDriverState *bs_ = (bs);             \
      AIO_WAIT_WHILE(bdrv_get_aio_context(bs_), \
                     cond); })

As we will remove the BlockDriverState use in the next commit,
start by using the exploded version of BDRV_POLL_WHILE().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index e04e1fa4f8f..b03735129d3 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -493,6 +493,7 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
 static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
                          NvmeCmd *cmd)
 {
+    AioContext *aio_context = bdrv_get_aio_context(bs);
     NVMeRequest *req;
     int ret = -EINPROGRESS;
     req = nvme_get_free_req(q);
@@ -501,7 +502,7 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
     }
     nvme_submit_command(q, req, cmd, nvme_cmd_sync_cb, &ret);
 
-    BDRV_POLL_WHILE(bs, ret == -EINPROGRESS);
+    AIO_WAIT_WHILE(aio_context, ret == -EINPROGRESS);
     return ret;
 }
 
-- 
2.26.2


