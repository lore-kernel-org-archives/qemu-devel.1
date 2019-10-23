Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A7ACA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775592086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E09VQdQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775592086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNKlR-0007gG-Mx
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 13:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKW6-0004Un-Iw
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKW5-0001wQ-59
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50075
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKW4-0001w3-Sf
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LU937jUM4xTYnxevSguqjhIZuQ0N7Ks/n2k0JkO4NWc=;
 b=E09VQdQKTjefiYrv5OFIQoEPUMTfR0Vy6YaCwQCfi1cV8OAyVVMCAq1GZV8dBQjNGlfncj
 hxqhWyywcl8rUa4rhRqcQoWpR69GGgUBFD0VIpiiUvsF9BP6+9p8Y86mm9gtjkjvqbaEd9
 tgP84AemCiicGdQbZVKDYBUAd5yJ9+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-EAsj01G3P8eZdbsaZbtTfA-1; Wed, 23 Oct 2019 13:33:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 153C4801E72;
 Wed, 23 Oct 2019 17:33:42 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 946FC6061E;
 Wed, 23 Oct 2019 17:33:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/33] serial: realize the serial device
Date: Wed, 23 Oct 2019 19:31:32 +0200
Message-Id: <20191023173154.30051-12-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EAsj01G3P8eZdbsaZbtTfA-1
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

Instead of calling serial_realize_core(), use the QDev realize
callback. Move qdev_set_legacy_instance_id() there.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial-isa.c       |  2 +-
 hw/char/serial-pci-multi.c |  2 +-
 hw/char/serial-pci.c       |  2 +-
 hw/char/serial.c           | 11 +++++------
 include/hw/char/serial.h   |  1 -
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 9a5928b3ee..33e093f1e6 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -75,7 +75,7 @@ static void serial_isa_realizefn(DeviceState *dev, Error =
**errp)
=20
     s->baudbase =3D 115200;
     isa_init_irq(isadev, &s->irq, isa->isairq);
-    serial_realize_core(s, errp);
+    object_property_set_bool(OBJECT(s), true, "realized", errp);
     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
=20
     memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "serial"=
, 8);
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 3485bdad87..60c1c948b8 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -108,7 +108,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Er=
ror **errp)
     for (i =3D 0; i < nr_ports; i++) {
         s =3D pci->state + i;
         s->baudbase =3D 115200;
-        serial_realize_core(s, &err);
+        object_property_set_bool(OBJECT(s), true, "realized", &err);
         if (err !=3D NULL) {
             error_propagate(errp, err);
             multi_serial_pci_exit(dev);
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index a33264a1fb..35a8552674 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -50,7 +50,7 @@ static void serial_pci_realize(PCIDevice *dev, Error **er=
rp)
     Error *err =3D NULL;
=20
     s->baudbase =3D 115200;
-    serial_realize_core(s, &err);
+    object_property_set_bool(OBJECT(s), true, "realized", &err);
     if (err !=3D NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0b61a71e4e..bf34d9594e 100644
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
@@ -946,6 +948,7 @@ void serial_realize_core(SerialState *s, Error **errp)
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
     serial_reset(s);
+    qdev_set_legacy_instance_id(dev, s->instance_id, 2);
 }
=20
 void serial_exit_core(SerialState *s)
@@ -991,8 +994,6 @@ SerialState *serial_init(int base, qemu_irq irq, int ba=
udbase,
     qdev_prop_set_uint32(dev, "baudbase", baudbase);
     qdev_prop_set_chr(dev, "chardev", chr);
     qdev_prop_set_int32(dev, "instance-id", base);
-    serial_realize_core(s, &error_fatal);
-    qdev_set_legacy_instance_id(dev, base, 2);
     qdev_init_nofail(dev);
=20
     memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
@@ -1012,6 +1013,7 @@ static void serial_class_init(ObjectClass *klass, voi=
d* data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
+    dc->realize =3D serial_realize;
     dc->vmsd =3D &vmstate_serial;
     dc->props =3D serial_properties;
 }
@@ -1076,9 +1078,6 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
     qdev_prop_set_uint32(dev, "baudbase", baudbase);
     qdev_prop_set_chr(dev, "chardev", chr);
     qdev_prop_set_int32(dev, "instance-id", base);
-
-    serial_realize_core(s, &error_fatal);
-    qdev_set_legacy_instance_id(dev, base, 2);
     qdev_init_nofail(dev);
=20
     memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index b472c7cd57..b445df5951 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -84,7 +84,6 @@ typedef struct SerialState {
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
=20
-void serial_realize_core(SerialState *s, Error **errp);
 void serial_exit_core(SerialState *s);
 void serial_set_frequency(SerialState *s, uint32_t frequency);
=20
--=20
2.23.0.606.g08da6496b6


