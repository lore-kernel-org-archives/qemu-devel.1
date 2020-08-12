Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5FB20838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBTjfeR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5FB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vqa-0001M9-Qg
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpW-0007zx-Er
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57858
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpT-0004V5-Pw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkqdCy476re75wjyst3nMLbIFP1njQZj90UgXgmJOZc=;
 b=UBTjfeR1ozJu0+WMbTEDsYWGNCl9ivzlJysdZ7nzLvsPRddeT916L0Z8kHVCGK31bG5c1p
 EbsYegbPqjd6P00XsDd+z1pu9WNzxPf4u8KKrWOtKLpiHgzMv6CHEb+BVK75BHJzxQCSHK
 olZO88XAw+/cUiydHaO/s+veNvX/tnE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-bZexTs3UMiy_AZyn677EgA-1; Wed, 12 Aug 2020 14:50:25 -0400
X-MC-Unique: bZexTs3UMiy_AZyn677EgA-1
Received: by mail-wm1-f71.google.com with SMTP id d22so1217668wmd.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XkqdCy476re75wjyst3nMLbIFP1njQZj90UgXgmJOZc=;
 b=jUGQbNW53v6LvKa6UhJDWAjtRCmBaz8nOJHwdP4RnJYuxysmWqf6EI7T1YyHMwBAjJ
 QLYb8YL3cqprhG6B1lVXI/GT0RwKKbrzqnzG1FtFcFAKjOwRzbXSZLTCT8yyOQaYNULe
 D1rKcnMIfUER0m3+qGHLCykx1Z552qSjLVfeRTeiQk1SdGcSK7r1lddRzwgVizHZVQSR
 6jBXuKjBeCCoNjFlLQhzCuVZmyVO2EC8fRB8kzUB81k+LGrO9u9SzucvjVj3pTIAdVoq
 Rdk8IoGaNvzscZTO2EwY7uGQH2+UtfbZbusO9mgpgnzLUgnI2rPFDbSRbZydrRtgXntc
 QZBw==
X-Gm-Message-State: AOAM531ELQj+gXonRq8bpFtAUgPq7+L4hd3sZf9AEnPEUJwh2d3kqiCx
 6gGTRGyW/6eBUT3q2mVoab8rDnh3GzWqf+3wp2LFmD8trw8mISwErnA1EPmoUvm02FWhvoauPOY
 foq6xplzZK/E0/M0=
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr497338wrw.13.1597258223591;
 Wed, 12 Aug 2020 11:50:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn+Nl7YRjM7HwbqTWWTsoAhPVBugudDBKkxe1DNfXdo3tuNZDEaQw47jmMoRSbOSpioPVI3w==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr497325wrw.13.1597258223402;
 Wed, 12 Aug 2020 11:50:23 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p6sm5167663wru.33.2020.08.12.11.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:50:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/14] block/nvme: Replace magic value by SCALE_MS
 definition
Date: Wed, 12 Aug 2020 20:50:01 +0200
Message-Id: <20200812185014.18267-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812185014.18267-1-philmd@redhat.com>
References: <20200812185014.18267-1-philmd@redhat.com>
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

Use self-explicit SCALE_MS definition instead of magic value.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 374e268915..2f5e3c2adf 100644
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
2.21.3


