Received: from eggs.gnu.org ([2001:4830:134:3::10]:48181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1czlua-00050b-2p
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 11:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1czluY-0004Hn-QV
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 11:16:24 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 16 Apr 2017 17:16:04 +0200
Message-Id: <20170416151604.22506-1-krzk@kernel.org>
Subject: [Qemu-devel] [RFC] hw/arm/exynos: Add generic SDHCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Exynos4210 has four SD/MMC controllers supporting:
 - SD Standard Host Specification Version 2.0,
 - MMC Specification Version 4.3,
 - SDIO Card Specification Version 2.0,
 - DMA and ADMA.

Add emulation of SDHCI devices which allows accessing storage through SD
cards. Differences from real hardware:
 - Devices are shipped with eMMC memory, not SD card.
 - The Exynos4210 SDHCI has few more registers, e.g. for
   controlling the clocks, additional status (0x80, 0x84, 0x8c). These
   are not implemented.

Testing on smdkc210 machine with "-drive file=FILE,if=sd,bus=0,index=2".

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Mostly it works:
[   11.763786] sdhci: Secure Digital Host Controller Interface driver
[   11.764593] sdhci: Copyright(c) Pierre Ossman
[   11.777295] s3c-sdhci 12530000.sdhci: clock source 2: mmc_busclk.2 (12000000 Hz)
[   11.976250] mmc0: SDHCI controller on samsung-hsmmc [12530000.sdhci] using ADMA
[   11.980283] Synopsys Designware Multimedia Card Interface Driver
[   12.086757] mmc0: new SDHC card at address 4567
[   12.151653] mmcblk0: mmc0:4567 QEMU! 4.00 GiB

... except that for guest, the storage starts from 0x50000. It just
skips first 0x50000 bytes thus the paritions (MBR) and initial data is
not visible.

I don't know what is the cause.

Any hints?

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/arm/exynos4210.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 0ec4250f0c05..d581f2217253 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -32,6 +32,7 @@
 #include "hw/arm/arm.h"
 #include "hw/loader.h"
 #include "hw/arm/exynos4210.h"
+#include "hw/sd/sd.h"
 #include "hw/usb/hcd-ehci.h"
 
 #define EXYNOS4210_CHIPID_ADDR         0x10000000
@@ -72,6 +73,13 @@
 #define EXYNOS4210_EXT_COMBINER_BASE_ADDR   0x10440000
 #define EXYNOS4210_INT_COMBINER_BASE_ADDR   0x10448000
 
+/* SD/MMC host controllers */
+#define EXYNOS4210_SDHCI_CAPABILITIES       0x05E80080
+#define EXYNOS4210_SDHCI_BASE_ADDR          0x12510000
+#define EXYNOS4210_SDHCI_ADDR(n)            (EXYNOS4210_SDHCI_BASE_ADDR + \
+                                                0x00010000 * (n))
+#define EXYNOS4210_SDHCI_NUMBER             4
+
 /* PMU SFR base address */
 #define EXYNOS4210_PMU_BASE_ADDR            0x10020000
 
@@ -386,6 +394,27 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem,
                            EXYNOS4210_UART3_FIFO_SIZE, 3, NULL,
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 3)]);
 
+    /*** SD/MMC host controllers ***/
+    for (n = 0; n < EXYNOS4210_SDHCI_NUMBER; n++) {
+        DeviceState *carddev;
+        DriveInfo *di;
+        BlockBackend *blk;
+
+        dev = qdev_create(NULL, "generic-sdhci");
+        qdev_prop_set_uint32(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITIES);
+        qdev_init_nofail(dev);
+
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, EXYNOS4210_SDHCI_ADDR(n));
+        sysbus_connect_irq(busdev, 0, s->irq_table[exynos4210_get_irq(29, n)]);
+
+        di = drive_get_next(IF_SD);
+        blk = di ? blk_by_legacy_dinfo(di) : NULL;
+        carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
+        qdev_prop_set_drive(carddev, "drive", blk, &error_abort);
+        qdev_prop_set_bit(carddev, "realized", true);
+    }
+
     /*** Display controller (FIMD) ***/
     sysbus_create_varargs("exynos4210.fimd", EXYNOS4210_FIMD0_BASE_ADDR,
             s->irq_table[exynos4210_get_irq(11, 0)],
-- 
2.9.3
