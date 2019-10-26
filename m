Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC4FCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD1220663
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOqNn4U+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD1220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQRz-0004Eo-Pe
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 14:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOQQ1-0001aI-HA
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOQQ0-0007mb-5I
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59009
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOQQ0-0007m8-1T
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572113043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaGGIPdRKREyMkIJNKEc0RLVDqW+DoJcRjwnPCc+80g=;
 b=gOqNn4U+yL28ovWcXf/ouh9gkYayGlqe8kSzfUkOI0qPfdY6wqg3dtkvt3Nni4lVAPVOTR
 8A34LNeCBVU1d0uMp/cpgI6RTYt4XEhfNq2YC8EUKqROW4b782OHZb+8qHq5fnGOiy7S4V
 g/CqNfohteVzKPgSGTCeyWF9sp55cXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-NGRn1jszN-WVVLXS3MXkEA-1; Sat, 26 Oct 2019 14:03:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE8B2800D41;
 Sat, 26 Oct 2019 18:03:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A11A660C57;
 Sat, 26 Oct 2019 18:03:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/20] hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c
Date: Sat, 26 Oct 2019 20:01:34 +0200
Message-Id: <20191026180143.7369-12-philmd@redhat.com>
In-Reply-To: <20191026180143.7369-1-philmd@redhat.com>
References: <20191026180143.7369-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NGRn1jszN-WVVLXS3MXkEA-1
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Now that we properly refactored the piix4_create() function, let's
move it to hw/isa/piix4.c where it belongs, so it can be reused
on other places.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/piix4.c                | 30 ++++++++++++++++++++++++++++++
 hw/mips/gt64xxx_pci.c         |  1 +
 hw/mips/mips_malta.c          | 28 ----------------------------
 include/hw/i386/pc.h          |  2 --
 include/hw/southbridge/piix.h |  6 ++++++
 5 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 6bf6f0c5d9..f3e21ea76d 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -27,12 +27,14 @@
 #include "qapi/error.h"
 #include "hw/irq.h"
 #include "hw/i386/pc.h"
+#include "hw/southbridge/piix.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "hw/dma/i8257.h"
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
+#include "hw/ide.h"
 #include "migration/vmstate.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
@@ -237,3 +239,31 @@ static void piix4_register_types(void)
 }
=20
 type_init(piix4_register_types)
+
+DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
+                          I2CBus **smbus, size_t ide_buses)
+{
+    size_t ide_drives =3D ide_buses * MAX_IDE_DEVS;
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
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index f325bd6c1c..c277398c0d 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -28,6 +28,7 @@
 #include "hw/mips/mips.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
+#include "hw/southbridge/piix.h"
 #include "migration/vmstate.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 9014d77b7a..92e9ca5bfa 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1210,34 +1210,6 @@ static void mips_create_cpu(MachineState *ms, MaltaS=
tate *s,
     }
 }
=20
-static DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
-                                 I2CBus **smbus, size_t ide_buses)
-{
-    const size_t ide_drives =3D ide_buses * MAX_IDE_DEVS;
-    DriveInfo **hd;
-    PCIDevice *pci;
-    DeviceState *dev;
-
-    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
-                                          true, TYPE_PIIX4_PCI_DEVICE);
-    dev =3D DEVICE(pci);
-    if (isa_bus) {
-        *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
-    }
-
-    hd =3D g_new(DriveInfo *, ide_drives);
-    ide_drive_get(hd, ide_drives);
-    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
-    g_free(hd);
-    pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
-    if (smbus) {
-        *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
-                               isa_get_irq(NULL, 9), NULL, 0, NULL);
-   }
-
-    return dev;
-}
-
 static
 void mips_malta_init(MachineState *machine)
 {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c933c0d3a1..2fd40ceebe 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -258,8 +258,6 @@ PCIBus *i440fx_init(const char *host_type, const char *=
pci_type,
                     MemoryRegion *ram_memory);
=20
 PCIBus *find_i440fx(void);
-/* piix4.c */
-extern PCIDevice *piix4_dev;
=20
 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index b8ce26fec4..add352456b 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -2,6 +2,7 @@
  * QEMU PIIX South Bridge Emulation
  *
  * Copyright (c) 2006 Fabrice Bellard
+ * Copyright (c) 2018 Herv=C3=A9 Poussineau
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
  * See the COPYING file in the top-level directory.
@@ -17,4 +18,9 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t sm=
b_io_base,
                       qemu_irq sci_irq, qemu_irq smi_irq,
                       int smm_enabled, DeviceState **piix4_pm);
=20
+extern PCIDevice *piix4_dev;
+
+DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
+                          I2CBus **smbus, size_t ide_buses);
+
 #endif
--=20
2.21.0


