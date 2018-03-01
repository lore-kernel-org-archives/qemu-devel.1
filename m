Received: from eggs.gnu.org ([2001:4830:134:3::10]:48424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1erH2t-0007e6-Vv
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 00:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1erH2t-0004FZ-0x
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 00:46:24 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  1 Mar 2018 06:46:08 +0100
Message-Id: <1519883168-22092-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm: Use more CONFIG switches to decide
 which object files should be linked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

A lot of ARM object files are linked into the executable unconditionally,
even though we have corresponding CONFIG switches like CONFIG_PXA2XX or
CONFIG_OMAP. We should make sure to use these switches in the Makefile so
that the users can disable certain unwanted boards and devices more easily.
Also introduce the new switch CONFIG_STRONGARM to be able to disable the
"Collie" machine if it is not wanted.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak |  2 ++
 hw/arm/Makefile.objs            | 26 +++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index ca34cf4..43f382a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -133,3 +133,5 @@ CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_XILINX_AXI=y
+
+CONFIG_STRONGARM=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 1c896ba..5e1e0a9 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,15 +1,23 @@
-obj-y += boot.o collie.o exynos4_boards.o gumstix.o highbank.o
-obj-$(CONFIG_DIGIC) += digic_boards.o
-obj-y += integratorcp.o mainstone.o musicpal.o nseries.o
-obj-y += omap_sx1.o palm.o realview.o spitz.o stellaris.o
-obj-y += tosa.o versatilepb.o vexpress.o virt.o xilinx_zynq.o z2.o
+obj-y += boot.o virt.o sysbus-fdt.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
-obj-y += netduino2.o
-obj-y += sysbus-fdt.o
+obj-$(CONFIG_ARM_V7M) += highbank.o netduino2.o vexpress.o
+obj-$(CONFIG_ASPEED_SOC) += integratorcp.o musicpal.o versatilepb.o
+obj-$(CONFIG_DIGIC) += digic_boards.o
+obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
+obj-$(CONFIG_NSERIES) += nseries.o
+obj-$(CONFIG_OMAP) += omap_sx1.o palm.o
+obj-$(CONFIG_PXA2XX) += gumstix.o spitz.o mainstone.o tosa.o z2.o
+obj-$(CONFIG_REALVIEW) += realview.o
+obj-$(CONFIG_STELLARIS) += stellaris.o
+obj-$(CONFIG_STRONGARM) += collie.o
+obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
 
-obj-y += armv7m.o exynos4210.o pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
+obj-$(CONFIG_ARM_V7M) += armv7m.o
+obj-$(CONFIG_EXYNOS4) += exynos4210.o
+obj-$(CONFIG_PXA2XX) += pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
 obj-$(CONFIG_DIGIC) += digic.o
-obj-y += omap1.o omap2.o strongarm.o
+obj-$(CONFIG_OMAP) += omap1.o omap2.o
+obj-$(CONFIG_STRONGARM) += strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
-- 
1.8.3.1
