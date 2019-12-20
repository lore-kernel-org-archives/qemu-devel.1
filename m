Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C00C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D13E21D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="mnFhCOtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D13E21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJbT-0001H2-2K
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiJY4-0006tu-S1
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iiJY3-0008Sd-JX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:46:36 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:52582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iiJY0-0008BK-Je; Fri, 20 Dec 2019 09:46:32 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 4A98296EF0;
 Fri, 20 Dec 2019 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576853191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUI425C+0o7N1J/sQKvdILj2VDsYvQDc77nK8FmyVMw=;
 b=mnFhCOtLHBzDl4db+ogmJ95bJMXPzMHAs/c9TT/mkczrEsfTaVOlyFXVdCh7eiP1NrygN+
 ZFNqobWMXhS7IiLlCt6tqHhF02A5TOQkMoFY+1JaZoxCevzAoah4nu921X0GqZ+JU9K7B7
 axqL7fuKqlDCO7lzq1GAB0XhgFyy62g=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/gpio/bcm2835_gpio: Update to resettable
Date: Fri, 20 Dec 2019 15:46:16 +0100
Message-Id: <20191220144616.911466-4-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220144616.911466-1-damien.hedde@greensocs.com>
References: <20191220144616.911466-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576853191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUI425C+0o7N1J/sQKvdILj2VDsYvQDc77nK8FmyVMw=;
 b=v4PXMf3e3fN5GPotJCE0hmynD6R8VF5WBV5PwRiqaIqEDd28zT2//41sdHTZK/jnZvSgOR
 R145uyAr8z64J2jnwkAV4GkGzq1M8wEbm6HXvHCd0SAIU1WbQZuGcFp9ZQKX9y9JGmqFew
 KdqZkXj+F15FGG7scZb/vV5RMalU1Ag=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576853191; a=rsa-sha256; cv=none;
 b=ObKsXkHIbTwaPniAdkeMAtyy4zEDhgGnLkxhdBvvuMcncuqk0lCBgE1OAnXCiM5DXeOia/
 kX+Z+ho3szT5ORGNtsi6xIdjDW+wuBYXk6Grrjo3D9x9LvEtHl8tEQynIzBl5c8RUw9pOK
 4kpav68JB2PWmlzYl1c23r/lUcKNqlo=
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

Transition the bcm2835_gpio device class to Resettable.
The sdbus reparenting is delayed in hold phase to respect
resettable side-effect rules.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/bcm2835_gpio.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index 88dc652018..4d393c6a47 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -260,9 +260,9 @@ err_out:
             __func__, offset);
 }
=20
-static void bcm2835_gpio_reset(DeviceState *dev)
+static void bcm2835_gpio_reset_enter(Object *obj, ResetType type)
 {
-    BCM2835GpioState *s =3D BCM2835_GPIO(dev);
+    BCM2835GpioState *s =3D BCM2835_GPIO(obj);
=20
     int i;
     /*
@@ -272,13 +272,22 @@ static void bcm2835_gpio_reset(DeviceState *dev)
     for (i =3D 0; i < 6; i++) {
         gpfsel_set(s, i, 0);
     }
-    /* Update s->sd_fsel and move the sd card */
-    gpfsel_update_sdbus(s);
=20
     s->lev0 =3D 0;
     s->lev1 =3D 0;
 }
=20
+static void bcm2835_gpio_reset_hold(Object *obj)
+{
+    BCM2835GpioState *s =3D BCM2835_GPIO(obj);
+
+    /*
+     * Update s->sd_fsel and move the sd card according to the config se=
t in
+     * bcm2835_gpio_reset_enter().
+     */
+    gpfsel_update_sdbus(s);
+}
+
 static const MemoryRegionOps bcm2835_gpio_ops =3D {
     .read =3D bcm2835_gpio_read,
     .write =3D bcm2835_gpio_write,
@@ -336,10 +345,12 @@ static void bcm2835_gpio_realize(DeviceState *dev, =
Error **errp)
 static void bcm2835_gpio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
=20
     dc->vmsd =3D &vmstate_bcm2835_gpio;
     dc->realize =3D &bcm2835_gpio_realize;
-    dc->reset =3D &bcm2835_gpio_reset;
+    rc->phases.enter =3D &bcm2835_gpio_reset_enter;
+    rc->phases.hold  =3D &bcm2835_gpio_reset_hold;
 }
=20
 static const TypeInfo bcm2835_gpio_info =3D {
--=20
2.24.0


