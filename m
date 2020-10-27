Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525AEC55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49422072D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfFjLa+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49422072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPrd-0006n0-I3
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPU8-00040n-RI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPU7-0004Wu-0G
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGgz+XLiFf+ohpuvMEd9wbrelu41fy1wd5IWGvE3gyY=;
 b=QfFjLa+BDYFeYswrPwoP+C4BQNq7BzneUSqyUXjrun99cfNbNWJFABws4tGTfa3FuWxBa4
 VvOxPK1iqSZ++QAkyPg4YNn2si89A+I7Us9HClF8Oswzjv+vuB9LFCynAkelxlOkDpBavX
 RHRr2/Ml3Rrx83U9HOPjKdKdcIXemzY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-C1KhB-5eMGilDXN6WXT5wQ-1; Tue, 27 Oct 2020 09:57:50 -0400
X-MC-Unique: C1KhB-5eMGilDXN6WXT5wQ-1
Received: by mail-ed1-f72.google.com with SMTP id y8so732412edj.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aGgz+XLiFf+ohpuvMEd9wbrelu41fy1wd5IWGvE3gyY=;
 b=WkwSGC6EWM2CQb7ln/rkzIb/bci+E8HebbEZB1L0/11XsBsDRv9w+2/d0i0M6AmhuK
 PXxSTOtikQ0rz1aFnadGwaFcWX8u32P2B7pr8WqwwbFyyII+5YQziqAgtz5odPzj0Sd3
 rJHiDu50anelLn6cl8gahdATHiNQkC00mPz8byZwTO3HrhPaA7jRREUQCK+5om8xfh2+
 6dpP6TeX5AxI0TLLd8BxP6oO8/sedTSkICp/1x3bpizYqM4WDAuSZEEpAs5jGlOegpS+
 WEzUmfiiq0Pnz/5D5VmeG2yp2HfynBOIoC/pv8WGb9ycSNCi+Zqpr6I/cc+C8OSGyyEx
 7jtA==
X-Gm-Message-State: AOAM531cWnxJn5N0+UHrW7z0r7u5mPql0pHVRU6Ly6U+9l0Y84D5yP9l
 ggIAhed/qyvBXbmkeRPyE+Y9dN4Fsm+STk9TQrVjcVheKI2GHIq2PEVQMvyCuTMIJWl8SzHOF24
 Kjxt24+ebblGeyTE=
X-Received: by 2002:a17:906:6a94:: with SMTP id
 p20mr2404745ejr.499.1603807068874; 
 Tue, 27 Oct 2020 06:57:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwOUz6H00BT4J8Of8oTGNZFsFpvU1WqANY1FB+xfxYbL26MBj/7nMSy4BYnPJXl69yqxaYDQ==
X-Received: by 2002:a17:906:6a94:: with SMTP id
 p20mr2404735ejr.499.1603807068718; 
 Tue, 27 Oct 2020 06:57:48 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h22sm1129238ejc.80.2020.10.27.06.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:57:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/25] block/nvme: Change size and alignment of queue
Date: Tue, 27 Oct 2020 14:55:44 +0100
Message-Id: <20201027135547.374946-23-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

In preparation of 64kB host page support, let's change the size
and alignment of the queue so that the VFIO DMA MAP succeeds.
We align on the host page size.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index ad70303c5c1..941f96b4c92 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -167,9 +167,9 @@ static bool nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
     size_t bytes;
     int r;
 
-    bytes = ROUND_UP(nentries * entry_bytes, s->page_size);
+    bytes = ROUND_UP(nentries * entry_bytes, qemu_real_host_page_size);
     q->head = q->tail = 0;
-    q->queue = qemu_try_memalign(s->page_size, bytes);
+    q->queue = qemu_try_memalign(qemu_real_host_page_size, bytes);
     if (!q->queue) {
         error_setg(errp, "Cannot allocate queue");
         return false;
-- 
2.26.2


