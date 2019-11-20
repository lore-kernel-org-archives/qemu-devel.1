Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB488C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7572620637
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzRYwHeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7572620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRy8-0007jN-0W
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRsW-0000hy-NT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRsV-0007Jf-Ch
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27158
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRsV-0007JX-90
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02Mz5s6Q+ERkvYFCo/0mxE2I5Oc43nGBXfCP2ygipEA=;
 b=bzRYwHegJ3NFtaYO9bhiXLeBswKHIaJtQjlhp52h/FhkXrQx9SUmvnGYRiqHpKHvlLlyth
 uKBJelV5EguC13aNAHOqAqxpdiStHjeJA9gAR5vXno2iM5Umd0tUxULPfbmcqViajX1l6z
 gZhEnbl9Lr5y8bg7A9K9E4DDiMmsVIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-BZ81LqcPO6Kutux_yRe9KQ-1; Wed, 20 Nov 2019 10:26:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7AC01005502;
 Wed, 20 Nov 2019 15:26:42 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDCEC2AA8A;
 Wed, 20 Nov 2019 15:26:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/37] serial: realize the serial device
Date: Wed, 20 Nov 2019 19:24:15 +0400
Message-Id: <20191120152442.26657-11-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: BZ81LqcPO6Kutux_yRe9KQ-1
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

Instead of calling serial_realize_core(), use the QDev realize
callback.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial-isa.c       | 2 +-
 hw/char/serial-pci-multi.c | 2 +-
 hw/char/serial-pci.c       | 2 +-
 hw/char/serial.c           | 8 ++++----
 include/hw/char/serial.h   | 1 -
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 2a4c8de1bf..db8644551e 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -74,7 +74,7 @@ static void serial_isa_realizefn(DeviceState *dev, Error =
**errp)
     index++;
=20
     isa_init_irq(isadev, &s->irq, isa->isairq);
-    serial_realize_core(s, errp);
+    object_property_set_bool(OBJECT(s), true, "realized", errp);
     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
=20
     memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "serial"=
, 8);
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 4891f32230..0e1fdb75d2 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -106,7 +106,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Er=
ror **errp)
=20
     for (i =3D 0; i < nports; i++) {
         s =3D pci->state + i;
-        serial_realize_core(s, &err);
+        object_property_set_bool(OBJECT(s), true, "realized", &err);
         if (err !=3D NULL) {
             error_propagate(errp, err);
             multi_serial_pci_exit(dev);
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index db2c17aafd..4b6a217365 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -49,7 +49,7 @@ static void serial_pci_realize(PCIDevice *dev, Error **er=
rp)
     SerialState *s =3D &pci->state;
     Error *err =3D NULL;
=20
-    serial_realize_core(s, &err);
+    object_property_set_bool(OBJECT(s), true, "realized", &err);
     if (err !=3D NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4a598ead21..1f3859eef1 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -934,8 +934,10 @@ static int serial_be_change(void *opaque)
     return 0;
 }
=20
-void serial_realize_core(SerialState *s, Error **errp)
+static void serial_realize(DeviceState *dev, Error **errp)
 {
+    SerialState *s =3D SERIAL(dev);
+
     s->modem_status_poll =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB=
 *) serial_update_msl, s);
=20
     s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerC=
B *) fifo_timeout_int, s);
@@ -990,7 +992,6 @@ SerialState *serial_init(int base, qemu_irq irq, int ba=
udbase,
     s->irq =3D irq;
     qdev_prop_set_uint32(dev, "baudbase", baudbase);
     qdev_prop_set_chr(dev, "chardev", chr);
-    serial_realize_core(s, &error_fatal);
     qdev_set_legacy_instance_id(dev, base, 2);
     qdev_init_nofail(dev);
=20
@@ -1011,6 +1012,7 @@ static void serial_class_init(ObjectClass *klass, voi=
d* data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->user_creatable =3D false;
+    dc->realize =3D serial_realize;
     dc->vmsd =3D &vmstate_serial;
     dc->props =3D serial_properties;
 }
@@ -1074,8 +1076,6 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
     s->irq =3D irq;
     qdev_prop_set_uint32(dev, "baudbase", baudbase);
     qdev_prop_set_chr(dev, "chardev", chr);
-
-    serial_realize_core(s, &error_fatal);
     qdev_set_legacy_instance_id(dev, base, 2);
     qdev_init_nofail(dev);
=20
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 3dc618598e..571aab97c8 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -83,7 +83,6 @@ typedef struct SerialState {
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
=20
-void serial_realize_core(SerialState *s, Error **errp);
 void serial_exit_core(SerialState *s);
 void serial_set_frequency(SerialState *s, uint32_t frequency);
=20
--=20
2.24.0


