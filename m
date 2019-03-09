Received: from eggs.gnu.org ([209.51.188.92]:34202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2yol-000543-CL
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2yoj-0005Th-FI
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:48:43 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:29609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h2yoi-0005So-7d
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:48:40 -0400
Message-Id: <da6370b22e0352ee803d25d68a62ff32eebf06e2.1552152100.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1552152100.git.balaton@eik.bme.hu>
References: <cover.1552152100.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 09 Mar 2019 18:21:40 +0100
Subject: [Qemu-devel] [PATCH v7 2/2] mips_fulong2e: Add on-board graphics
 chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Aleksandar Markovic <amarkovic@wavecomp.com>, philmd@redhat.com

Add (partial) emulation of the on-board GPU of the machine. This
allows the PMON2000 firmware to run and should also work with Linux
console but probably not with X yet.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
v7:
- set vgamem_mb explicitely to match board instead of relying on default

 hw/mips/mips_fulong2e.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index fbbc543eed..2bdb766ed1 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -287,6 +287,7 @@ static void mips_fulong2e_init(MachineState *machine)
     I2CBus *smbus;
     MIPSCPU *cpu;
     CPUMIPSState *env;
+    DeviceState *dev;
 
     /* init CPUs */
     cpu = MIPS_CPU(cpu_create(machine->cpu_type));
@@ -347,6 +348,12 @@ static void mips_fulong2e_init(MachineState *machine)
     vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
                                &smbus, &isa_bus);
 
+    /* GPU */
+    dev = DEVICE(pci_create(pci_bus, -1, "ati-vga"));
+    qdev_prop_set_uint32(dev, "vgamem_mb", 16);
+    qdev_prop_set_uint16(dev, "x-device-id", 0x5159);
+    qdev_init_nofail(dev);
+
     /* Populate SPD eeprom data */
     spd_data = spd_data_generate(DDR, ram_size, &err);
     if (err) {
-- 
2.13.7
