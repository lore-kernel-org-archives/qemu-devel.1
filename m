Received: from eggs.gnu.org ([208.118.235.92]:48983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Paul.Burton@mips.com>) id 1en87D-0004pR-F2
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 14:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Paul.Burton@mips.com>) id 1en87B-000828-1u
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 14:25:43 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:35066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Paul.Burton@mips.com>)
	id 1en87A-00081I-Sm
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 14:25:40 -0500
From: Paul Burton <paul.burton@mips.com>
Date: Sat, 17 Feb 2018 11:22:15 -0800
Message-ID: <20180217192215.28581-3-paul.burton@mips.com>
In-Reply-To: <20180217192215.28581-1-paul.burton@mips.com>
References: <20180217192215.28581-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] hw/mips/boston: Enable pch_gbe ethernet
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Paul Burton <paul.burton@mips.com>

Enable CONFIG_PCH_GBE_PCI in mips64el-softmmu.mak (currently the only
default config to enable Boston board support) and create the pch_gbe
device when using the Boston board.

This provides the board with an ethernet controller matching that found
on real Boston boards as part of the Intel EG20T Platform Controller
Hub, and allows standard Boston Linux kernels to have network access.

This is most easily tested using the downstream linux-mti kernels at the
moment, until MIPS support for the Linux pch_gbe driver is upstream. For
example, presuming U-Boot's mkimage tool is present in your $PATH, this
should be sufficient to boot Linux & see it obtain an IP address using
the emulated pch_gbe device:

  $ git clone git://git.linux-mips.org/pub/scm/linux-mti.git -b eng
  $ cd linux-mti
  $ make ARCH=mips 64r6el_defconfig
  $ make ARCH=mips CROSS_COMPILE=/path/to/compiler/bin/mips-linux-gnu-
  $ qemu-system-mips64el \
      -M boston -cpu I6400 \
      -kernel arch/mips/boot/vmlinux.gz.itb \
      -serial stdio -append "ip=dhcp"

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>

---

 default-configs/mips64el-softmmu.mak | 1 +
 hw/mips/boston.c                     | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
index c2ae313f47..85175ea223 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -13,3 +13,4 @@ CONFIG_VT82C686=y
 CONFIG_MIPS_BOSTON=y
 CONFIG_FITLOADER=y
 CONFIG_PCI_XILINX=y
+CONFIG_PCH_GBE_PCI=y
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index fb23161b33..408977bca1 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -31,6 +31,7 @@
 #include "hw/mips/cps.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci-host/xilinx-pcie.h"
+#include "net/net.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
@@ -430,7 +431,7 @@ static void boston_mach_init(MachineState *machine)
     MemoryRegion *flash, *ddr, *ddr_low_alias, *lcd, *platreg;
     MemoryRegion *sys_mem = get_system_memory();
     XilinxPCIEHost *pcie2;
-    PCIDevice *ahci;
+    PCIDevice *ahci, *eth;
     DriveInfo *hd[6];
     Chardev *chr;
     int fw_size, fit_err;
@@ -529,6 +530,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ahci_get_num_ports(ahci));
     ahci_ide_create_devs(ahci, hd);
 
+    eth = pci_create(&PCI_BRIDGE(&pcie2->root)->sec_bus,
+                     PCI_DEVFN(0, 1), "pch_gbe");
+    qdev_set_nic_properties(&eth->qdev, &nd_table[0]);
+    qdev_init_nofail(&eth->qdev);
+
     if (machine->firmware) {
         fw_size = load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * M_BYTE);
-- 
2.16.1
