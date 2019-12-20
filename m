Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B96FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EC8218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEDFszS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EC8218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIqO-0000Xy-5d
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIe2-0005HV-JW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIe0-0003FX-LN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:48:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37962
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIdy-0003Ec-P4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVKjYAUv3XHPaE0rjsLuyLcgITuOpWJlhlrCF37XM+s=;
 b=fEDFszS7TbTD/j6uuivoSugPoQ/CdMirMA4rbifn6fOgBh1eInd33WvaE3S6X8Q6Ta9q8p
 ebbtywcen7vkySAesrAcgCsHBU3eDM0gtts0HN6Hq0WKdQ+7vJj/9aqjJo7hPEbsoJDr08
 sVPUVz2xp6mOBcpXDbdjdIRsKsjAL9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-FedH1qAAOdijs3pZ2Tiadg-1; Fri, 20 Dec 2019 08:48:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1491C8D6746;
 Fri, 20 Dec 2019 13:48:34 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F1FE26FB3;
 Fri, 20 Dec 2019 13:48:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 15/37] serial-mm: use sysbus facilities
Date: Fri, 20 Dec 2019 17:45:39 +0400
Message-Id: <20191220134601.571905-16-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-1-marcandre.lureau@redhat.com>
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: FedH1qAAOdijs3pZ2Tiadg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Make SerialMM a regular sysbus device, by registering the irq, and the
mmio region. Reexport the internal serial properties.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c | 50 +++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index e8306a803a..4899c0454a 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1044,18 +1044,6 @@ static void serial_mm_write(void *opaque, hwaddr add=
r,
     serial_ioport_write(&s->serial, addr >> s->regshift, value, 1);
 }
=20
-static void serial_mm_realize(DeviceState *dev, Error **errp)
-{
-    SerialMM *s =3D SERIAL_MM(dev);
-    Error *local_err =3D NULL;
-
-    object_property_set_bool(OBJECT(&s->serial), true, "realized", &local_=
err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-}
-
 static const MemoryRegionOps serial_mm_ops[3] =3D {
     [DEVICE_NATIVE_ENDIAN] =3D {
         .read =3D serial_mm_read,
@@ -1080,26 +1068,42 @@ static const MemoryRegionOps serial_mm_ops[3] =3D {
     },
 };
=20
+static void serial_mm_realize(DeviceState *dev, Error **errp)
+{
+    SerialMM *smm =3D SERIAL_MM(dev);
+    SerialState *s =3D &smm->serial;
+    Error *local_err =3D NULL;
+
+    object_property_set_bool(OBJECT(s), true, "realized", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    memory_region_init_io(&s->io, NULL, &serial_mm_ops[smm->endianness], s=
mm,
+                          "serial", 8 << smm->regshift);
+    sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
+    sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
+}
+
 SerialMM *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int regshift,
                             qemu_irq irq, int baudbase,
                             Chardev *chr, enum device_endian end)
 {
     SerialMM *smm =3D SERIAL_MM(qdev_create(NULL, TYPE_SERIAL_MM));
-    SerialState *s =3D &smm->serial;
+    MemoryRegion *mr;
=20
     qdev_prop_set_uint8(DEVICE(smm), "regshift", regshift);
-    s->irq =3D irq;
-    qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
-    qdev_prop_set_chr(DEVICE(s), "chardev", chr);
-    qdev_set_legacy_instance_id(DEVICE(s), base, 2);
-    qdev_prop_set_uint8(DEVICE(self), "endianness", end);
-
+    qdev_prop_set_uint32(DEVICE(smm), "baudbase", baudbase);
+    qdev_prop_set_chr(DEVICE(smm), "chardev", chr);
+    qdev_set_legacy_instance_id(DEVICE(smm), base, 2);
+    qdev_prop_set_uint8(DEVICE(smm), "endianness", end);
     qdev_init_nofail(DEVICE(smm));
=20
-    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], smm,
-                          "serial", 8 << regshift);
-    memory_region_add_subregion(address_space, base, &s->io);
+    sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, irq);
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(smm), 0);
+    memory_region_add_subregion(address_space, base, mr);
=20
     return smm;
 }
@@ -1110,6 +1114,8 @@ static void serial_mm_instance_init(Object *o)
=20
     object_initialize_child(o, "serial", &smm->serial, sizeof(smm->serial)=
,
                             TYPE_SERIAL, &error_abort, NULL);
+
+    qdev_alias_all_properties(DEVICE(&smm->serial), o);
 }
=20
 static Property serial_mm_properties[] =3D {
--=20
2.24.0.308.g228f53135a


