Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D6ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAC121852
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="jt6EpsvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAC121852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUDv-0000L9-T2
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrm-0007Li-DA
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrl-0000Vq-8P
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:34 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:38788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iLTrg-0000J2-Sp; Fri, 18 Oct 2019 11:08:29 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 3C82596F5C;
 Fri, 18 Oct 2019 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1571411277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csiJwmDDJ1X+h08zqd88vO2yIGi07AvaeJFvRK/uExA=;
 b=jt6EpsvItqPtYrND3cd2USeJTJWV4JJPUsOPBPDmu9PkmB2nAUuYxNwh+jJMJ9q1stQ8K4
 gh2ShTgwIZeL2x3n2x4Vkn69ul/1t9wFGjWIJCAGbQyWjY+8b0k4FdI5Q4dhTsxrcg6x/W
 mQX65ZHl2CuBYl5nCa6vlSn+8peUZnU=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/13] hw/gpio/bcm2835_gpio: Update to resettable
Date: Fri, 18 Oct 2019 17:06:30 +0200
Message-Id: <20191018150630.31099-14-damien.hedde@greensocs.com>
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
 bh=csiJwmDDJ1X+h08zqd88vO2yIGi07AvaeJFvRK/uExA=;
 b=bzg6srUUN146O1kBjWNa+dQxm2BTQ4HkIFB8ji4n0FkC1f6l1aCV1adG5STLSYD/9g+74K
 515cUHzsQdJX/XSPQOoA1bhTOa4pZm7/KbgcJyCx+iGiiEg6Nr93QTWxwzlVzP8wJjcAsq
 3V2XvVSb6ID7/ZeTFGClqzBS87PV5Qw=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1571411277; a=rsa-sha256; cv=none;
 b=RNRVpJU3OFVN3KcsIrG7xkzeJd+qIG8iBGF+8vHZBHrEeibMwNFyj0DfkuJN+4WXF7ltsm
 RUVF6NPH7cgXiIxO01N/T4SYCpD2XYYxupBT/zDQX7hVrQ/I4sba/EAPnYvBVrGnBefxTi
 iapbvFnDNY8QAOx4FPy15L7jqMc+Y48=
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

Transition the bcm2835_gpio device class to Resettable.
The sdbus reparenting is delayed in hold phase to respect
resettable side-effect rules.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: qemu-arm@nongnu.org
---
 hw/gpio/bcm2835_gpio.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index 81fe07132f..24e39eac5e 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -262,24 +262,29 @@ err_out:
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
     for (i =3D 0; i < 6; i++) {
         gpfsel_set(s, i, 0);
     }
=20
+    s->lev0 =3D 0;
+    s->lev1 =3D 0;
+}
+
+static void bcm2835_gpio_reset_hold(Object *obj)
+{
+    BCM2835GpioState *s =3D BCM2835_GPIO(obj);
     /*
      * Setup the right sdbus (put 1 in sd_fsel to force reparenting
-     * the sd). It will be SDHCI because of the gpfsel_set() above.
+     * the sd). It will be SDHCI because of the gpfsel_set() done
+     * in bcm2835_gpio_reset_enter().
      */
     s->sd_fsel =3D 1;
     gpfsel_update_sdbus(s);
-
-    s->lev0 =3D 0;
-    s->lev1 =3D 0;
 }
=20
 static const MemoryRegionOps bcm2835_gpio_ops =3D {
@@ -342,10 +347,12 @@ static void bcm2835_gpio_realize(DeviceState *dev, =
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
2.23.0


