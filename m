Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7065EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C22D20774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTBSP6dL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C22D20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vur-0001ei-Cs
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vqO-0001PD-9B
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:51:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55236
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vqM-0004iW-KO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZvIeUTtbA1cdburvrqsRBmAYT3Mcinvh7uqhE02lns=;
 b=NTBSP6dLwOrZptPwUcXrj6Y0z+8gm7y1Sn0IhPGC9uqS9mTP+4zEoemVA1lmVrWbunLtBB
 WaSux5d2zgi8Sj3M4vdD2PRn2+A/yt/DjmrWAj5bzxRZnuKpE/TnyaqIXPcenONt19YGO7
 YzLW/XM5C2AivHv/2zWsLZdam4k9rJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-42Ly0qR4OF-ro-KJNqHjwg-1; Wed, 12 Aug 2020 14:51:20 -0400
X-MC-Unique: 42Ly0qR4OF-ro-KJNqHjwg-1
Received: by mail-wm1-f69.google.com with SMTP id h7so1207389wmm.7
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fZvIeUTtbA1cdburvrqsRBmAYT3Mcinvh7uqhE02lns=;
 b=H2NssatC0ZSTELOwkiCqUwhu4t/T91eb2Lpnu0K7uuoiqbX7KWjh4k8581M+rB+z8r
 w8M5qoQIb5N0i3dqNJHAoAauxby1DhyU7M42sRlziXHAa+vLirLGxMakIJa6wl/mlI+d
 jf2GDxPnUW9PZ/NCBJXrsHPqOglH3L5kgeVJimbUI5nVD5Q7S4spJifKFKxohQ8pjR3g
 Dpa/8Znc55Y42YFiKVJh6eaQKsiBYi7WHUJZ9HLnojRcipT/IJaWxDuhfZw/COH7u7QK
 JxEJ5120gJFPCteCx3DkfyuoOJuIRdZL6WpEUGXzDPoXr1oR7koP6uCAe5OqRHFGRy+F
 gyww==
X-Gm-Message-State: AOAM5320iPyhEb/OMRoGh3IVdW9bgdhBdiz8QmXez+EExCEpsAdFC5YA
 5HnFJ7ZojIES4TScEUClKYgPPN6tJ8Z1I3vfV+hl+nvQOdLQJ4dx7JHGcWUyWwxRvqyztEV/pfQ
 9sMpN2uLcshYCrko=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr585700wrs.226.1597258278476;
 Wed, 12 Aug 2020 11:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7eMGzW6+QMFp6DEYcHIKo1HUe97JfPPS4Y5weiB/cgW9XJIVnd9O9PCVgFAP57kSAog/NrA==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr585693wrs.226.1597258278315;
 Wed, 12 Aug 2020 11:51:18 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id l10sm5408966wru.3.2020.08.12.11.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:51:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/14] block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
Date: Wed, 12 Aug 2020 20:50:12 +0200
Message-Id: <20200812185014.18267-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812185014.18267-1-philmd@redhat.com>
References: <20200812185014.18267-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:32:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
index 5b69fc75a6..456fe61f5e 100644
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


