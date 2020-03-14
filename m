Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A7EC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4882A2072A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbaBZBD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4882A2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDAbt-0004U1-ER
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 13:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jDAZg-0007xL-DP
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jDAZf-0005pH-Am
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:48 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jDAZf-0005kg-4m; Sat, 14 Mar 2020 13:27:47 -0400
Received: by mail-pg1-x544.google.com with SMTP id b22so930154pgb.6;
 Sat, 14 Mar 2020 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7TmW4s4JB9EMXPFhnrWNp7SZXHVbJpUn5YaMe/I2UDc=;
 b=MbaBZBD0xxWU9k7ksA4PNKnBsSjdpcq/sqrQETnHUk/0UUCI6B3bXM6GqhZTBFRsDA
 hWJdiJMoDNkOjZrZs4YDkScSj1YRGA+L+aamRCpBYNjkBwO9rv/qYmPZobdRx31z485O
 yKrOAAoW3T6k7eDvMH7c0eW6d7uW/9C58qXxhVAW4EmZYGNhjQK3REs257kC3JndWMVm
 TcFThPqmUfqamcvQo+1OsgPKYL0Oazn/lcyC91FJpfZUhFsvSeSVTGaGiqHP17uPNxFJ
 1m+D4IxGx1CK65Fn7+rUxQZ0ggrRdcGDjGdFWUFSMIqTaQjG2EsUzPt1U9zd8jK5pOIP
 xEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=7TmW4s4JB9EMXPFhnrWNp7SZXHVbJpUn5YaMe/I2UDc=;
 b=kh2QcDaRSAcPGH1nBYLjkFcrTErTY/lpFFy6p3ejvs/15Vb2NkxQb9RdrdAm6AHd+l
 euFM+Wr/2vE5cFTqVlXQWV2jHIXvLQbCC6ZpG4Vllhf0goFa+6DhnD4/8/58n/LJI+Ib
 XehugNtijTGt4whjpElh771AmHSyrww0yv3IrCFR3nLxn9d6g4lkX9iGvgFVSvD3Zdys
 wfCFqSFfvc5ahGC49na+vCka5LC7T21edGmniqugxHn/FDy8RyL4trphlJQWvjHcdoW3
 QqrcsZ7cisqoBgCBtzivjMVIXdT2F4UrJAop9/hOZ5dvzeO8EQGNVimCpcL1xoQNUytm
 Ehzw==
X-Gm-Message-State: ANhLgQ2f7gvTLJoUYxBX9jkVk6Rv48ANbUcdB8cbF2LqKDLaXlaXxxqR
 NoS0K/rhI9/p6ac5p0SEMrs=
X-Google-Smtp-Source: ADFU+vuN3goJ+jg/kFW2zbYRzMRrN51X8xt6DI4WHN9mbRBmaYKKB3ogK5tJ7L1W+B814BXcWf3nMw==
X-Received: by 2002:a63:309:: with SMTP id 9mr18829326pgd.193.1584206866335;
 Sat, 14 Mar 2020 10:27:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id c201sm16745005pfc.73.2020.03.14.10.27.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 14 Mar 2020 10:27:45 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 5/8] hw/arm/fsl-imx6: Connect watchdog interrupts
Date: Sat, 14 Mar 2020 10:27:33 -0700
Message-Id: <20200314172736.24528-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314172736.24528-1-linux@roeck-us.net>
References: <20200314172736.24528-1-linux@roeck-us.net>
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
 hw/arm/fsl-imx6.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index ecc62855f2..b266d40881 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -397,11 +397,20 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
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


