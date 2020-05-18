Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1EEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF2320657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGhWge9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF2320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaXzq-0005iq-NE
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwn-0008MG-KA
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwl-0004Jr-Kp
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589778254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXVMvm1PxSB5tcsPFS9fnNgDrjSKRPK4CNQ0NUGIpCA=;
 b=EGhWge9BRo+X/7iaGeiK580FPPLYJoxHLLGSzdr4UYUooSEpyntMA40u2Rv9xS+e/2A4wT
 Epv13FOnJd8GUkQAD2MZusIuW65mErGheRzKf1qvoDpK6XRuxkqdW0KJHUGHBqk+9+W5np
 mODS3zUXmwiBDtDV9p04ELLTHfqG4Dw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-MaCBv4BTPiqywP1AHwcE_w-1; Mon, 18 May 2020 01:04:11 -0400
X-MC-Unique: MaCBv4BTPiqywP1AHwcE_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB7051005512;
 Mon, 18 May 2020 05:04:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8DDC5F7EA;
 Mon, 18 May 2020 05:04:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1829911358BD; Mon, 18 May 2020 07:04:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/24] arm/stm32f405: Fix realization of "stm32f2xx-adc"
 devices
Date: Mon, 18 May 2020 07:03:45 +0200
Message-Id: <20200518050408.4579-2-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-1-armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

I wonder how this ever worked.  If the "device becomes real only on
realize" thing actually works, then we've always been missing five of
six such devices, yet nobody noticed.

Fix stm32f405_soc_realize() to realize all six.  Visible in "info
qtree":

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
    +    mmio 0000000040012000/00000000000000ff
       dev: stm32f2xx-adc, id ""
         gpio-out "sysbus-irq" 1
    -    mmio ffffffffffffffff/00000000000000ff
    +    mmio 0000000040012000/00000000000000ff
       dev: stm32f2xx-adc, id ""
         gpio-out "sysbus-irq" 1
    -    mmio ffffffffffffffff/00000000000000ff
    +    mmio 0000000040012000/00000000000000ff
       dev: stm32f2xx-adc, id ""
         gpio-out "sysbus-irq" 1
         mmio 0000000040012000/00000000000000ff
       dev: stm32f2xx-adc, id ""
         gpio-out "sysbus-irq" 1
    -    mmio ffffffffffffffff/00000000000000ff
    +    mmio 0000000040012000/00000000000000ff
       dev: armv7m, id ""

The mmio addresses look suspicious.

Fixes: 529fc5fd3e18ace8f739afd02dc0953354f39442
Cc: Alistair Francis <alistair@alistair23.me>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/stm32f405_soc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 4f10ce6176..4649502711 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -185,16 +185,18 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
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
+        sysbus_mmio_map(busdev, 0, ADC_ADDR);
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
2.21.1


