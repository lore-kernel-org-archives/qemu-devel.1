Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B962FCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794F620679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOjp/JbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794F620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNNOG-0004kG-9T
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 16:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKWS-0004ev-FJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKWQ-000245-6S
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37824
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKWQ-00023s-3M
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuNuTh9HEsEKkVAfEnTaFjjWEGe/RTOYLDx8IqmZ30E=;
 b=VOjp/JbQKYDFYYHKV38yhsq5oaMGyzYRwwMzLlWpA0E2EDRNJBk/4xjQqJSX0Ud/zyasVL
 lNqel2X4iriMuOB+5xKeJvI4vHLsJG1mUSGNQYrwOaWFdsgcKvRPuCkoTFJEcvPnxSSlur
 SHNgzri24/5l94a0vism6Bj4DbkuigI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-h38LJog8OiuZCqEGQxpX3A-1; Wed, 23 Oct 2019 13:34:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0D5B800D63;
 Wed, 23 Oct 2019 17:34:03 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DB775C1D4;
 Wed, 23 Oct 2019 17:33:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/33] serial-mm: use sysbus facilities
Date: Wed, 23 Oct 2019 19:31:37 +0200
Message-Id: <20191023173154.30051-17-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: h38LJog8OiuZCqEGQxpX3A-1
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

Make SerialMM a regular sysbus device, by registering the irq, and the
mmio region. Reexport the internal serial properties.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 2f7667c30c..a40bc3ab81 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1074,21 +1074,18 @@ SerialMM *serial_mm_init(MemoryRegion *address_spac=
e,
                             Chardev *chr, enum device_endian end)
 {
     SerialMM *self =3D SERIAL_MM(qdev_create(NULL, TYPE_SERIAL_MM));
-    SerialState *s =3D &self->serial;
+    MemoryRegion *mr;
=20
     qdev_prop_set_uint8(DEVICE(self), "regshift", regshift);
-    s->irq =3D irq;
-    qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
-    qdev_prop_set_chr(DEVICE(s), "chardev", chr);
-    qdev_prop_set_int32(DEVICE(s), "instance-id", base);
-    qdev_prop_set_uint8(DEVICE(s), "endianness", end);
-
-    qdev_init_nofail(DEVICE(s));
+    qdev_prop_set_uint32(DEVICE(self), "baudbase", baudbase);
+    qdev_prop_set_chr(DEVICE(self), "chardev", chr);
+    qdev_prop_set_int32(DEVICE(self), "instance-id", base);
+    qdev_prop_set_uint8(DEVICE(self), "endianness", end);
     qdev_init_nofail(DEVICE(self));
=20
-    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], self,
-                          "serial", 8 << regshift);
-    memory_region_add_subregion(address_space, base, &s->io);
+    sysbus_connect_irq(SYS_BUS_DEVICE(self), 0, irq);
+    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(self), 0);
+    memory_region_add_subregion(address_space, base, mr);
=20
     return self;
 }
@@ -1099,6 +1096,8 @@ static void serial_mm_instance_init(Object *o)
=20
     object_initialize_child(o, "serial", &self->serial, sizeof(self->seria=
l),
                             TYPE_SERIAL, &error_abort, NULL);
+
+    qdev_alias_all_properties(DEVICE(&self->serial), o);
 }
=20
 static Property serial_mm_properties[] =3D {
@@ -1107,11 +1106,25 @@ static Property serial_mm_properties[] =3D {
     DEFINE_PROP_END_OF_LIST(),
 };
=20
+static void serial_mm_realize(DeviceState *dev, Error **errp)
+{
+    SerialMM *self =3D SERIAL_MM(dev);
+    SerialState *s =3D &self->serial;
+
+    qdev_init_nofail(DEVICE(s));
+
+    memory_region_init_io(&s->io, NULL, &serial_mm_ops[self->endianness], =
self,
+                          "serial", 8 << self->regshift);
+    sysbus_init_mmio(SYS_BUS_DEVICE(self), &s->io);
+    sysbus_init_irq(SYS_BUS_DEVICE(self), &self->serial.irq);
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
2.23.0.606.g08da6496b6


