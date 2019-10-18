Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0F6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4567B222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4567B222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLShS-0001OI-6K
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSdh-0004yz-GK
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSdg-0006IL-5N
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:49:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSdf-0006HY-Sp
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:49:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 17239C05AA6C;
 Fri, 18 Oct 2019 13:49:55 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92E9660BF1;
 Fri, 18 Oct 2019 13:49:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/20] hw/mips/mips_malta: Extract the PIIX4 creation code
 as piix4_create()
Date: Fri, 18 Oct 2019 15:47:44 +0200
Message-Id: <20191018134754.16362-11-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-1-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 18 Oct 2019 13:49:55 +0000 (UTC)
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

The Malta board instantiate a PIIX4 chipset doing various
calls. Refactor all those related calls into a single
function: piix4_create().

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_malta.c | 47 +++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 774bb810f6..0d4312840b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1210,6 +1210,34 @@ static void mips_create_cpu(MachineState *ms, Malt=
aState *s,
     }
 }
=20
+static DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
+                                 I2CBus **smbus, size_t ide_buses)
+{
+    const size_t ide_drives =3D ide_buses * MAX_IDE_DEVS;
+    DriveInfo **hd;
+    PCIDevice *pci;
+    DeviceState *dev;
+
+    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
+                                          true, TYPE_PIIX4_PCI_DEVICE);
+    dev =3D DEVICE(pci);
+    if (isa_bus) {
+        *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
+    }
+
+    hd =3D g_new(DriveInfo *, ide_drives);
+    ide_drive_get(hd, ide_drives);
+    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
+    g_free(hd);
+    pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
+    if (smbus) {
+        *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
+                               isa_get_irq(NULL, 9), NULL, 0, NULL);
+   }
+
+    return dev;
+}
+
 static
 void mips_malta_init(MachineState *machine)
 {
@@ -1231,12 +1259,8 @@ void mips_malta_init(MachineState *machine)
     PCIBus *pci_bus;
     ISABus *isa_bus;
     qemu_irq cbus_irq, i8259_irq;
-    PCIDevice *pci;
-    int piix4_devfn;
     I2CBus *smbus;
     DriveInfo *dinfo;
-    const size_t ide_drives =3D MAX_IDE_BUS * MAX_IDE_DEVS;
-    DriveInfo **hd;
     int fl_idx =3D 0;
     int be;
=20
@@ -1407,14 +1431,7 @@ void mips_malta_init(MachineState *machine)
     pci_bus =3D gt64120_register(s->i8259);
=20
     /* Southbridge */
-    hd =3D g_new(DriveInfo *, ide_drives);
-    ide_drive_get(hd, ide_drives);
-
-    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
-                                          true, TYPE_PIIX4_PCI_DEVICE);
-    dev =3D DEVICE(pci);
-    isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
-    piix4_devfn =3D pci->devfn;
+    dev =3D piix4_create(pci_bus, &isa_bus, &smbus, MAX_IDE_BUS);
=20
     /* Interrupt controller */
     qdev_connect_gpio_out_named(dev, "intr", 0, i8259_irq);
@@ -1422,12 +1439,6 @@ void mips_malta_init(MachineState *machine)
         s->i8259[i] =3D qdev_get_gpio_in_named(dev, "isa", i);
     }
=20
-    pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);
-    g_free(hd);
-    pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
-    smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
-                          isa_get_irq(NULL, 9), NULL, 0, NULL);
-
     /* generate SPD EEPROM data */
     generate_eeprom_spd(&smbus_eeprom_buf[0 * 256], ram_size);
     generate_eeprom_serial(&smbus_eeprom_buf[6 * 256]);
--=20
2.21.0


