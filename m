Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DBCC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F24214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghzBJP88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F24214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEWl-0000ML-4Y
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEVV-0007kg-8W
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEVU-0007dq-4M
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:59:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEVT-0007cB-UB
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576357159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IiMSoFUEZseoMxLw1sAmT/IUeieWX2EUqAxBTC+j+po=;
 b=ghzBJP88B4iQgceh0fqNxwlCPfFlOCloNtEFCU0Ib+S32KOsLT92oA5z0PaRWSvm8rQNTE
 yiwh4E2wGl2Zwhchff9npqOkVrwWM6brULAyac3HyWhDRJI1EHqFNCd0V4itycMvcpo26S
 tjnB9bFORHcSqThCJn1kFRLDXiWdEcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-8GfcR2qbM7asPJU8NqZDDA-1; Sat, 14 Dec 2019 10:56:49 -0500
X-MC-Unique: 8GfcR2qbM7asPJU8NqZDDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62B71107ACC4;
 Sat, 14 Dec 2019 15:56:47 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C0F166A1A;
 Sat, 14 Dec 2019 15:56:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] hw/arm/nrf51_soc: Use memory_region_add_subregion() when
 priority is 0
Date: Sat, 14 Dec 2019 16:56:07 +0100
Message-Id: <20191214155614.19004-2-philmd@redhat.com>
In-Reply-To: <20191214155614.19004-1-philmd@redhat.com>
References: <20191214155614.19004-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Alistair Francis <alistair@alistair23.me>, Paul Burton <pburton@wavecomp.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is pointless to overlap a memory subregion with priority 0.
Use the simpler memory_region_add_subregion() function.

This patch was produced with the following spatch script:

    @@
    expression region;
    expression offset;
    expression subregion;
    @@
    -memory_region_add_subregion_overlap(region, offset, subregion, 0)
    +memory_region_add_subregion(region, offset, subregion)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/nrf51_soc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 74029169d0..ade06b225f 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -94,7 +94,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Err=
or **errp)
         return;
     }
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
-    memory_region_add_subregion_overlap(&s->container, NRF51_UART_BASE, =
mr, 0);
+    memory_region_add_subregion(&s->container, NRF51_UART_BASE, mr);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
                        qdev_get_gpio_in(DEVICE(&s->cpu),
                        BASE_TO_IRQ(NRF51_UART_BASE)));
@@ -107,7 +107,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     }
=20
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0);
-    memory_region_add_subregion_overlap(&s->container, NRF51_RNG_BASE, m=
r, 0);
+    memory_region_add_subregion(&s->container, NRF51_RNG_BASE, mr);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng), 0,
                        qdev_get_gpio_in(DEVICE(&s->cpu),
                        BASE_TO_IRQ(NRF51_RNG_BASE)));
@@ -127,13 +127,13 @@ static void nrf51_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     }
=20
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 0);
-    memory_region_add_subregion_overlap(&s->container, NRF51_NVMC_BASE, =
mr, 0);
+    memory_region_add_subregion(&s->container, NRF51_NVMC_BASE, mr);
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 1);
-    memory_region_add_subregion_overlap(&s->container, NRF51_FICR_BASE, =
mr, 0);
+    memory_region_add_subregion(&s->container, NRF51_FICR_BASE, mr);
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 2);
-    memory_region_add_subregion_overlap(&s->container, NRF51_UICR_BASE, =
mr, 0);
+    memory_region_add_subregion(&s->container, NRF51_UICR_BASE, mr);
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->nvm), 3);
-    memory_region_add_subregion_overlap(&s->container, NRF51_FLASH_BASE,=
 mr, 0);
+    memory_region_add_subregion(&s->container, NRF51_FLASH_BASE, mr);
=20
     /* GPIO */
     object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
@@ -143,7 +143,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     }
=20
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0);
-    memory_region_add_subregion_overlap(&s->container, NRF51_GPIO_BASE, =
mr, 0);
+    memory_region_add_subregion(&s->container, NRF51_GPIO_BASE, mr);
=20
     /* Pass all GPIOs to the SOC layer so they are available to the boar=
d */
     qdev_pass_gpios(DEVICE(&s->gpio), dev_soc, NULL);
--=20
2.21.0


