Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E4CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD7C207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6zcUv/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD7C207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGMg-0007b5-HZ
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLF-0005gO-84
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:04:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLC-0006bx-BO
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590663889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVcKLeFWj0VSeKdG4aLNUd6u+7CARzd27MuFmScMnPw=;
 b=f6zcUv/unXJ+QQjuzx5QVlmvtqb96MPqXQwEbwnCsrScb4f7Xh6wO02xZuXXeMA6P8ruSq
 sNFVuoh9hpRzOuFFEkSdfMidUxrsxJvrJDdjWxQO/R0qhdjlvwVSD6eAY9weDQboM6u/M2
 qA/JkS0rkwkdyiudmdmwUv/Sne2n0XE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-wc5HpOncM9O1XGX0j_sLaA-1; Thu, 28 May 2020 07:04:47 -0400
X-MC-Unique: wc5HpOncM9O1XGX0j_sLaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B51D107ACCD;
 Thu, 28 May 2020 11:04:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3919019D71;
 Thu, 28 May 2020 11:04:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B78C811386A0; Thu, 28 May 2020 13:04:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/24] arm/stm32f405: Fix realization of "stm32f2xx-adc"
 devices
Date: Thu, 28 May 2020 13:04:21 +0200
Message-Id: <20200528110444.20456-2-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-1-armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

stm32f405_soc_initfn() creates six such devices, but
stm32f405_soc_realize() realizes only one.  Affects machine
netduinoplus2.

In theory, a device becomes real only on realize.  In practice, the
transition from unreal to real is a fuzzy one.  The work to make a
device real can be spread between realize methods (fine),
instance_init methods (wrong), and board code wiring up the device
(fine as long as it effectively happens on realize).  Depending on
what exactly is done where, a device can work even when we neglect
to realize it.

The five unrealized devices appear to stay unreal: neither MMIO nor
IRQ get wired up.

Fix stm32f405_soc_realize() to realize and wire up all six.  Visible
in "info qtree":

     bus: main-system-bus
       type System
       dev: stm32f405-soc, id ""
         cpu-type = "cortex-m4-arm-cpu"
       dev: stm32f2xx-adc, id ""
         gpio-out "sysbus-irq" 1
    -    mmio ffffffffffffffff/00000000000000ff
    +    mmio 0000000040012000/00000000000000ff
       dev: stm32f2xx-adc, id ""
         gpio-out "sysbus-irq" 1
    -    mmio ffffffffffffffff/00000000000000ff
    +    mmio 0000000040012100/00000000000000ff
       dev: stm32f2xx-adc, id ""
         gpio-out "sysbus-irq" 1
    -    mmio ffffffffffffffff/00000000000000ff
    +    mmio 0000000040012200/00000000000000ff
       dev: stm32f2xx-adc, id ""
         gpio-out "sysbus-irq" 1
    -    mmio ffffffffffffffff/00000000000000ff
    +    mmio 0000000040012300/00000000000000ff
       dev: stm32f2xx-adc, id ""
         gpio-out "sysbus-irq" 1
    -    mmio 0000000040012000/00000000000000ff
    +    mmio 0000000040012400/00000000000000ff
       dev: stm32f2xx-adc, id ""
         gpio-out "sysbus-irq" 1
    -    mmio ffffffffffffffff/00000000000000ff
    +    mmio 0000000040012500/00000000000000ff
       dev: armv7m, id ""

Fixes: 529fc5fd3e18ace8f739afd02dc0953354f39442
Cc: Alistair Francis <alistair@alistair23.me>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/stm32f405_soc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 4f10ce6176..c9a530eecf 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -37,7 +37,8 @@ static const uint32_t usart_addr[] = { 0x40011000, 0x40004400, 0x40004800,
 /* At the moment only Timer 2 to 5 are modelled */
 static const uint32_t timer_addr[] = { 0x40000000, 0x40000400,
                                        0x40000800, 0x40000C00 };
-#define ADC_ADDR                       0x40012000
+static const uint32_t adc_addr[] = { 0x40012000, 0x40012100, 0x40012200,
+                                     0x40012300, 0x40012400, 0x40012500 };
 static const uint32_t spi_addr[] =   { 0x40013000, 0x40003800, 0x40003C00,
                                        0x40013400, 0x40015000, 0x40015400 };
 #define EXTI_ADDR                      0x40013C00
@@ -185,16 +186,18 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
                           qdev_get_gpio_in(armv7m, ADC_IRQ));
 
-    dev = DEVICE(&(s->adc[i]));
-    object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
-        return;
+    for (i = 0; i < STM_NUM_ADCS; i++) {
+        dev = DEVICE(&(s->adc[i]));
+        object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, adc_addr[i]);
+        sysbus_connect_irq(busdev, 0,
+                           qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
     }
-    busdev = SYS_BUS_DEVICE(dev);
-    sysbus_mmio_map(busdev, 0, ADC_ADDR);
-    sysbus_connect_irq(busdev, 0,
-                       qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
 
     /* SPI devices */
     for (i = 0; i < STM_NUM_SPIS; i++) {
-- 
2.21.3


