Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597E2C43469
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A9023998
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkTS0ODV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A9023998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOsH-00062u-O3
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhw-0004iG-A1
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhu-0007Tv-G7
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600705825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFUnGI39xPjzTrYSbqi9ooQfeOOci8dGNYXdLQ1TjBg=;
 b=ZkTS0ODV5H4mq3OFkXXS1AYv05zsAOksXzrqd1savfJSBqlbLZPc+3xlLvnhbGTxohDgX9
 HczlWTS+3o/1ghL6MRfLlBz8xYFl1GdlEnR0WmCzK/xDl1sp4sDre/QIRefj0Zc5hcZLMp
 PCMR7oLO6etsi7AbpWueWA7F9U1qUh4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-HYyPF9nKPs2Q-ICUMUQSAw-1; Mon, 21 Sep 2020 12:30:23 -0400
X-MC-Unique: HYyPF9nKPs2Q-ICUMUQSAw-1
Received: by mail-wr1-f69.google.com with SMTP id l17so6050676wrw.11
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 09:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VFUnGI39xPjzTrYSbqi9ooQfeOOci8dGNYXdLQ1TjBg=;
 b=TP7uw8ExHbs6na/j03tMnn7LwiNELqQ7kBCun6p921KBGA28AON1+vW0XjF+X3DuOJ
 wvw7cQ5unMsY9vjVA07xtouD3PMpjXxqeOBvroqYsT0GDQuUB7GMSI13epRcGsoupupl
 gohH4bOPC8Hg3bA3ENAQdNj2Vc6yFIqzz33Wll3+eEGCVP+H9bYjz6XTb7M5Vi6tMOSI
 G4k5GmaSHppKcJqe0+/BWH3GNjCuxShKlYhk42N2jN05pzxC5U+i9WPKAcB13xgE8iqb
 21xeUsLokXKQiV7t3dve8jFPwc2VwFgS07tQZd9k53KVXEvEoBPqVZ/0sD/xZEZQshAa
 BkXw==
X-Gm-Message-State: AOAM531wK97W6r2U85vDjkjTKGEA47uo881UQOf3eMVqY1w87Ro3Sx7N
 9TzVyZLVlYzISEl3OK1XkQpcfynyjUno2eBoUkoHNh2/WNNhnW/EAcnhesZ3dFiQVExkK4P1nIv
 5uYUHcCcP/GCryio=
X-Received: by 2002:a1c:6484:: with SMTP id y126mr167559wmb.177.1600705822498; 
 Mon, 21 Sep 2020 09:30:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqAMnvvzX7KRFUB9AMMq50VEuwDyDmX1j4JarJc9ypAQHEYr/rthZ9b2cqS3DipFFGazQQIA==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr167544wmb.177.1600705822362; 
 Mon, 21 Sep 2020 09:30:22 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f12sm148215wmf.26.2020.09.21.09.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 09:30:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 6/6] block/nvme: Replace magic value by SCALE_MS definition
Date: Mon, 21 Sep 2020 18:29:49 +0200
Message-Id: <20200921162949.553863-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921162949.553863-1-philmd@redhat.com>
References: <20200921162949.553863-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit SCALE_MS definition instead of magic value
(missed in similar commit e4f310fe7f5).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index d18e897c7c9..b3dab1c4610 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -772,7 +772,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                            CC_EN_MASK);
     /* Wait for CSTS.RDY = 1. */
     now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    deadline = now + timeout_ms * 1000000;
+    deadline = now + timeout_ms * SCALE_MS;
     while (!NVME_CSTS_RDY(le32_to_cpu(regs->csts))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to start (%"
-- 
2.26.2


