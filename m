Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CD6C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 00:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D61C21872
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 00:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lePXLF7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D61C21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUgwA-0003Cg-M3
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 19:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iUgtT-0001VD-Vq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iUgtT-0005K0-1P
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:52:23 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iUgtQ-0005JE-VB; Tue, 12 Nov 2019 19:52:21 -0500
Received: by mail-pg1-x544.google.com with SMTP id l24so150809pgh.10;
 Tue, 12 Nov 2019 16:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aNfFczhM8NYMoBpUcEwP04hyJCPiYk7J/QnyzWmI2l8=;
 b=lePXLF7AcSFkiDMl6Or4EyDx6Sa5+DayZIMfs8WYoO61KhqXFZdHA2BYG+jWj6t87l
 O/mtH/omXWKOtO2Ogig7yUxIj6Naq/nHLm1HmZGb4vCWyKrnE11m558QfaKmvdlTPey9
 T8EHF42FPTUJRX/lPWYfuJbWyqTv672XJkC+elSQMZvGWJcy0yxl2VI0/SG+AJwB7ETH
 Ul+zQFBO0w0x4VcxpRkP5aYxLkFnj4TIlfS+XoANp1BlJK/NvKqgaiwPwdXMyp8js4Y0
 WOUJb0UgJghKvEyJAOw5UfvMW0NfZzq1sNR+HHdux8V0J9/JGdLzajnO46uBoIPN/snP
 Na9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aNfFczhM8NYMoBpUcEwP04hyJCPiYk7J/QnyzWmI2l8=;
 b=Q1vbK9lK/Ch28B2KwpOTurG6wEWTOWBIvDjotey71hDJqLa/hUkYAsrN2MmX8oxsXe
 bOXBgSo72TlRU/uAfk2XWXjw+McVtLMVabLymcex8/gtEugA7slz5Bk0sjMMxxBIuNYo
 yLRUMKSumM54JhSEWSuTko49BvB6k9oOXYjHsUBIaQskpLK1u8lLXBPGAJp85v7jsYO0
 ptGKpqMh+pZJR7l7fy9xtyWszGxWhPauypZV88iXdROykva2C/GFJWlUME4+61gd+lq1
 /hwXRx8XpM1brb8e50LKqXzkSMPO/Q21tdRGp/a4h2U6DkLApYOKiRD5BLeD9Tczg6s4
 87Og==
X-Gm-Message-State: APjAAAUBl5o/IzLpERqr5TXkryCdk4uJDQq4O1vfUqs/ec/sHSs8an9r
 EPdR15AyQXvCFnqdSNHgTF8=
X-Google-Smtp-Source: APXvYqzaZR0YirggX2ER41wzyMX4gPg5r9s+OsA6a96F3FNdJBFn5QwMH4cEhhdv8wBdx/9qQ67MVA==
X-Received: by 2002:aa7:9314:: with SMTP id 20mr897065pfj.231.1573606339846;
 Tue, 12 Nov 2019 16:52:19 -0800 (PST)
Received: from voyager.ozlabs.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id i13sm169848pfo.39.2019.11.12.16.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 16:52:19 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 3/4] watchdog/aspeed: Improve watchdog timeout message
Date: Wed, 13 Nov 2019 11:22:00 +1030
Message-Id: <20191113005201.19005-4-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113005201.19005-1-joel@jms.id.au>
References: <20191113005201.19005-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Users benefit from knowing which watchdog timer has expired. The address
of the watchdog's registers unambiguously indicates which has expired,
so log that.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Use HWADDR_PRIx
---
 hw/watchdog/wdt_aspeed.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 145be6f99ce2..8787c5ad0f97 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -219,7 +219,8 @@ static void aspeed_wdt_timer_expired(void *dev)
         return;
     }
 
-    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
+    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer %" HWADDR_PRIx " expired.\n",
+            s->iomem.addr);
     watchdog_perform_action();
     timer_del(s->timer);
 }
-- 
2.24.0


