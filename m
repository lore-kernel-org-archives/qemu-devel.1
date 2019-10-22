Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7627DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB172084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+6xD+tY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB172084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMx0n-0004mf-G3
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwvw-00073s-2W
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwvu-0007Ja-PK
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iMwvu-0007JI-LG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571761374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpuM9Cna4yoB6f1N21BTHcy+qv96PV8TfZl7+kRUFJ0=;
 b=V+6xD+tY7PDfoOuw0/3fOOzbHj4zQ7CcAplU0CaHTMBpC3A7ZhYg5bRGvYclw9iZq1XriD
 xGNnUa8ZCg6r6Pp850ogtmn/CVoluh4MXJ+ptOJVLuEB9VPlU3hkHmFsOhPPGb1wremS8d
 0hj4pAOmajqBYSbUyidDtZnkZVV4iYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-8neNo7aOMBG-ND4-ujOLWQ-1; Tue, 22 Oct 2019 12:22:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B6001005500;
 Tue, 22 Oct 2019 16:22:48 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2192B6012D;
 Tue, 22 Oct 2019 16:22:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/28] serial: add and set "regshift" property
Date: Tue, 22 Oct 2019 18:21:16 +0200
Message-Id: <20191022162137.27161-8-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-1-marcandre.lureau@redhat.com>
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 8neNo7aOMBG-ND4-ujOLWQ-1
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

And rename "it_shift" field to "regshift", as it seems to be more
popular for this (and I don't know what "it" stands for).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c         | 23 ++++++++++++++++++-----
 include/hw/char/serial.h |  2 +-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4fc2bcedf1..18ca79ccf3 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1026,7 +1026,7 @@ static uint64_t serial_mm_read(void *opaque, hwaddr a=
ddr,
                                unsigned size)
 {
     SerialMMState *s =3D SERIAL_MM(opaque);
-    return serial_ioport_read(s, addr >> s->it_shift, 1);
+    return serial_ioport_read(s, addr >> s->regshift, 1);
 }
=20
 static void serial_mm_write(void *opaque, hwaddr addr,
@@ -1034,7 +1034,7 @@ static void serial_mm_write(void *opaque, hwaddr addr=
,
 {
     SerialMMState *s =3D SERIAL_MM(opaque);
     value &=3D 255;
-    serial_ioport_write(s, addr >> s->it_shift, value, 1);
+    serial_ioport_write(s, addr >> s->regshift, value, 1);
 }
=20
 static const MemoryRegionOps serial_mm_ops[3] =3D {
@@ -1062,7 +1062,7 @@ static const MemoryRegionOps serial_mm_ops[3] =3D {
 };
=20
 SerialState *serial_mm_init(MemoryRegion *address_space,
-                            hwaddr base, int it_shift,
+                            hwaddr base, int regshift,
                             qemu_irq irq, int baudbase,
                             Chardev *chr, enum device_endian end)
 {
@@ -1070,26 +1070,39 @@ SerialState *serial_mm_init(MemoryRegion *address_s=
pace,
     SerialMMState *m =3D SERIAL_MM(dev);
     SerialState *s =3D SERIAL(dev);
=20
-    m->it_shift =3D it_shift;
     s->irq =3D irq;
     s->baudbase =3D baudbase;
     qdev_prop_set_chr(dev, "chardev", chr);
+    qdev_prop_set_uint8(dev, "regshift", regshift);
=20
     serial_realize_core(s, &error_fatal);
     qdev_set_legacy_instance_id(DEVICE(s), base, 2);
     qdev_init_nofail(dev);
=20
     memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
-                          "serial", 8 << it_shift);
+                          "serial", 8 << m->regshift);
     memory_region_add_subregion(address_space, base, &s->io);
=20
     return s;
 }
=20
+static Property serial_mm_properties[] =3D {
+    DEFINE_PROP_UINT8("regshift", SerialMMState, regshift, 0),
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
     .parent =3D TYPE_SERIAL,
     .instance_size =3D sizeof(SerialMMState),
+    .class_init =3D serial_mm_class_init,
 };
=20
 static void serial_register_types(void)
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 62962e3c5a..613879ced8 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -82,7 +82,7 @@ typedef struct SerialState {
 typedef struct SerialMMState {
     SerialState parent;
=20
-    int it_shift;
+    uint8_t regshift;
 } SerialMMState;
=20
 extern const VMStateDescription vmstate_serial;
--=20
2.23.0.606.g08da6496b6


