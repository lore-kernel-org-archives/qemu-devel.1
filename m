Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB2C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D048220714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJn/U66L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D048220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43249 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELoF-0007qb-VB
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELak-0002hl-89
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELai-000370-9m
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELag-00032S-7W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9FJywFBqem12AIhvlt34sK1ph0aw1jFx1iGScvNM38=;
 b=PJn/U66LugJlfnTT8R4AqVe4daseZa2C0eKzEidOGfBawtrJ198S7O/f8t186PY1iswmi9
 fPvasCYlmLArrU1Tb591E6fk04rh3LZMLkdLBSd8Kk3G1K6ssf1TP9SlKLfAlCdr7l+XYF
 QLpxv55CZGolA/t4ksl5z/Li11rpaRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-hkB0LRk2NbSJd2sxJb_UoA-1; Tue, 17 Mar 2020 19:25:37 -0400
X-MC-Unique: hkB0LRk2NbSJd2sxJb_UoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 132C81804560;
 Tue, 17 Mar 2020 23:25:35 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF89960BE0;
 Tue, 17 Mar 2020 23:25:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/20] hw/ide: Do ide_drive_get() within pci_ide_create_devs()
Date: Tue, 17 Mar 2020 19:23:27 -0400
Message-Id: <20200317232329.22362-19-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
References: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Helge Deller <deller@gmx.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

The pci_ide_create_devs() function takes a hd_table parameter but all
callers just pass what ide_drive_get() returns so we can do it locally
simplifying callers and removing hd_table parameter.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: e9713fdded4d212fa68ed03b844e531934226a6f.1584457537.git.balaton=
@eik.bme.hu
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/hw/ide/pci.h          |  2 +-
 include/hw/southbridge/piix.h |  3 +--
 hw/alpha/dp264.c              | 13 +++----------
 hw/i386/pc_piix.c             |  9 +++++----
 hw/ide/pci.c                  |  4 +++-
 hw/isa/piix4.c                | 10 ++--------
 hw/mips/mips_fulong2e.c       |  4 +---
 hw/mips/mips_malta.c          |  2 +-
 hw/sparc64/sun4u.c            |  6 +-----
 9 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index 98ffa7dfcd..dd504e5a0b 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -63,7 +63,7 @@ static inline IDEState *bmdma_active_if(BMDMAState *bmdma=
)
 void bmdma_init(IDEBus *bus, BMDMAState *bm, PCIIDEState *d);
 void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val);
 extern MemoryRegionOps bmdma_addr_ioport_ops;
-void pci_ide_create_devs(PCIDevice *dev, DriveInfo **hd_table);
+void pci_ide_create_devs(PCIDevice *dev);
=20
 extern const VMStateDescription vmstate_ide_pci;
 extern const MemoryRegionOps pci_ide_cmd_le_ops;
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 152628c6d9..02bd741209 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -68,7 +68,6 @@ extern PCIDevice *piix4_dev;
=20
 PIIX3State *piix3_create(PCIBus *pci_bus, ISABus **isa_bus);
=20
-DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
-                          I2CBus **smbus, size_t ide_buses);
+DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus, I2CBus **smbu=
s);
=20
 #endif
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 27595767e5..f7751b18f6 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -15,7 +15,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/ide.h"
 #include "hw/ide/pci.h"
 #include "hw/timer/i8254.h"
 #include "hw/isa/superio.h"
@@ -58,6 +57,7 @@ static void clipper_init(MachineState *machine)
     const char *initrd_filename =3D machine->initrd_filename;
     AlphaCPU *cpus[4];
     PCIBus *pci_bus;
+    PCIDevice *pci_dev;
     ISABus *isa_bus;
     qemu_irq rtc_irq;
     long size, i;
@@ -100,15 +100,8 @@ static void clipper_init(MachineState *machine)
     isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
=20
     /* IDE disk setup.  */
-    {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        PCIDevice *pci_dev;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-
-        pci_dev =3D pci_create_simple(pci_bus, -1, "cmd646-ide");
-        pci_ide_create_devs(pci_dev, hd);
-    }
+    pci_dev =3D pci_create_simple(pci_bus, -1, "cmd646-ide");
+    pci_ide_create_devs(pci_dev);
=20
     /* Load PALcode.  Given that this is not "real" cpu palcode,
        but one explicitly written for the emulation, we might as
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c399398739..9216596ec6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -86,7 +86,6 @@ static void pc_init1(MachineState *machine,
     int piix3_devfn =3D -1;
     qemu_irq smi_irq;
     GSIState *gsi_state;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     BusState *idebus[MAX_IDE_BUS];
     ISADevice *rtc_state;
     MemoryRegion *ram_memory;
@@ -240,20 +239,22 @@ static void pc_init1(MachineState *machine,
=20
     pc_nic_init(pcmc, isa_bus, pci_bus);
=20
-    ide_drive_get(hd, ARRAY_SIZE(hd));
     if (pcmc->pci_enabled) {
         PCIDevice *dev;
=20
         dev =3D pci_create_simple(pci_bus, piix3_devfn + 1,
                                 xen_enabled() ? "piix3-ide-xen" : "piix3-i=
de");
-        pci_ide_create_devs(dev, hd);
+        pci_ide_create_devs(dev);
         idebus[0] =3D qdev_get_child_bus(&dev->qdev, "ide.0");
         idebus[1] =3D qdev_get_child_bus(&dev->qdev, "ide.1");
         pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
     }
 #ifdef CONFIG_IDE_ISA
-else {
+    else {
+        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
         int i;
+
+        ide_drive_get(hd, ARRAY_SIZE(hd));
         for (i =3D 0; i < MAX_IDE_BUS; i++) {
             ISADevice *dev;
             char busname[] =3D "ide.0";
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index e0c84392e2..97347f07f1 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -477,13 +477,15 @@ const VMStateDescription vmstate_ide_pci =3D {
 };
=20
 /* hd_table must contain 4 block drivers */
-void pci_ide_create_devs(PCIDevice *dev, DriveInfo **hd_table)
+void pci_ide_create_devs(PCIDevice *dev)
 {
     PCIIDEState *d =3D PCI_IDE(dev);
+    DriveInfo *hd_table[2 * MAX_IDE_DEVS];
     static const int bus[4]  =3D { 0, 0, 1, 1 };
     static const int unit[4] =3D { 0, 1, 0, 1 };
     int i;
=20
+    ide_drive_get(hd_table, ARRAY_SIZE(hd_table));
     for (i =3D 0; i < 4; i++) {
         if (hd_table[i]) {
             ide_create_drive(d->bus + bus[i], unit[i], hd_table[i]);
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 706eb5be69..cc3e5cef8c 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -241,11 +241,8 @@ static void piix4_register_types(void)
=20
 type_init(piix4_register_types)
=20
-DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
-                          I2CBus **smbus, size_t ide_buses)
+DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus, I2CBus **smbu=
s)
 {
-    size_t ide_drives =3D ide_buses * MAX_IDE_DEVS;
-    DriveInfo **hd;
     PCIDevice *pci;
     DeviceState *dev;
     int devfn =3D PCI_DEVFN(10, 0);
@@ -258,10 +255,7 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus **is=
a_bus,
     }
=20
     pci =3D pci_create_simple(pci_bus, devfn + 1, "piix4-ide");
-    hd =3D g_new(DriveInfo *, ide_drives);
-    ide_drive_get(hd, ide_drives);
-    pci_ide_create_devs(pci, hd);
-    g_free(hd);
+    pci_ide_create_devs(pci);
=20
     pci_create_simple(pci_bus, devfn + 2, "piix4-usb-uhci");
     if (smbus) {
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 639ba2a091..0f312b5a35 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -239,7 +239,6 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus,=
 int slot, qemu_irq intc,
 {
     qemu_irq *i8259;
     ISABus *isa_bus;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     PCIDevice *dev;
=20
     isa_bus =3D vt82c686b_isa_init(pci_bus, PCI_DEVFN(slot, 0));
@@ -259,8 +258,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus,=
 int slot, qemu_irq intc,
     isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
=20
     dev =3D pci_create_simple(pci_bus, PCI_DEVFN(slot, 1), "via-ide");
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    pci_ide_create_devs(dev, hd);
+    pci_ide_create_devs(dev);
=20
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci");
     pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci");
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index d380f73d7b..e4c4de1b4e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1403,7 +1403,7 @@ void mips_malta_init(MachineState *machine)
     pci_bus =3D gt64120_register(s->i8259);
=20
     /* Southbridge */
-    dev =3D piix4_create(pci_bus, &isa_bus, &smbus, MAX_IDE_BUS);
+    dev =3D piix4_create(pci_bus, &isa_bus, &smbus);
=20
     /* Interrupt controller */
     qdev_connect_gpio_out_named(dev, "intr", 0, i8259_irq);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d33e84f831..6abfcb30f8 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -50,7 +50,6 @@
 #include "hw/sparc/sparc64.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
-#include "hw/ide.h"
 #include "hw/ide/pci.h"
 #include "hw/loader.h"
 #include "hw/fw-path-provider.h"
@@ -563,7 +562,6 @@ static void sun4uv_init(MemoryRegion *address_space_mem=
,
     PCIBus *pci_bus, *pci_busA, *pci_busB;
     PCIDevice *ebus, *pci_dev;
     SysBusDevice *s;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     DeviceState *iommu, *dev;
     FWCfgState *fw_cfg;
     NICInfo *nd;
@@ -663,12 +661,10 @@ static void sun4uv_init(MemoryRegion *address_space_m=
em,
         qemu_macaddr_default_if_unset(&macaddr);
     }
=20
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-
     pci_dev =3D pci_create(pci_busA, PCI_DEVFN(3, 0), "cmd646-ide");
     qdev_prop_set_uint32(&pci_dev->qdev, "secondary", 1);
     qdev_init_nofail(&pci_dev->qdev);
-    pci_ide_create_devs(pci_dev, hd);
+    pci_ide_create_devs(pci_dev);
=20
     /* Map NVRAM into I/O (ebus) space */
     nvram =3D m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
--=20
2.21.1


