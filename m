Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D603C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284ED2078C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INDEYzPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284ED2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidKE-000550-CQ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jidIG-0003Eb-Nu
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:23:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jidI9-0005Oo-K6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591705424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a97wbzF8rIGQsC0Rq9NAGUWNPSYKmS8gW+odfXBMS+w=;
 b=INDEYzPgGKrPVxYz9+bvs7fMAQsQwsa1TAKnb/uHw4vKj60GRh9voIeDdKUENrTCkQaKdt
 +mRWTa9qFJY9qIcv0kMEqreNXChWDicf9kOOw+770X7l05PdL41GEdN6vTIogXyjwQP/pQ
 jK2yaJBgn/rZza0ShpUofYkJuud5eLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-etibD4K3PmCRkfkJYt8eow-1; Tue, 09 Jun 2020 08:23:42 -0400
X-MC-Unique: etibD4K3PmCRkfkJYt8eow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 960EA805721;
 Tue,  9 Jun 2020 12:23:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 614AF5D9E4;
 Tue,  9 Jun 2020 12:23:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCB7311385C2; Tue,  9 Jun 2020 14:23:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/24] arm/stm32f405: Fix realization of "stm32f2xx-adc"
 devices
Date: Tue,  9 Jun 2020 14:23:16 +0200
Message-Id: <20200609122339.937862-2-armbru@redhat.com>
In-Reply-To: <20200609122339.937862-1-armbru@redhat.com>
References: <20200609122339.937862-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.26.2


