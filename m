Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0355C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF273218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJkvOG5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF273218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIil-0005Lc-8z
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIcz-0003tC-IJ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIcy-0008W3-5E
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:47:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39664
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIcx-0008U4-Uq
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trohubcB+l/ZA+9i9PZqlz4RM2grBdGpv/nN0C6XYvs=;
 b=eJkvOG5TDgyYbYTs9wOM6jYzlL94go7zBfpuNzh3HpgcRPBoMdr/kJocSAqRIkkwOBI5W1
 lAKXtAMF6SnFkJI/dR+HGKMsPf4EE3i85YCNN29qSTvUhpWPHo9BlTSWDjehi2bywpCUb7
 eKFckjKjx8i3vtK+ZyUSbqwH2ybP6GA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-IqVr2KTjM1G7M5YI3NhS-Q-1; Fri, 20 Dec 2019 08:47:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56901800D5C;
 Fri, 20 Dec 2019 13:47:33 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6687310027AE;
 Fri, 20 Dec 2019 13:47:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/37] serial: realize the serial device
Date: Fri, 20 Dec 2019 17:45:34 +0400
Message-Id: <20191220134601.571905-11-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-1-marcandre.lureau@redhat.com>
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: IqVr2KTjM1G7M5YI3NhS-Q-1
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of calling serial_realize_core(), use the QDev realize
callback.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
index a4f0566865..8328cc62c3 100644
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
@@ -1012,6 +1013,7 @@ static void serial_class_init(ObjectClass *klass, voi=
d* data)
=20
     /* internal device for serialio/serialmm, not user-creatable */
     dc->user_creatable =3D false;
+    dc->realize =3D serial_realize;
     dc->vmsd =3D &vmstate_serial;
     dc->props =3D serial_properties;
 }
@@ -1075,8 +1077,6 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
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
2.24.0.308.g228f53135a


