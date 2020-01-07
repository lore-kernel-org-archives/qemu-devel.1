Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41DCC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F202077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvK5mnjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F202077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqrN-0003ou-Rk
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqSQ-00039x-EP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqSP-0004NA-4J
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:07:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60113
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ioqSP-0004Mr-0L
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppDKqzfEKKIG7Qx/VnzMAXmwrM9QBgkLvpbuCCdqIC8=;
 b=VvK5mnjV8lTRQatT6m5exNpxLCluSU/C78BpZusCvYtI1wkOB1zVGJtfdphS0NR5WJO/kn
 fgF9gZwv1oe24e3ZuJG+8KZ+cZStmkOOag/78KPstjXN8vlMk6UsyS8PTbeYwU/NHc2nba
 YZRkXKAs4UT+fhE9M2D2o2PyX6ZZNPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-5kqHPY8nN_COJ5cHpd_zeQ-1; Tue, 07 Jan 2020 10:07:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C2C0107ACCC;
 Tue,  7 Jan 2020 15:07:42 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 106BC86C40;
 Tue,  7 Jan 2020 15:07:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/37] serial-mm: use sysbus facilities
Date: Tue,  7 Jan 2020 19:04:20 +0400
Message-Id: <20200107150442.1727958-16-marcandre.lureau@redhat.com>
In-Reply-To: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 5kqHPY8nN_COJ5cHpd_zeQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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
index 1d350a851b..b3927c7198 100644
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
2.25.0.rc1.20.g2443f3f80d


