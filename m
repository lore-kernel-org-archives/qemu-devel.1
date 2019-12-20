Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292FCC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71F5218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Vvt1dya3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71F5218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJai-0000r4-T5
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiJY1-0006no-R5
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiJY0-0008FG-OC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:46:33 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:52566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iiJXy-00081w-7P; Fri, 20 Dec 2019 09:46:30 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id F2B3796F50;
 Fri, 20 Dec 2019 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576853189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lM12RI0EHDUNjslinRXmoW1BfejdQGdartCVRRzWAmE=;
 b=Vvt1dya3SavXYQzVTEWVATCFU2MszH4rUbjkT4YbxDGgkf40K/XO1F7h5sImmdoN2GO9Hl
 LrW5VV8RMsWTRaigIu6Y3ez9+fh5i8aqTvzv0itAzmbBbpI77Glhwgachzbdxma3lfeFvS
 kAmKnZWC/V0e1HLdtQIBYJ+rXlvMD9k=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/gpio/bcm2835_gpio: Isolate sdbus reparenting
Date: Fri, 20 Dec 2019 15:46:15 +0100
Message-Id: <20191220144616.911466-3-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220144616.911466-1-damien.hedde@greensocs.com>
References: <20191220144616.911466-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576853189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lM12RI0EHDUNjslinRXmoW1BfejdQGdartCVRRzWAmE=;
 b=s6FLgPAzjEcjCAtj001VhqG2TKWSG5pmbxIE+28yQNdPwGhqGH/KLK3VrkHqKduY3HjurT
 0I42w+jQ/AcxuxmpuruyuezSUFLtlqefcLTwkex7q5vBCyhA6ScOTpZr1T6eo8ebj8+ywA
 HmHnDzYQJPs7Km7q4hEhHEtzfOO3r4k=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576853189; a=rsa-sha256; cv=none;
 b=HzoF3GU8k2kXjvUvNfjETN56zrIEk8EPSW3bPdUOGCTXALu92UkvUp4QgdiyLf+65T3Gpe
 hpSNrQ03jZKWwNz56v2E4O7e+ItvzIUh/PZY/SGN3+9EFKqk9FooKswhtDC4duPs7Xjh5N
 /U8DEqJO/IZmAsoSln0ruGB8nFxNvqU=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, philmd@redhat.com, Andrew.Baumann@microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split gpfsel_set() in 2 so that the sdbus reparenting is done
in a dedicated function: gpfsel_update_sdbus().

Update call sites of gpfsel_set() to also call gpfsel_update_sdbus().

This commit is a preparation to switch to multiphase reset.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/gpio/bcm2835_gpio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index 25c180423f..88dc652018 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -75,7 +75,10 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t re=
g, uint32_t value)
             s->fsel[index] =3D fsel;
         }
     }
+}
=20
+static void gpfsel_update_sdbus(BCM2835GpioState *s)
+{
     /* SD controller selection (48-53) */
     if (s->sd_fsel !=3D 0
             && (s->fsel[48] =3D=3D 0) /* SD_CLK_R */
@@ -210,6 +213,7 @@ static void bcm2835_gpio_write(void *opaque, hwaddr o=
ffset,
     case GPFSEL4:
     case GPFSEL5:
         gpfsel_set(s, offset / 4, value);
+        gpfsel_update_sdbus(s);
         break;
     case GPSET0:
         gpset(s, value, 0, 32, &s->lev0);
@@ -261,11 +265,15 @@ static void bcm2835_gpio_reset(DeviceState *dev)
     BCM2835GpioState *s =3D BCM2835_GPIO(dev);
=20
     int i;
+    /*
+     * Initialize the gpfsel registers. In particular, it selects the SD=
HCI bus
+     * for the sd card.
+     */
     for (i =3D 0; i < 6; i++) {
         gpfsel_set(s, i, 0);
     }
-
-    s->sd_fsel =3D 0;
+    /* Update s->sd_fsel and move the sd card */
+    gpfsel_update_sdbus(s);
=20
     s->lev0 =3D 0;
     s->lev1 =3D 0;
--=20
2.24.0


