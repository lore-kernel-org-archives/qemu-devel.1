Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C24C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785C22072A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBdvXm6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785C22072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDAc9-0004pe-Lr
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 13:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jDAZk-00086s-Jo
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jDAZj-0006At-HE
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:52 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jDAZj-00068E-B9; Sat, 14 Mar 2020 13:27:51 -0400
Received: by mail-pf1-x444.google.com with SMTP id n7so7243349pfn.0;
 Sat, 14 Mar 2020 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2yvrzU4TfZKPLfKcAijb7xS2WSEBvTCKiwAF8gWuxus=;
 b=iBdvXm6Kp49rDZXAqy0db/ArZEH7T9otnlsN3BUzh5zl7wbHdta3ie5yDW1fE/qjA8
 mDxlEkSYSn78d5Ec1gUJsPbQBH0Y9TkvSV0kwfnYdaVe5tS9O1Yy9e5XAxIe77BAVGk+
 WDuNpF2RNX+JHQinZPuKzf4Et4nPb/nuZfRFtsRJjP6yjnqq2b6Budlsjzcm+VrQ5FIX
 nvSsnlpoviPc5trI+ZVzWNo20beIebaf/Bf7g0w/HJu8pZnCP9njKhcXLIJy1Ft59mn0
 hi/hZtZMejzkeqN1Cp8DQFT+DrELqdPXXthibuBAcL+d9nYBpXSyxWuolIUOiSP66xKe
 Cgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=2yvrzU4TfZKPLfKcAijb7xS2WSEBvTCKiwAF8gWuxus=;
 b=LGGtFJGWTNeIPTpNTJNN9ZZZH5P/bib8ojt0HV7yOlAmE2Jm7OIho+s7WGp2OTVlZM
 CkUHLt9OwVs13BJQpa1YTjRy2ObXOrV+9jaltsp1YdqdZIX7hExwUvcFjK4Ox08uF5JX
 lHEwBDoYFYTzRS8kT9gaip70K0dGY9r1rwaUwcaL6MEHJANjOUa5mA/NJ83KbmAcRFSf
 kfL8A9Z78EtytHVKzb9C6aiERAj7/nvJngeOX3OibJgLKHP+Mu5++MKxFt23ptWevAVL
 QAhMqpRpTVdLBAQyV/FBKsPyPfpjuoVEISsJZONzou5QfXWJbOO2vMWI7MCVyNXuPeOv
 PlRQ==
X-Gm-Message-State: ANhLgQ3lwnK8cMi3fLnjZ/WJM7px5NiEbHTVzuVyI6d2hNz090/QXa0E
 Q3DkwOnZsqdR5KhmlJxce7A=
X-Google-Smtp-Source: ADFU+vtLewS5G4NuIpA3nj3oljUuFDksk8gmeHvKa5p843ExmPZkvwVhNENjanfcbUYsy6gUJZtOpQ==
X-Received: by 2002:a62:1417:: with SMTP id 23mr18441250pfu.55.1584206870508; 
 Sat, 14 Mar 2020 10:27:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id g19sm61543370pfh.134.2020.03.14.10.27.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 14 Mar 2020 10:27:50 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 8/8] hw/arm/fsl-imx7: Connect watchdog interrupts
Date: Sat, 14 Mar 2020 10:27:36 -0700
Message-Id: <20200314172736.24528-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314172736.24528-1-linux@roeck-us.net>
References: <20200314172736.24528-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

i.MX7 supports watchdog pretimeout interupts. With this commit,
the watchdog in mcimx7d-sabre is fully operational, including
pretimeout support.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/fsl-imx7.c         | 11 +++++++++++
 include/hw/arm/fsl-imx7.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 29382776b2..6c539c8b23 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -447,11 +447,22 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_WDOG3_ADDR,
             FSL_IMX7_WDOG4_ADDR,
         };
+        static const int FSL_IMX7_WDOGn_IRQ[FSL_IMX7_NUM_WDTS] = {
+            FSL_IMX7_WDOG1_IRQ,
+            FSL_IMX7_WDOG2_IRQ,
+            FSL_IMX7_WDOG3_IRQ,
+            FSL_IMX7_WDOG4_IRQ,
+        };
 
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
+                                 &error_abort);
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
                                  &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX7_WDOGn_ADDR[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX7_WDOGn_IRQ[i]));
     }
 
     /*
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 47826da2b7..da977f9ffb 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -228,6 +228,11 @@ enum FslIMX7IRQs {
     FSL_IMX7_USB2_IRQ     = 42,
     FSL_IMX7_USB3_IRQ     = 40,
 
+    FSL_IMX7_WDOG1_IRQ    = 78,
+    FSL_IMX7_WDOG2_IRQ    = 79,
+    FSL_IMX7_WDOG3_IRQ    = 10,
+    FSL_IMX7_WDOG4_IRQ    = 109,
+
     FSL_IMX7_PCI_INTA_IRQ = 125,
     FSL_IMX7_PCI_INTB_IRQ = 124,
     FSL_IMX7_PCI_INTC_IRQ = 123,
-- 
2.17.1


