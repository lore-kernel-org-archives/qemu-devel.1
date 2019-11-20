Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C39C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4080520637
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8Ettiug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4080520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRxA-0006Q1-Aq
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRt1-0001aZ-Sr
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRt0-0007QO-9a
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44696
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRt0-0007QE-66
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TK1v7ipOblhwhZ7OE6pi8l1Aqnl9u0xXk7lixjgMW3c=;
 b=b8EttiugF56sEizhxRzoD8NyXQykLy2KVk5OY+m0KBf4ccCjlmUi4WRo65u8XCBB3Jb0ZW
 Yx4xlhnnsVKG1tI8dLtHU8MWfsFnDonFpfGBDjgBJiQAKWW9Ntwj6cjIZHdgA+M72iEcw7
 4/XOEcGaiXd+ZvK3Q5gEDHlgE4e6QyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-D28crsGlPPi-HXL5fvyiuQ-1; Wed, 20 Nov 2019 10:27:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A4D91005514;
 Wed, 20 Nov 2019 15:27:12 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB1166055B;
 Wed, 20 Nov 2019 15:27:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/37] serial: start making SerialMM a sysbus device
Date: Wed, 20 Nov 2019 19:24:17 +0400
Message-Id: <20191120152442.26657-13-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: D28crsGlPPi-HXL5fvyiuQ-1
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
Cc: Paul Burton <pburton@wavecomp.com>, peter.maydell@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Memory mapped serial device is in fact a sysbus device. The following
patches will make use of sysbus facilities for resource and
registration. In particular, "serial-mm: use sysbus facilities" will
move internal serial realization to serial_mm_realize callback to
follow qdev best practices.

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
index 2d8471dbbb..cb9cbd5146 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1031,16 +1031,16 @@ static const TypeInfo serial_info =3D {
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
@@ -1067,30 +1067,49 @@ static const MemoryRegionOps serial_mm_ops[3] =3D {
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
+    SerialMM *smm =3D SERIAL_MM(qdev_create(NULL, TYPE_SERIAL_MM));
+    SerialState *s =3D &smm->serial;
=20
-    s->it_shift =3D it_shift;
+    smm->it_shift =3D it_shift;
     s->irq =3D irq;
-    qdev_prop_set_uint32(dev, "baudbase", baudbase);
-    qdev_prop_set_chr(dev, "chardev", chr);
-    qdev_set_legacy_instance_id(dev, base, 2);
-    qdev_init_nofail(dev);
+    qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
+    qdev_prop_set_chr(DEVICE(s), "chardev", chr);
+    qdev_set_legacy_instance_id(DEVICE(s), base, 2);
+
+    qdev_init_nofail(DEVICE(s));
+    qdev_init_nofail(DEVICE(smm));
=20
-    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
+    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], smm,
                           "serial", 8 << it_shift);
     memory_region_add_subregion(address_space, base, &s->io);
-    return s;
+
+    return smm;
+}
+
+static void serial_mm_instance_init(Object *o)
+{
+    SerialMM *smm =3D SERIAL_MM(o);
+
+    object_initialize_child(o, "serial", &smm->serial, sizeof(smm->serial)=
,
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
index 92e9ca5bfa..89b5e3123a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -83,7 +83,7 @@ typedef struct {
     uint32_t i2csel;
     CharBackend display;
     char display_text[9];
-    SerialState *uart;
+    SerialMM *uart;
     bool display_inited;
 } MaltaFPGAState;
=20
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 548944b06a..730165347c 100644
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
@@ -80,6 +79,14 @@ typedef struct SerialState {
     MemoryRegion io;
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
@@ -88,12 +95,15 @@ void serial_set_frequency(SerialState *s, uint32_t freq=
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
2.24.0


