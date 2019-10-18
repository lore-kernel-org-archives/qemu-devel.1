Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD38FCA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4ED021925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ED021925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSrk-00046Z-6e
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSfA-0006w9-TB
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSf7-00072Z-9W
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSf6-00071a-Pi
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:51:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24C753090FEE;
 Fri, 18 Oct 2019 13:51:23 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 434FB60BF1;
 Fri, 18 Oct 2019 13:51:11 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/20] hw/pci-host/piix: Extract PIIX3 functions to
 hw/isa/piix3.c
Date: Fri, 18 Oct 2019 15:47:52 +0200
Message-Id: <20191018134754.16362-19-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-1-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 18 Oct 2019 13:51:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Move all the PIIX3 functions to a new file: hw/isa/piix3.c.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Checkpatch warning:

 ERROR: spaces required around that '*' (ctx:VxV)
 #312: FILE: hw/isa/piix3.c:248:
 +    .subsections =3D (const VMStateDescription*[]) {
                                              ^
---
 MAINTAINERS                   |   1 +
 hw/i386/Kconfig               |   1 +
 hw/isa/Kconfig                |   4 +
 hw/isa/Makefile.objs          |   1 +
 hw/isa/piix3.c                | 399 +++++++++++++++++++++++++++++++++
 hw/pci-host/Kconfig           |   1 -
 hw/pci-host/piix.c            | 402 ----------------------------------
 include/hw/southbridge/piix.h |  36 +++
 8 files changed, 442 insertions(+), 403 deletions(-)
 create mode 100644 hw/isa/piix3.c

diff --git a/MAINTAINERS b/MAINTAINERS
index adf059a164..4845f47d93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1231,6 +1231,7 @@ F: hw/pci-host/pam.c
 F: include/hw/pci-host/i440fx.h
 F: include/hw/pci-host/q35.h
 F: include/hw/pci-host/pam.h
+F: hw/isa/piix3.c
 F: hw/isa/lpc_ich9.c
 F: hw/i2c/smbus_ich9.c
 F: hw/acpi/piix4.c
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index c5c9d4900e..589d75e26a 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -61,6 +61,7 @@ config I440FX
     select PC_ACPI
     select ACPI_SMBUS
     select PCI_PIIX
+    select PIIX3
     select IDE_PIIX
     select DIMM
     select SMBIOS
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 98a289957e..8a38813cc1 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -29,6 +29,10 @@ config PC87312
     select FDC
     select IDE_ISA
=20
+config PIIX3
+    bool
+    select ISA_BUS
+
 config PIIX4
     bool
     # For historical reasons, SuperIO devices are created in the board
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index ff97485504..8e73960a75 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -3,6 +3,7 @@ common-obj-$(CONFIG_ISA_SUPERIO) +=3D isa-superio.o
 common-obj-$(CONFIG_APM) +=3D apm.o
 common-obj-$(CONFIG_I82378) +=3D i82378.o
 common-obj-$(CONFIG_PC87312) +=3D pc87312.o
+common-obj-$(CONFIG_PIIX3) +=3D piix3.o
 common-obj-$(CONFIG_PIIX4) +=3D piix4.o
 common-obj-$(CONFIG_VT82C686) +=3D vt82c686.o
 common-obj-$(CONFIG_SMC37C669) +=3D smc37c669-superio.o
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
new file mode 100644
index 0000000000..fd1c78879f
--- /dev/null
+++ b/hw/isa/piix3.c
@@ -0,0 +1,399 @@
+/*
+ * QEMU PIIX PCI ISA Bridge Emulation
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/range.h"
+#include "hw/southbridge/piix.h"
+#include "hw/irq.h"
+#include "hw/isa/isa.h"
+#include "hw/xen/xen.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/reset.h"
+#include "sysemu/runstate.h"
+#include "migration/vmstate.h"
+
+#define XEN_PIIX_NUM_PIRQS      128ULL
+
+#define TYPE_PIIX3_PCI_DEVICE "pci-piix3"
+#define PIIX3_PCI_DEVICE(obj) \
+    OBJECT_CHECK(PIIX3State, (obj), TYPE_PIIX3_PCI_DEVICE)
+
+#define TYPE_PIIX3_DEVICE "PIIX3"
+#define TYPE_PIIX3_XEN_DEVICE "PIIX3-xen"
+
+static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
+{
+    qemu_set_irq(piix3->pic[pic_irq],
+                 !!(piix3->pic_levels &
+                    (((1ULL << PIIX_NUM_PIRQS) - 1) <<
+                     (pic_irq * PIIX_NUM_PIRQS))));
+}
+
+static void piix3_set_irq_level_internal(PIIX3State *piix3, int pirq, in=
t level)
+{
+    int pic_irq;
+    uint64_t mask;
+
+    pic_irq =3D piix3->dev.config[PIIX_PIRQCA + pirq];
+    if (pic_irq >=3D PIIX_NUM_PIC_IRQS) {
+        return;
+    }
+
+    mask =3D 1ULL << ((pic_irq * PIIX_NUM_PIRQS) + pirq);
+    piix3->pic_levels &=3D ~mask;
+    piix3->pic_levels |=3D mask * !!level;
+}
+
+static void piix3_set_irq_level(PIIX3State *piix3, int pirq, int level)
+{
+    int pic_irq;
+
+    pic_irq =3D piix3->dev.config[PIIX_PIRQCA + pirq];
+    if (pic_irq >=3D PIIX_NUM_PIC_IRQS) {
+        return;
+    }
+
+    piix3_set_irq_level_internal(piix3, pirq, level);
+
+    piix3_set_irq_pic(piix3, pic_irq);
+}
+
+static void piix3_set_irq(void *opaque, int pirq, int level)
+{
+    PIIX3State *piix3 =3D opaque;
+    piix3_set_irq_level(piix3, pirq, level);
+}
+
+static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
+{
+    PIIX3State *piix3 =3D opaque;
+    int irq =3D piix3->dev.config[PIIX_PIRQCA + pin];
+    PCIINTxRoute route;
+
+    if (irq < PIIX_NUM_PIC_IRQS) {
+        route.mode =3D PCI_INTX_ENABLED;
+        route.irq =3D irq;
+    } else {
+        route.mode =3D PCI_INTX_DISABLED;
+        route.irq =3D -1;
+    }
+    return route;
+}
+
+/* irq routing is changed. so rebuild bitmap */
+static void piix3_update_irq_levels(PIIX3State *piix3)
+{
+    PCIBus *bus =3D pci_get_bus(&piix3->dev);
+    int pirq;
+
+    piix3->pic_levels =3D 0;
+    for (pirq =3D 0; pirq < PIIX_NUM_PIRQS; pirq++) {
+        piix3_set_irq_level(piix3, pirq, pci_bus_get_irq_level(bus, pirq=
));
+    }
+}
+
+static void piix3_write_config(PCIDevice *dev,
+                               uint32_t address, uint32_t val, int len)
+{
+    pci_default_write_config(dev, address, val, len);
+    if (ranges_overlap(address, len, PIIX_PIRQCA, 4)) {
+        PIIX3State *piix3 =3D PIIX3_PCI_DEVICE(dev);
+        int pic_irq;
+
+        pci_bus_fire_intx_routing_notifier(pci_get_bus(&piix3->dev));
+        piix3_update_irq_levels(piix3);
+        for (pic_irq =3D 0; pic_irq < PIIX_NUM_PIC_IRQS; pic_irq++) {
+            piix3_set_irq_pic(piix3, pic_irq);
+        }
+    }
+}
+
+static void piix3_write_config_xen(PCIDevice *dev,
+                                   uint32_t address, uint32_t val, int l=
en)
+{
+    xen_piix_pci_write_config_client(address, val, len);
+    piix3_write_config(dev, address, val, len);
+}
+
+static void piix3_reset(void *opaque)
+{
+    PIIX3State *d =3D opaque;
+    uint8_t *pci_conf =3D d->dev.config;
+
+    pci_conf[0x04] =3D 0x07; /* master, memory and I/O */
+    pci_conf[0x05] =3D 0x00;
+    pci_conf[0x06] =3D 0x00;
+    pci_conf[0x07] =3D 0x02; /* PCI_status_devsel_medium */
+    pci_conf[0x4c] =3D 0x4d;
+    pci_conf[0x4e] =3D 0x03;
+    pci_conf[0x4f] =3D 0x00;
+    pci_conf[0x60] =3D 0x80;
+    pci_conf[0x61] =3D 0x80;
+    pci_conf[0x62] =3D 0x80;
+    pci_conf[0x63] =3D 0x80;
+    pci_conf[0x69] =3D 0x02;
+    pci_conf[0x70] =3D 0x80;
+    pci_conf[0x76] =3D 0x0c;
+    pci_conf[0x77] =3D 0x0c;
+    pci_conf[0x78] =3D 0x02;
+    pci_conf[0x79] =3D 0x00;
+    pci_conf[0x80] =3D 0x00;
+    pci_conf[0x82] =3D 0x00;
+    pci_conf[0xa0] =3D 0x08;
+    pci_conf[0xa2] =3D 0x00;
+    pci_conf[0xa3] =3D 0x00;
+    pci_conf[0xa4] =3D 0x00;
+    pci_conf[0xa5] =3D 0x00;
+    pci_conf[0xa6] =3D 0x00;
+    pci_conf[0xa7] =3D 0x00;
+    pci_conf[0xa8] =3D 0x0f;
+    pci_conf[0xaa] =3D 0x00;
+    pci_conf[0xab] =3D 0x00;
+    pci_conf[0xac] =3D 0x00;
+    pci_conf[0xae] =3D 0x00;
+
+    d->pic_levels =3D 0;
+    d->rcr =3D 0;
+}
+
+static int piix3_post_load(void *opaque, int version_id)
+{
+    PIIX3State *piix3 =3D opaque;
+    int pirq;
+
+    /*
+     * Because the i8259 has not been deserialized yet, qemu_irq_raise
+     * might bring the system to a different state than the saved one;
+     * for example, the interrupt could be masked but the i8259 would
+     * not know that yet and would trigger an interrupt in the CPU.
+     *
+     * Here, we update irq levels without raising the interrupt.
+     * Interrupt state will be deserialized separately through the i8259=
.
+     */
+    piix3->pic_levels =3D 0;
+    for (pirq =3D 0; pirq < PIIX_NUM_PIRQS; pirq++) {
+        piix3_set_irq_level_internal(piix3, pirq,
+            pci_bus_get_irq_level(pci_get_bus(&piix3->dev), pirq));
+    }
+    return 0;
+}
+
+static int piix3_pre_save(void *opaque)
+{
+    int i;
+    PIIX3State *piix3 =3D opaque;
+
+    for (i =3D 0; i < ARRAY_SIZE(piix3->pci_irq_levels_vmstate); i++) {
+        piix3->pci_irq_levels_vmstate[i] =3D
+            pci_bus_get_irq_level(pci_get_bus(&piix3->dev), i);
+    }
+
+    return 0;
+}
+
+static bool piix3_rcr_needed(void *opaque)
+{
+    PIIX3State *piix3 =3D opaque;
+
+    return (piix3->rcr !=3D 0);
+}
+
+static const VMStateDescription vmstate_piix3_rcr =3D {
+    .name =3D "PIIX3/rcr",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D piix3_rcr_needed,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT8(rcr, PIIX3State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_piix3 =3D {
+    .name =3D "PIIX3",
+    .version_id =3D 3,
+    .minimum_version_id =3D 2,
+    .post_load =3D piix3_post_load,
+    .pre_save =3D piix3_pre_save,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, PIIX3State),
+        VMSTATE_INT32_ARRAY_V(pci_irq_levels_vmstate, PIIX3State,
+                              PIIX_NUM_PIRQS, 3),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections =3D (const VMStateDescription*[]) {
+        &vmstate_piix3_rcr,
+        NULL
+    }
+};
+
+
+static void rcr_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
len)
+{
+    PIIX3State *d =3D opaque;
+
+    if (val & 4) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        return;
+    }
+    d->rcr =3D val & 2; /* keep System Reset type only */
+}
+
+static uint64_t rcr_read(void *opaque, hwaddr addr, unsigned len)
+{
+    PIIX3State *d =3D opaque;
+
+    return d->rcr;
+}
+
+static const MemoryRegionOps rcr_ops =3D {
+    .read =3D rcr_read,
+    .write =3D rcr_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN
+};
+
+static void piix3_realize(PCIDevice *dev, Error **errp)
+{
+    PIIX3State *d =3D PIIX3_PCI_DEVICE(dev);
+
+    if (!isa_bus_new(DEVICE(d), get_system_memory(),
+                     pci_address_space_io(dev), errp)) {
+        return;
+    }
+
+    memory_region_init_io(&d->rcr_mem, OBJECT(dev), &rcr_ops, d,
+                          "piix3-reset-control", 1);
+    memory_region_add_subregion_overlap(pci_address_space_io(dev),
+                                        PIIX_RCR_IOPORT, &d->rcr_mem, 1)=
;
+
+    qemu_register_reset(piix3_reset, d);
+}
+
+static void pci_piix3_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    dc->desc        =3D "ISA bridge";
+    dc->vmsd        =3D &vmstate_piix3;
+    dc->hotpluggable   =3D false;
+    k->realize      =3D piix3_realize;
+    k->vendor_id    =3D PCI_VENDOR_ID_INTEL;
+    /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
+    k->device_id    =3D PCI_DEVICE_ID_INTEL_82371SB_0;
+    k->class_id     =3D PCI_CLASS_BRIDGE_ISA;
+    /*
+     * Reason: part of PIIX3 southbridge, needs to be wired up by
+     * pc_piix.c's pc_init1()
+     */
+    dc->user_creatable =3D false;
+}
+
+static const TypeInfo piix3_pci_type_info =3D {
+    .name =3D TYPE_PIIX3_PCI_DEVICE,
+    .parent =3D TYPE_PCI_DEVICE,
+    .instance_size =3D sizeof(PIIX3State),
+    .abstract =3D true,
+    .class_init =3D pci_piix3_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void piix3_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->config_write =3D piix3_write_config;
+}
+
+static const TypeInfo piix3_info =3D {
+    .name          =3D TYPE_PIIX3_DEVICE,
+    .parent        =3D TYPE_PIIX3_PCI_DEVICE,
+    .class_init    =3D piix3_class_init,
+};
+
+static void piix3_xen_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+
+    k->config_write =3D piix3_write_config_xen;
+};
+
+static const TypeInfo piix3_xen_info =3D {
+    .name          =3D TYPE_PIIX3_XEN_DEVICE,
+    .parent        =3D TYPE_PIIX3_PCI_DEVICE,
+    .class_init    =3D piix3_xen_class_init,
+};
+
+static void piix3_register_types(void)
+{
+    type_register_static(&piix3_pci_type_info);
+    type_register_static(&piix3_info);
+    type_register_static(&piix3_xen_info);
+}
+
+type_init(piix3_register_types)
+
+/*
+ * Return the global irq number corresponding to a given device irq
+ * pin. We could also use the bus number to have a more precise mapping.
+ */
+static int pci_slot_get_pirq(PCIDevice *pci_dev, int pci_intx)
+{
+    int slot_addend;
+    slot_addend =3D (pci_dev->devfn >> 3) - 1;
+    return (pci_intx + slot_addend) & 3;
+}
+
+PIIX3State *piix3_create(PCIBus *pci_bus, ISABus **isa_bus)
+{
+    PIIX3State *piix3;
+    PCIDevice *pci_dev;
+
+    /*
+     * Xen supports additional interrupt routes from the PCI devices to
+     * the IOAPIC: the four pins of each PCI device on the bus are also
+     * connected to the IOAPIC directly.
+     * These additional routes can be discovered through ACPI.
+     */
+    if (xen_enabled()) {
+        pci_dev =3D pci_create_simple_multifunction(pci_bus, -1, true,
+                                                  TYPE_PIIX3_XEN_DEVICE)=
;
+        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
+        pci_bus_irqs(pci_bus, xen_piix3_set_irq, xen_pci_slot_get_pirq,
+                     piix3, XEN_PIIX_NUM_PIRQS);
+    } else {
+        pci_dev =3D pci_create_simple_multifunction(pci_bus, -1, true,
+                                                  TYPE_PIIX3_DEVICE);
+        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
+        pci_bus_irqs(pci_bus, piix3_set_irq, pci_slot_get_pirq,
+                     piix3, PIIX_NUM_PIRQS);
+        pci_bus_set_route_irq_fn(pci_bus, piix3_route_intx_pin_to_irq);
+    }
+    *isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
+
+    return piix3;
+}
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 1edc1a31d4..397043b289 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -32,7 +32,6 @@ config PCI_PIIX
     bool
     select PCI
     select PAM
-    select ISA_BUS
=20
 config PCI_EXPRESS_Q35
     bool
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 1544c4726b..79ecd58a2b 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -24,22 +24,15 @@
=20
 #include "qemu/osdep.h"
 #include "hw/i386/pc.h"
-#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci-host/i440fx.h"
 #include "hw/southbridge/piix.h"
 #include "hw/qdev-properties.h"
-#include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
-#include "qemu/range.h"
-#include "hw/xen/xen.h"
 #include "migration/vmstate.h"
 #include "hw/pci-host/pam.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "hw/i386/ioapic.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
=20
@@ -59,49 +52,9 @@ typedef struct I440FXState {
     uint32_t short_root_bus;
 } I440FXState;
=20
-#define PIIX_NUM_PIC_IRQS       16      /* i8259 * 2 */
-#define PIIX_NUM_PIRQS          4ULL    /* PIRQ[A-D] */
-#define XEN_PIIX_NUM_PIRQS      128ULL
-
-typedef struct PIIX3State {
-    PCIDevice dev;
-
-    /*
-     * bitmap to track pic levels.
-     * The pic level is the logical OR of all the PCI irqs mapped to it
-     * So one PIC level is tracked by PIIX_NUM_PIRQS bits.
-     *
-     * PIRQ is mapped to PIC pins, we track it by
-     * PIIX_NUM_PIRQS * PIIX_NUM_PIC_IRQS =3D 64 bits with
-     * pic_irq * PIIX_NUM_PIRQS + pirq
-     */
-#if PIIX_NUM_PIC_IRQS * PIIX_NUM_PIRQS > 64
-#error "unable to encode pic state in 64bit in pic_levels."
-#endif
-    uint64_t pic_levels;
-
-    qemu_irq *pic;
-
-    /* This member isn't used. Just for save/load compatibility */
-    int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
-
-    /* Reset Control Register contents */
-    uint8_t rcr;
-
-    /* IO memory region for Reset Control Register (PIIX_RCR_IOPORT) */
-    MemoryRegion rcr_mem;
-} PIIX3State;
-
-#define TYPE_PIIX3_PCI_DEVICE "pci-piix3"
-#define PIIX3_PCI_DEVICE(obj) \
-    OBJECT_CHECK(PIIX3State, (obj), TYPE_PIIX3_PCI_DEVICE)
-
 #define I440FX_PCI_DEVICE(obj) \
     OBJECT_CHECK(PCII440FXState, (obj), TYPE_I440FX_PCI_DEVICE)
=20
-#define TYPE_PIIX3_DEVICE "PIIX3"
-#define TYPE_PIIX3_XEN_DEVICE "PIIX3-xen"
-
 struct PCII440FXState {
     /*< private >*/
     PCIDevice parent_obj;
@@ -128,22 +81,6 @@ struct PCII440FXState {
  */
 #define I440FX_COREBOOT_RAM_SIZE 0x57
=20
-static void piix3_set_irq(void *opaque, int pirq, int level);
-static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pci_in=
tx);
-static void piix3_write_config_xen(PCIDevice *dev,
-                               uint32_t address, uint32_t val, int len);
-
-/*
- * Return the global irq number corresponding to a given device irq
- * pin. We could also use the bus number to have a more precise mapping.
- */
-static int pci_slot_get_pirq(PCIDevice *pci_dev, int pci_intx)
-{
-    int slot_addend;
-    slot_addend =3D (pci_dev->devfn >> 3) - 1;
-    return (pci_intx + slot_addend) & 3;
-}
-
 static void i440fx_update_memory_mappings(PCII440FXState *d)
 {
     int i;
@@ -333,36 +270,6 @@ static void i440fx_realize(PCIDevice *dev, Error **e=
rrp)
     }
 }
=20
-static PIIX3State *piix3_create(PCIBus *pci_bus, ISABus **isa_bus)
-{
-    PIIX3State *piix3;
-    PCIDevice *pci_dev;
-
-    /*
-     * Xen supports additional interrupt routes from the PCI devices to
-     * the IOAPIC: the four pins of each PCI device on the bus are also
-     * connected to the IOAPIC directly.
-     * These additional routes can be discovered through ACPI.
-     */
-    if (xen_enabled()) {
-        pci_dev =3D pci_create_simple_multifunction(pci_bus, -1, true,
-                                                  TYPE_PIIX3_XEN_DEVICE)=
;
-        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
-        pci_bus_irqs(pci_bus, xen_piix3_set_irq, xen_pci_slot_get_pirq,
-                     piix3, XEN_PIIX_NUM_PIRQS);
-    } else {
-        pci_dev =3D pci_create_simple_multifunction(pci_bus, -1, true,
-                                                  TYPE_PIIX3_DEVICE);
-        piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
-        pci_bus_irqs(pci_bus, piix3_set_irq, pci_slot_get_pirq,
-                     piix3, PIIX_NUM_PIRQS);
-        pci_bus_set_route_irq_fn(pci_bus, piix3_route_intx_pin_to_irq);
-    }
-    *isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
-
-    return piix3;
-}
-
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     PCII440FXState **pi440fx_state,
                     int *piix3_devfn,
@@ -455,312 +362,6 @@ PCIBus *find_i440fx(void)
     return s ? s->bus : NULL;
 }
=20
-/* PIIX3 PCI to ISA bridge */
-static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
-{
-    qemu_set_irq(piix3->pic[pic_irq],
-                 !!(piix3->pic_levels &
-                    (((1ULL << PIIX_NUM_PIRQS) - 1) <<
-                     (pic_irq * PIIX_NUM_PIRQS))));
-}
-
-static void piix3_set_irq_level_internal(PIIX3State *piix3, int pirq, in=
t level)
-{
-    int pic_irq;
-    uint64_t mask;
-
-    pic_irq =3D piix3->dev.config[PIIX_PIRQCA + pirq];
-    if (pic_irq >=3D PIIX_NUM_PIC_IRQS) {
-        return;
-    }
-
-    mask =3D 1ULL << ((pic_irq * PIIX_NUM_PIRQS) + pirq);
-    piix3->pic_levels &=3D ~mask;
-    piix3->pic_levels |=3D mask * !!level;
-}
-
-static void piix3_set_irq_level(PIIX3State *piix3, int pirq, int level)
-{
-    int pic_irq;
-
-    pic_irq =3D piix3->dev.config[PIIX_PIRQCA + pirq];
-    if (pic_irq >=3D PIIX_NUM_PIC_IRQS) {
-        return;
-    }
-
-    piix3_set_irq_level_internal(piix3, pirq, level);
-
-    piix3_set_irq_pic(piix3, pic_irq);
-}
-
-static void piix3_set_irq(void *opaque, int pirq, int level)
-{
-    PIIX3State *piix3 =3D opaque;
-    piix3_set_irq_level(piix3, pirq, level);
-}
-
-static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
-{
-    PIIX3State *piix3 =3D opaque;
-    int irq =3D piix3->dev.config[PIIX_PIRQCA + pin];
-    PCIINTxRoute route;
-
-    if (irq < PIIX_NUM_PIC_IRQS) {
-        route.mode =3D PCI_INTX_ENABLED;
-        route.irq =3D irq;
-    } else {
-        route.mode =3D PCI_INTX_DISABLED;
-        route.irq =3D -1;
-    }
-    return route;
-}
-
-/* irq routing is changed. so rebuild bitmap */
-static void piix3_update_irq_levels(PIIX3State *piix3)
-{
-    PCIBus *bus =3D pci_get_bus(&piix3->dev);
-    int pirq;
-
-    piix3->pic_levels =3D 0;
-    for (pirq =3D 0; pirq < PIIX_NUM_PIRQS; pirq++) {
-        piix3_set_irq_level(piix3, pirq, pci_bus_get_irq_level(bus, pirq=
));
-    }
-}
-
-static void piix3_write_config(PCIDevice *dev,
-                               uint32_t address, uint32_t val, int len)
-{
-    pci_default_write_config(dev, address, val, len);
-    if (ranges_overlap(address, len, PIIX_PIRQCA, 4)) {
-        PIIX3State *piix3 =3D PIIX3_PCI_DEVICE(dev);
-        int pic_irq;
-
-        pci_bus_fire_intx_routing_notifier(pci_get_bus(&piix3->dev));
-        piix3_update_irq_levels(piix3);
-        for (pic_irq =3D 0; pic_irq < PIIX_NUM_PIC_IRQS; pic_irq++) {
-            piix3_set_irq_pic(piix3, pic_irq);
-        }
-    }
-}
-
-static void piix3_write_config_xen(PCIDevice *dev,
-                               uint32_t address, uint32_t val, int len)
-{
-    xen_piix_pci_write_config_client(address, val, len);
-    piix3_write_config(dev, address, val, len);
-}
-
-static void piix3_reset(void *opaque)
-{
-    PIIX3State *d =3D opaque;
-    uint8_t *pci_conf =3D d->dev.config;
-
-    pci_conf[0x04] =3D 0x07; /* master, memory and I/O */
-    pci_conf[0x05] =3D 0x00;
-    pci_conf[0x06] =3D 0x00;
-    pci_conf[0x07] =3D 0x02; /* PCI_status_devsel_medium */
-    pci_conf[0x4c] =3D 0x4d;
-    pci_conf[0x4e] =3D 0x03;
-    pci_conf[0x4f] =3D 0x00;
-    pci_conf[0x60] =3D 0x80;
-    pci_conf[0x61] =3D 0x80;
-    pci_conf[0x62] =3D 0x80;
-    pci_conf[0x63] =3D 0x80;
-    pci_conf[0x69] =3D 0x02;
-    pci_conf[0x70] =3D 0x80;
-    pci_conf[0x76] =3D 0x0c;
-    pci_conf[0x77] =3D 0x0c;
-    pci_conf[0x78] =3D 0x02;
-    pci_conf[0x79] =3D 0x00;
-    pci_conf[0x80] =3D 0x00;
-    pci_conf[0x82] =3D 0x00;
-    pci_conf[0xa0] =3D 0x08;
-    pci_conf[0xa2] =3D 0x00;
-    pci_conf[0xa3] =3D 0x00;
-    pci_conf[0xa4] =3D 0x00;
-    pci_conf[0xa5] =3D 0x00;
-    pci_conf[0xa6] =3D 0x00;
-    pci_conf[0xa7] =3D 0x00;
-    pci_conf[0xa8] =3D 0x0f;
-    pci_conf[0xaa] =3D 0x00;
-    pci_conf[0xab] =3D 0x00;
-    pci_conf[0xac] =3D 0x00;
-    pci_conf[0xae] =3D 0x00;
-
-    d->pic_levels =3D 0;
-    d->rcr =3D 0;
-}
-
-static int piix3_post_load(void *opaque, int version_id)
-{
-    PIIX3State *piix3 =3D opaque;
-    int pirq;
-
-    /* Because the i8259 has not been deserialized yet, qemu_irq_raise
-     * might bring the system to a different state than the saved one;
-     * for example, the interrupt could be masked but the i8259 would
-     * not know that yet and would trigger an interrupt in the CPU.
-     *
-     * Here, we update irq levels without raising the interrupt.
-     * Interrupt state will be deserialized separately through the i8259=
.
-     */
-    piix3->pic_levels =3D 0;
-    for (pirq =3D 0; pirq < PIIX_NUM_PIRQS; pirq++) {
-        piix3_set_irq_level_internal(piix3, pirq,
-            pci_bus_get_irq_level(pci_get_bus(&piix3->dev), pirq));
-    }
-    return 0;
-}
-
-static int piix3_pre_save(void *opaque)
-{
-    int i;
-    PIIX3State *piix3 =3D opaque;
-
-    for (i =3D 0; i < ARRAY_SIZE(piix3->pci_irq_levels_vmstate); i++) {
-        piix3->pci_irq_levels_vmstate[i] =3D
-            pci_bus_get_irq_level(pci_get_bus(&piix3->dev), i);
-    }
-
-    return 0;
-}
-
-static bool piix3_rcr_needed(void *opaque)
-{
-    PIIX3State *piix3 =3D opaque;
-
-    return (piix3->rcr !=3D 0);
-}
-
-static const VMStateDescription vmstate_piix3_rcr =3D {
-    .name =3D "PIIX3/rcr",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
-    .needed =3D piix3_rcr_needed,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_UINT8(rcr, PIIX3State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_piix3 =3D {
-    .name =3D "PIIX3",
-    .version_id =3D 3,
-    .minimum_version_id =3D 2,
-    .post_load =3D piix3_post_load,
-    .pre_save =3D piix3_pre_save,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, PIIX3State),
-        VMSTATE_INT32_ARRAY_V(pci_irq_levels_vmstate, PIIX3State,
-                              PIIX_NUM_PIRQS, 3),
-        VMSTATE_END_OF_LIST()
-    },
-    .subsections =3D (const VMStateDescription*[]) {
-        &vmstate_piix3_rcr,
-        NULL
-    }
-};
-
-
-static void rcr_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
len)
-{
-    PIIX3State *d =3D opaque;
-
-    if (val & 4) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-        return;
-    }
-    d->rcr =3D val & 2; /* keep System Reset type only */
-}
-
-static uint64_t rcr_read(void *opaque, hwaddr addr, unsigned len)
-{
-    PIIX3State *d =3D opaque;
-
-    return d->rcr;
-}
-
-static const MemoryRegionOps rcr_ops =3D {
-    .read =3D rcr_read,
-    .write =3D rcr_write,
-    .endianness =3D DEVICE_LITTLE_ENDIAN
-};
-
-static void piix3_realize(PCIDevice *dev, Error **errp)
-{
-    PIIX3State *d =3D PIIX3_PCI_DEVICE(dev);
-
-    if (!isa_bus_new(DEVICE(d), get_system_memory(),
-                     pci_address_space_io(dev), errp)) {
-        return;
-    }
-
-    memory_region_init_io(&d->rcr_mem, OBJECT(dev), &rcr_ops, d,
-                          "piix3-reset-control", 1);
-    memory_region_add_subregion_overlap(pci_address_space_io(dev),
-                                        PIIX_RCR_IOPORT, &d->rcr_mem, 1)=
;
-
-    qemu_register_reset(piix3_reset, d);
-}
-
-static void pci_piix3_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
-
-    dc->desc        =3D "ISA bridge";
-    dc->vmsd        =3D &vmstate_piix3;
-    dc->hotpluggable   =3D false;
-    k->realize      =3D piix3_realize;
-    k->vendor_id    =3D PCI_VENDOR_ID_INTEL;
-    /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
-    k->device_id    =3D PCI_DEVICE_ID_INTEL_82371SB_0;
-    k->class_id     =3D PCI_CLASS_BRIDGE_ISA;
-    /*
-     * Reason: part of PIIX3 southbridge, needs to be wired up by
-     * pc_piix.c's pc_init1()
-     */
-    dc->user_creatable =3D false;
-}
-
-static const TypeInfo piix3_pci_type_info =3D {
-    .name =3D TYPE_PIIX3_PCI_DEVICE,
-    .parent =3D TYPE_PCI_DEVICE,
-    .instance_size =3D sizeof(PIIX3State),
-    .abstract =3D true,
-    .class_init =3D pci_piix3_class_init,
-    .interfaces =3D (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
-static void piix3_class_init(ObjectClass *klass, void *data)
-{
-    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
-
-    k->config_write =3D piix3_write_config;
-}
-
-static const TypeInfo piix3_info =3D {
-    .name          =3D TYPE_PIIX3_DEVICE,
-    .parent        =3D TYPE_PIIX3_PCI_DEVICE,
-    .class_init    =3D piix3_class_init,
-};
-
-static void piix3_xen_class_init(ObjectClass *klass, void *data)
-{
-    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
-
-    k->config_write =3D piix3_write_config_xen;
-};
-
-static const TypeInfo piix3_xen_info =3D {
-    .name          =3D TYPE_PIIX3_XEN_DEVICE,
-    .parent        =3D TYPE_PIIX3_PCI_DEVICE,
-    .class_init    =3D piix3_xen_class_init,
-};
-
 static void i440fx_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -922,9 +523,6 @@ static void i440fx_register_types(void)
 {
     type_register_static(&i440fx_info);
     type_register_static(&igd_passthrough_i440fx_info);
-    type_register_static(&piix3_pci_type_info);
-    type_register_static(&piix3_info);
-    type_register_static(&piix3_xen_info);
     type_register_static(&i440fx_pcihost_info);
 }
=20
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.=
h
index 094508b928..152628c6d9 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -12,6 +12,8 @@
 #ifndef HW_SOUTHBRIDGE_PIIX_H
 #define HW_SOUTHBRIDGE_PIIX_H
=20
+#include "hw/pci/pci.h"
+
 #define TYPE_PIIX4_PM "PIIX4_PM"
=20
 I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t smb_io_base,
@@ -30,8 +32,42 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t=
 smb_io_base,
  */
 #define PIIX_RCR_IOPORT 0xcf9
=20
+#define PIIX_NUM_PIC_IRQS       16      /* i8259 * 2 */
+#define PIIX_NUM_PIRQS          4ULL    /* PIRQ[A-D] */
+
+typedef struct PIIXState {
+    PCIDevice dev;
+
+    /*
+     * bitmap to track pic levels.
+     * The pic level is the logical OR of all the PCI irqs mapped to it
+     * So one PIC level is tracked by PIIX_NUM_PIRQS bits.
+     *
+     * PIRQ is mapped to PIC pins, we track it by
+     * PIIX_NUM_PIRQS * PIIX_NUM_PIC_IRQS =3D 64 bits with
+     * pic_irq * PIIX_NUM_PIRQS + pirq
+     */
+#if PIIX_NUM_PIC_IRQS * PIIX_NUM_PIRQS > 64
+#error "unable to encode pic state in 64bit in pic_levels."
+#endif
+    uint64_t pic_levels;
+
+    qemu_irq *pic;
+
+    /* This member isn't used. Just for save/load compatibility */
+    int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
+
+    /* Reset Control Register contents */
+    uint8_t rcr;
+
+    /* IO memory region for Reset Control Register (PIIX_RCR_IOPORT) */
+    MemoryRegion rcr_mem;
+} PIIX3State;
+
 extern PCIDevice *piix4_dev;
=20
+PIIX3State *piix3_create(PCIBus *pci_bus, ISABus **isa_bus);
+
 DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
                           I2CBus **smbus, size_t ide_buses);
=20
--=20
2.21.0


