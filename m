Received: from eggs.gnu.org ([209.51.188.92]:56485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hApSU-0007KR-6d
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hApSQ-0002Zi-9K
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:26:09 -0400
Received: from mail-eopbgr770123.outbound.protection.outlook.com
	([40.107.77.123]:22843
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tjin@wavecomp.com>) id 1hApSM-0002Y0-U2
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:26:04 -0400
From: Tommy Jin <tjin@wavecomp.com>
Date: Mon, 1 Apr 2019 05:26:00 +0000
Message-ID: <1554096222-29539-2-git-send-email-tjin@wavecomp.com>
References: <1554096222-29539-1-git-send-email-tjin@wavecomp.com>
In-Reply-To: <1554096222-29539-1-git-send-email-tjin@wavecomp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard for
 boston board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Tommy Jin <tjin@wavecomp.com>

Boston didn't bring up any netcard by default, this is not so convenient.
As the linux kernel has supported virtio_net, now add a virtio netcard for =
boston.
To make virtio work properly, please:
1. set virtio net options in linux kernel, saying CONFIG_VIRTIO && CONFIG_V=
IRTIO_PCI && CONFIG_VIRTIO_NET
2. specify model=3Dvirtio when you start netcard in qemu.

Signed-off-by: tjin <tjin@wavecomp.com>
---
 hw/mips/boston.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index e5bab3c..930bb9d 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -32,6 +32,7 @@
 #include "hw/mips/cps.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci-host/xilinx-pcie.h"
+#include "hw/virtio/virtio-pci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -422,6 +423,20 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_n=
r,
     return XILINX_PCIE_HOST(dev);
 }
=20
+/* Plug network card  in pcie slot.*/
+static void network_init(PCIBus *bus)
+{
+	PCIDevice *eth;
+
+	/*Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI && CONFIG_VIRTIO_NET
+	of Linux kernel.*/
+	eth =3D pci_create(bus,
+					 PCI_DEVFN(0, 1), "virtio-net-pci");
+
+	qdev_set_nic_properties(&eth->qdev, &nd_table[0]);
+	qdev_init_nofail(&eth->qdev);
+}
+
 static void boston_mach_init(MachineState *machine)
 {
     DeviceState *dev;
@@ -545,6 +560,9 @@ static void boston_mach_init(MachineState *machine)
         error_printf("Please provide either a -kernel or -bios argument\n"=
);
         exit(1);
     }
+
+	/* Network card */
+	network_init(&PCI_BRIDGE(&pcie2->root)->sec_bus);
 }
=20
 static void boston_mach_class_init(MachineClass *mc)
--=20
2.7.4
