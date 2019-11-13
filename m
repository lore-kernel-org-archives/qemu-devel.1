Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28096C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21256206EE
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkaX2O2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21256206EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV137-0006pS-0M
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iV0tE-0001pX-Cf
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iV0tD-0001FI-4l
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:13:28 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iV0tA-0001Bs-Qc; Wed, 13 Nov 2019 17:13:25 -0500
Received: by mail-pl1-x641.google.com with SMTP id ay6so1669897plb.0;
 Wed, 13 Nov 2019 14:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8TuERMwKIX0IjYAYBvRG+/eE8by9a0Ql/FHpjEAjdkQ=;
 b=RkaX2O2KL449KlwuavPI5G3WFShvPSTM220WZKzvW+dJG+PEJT2rW0Xtzr/MLxpVYF
 3X7dH1TNU79qU5/f2jRBWhs9z+Oz/vi3y/S5XpmZNDJfLo1PssI6oTQkwElHL/AMDpSV
 G+Xc4O9U/wW3Q0Dq+fQta/OFWLnO/5X4gN3vH92HZ8LG0WpvhdAkIZvdCax7hz68ef+j
 si0MEVK9piF2FgBjPz56iG45PweJ9JsM3kPnuEGPnDVd1lUoNdToDUPRhz8pY5+URkY4
 HXiH1XbLLK8gZEWAPc47e+FWG2vpKdL07T8E57kRbiyH8pkUSqkQAY6t64qzmPx8vBBt
 IEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8TuERMwKIX0IjYAYBvRG+/eE8by9a0Ql/FHpjEAjdkQ=;
 b=mAw7l+A42OKeGN3L1QZP9V7Kut0JBZiooKPh/ifk+7hjOdzMzVdAExxGyx2vsYWTCU
 XG83GXKio0TDKlTZKb0gA4ilC05215n4y73H0UgKLGyzmnsutuBqUT6AwV7c4WFRV1M4
 cHRCAnPvE8L1Izx7zJNoLiKDaDp1iRd9s4nBMdprKYIDEqp82pAvNT87zqKh5F9jRk2q
 KQRm7Nh5PwcagityMSmeVhAkK4nA/abx/E5QfwiPZYFJTpK1LlFvgnJVzikstt6wFi7K
 ctURP6ExD4OWWCAYYTs618GEhOhRSb53AeMNbANFmJw7CmecRicgUZ/UzOapdxRhYEik
 v+uA==
X-Gm-Message-State: APjAAAVjyMOtYx5zY8d+DJ7pd+R3rty3Vd+dCecXuxWddBMNiyhSPdLX
 c57bB6Jg/CIautubnqj73Es=
X-Google-Smtp-Source: APXvYqzymcyJv5GoP2UKH/+bKz7Dd3hKoRQIdWSHmhloYF+NVbzlspE+ovxuS+sua3Du9zgR2DAX8w==
X-Received: by 2002:a17:902:82c7:: with SMTP id
 u7mr5770045plz.31.1573683203708; 
 Wed, 13 Nov 2019 14:13:23 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
 by smtp.gmail.com with ESMTPSA id w69sm5252005pfc.164.2019.11.13.14.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 14:13:23 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3 3/4] watchdog/aspeed: Improve watchdog timeout message
Date: Thu, 14 Nov 2019 08:43:00 +1030
Message-Id: <20191113221301.8768-4-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113221301.8768-1-joel@jms.id.au>
References: <20191113221301.8768-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Users benefit from knowing which watchdog timer has expired. The address
of the watchdog's registers unambiguously indicates which has expired,
so log that.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Use HWADDR_PRIx
v3: Fix spacing
---
 hw/watchdog/wdt_aspeed.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 145be6f99ce2..d283d07d6546 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -219,7 +219,8 @@ static void aspeed_wdt_timer_expired(void *dev)
         return;
     }
 
-    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
+    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer %" HWADDR_PRIx " expired.\n",
+                  s->iomem.addr);
     watchdog_perform_action();
     timer_del(s->timer);
 }
-- 
2.24.0


