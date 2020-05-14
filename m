Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C47C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822EB20727
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nx+mpB58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822EB20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZCyW-0000Zo-P1
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZCtx-0001gv-F8
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:23:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZCtu-0003Zx-8s
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589459025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ZTyxGJXsQ0G8ZMjcr3S07D1e5jsnMdhx5FHvtwszGE0=;
 b=Nx+mpB58i1G9i9cS5K/8m76Z4108nKqeN8XwkWHdzHjiDJ7Pt8lgppUt+mXN/z0PNUvIc7
 Ytlvx52sJLptaghbXfKMzcJqnUO4X6K05ohsSZpWWM+mO9U44NA1YteWustcevDxaVgNrv
 nbnrJPf0WFD0xOPCa9+lhKBuJ9j+iGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200--1YDrlElO3yxDNYovaGm1A-1; Thu, 14 May 2020 08:23:43 -0400
X-MC-Unique: -1YDrlElO3yxDNYovaGm1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D598474;
 Thu, 14 May 2020 12:23:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC8CF78379;
 Thu, 14 May 2020 12:23:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EA2089DAF; Thu, 14 May 2020 14:23:34 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] wire in the dwc-hsotg (dwc2) USB host controller emulation
Date: Thu, 14 May 2020 14:23:33 +0200
Message-Id: <20200514122334.25089-7-kraxel@redhat.com>
In-Reply-To: <20200514122334.25089-1-kraxel@redhat.com>
References: <20200514122334.25089-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Zimmerman <pauldzim@gmail.com>

Wire the dwc-hsotg (dwc2) emulation into Qemu

Reviewed-by: Philippe Mathieu-Daude <f4bug@amsat.org>
Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
Message-id: 20200512064900.28554-7-pauldzim@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 hw/arm/bcm2835_peripherals.c         | 21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 7a7a8f614146..48a0ad163358 100644
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
 
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 5e2c832d95f6..3b554cfac0c8 100644
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
 
-- 
2.18.4


