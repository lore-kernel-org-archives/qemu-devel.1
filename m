Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C593ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D0320679
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok9Vj4L4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D0320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxE6-0003rJ-1w
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwwb-0007m9-Nk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwwa-0007YF-GU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:23:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58832
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iMwwa-0007Y3-DG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571761416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNKikGBgZ6nGFsKZ9PDarJpXzXz/Um+xb2CYFyOHYus=;
 b=Ok9Vj4L4orzwv2MjqprDP5zeFnqTmTrED0337ubI7+xE8+e/GFpxgC8vUIWQ8Mtyi9QAeL
 1kJ/t4F9nx8plQMXaXZ+qcDuxG/6fowN4GZnLRA6y/EHO5RBsdy76AciS/Y6Io9FCDE63g
 tJNCnuYn/4sJ+iuMX05ZoJfFUD9jlYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-suFCn2pGO-CQY2f-WQbbYA-1; Tue, 22 Oct 2019 12:23:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73E57107AD31;
 Tue, 22 Oct 2019 16:23:25 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FC3B10027B8;
 Tue, 22 Oct 2019 16:23:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/28] sm501: embed the serial device
Date: Tue, 22 Oct 2019 18:21:23 +0200
Message-Id: <20191022162137.27161-15-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-1-marcandre.lureau@redhat.com>
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: suFCn2pGO-CQY2f-WQbbYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Embedding the serial device allows to expose a property for the
associated chardev backend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/sm501.c | 27 ++++++++++++++++++---------
 hw/sh4/r2d.c       |  2 +-
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 1f33c87e65..a17ff82db8 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1930,7 +1930,7 @@ typedef struct {
     SM501State state;
     uint32_t vram_size;
     uint32_t base;
-    void *chr_state;
+    SerialMMState serial;
 } SM501SysBusState;
=20
 static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
@@ -1958,17 +1958,20 @@ static void sm501_realize_sysbus(DeviceState *dev, =
Error **errp)
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
=20
     /* bridge to serial emulation module */
-    if (s->chr_state) {
-        serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
-                       NULL, /* TODO : chain irq to IRL */
-                       115200, s->chr_state, DEVICE_LITTLE_ENDIAN);
+    if (qemu_chr_fe_backend_connected(&SERIAL(&s->serial)->chr)) {
+        qdev_prop_set_uint64(DEVICE(&s->serial), "base", SM501_UART0);
+        qdev_prop_set_uint8(DEVICE(&s->serial), "regshift", 2);
+        qdev_init_nofail(DEVICE(&s->serial));
+        serial_mm_connect(&s->serial, DEVICE_LITTLE_ENDIAN,
+                          &s->state.mmio_region,
+                          NULL /* TODO : chain irq to IRL */);
     }
 }
=20
 static Property sm501_sysbus_properties[] =3D {
     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
     DEFINE_PROP_UINT32("base", SM501SysBusState, base, 0),
-    DEFINE_PROP_PTR("chr-state", SM501SysBusState, chr_state),
+    DEFINE_PROP_CHR("chardev", SM501SysBusState, serial.parent.chr),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -1999,15 +2002,21 @@ static void sm501_sysbus_class_init(ObjectClass *kl=
ass, void *data)
     dc->props =3D sm501_sysbus_properties;
     dc->reset =3D sm501_reset_sysbus;
     dc->vmsd =3D &vmstate_sm501_sysbus;
-    /* Note: pointer property "chr-state" may remain null, thus
-     * no need for dc->user_creatable =3D false;
-     */
+}
+
+static void sm501_sysbus_init(Object *o)
+{
+    SM501SysBusState *self =3D SYSBUS_SM501(o);
+
+    object_initialize_child(o, "serial", &self->serial, sizeof(self->seria=
l),
+                            TYPE_SERIAL_MM, &error_abort, NULL);
 }
=20
 static const TypeInfo sm501_sysbus_info =3D {
     .name          =3D TYPE_SYSBUS_SM501,
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(SM501SysBusState),
+    .instance_init =3D sm501_sysbus_init,
     .class_init    =3D sm501_sysbus_class_init,
 };
=20
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index ee0840f380..72bb5285cc 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -272,7 +272,7 @@ static void r2d_init(MachineState *machine)
     busdev =3D SYS_BUS_DEVICE(dev);
     qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
     qdev_prop_set_uint32(dev, "base", 0x10000000);
-    qdev_prop_set_ptr(dev, "chr-state", serial_hd(2));
+    qdev_prop_set_chr(dev, "chardev", serial_hd(2));
     qdev_init_nofail(dev);
     sysbus_mmio_map(busdev, 0, 0x10000000);
     sysbus_mmio_map(busdev, 1, 0x13e00000);
--=20
2.23.0.606.g08da6496b6


