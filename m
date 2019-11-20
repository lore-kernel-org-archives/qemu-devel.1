Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AE3C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D031B20714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMBgwXyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D031B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXS2y-0005Jt-HT
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRte-0002SA-7C
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRtd-0007bJ-1Z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRtc-0007b8-UF
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gcx+lqJ1Mak00WwUwi/yoyf3KKQCBGyJASG3VRzis00=;
 b=eMBgwXyX4docIuE2Kkxj0fg7gDgi4ce3BT9PrNlgRfWlPzKdIWeeeKSb0dDOUrJzIHzQTY
 vyC5GIqr/HGQw3sLLCFwjOyS4IdBSCct/6E5cgCUrrVVI+pmPDgkrsquc2tzpTVHlVzPwB
 IF/iiavRfR9cJr6+Mni3tyKTvWlPjmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-Lv2A-SW0MhCS1HWocMqI7g-1; Wed, 20 Nov 2019 10:27:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A380802689;
 Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C77F3503F1;
 Wed, 20 Nov 2019 15:27:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/37] serial-mm: use sysbus facilities
Date: Wed, 20 Nov 2019 19:24:20 +0400
Message-Id: <20191120152442.26657-16-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Lv2A-SW0MhCS1HWocMqI7g-1
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
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make SerialMM a regular sysbus device, by registering the irq, and the
mmio region. Reexport the internal serial properties.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 1c16fed4d1..e0f1a99e8b 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1073,21 +1073,18 @@ SerialMM *serial_mm_init(MemoryRegion *address_spac=
e,
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
-    qdev_init_nofail(DEVICE(s));
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
@@ -1098,6 +1095,8 @@ static void serial_mm_instance_init(Object *o)
=20
     object_initialize_child(o, "serial", &smm->serial, sizeof(smm->serial)=
,
                             TYPE_SERIAL, &error_abort, NULL);
+
+    qdev_alias_all_properties(DEVICE(&smm->serial), o);
 }
=20
 static Property serial_mm_properties[] =3D {
@@ -1111,11 +1110,25 @@ static Property serial_mm_properties[] =3D {
     DEFINE_PROP_END_OF_LIST(),
 };
=20
+static void serial_mm_realize(DeviceState *dev, Error **errp)
+{
+    SerialMM *smm =3D SERIAL_MM(dev);
+    SerialState *s =3D &smm->serial;
+
+    qdev_init_nofail(DEVICE(s));
+
+    memory_region_init_io(&s->io, NULL, &serial_mm_ops[smm->endianness], s=
mm,
+                          "serial", 8 << smm->regshift);
+    sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
+    sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
+}
+
 static void serial_mm_class_init(ObjectClass *klass, void* data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->props =3D serial_mm_properties;
+    dc->realize =3D serial_mm_realize;
 }
=20
 static const TypeInfo serial_mm_info =3D {
--=20
2.24.0


