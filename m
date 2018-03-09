Received: from eggs.gnu.org ([2001:4830:134:3::10]:59533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmr-0008NR-7k
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmp-00063i-Ql
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:33 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmp-00060G-IP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:31 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmo-00075u-Cd
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:30 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:08 +0000
Message-Id: <20180309172622.4277-12-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/25] hw/arm: Use more CONFIG switches for the
 object files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

A lot of ARM object files are linked into the executable unconditionally,
even though we have corresponding CONFIG switches like CONFIG_PXA2XX or
CONFIG_OMAP. We should make sure to use these switches in the Makefile so
that the users can disable certain unwanted boards and devices more easily.
While we're at it, also add some new switches for the boards that do not
have a CONFIG option yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1520266949-29817-1-git-send-email-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Makefile.objs            | 30 +++++++++++++++++++++---------
 default-configs/arm-softmmu.mak |  7 +++++++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 48474c3394..2885e3e234 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,15 +1,27 @@
-obj-y += boot.o collie.o exynos4_boards.o gumstix.o highbank.o
-obj-$(CONFIG_DIGIC) += digic_boards.o
-obj-y += integratorcp.o mainstone.o musicpal.o nseries.o
-obj-y += omap_sx1.o palm.o realview.o spitz.o stellaris.o
-obj-y += tosa.o versatilepb.o vexpress.o virt.o xilinx_zynq.o z2.o
+obj-y += boot.o virt.o sysbus-fdt.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
-obj-y += netduino2.o
-obj-y += sysbus-fdt.o
+obj-$(CONFIG_DIGIC) += digic_boards.o
+obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
+obj-$(CONFIG_HIGHBANK) += highbank.o
+obj-$(CONFIG_INTEGRATOR) += integratorcp.o
+obj-$(CONFIG_MAINSTONE) += mainstone.o
+obj-$(CONFIG_MUSICPAL) += musicpal.o
+obj-$(CONFIG_NETDUINO2) += netduino2.o
+obj-$(CONFIG_NSERIES) += nseries.o
+obj-$(CONFIG_OMAP) += omap_sx1.o palm.o
+obj-$(CONFIG_PXA2XX) += gumstix.o spitz.o tosa.o z2.o
+obj-$(CONFIG_REALVIEW) += realview.o
+obj-$(CONFIG_STELLARIS) += stellaris.o
+obj-$(CONFIG_STRONGARM) += collie.o
+obj-$(CONFIG_VERSATILE) += vexpress.o versatilepb.o
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
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index a5c6b24ae6..dd29e741c2 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -47,6 +47,7 @@ CONFIG_A9MPCORE=y
 CONFIG_A15MPCORE=y
 
 CONFIG_ARM_V7M=y
+CONFIG_NETDUINO2=y
 
 CONFIG_ARM_GIC=y
 CONFIG_ARM_GIC_KVM=$(CONFIG_KVM)
@@ -109,6 +110,7 @@ CONFIG_TZ_PPC=y
 CONFIG_IOTKIT=y
 CONFIG_IOTKIT_SECCTL=y
 
+CONFIG_VERSATILE=y
 CONFIG_VERSATILE_PCI=y
 CONFIG_VERSATILE_I2C=y
 
@@ -117,6 +119,7 @@ CONFIG_VFIO_XGMAC=y
 CONFIG_VFIO_AMD_XGBE=y
 
 CONFIG_SDHCI=y
+CONFIG_INTEGRATOR=y
 CONFIG_INTEGRATOR_DEBUG=y
 
 CONFIG_ALLWINNER_A10_PIT=y
@@ -142,3 +145,7 @@ CONFIG_MSF2=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_XILINX_AXI=y
 CONFIG_PCI_DESIGNWARE=y
+
+CONFIG_STRONGARM=y
+CONFIG_HIGHBANK=y
+CONFIG_MUSICPAL=y
-- 
2.16.2
