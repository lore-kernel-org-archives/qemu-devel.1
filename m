Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B075C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5835B2087E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah3ygukF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5835B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb97-0001wL-GE
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyazx-0004hI-Mo
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyazv-00063L-Ae
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29674
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyazv-000635-0h
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580733518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5IlqUmZX5LS5DDn/gkpHkUkHf6FxQ4Y59lF6/1wwYk=;
 b=Ah3ygukFAWoq/47vpdAA8xq9KF3aj5w9SaTxJlyewNsEDb4fOOb009aRhQlTmP4+CJgs9C
 v0kqygKzw1w4qIUmV5yhByNH0uUcNog3OQBck7dzMTh3YNjJf5e9q8XFXl3u9UQiqfEozr
 r3uC13u/jHcUjpIxoW90odOJ1CT5B0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-CqQtvHHmNA6yfoHnHIoBww-1; Mon, 03 Feb 2020 07:38:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F16E6100550E;
 Mon,  3 Feb 2020 12:38:33 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F4DC61070;
 Mon,  3 Feb 2020 12:38:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/13] hw/*/Makefile.objs: Move many .o files to common-objs
Date: Mon,  3 Feb 2020 13:38:09 +0100
Message-Id: <20200203123811.8651-12-thuth@redhat.com>
In-Reply-To: <20200203123811.8651-1-thuth@redhat.com>
References: <20200203123811.8651-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: CqQtvHHmNA6yfoHnHIoBww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have many files that apparently do not depend on the target CPU
configuration, i.e. which can be put into common-obj-y instead of
obj-y. This way, the code can be shared for example between
qemu-system-arm and qemu-system-aarch64, or the various big and
little endian variants like qemu-system-sh4 and qemu-system-sh4eb,
so that we do not have to compile the code multiple times anymore.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200130133841.10779-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/adc/Makefile.objs     |  2 +-
 hw/block/Makefile.objs   |  2 +-
 hw/char/Makefile.objs    | 16 ++++++++--------
 hw/core/Makefile.objs    |  2 +-
 hw/display/Makefile.objs |  2 +-
 hw/dma/Makefile.objs     |  6 +++---
 hw/gpio/Makefile.objs    | 10 +++++-----
 hw/i2c/Makefile.objs     |  4 ++--
 hw/i2c/ppc4xx_i2c.c      |  1 -
 hw/input/Makefile.objs   |  8 ++++----
 hw/net/Makefile.objs     |  6 +++---
 hw/nvram/Makefile.objs   |  2 +-
 hw/pcmcia/Makefile.objs  |  2 +-
 hw/sd/Makefile.objs      | 10 +++++-----
 hw/ssi/Makefile.objs     |  4 ++--
 hw/usb/Makefile.objs     |  4 ++--
 16 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/hw/adc/Makefile.objs b/hw/adc/Makefile.objs
index 3f6dfdedae..2b9dc36c7f 100644
--- a/hw/adc/Makefile.objs
+++ b/hw/adc/Makefile.objs
@@ -1 +1 @@
-obj-$(CONFIG_STM32F2XX_ADC) +=3D stm32f2xx_adc.o
+common-obj-$(CONFIG_STM32F2XX_ADC) +=3D stm32f2xx_adc.o
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 28c2495a00..4b4a2b338d 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -10,7 +10,7 @@ common-obj-$(CONFIG_ONENAND) +=3D onenand.o
 common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
 common-obj-$(CONFIG_SWIM) +=3D swim.o
=20
-obj-$(CONFIG_SH4) +=3D tc58128.o
+common-obj-$(CONFIG_SH4) +=3D tc58128.o
=20
 obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk.o
 obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk.o
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 02d8a66925..9e9a6c1aff 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -13,14 +13,13 @@ common-obj-$(CONFIG_XILINX) +=3D xilinx_uartlite.o
 common-obj-$(CONFIG_XEN) +=3D xen_console.o
 common-obj-$(CONFIG_CADENCE) +=3D cadence_uart.o
=20
-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_uart.o
-obj-$(CONFIG_COLDFIRE) +=3D mcf_uart.o
-obj-$(CONFIG_OMAP) +=3D omap_uart.o
-obj-$(CONFIG_SH4) +=3D sh_serial.o
-obj-$(CONFIG_PSERIES) +=3D spapr_vty.o
-obj-$(CONFIG_DIGIC) +=3D digic-uart.o
-obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
-obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
+common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_uart.o
+common-obj-$(CONFIG_COLDFIRE) +=3D mcf_uart.o
+common-obj-$(CONFIG_OMAP) +=3D omap_uart.o
+common-obj-$(CONFIG_SH4) +=3D sh_serial.o
+common-obj-$(CONFIG_DIGIC) +=3D digic-uart.o
+common-obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
+common-obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
=20
 common-obj-$(CONFIG_CMSDK_APB_UART) +=3D cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
@@ -33,4 +32,5 @@ common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-uart.o
 common-obj-$(CONFIG_SCLPCONSOLE) +=3D sclpconsole.o sclpconsole-lm.o
=20
 obj-$(CONFIG_VIRTIO) +=3D virtio-serial-bus.o
+obj-$(CONFIG_PSERIES) +=3D spapr_vty.o
 obj-$(CONFIG_TERMINAL3270) +=3D terminal3270.o
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 9e41ec9a15..6215e7c208 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -19,8 +19,8 @@ common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
 common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
 common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
 common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o
+common-obj-$(CONFIG_SOFTMMU) +=3D numa.o
 obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
-obj-$(CONFIG_SOFTMMU) +=3D numa.o
=20
 common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) +=3D stream.o
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 5f03dfdcc4..77a7d622bd 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -24,7 +24,7 @@ common-obj-$(CONFIG_BOCHS_DISPLAY) +=3D bochs-display.o
 common-obj-$(CONFIG_BLIZZARD) +=3D blizzard.o
 common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_fimd.o
 common-obj-$(CONFIG_FRAMEBUFFER) +=3D framebuffer.o
-obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
+common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) +=3D tc6393xb.o
 common-obj-$(CONFIG_MACFB) +=3D macfb.o
=20
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index b672e7a522..f4b1cfe26d 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -8,9 +8,9 @@ common-obj-$(CONFIG_XILINX_AXI) +=3D xilinx_axidma.o
 common-obj-$(CONFIG_ZYNQ_DEVCFG) +=3D xlnx-zynq-devcfg.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_dma.o
 common-obj-$(CONFIG_STP2000) +=3D sparc32_dma.o
-obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx_dpdma.o
+common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx_dpdma.o
 common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zdma.o
=20
-obj-$(CONFIG_OMAP) +=3D omap_dma.o soc_dma.o
-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_dma.o
+common-obj-$(CONFIG_OMAP) +=3D omap_dma.o soc_dma.o
+common-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_dma.o
 common-obj-$(CONFIG_RASPI) +=3D bcm2835_dma.o
diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
index d305b3b24b..3cfc261f9b 100644
--- a/hw/gpio/Makefile.objs
+++ b/hw/gpio/Makefile.objs
@@ -5,8 +5,8 @@ common-obj-$(CONFIG_ZAURUS) +=3D zaurus.o
 common-obj-$(CONFIG_E500) +=3D mpc8xxx.o
 common-obj-$(CONFIG_GPIO_KEY) +=3D gpio_key.o
=20
-obj-$(CONFIG_OMAP) +=3D omap_gpio.o
-obj-$(CONFIG_IMX) +=3D imx_gpio.o
-obj-$(CONFIG_RASPI) +=3D bcm2835_gpio.o
-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_gpio.o
-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_gpio.o
+common-obj-$(CONFIG_OMAP) +=3D omap_gpio.o
+common-obj-$(CONFIG_IMX) +=3D imx_gpio.o
+common-obj-$(CONFIG_RASPI) +=3D bcm2835_gpio.o
+common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_gpio.o
+common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_gpio.o
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index d7073a401f..6ba976b257 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -9,5 +9,5 @@ common-obj-$(CONFIG_IMX_I2C) +=3D imx_i2c.o
 common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_i2c.o
 common-obj-$(CONFIG_NRF51_SOC) +=3D microbit_i2c.o
 common-obj-$(CONFIG_MPC_I2C) +=3D mpc_i2c.o
-obj-$(CONFIG_OMAP) +=3D omap_i2c.o
-obj-$(CONFIG_PPC4XX) +=3D ppc4xx_i2c.o
+common-obj-$(CONFIG_OMAP) +=3D omap_i2c.o
+common-obj-$(CONFIG_PPC4XX) +=3D ppc4xx_i2c.o
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
=20
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index f98f635685..abc1ff03c0 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -12,7 +12,7 @@ common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-hid.o
 common-obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host.o
 common-obj-$(CONFIG_VHOST_USER_INPUT) +=3D vhost-user-input.o
=20
-obj-$(CONFIG_MILKYMIST) +=3D milkymist-softusb.o
-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_keypad.o
-obj-$(CONFIG_TSC210X) +=3D tsc210x.o
-obj-$(CONFIG_LASIPS2) +=3D lasips2.o
+common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-softusb.o
+common-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_keypad.o
+common-obj-$(CONFIG_TSC210X) +=3D tsc210x.o
+common-obj-$(CONFIG_LASIPS2) +=3D lasips2.o
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 19f13e9fa5..991c46c773 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -34,8 +34,8 @@ common-obj-$(CONFIG_SUNHME) +=3D sunhme.o
 common-obj-$(CONFIG_FTGMAC100) +=3D ftgmac100.o
 common-obj-$(CONFIG_SUNGEM) +=3D sungem.o
=20
-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_eth.o
-obj-$(CONFIG_COLDFIRE) +=3D mcf_fec.o
+common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_eth.o
+common-obj-$(CONFIG_COLDFIRE) +=3D mcf_fec.o
 obj-$(CONFIG_MILKYMIST) +=3D milkymist-minimac2.o
 obj-$(CONFIG_PSERIES) +=3D spapr_llan.o
 obj-$(CONFIG_XILINX_ETHLITE) +=3D xilinx_ethlite.o
@@ -45,7 +45,7 @@ common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOS=
T_NET)) +=3D vhost_net.o
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET=
))) +=3D vhost_net-stub.o
 common-obj-$(CONFIG_ALL) +=3D vhost_net-stub.o
=20
-obj-$(CONFIG_ETSEC) +=3D fsl_etsec/etsec.o fsl_etsec/registers.o \
+common-obj-$(CONFIG_ETSEC) +=3D fsl_etsec/etsec.o fsl_etsec/registers.o \
 =09=09=09fsl_etsec/rings.o fsl_etsec/miim.o
=20
 common-obj-$(CONFIG_ROCKER) +=3D rocker/rocker.o rocker/rocker_fp.o \
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index 090df63fcd..f3ad921382 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -4,5 +4,5 @@ common-obj-$(CONFIG_AT24C) +=3D eeprom_at24c.o
 common-obj-y +=3D fw_cfg.o
 common-obj-$(CONFIG_CHRP_NVRAM) +=3D chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) +=3D mac_nvram.o
+common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_nvm.o
 obj-$(CONFIG_PSERIES) +=3D spapr_nvram.o
-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_nvm.o
diff --git a/hw/pcmcia/Makefile.objs b/hw/pcmcia/Makefile.objs
index 4eac060c93..02cd986a2c 100644
--- a/hw/pcmcia/Makefile.objs
+++ b/hw/pcmcia/Makefile.objs
@@ -1,2 +1,2 @@
 common-obj-y +=3D pcmcia.o
-obj-$(CONFIG_PXA2XX) +=3D pxa2xx.o
+common-obj-$(CONFIG_PXA2XX) +=3D pxa2xx.o
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index a884c238df..e371281ac4 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -4,8 +4,8 @@ common-obj-$(CONFIG_SD) +=3D sd.o core.o sdmmc-internal.o
 common-obj-$(CONFIG_SDHCI) +=3D sdhci.o
 common-obj-$(CONFIG_SDHCI_PCI) +=3D sdhci-pci.o
=20
-obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o
-obj-$(CONFIG_OMAP) +=3D omap_mmc.o
-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_mmci.o
-obj-$(CONFIG_RASPI) +=3D bcm2835_sdhost.o
-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_sdhci.o
+common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o
+common-obj-$(CONFIG_OMAP) +=3D omap_mmc.o
+common-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_mmci.o
+common-obj-$(CONFIG_RASPI) +=3D bcm2835_sdhost.o
+common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_sdhci.o
diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
index f5bcc65fe7..07a85f1967 100644
--- a/hw/ssi/Makefile.objs
+++ b/hw/ssi/Makefile.objs
@@ -6,5 +6,5 @@ common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_smc.o
 common-obj-$(CONFIG_STM32F2XX_SPI) +=3D stm32f2xx_spi.o
 common-obj-$(CONFIG_MSF2) +=3D mss-spi.o
=20
-obj-$(CONFIG_OMAP) +=3D omap_spi.o
-obj-$(CONFIG_IMX) +=3D imx_spi.o
+common-obj-$(CONFIG_OMAP) +=3D omap_spi.o
+common-obj-$(CONFIG_IMX) +=3D imx_spi.o
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 0052d49ce1..2b10868937 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -13,8 +13,8 @@ common-obj-$(CONFIG_USB_XHCI) +=3D hcd-xhci.o
 common-obj-$(CONFIG_USB_XHCI_NEC) +=3D hcd-xhci-nec.o
 common-obj-$(CONFIG_USB_MUSB) +=3D hcd-musb.o
=20
-obj-$(CONFIG_TUSB6010) +=3D tusb6010.o
-obj-$(CONFIG_IMX)      +=3D chipidea.o
+common-obj-$(CONFIG_TUSB6010) +=3D tusb6010.o
+common-obj-$(CONFIG_IMX)      +=3D chipidea.o
=20
 # emulated usb devices
 common-obj-$(CONFIG_USB) +=3D dev-hub.o
--=20
2.18.1


