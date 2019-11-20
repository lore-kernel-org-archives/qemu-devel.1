Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE0FC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8425F218DE
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMAO4LBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8425F218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRvR-0004lo-9V
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRrm-0007lK-U0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRrl-00076O-43
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41416
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRrj-00075o-As
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//PnQGah+l3RqbTb2Qvp9/EzANwNCgBut2jle5Uljlo=;
 b=NMAO4LBnKLok+yweMXPcQoTZ1xWJFWdwh38Gt1oEEI33WAApqYDvOA2Jtn+F+ZmEV/vWOt
 yVmmdUDFyDl3IpjKwmg/82xRUP2oXj14o4IdtLbjh5ByffyTtJSIIQbW3LwtHwUHNnjoea
 vX8KSjHuampM9vZrHDSa45gYnXQD8dc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-hBDq28CtMoO9VKv8uHYu5w-1; Wed, 20 Nov 2019 10:25:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B85F1801FA1;
 Wed, 20 Nov 2019 15:25:56 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D95F551956;
 Wed, 20 Nov 2019 15:25:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/37] serial: initial qom-ification
Date: Wed, 20 Nov 2019 19:24:11 +0400
Message-Id: <20191120152442.26657-7-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: hBDq28CtMoO9VKv8uHYu5w-1
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

Make SerialState a device (the following patches will introduce IO/MM
sysbus serial devices)

None of the serial_{,mm}_init() callers actually free the returned
value (even if they did, it would be quite harmless), so we can change
the object allocation at will.

However, the devices that embed SerialState must now have their field
QOM-initialized manually (isa, pci, pci-multi).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial-isa.c       |  9 +++++++++
 hw/char/serial-pci-multi.c | 15 +++++++++++++++
 hw/char/serial-pci.c       | 13 ++++++++++++-
 hw/char/serial.c           | 33 +++++++++++++++++++++++++++------
 include/hw/char/serial.h   |  7 ++++++-
 5 files changed, 69 insertions(+), 8 deletions(-)

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
index 5c553c30d0..edfbfdca9e 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -181,10 +181,24 @@ static void multi_4x_serial_pci_class_initfn(ObjectCl=
ass *klass, void *data)
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
=20
+static void multi_serial_init(Object *o)
+{
+    PCIDevice *dev =3D PCI_DEVICE(o);
+    PCIMultiSerialState *pms =3D DO_UPCAST(PCIMultiSerialState, dev, dev);
+    size_t i, nports =3D multi_serial_get_port_count(PCI_DEVICE_GET_CLASS(=
dev));
+
+    for (i =3D 0; i < nports; i++) {
+        object_initialize_child(o, "serial[*]", &pms->state[i],
+                                sizeof(pms->state[i]),
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
@@ -196,6 +210,7 @@ static const TypeInfo multi_4x_serial_pci_info =3D {
     .name          =3D "pci-serial-4x",
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIMultiSerialState),
+    .instance_init =3D multi_serial_init,
     .class_init    =3D multi_4x_serial_pci_class_initfn,
     .interfaces =3D (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index cb9b76e22b..f99b6c19e0 100644
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
+    PCISerialState *ps =3D PCI_SERIAL(o);
+
+    object_initialize_child(o, "serial", &ps->state, sizeof(ps->state),
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
index b4aa250950..e0a5bec290 100644
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
+static void serial_class_init(ObjectClass *klass, void *data)
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
@@ -1056,9 +1069,17 @@ SerialState *serial_mm_init(MemoryRegion *address_sp=
ace,
=20
     serial_realize_core(s, &error_fatal);
     vmstate_register(NULL, base, &vmstate_serial, s);
+    qdev_init_nofail(dev);
=20
     memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
                           "serial", 8 << it_shift);
     memory_region_add_subregion(address_space, base, &s->io);
     return s;
 }
+
+static void serial_register_types(void)
+{
+    type_register_static(&serial_info);
+}
+
+type_init(serial_register_types)
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 8be3d8a4f9..180cc7c24e 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -30,10 +30,13 @@
 #include "exec/memory.h"
 #include "qemu/fifo8.h"
 #include "chardev/char.h"
+#include "hw/sysbus.h"
=20
 #define UART_FIFO_LENGTH    16      /* 16550A Fifo Length */
=20
 typedef struct SerialState {
+    DeviceState parent;
+
     uint16_t divider;
     uint8_t rbr; /* receive register */
     uint8_t thr; /* transmit holding register */
@@ -84,7 +87,9 @@ void serial_realize_core(SerialState *s, Error **errp);
 void serial_exit_core(SerialState *s);
 void serial_set_frequency(SerialState *s, uint32_t frequency);
=20
-/* legacy pre qom */
+#define TYPE_SERIAL "serial"
+#define SERIAL(s) OBJECT_CHECK(SerialState, (s), TYPE_SERIAL)
+
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
                          Chardev *chr, MemoryRegion *system_io);
 SerialState *serial_mm_init(MemoryRegion *address_space,
--=20
2.24.0


