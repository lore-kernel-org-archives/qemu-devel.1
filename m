Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E846C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FB8206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqAWoWpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FB8206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilsz0-0001mM-63
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 06:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvz-0005Wo-AT
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvy-00038a-0T
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:03 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvx-00038J-QE; Mon, 30 Dec 2019 06:10:01 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so32333596wrw.8;
 Mon, 30 Dec 2019 03:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N8YaSe87ak8uhHmiFp5CcDUPJZv1Grr3iIYPennz/Fg=;
 b=pqAWoWpJK71sx/Jygy1TAsWw9WBir7sjma/NtvScrYwW4w/zun0VShlyr7KPOj5l1Y
 CdXaYT0yumPDS6/JYQE8DXzDHmQUqBb+HP3gVBKsB7as1SRH8kdnX+8HblR1byQg4UdD
 K5F2a8Zt45M/AfVo5DsHFRsM5Pi6cvyREax74Wp5hDSlriecEWZJT8D4wF4rWsWgBwtY
 HbST8dO7yrUfJ+YipMt1Y66DTm2gXV1GMTd2BqhcJVik2n33FXpc7mn1aft5xuCaCeug
 uyi+1A9VkOx2GTtqdp+Im3A7cVHtVKu2K5SgQ3L2GE5BTw5mZ86DSPV2tPd/M2/njnMW
 0ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=N8YaSe87ak8uhHmiFp5CcDUPJZv1Grr3iIYPennz/Fg=;
 b=He3GvTrGmuugk1xtnljsgEhkXWhb3tXm0OtrW36ydsWfZo6MjMQ7jdnFQPK+oAv2OB
 GZo/N9cy6xtKaNH+QikWTqG0S3ZysJHtBQSbPHANJqJajswHNjBKIPdCIJNOjEm4CW4Z
 eQUePTdJlhkC9p1GlREi3U1j2ZKQX+zWv/IhD1GcgIoYOauO29ysajX0JYOeRGD2sFiq
 5gYxPgaaru3o5a0obJSCGslQLy16rRCwjcZrtQ6HW6gUlDz7FAUZNheeAFVNwkjfhAY0
 x4fsz8tIVyXAscgFBqAVArKnb/f0Ze4O+kzxwGqBs/5J7B8u2523Pv67SCMO+eaqTsGn
 0yBw==
X-Gm-Message-State: APjAAAX1CghQrOxKwLh7iqFI9Cn/YSZazqVtKN2rQl+TMD780j2T7356
 jUXeCOtb5Bvjqaz1ccl1OS9xGXjEBQw=
X-Google-Smtp-Source: APXvYqyzaM+xC09z7CU/Fu5tXjFqT9yeosSG2EHnEfpAuGzSfexIxtXgQ2RRt2IpyTeN9BIw0fj1nw==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr65591723wrq.67.1577704200633; 
 Mon, 30 Dec 2019 03:10:00 -0800 (PST)
Received: from x1w.redhat.com ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id p15sm20442738wma.40.2019.12.30.03.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2019 03:10:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] hw/arm/allwinner-a10: Simplify by passing IRQs with
 qdev_pass_gpios()
Date: Mon, 30 Dec 2019 12:09:51 +0100
Message-Id: <20191230110953.25496-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191230110953.25496-1-f4bug@amsat.org>
References: <20191230110953.25496-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By calling qdev_pass_gpios() we don't need to hold a copy of the
IRQs from the INTC into the SoC state.
Instead of filling an array of qemu_irq and passing it around, we
can now directly call qdev_get_gpio_in() on the SoC.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/allwinner-a10.h |  1 -
 hw/arm/allwinner-a10.c         | 24 +++++++++++-------------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 941c61e533..40d0b1d9c0 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -23,7 +23,6 @@ typedef struct AwA10State {
     /*< public >*/
 
     ARMCPU cpu;
-    qemu_irq irq[AW_A10_PIC_INT_NR];
     AwA10PITState timer;
     AwA10PICState intc;
     AwEmacState emac;
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 0f1af5a880..966fbd4a6e 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -55,7 +55,6 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 {
     AwA10State *s = AW_A10(dev);
     SysBusDevice *sysbusdev;
-    uint8_t i;
     qemu_irq fiq, irq;
     Error *err = NULL;
 
@@ -76,9 +75,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(sysbusdev, 0, AW_A10_PIC_REG_BASE);
     sysbus_connect_irq(sysbusdev, 0, irq);
     sysbus_connect_irq(sysbusdev, 1, fiq);
-    for (i = 0; i < AW_A10_PIC_INT_NR; i++) {
-        s->irq[i] = qdev_get_gpio_in(DEVICE(&s->intc), i);
-    }
+    qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);
 
     object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
     if (err != NULL) {
@@ -87,12 +84,12 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     }
     sysbusdev = SYS_BUS_DEVICE(&s->timer);
     sysbus_mmio_map(sysbusdev, 0, AW_A10_PIT_REG_BASE);
-    sysbus_connect_irq(sysbusdev, 0, s->irq[22]);
-    sysbus_connect_irq(sysbusdev, 1, s->irq[23]);
-    sysbus_connect_irq(sysbusdev, 2, s->irq[24]);
-    sysbus_connect_irq(sysbusdev, 3, s->irq[25]);
-    sysbus_connect_irq(sysbusdev, 4, s->irq[67]);
-    sysbus_connect_irq(sysbusdev, 5, s->irq[68]);
+    sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(dev, 22));
+    sysbus_connect_irq(sysbusdev, 1, qdev_get_gpio_in(dev, 23));
+    sysbus_connect_irq(sysbusdev, 2, qdev_get_gpio_in(dev, 24));
+    sysbus_connect_irq(sysbusdev, 3, qdev_get_gpio_in(dev, 25));
+    sysbus_connect_irq(sysbusdev, 4, qdev_get_gpio_in(dev, 67));
+    sysbus_connect_irq(sysbusdev, 5, qdev_get_gpio_in(dev, 68));
 
     memory_region_init_ram(&s->sram_a, OBJECT(dev), "sram A", 48 * KiB,
                            &error_fatal);
@@ -111,7 +108,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     }
     sysbusdev = SYS_BUS_DEVICE(&s->emac);
     sysbus_mmio_map(sysbusdev, 0, AW_A10_EMAC_BASE);
-    sysbus_connect_irq(sysbusdev, 0, s->irq[55]);
+    sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(dev, 55));
 
     object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
     if (err) {
@@ -119,10 +116,11 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0, AW_A10_SATA_BASE);
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, s->irq[56]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, qdev_get_gpio_in(dev, 56));
 
     /* FIXME use a qdev chardev prop instead of serial_hd() */
-    serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2, s->irq[1],
+    serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2,
+                   qdev_get_gpio_in(dev, 1),
                    115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
 }
 
-- 
2.21.0


