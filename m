Received: from eggs.gnu.org ([209.51.188.92]:37244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gt3FL-0003N9-5i
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gt32C-0006Bh-QD
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:17:34 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:41257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gt326-0005qd-18
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:17:27 -0500
Message-Id: <9f5f3187f0eff04efc2ec3639727a17bf8d36dce.1549857716.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1549857716.git.balaton@eik.bme.hu>
References: <cover.1549857716.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 11 Feb 2019 05:01:56 +0100
Subject: [Qemu-devel] [PATCH 4/4] mips_fulong2e: Add on-board graphics chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>

Add (partial) emulation of the on-board GPU of the machine. This
allows the PMON2000 firmware to run and should also work with Linux
console but probably not with X yet.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Depends on hw/display: Add basic ATI VGA emulation

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
