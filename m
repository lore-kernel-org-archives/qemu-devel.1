Received: from eggs.gnu.org ([209.51.188.92]:34827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvhnf-000625-8v
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvhne-0006cW-9d
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:31 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:27830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gvhna-0006Xe-1J
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:27 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 18 Feb 2019 13:09:17 +0100
Message-Id: <20190218121322.DAB0474569F@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH v2] mips_fulong2e: Add on-board graphics chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>, philmd@redhat.com

Add (partial) emulation of the on-board GPU of the machine. This
allows the PMON2000 firmware to run and should also work with Linux
console but probably not with X yet.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Based-on: 20190218030257.624A7745694@zero.eik.bme.hu
---
 hw/mips/mips_fulong2e.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index eec6fd02c8..68bd030fc1 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -287,6 +287,7 @@ static void mips_fulong2e_init(MachineState *machine)
     I2CBus *smbus;
     MIPSCPU *cpu;
     CPUMIPSState *env;
+    DeviceState *dev;
 
     /* init CPUs */
     cpu = MIPS_CPU(cpu_create(machine->cpu_type));
@@ -347,6 +348,11 @@ static void mips_fulong2e_init(MachineState *machine)
     vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
                                &smbus, &isa_bus);
 
+    /* GPU */
+    dev = DEVICE(pci_create(pci_bus, -1, "ati-vga"));
+    qdev_prop_set_uint16(dev, "device_id", 0x5159);
+    qdev_init_nofail(dev);
+
     /* Populate SPD eeprom data */
     spd_data = spd_data_generate(DDR, ram_size, &err);
     if (err) {
-- 
2.13.7
