Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9029EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541C0206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NixcHs8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541C0206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLks-0003EZ-PW
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhz-0006ym-Jt
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:14:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhs-0005Zx-Lu
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593544451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOpQpvHqMfX4FPMLDJD68SQU34AdCnwRx9P5g+DPasA=;
 b=NixcHs8m+u3HEC6pHi72fbeqXzjBN/kY+eTB/CQeJAxD+wSyZY3q5AB1JHfH/m1Vd3aijY
 ySnHs328YqECBw80AlJAPBEieduvqMDE11FvYivpmincjXVkZ+DJytN6LVVCIK6+z++/6T
 nwDfPZymQFV1+iGdNWn0/Mkg5XbDUjU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-gdVpSrkmOuyyUIkEBQtHoA-1; Tue, 30 Jun 2020 15:14:09 -0400
X-MC-Unique: gdVpSrkmOuyyUIkEBQtHoA-1
Received: by mail-wr1-f70.google.com with SMTP id o25so19038196wro.16
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KOpQpvHqMfX4FPMLDJD68SQU34AdCnwRx9P5g+DPasA=;
 b=ByMwIxX1C+qPrYtswDK24mMwDBCis1UGYdMqtEab0WmVhpWctie+mTQ1mKwmSZvtEC
 RgHCqma92vSrQw3jOoipZDJVCaoA0UORKtjhTDGjKvgRo68X6YNqLadmK6CyF3CPquVM
 +gXqcKJhVqme0GMRKE8njFBp6/BavWCvMDRnk99cFrhK0yPDoSHJrqnHKUlRs9LbYoSe
 +HvV1L0R+gi2kLGVg+JOCe/cTkWhaDs1ToZsLT3vF+R4OAPVEmJQBY9/c4eWRRoGXw/x
 KrMFXBc/iHr2aUB008BvEUbu4YsfeHTIfjw1tHc1ewqRjorFoqRlzTVNI+s+8RFClYSx
 HiBQ==
X-Gm-Message-State: AOAM530GABbHNpn05H0lDn6yU4JGh69Pic57idoOuuk9SpEUeH7SsNyG
 68vUWGZS0suqKPKc2obqjsB7lH5fZPvfhQBgzRNWKPkXdRGp6gJkQPFiOJFxMUwhPn21M2ccKcF
 /Mg34rDvm6LrTtao=
X-Received: by 2002:adf:e38b:: with SMTP id e11mr22761568wrm.65.1593544448681; 
 Tue, 30 Jun 2020 12:14:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1EZVpTdd6iXbH3PSnKeVnsDO0FFxLn8ufo5u4r8UFQHUawa91336cWUspmUwMIrMWX837DQ==
X-Received: by 2002:adf:e38b:: with SMTP id e11mr22761556wrm.65.1593544448497; 
 Tue, 30 Jun 2020 12:14:08 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id i19sm4911419wrb.56.2020.06.30.12.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:14:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/12] block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
Date: Tue, 30 Jun 2020 21:13:16 +0200
Message-Id: <20200630191318.30021-11-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
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
index c28c08b3e3..010286e8ad 100644
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


