Received: from eggs.gnu.org ([2001:4830:134:3::10]:38528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1d3nNc-00049Z-WC
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 13:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1d3nNc-0005Fn-8L
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 13:39:01 -0400
From: Wei Huang <wei@redhat.com>
Date: Thu, 27 Apr 2017 12:38:46 -0500
Message-Id: <1493314727-6951-2-git-send-email-wei@redhat.com>
In-Reply-To: <1493314727-6951-1-git-send-email-wei@redhat.com>
References: <1493314727-6951-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] armv7m: Make armv7m SoC compilation
 dependent on CONFIG_ARM_V7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

In current QEMU, when CONFIG_ARM_V7M is not configured, armv7m_nvic.c
and armv7m_systick.c won't be compiled. This causes dependency issues
for armv7m SoC because armv7m uses the device "armv7m_nvic". This patch
makes the compilation of armv7m.c and other v7m SoC dependent on
CONFIG_ARM_V7M.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 default-configs/arm-softmmu.mak | 2 --
 hw/arm/Makefile.objs            | 7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 78d7af0..a89d77d 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -15,7 +15,6 @@ CONFIG_TWL92230=y
 CONFIG_TSC2005=y
 CONFIG_LM832X=y
 CONFIG_TMP105=y
-CONFIG_STELLARIS=y
 CONFIG_STELLARIS_INPUT=y
 CONFIG_STELLARIS_ENET=y
 CONFIG_SSD0303=y
@@ -92,7 +91,6 @@ CONFIG_STM32F2XX_USART=y
 CONFIG_STM32F2XX_SYSCFG=y
 CONFIG_STM32F2XX_ADC=y
 CONFIG_STM32F2XX_SPI=y
-CONFIG_STM32F205_SOC=y
 
 CONFIG_VERSATILE_PCI=y
 CONFIG_VERSATILE_I2C=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 4c5c4ee..e3c5fc5 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,18 +1,17 @@
 obj-y += boot.o collie.o exynos4_boards.o gumstix.o highbank.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-y += integratorcp.o mainstone.o musicpal.o nseries.o
-obj-y += omap_sx1.o palm.o realview.o spitz.o stellaris.o
+obj-y += omap_sx1.o palm.o realview.o spitz.o
 obj-y += tosa.o versatilepb.o vexpress.o virt.o xilinx_zynq.o z2.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
-obj-y += netduino2.o
 obj-y += sysbus-fdt.o
 
-obj-y += armv7m.o exynos4210.o pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
+obj-y += exynos4210.o pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
 obj-$(CONFIG_DIGIC) += digic.o
+obj-$(CONFIG_ARM_V7M) += armv7m.o netduino2.o stellaris.o stm32f205_soc.o
 obj-y += omap1.o omap2.o strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
-obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
 obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp.o xlnx-ep108.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
-- 
1.8.3.1
