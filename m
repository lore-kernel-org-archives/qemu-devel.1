Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7884C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B374021D94
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfYwEaet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B374021D94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrptu-0001YP-0v
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrplM-0003V4-OO
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrplK-00046K-QI
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjFAluXrQqAea6BsNgoNTAhItzpMDbo69v4ixXnRHEQ=;
 b=JfYwEaetH3XIhqFXKCm4CEhz2A/l778Rtye6VaGqubwY4T+IpZSm0337O+P0a7+OR6uVL/
 sN9fA9wJXYhno7MPHBmdStdelf/TcBg+wFr66V/PqG7SYgWMAUIhM14VwbIJceVDFNxRap
 uLadSd9Z0XFtyvaY68GdNpQlHW5IOfc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-8pt5tpVTPsWRYZiJbO_FgA-1; Sat, 04 Jul 2020 17:31:52 -0400
X-MC-Unique: 8pt5tpVTPsWRYZiJbO_FgA-1
Received: by mail-wm1-f71.google.com with SMTP id q20so30917390wme.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fjFAluXrQqAea6BsNgoNTAhItzpMDbo69v4ixXnRHEQ=;
 b=JzwCDA/PREiOg6gHL54aoWEBgY6WkIt4mLWPfDwdpIhC1eT1qNoa+XgQWGEptVgBkn
 caBtAwW/PhdPK9IEOUteJxrQt2c8bcOlgxhN5gtK071FfKg0yNZnhWn87YVWeiWxTzMV
 YDdpp61eEaVm7JlS4D3TUdoSFelAXrrA0+Q2rvbu89PGXI6Phg7FcCkWa0j0PVoKcqhz
 23ESA3mTfwa+UXY0TMddW32JyRwfHMpnQ3wqoH6oZ5zw/AxiEhbCQC2FQolSXku4eu9V
 2bPf7UxTH0mA4Cd6SyKF8u8BMWGvisGedK2wkbZnaFY1+9g/AVYv4smuZdPa26lSkllT
 Av2Q==
X-Gm-Message-State: AOAM533kf4/yjFYvhGM8XyEYNNyGY0Tjod0eQYJ7vLZCBo1Dp82RPITo
 BImtVVuvM4JAOMtcz2wrJlpX2ZL3YSTCKRtwYPLhXWlZVirASY71ARX7kIy1VWv0C9u90pSrO56
 Rx0edVFkbUKWCPoA=
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr42249671wrm.193.1593898311362; 
 Sat, 04 Jul 2020 14:31:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvWqZHzCKVvifJ1cJkVaeiIH7gEBjXxL1cg/jMobS3d3kg7cql7XpyTdnxGwx42AD3CRsy7w==
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr42249660wrm.193.1593898311167; 
 Sat, 04 Jul 2020 14:31:51 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p17sm16980699wma.47.2020.07.04.14.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:31:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 12/16] block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
Date: Sat,  4 Jul 2020 23:30:47 +0200
Message-Id: <20200704213051.19749-13-philmd@redhat.com>
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

BDRV_POLL_WHILE() is defined as:

  #define BDRV_POLL_WHILE(bs, cond) ({          \
      BlockDriverState *bs_ = (bs);             \
      AIO_WAIT_WHILE(bdrv_get_aio_context(bs_), \
                     cond); })

As we will remove the BlockDriverState use in the next commit,
start by using the exploded version of BDRV_POLL_WHILE().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 97a63be9d8..b2fc3c300a 100644
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
2.21.3


