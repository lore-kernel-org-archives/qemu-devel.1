Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA2FC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236F620829
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwOM8ZXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236F620829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNao-0004UM-4p
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPr-0001nx-IJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:27 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPp-0004hT-9A
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:27 -0400
Received: by mail-wr1-x434.google.com with SMTP id n15so1553861wrq.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Zhf3AwHffn8y3rxo+99ENZuySCfocQn9p27AO6bAdpo=;
 b=lwOM8ZXKBMxqwbFdDm33F4z8CmFcUiNk9hYRh+T9w1CrJBQCMLOY4LZhHCbphl+qDj
 h3aRgbCcPnTNVETde28PJLKiSvdSw6wT3TeiqjetiuJgvh/M/Jyrz0yHP5mBXnqbiSKI
 bJvyAV6uV1r/9aBVQ9v0hfM1mRHOTNP6zvX9Cf8CmpBT9CnNsj/4PqpTOa4GPYf9Hc8g
 x0VOXldbtzWhAAkVUIyp/jaPxKfdFh2iykQBoTmAi541x8Thejl2NCRDmCzbgg9f5lbs
 OhI4ESdZYa+xQq8KRkVHsvcW9ydIA5VvqJSDUqQTvk8Qlg6MbafLVGX6QOjYm0BrvW5h
 eLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zhf3AwHffn8y3rxo+99ENZuySCfocQn9p27AO6bAdpo=;
 b=ES0ipaswvCRjrFq0VwcOVV5JBtuIXG7gdd7c9svsSqlKHgn4NVMJXxfO4gjOwqB1mQ
 yr6saMwk7jqa27oS5rJLtg2g+E0MdBCGINC1ARK4QQY0rxmZ9VhyMfOpjwURgZ61LPSf
 j1zR1Or5kcUUkWvxfxBhl8G/XcaGREek6dKeMaeO09b/Dpx19xKH2t8u73GFghAjqKqQ
 rV+WnuLfBZjV7Gi/P8O/LQCHXN68lSmcX+ybNr+d515LMFKuovzRcDYKBy/b7FNqKLwI
 5ILgAFU6ro1V7jHnOFrLnFWMK8JZ1JL8hiV63MvuNdZRhgaYA3shEH+b6fqIGPiFa37N
 3zgA==
X-Gm-Message-State: AOAM53357gdSUtPPclitVdJc4usmYv30RChcyaJRz8H2ln4Al4Mx+7gw
 rFx5H+sHElhqM5Wr2sbMARMXe4tJlk5qUw==
X-Google-Smtp-Source: ABdhPJwWPQjr5P10gLVVOsya1Ozy2xj3cRcOuDc9wGhGa55bUY/HFHcNRW6aSk5GeYcFTsr0ThF5og==
X-Received: by 2002:adf:bb43:: with SMTP id x3mr2394130wrg.250.1603799121533; 
 Tue, 27 Oct 2020 04:45:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/48] hw/arm/raspi: fix CPRMAN base address
Date: Tue, 27 Oct 2020 11:44:23 +0000
Message-Id: <20201027114438.17662-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Luc Michel <luc@lmichel.fr>

The CPRMAN (clock controller) was mapped at the watchdog/power manager
address. It was also split into two unimplemented peripherals (CM and
A2W) but this is really the same one, as shown by this extract of the
Raspberry Pi 3 Linux device tree:

    watchdog@7e100000 {
            compatible = "brcm,bcm2835-pm\0brcm,bcm2835-pm-wdt";
            [...]
            reg = <0x7e100000 0x114 0x7e00a000 0x24>;
            [...]
    };

    [...]
    cprman@7e101000 {
            compatible = "brcm,bcm2835-cprman";
            [...]
            reg = <0x7e101000 0x2000>;
            [...]
    };

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h | 2 +-
 include/hw/arm/raspi_platform.h      | 5 ++---
 hw/arm/bcm2835_peripherals.c         | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index c9ac941a82c..6aa94184eb9 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -47,8 +47,8 @@ struct BCM2835PeripheralState {
     BCM2835MphiState mphi;
     UnimplementedDeviceState txp;
     UnimplementedDeviceState armtmr;
+    UnimplementedDeviceState powermgt;
     UnimplementedDeviceState cprman;
-    UnimplementedDeviceState a2w;
     PL011State uart0;
     BCM2835AuxState aux;
     BCM2835FBState fb;
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index c7f50b260f6..e0e6c8ce94a 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -45,9 +45,8 @@
 #define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 (SP804) */
 #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0 (ARM) Semaphores
                                                       * Doorbells & Mailboxes */
-#define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
-#define CM_OFFSET               0x101000 /* Clock Management */
-#define A2W_OFFSET              0x102000 /* Reset controller */
+#define PM_OFFSET               0x100000 /* Power Management */
+#define CPRMAN_OFFSET           0x101000 /* Clock Management */
 #define AVS_OFFSET              0x103000 /* Audio Video Standard */
 #define RNG_OFFSET              0x104000
 #define GPIO_OFFSET             0x200000
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 48909a43c32..10ed418e28e 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -354,8 +354,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 
     create_unimp(s, &s->txp, "bcm2835-txp", TXP_OFFSET, 0x1000);
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
-    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
-    create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
+    create_unimp(s, &s->powermgt, "bcm2835-powermgt", PM_OFFSET, 0x114);
+    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x2000);
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
     create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
-- 
2.20.1


