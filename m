Received: from eggs.gnu.org ([2001:4830:134:3::10]:49556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWg-0004cS-Ki
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWf-0001kH-AM
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:06 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWf-0001jT-06
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:05 -0500
Received: by mail-wm0-x243.google.com with SMTP id z81so18730611wmb.4
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 13:20:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 18:19:22 -0300
Message-Id: <20180305211928.466-17-f4bug@amsat.org>
In-Reply-To: <20180305211928.466-1-f4bug@amsat.org>
References: <20180305211928.466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 16/22] hw/mips/mips_fulong2e: Factor out
 vt82c686b_southbridge_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_fulong2e.c | 83 ++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 9339e02120..ca1f76a724 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -78,8 +78,6 @@
 #define FULONG2E_ATI_SLOT        6
 #define FULONG2E_RTL8139_SLOT    7
 
-static ISADevice *pit;
-
 static struct _loaderparams {
     int ram_size;
     const char *kernel_filename;
@@ -232,11 +230,44 @@ static const uint8_t eeprom_spd[0x80] = {
     0x20,0x30,0x20
 };
 
-/* Audio support */
-static void audio_init (PCIBus *pci_bus)
+static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
+                                       I2CBus **i2c_bus, ISABus **p_isa_bus)
 {
-    vt82c686b_ac97_init(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 5));
-    vt82c686b_mc97_init(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 6));
+    qemu_irq *i8259;
+    ISABus *isa_bus;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+
+    isa_bus = vt82c686b_init(pci_bus, PCI_DEVFN(slot, 0));
+    if (!isa_bus) {
+        fprintf(stderr, "vt82c686b_init error\n");
+        exit(1);
+    }
+    *p_isa_bus = isa_bus;
+    /* Interrupt controller */
+    /* The 8259 -> IP5  */
+    i8259 = i8259_init(isa_bus, intc);
+    isa_bus_irqs(isa_bus, i8259);
+    /* init other devices */
+    i8254_pit_init(isa_bus, 0x40, 0, NULL);
+    i8257_dma_init(isa_bus, 0);
+
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    vt82c686b_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
+
+    pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci");
+    pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci");
+
+    *i2c_bus = vt82c686b_pm_init(pci_bus, PCI_DEVFN(slot, 4), 0xeee1, NULL);
+
+    /* Audio support */
+    vt82c686b_ac97_init(pci_bus, PCI_DEVFN(slot, 5));
+    vt82c686b_mc97_init(pci_bus, PCI_DEVFN(slot, 6));
+
+    /* Super I/O */
+    isa_create_simple(isa_bus, TYPE_I8042);
+
+    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
+    parallel_hds_isa_init(isa_bus, 1);
 }
 
 /* Network support */
@@ -269,11 +300,9 @@ static void mips_fulong2e_init(MachineState *machine)
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     long bios_size;
     int64_t kernel_entry;
-    qemu_irq *i8259;
     PCIBus *pci_bus;
     ISABus *isa_bus;
     I2CBus *smbus;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     MIPSCPU *cpu;
     CPUMIPSState *env;
 
@@ -335,46 +364,16 @@ static void mips_fulong2e_init(MachineState *machine)
     /* North bridge, Bonito --> IP2 */
     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
 
-    /* South bridge */
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-
-    isa_bus = vt82c686b_init(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 0));
-    if (!isa_bus) {
-        error_report("vt82c686b_init error");
-        exit(1);
-    }
-
-    /* Interrupt controller */
-    /* The 8259 -> IP5  */
-    i8259 = i8259_init(isa_bus, env->irq[5]);
-    isa_bus_irqs(isa_bus, i8259);
-
-    vt82c686b_ide_init(pci_bus, hd, PCI_DEVFN(FULONG2E_VIA_SLOT, 1));
-    pci_create_simple(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 2),
-                      "vt82c686b-usb-uhci");
-    pci_create_simple(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 3),
-                      "vt82c686b-usb-uhci");
+    /* South bridge -> IP5 */
+    vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
+                               &smbus, &isa_bus);
 
-    smbus = vt82c686b_pm_init(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 4),
-                              0xeee1, NULL);
     /* TODO: Populate SPD eeprom data.  */
     smbus_eeprom_init(smbus, 1, eeprom_spd, sizeof(eeprom_spd));
 
-    /* init other devices */
-    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    i8257_dma_init(isa_bus, 0);
-
-    /* Super I/O */
-    isa_create_simple(isa_bus, TYPE_I8042);
-
     mc146818_rtc_init(isa_bus, 2000, NULL);
 
-    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
-    parallel_hds_isa_init(isa_bus, 1);
-
-    /* Sound card */
-    audio_init(pci_bus);
-    /* Network card */
+    /* Network card: RTL8139D */
     network_init(pci_bus);
 }
 
-- 
2.16.2
