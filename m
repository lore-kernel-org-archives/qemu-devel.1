Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CEBC2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B260218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvmFeFan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B260218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIql-00016D-Rf
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIe9-0005VO-SX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIe8-0003f6-ES
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:48:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIe7-0003ci-V6
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErEusLMkFXXYvU1bgrkOZYaAHQWrglTdAbdT6UhLbQQ=;
 b=KvmFeFan7nO0EfNU/rWsip8xt46AcPvm65XtdTuSXvCSptGSCwTibmMM0TdPuwzs8+4iWT
 L7YQvZAgql2JPjR109s5GiHAHCHfMgR4OkyeaJKAkb66b7xi7gXm2Ya1L4hJdU6rdb9SGZ
 Ndy13iJQnvznG37J1BiDDl92m8fsA40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-9e0Dv2GDP16b0inkhVBBVQ-1; Fri, 20 Dec 2019 08:48:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C54107ACCC;
 Fri, 20 Dec 2019 13:48:43 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E340F5C54A;
 Fri, 20 Dec 2019 13:48:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/37] serial: make SerialIO a sysbus device
Date: Fri, 20 Dec 2019 17:45:40 +0400
Message-Id: <20191220134601.571905-17-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-1-marcandre.lureau@redhat.com>
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 9e0Dv2GDP16b0inkhVBBVQ-1
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make serial IO a proper sysbus device, similar to serial MM.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/serial.c         | 64 +++++++++++++++++++++++++++++++++-------
 include/hw/char/serial.h | 13 ++++++--
 2 files changed, 64 insertions(+), 13 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4899c0454a..84b4267ce6 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -985,22 +985,63 @@ const MemoryRegionOps serial_io_ops =3D {
     .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
-SerialState *serial_init(int base, qemu_irq irq, int baudbase,
-                         Chardev *chr, MemoryRegion *system_io)
+static void serial_io_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
-    SerialState *s =3D SERIAL(dev);
+    SerialIO *sio =3D SERIAL_IO(dev);
+    SerialState *s =3D &sio->serial;
+    Error *local_err =3D NULL;
=20
-    s->irq =3D irq;
-    qdev_prop_set_uint32(dev, "baudbase", baudbase);
-    qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_set_legacy_instance_id(dev, base, 2);
-    qdev_init_nofail(dev);
+    object_property_set_bool(OBJECT(s), true, "realized", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
     memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
-    memory_region_add_subregion(system_io, base, &s->io);
+    sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
+}
+
+static void serial_io_class_init(ObjectClass *klass, void* data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D serial_io_realize;
+    /* No dc->vmsd: class has no migratable state */
+}
+
+static void serial_io_instance_init(Object *o)
+{
+    SerialIO *sio =3D SERIAL_IO(o);
+
+    object_initialize_child(o, "serial", &sio->serial, sizeof(sio->serial)=
,
+                            TYPE_SERIAL, &error_abort, NULL);
+
+    qdev_alias_all_properties(DEVICE(&sio->serial), o);
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
+    SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
+
+    qdev_prop_set_uint32(DEVICE(sio), "baudbase", baudbase);
+    qdev_prop_set_chr(DEVICE(sio), "chardev", chr);
+    qdev_set_legacy_instance_id(DEVICE(sio), base, 2);
+    qdev_init_nofail(DEVICE(sio));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);
+    memory_region_add_subregion(system_io, base, &sio->serial.io);
=20
-    return s;
+    return sio;
 }
=20
 static Property serial_properties[] =3D {
@@ -1149,6 +1190,7 @@ static const TypeInfo serial_mm_info =3D {
 static void serial_register_types(void)
 {
     type_register_static(&serial_info);
+    type_register_static(&serial_io_info);
     type_register_static(&serial_mm_info);
 }
=20
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index d586924937..d356ba838c 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -88,6 +88,12 @@ typedef struct SerialMM {
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
@@ -99,8 +105,11 @@ void serial_set_frequency(SerialState *s, uint32_t freq=
uency);
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
2.24.0.308.g228f53135a


