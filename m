Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BBC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 00:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF772084F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 00:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjZLePDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF772084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUgz5-0005Fu-06
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 19:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iUgtN-0001Oe-Rh
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iUgtM-0005I7-VF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:52:17 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iUgtK-0005HW-VW; Tue, 12 Nov 2019 19:52:15 -0500
Received: by mail-pg1-x542.google.com with SMTP id z24so172447pgu.4;
 Tue, 12 Nov 2019 16:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lmFvZZZEGHi/jNPzB8Fjz4VckveQEY65n8jFgmWLQrs=;
 b=cjZLePDojxTtnAfrXn6gz0h083D/nJMCELvufI7vORDlrOAy0wWlMh6k2DjlsgGfQn
 ZXEFkMAKYM2JmqLMdNbYcJ0jFRryIRyXMlMOr2nqsn6hXUB2OlK1xYQcDZEoU9UV+oTq
 mcapQVvF1cfnOsAzCrQIm6IJI4irBOZGPcJXqNLK9ax3gbEtKOqrs+mdJcaIUDU7npIt
 zBRFypimS5uj00visXxZnnrlqVrf7kXksV+Y0XA4rXSgK7zccKIfSk3qlLizi/3vbFi0
 MtHxsfpJkDYZQDcF+viTfyXZyV81fNKE048APNTy6lWFTswCL1iNh5ym165ujTExXiLI
 Xn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lmFvZZZEGHi/jNPzB8Fjz4VckveQEY65n8jFgmWLQrs=;
 b=ezetE7p+GxlOL1xf/yNrNnQKuKTpweSEBWbWDrYoyzEHEA+IaRILmDx7iB0kAOfFxU
 T65jqHHOZtPsnJtGC9PoL1xJpy3RnzUEnjOj1Tc4Hy5rfkHNrtkBLLxgHIpG4zO9sUMb
 dvT4fGPJcjrGhHDoud5bjGHI6sNi0HYP5l8vgcTU7YfyXTa1apOzzJaZEV48Zx0PKxf7
 Bd19KX0aozLJCHM+e0HBdI99IEyrenwzL31aNxDaeUQmyhs9a0KlxTscX30W/Gt9vZbh
 PXdDTc4ECNZd3adyj+CwUVeoOcHHMkgHkOLsJf3zylmwUF9xzpgXgCyuc6xa/iKi7ZMi
 HLmw==
X-Gm-Message-State: APjAAAUam6bSoelSHfamNAdnB3lyAlrjfHMoU9Cs9dPO2XxyConatHzh
 e611UT8ybP/oaj1VQOqxKSQ=
X-Google-Smtp-Source: APXvYqy3swK84ZQosXBDvPju/0PxJ/OHldwWE98YcEkKr5UYVjGLZb6S/ZvDgeDgBUzZpM5NNYxrzw==
X-Received: by 2002:a65:5542:: with SMTP id t2mr478788pgr.74.1573606333758;
 Tue, 12 Nov 2019 16:52:13 -0800 (PST)
Received: from voyager.ozlabs.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id i13sm169848pfo.39.2019.11.12.16.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 16:52:13 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 1/4] aspeed/sdmc: Make ast2600 default 1G
Date: Wed, 13 Nov 2019 11:21:58 +1030
Message-Id: <20191113005201.19005-2-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113005201.19005-1-joel@jms.id.au>
References: <20191113005201.19005-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

Most boards have this much.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_sdmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index f3a63a2e01db..2df3244b53c8 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -208,10 +208,10 @@ static int ast2600_rambits(AspeedSDMCState *s)
     }
 
     /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
+    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
                 s->ram_size);
-    s->ram_size = 512 << 20;
-    return ASPEED_SDMC_AST2600_512MB;
+    s->ram_size = 1024 << 20;
+    return ASPEED_SDMC_AST2600_1024MB;
 }
 
 static void aspeed_sdmc_reset(DeviceState *dev)
-- 
2.24.0


