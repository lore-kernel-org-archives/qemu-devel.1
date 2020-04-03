Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B58C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E1B206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5noisZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E1B206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHNC-0006gl-2p
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jKHKQ-00019d-5z
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jKHKO-0007z8-KA
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27579
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jKHKO-0007xG-Eh
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585901124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwR1qMIBjIcDZdiTa5Rr4gGe3uQy/EM8NiTlQ6geYmo=;
 b=B5noisZ6rAoZaILSjz2lf2PHVOH9ffNBeqtW16uQEF/Hz8//hi9TAFF0inHUI263QvGDMC
 fujo2Y1sAemTeI0/hE9/BqpOvR8JFCZspahM7U+Go21PvF/jvpjWhLNz48laIqIjkmiXpo
 9TTyM8D3+ZVi6j1PfLAexkeQCszWe08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-ZNMPMIdTMVi0TodkNZxd1A-1; Fri, 03 Apr 2020 04:05:22 -0400
X-MC-Unique: ZNMPMIdTMVi0TodkNZxd1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38FC7107ACC7;
 Fri,  3 Apr 2020 08:05:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5163D5C1D6;
 Fri,  3 Apr 2020 08:05:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 362E717517; Fri,  3 Apr 2020 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/12] acpi: move aml builder code for serial device
Date: Fri,  3 Apr 2020 10:04:58 +0200
Message-Id: <20200403080502.8154-9-kraxel@redhat.com>
In-Reply-To: <20200403080502.8154-1-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code uses the isa_serial_io array to figure what the device uid is.
Side effect is that acpi antries are not limited to port 1+2 any more,
we'll also get entries for ports 3+4.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/char/serial-isa.c | 32 ++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c | 32 --------------------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index f9b6eed7833d..f7c19a398ced 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/char/serial.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
@@ -81,6 +82,35 @@ static void serial_isa_realizefn(DeviceState *dev, Error=
 **errp)
     isa_register_ioport(isadev, &s->io, isa->iobase);
 }
=20
+static void serial_isa_build_aml(ISADevice *isadev, Aml *scope)
+{
+    ISASerialState *isa =3D ISA_SERIAL(isadev);
+    int i, uid =3D 0;
+    Aml *dev;
+    Aml *crs;
+
+    for (i =3D 0; i < ARRAY_SIZE(isa_serial_io); i++) {
+        if (isa->iobase =3D=3D isa_serial_io[i]) {
+            uid =3D i + 1;
+        }
+    }
+    if (!uid) {
+        return;
+    }
+
+    crs =3D aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0=
x08));
+    aml_append(crs, aml_irq_no_flags(isa->isairq));
+
+    dev =3D aml_device("COM%d", uid);
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    aml_append(scope, dev);
+}
+
 static const VMStateDescription vmstate_isa_serial =3D {
     .name =3D "serial",
     .version_id =3D 3,
@@ -103,9 +133,11 @@ static Property serial_isa_properties[] =3D {
 static void serial_isa_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ISADeviceClass *isa =3D ISA_DEVICE_CLASS(klass);
=20
     dc->realize =3D serial_isa_realizefn;
     dc->vmsd =3D &vmstate_isa_serial;
+    isa->build_aml =3D serial_isa_build_aml;
     device_class_set_props(dc, serial_isa_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a5bc7764e611..81805bf85f8d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1189,36 +1189,6 @@ static void build_lpt_device_aml(Aml *scope)
     aml_append(scope, dev);
 }
=20
-static void build_com_device_aml(Aml *scope, uint8_t uid)
-{
-    Aml *dev;
-    Aml *crs;
-    uint8_t irq =3D 4;
-    uint16_t io_port =3D 0x03F8;
-
-    assert(uid =3D=3D 1 || uid =3D=3D 2);
-    if (uid =3D=3D 2) {
-        irq =3D 3;
-        io_port =3D 0x02F8;
-    }
-    if (!memory_region_present(get_system_io(), io_port)) {
-        return;
-    }
-
-    dev =3D aml_device("COM%d", uid);
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
-
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
-
-    crs =3D aml_resource_template();
-    aml_append(crs, aml_io(AML_DECODE16, io_port, io_port, 0x00, 0x08));
-    aml_append(crs, aml_irq_no_flags(irq));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-
-    aml_append(scope, dev);
-}
-
 static void build_isa_devices_aml(Aml *table)
 {
     ISADevice *fdc =3D pc_find_fdc0();
@@ -1233,8 +1203,6 @@ static void build_isa_devices_aml(Aml *table)
         aml_append(scope, build_fdc_device_aml(fdc));
     }
     build_lpt_device_aml(scope);
-    build_com_device_aml(scope, 1);
-    build_com_device_aml(scope, 2);
=20
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data=
");
--=20
2.18.2


