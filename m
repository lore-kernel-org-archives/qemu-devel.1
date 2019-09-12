Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F66C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE1C2081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE1C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8OsQ-0000hf-EK
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 09:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i8Orh-00009R-7x
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i8Ord-00080c-T8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i8Ord-00080B-LX; Thu, 12 Sep 2019 09:10:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8982B2A09AC;
 Thu, 12 Sep 2019 13:10:20 +0000 (UTC)
Received: from thuth.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C03B919C78;
 Thu, 12 Sep 2019 13:10:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 15:10:11 +0200
Message-Id: <20190912131011.6255-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 12 Sep 2019 13:10:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] hw/*/Makefile.objs: Move many .o files to
 common-objs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have many files that apparently do not depend on the target CPU
configuration, i.e. which can be put into common-obj-y instead of
obj-y. This way, the code can be shared for example between
qemu-system-arm and qemu-system-aarch64, or the various big and
little endian variants like qemu-system-sh4 and qemu-system-sh4eb,
so that we do not have to compile the code multiple times anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/adc/Makefile.objs     |  2 +-
 hw/block/Makefile.objs   |  2 +-
 hw/char/Makefile.objs    | 16 ++++++++--------
 hw/core/Makefile.objs    |  2 +-
 hw/display/Makefile.objs |  2 +-
 hw/dma/Makefile.objs     |  6 +++---
 hw/gpio/Makefile.objs    |  8 ++++----
 hw/i2c/Makefile.objs     |  4 ++--
 hw/i2c/ppc4xx_i2c.c      |  1 -
 hw/input/Makefile.objs   |  6 +++---
 hw/net/Makefile.objs     |  6 +++---
 hw/nvram/Makefile.objs   |  2 +-
 hw/pcmcia/Makefile.objs  |  2 +-
 hw/sd/Makefile.objs      |  8 ++++----
 hw/ssi/Makefile.objs     |  4 ++--
 hw/timer/Makefile.objs   | 22 +++++++++++-----------
 hw/usb/Makefile.objs     |  4 ++--
 17 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/hw/adc/Makefile.objs b/hw/adc/Makefile.objs
index 3f6dfdedae..2b9dc36c7f 100644
--- a/hw/adc/Makefile.objs
+++ b/hw/adc/Makefile.objs
@@ -1 +1 @@
-obj-$(CONFIG_STM32F2XX_ADC) += stm32f2xx_adc.o
+common-obj-$(CONFIG_STM32F2XX_ADC) += stm32f2xx_adc.o
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index f5f643f0cc..64c1f315c9 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -9,7 +9,7 @@ common-obj-$(CONFIG_ECC) += ecc.o
 common-obj-$(CONFIG_ONENAND) += onenand.o
 common-obj-$(CONFIG_NVME_PCI) += nvme.o
 
-obj-$(CONFIG_SH4) += tc58128.o
+common-obj-$(CONFIG_SH4) += tc58128.o
 
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 02d8a66925..9e9a6c1aff 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -13,14 +13,13 @@ common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
 common-obj-$(CONFIG_XEN) += xen_console.o
 common-obj-$(CONFIG_CADENCE) += cadence_uart.o
 
-obj-$(CONFIG_EXYNOS4) += exynos4210_uart.o
-obj-$(CONFIG_COLDFIRE) += mcf_uart.o
-obj-$(CONFIG_OMAP) += omap_uart.o
-obj-$(CONFIG_SH4) += sh_serial.o
-obj-$(CONFIG_PSERIES) += spapr_vty.o
-obj-$(CONFIG_DIGIC) += digic-uart.o
-obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
-obj-$(CONFIG_RASPI) += bcm2835_aux.o
+common-obj-$(CONFIG_EXYNOS4) += exynos4210_uart.o
+common-obj-$(CONFIG_COLDFIRE) += mcf_uart.o
+common-obj-$(CONFIG_OMAP) += omap_uart.o
+common-obj-$(CONFIG_SH4) += sh_serial.o
+common-obj-$(CONFIG_DIGIC) += digic-uart.o
+common-obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
+common-obj-$(CONFIG_RASPI) += bcm2835_aux.o
 
 common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
@@ -33,4 +32,5 @@ common-obj-$(CONFIG_MILKYMIST) += milkymist-uart.o
 common-obj-$(CONFIG_SCLPCONSOLE) += sclpconsole.o sclpconsole-lm.o
 
 obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o
+obj-$(CONFIG_PSERIES) += spapr_vty.o
 obj-$(CONFIG_TERMINAL3270) += terminal3270.o
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index fd0550d1d9..c94886cd74 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -26,5 +26,5 @@ common-obj-$(CONFIG_GENERIC_LOADER) += generic-loader.o
 common-obj-$(CONFIG_SOFTMMU) += null-machine.o
 
 obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
-obj-$(CONFIG_SOFTMMU) += numa.o
+common-obj-$(CONFIG_SOFTMMU) += numa.o
 common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 5a4066383b..a56ea95d46 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -24,7 +24,7 @@ common-obj-$(CONFIG_BOCHS_DISPLAY) += bochs-display.o
 common-obj-$(CONFIG_BLIZZARD) += blizzard.o
 common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o
 common-obj-$(CONFIG_FRAMEBUFFER) += framebuffer.o
-obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
+common-obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) += tc6393xb.o
 
 obj-$(CONFIG_MILKYMIST_TMU2) += milkymist-tmu2.o
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index b672e7a522..f4b1cfe26d 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -8,9 +8,9 @@ common-obj-$(CONFIG_XILINX_AXI) += xilinx_axidma.o
 common-obj-$(CONFIG_ZYNQ_DEVCFG) += xlnx-zynq-devcfg.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_dma.o
 common-obj-$(CONFIG_STP2000) += sparc32_dma.o
-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dpdma.o
+common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dpdma.o
 common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zdma.o
 
-obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
+common-obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
+common-obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
 common-obj-$(CONFIG_RASPI) += bcm2835_dma.o
diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
index e5da0cb54f..afdb4c3a06 100644
--- a/hw/gpio/Makefile.objs
+++ b/hw/gpio/Makefile.objs
@@ -5,7 +5,7 @@ common-obj-$(CONFIG_ZAURUS) += zaurus.o
 common-obj-$(CONFIG_E500) += mpc8xxx.o
 common-obj-$(CONFIG_GPIO_KEY) += gpio_key.o
 
-obj-$(CONFIG_OMAP) += omap_gpio.o
-obj-$(CONFIG_IMX) += imx_gpio.o
-obj-$(CONFIG_RASPI) += bcm2835_gpio.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_gpio.o
+common-obj-$(CONFIG_OMAP) += omap_gpio.o
+common-obj-$(CONFIG_IMX) += imx_gpio.o
+common-obj-$(CONFIG_RASPI) += bcm2835_gpio.o
+common-obj-$(CONFIG_NRF51_SOC) += nrf51_gpio.o
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index d7073a401f..6ba976b257 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -9,5 +9,5 @@ common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_i2c.o
 common-obj-$(CONFIG_NRF51_SOC) += microbit_i2c.o
 common-obj-$(CONFIG_MPC_I2C) += mpc_i2c.o
-obj-$(CONFIG_OMAP) += omap_i2c.o
-obj-$(CONFIG_PPC4XX) += ppc4xx_i2c.o
+common-obj-$(CONFIG_OMAP) += omap_i2c.o
+common-obj-$(CONFIG_PPC4XX) += ppc4xx_i2c.o
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index 3f015a1581..c0a8e04567 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -27,7 +27,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "cpu.h"
 #include "hw/i2c/ppc4xx_i2c.h"
 #include "hw/irq.h"
 
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index a1bc502ed0..7a4abb0aa1 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -12,6 +12,6 @@ common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-hid.o
 common-obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host.o
 common-obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input.o
 
-obj-$(CONFIG_MILKYMIST) += milkymist-softusb.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_keypad.o
-obj-$(CONFIG_TSC210X) += tsc210x.o
+common-obj-$(CONFIG_MILKYMIST) += milkymist-softusb.o
+common-obj-$(CONFIG_PXA2XX) += pxa2xx_keypad.o
+common-obj-$(CONFIG_TSC210X) += tsc210x.o
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 9904273b06..ef57e257ab 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -31,8 +31,8 @@ common-obj-$(CONFIG_SUNHME) += sunhme.o
 common-obj-$(CONFIG_FTGMAC100) += ftgmac100.o
 common-obj-$(CONFIG_SUNGEM) += sungem.o
 
-obj-$(CONFIG_ETRAXFS) += etraxfs_eth.o
-obj-$(CONFIG_COLDFIRE) += mcf_fec.o
+common-obj-$(CONFIG_ETRAXFS) += etraxfs_eth.o
+common-obj-$(CONFIG_COLDFIRE) += mcf_fec.o
 obj-$(CONFIG_MILKYMIST) += milkymist-minimac2.o
 obj-$(CONFIG_PSERIES) += spapr_llan.o
 obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
@@ -42,7 +42,7 @@ common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET)) += vhost_net.o
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET))) += vhost_net-stub.o
 common-obj-$(CONFIG_ALL) += vhost_net-stub.o
 
-obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
+common-obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
 			fsl_etsec/rings.o fsl_etsec/miim.o
 
 common-obj-$(CONFIG_ROCKER) += rocker/rocker.o rocker/rocker_fp.o \
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index 26f7b4ca35..f22229c244 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -4,5 +4,5 @@ common-obj-$(CONFIG_AT24C) += eeprom_at24c.o
 common-obj-y += fw_cfg.o
 common-obj-y += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
+common-obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
 obj-$(CONFIG_PSERIES) += spapr_nvram.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
diff --git a/hw/pcmcia/Makefile.objs b/hw/pcmcia/Makefile.objs
index 4eac060c93..02cd986a2c 100644
--- a/hw/pcmcia/Makefile.objs
+++ b/hw/pcmcia/Makefile.objs
@@ -1,2 +1,2 @@
 common-obj-y += pcmcia.o
-obj-$(CONFIG_PXA2XX) += pxa2xx.o
+common-obj-$(CONFIG_PXA2XX) += pxa2xx.o
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index 06657279d1..42e79c2afd 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -4,7 +4,7 @@ common-obj-$(CONFIG_SD) += sd.o core.o sdmmc-internal.o
 common-obj-$(CONFIG_SDHCI) += sdhci.o
 common-obj-$(CONFIG_SDHCI_PCI) += sdhci-pci.o
 
-obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
-obj-$(CONFIG_OMAP) += omap_mmc.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
-obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
+common-obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
+common-obj-$(CONFIG_OMAP) += omap_mmc.o
+common-obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
+common-obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
index f5bcc65fe7..07a85f1967 100644
--- a/hw/ssi/Makefile.objs
+++ b/hw/ssi/Makefile.objs
@@ -6,5 +6,5 @@ common-obj-$(CONFIG_ASPEED_SOC) += aspeed_smc.o
 common-obj-$(CONFIG_STM32F2XX_SPI) += stm32f2xx_spi.o
 common-obj-$(CONFIG_MSF2) += mss-spi.o
 
-obj-$(CONFIG_OMAP) += omap_spi.o
-obj-$(CONFIG_IMX) += imx_spi.o
+common-obj-$(CONFIG_OMAP) += omap_spi.o
+common-obj-$(CONFIG_IMX) += imx_spi.o
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 123d92c969..f407523aa4 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -25,20 +25,20 @@ common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
 common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
 
-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
-obj-$(CONFIG_OMAP) += omap_gptimer.o
-obj-$(CONFIG_OMAP) += omap_synctimer.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
-obj-$(CONFIG_SH4) += sh_timer.o
-obj-$(CONFIG_DIGIC) += digic-timer.o
-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
+common-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
+common-obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
+common-obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
+common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
+common-obj-$(CONFIG_OMAP) += omap_gptimer.o
+common-obj-$(CONFIG_OMAP) += omap_synctimer.o
+common-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
+common-obj-$(CONFIG_SH4) += sh_timer.o
+common-obj-$(CONFIG_DIGIC) += digic-timer.o
+common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
 
 obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
 
-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
+common-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
 
 common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o aspeed_rtc.o
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 303ac084a0..ae43ccf263 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -13,8 +13,8 @@ common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
 common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
 
-obj-$(CONFIG_TUSB6010) += tusb6010.o
-obj-$(CONFIG_IMX)      += chipidea.o
+common-obj-$(CONFIG_TUSB6010) += tusb6010.o
+common-obj-$(CONFIG_IMX)      += chipidea.o
 
 # emulated usb devices
 common-obj-$(CONFIG_USB) += dev-hub.o
-- 
2.18.1


