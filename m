Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E309ECA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B082E2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3EjU4JO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B082E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNKnR-0000UB-FA
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 13:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKWC-0004XH-QI
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKWA-0001xd-Fm
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31689
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKWA-0001xX-Bd
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/D1J2UJzAyc6e7JxXWFA+jl9eJCtu5Stu1K8cmuV8Ew=;
 b=T3EjU4JOLaZG6Rlwn3ZQh6sCr6PjL8fDfJVwqTm5xr761AFiftbEsXJJtRvksCrglpMyh3
 qvvi89cD+RRcDE62m9cqeiOShJNvH4BSJ6gMg8pxBzNfHjpWE9cauMMc7uRlgCNiwIX4DK
 KlVKEKgc5EQm2cSdsAvITQVJo3C4e2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-ds4_ypJXNrOU9Skouh5BJg-1; Wed, 23 Oct 2019 13:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B4BD801E70;
 Wed, 23 Oct 2019 17:33:48 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9F7360BE1;
 Wed, 23 Oct 2019 17:33:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/33] serial: start making SerialMM a sysbus device
Date: Wed, 23 Oct 2019 19:31:34 +0200
Message-Id: <20191023173154.30051-14-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ds4_ypJXNrOU9Skouh5BJg-1
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

Memory mapped serial device is in fact a sysbus device. The following
patches will make use of sysbus facilities for resource and
registration.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/omap_uart.c      |  2 +-
 hw/char/serial.c         | 47 ++++++++++++++++++++++++++++------------
 hw/mips/boston.c         |  2 +-
 hw/mips/mips_malta.c     |  2 +-
 include/hw/char/serial.h | 20 ++++++++++++-----
 5 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 13e4f43c4c..e8da933378 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -27,7 +27,7 @@
 struct omap_uart_s {
     MemoryRegion iomem;
     hwaddr base;
-    SerialState *serial; /* TODO */
+    SerialMM *serial; /* TODO */
     struct omap_target_agent_s *ta;
     omap_clk fclk;
     qemu_irq irq;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 667570e310..0290b3c633 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1032,16 +1032,16 @@ static const TypeInfo serial_info =3D {
 static uint64_t serial_mm_read(void *opaque, hwaddr addr,
                                unsigned size)
 {
-    SerialState *s =3D opaque;
-    return serial_ioport_read(s, addr >> s->it_shift, 1);
+    SerialMM *s =3D SERIAL_MM(opaque);
+    return serial_ioport_read(&s->serial, addr >> s->it_shift, 1);
 }
=20
 static void serial_mm_write(void *opaque, hwaddr addr,
                             uint64_t value, unsigned size)
 {
-    SerialState *s =3D opaque;
+    SerialMM *s =3D SERIAL_MM(opaque);
     value &=3D 255;
-    serial_ioport_write(s, addr >> s->it_shift, value, 1);
+    serial_ioport_write(&s->serial, addr >> s->it_shift, value, 1);
 }
=20
 static const MemoryRegionOps serial_mm_ops[3] =3D {
@@ -1068,30 +1068,49 @@ static const MemoryRegionOps serial_mm_ops[3] =3D {
     },
 };
=20
-SerialState *serial_mm_init(MemoryRegion *address_space,
+SerialMM *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int it_shift,
                             qemu_irq irq, int baudbase,
                             Chardev *chr, enum device_endian end)
 {
-    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
-    SerialState *s =3D SERIAL(dev);
+    SerialMM *self =3D SERIAL_MM(qdev_create(NULL, TYPE_SERIAL_MM));
+    SerialState *s =3D &self->serial;
=20
-    s->it_shift =3D it_shift;
+    self->it_shift =3D it_shift;
     s->irq =3D irq;
-    qdev_prop_set_uint32(dev, "baudbase", baudbase);
-    qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_prop_set_int32(dev, "instance-id", base);
-    qdev_init_nofail(dev);
+    qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
+    qdev_prop_set_chr(DEVICE(s), "chardev", chr);
+    qdev_prop_set_int32(DEVICE(s), "instance-id", base);
+
+    qdev_init_nofail(DEVICE(s));
+    qdev_init_nofail(DEVICE(self));
=20
-    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
+    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], self,
                           "serial", 8 << it_shift);
     memory_region_add_subregion(address_space, base, &s->io);
-    return s;
+
+    return self;
+}
+
+static void serial_mm_instance_init(Object *o)
+{
+    SerialMM *self =3D SERIAL_MM(o);
+
+    object_initialize_child(o, "serial", &self->serial, sizeof(self->seria=
l),
+                            TYPE_SERIAL, &error_abort, NULL);
 }
=20
+static const TypeInfo serial_mm_info =3D {
+    .name =3D TYPE_SERIAL_MM,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_init =3D serial_mm_instance_init,
+    .instance_size =3D sizeof(SerialMM),
+};
+
 static void serial_register_types(void)
 {
     type_register_static(&serial_info);
+    type_register_static(&serial_mm_info);
 }
=20
 type_init(serial_register_types)
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index ca7d813a52..23fdd5ec6a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -50,7 +50,7 @@ typedef struct {
=20
     MachineState *mach;
     MIPSCPSState cps;
-    SerialState *uart;
+    SerialMM *uart;
=20
     CharBackend lcd_display;
     char lcd_content[8];
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 4d9c64b36a..efc3307973 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -86,7 +86,7 @@ typedef struct {
     uint32_t i2csel;
     CharBackend display;
     char display_text[9];
-    SerialState *uart;
+    SerialMM *uart;
     bool display_inited;
 } MaltaFPGAState;
=20
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 7cc6304f1d..f146d426c2 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -57,7 +57,6 @@ typedef struct SerialState {
     qemu_irq irq;
     CharBackend chr;
     int last_break_enable;
-    int it_shift;
     uint32_t baudbase;
     uint32_t tsr_retry;
     guint watch_tag;
@@ -81,6 +80,14 @@ typedef struct SerialState {
     int instance_id;
 } SerialState;
=20
+typedef struct SerialMM {
+    SysBusDevice parent;
+
+    SerialState serial;
+
+    int it_shift;
+} SerialMM;
+
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
=20
@@ -89,12 +96,15 @@ void serial_set_frequency(SerialState *s, uint32_t freq=
uency);
 #define TYPE_SERIAL "serial"
 #define SERIAL(s) OBJECT_CHECK(SerialState, (s), TYPE_SERIAL)
=20
+#define TYPE_SERIAL_MM "serial-mm"
+#define SERIAL_MM(s) OBJECT_CHECK(SerialMM, (s), TYPE_SERIAL_MM)
+
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
                          Chardev *chr, MemoryRegion *system_io);
-SerialState *serial_mm_init(MemoryRegion *address_space,
-                            hwaddr base, int it_shift,
-                            qemu_irq irq, int baudbase,
-                            Chardev *chr, enum device_endian end);
+SerialMM *serial_mm_init(MemoryRegion *address_space,
+                         hwaddr base, int it_shift,
+                         qemu_irq irq, int baudbase,
+                         Chardev *chr, enum device_endian end);
=20
 /* serial-isa.c */
=20
--=20
2.23.0.606.g08da6496b6


