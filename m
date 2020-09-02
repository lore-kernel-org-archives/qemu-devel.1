Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C8EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690832084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1y67BRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690832084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNmv-0004ZR-KK
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNmL-000459-Fx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:06:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29057
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNmJ-0001UW-SL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599033958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zUKO378qgEMw5DfWn5fjWQga9IMT5p6MgV6h7VpM6Fs=;
 b=S1y67BRSX3kIOmNDDlM7VmqLNdOayQHKuQGJxXEe/D30+cS6dbYMEeo/flesyxUjnYTdU+
 U9CjKyCtc01fNVS4SYI07bjQfc3+cw5AREZdQ4cNvjFhAvmd2CUl1UABsSJpf3L8qYjIwL
 puI2QudzJtdYjkFvS2wvEx4lZjkl/aU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-ao178VPbPHSbKJ8LkPQWLg-1; Wed, 02 Sep 2020 04:05:57 -0400
X-MC-Unique: ao178VPbPHSbKJ8LkPQWLg-1
Received: by mail-wm1-f70.google.com with SMTP id b14so1297747wmj.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zUKO378qgEMw5DfWn5fjWQga9IMT5p6MgV6h7VpM6Fs=;
 b=M4zcb9bfwbfpgRzf7pVLrD+/PypDdQGYtEUXmwN0MF0vBIxg45gK0TY3voy/Fya6gz
 /uIFuBG09WBPSb855++vOZ2xS/eN4/iWRYgMxD/bqC2rpL7hDMEWky+NbBMZI/z5gMK6
 Q1jhFAXBPnZZazh/hjRjOecAzNUxvD4ICWynYuRoXbeelfsQh5amgmd4tDwRXYYnQRvy
 LtkWnMZfK6q6XNSIiChGO1Ib1G1WGECEAmhefe5Yej00J6xO1ZXy75+q5CSmbKHY6LNP
 mFiJw5ckg+/PtUdtYOobz1NJyNEhkjrbHrCzSGtqLfWDHoBK1MPF9JIw07YJrYke8g3Z
 +YYg==
X-Gm-Message-State: AOAM530zG/ExWTwOkVTwkuKw/dmcajriD8RMTXxCIraiXDX9bHjq/kTy
 j7jvhLkV1dAux3HoEQg/I/YoaRU4gBT6eUvkk9uTFWy/2esjcJHckj7p6BJUcoo75PuyukTnA3L
 MJ+xKEHFZS6VZcX4=
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr6214366wrn.358.1599033956219; 
 Wed, 02 Sep 2020 01:05:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytJfqcUm/KS3NTrXzTxNWKpe1KkvD7PkR9NvSuxYaenth0xfVc8pGz6ARZuKgyXALclpd2Iw==
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr6214346wrn.358.1599033955948; 
 Wed, 02 Sep 2020 01:05:55 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id w15sm5874984wro.46.2020.09.02.01.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 01:05:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/ahci: Improve error handling (NEGATIVE_RETURNS)
Date: Wed,  2 Sep 2020 10:05:52 +0200
Message-Id: <20200902080552.159806-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix an error handling issue reported by Coverity:

  /qemu/tests/qtest/ahci-test.c: 1452 in prepare_iso()
  1444         int fd = mkstemp(cdrom_path);
  >>>     CID 1432375:  Error handling issues  (NEGATIVE_RETURNS)
  >>>     "fd" is passed to a parameter that cannot be negative.
  1452         ret = write(fd, patt, size);

Reported-by: Coverity (CID 1432375)
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/ahci-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index ca4294f44f3..5e1954852e7 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1443,6 +1443,7 @@ static int prepare_iso(size_t size, unsigned char **buf, char **name)
     ssize_t ret;
     int fd = mkstemp(cdrom_path);
 
+    g_assert(fd != -1);
     g_assert(buf);
     g_assert(name);
     patt = g_malloc(size);
-- 
2.26.2


