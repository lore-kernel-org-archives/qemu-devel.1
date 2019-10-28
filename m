Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DE6CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7233520862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASysei4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7233520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9Nd-0002pF-V3
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 14:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iP7zt-0002Rq-6L
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iP7zr-0007hy-LB
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:36:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40166
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iP7zr-0007fP-FT
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572280555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4J3P2UfFCzOddbSMsyW2LgzLAlP7e/TG1wlFn/qvUL0=;
 b=ASysei4CfRbQbQFwtwfIu9EgaJCgnCE4nC/8LIoit9W+Cp3r4Jev008OvdqeA769fcEOjy
 JRMNmHSr2hJF4OEI55R4+HKRIWHbBnVwnAzmtjKmIHdybWHSjUfmgl/36aTX2gRM7KtqCh
 c/f6KzVu9xhRlSEYd/vLc4UvX5uMWb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-VdJVkobbP3iJP3VI_U3K8A-1; Mon, 28 Oct 2019 12:35:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F7548017CC;
 Mon, 28 Oct 2019 16:35:51 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-87.brq.redhat.com [10.40.204.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8C961C941;
 Mon, 28 Oct 2019 16:35:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] hw/mips/mips_malta: Extract the PIIX4 creation code as
 piix4_create()
Date: Mon, 28 Oct 2019 17:34:37 +0100
Message-Id: <20191028163447.18541-11-philmd@redhat.com>
In-Reply-To: <20191028163447.18541-1-philmd@redhat.com>
References: <20191028163447.18541-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: VdJVkobbP3iJP3VI_U3K8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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
index 239ea98ef8..9014d77b7a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1210,6 +1210,34 @@ static void mips_create_cpu(MachineState *ms, MaltaS=
tate *s,
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


