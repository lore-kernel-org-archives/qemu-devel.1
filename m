Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C08AC1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A7A206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaIOtcCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A7A206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG85J-0000qw-4Z
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 17:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jG80Q-0002uW-DC
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jG80O-0002lV-EW
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:37 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jG80M-0002kX-Jb; Sun, 22 Mar 2020 17:19:34 -0400
Received: by mail-pf1-x443.google.com with SMTP id j10so6439773pfi.12;
 Sun, 22 Mar 2020 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DftWBiWkjHoKVvHzazigRJcybZQA/gcmEJAYkticqjM=;
 b=WaIOtcCb17Zog3YpnvEEY/8+Dn5U/BnaF56cBLZ+i2QYTG7xapW5WfZZhPDPGVG9wz
 oGEcO+7WMmYdCu+WC6IBPykiPTjuu5IqK/iZ4rIEBjHzY8PoyLhvPbngQreesWdGJtWT
 pAJfhNW3RVAkN3jgBa/7wWyi49YR+hjg7wMMW33YXy3NWSCZ7KogUOjzKS5cyKMdyebh
 yqN6FqdfCAcWxj1TAfetgDBvMcDfahAyS431/rkDIRqUjx6DQf5SMexTY6DZIaC94Vq0
 QDjHCwS9zLkZX6pAZsmpiv21l9F9RGqHvhPvxwn5+vElcJY5BezvMC83ep6p/tN8y25D
 uFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=DftWBiWkjHoKVvHzazigRJcybZQA/gcmEJAYkticqjM=;
 b=hsZCnovk6Itmb0uFTw02M8Gk/XK6thvYCQPD1HBTwRhqEzFYRHLlqXp51avyKX/9pl
 9DPoRDP9/YIVjOwrnD76oPA7vuy6MWFGGVAqeNrnbq78cvK2x4bsGNnLR76HUr8kBNph
 rJaHyPCUU7PY7NxSgRpwGY7YkfAXFVGhJqNj1CHK5M5rzEVl5eXi0JN+Bsq9k4lH0Rcd
 ePJHp5SRTp+dD8Ka2iXOz1lqhPWSIRwhjr+ssJXjD9oW1Zygzs2w4TD0lTTGn1R2C/gS
 l6MZpsRRoYssL5Yo3DjCPKWSWxGtziDxtbumR38QfDlL9jneMwdhgb5qFtfbgMJ00E2q
 YF2g==
X-Gm-Message-State: ANhLgQ2IBNtdByE6mbOM3TXaZhFadxbkPHxsbxXXaTE/fMhgA7atObez
 DE4Rk0VIdUtbgy8jf7Up3Rg=
X-Google-Smtp-Source: ADFU+vt5eHLnkiRDN8cuMIeckZZIYPenSzzpJieobSC++It0NtSPhKZaSVljBf3+ZbEXduRG4wVpkA==
X-Received: by 2002:aa7:9af8:: with SMTP id y24mr21912508pfp.91.1584911973602; 
 Sun, 22 Mar 2020 14:19:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id k189sm10446306pgc.24.2020.03.22.14.19.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 22 Mar 2020 14:19:33 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 5/8] hw/arm/fsl-imx6: Connect watchdog interrupts
Date: Sun, 22 Mar 2020 14:19:16 -0700
Message-Id: <20200322211919.11335-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322211919.11335-1-linux@roeck-us.net>
References: <20200322211919.11335-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this patch applied, the watchdog in the sabrelite emulation
is fully operational, including pretimeout support.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 hw/arm/fsl-imx6.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 13f1bf23a6..f58c85aa8c 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -433,11 +433,20 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             FSL_IMX6_WDOG1_ADDR,
             FSL_IMX6_WDOG2_ADDR,
         };
+        static const int FSL_IMX6_WDOGn_IRQ[FSL_IMX6_NUM_WDTS] = {
+            FSL_IMX6_WDOG1_IRQ,
+            FSL_IMX6_WDOG2_IRQ,
+        };
 
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
+                                 &error_abort);
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
                                  &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_ADDR[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
+                                            FSL_IMX6_WDOGn_IRQ[i]));
     }
 
     /* ROM memory */
-- 
2.17.1


