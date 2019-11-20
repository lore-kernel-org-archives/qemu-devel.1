Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C274EC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8EE206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQTMzxuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8EE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXS0j-0001iJ-Ba
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRtA-0001qa-Ph
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRt9-0007SG-9k
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25860
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRt9-0007S5-44
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBEJ1PyhMHNH1myZtB7lpQu8g1jjowBf8BuzAqx925s=;
 b=jQTMzxucia0HY92L8q0NGwA5HY6aHyo0m4UAbRqcBmgsO5P/ma58CZeeay+33eNaVBlp0s
 tJlr4y0sz3kGlMRDEdqtXyDvWYxKlME6AhkEvn1cKIxZuO8NEa4Se3222R/XlUV46JTUDH
 p3UEhF/ATBPzeL+ra9j7WGtUL6MDfY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-Bq4qx5LuMCyOVhZPYkGHPA-1; Wed, 20 Nov 2019 10:27:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B39B6477;
 Wed, 20 Nov 2019 15:27:24 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA5BD1037ADA;
 Wed, 20 Nov 2019 15:27:16 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/37] serial-mm: add "regshift" property
Date: Wed, 20 Nov 2019 19:24:18 +0400
Message-Id: <20191120152442.26657-14-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Bq4qx5LuMCyOVhZPYkGHPA-1
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
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

And a property and rename "it_shift" field to "regshift", as it seems
to be more popular (and I don't know what "it" stands for).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c         | 28 +++++++++++++++++++++++-----
 include/hw/char/serial.h |  4 ++--
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index cb9cbd5146..225f09f30f 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1032,7 +1032,7 @@ static uint64_t serial_mm_read(void *opaque, hwaddr a=
ddr,
                                unsigned size)
 {
     SerialMM *s =3D SERIAL_MM(opaque);
-    return serial_ioport_read(&s->serial, addr >> s->it_shift, 1);
+    return serial_ioport_read(&s->serial, addr >> s->regshift, 1);
 }
=20
 static void serial_mm_write(void *opaque, hwaddr addr,
@@ -1040,7 +1040,7 @@ static void serial_mm_write(void *opaque, hwaddr addr=
,
 {
     SerialMM *s =3D SERIAL_MM(opaque);
     value &=3D 255;
-    serial_ioport_write(&s->serial, addr >> s->it_shift, value, 1);
+    serial_ioport_write(&s->serial, addr >> s->regshift, value, 1);
 }
=20
 static const MemoryRegionOps serial_mm_ops[3] =3D {
@@ -1068,14 +1068,14 @@ static const MemoryRegionOps serial_mm_ops[3] =3D {
 };
=20
 SerialMM *serial_mm_init(MemoryRegion *address_space,
-                            hwaddr base, int it_shift,
+                            hwaddr base, int regshift,
                             qemu_irq irq, int baudbase,
                             Chardev *chr, enum device_endian end)
 {
     SerialMM *smm =3D SERIAL_MM(qdev_create(NULL, TYPE_SERIAL_MM));
     SerialState *s =3D &smm->serial;
=20
-    smm->it_shift =3D it_shift;
+    qdev_prop_set_uint8(DEVICE(smm), "regshift", regshift);
     s->irq =3D irq;
     qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
     qdev_prop_set_chr(DEVICE(s), "chardev", chr);
@@ -1085,7 +1085,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
     qdev_init_nofail(DEVICE(smm));
=20
     memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], smm,
-                          "serial", 8 << it_shift);
+                          "serial", 8 << regshift);
     memory_region_add_subregion(address_space, base, &s->io);
=20
     return smm;
@@ -1099,11 +1099,29 @@ static void serial_mm_instance_init(Object *o)
                             TYPE_SERIAL, &error_abort, NULL);
 }
=20
+static Property serial_mm_properties[] =3D {
+    /*
+     * Set the spacing between adjacent memory-mapped UART registers.
+     * Each register will be at (1 << regshift) bytes after the
+     * previous one.
+     */
+    DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void serial_mm_class_init(ObjectClass *klass, void* data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->props =3D serial_mm_properties;
+}
+
 static const TypeInfo serial_mm_info =3D {
     .name =3D TYPE_SERIAL_MM,
     .parent =3D TYPE_SYS_BUS_DEVICE,
     .instance_init =3D serial_mm_instance_init,
     .instance_size =3D sizeof(SerialMM),
+    .class_init =3D serial_mm_class_init,
 };
=20
 static void serial_register_types(void)
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 730165347c..eaeda62698 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -84,7 +84,7 @@ typedef struct SerialMM {
=20
     SerialState serial;
=20
-    int it_shift;
+    uint8_t regshift;
 } SerialMM;
=20
 extern const VMStateDescription vmstate_serial;
@@ -101,7 +101,7 @@ void serial_set_frequency(SerialState *s, uint32_t freq=
uency);
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
                          Chardev *chr, MemoryRegion *system_io);
 SerialMM *serial_mm_init(MemoryRegion *address_space,
-                         hwaddr base, int it_shift,
+                         hwaddr base, int regshift,
                          qemu_irq irq, int baudbase,
                          Chardev *chr, enum device_endian end);
=20
--=20
2.24.0


