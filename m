Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5142CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13C220663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdoJ4pl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13C220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNM9w-0008H5-7F
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 15:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKWN-0004c2-S0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKWM-00020x-Dz
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40799
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKWM-0001zT-8o
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IePSxhFaXvcTXd9uZyRiYxkYI/3893jzovLyjvT01ew=;
 b=SdoJ4pl74iq+Tn71pxxQ6ahxQAOOuC2mgWGHjYg5ZdLnlwOFBM2WFQURW1bc5flCCqdbZH
 NM/ENCIwUteDUY7e51NQaPaPR7QRWZ7q6KCU9KbEoMwI+jN44ocer0ePWso9XX8WzeA9Mu
 TSySYcImw8eMlPDlNSlK6n/oSwcu9kQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-vHVna7eBMM-_R9SZDHrYpA-1; Wed, 23 Oct 2019 13:33:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18BE51800E04;
 Wed, 23 Oct 2019 17:33:50 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 916E060BE1;
 Wed, 23 Oct 2019 17:33:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/33] serial-mm: add "regshift" property
Date: Wed, 23 Oct 2019 19:31:35 +0200
Message-Id: <20191023173154.30051-15-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: vHVna7eBMM-_R9SZDHrYpA-1
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

And a property and rename "it_shift" field to "regshift", as it seems
to be more popular (and I don't know what "it" stands for).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c         | 23 ++++++++++++++++++-----
 include/hw/char/serial.h |  4 ++--
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0290b3c633..c28cfc94fd 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1033,7 +1033,7 @@ static uint64_t serial_mm_read(void *opaque, hwaddr a=
ddr,
                                unsigned size)
 {
     SerialMM *s =3D SERIAL_MM(opaque);
-    return serial_ioport_read(&s->serial, addr >> s->it_shift, 1);
+    return serial_ioport_read(&s->serial, addr >> s->regshift, 1);
 }
=20
 static void serial_mm_write(void *opaque, hwaddr addr,
@@ -1041,7 +1041,7 @@ static void serial_mm_write(void *opaque, hwaddr addr=
,
 {
     SerialMM *s =3D SERIAL_MM(opaque);
     value &=3D 255;
-    serial_ioport_write(&s->serial, addr >> s->it_shift, value, 1);
+    serial_ioport_write(&s->serial, addr >> s->regshift, value, 1);
 }
=20
 static const MemoryRegionOps serial_mm_ops[3] =3D {
@@ -1069,14 +1069,14 @@ static const MemoryRegionOps serial_mm_ops[3] =3D {
 };
=20
 SerialMM *serial_mm_init(MemoryRegion *address_space,
-                            hwaddr base, int it_shift,
+                            hwaddr base, int regshift,
                             qemu_irq irq, int baudbase,
                             Chardev *chr, enum device_endian end)
 {
     SerialMM *self =3D SERIAL_MM(qdev_create(NULL, TYPE_SERIAL_MM));
     SerialState *s =3D &self->serial;
=20
-    self->it_shift =3D it_shift;
+    qdev_prop_set_uint8(DEVICE(self), "regshift", regshift);
     s->irq =3D irq;
     qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
     qdev_prop_set_chr(DEVICE(s), "chardev", chr);
@@ -1086,7 +1086,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
     qdev_init_nofail(DEVICE(self));
=20
     memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], self,
-                          "serial", 8 << it_shift);
+                          "serial", 8 << regshift);
     memory_region_add_subregion(address_space, base, &s->io);
=20
     return self;
@@ -1100,11 +1100,24 @@ static void serial_mm_instance_init(Object *o)
                             TYPE_SERIAL, &error_abort, NULL);
 }
=20
+static Property serial_mm_properties[] =3D {
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
index f146d426c2..759c85976d 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -85,7 +85,7 @@ typedef struct SerialMM {
=20
     SerialState serial;
=20
-    int it_shift;
+    uint8_t regshift;
 } SerialMM;
=20
 extern const VMStateDescription vmstate_serial;
@@ -102,7 +102,7 @@ void serial_set_frequency(SerialState *s, uint32_t freq=
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
2.23.0.606.g08da6496b6


