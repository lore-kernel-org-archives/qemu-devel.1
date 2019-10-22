Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EC6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7642084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjGvFGJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7642084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMx0E-0003q4-Ur
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwvo-0006tW-H7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwvn-0007Hk-AM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iMwvn-0007HM-6s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571761366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+i8OgFBD4A2/05+byWS5j2CMFVOYhYSUDPGflIqzto4=;
 b=WjGvFGJ1OOKiQHmL7yFp/1C/ljuYqZD4zuD6WJUPRvI8/NhYFMNdMFl21I+QINQC4nyhwf
 3sa4h2lBM2GmSY4rUakvD/E2Q+wjk/eMr6XZGl3Xhxwm97VEoWvIJN498vVsfehIqQmZwE
 uC/GvO/xhRGks03Y5fllUUVwKia9ULo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-UALn1juJNHqMvpv0GxeWVQ-1; Tue, 22 Oct 2019 12:22:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F6A6476;
 Tue, 22 Oct 2019 16:22:40 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F0575C1D4;
 Tue, 22 Oct 2019 16:22:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/28] serial: make SerialMMState actually a different type
Date: Tue, 22 Oct 2019 18:21:15 +0200
Message-Id: <20191022162137.27161-7-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-1-marcandre.lureau@redhat.com>
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: UALn1juJNHqMvpv0GxeWVQ-1
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

And move the "it_shift" field there, since it's specific.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c         | 10 ++++++----
 include/hw/char/serial.h |  9 +++++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index b623c4e79f..4fc2bcedf1 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1025,14 +1025,14 @@ static const TypeInfo serial_info =3D {
 static uint64_t serial_mm_read(void *opaque, hwaddr addr,
                                unsigned size)
 {
-    SerialState *s =3D opaque;
+    SerialMMState *s =3D SERIAL_MM(opaque);
     return serial_ioport_read(s, addr >> s->it_shift, 1);
 }
=20
 static void serial_mm_write(void *opaque, hwaddr addr,
                             uint64_t value, unsigned size)
 {
-    SerialState *s =3D opaque;
+    SerialMMState *s =3D SERIAL_MM(opaque);
     value &=3D 255;
     serial_ioport_write(s, addr >> s->it_shift, value, 1);
 }
@@ -1066,10 +1066,11 @@ SerialState *serial_mm_init(MemoryRegion *address_s=
pace,
                             qemu_irq irq, int baudbase,
                             Chardev *chr, enum device_endian end)
 {
-    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
+    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL_MM));
+    SerialMMState *m =3D SERIAL_MM(dev);
     SerialState *s =3D SERIAL(dev);
=20
-    s->it_shift =3D it_shift;
+    m->it_shift =3D it_shift;
     s->irq =3D irq;
     s->baudbase =3D baudbase;
     qdev_prop_set_chr(dev, "chardev", chr);
@@ -1088,6 +1089,7 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
 static const TypeInfo serial_mm_info =3D {
     .name =3D TYPE_SERIAL_MM,
     .parent =3D TYPE_SERIAL,
+    .instance_size =3D sizeof(SerialMMState),
 };
=20
 static void serial_register_types(void)
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 2b8dbd88f1..62962e3c5a 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -57,7 +57,6 @@ typedef struct SerialState {
     qemu_irq irq;
     CharBackend chr;
     int last_break_enable;
-    int it_shift;
     int baudbase;
     uint32_t tsr_retry;
     guint watch_tag;
@@ -80,6 +79,12 @@ typedef struct SerialState {
     MemoryRegion io;
 } SerialState;
=20
+typedef struct SerialMMState {
+    SerialState parent;
+
+    int it_shift;
+} SerialMMState;
+
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
=20
@@ -91,7 +96,7 @@ void serial_set_frequency(SerialState *s, uint32_t freque=
ncy);
 #define SERIAL(s) OBJECT_CHECK(SerialState, (s), TYPE_SERIAL)
=20
 #define TYPE_SERIAL_MM "serial-mm"
-#define SERIAL_MM(s) OBJECT_CHECK(SerialState, (s), TYPE_SERIAL_MM)
+#define SERIAL_MM(s) OBJECT_CHECK(SerialMMState, (s), TYPE_SERIAL_MM)
=20
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
                          Chardev *chr, MemoryRegion *system_io);
--=20
2.23.0.606.g08da6496b6


