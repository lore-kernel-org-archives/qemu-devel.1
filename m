Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAA5C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D568222E9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RidUPOMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D568222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPmF-0008Sd-Sj
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTh-0003dg-0O
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTW-0004Ou-S5
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnKJRPL31xVnAcjJgHQjDndeYt6tVNjYfmSUE2zuN74=;
 b=RidUPOMrous0zB7xzqrwECzcHt+yKAYPHhtFcJrO78dNfPkVM8NnG2Ou1ADmi49KaarJ/y
 +bkl6ROCT8BAn2PhszGbFUDnrVuz90FR0FtoW5Ygoc+JzbH9hsp3xD36iTe23JihA2pZmZ
 9eErogwPFBrTJDFCt6oGPjtjIYRwm0E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-hTRvjjwwMY2ePrBrp66y-Q-1; Tue, 27 Oct 2020 09:57:13 -0400
X-MC-Unique: hTRvjjwwMY2ePrBrp66y-Q-1
Received: by mail-ej1-f70.google.com with SMTP id t1so870958ejb.21
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CnKJRPL31xVnAcjJgHQjDndeYt6tVNjYfmSUE2zuN74=;
 b=kovX/GNq872S3EdvIjKZliKtaaZcSRS/nitSw9xntA4Xpbl9S5cwApAHYffUGyrEFa
 y9Y1HH3MX83XFFCFcshitLdnVG0yZ+lczc6GZqPFhT33FV6hh2ofG+cQmugyQrAlAk8N
 1hx3iSBDUja6DmIqf4KjiG7NL59RNmnwRo/Gb0Wu77fbG4DEzpn/z8LK1Vq9yew0DEDk
 jHm1LzcufrGvo/raljgt3zoizQo/xDbm3xoMzsUo4IbSAYihuZF9Bw59xr6qvzV3ZOai
 FEQ/m6H83gUeWOZ3jI6aETFerDzQLBl5H0ge/4/E6uz0Dij2R0tB1XtdChtExSMVQKdk
 vpYQ==
X-Gm-Message-State: AOAM531r2DGaQj2z4LLX3UP7RU0wwRwOLGRj3FqO+4ZsfYqN8ZeYqcEt
 MHtYgXUQRV6GcQ8YFxGjygcKadt+ki/3G+Wun3NTXxjd73Hz94C5hB7ajCNvtkt/Xa6Ln8kmhj3
 j41GDSz3q6mwT1Bk=
X-Received: by 2002:aa7:cf0f:: with SMTP id a15mr2488090edy.3.1603807031579;
 Tue, 27 Oct 2020 06:57:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvCUXDinGiPty4cyztZwsd74U8l4L82wkME6zZcbbfVNW3u/nxxKWmdV1QX7jPFSHS9y65PA==
X-Received: by 2002:aa7:cf0f:: with SMTP id a15mr2488074edy.3.1603807031403;
 Tue, 27 Oct 2020 06:57:11 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id cw15sm1109814ejb.47.2020.10.27.06.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:57:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/25] block/nvme: Correctly initialize Admin Queue Attributes
Date: Tue, 27 Oct 2020 14:55:37 +0100
Message-Id: <20201027135547.374946-16-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From the specification chapter 3.1.8 "AQA - Admin Queue Attributes"
the Admin Submission Queue Size field is a 0’s based value:

  Admin Submission Queue Size (ASQS):

    Defines the size of the Admin Submission Queue in entries.
    Enabling a controller while this field is cleared to 00h
    produces undefined results. The minimum size of the Admin
    Submission Queue is two entries. The maximum size of the
    Admin Submission Queue is 4096 entries.
    This is a 0’s based value.

This bug has never been hit because the device initialization
uses a single command synchronously :)

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 2dfcf8c41d7..d5df30ec074 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -789,9 +789,9 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         goto out;
     }
     s->queue_count = 1;
-    QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
-    regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << AQA_ACQS_SHIFT) |
-                            (NVME_QUEUE_SIZE << AQA_ASQS_SHIFT));
+    QEMU_BUILD_BUG_ON((NVME_QUEUE_SIZE - 1) & 0xF000);
+    regs->aqa = cpu_to_le32(((NVME_QUEUE_SIZE - 1) << AQA_ACQS_SHIFT) |
+                            ((NVME_QUEUE_SIZE - 1) << AQA_ASQS_SHIFT));
     regs->asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
     regs->acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
 
-- 
2.26.2


