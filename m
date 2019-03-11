Received: from eggs.gnu.org ([209.51.188.92]:36661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Gdr-0004xp-H9
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Gdq-0002GQ-Hi
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3Gdq-0002Fh-AA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:38 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 11 Mar 2019 09:50:24 +0100
Message-Id: <20190311085024.13780-6-kraxel@redhat.com>
In-Reply-To: <20190311085024.13780-1-kraxel@redhat.com>
References: <20190311085024.13780-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] mips_fulong2e: Add on-board graphics chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>

From: BALATON Zoltan <balaton@eik.bme.hu>

Add (partial) emulation of the on-board GPU of the machine. This
allows the PMON2000 firmware to run and should also work with Linux
console but probably not with X yet.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
Message-id: da6370b22e0352ee803d25d68a62ff32eebf06e2.1552152100.git.balat=
on@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/mips/mips_fulong2e.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index fbbc543eede5..9d7480ed3171 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -287,6 +287,7 @@ static void mips_fulong2e_init(MachineState *machine)
     I2CBus *smbus;
     MIPSCPU *cpu;
     CPUMIPSState *env;
+    DeviceState *dev;
=20
     /* init CPUs */
     cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
@@ -347,6 +348,12 @@ static void mips_fulong2e_init(MachineState *machine=
)
     vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
                                &smbus, &isa_bus);
=20
+    /* GPU */
+    dev =3D DEVICE(pci_create(pci_bus, -1, "ati-vga"));
+    qdev_prop_set_uint32(dev, "vgamem_mb", 16);
+    qdev_prop_set_uint16(dev, "x-device-id", 0x5159);
+    qdev_init_nofail(dev);
+
     /* Populate SPD eeprom data */
     spd_data =3D spd_data_generate(DDR, ram_size, &err);
     if (err) {
--=20
2.18.1
