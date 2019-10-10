Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A697C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F02120650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F02120650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYNK-0004DL-On
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIYKH-0001d3-Hp
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIYKE-0002dt-OO
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:17:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39054)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iIYJs-0002Xy-TV; Thu, 10 Oct 2019 09:17:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB15A300BCE9;
 Thu, 10 Oct 2019 13:17:27 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.241])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5C71600C4;
 Thu, 10 Oct 2019 13:17:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 7/8] hw/input/lm832x: Convert reset handler to DeviceReset
Date: Thu, 10 Oct 2019 15:15:26 +0200
Message-Id: <20191010131527.32513-8-philmd@redhat.com>
In-Reply-To: <20191010131527.32513-1-philmd@redhat.com>
References: <20191010131527.32513-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 10 Oct 2019 13:17:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The LM8323 key-scan controller is a I2C device, it will be reset
when the I2C bus it stands on is reset.

Convert its reset handler into a proper Device reset method.

Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/input/lm832x.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index a37eb854b9..aa629ddbf1 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -24,7 +24,6 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "sysemu/reset.h"
 #include "ui/console.h"
=20
 #define TYPE_LM8323 "lm8323"
@@ -94,8 +93,10 @@ static void lm_kbd_gpio_update(LM823KbdState *s)
 {
 }
=20
-static void lm_kbd_reset(LM823KbdState *s)
+static void lm_kbd_reset(DeviceState *dev)
 {
+    LM823KbdState *s =3D LM8323(dev);
+
     s->config =3D 0x80;
     s->status =3D INT_NOINIT;
     s->acttime =3D 125;
@@ -273,7 +274,7 @@ static void lm_kbd_write(LM823KbdState *s, int reg, i=
nt byte, uint8_t value)
=20
     case LM832x_CMD_RESET:
         if (value =3D=3D 0xaa)
-            lm_kbd_reset(s);
+            lm_kbd_reset(DEVICE(s));
         else
             lm_kbd_error(s, ERR_BADPAR);
         s->reg =3D LM832x_GENERAL_ERROR;
@@ -476,10 +477,6 @@ static void lm8323_realize(DeviceState *dev, Error *=
*errp)
     s->pwm.tm[1] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm1_tick, =
s);
     s->pwm.tm[2] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm2_tick, =
s);
     qdev_init_gpio_out(dev, &s->nirq, 1);
-
-    lm_kbd_reset(s);
-
-    qemu_register_reset((void *) lm_kbd_reset, s);
 }
=20
 void lm832x_key_event(DeviceState *dev, int key, int state)
@@ -507,6 +504,7 @@ static void lm8323_class_init(ObjectClass *klass, voi=
d *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
=20
+    dc->reset =3D lm_kbd_reset;
     dc->realize =3D lm8323_realize;
     k->event =3D lm_i2c_event;
     k->recv =3D lm_i2c_rx;
--=20
2.21.0


