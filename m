Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC8EC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F5F2085B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ds9l+8kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F5F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKduJ-0004Ka-P0
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdpD-0005zr-NJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdpC-0008EA-0g
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600763937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUWquMJ0RxAYROBHIyitnnUFXZeARp+T5e38sU6nK2Y=;
 b=Ds9l+8kty5UKKfcl6CQSbpiEdeRPK2ZUPDXwVrPknncJhQ+iIz2DFeNcNcb3xZqTRzvVrC
 8pciUJJHPph7+3au/ZDW4lzdhOSO8cdLOiGgzCRhuXOZUMhhocrMX5iYVQvQ4umuDVls+9
 HKN3V6M9smr5mNbe47Lta+sTbN7xpeU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-KRtPkUzIMniRCBnAQTvI8w-1; Tue, 22 Sep 2020 04:38:55 -0400
X-MC-Unique: KRtPkUzIMniRCBnAQTvI8w-1
Received: by mail-wm1-f69.google.com with SMTP id s24so395722wmh.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eUWquMJ0RxAYROBHIyitnnUFXZeARp+T5e38sU6nK2Y=;
 b=hvgU6RJ3f3JbRGjQs4YS5yqukTgIqbhm1R66vhkNvVBV1MUKMK0gGpQAU85Nz79vqv
 eNM8qIK3YA8glUwfN73wp+/m778rLuK3xiNCCcpxxSOQGJFSteDhY7MQ36bQBEvF8z8m
 e9YWonQJYE8+/klEwydkR/iACFc5fEJucFsMBwjk4Ea+jLErkc2iiyJofM1r1B1lHUU5
 seMZQnOr7cI3C3CwwbrMnmqXu6Bd2Fb84C5xYqZlmHFBhBDnhTogNeJS5uqJcTw/GSeY
 OX2Q8x8TUWxXpRCHixi14ISi2LO6bGEGUEzPkguRARRiArv1b+ZHb6HIElJcsWkLcoH8
 MNmQ==
X-Gm-Message-State: AOAM531l7ZjXNizIeuuVK7yi4JgSZes3OTX3Rn6xqq1/zKfTWWg5bjKC
 OR5isR9CWxk7ZSEkVnLL7l10wkmAcC6zi+Vm3kSseS4U74vr7wMsxdOkSo/Jh2uAnttbO5RFqFr
 wl8K03gZUXVATXa4=
X-Received: by 2002:adf:cd05:: with SMTP id w5mr4092695wrm.62.1600763934313;
 Tue, 22 Sep 2020 01:38:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMDy41vws801DLin8/B/65FrcxeUVg0Q3hoNAdcILiV+NbPlRKhPJ/VGhaIGTAI4a2GVAMjw==
X-Received: by 2002:adf:cd05:: with SMTP id w5mr4092671wrm.62.1600763934098;
 Tue, 22 Sep 2020 01:38:54 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id w14sm25632237wrk.95.2020.09.22.01.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 01:38:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 6/6] block/nvme: Replace magic value by SCALE_MS definition
Date: Tue, 22 Sep 2020 10:38:21 +0200
Message-Id: <20200922083821.578519-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922083821.578519-1-philmd@redhat.com>
References: <20200922083821.578519-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
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
index 959569d262f..b48f6f25881 100644
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


