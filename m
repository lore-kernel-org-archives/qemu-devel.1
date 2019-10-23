Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CBCCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EE621872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="co8ODF8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EE621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNLHd-00087w-T9
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 14:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKXw-0006Hv-5V
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKXu-0002py-Rd
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20292
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKXu-0002ps-OR
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RLin/gMURkv6SWnRw7pKzxO/OTySf/usbRwej+gNRbs=;
 b=co8ODF8h7Loh4rZuN3L7I5GzSxAp+OwTDz8Qot2icJ6zSnmn1D3c4GOjoflk5iwTyjNmhe
 H1Cn0BkuNDpu+BoZD/5jDrV7TOx1SjF6I45FYoL6x4jlbO56KkLjEqdRjylfQaaeprsJkZ
 WWJ74DqUfMJCKPQGzQAACzUveYhYnaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-jMqYSDZYN2WIEXtmvCk1VQ-1; Wed, 23 Oct 2019 13:34:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57E3B800D62;
 Wed, 23 Oct 2019 17:34:25 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9269C5C1D4;
 Wed, 23 Oct 2019 17:34:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/33] sm501: make SerialMM a child, export chardev property
Date: Wed, 23 Oct 2019 19:31:40 +0200
Message-Id: <20191023173154.30051-20-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: jMqYSDZYN2WIEXtmvCk1VQ-1
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
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
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

Embed the SerialMM sybus device, and re-export its "chardev" property.
That way, we can get rid of PROP_PTR "chr-state" and better track
devices relationship.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/sm501.c | 31 ++++++++++++++++++++++---------
 hw/sh4/r2d.c       |  2 +-
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 1f33c87e65..6efdf764c1 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1930,13 +1930,14 @@ typedef struct {
     SM501State state;
     uint32_t vram_size;
     uint32_t base;
-    void *chr_state;
+    SerialMM serial;
 } SM501SysBusState;
=20
 static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
 {
     SM501SysBusState *s =3D SYSBUS_SM501(dev);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    SerialState *ss =3D &s->serial.serial;
     DeviceState *usb_dev;
=20
     sm501_init(&s->state, dev, s->vram_size);
@@ -1958,17 +1959,18 @@ static void sm501_realize_sysbus(DeviceState *dev, =
Error **errp)
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
=20
     /* bridge to serial emulation module */
-    if (s->chr_state) {
-        serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
-                       NULL, /* TODO : chain irq to IRL */
-                       115200, s->chr_state, DEVICE_LITTLE_ENDIAN);
+    if (qemu_chr_fe_backend_connected(&ss->chr)) {
+        MemoryRegion *mr;
+        qdev_init_nofail(DEVICE(&s->serial));
+        mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->serial), 0);
+        memory_region_add_subregion(&s->state.mmio_region, SM501_UART0, mr=
);
+        /* TODO : chain irq to IRL */
     }
 }
=20
 static Property sm501_sysbus_properties[] =3D {
     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
     DEFINE_PROP_UINT32("base", SM501SysBusState, base, 0),
-    DEFINE_PROP_PTR("chr-state", SM501SysBusState, chr_state),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -1999,9 +2001,19 @@ static void sm501_sysbus_class_init(ObjectClass *kla=
ss, void *data)
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
+    SerialMM *s =3D &self->serial;
+
+    sysbus_init_child_obj(o, "serial", s, sizeof(SerialMM), TYPE_SERIAL_MM=
);
+    qdev_prop_set_int32(DEVICE(s), "instance-id", SM501_UART0);
+    qdev_prop_set_uint8(DEVICE(s), "regshift", 2);
+    qdev_prop_set_uint8(DEVICE(s), "endianness", DEVICE_LITTLE_ENDIAN);
+
+    object_property_add_alias(o, "chardev", OBJECT(s), "chardev", &error_a=
bort);
 }
=20
 static const TypeInfo sm501_sysbus_info =3D {
@@ -2009,6 +2021,7 @@ static const TypeInfo sm501_sysbus_info =3D {
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(SM501SysBusState),
     .class_init    =3D sm501_sysbus_class_init,
+    .instance_init =3D sm501_sysbus_init,
 };
=20
 #define TYPE_PCI_SM501 "sm501"
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


