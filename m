Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F57C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D7720658
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXI6L1GR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D7720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEq8i-000377-AK
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEq7Q-0001T4-1j
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEq7O-0004ix-Jg
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23126)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEq7O-0004gt-E2
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584604890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTYhOkELmHFCgie3ThSBryZcp/TC9L9pIbajWLjOzNU=;
 b=GXI6L1GRxmBSWqJLwG6DPBY5C8xZIsm/5Ty6rmwEtyI0gGUCFSjSf/ZGOBz8KqOAXzbqMK
 j2MeRvsBgNWjHEC8q0oKnSqtsTJ6PQNTLiVimyWuHo0Hem0YKVVk61za8gM/6NDicJf4/R
 SypjSLDCy1XEieQ+BaT7dJ71zt7LJn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-GE7tqcOTPsuVSK6D42K-yw-1; Thu, 19 Mar 2020 04:01:28 -0400
X-MC-Unique: GE7tqcOTPsuVSK6D42K-yw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AC65800D54;
 Thu, 19 Mar 2020 08:01:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 665265DA81;
 Thu, 19 Mar 2020 08:01:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B98C731F2D; Thu, 19 Mar 2020 09:01:17 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/13] microvm: add isa-acpi device
Date: Thu, 19 Mar 2020 09:01:07 +0100
Message-Id: <20200319080117.7725-4-kraxel@redhat.com>
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Minimal ACPI device for PCI-less machines like microvm.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/acpi/isa-acpi.c    | 114 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/Makefile.objs |   1 +
 2 files changed, 115 insertions(+)
 create mode 100644 hw/acpi/isa-acpi.c

diff --git a/hw/acpi/isa-acpi.c b/hw/acpi/isa-acpi.c
new file mode 100644
index 000000000000..5d7d770a5c0b
--- /dev/null
+++ b/hw/acpi/isa-acpi.c
@@ -0,0 +1,114 @@
+#include "qemu/osdep.h"
+#include "hw/i386/pc.h"
+#include "hw/acpi/acpi.h"
+#include "sysemu/runstate.h"
+
+typedef struct ISAACPI {
+    ISADevice base;
+
+    uint32_t io_base;
+    uint16_t sci_irq;
+    uint32_t gpe_base;
+    uint32_t gpe_len;
+
+    qemu_irq irq;
+    MemoryRegion io;
+    ACPIREGS acpi;
+    Notifier powerdown_req;
+} ISAACPI;
+
+#define TYPE_ISA_ACPI "isa-acpi"
+#define ISA_ACPI(obj) \
+    OBJECT_CHECK(ISAACPI, (obj), TYPE_ISA_ACPI)
+
+static void isa_acpi_timer(ACPIREGS *acpi)
+{
+    ISAACPI *s =3D container_of(acpi, ISAACPI, acpi);
+    acpi_update_sci(&s->acpi, s->irq);
+}
+
+static void isa_acpi_init(Object *obj)
+{
+    ISAACPI *s =3D ISA_ACPI(obj);
+
+    s->io_base =3D 0x600;
+    s->sci_irq =3D 9;
+    s->gpe_base =3D 0x680;
+    s->gpe_len =3D 4;
+}
+
+static void isa_acpi_powerdown_req(Notifier *n, void *opaque)
+{
+    ISAACPI *s =3D container_of(n, ISAACPI, powerdown_req);
+
+    acpi_pm1_evt_power_down(&s->acpi);
+}
+
+static void isa_acpi_add_propeties(ISAACPI *s)
+{
+    static const uint8_t zero;
+
+    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                  &zero, NULL);
+    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD=
,
+                                  &zero, NULL);
+    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
+                                   &s->gpe_base, NULL);
+    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
+                                   &s->gpe_len, NULL);
+    object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
+                                   &s->sci_irq, NULL);
+    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
+                                   &s->io_base, NULL);
+}
+
+static void isa_acpi_realize(DeviceState *dev, Error **errp)
+{
+    ISADevice *isa =3D ISA_DEVICE(dev);
+    ISAACPI *s =3D ISA_ACPI(dev);
+
+    memory_region_init(&s->io, OBJECT(s), "isa-acpi", 64);
+    memory_region_set_enabled(&s->io, true);
+    isa_register_ioport(isa, &s->io, s->io_base);
+    isa_init_irq(isa, &s->irq, s->sci_irq);
+
+    acpi_pm_tmr_init(&s->acpi, isa_acpi_timer, &s->io);
+    acpi_pm1_evt_init(&s->acpi, isa_acpi_timer, &s->io);
+    acpi_pm1_cnt_init(&s->acpi, &s->io, true, true, 0);
+    acpi_gpe_init(&s->acpi, 4);
+
+    s->powerdown_req.notify =3D isa_acpi_powerdown_req;
+    qemu_register_powerdown_notifier(&s->powerdown_req);
+
+    isa_acpi_add_propeties(s);
+}
+
+static void isa_acpi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_CLASS(klass);
+
+    dc->realize =3D isa_acpi_realize;
+    dc->user_creatable =3D false;
+    dc->hotpluggable =3D false;
+    adevc->madt_cpu =3D pc_madt_cpu_entry;
+}
+
+static const TypeInfo isa_acpi_info =3D {
+    .name          =3D TYPE_ISA_ACPI,
+    .parent        =3D TYPE_ISA_DEVICE,
+    .instance_size =3D sizeof(ISAACPI),
+    .instance_init =3D isa_acpi_init,
+    .class_init    =3D isa_acpi_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_ACPI_DEVICE_IF },
+        { }
+    }
+};
+
+static void register_types(void)
+{
+    type_register_static(&isa_acpi_info);
+}
+
+type_init(register_types)
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 777da07f4d70..aae53c73ebbd 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -14,6 +14,7 @@ common-obj-$(call lnot,$(CONFIG_PC)) +=3D acpi-x86-stub.o
 common-obj-y +=3D acpi_interface.o
 common-obj-y +=3D bios-linker-loader.o
 common-obj-y +=3D aml-build.o utils.o
+common-obj-$(CONFIG_PC) +=3D isa-acpi.o
 common-obj-$(CONFIG_ACPI_PCI) +=3D pci.o
 common-obj-$(CONFIG_TPM) +=3D tpm.o
=20
--=20
2.18.2


