Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1E7C38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FBB2078C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCdKy1Ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FBB2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQi4c-0003up-1x
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 21:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQi1m-0007KK-Nw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQi1j-00064Z-Jy
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:48:45 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jQi1j-000633-3b
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:48:43 -0400
Received: by mail-pl1-x644.google.com with SMTP id g2so4669523plo.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 18:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c8lJAVwCmeKnhToGSxPJejf/zQkt+fOUmwhjCAMz86A=;
 b=WCdKy1EysBucb9ud3Lqn5k9uruQBHR+DXNtWhSujzAg+pkXo+Ent7yyaaM7WPHbNNR
 JPfv2+jOxAaiTFlK1wyDYMXMNHB29X5B2XCg4DC8YiEI8U/mfEt8SktG7zK6/A8uBCOq
 U1SstZhomAq0bw0Ociq7MyP5qpO5DpBJMa4pr9iai8XY23vYvdjxcn5PiGuGVeY9OL1v
 Kml85EEUNdchg2rwRNYC9wTB4b9FveLydlX5z7iJObI20eiVUQgdLWG6QHMf7ALPlyeJ
 Ooz4ZyHA6YikHqcU40ZG0J3ZEwV3irJyFACKsUl42XzsyHKnyW2Lrh11wY+JcJ3M0iV3
 JgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=c8lJAVwCmeKnhToGSxPJejf/zQkt+fOUmwhjCAMz86A=;
 b=dod20qzGxHyIBwJkHe2vJYxdSsmNub/9nJoDOyE7ej/MBoxci+viDvqEn5mlsuUS8z
 FqZ8bym4jqOWj22qlFrv+d4CjWvFJlNsQGSRAB9qklkfijKlaVWLWdH0XiaQ8EQXeOlD
 hmYjYYLY1mpAbDX9YhMHkpfur3StAZqNwk2iny4QCKyuP0L44rVsAs2mtHdopYIB2WWB
 V3YA8LQXz5K/Guw2C34BvndPQ5oIeGwwHPV3a2QYr/1hSDi3F1u7n3fj3u04G9v1BLLe
 OMbX4240A0Oq2ctSn4Ys6OtE8c9q7qGT7+dvE3I2NcfuJu3ihmkx17B/SiZmtmkpfbSw
 lYkw==
X-Gm-Message-State: AGi0PuZXZ1cyQYoiw01oCPJ6+he39tZANP03ZEfvsVEZGvEiCblGdYeS
 uh5PYcpAh+Hy1uOnq+n16XU=
X-Google-Smtp-Source: APiQypJmmgytUw5RKush8kUd7ADPdC8tPsA9rNmvYWN9md9pmehTb4BdaSjuOVVOqMy7fsOwIB896A==
X-Received: by 2002:a17:902:b7cc:: with SMTP id
 v12mr13713995plz.39.1587433721185; 
 Mon, 20 Apr 2020 18:48:41 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id q11sm654868pgs.25.2020.04.20.18.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 18:48:40 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 6/7] wire in the dwc-hsotg (dwc2) USB host controller
 emulation
Date: Mon, 20 Apr 2020 18:45:50 -0700
Message-Id: <20200421014551.10426-7-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421014551.10426-1-pauldzim@gmail.com>
References: <20200421014551.10426-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=pauldzim@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wire the dwc-hsotg (dwc2) emulation into Qemu

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         | 21 ++++++++++++++++++++-
 hw/usb/Kconfig                       |  5 +++++
 hw/usb/Makefile.objs                 |  1 +
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 5e2c832d95..3b554cfac0 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -128,6 +128,13 @@ static void bcm2835_peripherals_init(Object *obj)
     sysbus_init_child_obj(obj, "mphi", &s->mphi, sizeof(s->mphi),
                           TYPE_BCM2835_MPHI);
 
+    /* DWC2 */
+    sysbus_init_child_obj(obj, "dwc2", &s->dwc2, sizeof(s->dwc2),
+                          TYPE_DWC2_USB);
+
+    object_property_add_const_link(OBJECT(&s->dwc2), "dma-mr",
+                                   OBJECT(&s->gpu_bus_mr), &error_abort);
+
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
                                    OBJECT(&s->sdhci.sdbus), &error_abort);
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
@@ -385,6 +392,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_HOSTPORT));
 
+    /* DWC2 */
+    object_property_set_bool(OBJECT(&s->dwc2), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, USB_OTG_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dwc2), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->dwc2), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_USB));
+
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
     create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
     create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
@@ -398,7 +418,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
-    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x1000);
     create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
 }
 
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 464348ba14..d4d8c37c28 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -46,6 +46,11 @@ config USB_MUSB
     bool
     select USB
 
+config USB_DWC2
+    bool
+    default y
+    select USB
+
 config TUSB6010
     bool
     select USB_MUSB
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 66835e5bf7..fa5c3fa1b8 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -12,6 +12,7 @@ common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
 common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
+common-obj-$(CONFIG_USB_DWC2) += hcd-dwc2.o
 
 common-obj-$(CONFIG_TUSB6010) += tusb6010.o
 common-obj-$(CONFIG_IMX)      += chipidea.o
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 7a7a8f6141..48a0ad1633 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -27,6 +27,7 @@
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
 #include "hw/timer/bcm2835_systmr.h"
+#include "hw/usb/hcd-dwc2.h"
 #include "hw/misc/unimp.h"
 
 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
@@ -67,7 +68,7 @@ typedef struct BCM2835PeripheralState {
     UnimplementedDeviceState ave0;
     UnimplementedDeviceState bscsl;
     UnimplementedDeviceState smi;
-    UnimplementedDeviceState dwc2;
+    DWC2State dwc2;
     UnimplementedDeviceState sdramc;
 } BCM2835PeripheralState;
 
-- 
2.17.1


