Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A78CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4C3222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="2Hgo1smB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4C3222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUCV-0007fi-A1
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrk-0007LO-RZ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrj-0000V6-9h
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:32 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:38770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iLTrg-0000IJ-2c; Fri, 18 Oct 2019 11:08:28 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 5EA0096F5B;
 Fri, 18 Oct 2019 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1571411276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gw/9OjOWVXESU4gXuWgq3cSpDZKHiW1A6Qa07223tS4=;
 b=2Hgo1smBHJKc8hH1+ddEvD6r9ON4YMMnIVarKOxj5L3+p9n8LsJpDwTCW8tV7YcBhWdoT7
 fRQHyZFS0PC7HNsmdFu/FssYrIWa021IECzz8t0sLIqbSjxb8piqkdp8J+DH8GY9Fq1ROr
 YY4O6nEYrA8sdhACNYqDxVX59xoQIDo=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/13] hw/gpio/bcm2835_gpio: Isolate sdbus reparenting
Date: Fri, 18 Oct 2019 17:06:29 +0200
Message-Id: <20191018150630.31099-13-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1571411277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gw/9OjOWVXESU4gXuWgq3cSpDZKHiW1A6Qa07223tS4=;
 b=vILmcuKtWURTOiXgVhIc1DaAORRjIFoK9qFn3iDtt0S/mAqbB6zFxQ338K4E9Z8unl3vJH
 SaPC4M28azmE93QjNljLUvn2KqT8Fim33dwpwqv0MEscKBYWAK35KY204tP4UXD2Rtl0na
 Sjwpf+NILNZV8thpW71rJaCc7qgVdEs=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1571411277; a=rsa-sha256; cv=none;
 b=GG+rbZ0BOnJ8bWGzctqkp1pKCEFjSDCOtoYm24cvnreOkmGm5oSQkizw9t/Rc8mx5aq9kq
 srRtgIf86jy1deNJRkbk4UMtVIYRj1voUcuHpc+RerBXJd/r6E08AD2cKK+NwXJkIB1WAn
 B5sypCqfQmlP6Fku5vKY/yIQSvtp3Po=
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
 berrange@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, edgari@xilinx.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split gpfsel_set() in 2 so that the sdbus reparenting is done
in a dedicated function.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: qemu-arm@nongnu.org
---
 hw/gpio/bcm2835_gpio.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index 91ce3d10cc..81fe07132f 100644
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
@@ -86,6 +89,7 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t reg=
, uint32_t value)
             && (s->fsel[53] =3D=3D 0) /* SD_DATA3_R */
             ) {
         /* SDHCI controller selected */
+        sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci);
         sdbus_reparent_card(s->sdbus_sdhost, s->sdbus_sdhci);
         s->sd_fsel =3D 0;
     } else if (s->sd_fsel !=3D 4
@@ -97,6 +101,7 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t re=
g, uint32_t value)
             && (s->fsel[53] =3D=3D 4) /* SD_DATA3_R */
             ) {
         /* SDHost controller selected */
+        sdbus_reparent_card(&s->sdbus, s->sdbus_sdhost);
         sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);
         s->sd_fsel =3D 4;
     }
@@ -210,6 +215,7 @@ static void bcm2835_gpio_write(void *opaque, hwaddr o=
ffset,
     case GPFSEL4:
     case GPFSEL5:
         gpfsel_set(s, offset / 4, value);
+        gpfsel_update_sdbus(s);
         break;
     case GPSET0:
         gpset(s, value, 0, 32, &s->lev0);
@@ -265,10 +271,12 @@ static void bcm2835_gpio_reset(DeviceState *dev)
         gpfsel_set(s, i, 0);
     }
=20
-    s->sd_fsel =3D 0;
-
-    /* SDHCI is selected by default */
-    sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci);
+    /*
+     * Setup the right sdbus (put 1 in sd_fsel to force reparenting
+     * the sd). It will be SDHCI because of the gpfsel_set() above.
+     */
+    s->sd_fsel =3D 1;
+    gpfsel_update_sdbus(s);
=20
     s->lev0 =3D 0;
     s->lev1 =3D 0;
--=20
2.23.0


