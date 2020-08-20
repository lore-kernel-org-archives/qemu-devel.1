Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8133C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499C3208A9
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT9RmzTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499C3208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8o2I-0000EM-FE
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nvB-00050o-Fw
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:00:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nv9-0006Jv-1S
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJf25gsH+6Qwxz9ynms3bXAs8zm6lq5Rrdtx+rf3EyY=;
 b=bT9RmzTwIUn8kNmKvbTEop1B+2sn0vAWQXoOBkgiReRqogJmXPO4wr/JcJysL+QOpKOxfp
 QEirCu7LNMTxitjjzpM8qBJWt5+nGmyOqTc0FjWoEUsfVX/6TtxVZwCoGvbq/+0zy2K8AF
 hNXnPgSKF5rrmWldBivRzuL6dmh8NKU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-9RUehUs7OdCAlbXHudOKNQ-1; Thu, 20 Aug 2020 13:00:09 -0400
X-MC-Unique: 9RUehUs7OdCAlbXHudOKNQ-1
Received: by mail-wm1-f71.google.com with SMTP id h7so998961wmm.7
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HJf25gsH+6Qwxz9ynms3bXAs8zm6lq5Rrdtx+rf3EyY=;
 b=Bufo5SSD8Lgthk8pNO8CLyEFR4QPNgLBdZEMlN4PUMegepyzAPDU5LmMgoJVBb2kNk
 1zAfPJDL7xtjE1hNxIcCvqD2IQVhtcZUblh8Zp0dkOKIItKlws0ldrGbcFu9TYRKetlH
 LGRtfTCAtOvRNp5huMlJ2v1VTlrJnLPDVbZXC1nXssjIQkPtNN30BYHDTOAUi1gF2zGX
 Dejpz4HKIS4PVCbIx9bGMCTHv6hjboypblAm3yVbyDtkkjMAqEU/rcsYT/y6Jb2aP9FD
 ckxDuK774xpx9gn9Dzi6J5wKAtb0X49W+aXoy4srpMWfxc9Yq5Tmpk3vJcCGD2l0C039
 KBxA==
X-Gm-Message-State: AOAM530LKRurGKVe5MmuvZ9yRz31qC6MPK5LMbg66ONlSZxgnq1CR7I3
 Q0AGaqSzOn8PKkj/HtQQXtKqLhAGimIJAOkYGGGrqxxya6S0ONCed/DCdcAFNsmh+d8VHFgh9ab
 OdZcbU3/+f0pk9uQ=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr4390238wrs.226.1597942807478; 
 Thu, 20 Aug 2020 10:00:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0LX1iEI5sG5+0WY5A4i9+FbisCQGjIP/NsUK+/7fAKoe+5ce7ba4ZbySCKmXmtY+7OwWBSw==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr4390210wrs.226.1597942807227; 
 Thu, 20 Aug 2020 10:00:07 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id l10sm5109782wru.3.2020.08.20.10.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 10:00:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/15] block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
Date: Thu, 20 Aug 2020 18:58:58 +0200
Message-Id: <20200820165901.1139109-13-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
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
index 5b69fc75a60..456fe61f5ea 100644
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


