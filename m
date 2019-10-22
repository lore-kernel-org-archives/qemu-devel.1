Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE6ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86102084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP+z5tmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86102084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwyj-0001PP-A9
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwvR-0006LL-Lg
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwvQ-00078k-3M
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iMwvP-00077r-Vc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571761343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mgsj8+CDEmUtcCk6ZB7/g3txdrtRS5NSu37PSAn5pI=;
 b=bP+z5tmxH96hAvHwnXdWn5KnLnIHHO4HQDsPS3zxTHSWBT1F/lwBj/tfYPYgIyqmMjyvrD
 CQ7/DWzZF9FtISDjZ/lX5U/qTxaLZGzFIWit2NOaG78Tn6WZWidfFTTCC+FoXN/y4c1Mvy
 O19gta6f23owdOjdyf1qEYXXsJIiTC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-bbHMbeAMPsucT0q6YVl-KA-1; Tue, 22 Oct 2019 12:22:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30343107AD31;
 Tue, 22 Oct 2019 16:22:19 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5E7C5E7B2;
 Tue, 22 Oct 2019 16:22:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/28] serial: initial qom-ification
Date: Tue, 22 Oct 2019 18:21:12 +0200
Message-Id: <20191022162137.27161-4-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-1-marcandre.lureau@redhat.com>
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: bbHMbeAMPsucT0q6YVl-KA-1
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

Make SerialState a non-bus device (not instantiable with qdev_create).

None of the serial_{,mm}_init() callers actually free the returned
value (even if they did, it would be quite harmless), so we can change
the object allocation at will.

However, the devices that embed SerialState must now have their field
QOM-initialized manually (isa, pci, pci-multi).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial-isa.c       |  9 +++++++++
 hw/char/serial-pci-multi.c | 15 ++++++++++++++
 hw/char/serial-pci.c       | 13 ++++++++++++-
 hw/char/serial.c           | 40 ++++++++++++++++++++++++++++++++------
 include/hw/char/serial.h   | 10 +++++++++-
 5 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 9e31c51bb6..9a5928b3ee 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -111,10 +111,19 @@ static void serial_isa_class_initfn(ObjectClass *klas=
s, void *data)
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
=20
+static void serial_isa_initfn(Object *o)
+{
+    ISASerialState *self =3D ISA_SERIAL(o);
+
+    object_initialize_child(o, "serial", &self->state, sizeof(self->state)=
,
+                            TYPE_SERIAL, &error_abort, NULL);
+}
+
 static const TypeInfo serial_isa_info =3D {
     .name          =3D TYPE_ISA_SERIAL,
     .parent        =3D TYPE_ISA_DEVICE,
     .instance_size =3D sizeof(ISASerialState),
+    .instance_init =3D serial_isa_initfn,
     .class_init    =3D serial_isa_class_initfn,
 };
=20
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 6fa1cc6225..3485bdad87 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -182,10 +182,24 @@ static void multi_4x_serial_pci_class_initfn(ObjectCl=
ass *klass, void *data)
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
=20
+static void multi_serial_init(Object *o)
+{
+    PCIDevice *dev =3D PCI_DEVICE(o);
+    PCIMultiSerialState *self =3D DO_UPCAST(PCIMultiSerialState, dev, dev)=
;
+    int i, nr_ports =3D multi_serial_get_nr_ports(PCI_DEVICE_GET_CLASS(dev=
));
+
+    for (i =3D 0; i < nr_ports; i++) {
+        object_initialize_child(o, "serial[*]", &self->state[i],
+                                sizeof(self->state[i]),
+                                TYPE_SERIAL, &error_abort, NULL);
+    }
+}
+
 static const TypeInfo multi_2x_serial_pci_info =3D {
     .name          =3D "pci-serial-2x",
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIMultiSerialState),
+    .instance_init =3D multi_serial_init,
     .class_init    =3D multi_2x_serial_pci_class_initfn,
     .interfaces =3D (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -197,6 +211,7 @@ static const TypeInfo multi_4x_serial_pci_info =3D {
     .name          =3D "pci-serial-4x",
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIMultiSerialState),
+    .instance_init =3D multi_serial_init,
     .class_init    =3D multi_4x_serial_pci_class_initfn,
     .interfaces =3D (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index cb9b76e22b..a33264a1fb 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -40,6 +40,8 @@ typedef struct PCISerialState {
     uint8_t prog_if;
 } PCISerialState;
=20
+#define TYPE_PCI_SERIAL "pci-serial"
+#define PCI_SERIAL(s) OBJECT_CHECK(PCISerialState, (s), TYPE_PCI_SERIAL)
=20
 static void serial_pci_realize(PCIDevice *dev, Error **errp)
 {
@@ -103,10 +105,19 @@ static void serial_pci_class_initfn(ObjectClass *klas=
s, void *data)
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
=20
+static void serial_pci_init(Object *o)
+{
+    PCISerialState *self =3D PCI_SERIAL(o);
+
+    object_initialize_child(o, "serial", &self->state, sizeof(self->state)=
,
+                            TYPE_SERIAL, &error_abort, NULL);
+}
+
 static const TypeInfo serial_pci_info =3D {
-    .name          =3D "pci-serial",
+    .name          =3D TYPE_PCI_SERIAL,
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCISerialState),
+    .instance_init =3D serial_pci_init,
     .class_init    =3D serial_pci_class_initfn,
     .interfaces =3D (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/char/serial.c b/hw/char/serial.c
index b4aa250950..fb0dd98103 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -983,9 +983,8 @@ const MemoryRegionOps serial_io_ops =3D {
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
                          Chardev *chr, MemoryRegion *system_io)
 {
-    SerialState *s;
-
-    s =3D g_malloc0(sizeof(SerialState));
+    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
+    SerialState *s =3D SERIAL(dev);
=20
     s->irq =3D irq;
     s->baudbase =3D baudbase;
@@ -993,6 +992,7 @@ SerialState *serial_init(int base, qemu_irq irq, int ba=
udbase,
     serial_realize_core(s, &error_fatal);
=20
     vmstate_register(NULL, base, &vmstate_serial, s);
+    qdev_init_nofail(dev);
=20
     memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
     memory_region_add_subregion(system_io, base, &s->io);
@@ -1000,6 +1000,20 @@ SerialState *serial_init(int base, qemu_irq irq, int=
 baudbase,
     return s;
 }
=20
+static void serial_class_init(ObjectClass *klass, void* data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->user_creatable =3D false;
+}
+
+static const TypeInfo serial_info =3D {
+    .name =3D TYPE_SERIAL,
+    .parent =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(SerialState),
+    .class_init =3D serial_class_init,
+};
+
 /* Memory mapped interface */
 static uint64_t serial_mm_read(void *opaque, hwaddr addr,
                                unsigned size)
@@ -1045,9 +1059,8 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
                             qemu_irq irq, int baudbase,
                             Chardev *chr, enum device_endian end)
 {
-    SerialState *s;
-
-    s =3D g_malloc0(sizeof(SerialState));
+    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
+    SerialState *s =3D SERIAL(dev);
=20
     s->it_shift =3D it_shift;
     s->irq =3D irq;
@@ -1056,9 +1069,24 @@ SerialState *serial_mm_init(MemoryRegion *address_sp=
ace,
=20
     serial_realize_core(s, &error_fatal);
     vmstate_register(NULL, base, &vmstate_serial, s);
+    qdev_init_nofail(dev);
=20
     memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
                           "serial", 8 << it_shift);
     memory_region_add_subregion(address_space, base, &s->io);
+
     return s;
 }
+
+static const TypeInfo serial_mm_info =3D {
+    .name =3D TYPE_SERIAL_MM,
+    .parent =3D TYPE_SERIAL,
+};
+
+static void serial_register_types(void)
+{
+    type_register_static(&serial_info);
+    type_register_static(&serial_mm_info);
+}
+
+type_init(serial_register_types)
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 8be3d8a4f9..2b8dbd88f1 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -30,10 +30,13 @@
 #include "exec/memory.h"
 #include "qemu/fifo8.h"
 #include "chardev/char.h"
+#include "hw/qdev-core.h"
=20
 #define UART_FIFO_LENGTH    16      /* 16550A Fifo Length */
=20
 typedef struct SerialState {
+    DeviceState parent;
+
     uint16_t divider;
     uint8_t rbr; /* receive register */
     uint8_t thr; /* transmit holding register */
@@ -84,7 +87,12 @@ void serial_realize_core(SerialState *s, Error **errp);
 void serial_exit_core(SerialState *s);
 void serial_set_frequency(SerialState *s, uint32_t frequency);
=20
-/* legacy pre qom */
+#define TYPE_SERIAL "serial"
+#define SERIAL(s) OBJECT_CHECK(SerialState, (s), TYPE_SERIAL)
+
+#define TYPE_SERIAL_MM "serial-mm"
+#define SERIAL_MM(s) OBJECT_CHECK(SerialState, (s), TYPE_SERIAL_MM)
+
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
                          Chardev *chr, MemoryRegion *system_io);
 SerialState *serial_mm_init(MemoryRegion *address_space,
--=20
2.23.0.606.g08da6496b6


