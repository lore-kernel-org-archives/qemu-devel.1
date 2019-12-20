Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00449C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF10E21D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="pLxt1y8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF10E21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJcK-0001tX-QP
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiJY0-0006lh-S9
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiJXz-0008AL-I0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:46:32 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:52552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iiJXw-0007yN-Qr; Fri, 20 Dec 2019 09:46:29 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 94A7396EF2;
 Fri, 20 Dec 2019 14:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576853187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SbgvYJhx6Lit3rs3j+nNkUTo6mP2ku7nAV624s9t11k=;
 b=pLxt1y8YeyRjjFOiEwU4gagAknZGqxqWTGjKTT9U+mWGN0sXPLzYwIHeDIGucqkrUrT+qd
 tATMQgU+kdBTh8aOnIKeASvvTlqhte4XIqfNk4lO3BiH1Ch49ugeQNZqg/z3TFYrq2yc4l
 TpEfot6HSwDHUQj0hnm8vP2R/m5QIJ0=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/arm/bcm2835: remove gpio/sd-bus
Date: Fri, 20 Dec 2019 15:46:14 +0100
Message-Id: <20191220144616.911466-2-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220144616.911466-1-damien.hedde@greensocs.com>
References: <20191220144616.911466-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576853187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SbgvYJhx6Lit3rs3j+nNkUTo6mP2ku7nAV624s9t11k=;
 b=MI6qLUDmaWiMtZ3wTmX4U+UnYBrHtvhcLZ+Zh6LmHC+M4LB6m2UPZwYqRBXRv0lnrVWsqk
 nHhdJIQc3cHFoA4M4H/cKVszyxb2K6mC9EWgDlFbJMuMyelG80EtIcDI76nG1BfmPsYla2
 ElP6436uEPVv9LCeG9VwkdH7Ahc7Slc=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576853187; a=rsa-sha256; cv=none;
 b=MxI/C14GDculPwqELFq5jEitYIDfAKg3A5TE7rxod3NVWQ2WuOakifmty2f/MXV+a29S3B
 P7fm0WjKiybmRabInhNXuzBYXpdxZBuB34q5Ld8nzw7mtJawAdWUxEcEPHVIWcWbYUlfOl
 4A7kNuLl3YtmwU9y/cVKiC09jR+2KcQ=
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

Remove gpio/sdbus which is only used to host the sd card before reset.

Instead directly we exhibit the sdhci bus to the soc and machine. Thus
the sd card is created on the sdhci bus and do not need to be moved
during first reset.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 include/hw/gpio/bcm2835_gpio.h | 1 -
 hw/arm/bcm2835_peripherals.c   | 2 +-
 hw/gpio/bcm2835_gpio.c         | 6 ------
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/hw/gpio/bcm2835_gpio.h b/include/hw/gpio/bcm2835_gpi=
o.h
index b0de0a3c74..f8416d43d3 100644
--- a/include/hw/gpio/bcm2835_gpio.h
+++ b/include/hw/gpio/bcm2835_gpio.h
@@ -23,7 +23,6 @@ typedef struct BCM2835GpioState {
     MemoryRegion iomem;
=20
     /* SDBus selector */
-    SDBus sdbus;
     SDBus *sdbus_sdhci;
     SDBus *sdbus_sdhost;
=20
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 17207ae07e..93477c5b2f 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -360,7 +360,7 @@ static void bcm2835_peripherals_realize(DeviceState *=
dev, Error **errp)
     memory_region_add_subregion(&s->peri_mr, GPIO_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
=20
-    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd=
-bus",
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->sdhci), "s=
d-bus",
                               &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index 91ce3d10cc..25c180423f 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -267,9 +267,6 @@ static void bcm2835_gpio_reset(DeviceState *dev)
=20
     s->sd_fsel =3D 0;
=20
-    /* SDHCI is selected by default */
-    sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci);
-
     s->lev0 =3D 0;
     s->lev1 =3D 0;
 }
@@ -299,9 +296,6 @@ static void bcm2835_gpio_init(Object *obj)
     DeviceState *dev =3D DEVICE(obj);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
=20
-    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
-                        TYPE_SD_BUS, DEVICE(s), "sd-bus");
-
     memory_region_init_io(&s->iomem, obj,
             &bcm2835_gpio_ops, s, "bcm2835_gpio", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
--=20
2.24.0


