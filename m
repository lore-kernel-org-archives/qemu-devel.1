Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED503C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5AA2076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAjkEx3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5AA2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4Pj-0007LV-08
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4KE-0006su-4O
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4KC-0006gZ-FK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/cFTVW+ke5uZg7BAFOkxbRZHK6mRcrvyD+HcJ4ykuI=;
 b=bAjkEx3Ovo46Vaqj2UOAn9sPzbUxOAPaXSXpeZiASxh9kiReUFmNjAulmZIph/hA03MdWh
 GMc1aPizHdHG/WAQ/9n0MR896DbZzvMEVZ0fB8y+AjfieO7MgcTtvGrNZOtPb4iF/MBrn4
 Lfk3PuYNVlbCOegMCK2pxukpvaBKtH4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-Om8eoJLGNUeHokQT4d_cYQ-1; Thu, 29 Oct 2020 05:34:26 -0400
X-MC-Unique: Om8eoJLGNUeHokQT4d_cYQ-1
Received: by mail-ej1-f71.google.com with SMTP id z25so952898ejd.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d/cFTVW+ke5uZg7BAFOkxbRZHK6mRcrvyD+HcJ4ykuI=;
 b=VTcIlXYsrKiBptC9sTvf/VmGNlENvzY5XLKaA4OPaM/s7D5aydp61aRjqFuiy68fjD
 TjmtuxTrZBZMl7uiKnl8V4HbOONYHEWpl4xAFU3CrO1Gq8GOO7py7sscL0Yhqk7uvYqe
 mzKz29t4xkBfq2PTeN7yps8KBzhZmx1X5o4C6Ksip65Szj2hsb33PXQXnFe+NqS2mRCG
 zvWKNHkTo3uwp0boJATJ4ycNz/qnfkQF+6unBnK6Gnrn9Gfp7gOjmquemAy3AEZ4cgHD
 Zbt1JhIJy+uYA/cuyENkipql1c8mGeUjDB4LOxG7qltzUm7OVJlKCIcM+D4BLfI2uqXE
 WTtw==
X-Gm-Message-State: AOAM531s9uH6rYkYB2q9/nGAfLJbdLjZq52Ey+vFvq27jICkMBqhCKWK
 G/ArXudWYkgTf/UU/75PDHePocoLL7lioC+oIdgrjJ8Q0p2cW/1ZCgzmNXoOraBh/aqjgDgUFLe
 OXUyTHLgH9Qy4zRQ=
X-Received: by 2002:a17:907:72cd:: with SMTP id
 du13mr2973288ejc.398.1603964064633; 
 Thu, 29 Oct 2020 02:34:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVSu+lYk6jMn2irOn3PJRKjNzw+BrS0+xizRLdjzcZjOzFzUQEKieP9hh/pnhDXNiADjs22g==
X-Received: by 2002:a17:907:72cd:: with SMTP id
 du13mr2973272ejc.398.1603964064456; 
 Thu, 29 Oct 2020 02:34:24 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id p9sm1137861ejo.75.2020.10.29.02.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:34:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 14/25] block/nvme: Correctly initialize Admin Queue
 Attributes
Date: Thu, 29 Oct 2020 10:32:55 +0100
Message-Id: <20201029093306.1063879-15-philmd@redhat.com>
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 7285bd2e271..0902aa55428 100644
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


