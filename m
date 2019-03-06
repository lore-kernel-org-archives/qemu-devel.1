Received: from eggs.gnu.org ([209.51.188.92]:39433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1cvY-0007s8-Oh
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1cvW-00074j-Rt
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:14:08 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:49139)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1cvU-00070T-Lc
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:14:04 -0500
Message-Id: <12a45041a9a5ae863bf04edf3875aa9d25c481a3.1551902740.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1551902740.git.balaton@eik.bme.hu>
References: <cover.1551902740.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 06 Mar 2019 21:05:40 +0100
Subject: [Qemu-devel] [PATCH v5-resend 2/2] mips_fulong2e: Add on-board
 graphics chip
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
 hw/mips/mips_fulong2e.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index fbbc543eed..f877693766 100644
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
+    qdev_prop_set_uint16(dev, "x-device-id", 0x5159);
+    qdev_init_nofail(dev);
+
     /* Populate SPD eeprom data */
     spd_data = spd_data_generate(DDR, ram_size, &err);
     if (err) {
-- 
2.13.7
