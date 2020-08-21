Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0187BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8452072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBWXQ/Z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8452072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9DA9-0003rQ-Va
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7W-0007FH-Vm
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7V-0002hy-5v
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xDCDapdWyub1oQeIVHPwnt1jYU5IQrsPDwy4E3ew7k=;
 b=EBWXQ/Z6HAdSokCSMSSY+0WxV2HYjYldpFS0IsiMZjgHhUeFWD4hBrEArOL4wPR64BWnPS
 mVERTwoJr9BLoS/rl0GZUdt2SHQsbMWf5oH7iLOKUYMvmJ8Of9uxWxAILz7TEUneuQqMa3
 vMaEuq37IsBtCW6hP6PDUxek0ByAxjk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-c_oTzyNvNP6-yyMY_NKQ6Q-1; Fri, 21 Aug 2020 15:54:34 -0400
X-MC-Unique: c_oTzyNvNP6-yyMY_NKQ6Q-1
Received: by mail-wm1-f70.google.com with SMTP id k204so1375066wmb.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7xDCDapdWyub1oQeIVHPwnt1jYU5IQrsPDwy4E3ew7k=;
 b=BQGhbKIMYKqqLwFUuX0cTLeO4C3vHMiHa2JO3H0nNbB9/gt0c3ijsn0RaCeMpexh6e
 s/XFEWyUWl+MLHya1+2BZYM0z/3p4L8SKSLIB60UKJLq3QsN29XfLRCUgMq7l3y3gx4p
 ypnVTybmGCVW7wMQIAlzJVnYV2hfCtABnBkWoyouyRJkZjve+d4BJSG+HNjLF0gNvehi
 7ukumT0CFkqtc8kHvUjdsG876dasY9YL+onPg5Oum1lfgi+jYMXlG0HROA+OWD9lUVYY
 cAauNZJsV74LRj5iTqa3Dif6rCO+k8sVzb5jxBmVs3S524KAmKX/ZAubDsN7vsGQ0+k6
 nZNQ==
X-Gm-Message-State: AOAM531eN5S1UMxat7gbx45WpgwbUXGdSWvVdN0Y7JD53WwN04HcBTFj
 f8iBg2OZct2aeUJvx4AaGdK32yx6zqu66rsabDJMVXaFTWXK9ZaKTZt1jNdnNO3UzDud/2IU+Uo
 WvFr5o8VaFZleHe0=
X-Received: by 2002:a1c:a54e:: with SMTP id o75mr5468870wme.181.1598039673693; 
 Fri, 21 Aug 2020 12:54:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPe89aAI6gKRcPETnkSxHgC7A8l1QHiyl3gfzMig87o+Kl7saTf6y48FosXkdn25nId9vxSA==
X-Received: by 2002:a1c:a54e:: with SMTP id o75mr5468860wme.181.1598039673531; 
 Fri, 21 Aug 2020 12:54:33 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id l17sm6663952wmg.1.2020.08.21.12.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:54:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/15] block/nvme: Use common error path in
 nvme_add_io_queue()
Date: Fri, 21 Aug 2020 21:53:50 +0200
Message-Id: <20200821195359.1285345-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821195359.1285345-1-philmd@redhat.com>
References: <20200821195359.1285345-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rearrange nvme_add_io_queue() by using a common error path.
This will be proven useful in few commits where we add IRQ
notification to the IO queues.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index c63629d3b45..419178adda3 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -649,8 +649,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create CQ io queue [%d]", n);
-        nvme_free_queue_pair(q);
-        return false;
+        goto out_error;
     }
     cmd = (NvmeCmd) {
         .opcode = NVME_ADM_CMD_CREATE_SQ,
@@ -660,13 +659,15 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create SQ io queue [%d]", n);
-        nvme_free_queue_pair(q);
-        return false;
+        goto out_error;
     }
     s->queues = g_renew(NVMeQueuePair *, s->queues, n + 1);
     s->queues[n] = q;
     s->nr_queues++;
     return true;
+out_error:
+    nvme_free_queue_pair(q);
+    return false;
 }
 
 static bool nvme_poll_cb(void *opaque)
-- 
2.26.2


