Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A805FC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648AF20767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZttGjjjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648AF20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoNA-0001Uu-Du
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoM0-0008EA-C7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLx-0007pH-EG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HgXwbQUt5qjogYM8iFoeW+GHqjN8VyRP3jjf5JuoDPA=;
 b=ZttGjjjCS3616krHaedR7CdgJC7MYFY6oKjVwhQwCU4y1QLwkhf9il9wSpTIUM38oWncs7
 7dgEIjCRIQ0dnAo6J93s7PDSmxOjUw8UpJGmBWWPdBWdevC/nL0wby0ctPFHkZaIAZJKcL
 7jyHUrPV/qJiqt8DnGNTkS1RVIPkAzM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-XdMnVcZaOyeE1dtvY2kW_A-1; Thu, 03 Sep 2020 08:28:31 -0400
X-MC-Unique: XdMnVcZaOyeE1dtvY2kW_A-1
Received: by mail-wr1-f70.google.com with SMTP id j2so1020585wrr.14
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HgXwbQUt5qjogYM8iFoeW+GHqjN8VyRP3jjf5JuoDPA=;
 b=DVJPmNOQwk76BYZ9ZmjHNtWTvPt6MQ4SrfKHXs4yqLtL4ARDqz8HKiWvuLTX+IDNla
 ixdlkAOMouVrYSMrXRmsb1+j8epjRYUScik/JxCaVLXHjSsRNj2+9KQko8Dl+tkm29Mb
 MAqIlb0e2FQzo4EFwm3tun+soJFaGtbc+Tzh5ZXIUujq7ROOxXKtUGTdzmvMAaX77rQg
 x3xDjKQTekhK/fcCgUev7u/BB5BcVdPVZbZotJrQDVtrDkp5KfXjscZ3fEOGMjBwwtzY
 ODgcuLpaSXTDupEQjRszFI+Dh5Kd66BD4uMgG1sE9ZOmCKvMEW4m4feuCj1amx30ctQy
 ihQw==
X-Gm-Message-State: AOAM5316Is1AS/xzPlWecBbn24H5fqrxpD7qGXnLXcPI3zfQld8jxeHW
 VLq009RNWuRZVPdZpYQwKeVQl1u7upEoOddRDGB/BSLrqd+Qi/+mW43ZABGUyI0T/4l88w4oQjb
 3f2R2VvQLZr2F2t0=
X-Received: by 2002:a05:600c:2f8f:: with SMTP id
 t15mr2339262wmn.41.1599136109718; 
 Thu, 03 Sep 2020 05:28:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmj/53RnlUwP41Kw830eyDzS+S/LEAKExFitdifMhLbzQYjgIiwMnMt/JKVg31cWPCejhtNg==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id
 t15mr2339246wmn.41.1599136109515; 
 Thu, 03 Sep 2020 05:28:29 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o4sm4079738wrv.86.2020.09.03.05.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/15] block/nvme: Improve error message when IO queue
 creation failed
Date: Thu,  3 Sep 2020 14:27:53 +0200
Message-Id: <20200903122803.405265-6-philmd@redhat.com>
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

Do not use the same error message for different failures.
Display a different error whether it is the CQ or the SQ.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 488d4ddb3b8..91dba4ec5db 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -648,7 +648,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x3),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create io queue [%d]", n);
+        error_setg(errp, "Failed to create CQ io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
     }
@@ -659,7 +659,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x1 | (n << 16)),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create io queue [%d]", n);
+        error_setg(errp, "Failed to create SQ io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
     }
-- 
2.26.2


