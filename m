Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D16C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC600204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWDss1Ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC600204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9D8T-0007t0-S2
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D77-0006Bq-9n
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D75-0002eb-Nu
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjuMfzB7vmmpnq1Y+pCZSaYpOzcdGDKXx0gwxTqDWn4=;
 b=GWDss1IiXb1qZ/s0EmHrQpChfPLDG/kYWK/m0u9SUFTYbP+PgvZ+OrrayMTROo2DjVvsfS
 B0dJ1xTahun1GFi7Pjbmk+8zLMz8nox81ccbP6pgkJBHqGOild2zg6ZfS/0thE7IPPPUXs
 O/7erSdUP6DPKeXDfXJZxYUtDFIFGyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-tetHgmGcOmK9CengH2ynOA-1; Fri, 21 Aug 2020 15:54:09 -0400
X-MC-Unique: tetHgmGcOmK9CengH2ynOA-1
Received: by mail-wm1-f69.google.com with SMTP id v8so1369288wma.6
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cjuMfzB7vmmpnq1Y+pCZSaYpOzcdGDKXx0gwxTqDWn4=;
 b=DboJD9a3I7iVkaA2J4XI2GW9njDdBmngq34V+kt2r6Cp+MZ3NwEbnX0I3YQO7E24JF
 ex0F7YtYxWCO+CkgLL21+lRtlnaezSF0o/tbsjZhqKW4VLj/5KZ5bMZCrwdJGtJAOfA9
 g4krqe8D0F4CILHH4OghjDiAQobOhufMIinD4Q1Vrp9c7k8Hd0BhinWK0x9cHLs5gQWC
 lKiPr6gsZiaW5rPN5NcIvGG/TRAdqOuDf9yc1WZrpECadt/6crcScGnMbuZA83ZXnck4
 3uixk8iEUbVD2AWoDevq64N3g/YZiMAYIGijKAcm2KJDFq8KOzOV1st+X95jQ8zkD41l
 60zw==
X-Gm-Message-State: AOAM531yy7QzY0BobmrQ3qs0p66hQMPr64zXp+yayDub2Rg0FDBPnpsD
 eZxcrxlJJtjrCqt1pJeJCrW+jmaOXnHy1YkND3+fQLkxcYqmZPqBinH+o7qZ+j8C0XOjVB+z5Jm
 RsEdKWMn28WpKaEc=
X-Received: by 2002:a1c:1904:: with SMTP id 4mr4614419wmz.119.1598039647710;
 Fri, 21 Aug 2020 12:54:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzRaArRtMttJmtkCRf690g6PGVLrd2W7qbwxwyd71RyatCuhPQyMtGhydLl9q7KsoAMRhe2Q==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr4614397wmz.119.1598039647479;
 Fri, 21 Aug 2020 12:54:07 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p14sm7330159wrg.96.2020.08.21.12.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:54:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 01/15] block/nvme: Replace magic value by SCALE_MS
 definition
Date: Fri, 21 Aug 2020 21:53:45 +0200
Message-Id: <20200821195359.1285345-2-philmd@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit SCALE_MS definition instead of magic value.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 374e2689157..2f5e3c2adfa 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -715,7 +715,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     /* Reset device to get a clean state. */
     s->regs->cc = cpu_to_le32(le32_to_cpu(s->regs->cc) & 0xFE);
     /* Wait for CSTS.RDY = 0. */
-    deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * 1000000ULL;
+    deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
     while (le32_to_cpu(s->regs->csts) & 0x1) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
-- 
2.26.2


