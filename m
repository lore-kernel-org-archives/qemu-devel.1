Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D6DCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40132173B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOj0Ehzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40132173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNL4H-0006HO-9L
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 14:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKWZ-0004lD-KY
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKWX-00026c-Uh
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32127
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKWX-000266-OM
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3n8NemwbAtO2vjJo0cvTmj3rjEQJOf2iog0bPQvhlk8=;
 b=QOj0EhzzKUY1momYp6YDRy9tQx06Zko3laN+T4h1zj4iikfJCqBvGw4zcGRqyCA03MnrOl
 HU/ujWfWXapBMmgDV4Gk3f/HwOjNDdCcYzvIDbyRi5AKNeT2HoNJn98iS/OD79poyBNbMN
 AZPffiVUxQD+BwOuGtPyvUi+IUJsIds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-u0nE5TA2Ps2mdxSKYUAz6Q-1; Wed, 23 Oct 2019 13:34:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9B111005512;
 Wed, 23 Oct 2019 17:34:10 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74C4B19C78;
 Wed, 23 Oct 2019 17:34:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/33] serial: make SerialIO a sysbus device
Date: Wed, 23 Oct 2019 19:31:38 +0200
Message-Id: <20191023173154.30051-18-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: u0nE5TA2Ps2mdxSKYUAz6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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

Make serial IO a proper sysbus device, similar to serial MM.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c         | 58 ++++++++++++++++++++++++++++++++--------
 include/hw/char/serial.h | 13 +++++++--
 2 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index a40bc3ab81..84de2740a7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -986,22 +986,57 @@ const MemoryRegionOps serial_io_ops =3D {
     .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
-SerialState *serial_init(int base, qemu_irq irq, int baudbase,
-                         Chardev *chr, MemoryRegion *system_io)
+static void serial_io_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
-    SerialState *s =3D SERIAL(dev);
+    SerialIO *self =3D SERIAL_IO(dev);
+    SerialState *s =3D &self->serial;
=20
-    s->irq =3D irq;
-    qdev_prop_set_uint32(dev, "baudbase", baudbase);
-    qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_prop_set_int32(dev, "instance-id", base);
-    qdev_init_nofail(dev);
+    qdev_init_nofail(DEVICE(s));
=20
     memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
-    memory_region_add_subregion(system_io, base, &s->io);
+    sysbus_init_irq(SYS_BUS_DEVICE(self), &self->serial.irq);
+}
+
+static void serial_io_class_init(ObjectClass *klass, void* data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D serial_io_realize;
+}
+
+static void serial_io_instance_init(Object *o)
+{
+    SerialIO *self =3D SERIAL_IO(o);
+
+    object_initialize_child(o, "serial", &self->serial, sizeof(self->seria=
l),
+                            TYPE_SERIAL, &error_abort, NULL);
+
+    qdev_alias_all_properties(DEVICE(&self->serial), o);
+}
+
+
+static const TypeInfo serial_io_info =3D {
+    .name =3D TYPE_SERIAL_IO,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(SerialIO),
+    .instance_init =3D serial_io_instance_init,
+    .class_init =3D serial_io_class_init,
+};
+
+SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
+                         Chardev *chr, MemoryRegion *system_io)
+{
+    SerialIO *self =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
=20
-    return s;
+    qdev_prop_set_uint32(DEVICE(self), "baudbase", baudbase);
+    qdev_prop_set_chr(DEVICE(self), "chardev", chr);
+    qdev_prop_set_int32(DEVICE(self), "instance-id", base);
+    qdev_init_nofail(DEVICE(self));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(self), 0, irq);
+    memory_region_add_subregion(system_io, base, &self->serial.io);
+
+    return self;
 }
=20
 static Property serial_properties[] =3D {
@@ -1138,6 +1173,7 @@ static const TypeInfo serial_mm_info =3D {
 static void serial_register_types(void)
 {
     type_register_static(&serial_info);
+    type_register_static(&serial_io_info);
     type_register_static(&serial_mm_info);
 }
=20
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 2d0802a909..cf9cdafaee 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -89,6 +89,12 @@ typedef struct SerialMM {
     uint8_t endianness;
 } SerialMM;
=20
+typedef struct SerialIO {
+    SysBusDevice parent;
+
+    SerialState serial;
+} SerialIO;
+
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
=20
@@ -100,8 +106,11 @@ void serial_set_frequency(SerialState *s, uint32_t fre=
quency);
 #define TYPE_SERIAL_MM "serial-mm"
 #define SERIAL_MM(s) OBJECT_CHECK(SerialMM, (s), TYPE_SERIAL_MM)
=20
-SerialState *serial_init(int base, qemu_irq irq, int baudbase,
-                         Chardev *chr, MemoryRegion *system_io);
+#define TYPE_SERIAL_IO "serial-io"
+#define SERIAL_IO(s) OBJECT_CHECK(SerialIO, (s), TYPE_SERIAL_IO)
+
+SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
+                      Chardev *chr, MemoryRegion *system_io);
 SerialMM *serial_mm_init(MemoryRegion *address_space,
                          hwaddr base, int regshift,
                          qemu_irq irq, int baudbase,
--=20
2.23.0.606.g08da6496b6


