Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D083C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078D920679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSpiWMWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078D920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX8q-0003oy-9M
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwZ-0000h2-K5
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwX-0001Fq-P6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXASt3Ms0kW/IxtpIXCdPXxIbHHRXq5VPxKgsbFlF6A=;
 b=PSpiWMWHV7ClDOV04kBw4UscJO3T97i2rawGqSvYUTQImQd4vD4otv0jiN5AO4eDSENodN
 pS8Qoa0sUO8xWG5T+iO2FuKhb66E8dLWreNI/DDTxdhQDxqJx+Uzyej3yTNYIO9G4u9w/J
 W3XmDLby3abJqz/GSbGhp3pNIxWn/Fs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-5NzhVgSjNymtmWd1jaL42A-1; Thu, 25 Jun 2020 14:49:47 -0400
X-MC-Unique: 5NzhVgSjNymtmWd1jaL42A-1
Received: by mail-wm1-f72.google.com with SMTP id v24so8009683wmh.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dXASt3Ms0kW/IxtpIXCdPXxIbHHRXq5VPxKgsbFlF6A=;
 b=K/87fyDOuou7Y18nxjFvH2TY++eNW/XPYhGYug+GKRfVms+hZ+p9QYZjRrEPCDYEmr
 gMrIUrmbQideSlO95X9i5lbx/QDYQqS6ZFigyWW1g9UnalHeteriCdfI8L6Tiv9AFctr
 3s+77rQjplonPZL2mvcJZy+7v8QQmoAFkPVguuAm5qMXRYeiys7d0KQWcVFZ07BYWmDo
 NdSPPsvZvljdTPNasEowUcnAn+13z4GrRyXiStxJ44YfY9LNxZz+foobK/SKeNcK1aws
 hem8MJfpjP0MFNbNYL6kg2v4fDeHhtiuawrXHgABxY1EJeop9YxJyAUj1wFbxmkjHVm4
 svog==
X-Gm-Message-State: AOAM5306mWd1lJduZR/kvl3FIFBbOWtQjeUMoAoQ1rNbs0Ep3nUyc2v3
 Dd81Ic3pyAsdybsp48aLNk7at/5n+LXP/pR+OxgAB3+XoFqBhKmFfGCj4x8o6e22hYQx4vZURN/
 1h/w2cPXOt8rdQes=
X-Received: by 2002:a5d:6202:: with SMTP id y2mr1866716wru.32.1593110986313;
 Thu, 25 Jun 2020 11:49:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxvRxzrrsGeWera0Bg/9MbggcnNfga2FrxDtfOrnxGYJam1O2ZeI0pf1cIadS4CFloAwRnkw==
X-Received: by 2002:a5d:6202:: with SMTP id y2mr1866702wru.32.1593110986181;
 Thu, 25 Jun 2020 11:49:46 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 3sm7989952wmi.45.2020.06.25.11.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 14/17] block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
Date: Thu, 25 Jun 2020 20:48:35 +0200
Message-Id: <20200625184838.28172-15-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 7b983ba4e1..ac933cafd0 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -419,6 +419,7 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
 static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
                          NvmeCmd *cmd)
 {
+    AioContext *aio_context = bdrv_get_aio_context(bs);
     NVMeRequest *req;
     BDRVNVMeState *s = bs->opaque;
     int ret = -EINPROGRESS;
@@ -428,7 +429,7 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
     }
     nvme_submit_command(s, q, req, cmd, nvme_cmd_sync_cb, &ret);
 
-    BDRV_POLL_WHILE(bs, ret == -EINPROGRESS);
+    AIO_WAIT_WHILE(aio_context, ret == -EINPROGRESS);
     return ret;
 }
 
-- 
2.21.3


