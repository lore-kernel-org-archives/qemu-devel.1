Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ABACA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8AB222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8AB222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSgT-0008Bg-NW
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLScU-0003Vc-A0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLScS-0005iQ-PU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLScQ-0005hD-NJ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:48:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 721463078467;
 Fri, 18 Oct 2019 13:48:37 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDF7060C4E;
 Fri, 18 Oct 2019 13:48:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/20] piix4: Add a i8259 Interrupt Controller as specified
 in datasheet
Date: Fri, 18 Oct 2019 15:47:37 +0200
Message-Id: <20191018134754.16362-4-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-1-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 18 Oct 2019 13:48:37 +0000 (UTC)
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

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Add ISA irqs as piix4 gpio in, and CPU interrupt request as piix4 gpio ou=
t.
Remove i8259 instanciated in malta board, to not have it twice.

We can also remove the now unused piix4_init() function.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Message-Id: <20171216090228.28505-8-hpoussin@reactos.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
[PMD: rebased, updated includes, use ISA_NUM_IRQS in for loop]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/piix4.c       | 43 ++++++++++++++++++++++++++++++++-----------
 hw/mips/mips_malta.c | 32 +++++++++++++-------------------
 include/hw/i386/pc.h |  1 -
 3 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index d0b18e0586..9c37c85ae2 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
@@ -36,6 +37,8 @@ PCIDevice *piix4_dev;
=20
 typedef struct PIIX4State {
     PCIDevice dev;
+    qemu_irq cpu_intr;
+    qemu_irq *isa;
=20
     /* Reset Control Register */
     MemoryRegion rcr_mem;
@@ -94,6 +97,18 @@ static const VMStateDescription vmstate_piix4 =3D {
     }
 };
=20
+static void piix4_request_i8259_irq(void *opaque, int irq, int level)
+{
+    PIIX4State *s =3D opaque;
+    qemu_set_irq(s->cpu_intr, level);
+}
+
+static void piix4_set_i8259_irq(void *opaque, int irq, int level)
+{
+    PIIX4State *s =3D opaque;
+    qemu_set_irq(s->isa[irq], level);
+}
+
 static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
                             unsigned int len)
 {
@@ -127,29 +142,35 @@ static const MemoryRegionOps piix4_rcr_ops =3D {
 static void piix4_realize(PCIDevice *dev, Error **errp)
 {
     PIIX4State *s =3D PIIX4_PCI_DEVICE(dev);
+    ISABus *isa_bus;
+    qemu_irq *i8259_out_irq;
=20
-    if (!isa_bus_new(DEVICE(dev), pci_address_space(dev),
-                     pci_address_space_io(dev), errp)) {
+    isa_bus =3D isa_bus_new(DEVICE(dev), pci_address_space(dev),
+                          pci_address_space_io(dev), errp);
+    if (!isa_bus) {
         return;
     }
=20
+    qdev_init_gpio_in_named(DEVICE(dev), piix4_set_i8259_irq,
+                            "isa", ISA_NUM_IRQS);
+    qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
+                             "intr", 1);
+
     memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
                           "reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev), 0xcf9=
,
                                         &s->rcr_mem, 1);
=20
+    /* initialize i8259 pic */
+    i8259_out_irq =3D qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
+    s->isa =3D i8259_init(isa_bus, *i8259_out_irq);
+
+    /* initialize ISA irqs */
+    isa_bus_irqs(isa_bus, s->isa);
+
     piix4_dev =3D dev;
 }
=20
-int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
-{
-    PCIDevice *d;
-
-    d =3D pci_create_simple_multifunction(bus, devfn, true, "PIIX4");
-    *isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(d), "isa.0"));
-    return d->devfn;
-}
-
 static void piix4_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 4d9c64b36a..7d25ab6c23 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -97,7 +97,7 @@ typedef struct {
     SysBusDevice parent_obj;
=20
     MIPSCPSState cps;
-    qemu_irq *i8259;
+    qemu_irq i8259[16];
 } MaltaState;
=20
 static ISADevice *pit;
@@ -1235,8 +1235,8 @@ void mips_malta_init(MachineState *machine)
     int64_t kernel_entry, bootloader_run_addr;
     PCIBus *pci_bus;
     ISABus *isa_bus;
-    qemu_irq *isa_irq;
     qemu_irq cbus_irq, i8259_irq;
+    PCIDevice *pci;
     int piix4_devfn;
     I2CBus *smbus;
     DriveInfo *dinfo;
@@ -1407,30 +1407,24 @@ void mips_malta_init(MachineState *machine)
     /* Board ID =3D 0x420 (Malta Board with CoreLV) */
     stl_p(memory_region_get_ram_ptr(bios_copy) + 0x10, 0x00000420);
=20
-    /*
-     * We have a circular dependency problem: pci_bus depends on isa_irq=
,
-     * isa_irq is provided by i8259, i8259 depends on ISA, ISA depends
-     * on piix4, and piix4 depends on pci_bus.  To stop the cycle we hav=
e
-     * qemu_irq_proxy() adds an extra bit of indirection, allowing us
-     * to resolve the isa_irq -> i8259 dependency after i8259 is initial=
ized.
-     */
-    isa_irq =3D qemu_irq_proxy(&s->i8259, 16);
-
     /* Northbridge */
-    pci_bus =3D gt64120_register(isa_irq);
+    pci_bus =3D gt64120_register(s->i8259);
=20
     /* Southbridge */
     ide_drive_get(hd, ARRAY_SIZE(hd));
=20
-    piix4_devfn =3D piix4_init(pci_bus, &isa_bus, 80);
+    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
+                                          true, "PIIX4");
+    dev =3D DEVICE(pci);
+    isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
+    piix4_devfn =3D pci->devfn;
=20
-    /*
-     * Interrupt controller
-     * The 8259 is attached to the MIPS CPU INT0 pin, ie interrupt 2
-     */
-    s->i8259 =3D i8259_init(isa_bus, i8259_irq);
+    /* Interrupt controller */
+    qdev_connect_gpio_out_named(dev, "intr", 0, i8259_irq);
+    for (int i =3D 0; i < ISA_NUM_IRQS; i++) {
+        s->i8259[i] =3D qdev_get_gpio_in_named(dev, "isa", i);
+    }
=20
-    isa_bus_irqs(isa_bus, s->i8259);
     pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);
     pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
     smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 37bfd95113..374f3e8835 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -286,7 +286,6 @@ PCIBus *i440fx_init(const char *host_type, const char=
 *pci_type,
 PCIBus *find_i440fx(void);
 /* piix4.c */
 extern PCIDevice *piix4_dev;
-int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
=20
 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
--=20
2.21.0


