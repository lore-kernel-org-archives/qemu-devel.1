Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8132C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5070321848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5070321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FTi-0002h1-25
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPa-0007UF-AW
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPQ-00029u-4F
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:39:50 -0400
Received: from nsstlmta07p.bpe.bigpond.com ([203.38.21.7]:46676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i1FPO-00027w-D7; Fri, 23 Aug 2019 15:39:40 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep07p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823193932.BBUI4111.nsstlfep07p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 05:39:32 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: 
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920C8EBD6D; Sat, 24 Aug 2019 05:39:30 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 05:42:41 +1000
Message-Id: <a04a32cf5bc28bf5682a0c82acc3f7b4a826cba2.1566588034.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566588033.git.tony.nguyen@bt.com>
References: <cover.1566588033.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.7
Subject: [Qemu-devel] [PATCH 2/9] exec: Replace DEVICE_NATIVE_ENDIAN with
 MO_TE
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Paul Burton <pburton@wavecomp.com>, Marek Vasut <marex@denx.de>,
 Rob Herring <robh@kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Alberto Garcia <berto@igalia.com>, Jia Liu <proljc@gmail.com>,
 qemu-block@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Jiri Slaby <jslaby@suse.cz>, Magnus Damm <magnus.damm@gmail.com>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Tony Nguyen <tony.nguyen@bt.com>,
 qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Chris Wulff <crwulff@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>,
 Paul Durrant <paul.durrant@citrix.com>, qemu-ppc@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify endianness comparisons with consistent use of the more
expressive MemOp.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 exec.c                         |  8 +++----
 hw/adc/stm32f2xx_adc.c         |  2 +-
 hw/arm/allwinner-a10.c         |  2 +-
 hw/arm/armv7m.c                |  2 +-
 hw/arm/aspeed.c                |  2 +-
 hw/arm/exynos4210.c            |  2 +-
 hw/arm/highbank.c              |  2 +-
 hw/arm/integratorcp.c          |  6 +++---
 hw/arm/kzm.c                   |  2 +-
 hw/arm/msf2-soc.c              |  2 +-
 hw/arm/musicpal.c              | 20 +++++++++---------
 hw/arm/omap1.c                 | 38 +++++++++++++++++-----------------
 hw/arm/omap2.c                 | 10 ++++-----
 hw/arm/omap_sx1.c              |  2 +-
 hw/arm/palm.c                  |  2 +-
 hw/arm/pxa2xx.c                | 20 +++++++++---------
 hw/arm/pxa2xx_gpio.c           |  2 +-
 hw/arm/pxa2xx_pic.c            |  2 +-
 hw/arm/spitz.c                 |  2 +-
 hw/arm/stellaris.c             |  8 +++----
 hw/arm/strongarm.c             | 12 +++++------
 hw/arm/versatilepb.c           |  2 +-
 hw/audio/intel-hda.c           |  2 +-
 hw/block/fdc.c                 |  4 ++--
 hw/block/pflash_cfi01.c        |  2 +-
 hw/block/pflash_cfi02.c        |  2 +-
 hw/char/bcm2835_aux.c          |  2 +-
 hw/char/digic-uart.c           |  2 +-
 hw/char/exynos4210_uart.c      |  2 +-
 hw/char/mcf_uart.c             |  2 +-
 hw/char/omap_uart.c            |  6 +++---
 hw/char/parallel.c             |  2 +-
 hw/char/sh_serial.c            |  2 +-
 hw/char/stm32f2xx_usart.c      |  2 +-
 hw/char/xilinx_uartlite.c      |  2 +-
 hw/core/empty_slot.c           |  2 +-
 hw/cris/axis_dev88.c           |  4 ++--
 hw/display/bcm2835_fb.c        |  2 +-
 hw/display/cg3.c               |  2 +-
 hw/display/exynos4210_fimd.c   |  2 +-
 hw/display/jazz_led.c          |  2 +-
 hw/display/milkymist-tmu2.c    |  2 +-
 hw/display/milkymist-vgafb.c   |  2 +-
 hw/display/omap_dss.c          | 10 ++++-----
 hw/display/omap_lcdc.c         |  2 +-
 hw/display/pxa2xx_lcd.c        |  2 +-
 hw/display/tcx.c               | 14 ++++++-------
 hw/display/vga-isa-mm.c        |  2 +-
 hw/display/xlnx_dp.c           |  8 +++----
 hw/dma/i8257.c                 |  4 ++--
 hw/dma/omap_dma.c              |  4 ++--
 hw/dma/pxa2xx_dma.c            |  2 +-
 hw/dma/rc4030.c                |  4 ++--
 hw/dma/xilinx_axidma.c         |  2 +-
 hw/dma/xlnx_dpdma.c            |  2 +-
 hw/gpio/bcm2835_gpio.c         |  2 +-
 hw/gpio/imx_gpio.c             |  2 +-
 hw/gpio/omap_gpio.c            |  6 +++---
 hw/gpio/puv3_gpio.c            |  2 +-
 hw/i2c/exynos4210_i2c.c        |  2 +-
 hw/i2c/omap_i2c.c              |  2 +-
 hw/i2c/ppc4xx_i2c.c            |  2 +-
 hw/i386/kvm/apic.c             |  2 +-
 hw/i386/kvmvapic.c             |  2 +-
 hw/i386/pc.c                   |  4 ++--
 hw/i386/xen/xen_apic.c         |  2 +-
 hw/i386/xen/xen_platform.c     |  2 +-
 hw/input/milkymist-softusb.c   |  2 +-
 hw/input/pckbd.c               |  2 +-
 hw/input/pxa2xx_keypad.c       |  2 +-
 hw/intc/allwinner-a10-pic.c    |  2 +-
 hw/intc/apic.c                 |  2 +-
 hw/intc/arm_gicv3_its_common.c |  2 +-
 hw/intc/armv7m_nvic.c          |  6 +++---
 hw/intc/bcm2835_ic.c           |  2 +-
 hw/intc/bcm2836_control.c      |  2 +-
 hw/intc/exynos4210_combiner.c  |  2 +-
 hw/intc/grlib_irqmp.c          |  2 +-
 hw/intc/ioapic.c               |  2 +-
 hw/intc/mips_gic.c             |  2 +-
 hw/intc/omap_intc.c            |  4 ++--
 hw/intc/ompic.c                |  2 +-
 hw/intc/sh_intc.c              |  2 +-
 hw/intc/slavio_intctl.c        |  4 ++--
 hw/intc/xilinx_intc.c          |  2 +-
 hw/ipack/tpci200.c             | 10 ++++-----
 hw/m68k/mcf5206.c              |  2 +-
 hw/m68k/mcf5208.c              |  4 ++--
 hw/m68k/mcf_intc.c             |  2 +-
 hw/mips/boston.c               |  6 +++---
 hw/mips/gt64xxx_pci.c          |  2 +-
 hw/mips/mips_jazz.c            |  8 +++----
 hw/mips/mips_malta.c           |  4 ++--
 hw/mips/mips_r4k.c             |  2 +-
 hw/misc/arm_integrator_debug.c |  2 +-
 hw/misc/arm_sysctl.c           |  2 +-
 hw/misc/aspeed_xdma.c          |  2 +-
 hw/misc/bcm2835_mbox.c         |  2 +-
 hw/misc/bcm2835_property.c     |  2 +-
 hw/misc/bcm2835_rng.c          |  2 +-
 hw/misc/eccmemctl.c            |  4 ++--
 hw/misc/edu.c                  |  2 +-
 hw/misc/exynos4210_clk.c       |  2 +-
 hw/misc/exynos4210_pmu.c       |  2 +-
 hw/misc/exynos4210_rng.c       |  2 +-
 hw/misc/imx25_ccm.c            |  2 +-
 hw/misc/imx2_wdt.c             |  2 +-
 hw/misc/imx31_ccm.c            |  2 +-
 hw/misc/imx6_ccm.c             |  4 ++--
 hw/misc/imx6_src.c             |  2 +-
 hw/misc/imx6ul_ccm.c           |  4 ++--
 hw/misc/imx7_ccm.c             |  4 ++--
 hw/misc/imx7_gpr.c             |  2 +-
 hw/misc/imx7_snvs.c            |  2 +-
 hw/misc/ivshmem.c              |  2 +-
 hw/misc/milkymist-hpdmc.c      |  2 +-
 hw/misc/milkymist-pfpu.c       |  2 +-
 hw/misc/mips_cmgcr.c           |  2 +-
 hw/misc/mips_cpc.c             |  2 +-
 hw/misc/mips_itu.c             |  4 ++--
 hw/misc/mos6522.c              |  2 +-
 hw/misc/msf2-sysreg.c          |  2 +-
 hw/misc/mst_fpga.c             |  2 +-
 hw/misc/omap_gpmc.c            |  6 +++---
 hw/misc/omap_l4.c              |  2 +-
 hw/misc/omap_sdrc.c            |  2 +-
 hw/misc/omap_tap.c             |  2 +-
 hw/misc/slavio_misc.c          | 16 +++++++-------
 hw/misc/stm32f2xx_syscfg.c     |  2 +-
 hw/misc/unimp.c                |  2 +-
 hw/misc/zynq-xadc.c            |  2 +-
 hw/misc/zynq_slcr.c            |  2 +-
 hw/net/dp8393x.c               |  2 +-
 hw/net/fsl_etsec/etsec.c       |  2 +-
 hw/net/mcf_fec.c               |  2 +-
 hw/net/milkymist-minimac2.c    |  2 +-
 hw/net/xilinx_ethlite.c        |  2 +-
 hw/nios2/10m50_devboard.c      |  2 +-
 hw/openrisc/openrisc_sim.c     |  2 +-
 hw/pci-host/bonito.c           | 10 ++++-----
 hw/pcmcia/pxa2xx.c             |  6 +++---
 hw/ppc/ppc405_boards.c         |  2 +-
 hw/ppc/ppc405_uc.c             |  4 ++--
 hw/riscv/sifive_prci.c         |  2 +-
 hw/riscv/sifive_test.c         |  2 +-
 hw/riscv/sifive_uart.c         |  2 +-
 hw/scsi/esp.c                  |  2 +-
 hw/sd/bcm2835_sdhost.c         |  2 +-
 hw/sd/milkymist-memcard.c      |  2 +-
 hw/sd/omap_mmc.c               |  2 +-
 hw/sd/pxa2xx_mmci.c            |  2 +-
 hw/sh4/r2d.c                   |  2 +-
 hw/sh4/sh7750.c                |  4 ++--
 hw/sh4/sh_pci.c                |  2 +-
 hw/sparc/sun4m_iommu.c         |  2 +-
 hw/sparc64/sun4u.c             |  2 +-
 hw/ssi/imx_spi.c               |  2 +-
 hw/ssi/omap_spi.c              |  2 +-
 hw/ssi/xilinx_spi.c            |  2 +-
 hw/timer/allwinner-a10-pit.c   |  2 +-
 hw/timer/altera_timer.c        |  2 +-
 hw/timer/digic-timer.c         |  2 +-
 hw/timer/exynos4210_mct.c      |  2 +-
 hw/timer/exynos4210_pwm.c      |  2 +-
 hw/timer/exynos4210_rtc.c      |  2 +-
 hw/timer/omap_gptimer.c        |  2 +-
 hw/timer/omap_synctimer.c      |  2 +-
 hw/timer/puv3_ost.c            |  2 +-
 hw/timer/pxa2xx_timer.c        |  2 +-
 hw/timer/sh_timer.c            |  2 +-
 hw/timer/slavio_timer.c        |  2 +-
 hw/timer/xilinx_timer.c        |  2 +-
 hw/usb/chipidea.c              |  4 ++--
 hw/usb/tusb6010.c              |  2 +-
 hw/virtio/virtio-mmio.c        |  2 +-
 hw/xen/xen_pt.c                |  2 +-
 hw/xen/xen_pt_msi.c            |  2 +-
 hw/xtensa/mx_pic.c             |  2 +-
 hw/xtensa/xtfpga.c             |  6 +++---
 ioport.c                       |  2 +-
 memory.c                       |  4 ++--
 memory_ldst.inc.c              | 12 +++++------
 182 files changed, 304 insertions(+), 304 deletions(-)

diff --git a/exec.c b/exec.c
index b3c38be5df..05717a3b40 100644
--- a/exec.c
+++ b/exec.c
@@ -2797,7 +2797,7 @@ static bool notdirty_mem_accepts(void *opaque, hwaddr addr,
 static const MemoryRegionOps notdirty_mem_ops = {
     .write = notdirty_mem_write,
     .valid.accepts = notdirty_mem_accepts,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
@@ -2926,7 +2926,7 @@ static MemTxResult watch_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps watch_mem_ops = {
     .read_with_attrs = watch_mem_read,
     .write_with_attrs = watch_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
@@ -3002,7 +3002,7 @@ static const MemoryRegionOps subpage_ops = {
     .valid.min_access_size = 1,
     .valid.max_access_size = 8,
     .valid.accepts = subpage_accepts,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static int subpage_register (subpage_t *mmio, uint32_t start, uint32_t end,
@@ -3077,7 +3077,7 @@ static bool readonly_mem_accepts(void *opaque, hwaddr addr,
 static const MemoryRegionOps readonly_mem_ops = {
     .write = readonly_mem_write,
     .valid.accepts = readonly_mem_accepts,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index 4f9d485ecf..598687aa60 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -245,7 +245,7 @@ static void stm32f2xx_adc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps stm32f2xx_adc_ops = {
     .read = stm32f2xx_adc_read,
     .write = stm32f2xx_adc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_stm32f2xx_adc = {
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 73810a4440..d326dc7fdf 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -116,7 +116,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 
     /* FIXME use a qdev chardev prop instead of serial_hd() */
     serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2, s->irq[1],
-                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                   115200, serial_hd(0), MO_TE);
 }
 
 static void aw_a10_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7a3c48f002..0700cbd654 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -88,7 +88,7 @@ static MemTxResult bitband_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps bitband_ops = {
     .read_with_attrs = bitband_read,
     .write_with_attrs = bitband_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl.min_access_size = 1,
     .impl.max_access_size = 4,
     .valid.min_access_size = 1,
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 7a2e885e0b..481e2ab310 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -106,7 +106,7 @@ static void max_ram_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps max_ram_ops = {
     .read = max_ram_read,
     .write = max_ram_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 #define FIRMWARE_ADDR 0x0
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index a9f8a5c868..17ad052c2d 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -121,7 +121,7 @@ static void exynos4210_chipid_and_omr_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps exynos4210_chipid_and_omr_ops = {
     .read = exynos4210_chipid_and_omr_read,
     .write = exynos4210_chipid_and_omr_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .max_access_size = 1,
     }
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 362e5ba044..93a730813b 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -150,7 +150,7 @@ static uint64_t hb_regs_read(void *opaque, hwaddr offset,
 static const MemoryRegionOps hb_mem_ops = {
     .read = hb_regs_read,
     .write = hb_regs_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 #define TYPE_HIGHBANK_REGISTERS "highbank-regs"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 200568b42a..d90fe462ee 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -263,7 +263,7 @@ static void integratorcm_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps integratorcm_ops = {
     .read = integratorcm_read,
     .write = integratorcm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void integratorcm_init(Object *obj)
@@ -439,7 +439,7 @@ static void icp_pic_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps icp_pic_ops = {
     .read = icp_pic_read,
     .write = icp_pic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void icp_pic_init(Object *obj)
@@ -531,7 +531,7 @@ static void icp_control_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps icp_control_ops = {
     .read = icp_control_read,
     .write = icp_control_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void icp_control_mmc_wprot(void *opaque, int line, int level)
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 2f052e1f8c..d927af0063 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -123,7 +123,7 @@ static void kzm_init(MachineState *machine)
     if (serial_hd(2)) { /* touchscreen */
         serial_mm_init(get_system_memory(), KZM_FPGA_ADDR+0x10, 0,
                        qdev_get_gpio_in(DEVICE(&s->soc.avic), 52),
-                       14745600, serial_hd(2), DEVICE_NATIVE_ENDIAN);
+                       14745600, serial_hd(2), MO_TE);
     }
 
     kzm_binfo.ram_size = machine->ram_size;
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 008fd9327a..a613504ef7 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -141,7 +141,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         if (serial_hd(i)) {
             serial_mm_init(get_system_memory(), uart_addr[i], 2,
                            qdev_get_gpio_in(armv7m, uart_irq[i]),
-                           115200, serial_hd(i), DEVICE_NATIVE_ENDIAN);
+                           115200, serial_hd(i), MO_TE);
         }
     }
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 8ae4751d75..5a8aa2f149 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -371,7 +371,7 @@ static void mv88w8618_eth_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps mv88w8618_eth_ops = {
     .read = mv88w8618_eth_read,
     .write = mv88w8618_eth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void eth_cleanup(NetClientState *nc)
@@ -617,7 +617,7 @@ static void musicpal_lcd_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps musicpal_lcd_ops = {
     .read = musicpal_lcd_read,
     .write = musicpal_lcd_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const GraphicHwOps musicpal_gfx_ops = {
@@ -758,7 +758,7 @@ static void mv88w8618_pic_reset(DeviceState *d)
 static const MemoryRegionOps mv88w8618_pic_ops = {
     .read = mv88w8618_pic_read,
     .write = mv88w8618_pic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void mv88w8618_pic_init(Object *obj)
@@ -922,7 +922,7 @@ static void mv88w8618_pit_reset(DeviceState *d)
 static const MemoryRegionOps mv88w8618_pit_ops = {
     .read = mv88w8618_pit_read,
     .write = mv88w8618_pit_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void mv88w8618_pit_init(Object *obj)
@@ -1026,7 +1026,7 @@ static void mv88w8618_flashcfg_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps mv88w8618_flashcfg_ops = {
     .read = mv88w8618_flashcfg_read,
     .write = mv88w8618_flashcfg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void mv88w8618_flashcfg_init(Object *obj)
@@ -1099,7 +1099,7 @@ static void musicpal_misc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps musicpal_misc_ops = {
     .read = musicpal_misc_read,
     .write = musicpal_misc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void musicpal_misc_init(Object *obj)
@@ -1147,7 +1147,7 @@ static void mv88w8618_wlan_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps mv88w8618_wlan_ops = {
     .read = mv88w8618_wlan_read,
     .write =mv88w8618_wlan_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void mv88w8618_wlan_realize(DeviceState *dev, Error **errp)
@@ -1344,7 +1344,7 @@ static void musicpal_gpio_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps musicpal_gpio_ops = {
     .read = musicpal_gpio_read,
     .write = musicpal_gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void musicpal_gpio_reset(DeviceState *d)
@@ -1614,11 +1614,11 @@ static void musicpal_init(MachineState *machine)
 
     if (serial_hd(0)) {
         serial_mm_init(address_space_mem, MP_UART1_BASE, 2, pic[MP_UART1_IRQ],
-                       1825000, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                       1825000, serial_hd(0), MO_TE);
     }
     if (serial_hd(1)) {
         serial_mm_init(address_space_mem, MP_UART2_BASE, 2, pic[MP_UART2_IRQ],
-                       1825000, serial_hd(1), DEVICE_NATIVE_ENDIAN);
+                       1825000, serial_hd(1), MO_TE);
     }
 
     /* Register flash */
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 0400593805..b6807be542 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -381,7 +381,7 @@ static void omap_wd_timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_wd_timer_ops = {
     .read = omap_wd_timer_read,
     .write = omap_wd_timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_wd_timer_reset(struct omap_watchdog_timer_s *s)
@@ -493,7 +493,7 @@ static void omap_os_timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_os_timer_ops = {
     .read = omap_os_timer_read,
     .write = omap_os_timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_os_timer_reset(struct omap_32khz_timer_s *s)
@@ -720,7 +720,7 @@ static void omap_ulpd_pm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_ulpd_pm_ops = {
     .read = omap_ulpd_pm_read,
     .write = omap_ulpd_pm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_ulpd_pm_reset(struct omap_mpu_state_s *mpu)
@@ -954,7 +954,7 @@ static void omap_pin_cfg_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_pin_cfg_ops = {
     .read = omap_pin_cfg_read,
     .write = omap_pin_cfg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_pin_cfg_reset(struct omap_mpu_state_s *mpu)
@@ -1045,7 +1045,7 @@ static void omap_id_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_id_ops = {
     .read = omap_id_read,
     .write = omap_id_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_id_init(MemoryRegion *memory, struct omap_mpu_state_s *mpu)
@@ -1134,7 +1134,7 @@ static void omap_mpui_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_mpui_ops = {
     .read = omap_mpui_read,
     .write = omap_mpui_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_mpui_reset(struct omap_mpu_state_s *s)
@@ -1237,7 +1237,7 @@ static void omap_tipb_bridge_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_tipb_bridge_ops = {
     .read = omap_tipb_bridge_read,
     .write = omap_tipb_bridge_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_tipb_bridge_reset(struct omap_tipb_bridge_s *s)
@@ -1342,7 +1342,7 @@ static void omap_tcmi_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_tcmi_ops = {
     .read = omap_tcmi_read,
     .write = omap_tcmi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_tcmi_reset(struct omap_mpu_state_s *mpu)
@@ -1437,7 +1437,7 @@ static void omap_dpll_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_dpll_ops = {
     .read = omap_dpll_read,
     .write = omap_dpll_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_dpll_reset(struct dpll_ctl_s *s)
@@ -1749,7 +1749,7 @@ static void omap_clkm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_clkm_ops = {
     .read = omap_clkm_read,
     .write = omap_clkm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static uint64_t omap_clkdsp_read(void *opaque, hwaddr addr,
@@ -1838,7 +1838,7 @@ static void omap_clkdsp_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_clkdsp_ops = {
     .read = omap_clkdsp_read,
     .write = omap_clkdsp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_clkm_reset(struct omap_mpu_state_s *s)
@@ -2083,7 +2083,7 @@ static void omap_mpuio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_mpuio_ops  = {
     .read = omap_mpuio_read,
     .write = omap_mpuio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_mpuio_reset(struct omap_mpuio_s *s)
@@ -2289,7 +2289,7 @@ static void omap_uwire_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_uwire_ops = {
     .read = omap_uwire_read,
     .write = omap_uwire_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_uwire_reset(struct omap_uwire_s *s)
@@ -2400,7 +2400,7 @@ static void omap_pwl_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_pwl_ops = {
     .read = omap_pwl_read,
     .write = omap_pwl_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_pwl_reset(struct omap_pwl_s *s)
@@ -2518,7 +2518,7 @@ static void omap_pwt_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_pwt_ops = {
     .read =omap_pwt_read,
     .write = omap_pwt_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_pwt_reset(struct omap_pwt_s *s)
@@ -2855,7 +2855,7 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_rtc_ops = {
     .read = omap_rtc_read,
     .write = omap_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_rtc_tick(void *opaque)
@@ -3453,7 +3453,7 @@ static void omap_mcbsp_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_mcbsp_ops = {
     .read = omap_mcbsp_read,
     .write = omap_mcbsp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_mcbsp_reset(struct omap_mcbsp_s *s)
@@ -3645,7 +3645,7 @@ static void omap_lpg_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_lpg_ops = {
     .read = omap_lpg_read,
     .write = omap_lpg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_lpg_clk_update(void *opaque, int line, int on)
@@ -3698,7 +3698,7 @@ static void omap_mpui_io_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_mpui_io_ops = {
     .read = omap_mpui_io_read,
     .write = omap_mpui_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_setup_mpui_io(MemoryRegion *system_memory,
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index bd7ddff983..405aa29671 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -597,7 +597,7 @@ static void omap_eac_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_eac_ops = {
     .read = omap_eac_read,
     .write = omap_eac_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static struct omap_eac_s *omap_eac_init(struct omap_target_agent_s *ta,
@@ -748,7 +748,7 @@ static void omap_sti_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_sti_ops = {
     .read = omap_sti_read,
     .write = omap_sti_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static uint64_t omap_sti_fifo_read(void *opaque, hwaddr addr,
@@ -789,7 +789,7 @@ static void omap_sti_fifo_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_sti_fifo_ops = {
     .read = omap_sti_fifo_read,
     .write = omap_sti_fifo_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static struct omap_sti_s *omap_sti_init(struct omap_target_agent_s *ta,
@@ -1728,7 +1728,7 @@ static void omap_prcm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_prcm_ops = {
     .read = omap_prcm_read,
     .write = omap_prcm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_prcm_reset(struct omap_prcm_s *s)
@@ -2128,7 +2128,7 @@ static const MemoryRegionOps omap_sysctl_ops = {
     .write = omap_sysctl_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_sysctl_reset(struct omap_sysctl_s *s)
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 75a05c36b0..1a8f7b4e61 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -82,7 +82,7 @@ static void static_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps static_ops = {
     .read = static_read,
     .write = static_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 #define sdram_size	0x02000000
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index bea47b917d..4de6fbe639 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -54,7 +54,7 @@ static const MemoryRegionOps static_ops = {
     .write = static_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 /* Palm Tunsgten|E support */
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index cdafde2f76..dccd71e955 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -152,7 +152,7 @@ static void pxa2xx_pm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pxa2xx_pm_ops = {
     .read = pxa2xx_pm_read,
     .write = pxa2xx_pm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_pxa2xx_pm = {
@@ -218,7 +218,7 @@ static void pxa2xx_cm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pxa2xx_cm_ops = {
     .read = pxa2xx_cm_read,
     .write = pxa2xx_cm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_pxa2xx_cm = {
@@ -442,7 +442,7 @@ static void pxa2xx_mm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pxa2xx_mm_ops = {
     .read = pxa2xx_mm_read,
     .write = pxa2xx_mm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_pxa2xx_mm = {
@@ -741,7 +741,7 @@ static void pxa2xx_ssp_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pxa2xx_ssp_ops = {
     .read = pxa2xx_ssp_read,
     .write = pxa2xx_ssp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void pxa2xx_ssp_reset(DeviceState *d)
@@ -1108,7 +1108,7 @@ static void pxa2xx_rtc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pxa2xx_rtc_ops = {
     .read = pxa2xx_rtc_read,
     .write = pxa2xx_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void pxa2xx_rtc_init(Object *obj)
@@ -1429,7 +1429,7 @@ static void pxa2xx_i2c_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pxa2xx_i2c_ops = {
     .read = pxa2xx_i2c_read,
     .write = pxa2xx_i2c_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_pxa2xx_i2c_slave = {
@@ -1687,7 +1687,7 @@ static void pxa2xx_i2s_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pxa2xx_i2s_ops = {
     .read = pxa2xx_i2s_read,
     .write = pxa2xx_i2s_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_pxa2xx_i2s = {
@@ -1924,7 +1924,7 @@ static void pxa2xx_fir_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pxa2xx_fir_ops = {
     .read = pxa2xx_fir_read,
     .write = pxa2xx_fir_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static int pxa2xx_fir_is_empty(void *opaque)
@@ -2113,7 +2113,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
             serial_mm_init(address_space, pxa270_serial[i].io_base, 2,
                            qdev_get_gpio_in(s->pic, pxa270_serial[i].irqn),
                            14857000 / 16, serial_hd(i),
-                           DEVICE_NATIVE_ENDIAN);
+                           MO_TE);
         } else {
             break;
         }
@@ -2237,7 +2237,7 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
             serial_mm_init(address_space, pxa255_serial[i].io_base, 2,
                            qdev_get_gpio_in(s->pic, pxa255_serial[i].irqn),
                            14745600 / 16, serial_hd(i),
-                           DEVICE_NATIVE_ENDIAN);
+                           MO_TE);
         } else {
             break;
         }
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index 86a0e86c4c..16f9127cdf 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -259,7 +259,7 @@ static void pxa2xx_gpio_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pxa_gpio_ops = {
     .read = pxa2xx_gpio_read,
     .write = pxa2xx_gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 DeviceState *pxa2xx_gpio_init(hwaddr base,
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 203d4d28af..9819186385 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -256,7 +256,7 @@ static const ARMCPRegInfo pxa_pic_cp_reginfo[] = {
 static const MemoryRegionOps pxa2xx_pic_ops = {
     .read = pxa2xx_pic_mem_read,
     .write = pxa2xx_pic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static int pxa2xx_pic_post_load(void *opaque, int version_id)
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 59348123b5..e4e84ea35b 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -148,7 +148,7 @@ enum {
 static const MemoryRegionOps sl_ops = {
     .read = sl_read,
     .write = sl_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void sl_flash_register(PXA2xxState *cpu, int size)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index b198066b54..e514ff8114 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -308,7 +308,7 @@ static void gptm_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps gptm_ops = {
     .read = gptm_read,
     .write = gptm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_stellaris_gptm = {
@@ -640,7 +640,7 @@ static void ssys_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps ssys_ops = {
     .read = ssys_read,
     .write = ssys_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void ssys_reset(void *opaque)
@@ -877,7 +877,7 @@ static void stellaris_i2c_reset(stellaris_i2c_state *s)
 static const MemoryRegionOps stellaris_i2c_ops = {
     .read = stellaris_i2c_read,
     .write = stellaris_i2c_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_stellaris_i2c = {
@@ -1147,7 +1147,7 @@ static void stellaris_adc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps stellaris_adc_ops = {
     .read = stellaris_adc_read,
     .write = stellaris_adc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_stellaris_adc = {
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index dc65d88a65..439bb7dd5c 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -182,7 +182,7 @@ static void strongarm_pic_mem_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps strongarm_pic_ops = {
     .read = strongarm_pic_mem_read,
     .write = strongarm_pic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void strongarm_pic_initfn(Object *obj)
@@ -382,7 +382,7 @@ static void strongarm_rtc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps strongarm_rtc_ops = {
     .read = strongarm_rtc_read,
     .write = strongarm_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void strongarm_rtc_init(Object *obj)
@@ -630,7 +630,7 @@ static void strongarm_gpio_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps strongarm_gpio_ops = {
     .read = strongarm_gpio_read,
     .write = strongarm_gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static DeviceState *strongarm_gpio_init(hwaddr base,
@@ -823,7 +823,7 @@ static void strongarm_ppc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps strongarm_ppc_ops = {
     .read = strongarm_ppc_read,
     .write = strongarm_ppc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void strongarm_ppc_init(Object *obj)
@@ -1228,7 +1228,7 @@ static void strongarm_uart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps strongarm_uart_ops = {
     .read = strongarm_uart_read,
     .write = strongarm_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void strongarm_uart_init(Object *obj)
@@ -1517,7 +1517,7 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps strongarm_ssp_ops = {
     .read = strongarm_ssp_read,
     .write = strongarm_ssp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static int strongarm_ssp_post_load(void *opaque, int version_id)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index e25561705f..a7762170fd 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -151,7 +151,7 @@ static void vpb_sic_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps vpb_sic_ops = {
     .read = vpb_sic_read,
     .write = vpb_sic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void vpb_sic_init(Object *obj)
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 6ecd383540..3699d960b9 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1069,7 +1069,7 @@ static const MemoryRegionOps intel_hda_mmio_ops = {
         .min_access_size = 1,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 /* --------------------------------------------------------------------- */
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index ac5d31e8c1..7a5720cea9 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -984,13 +984,13 @@ static void fdctrl_write_mem (void *opaque, hwaddr reg,
 static const MemoryRegionOps fdctrl_mem_ops = {
     .read = fdctrl_read_mem,
     .write = fdctrl_write_mem,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const MemoryRegionOps fdctrl_mem_strict_ops = {
     .read = fdctrl_read_mem,
     .write = fdctrl_write_mem,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 566c0acb77..80240c5a4b 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -695,7 +695,7 @@ static MemTxResult pflash_mem_write_with_attrs(void *opaque, hwaddr addr, uint64
 static const MemoryRegionOps pflash_cfi01_ops = {
     .read_with_attrs = pflash_mem_read_with_attrs,
     .write_with_attrs = pflash_mem_write_with_attrs,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 4baca701b7..16404ea9d2 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -714,7 +714,7 @@ static const MemoryRegionOps pflash_cfi02_ops = {
     .write = pflash_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 3f855196e3..527f36b178 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -247,7 +247,7 @@ static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int size)
 static const MemoryRegionOps bcm2835_aux_ops = {
     .read = bcm2835_aux_read,
     .write = bcm2835_aux_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 974a2619dd..3de66380e2 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -111,7 +111,7 @@ static const MemoryRegionOps uart_mmio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static int uart_can_rx(void *opaque)
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index d6b6b62366..651f15f1ce 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -483,7 +483,7 @@ static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
 static const MemoryRegionOps exynos4210_uart_ops = {
     .read = exynos4210_uart_read,
     .write = exynos4210_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .max_access_size = 4,
         .unaligned = false
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 58323baf43..99e361c3df 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -287,7 +287,7 @@ static void mcf_uart_receive(void *opaque, const uint8_t *buf, int size)
 static const MemoryRegionOps mcf_uart_ops = {
     .read = mcf_uart_read,
     .write = mcf_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void mcf_uart_instance_init(Object *obj)
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 13e4f43c4c..ca0d429579 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -63,7 +63,7 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
     s->serial = serial_mm_init(get_system_memory(), base, 2, irq,
                                omap_clk_getrate(fclk)/16,
                                chr ?: qemu_chr_new(label, "null", NULL),
-                               DEVICE_NATIVE_ENDIAN);
+                               MO_TE);
     return s;
 }
 
@@ -155,7 +155,7 @@ static void omap_uart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_uart_ops = {
     .read = omap_uart_read,
     .write = omap_uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
@@ -183,5 +183,5 @@ void omap_uart_attach(struct omap_uart_s *s, Chardev *chr)
     s->serial = serial_mm_init(get_system_memory(), s->base, 2, s->irq,
                                omap_clk_getrate(s->fclk) / 16,
                                chr ?: qemu_chr_new("null", "null", NULL),
-                               DEVICE_NATIVE_ENDIAN);
+                               MO_TE);
 }
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 40174eeda1..66871c4499 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -591,7 +591,7 @@ static const MemoryRegionOps parallel_mm_ops = {
     .write = parallel_mm_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 /* If fd is zero, it means that the parallel device uses the console */
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 07dc16be13..0a2418a97d 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -368,7 +368,7 @@ static void sh_serial_event(void *opaque, int event)
 static const MemoryRegionOps sh_serial_ops = {
     .read = sh_serial_read,
     .write = sh_serial_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 void sh_serial_init(MemoryRegion *sysmem,
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 4ec843de38..1099b0492d 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -189,7 +189,7 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps stm32f2xx_usart_ops = {
     .read = stm32f2xx_usart_read,
     .write = stm32f2xx_usart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static Property stm32f2xx_usart_properties[] = {
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 2c47275068..3f6ba1e5d8 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -169,7 +169,7 @@ uart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps uart_ops = {
     .read = uart_read,
     .write = uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4
diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 3ba450e1ca..950fb1564e 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -49,7 +49,7 @@ static void empty_slot_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps empty_slot_ops = {
     .read = empty_slot_read,
     .write = empty_slot_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 void empty_slot_init(hwaddr addr, uint64_t slot_size)
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 940c7dd122..a98ffd3dd2 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -83,7 +83,7 @@ nand_write(void *opaque, hwaddr addr, uint64_t value,
 static const MemoryRegionOps nand_ops = {
     .read = nand_read,
     .write = nand_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct tempsensor_t
@@ -235,7 +235,7 @@ static void gpio_write(void *opaque, hwaddr addr, uint64_t value,
 static const MemoryRegionOps gpio_ops = {
     .read = gpio_read,
     .write = gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 8f856878cd..9650007f86 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -344,7 +344,7 @@ static void bcm2835_fb_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps bcm2835_fb_ops = {
     .read = bcm2835_fb_read,
     .write = bcm2835_fb_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index f90baae4de..97dd7f44ec 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -270,7 +270,7 @@ static void cg3_reg_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps cg3_reg_ops = {
     .read = cg3_reg_read,
     .write = cg3_reg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index c1071ecd46..f74693f547 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1821,7 +1821,7 @@ static const MemoryRegionOps exynos4210_fimd_mmio_ops = {
         .max_access_size = 4,
         .unaligned = false
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static int exynos4210_fimd_load(void *opaque, int version_id)
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 3e0112b1ca..7ffd2d36a6 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -73,7 +73,7 @@ static void jazz_led_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps led_ops = {
     .read = jazz_led_read,
     .write = jazz_led_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl.min_access_size = 1,
     .impl.max_access_size = 1,
 };
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 199f1227e7..f38e06aeba 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -435,7 +435,7 @@ static const MemoryRegionOps tmu2_mmio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void milkymist_tmu2_reset(DeviceState *d)
diff --git a/hw/display/milkymist-vgafb.c b/hw/display/milkymist-vgafb.c
index 8b0da4660a..a5a7654f5b 100644
--- a/hw/display/milkymist-vgafb.c
+++ b/hw/display/milkymist-vgafb.c
@@ -271,7 +271,7 @@ static const MemoryRegionOps vgafb_mmio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void milkymist_vgafb_reset(DeviceState *d)
diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
index 637aae8d39..34ba41e913 100644
--- a/hw/display/omap_dss.c
+++ b/hw/display/omap_dss.c
@@ -247,7 +247,7 @@ static void omap_diss_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_diss_ops = {
     .read = omap_diss_read,
     .write = omap_diss_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static uint64_t omap_disc_read(void *opaque, hwaddr addr,
@@ -591,7 +591,7 @@ static void omap_disc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_disc_ops = {
     .read = omap_disc_read,
     .write = omap_disc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_rfbi_transfer_stop(struct omap_dss_s *s)
@@ -867,7 +867,7 @@ static void omap_rfbi_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_rfbi_ops = {
     .read = omap_rfbi_read,
     .write = omap_rfbi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static uint64_t omap_venc_read(void *opaque, hwaddr addr,
@@ -990,7 +990,7 @@ static void omap_venc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_venc_ops = {
     .read = omap_venc_read,
     .write = omap_venc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static uint64_t omap_im3_read(void *opaque, hwaddr addr,
@@ -1044,7 +1044,7 @@ static void omap_im3_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_im3_ops = {
     .read = omap_im3_read,
     .write = omap_im3_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct omap_dss_s *omap_dss_init(struct omap_target_agent_s *ta,
diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index 6ad13f2e9e..ab98c1dc1b 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -331,7 +331,7 @@ static void omap_lcdc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_lcdc_ops = {
     .read = omap_lcdc_read,
     .write = omap_lcdc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 void omap_lcdc_reset(struct omap_lcd_panel_s *s)
diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index 05f5f84671..4b692565ab 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -569,7 +569,7 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pxa2xx_lcdc_ops = {
     .read = pxa2xx_lcdc_read,
     .write = pxa2xx_lcdc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 /* Load new palette for a given DMA channel, convert to internal format */
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 14e829d3fa..3ef8c85f22 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -464,7 +464,7 @@ static void tcx_dac_writel(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps tcx_dac_ops = {
     .read = tcx_dac_readl,
     .write = tcx_dac_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -545,7 +545,7 @@ static void tcx_rstip_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps tcx_stip_ops = {
     .read = tcx_stip_readl,
     .write = tcx_stip_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -555,7 +555,7 @@ static const MemoryRegionOps tcx_stip_ops = {
 static const MemoryRegionOps tcx_rstip_ops = {
     .read = tcx_stip_readl,
     .write = tcx_rstip_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -637,7 +637,7 @@ static void tcx_rblit_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps tcx_blit_ops = {
     .read = tcx_blit_readl,
     .write = tcx_blit_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -647,7 +647,7 @@ static const MemoryRegionOps tcx_blit_ops = {
 static const MemoryRegionOps tcx_rblit_ops = {
     .read = tcx_blit_readl,
     .write = tcx_rblit_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -709,7 +709,7 @@ static void tcx_thc_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps tcx_thc_ops = {
     .read = tcx_thc_readl,
     .write = tcx_thc_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -731,7 +731,7 @@ static void tcx_dummy_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps tcx_dummy_ops = {
     .read = tcx_dummy_readl,
     .write = tcx_dummy_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index e9c43e5530..e90c821d6e 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -62,7 +62,7 @@ static const MemoryRegionOps vga_mm_ctrl_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void vga_mm_init(ISAVGAMMState *s, hwaddr vram_base,
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index fde3b21ea5..625a7c2ac7 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -303,7 +303,7 @@ static void xlnx_dp_audio_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps audio_ops = {
     .read = xlnx_dp_audio_read,
     .write = xlnx_dp_audio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static inline uint32_t xlnx_dp_audio_get_volume(XlnxDPState *s,
@@ -878,7 +878,7 @@ static void xlnx_dp_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps dp_ops = {
     .read = xlnx_dp_read,
     .write = xlnx_dp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -993,7 +993,7 @@ static uint64_t xlnx_dp_vblend_read(void *opaque, hwaddr offset,
 static const MemoryRegionOps vblend_ops = {
     .read = xlnx_dp_vblend_read,
     .write = xlnx_dp_vblend_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1106,7 +1106,7 @@ static uint64_t xlnx_dp_avbufm_read(void *opaque, hwaddr offset,
 static const MemoryRegionOps avbufm_ops = {
     .read = xlnx_dp_avbufm_read,
     .write = xlnx_dp_avbufm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 792f617eb4..f588bc2d34 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -476,7 +476,7 @@ static int i8257_phony_handler(void *opaque, int nchan, int dma_pos,
 static const MemoryRegionOps channel_io_ops = {
     .read = i8257_read_chan,
     .write = i8257_write_chan,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -500,7 +500,7 @@ static const MemoryRegionPortio pageh_portio_list[] = {
 static const MemoryRegionOps cont_io_ops = {
     .read = i8257_read_cont,
     .write = i8257_write_cont,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index eab83c5c3a..16cc7df945 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -1552,7 +1552,7 @@ static void omap_dma_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_dma_ops = {
     .read = omap_dma_read,
     .write = omap_dma_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_dma_request(void *opaque, int drq, int req)
@@ -2073,7 +2073,7 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_dma4_ops = {
     .read = omap_dma4_read,
     .write = omap_dma4_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct soc_dma_s *omap_dma4_init(hwaddr base, qemu_irq *irqs,
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index 18e7a0b694..35828c989b 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -427,7 +427,7 @@ static void pxa2xx_dma_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pxa2xx_dma_ops = {
     .read = pxa2xx_dma_read,
     .write = pxa2xx_dma_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void pxa2xx_dma_request(void *opaque, int req_num, int on)
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index d54e296d3a..16a055df48 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -388,7 +388,7 @@ static const MemoryRegionOps rc4030_ops = {
     .write = rc4030_write,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void update_jazz_irq(rc4030State *s)
@@ -491,7 +491,7 @@ static const MemoryRegionOps jazzio_ops = {
     .write = jazzio_write,
     .impl.min_access_size = 2,
     .impl.max_access_size = 2,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static IOMMUTLBEntry rc4030_dma_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index d176df6d44..30c479fbbc 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -515,7 +515,7 @@ static void axidma_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps axidma_ops = {
     .read = axidma_read,
     .write = axidma_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index b40c897de2..67605c515e 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -554,7 +554,7 @@ static void xlnx_dpdma_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps dma_ops = {
     .read = xlnx_dpdma_read,
     .write = xlnx_dpdma_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index 91ce3d10cc..d1dfb576ec 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -277,7 +277,7 @@ static void bcm2835_gpio_reset(DeviceState *dev)
 static const MemoryRegionOps bcm2835_gpio_ops = {
     .read = bcm2835_gpio_read,
     .write = bcm2835_gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_bcm2835_gpio = {
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index ac8304ec56..cf1b3dae56 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -270,7 +270,7 @@ static const MemoryRegionOps imx_gpio_ops = {
     .write = imx_gpio_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_imx_gpio = {
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 41e1aa798c..7b716d61f3 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -178,7 +178,7 @@ static void omap_gpio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_gpio_ops = {
     .read = omap_gpio_read,
     .write = omap_gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_gpio_reset(struct omap_gpio_s *s)
@@ -593,7 +593,7 @@ static const MemoryRegionOps omap2_gpio_module_ops = {
     .write = omap2_gpio_module_writep,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_gpif_reset(DeviceState *dev)
@@ -676,7 +676,7 @@ static void omap2_gpif_top_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap2_gpif_top_ops = {
     .read = omap2_gpif_top_read,
     .write = omap2_gpif_top_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_gpio_init(Object *obj)
diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
index d19e342514..241431d79a 100644
--- a/hw/gpio/puv3_gpio.c
+++ b/hw/gpio/puv3_gpio.c
@@ -97,7 +97,7 @@ static const MemoryRegionOps puv3_gpio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void puv3_gpio_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index a600f65560..b9402defba 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -266,7 +266,7 @@ static void exynos4210_i2c_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps exynos4210_i2c_ops = {
     .read = exynos4210_i2c_read,
     .write = exynos4210_i2c_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription exynos4210_i2c_vmstate = {
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 3ba965a58f..c67477e2cf 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -470,7 +470,7 @@ static const MemoryRegionOps omap_i2c_ops = {
     .write = omap_i2c_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_i2c_init(Object *obj)
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index 3f015a1581..e9fded6378 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -335,7 +335,7 @@ static const MemoryRegionOps ppc4xx_i2c_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 1,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void ppc4xx_i2c_init(Object *o)
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 91fb622d63..e645447fc8 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -207,7 +207,7 @@ static void kvm_apic_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps kvm_apic_io_ops = {
     .read = kvm_apic_mem_read,
     .write = kvm_apic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void kvm_apic_reset(APICCommonState *s)
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 51639202c2..d8f1c22d72 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -719,7 +719,7 @@ static uint64_t vapic_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps vapic_ops = {
     .write = vapic_write,
     .read = vapic_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void vapic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 697c33606a..f79922d096 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2000,7 +2000,7 @@ DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
 static const MemoryRegionOps ioport80_io_ops = {
     .write = ioport80_write,
     .read = ioport80_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -2010,7 +2010,7 @@ static const MemoryRegionOps ioport80_io_ops = {
 static const MemoryRegionOps ioportF0_io_ops = {
     .write = ioportF0_write,
     .read = ioportF0_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/i386/xen/xen_apic.c b/hw/i386/xen/xen_apic.c
index 7c7a60b166..2a28057562 100644
--- a/hw/i386/xen/xen_apic.c
+++ b/hw/i386/xen/xen_apic.c
@@ -36,7 +36,7 @@ static void xen_apic_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps xen_apic_io_ops = {
     .read = xen_apic_mem_read,
     .write = xen_apic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void xen_apic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 0f7b05e5e1..bf0c6eb341 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -427,7 +427,7 @@ static void platform_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps platform_mmio_handler = {
     .read = &platform_mmio_read,
     .write = &platform_mmio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void platform_mmio_setup(PCIXenPlatformState *d)
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 67fcb3595f..2fba741ac0 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -129,7 +129,7 @@ softusb_write(void *opaque, hwaddr addr, uint64_t value,
 static const MemoryRegionOps softusb_mmio_ops = {
     .read = softusb_read,
     .write = softusb_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index f0acfd86f7..3676131427 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -459,7 +459,7 @@ static const MemoryRegionOps i8042_mmio_ops = {
     .write = kbd_mm_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 31862a7d16..b694678a72 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -287,7 +287,7 @@ static void pxa2xx_keypad_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pxa2xx_keypad_ops = {
     .read = pxa2xx_keypad_read,
     .write = pxa2xx_keypad_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_pxa2xx_keypad = {
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 8cca124807..c6be48bbf6 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -138,7 +138,7 @@ static void aw_a10_pic_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps aw_a10_pic_ops = {
     .read = aw_a10_pic_read,
     .write = aw_a10_pic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_aw_a10_pic = {
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index bce89911dc..6379c66042 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -878,7 +878,7 @@ static const MemoryRegionOps apic_io_ops = {
     .impl.max_access_size = 4,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void apic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 66c4c6a188..219de07a03 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -96,7 +96,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps gicv3_its_trans_ops = {
     .read_with_attrs = gicv3_its_trans_read,
     .write_with_attrs = gicv3_its_trans_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 void gicv3_its_init_mmio(GICv3ITSState *s, const MemoryRegionOps *ops)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 8e93e51e81..10c646fe39 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2337,7 +2337,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps nvic_sysreg_ops = {
     .read_with_attrs = nvic_sysreg_read,
     .write_with_attrs = nvic_sysreg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static MemTxResult nvic_sysreg_ns_write(void *opaque, hwaddr addr,
@@ -2384,7 +2384,7 @@ static MemTxResult nvic_sysreg_ns_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps nvic_sysreg_ns_ops = {
     .read_with_attrs = nvic_sysreg_ns_read,
     .write_with_attrs = nvic_sysreg_ns_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static MemTxResult nvic_systick_write(void *opaque, hwaddr addr,
@@ -2416,7 +2416,7 @@ static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps nvic_systick_ops = {
     .read_with_attrs = nvic_systick_read,
     .write_with_attrs = nvic_systick_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static int nvic_post_load(void *opaque, int version_id)
diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 05bd28e4f9..c3312feb9b 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -170,7 +170,7 @@ static void bcm2835_ic_write(void *opaque, hwaddr offset, uint64_t val,
 static const MemoryRegionOps bcm2835_ic_ops = {
     .read = bcm2835_ic_read,
     .write = bcm2835_ic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index 04229b8a17..41af557fba 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -304,7 +304,7 @@ static void bcm2836_control_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps bcm2836_control_ops = {
     .read = bcm2836_control_read,
     .write = bcm2836_control_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 5b33ca6628..8b4805ed34 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -405,7 +405,7 @@ static void exynos4210_combiner_reset(DeviceState *d)
 static const MemoryRegionOps exynos4210_combiner_ops = {
     .read = exynos4210_combiner_read,
     .write = exynos4210_combiner_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 /*
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index bc78e1a14f..799a353c0e 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -314,7 +314,7 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps grlib_irqmp_ops = {
     .read = grlib_irqmp_read,
     .write = grlib_irqmp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 1ede055387..18ac05cc61 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -404,7 +404,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps ioapic_io_ops = {
     .read = ioapic_mem_read,
     .write = ioapic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void ioapic_machine_done_notify(Notifier *notifier, void *data)
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 54b3059f3f..7465550bc5 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -386,7 +386,7 @@ static void gic_reset(void *opaque)
 static const MemoryRegionOps gic_ops = {
     .read = gic_read,
     .write = gic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .max_access_size = 8,
     },
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 854b709ca0..0ad3a4efc9 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -331,7 +331,7 @@ static void omap_inth_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_inth_mem_ops = {
     .read = omap_inth_read,
     .write = omap_inth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -607,7 +607,7 @@ static void omap2_inth_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap2_inth_mem_ops = {
     .read = omap2_inth_read,
     .write = omap2_inth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index ca9614fda1..4daf60dcd4 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -97,7 +97,7 @@ static void ompic_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
 static const MemoryRegionOps ompic_ops = {
     .read = ompic_read,
     .write = ompic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .max_access_size = 8,
     },
diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index 72a55e32dd..7031e5dba3 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -289,7 +289,7 @@ static void sh_intc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps sh_intc_ops = {
     .read = sh_intc_read,
     .write = sh_intc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct intc_source *sh_intc_source(struct intc_desc *desc, intc_enum id)
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index c4cf9096eb..44c9b698bd 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -136,7 +136,7 @@ static void slavio_intctl_mem_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_intctl_mem_ops = {
     .read = slavio_intctl_mem_readl,
     .write = slavio_intctl_mem_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -206,7 +206,7 @@ static void slavio_intctlm_mem_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_intctlm_mem_ops = {
     .read = slavio_intctlm_mem_readl,
     .write = slavio_intctlm_mem_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index e15cb42b36..45634b3cba 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -143,7 +143,7 @@ pic_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pic_ops = {
     .read = pic_read,
     .write = pic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index f931d4df62..b287694c33 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -526,7 +526,7 @@ static void tpci200_write_las3(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps tpci200_cfg_ops = {
     .read = tpci200_read_cfg,
     .write = tpci200_write_cfg,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid =  {
         .min_access_size = 1,
         .max_access_size = 4
@@ -540,7 +540,7 @@ static const MemoryRegionOps tpci200_cfg_ops = {
 static const MemoryRegionOps tpci200_las0_ops = {
     .read = tpci200_read_las0,
     .write = tpci200_write_las0,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid =  {
         .min_access_size = 2,
         .max_access_size = 2
@@ -550,7 +550,7 @@ static const MemoryRegionOps tpci200_las0_ops = {
 static const MemoryRegionOps tpci200_las1_ops = {
     .read = tpci200_read_las1,
     .write = tpci200_write_las1,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid =  {
         .min_access_size = 1,
         .max_access_size = 2
@@ -560,7 +560,7 @@ static const MemoryRegionOps tpci200_las1_ops = {
 static const MemoryRegionOps tpci200_las2_ops = {
     .read = tpci200_read_las2,
     .write = tpci200_write_las2,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid =  {
         .min_access_size = 1,
         .max_access_size = 2
@@ -570,7 +570,7 @@ static const MemoryRegionOps tpci200_las2_ops = {
 static const MemoryRegionOps tpci200_las3_ops = {
     .read = tpci200_read_las3,
     .write = tpci200_write_las3,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid =  {
         .min_access_size = 1,
         .max_access_size = 1
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index a9c2c95b0d..25f3098408 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -551,7 +551,7 @@ static const MemoryRegionOps m5206_mbar_ops = {
     .write = m5206_mbar_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 qemu_irq *mcf5206_init(MemoryRegion *sysmem, uint32_t base, M68kCPU *cpu)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 012710d057..1749e2abf5 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -141,7 +141,7 @@ static uint64_t m5208_timer_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps m5208_timer_ops = {
     .read = m5208_timer_read,
     .write = m5208_timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
@@ -175,7 +175,7 @@ static void m5208_sys_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps m5208_sys_ops = {
     .read = m5208_sys_read,
     .write = m5208_sys_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index d9e03a06ab..e6599d343e 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -160,7 +160,7 @@ static void mcf_intc_reset(DeviceState *dev)
 static const MemoryRegionOps mcf_intc_ops = {
     .read = mcf_intc_read,
     .write = mcf_intc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void mcf_intc_instance_init(Object *obj)
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index ca7d813a52..6e753681cd 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -166,7 +166,7 @@ static void boston_lcd_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps boston_lcd_ops = {
     .read = boston_lcd_read,
     .write = boston_lcd_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
@@ -245,7 +245,7 @@ static void boston_platreg_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps boston_platreg_ops = {
     .read = boston_platreg_read,
     .write = boston_platreg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const TypeInfo boston_device = {
@@ -505,7 +505,7 @@ static void boston_mach_init(MachineState *machine)
 
     s->uart = serial_mm_init(sys_mem, 0x17ffe000, 2,
                              get_cps_irq(&s->cps, 3), 10000000,
-                             serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                             serial_hd(0), MO_TE);
 
     lcd = g_new(MemoryRegion, 1);
     memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8);
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index f325bd6c1c..f292ec71f7 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -973,7 +973,7 @@ static uint64_t gt64120_readl(void *opaque,
 static const MemoryRegionOps isd_mem_ops = {
     .read = gt64120_readl,
     .write = gt64120_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static int gt64120_pci_map_irq(PCIDevice *pci_dev, int irq_num)
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 388c15c376..e0c83df045 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -84,7 +84,7 @@ static void rtc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps rtc_ops = {
     .read = rtc_read,
     .write = rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static uint64_t dma_dummy_read(void *opaque, hwaddr addr,
@@ -105,7 +105,7 @@ static void dma_dummy_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps dma_dummy_ops = {
     .read = dma_dummy_read,
     .write = dma_dummy_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 #define MAGNUM_BIOS_SIZE_MAX 0x7e000
@@ -320,12 +320,12 @@ static void mips_jazz_init(MachineState *machine,
     if (serial_hd(0)) {
         serial_mm_init(address_space, 0x80006000, 0,
                        qdev_get_gpio_in(rc4030, 8), 8000000/16,
-                       serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                       serial_hd(0), MO_TE);
     }
     if (serial_hd(1)) {
         serial_mm_init(address_space, 0x80007000, 0,
                        qdev_get_gpio_in(rc4030, 9), 8000000/16,
-                       serial_hd(1), DEVICE_NATIVE_ENDIAN);
+                       serial_hd(1), MO_TE);
     }
 
     /* Parallel port */
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 4d9c64b36a..c3aa6e0744 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -531,7 +531,7 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps malta_fpga_ops = {
     .read = malta_fpga_read,
     .write = malta_fpga_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void malta_fpga_reset(void *opaque)
@@ -592,7 +592,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
                              malta_fgpa_display_event, NULL, s, NULL, true);
 
     s->uart = serial_mm_init(address_space, base + 0x900, 3, uart_irq,
-                             230400, uart_chr, DEVICE_NATIVE_ENDIAN);
+                             230400, uart_chr, MO_TE);
 
     malta_fpga_reset(s);
     qemu_register_reset(malta_fpga_reset, s);
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index bc0be26544..189bf6a779 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -72,7 +72,7 @@ static uint64_t mips_qemu_read (void *opaque, hwaddr addr,
 static const MemoryRegionOps mips_qemu_ops = {
     .read = mips_qemu_read,
     .write = mips_qemu_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 typedef struct ResetData {
diff --git a/hw/misc/arm_integrator_debug.c b/hw/misc/arm_integrator_debug.c
index 3e23201ae6..109388bf6f 100644
--- a/hw/misc/arm_integrator_debug.c
+++ b/hw/misc/arm_integrator_debug.c
@@ -72,7 +72,7 @@ static void intdbg_control_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps intdbg_control_ops = {
     .read = intdbg_control_read,
     .write = intdbg_control_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void intdbg_control_init(Object *obj)
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index fc79522ece..6ead04da44 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -563,7 +563,7 @@ static void arm_sysctl_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps arm_sysctl_ops = {
     .read = arm_sysctl_read,
     .write = arm_sysctl_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void arm_sysctl_gpio_set(void *opaque, int line, int level)
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index dca5585a75..973c84f8a7 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -108,7 +108,7 @@ static void aspeed_xdma_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps aspeed_xdma_ops = {
     .read = aspeed_xdma_read,
     .write = aspeed_xdma_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 79bad11631..d8f12bf689 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -239,7 +239,7 @@ static void bcm2835_mbox_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps bcm2835_mbox_ops = {
     .read = bcm2835_mbox_read,
     .write = bcm2835_mbox_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index d86d510572..4740f2a83e 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -346,7 +346,7 @@ static void bcm2835_property_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps bcm2835_property_ops = {
     .read = bcm2835_property_read,
     .write = bcm2835_property_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index d0c4e64e88..c5737f96b6 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -92,7 +92,7 @@ static void bcm2835_rng_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps bcm2835_rng_ops = {
     .read = bcm2835_rng_read,
     .write = bcm2835_rng_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_bcm2835_rng = {
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index 4b1f2b675a..c9760e7993 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -231,7 +231,7 @@ static uint64_t ecc_mem_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps ecc_mem_ops = {
     .read = ecc_mem_read,
     .write = ecc_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -260,7 +260,7 @@ static uint64_t ecc_diag_mem_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps ecc_diag_mem_ops = {
     .read = ecc_diag_mem_read,
     .write = ecc_diag_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index d5e2bdbb57..eea38632ab 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -295,7 +295,7 @@ static void edu_mmio_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps edu_mmio_ops = {
     .read = edu_mmio_read,
     .write = edu_mmio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 8,
diff --git a/hw/misc/exynos4210_clk.c b/hw/misc/exynos4210_clk.c
index bc1463ff89..276de59abb 100644
--- a/hw/misc/exynos4210_clk.c
+++ b/hw/misc/exynos4210_clk.c
@@ -101,7 +101,7 @@ static void exynos4210_clk_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps exynos4210_clk_ops = {
     .read = exynos4210_clk_read,
     .write = exynos4210_clk_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index 500f28343f..3abc877d68 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -458,7 +458,7 @@ static void exynos4210_pmu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps exynos4210_pmu_ops = {
     .read = exynos4210_pmu_read,
     .write = exynos4210_pmu_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 38cd61c7ea..cf32c72273 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -216,7 +216,7 @@ static void exynos4210_rng_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps exynos4210_rng_ops = {
     .read = exynos4210_rng_read,
     .write = exynos4210_rng_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void exynos4210_rng_reset(DeviceState *dev)
diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index d3107e5ca2..2797923d34 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -267,7 +267,7 @@ static void imx25_ccm_write(void *opaque, hwaddr offset, uint64_t value,
 static const struct MemoryRegionOps imx25_ccm_ops = {
     .read = imx25_ccm_read,
     .write = imx25_ccm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/misc/imx2_wdt.c b/hw/misc/imx2_wdt.c
index 5576778a32..07e97a27f7 100644
--- a/hw/misc/imx2_wdt.c
+++ b/hw/misc/imx2_wdt.c
@@ -37,7 +37,7 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps imx2_wdt_ops = {
     .read  = imx2_wdt_read,
     .write = imx2_wdt_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index 6e246827ab..060ea64eb3 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -293,7 +293,7 @@ static void imx31_ccm_write(void *opaque, hwaddr offset, uint64_t value,
 static const struct MemoryRegionOps imx31_ccm_ops = {
     .read = imx31_ccm_read,
     .write = imx31_ccm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 7fec8f0a47..a08b824768 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -697,7 +697,7 @@ static void imx6_analog_write(void *opaque, hwaddr offset, uint64_t value,
 static const struct MemoryRegionOps imx6_ccm_ops = {
     .read = imx6_ccm_read,
     .write = imx6_ccm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         /*
          * Our device would not work correctly if the guest was doing
@@ -714,7 +714,7 @@ static const struct MemoryRegionOps imx6_ccm_ops = {
 static const struct MemoryRegionOps imx6_analog_ops = {
     .read = imx6_analog_read,
     .write = imx6_analog_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 8ab18967b5..c3fbcdd425 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -263,7 +263,7 @@ static void imx6_src_write(void *opaque, hwaddr offset, uint64_t value,
 static const struct MemoryRegionOps imx6_src_ops = {
     .read = imx6_src_read,
     .write = imx6_src_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index a2fc1d0364..84960c1f67 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -802,7 +802,7 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
 static const struct MemoryRegionOps imx6ul_ccm_ops = {
     .read = imx6ul_ccm_read,
     .write = imx6ul_ccm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         /*
          * Our device would not work correctly if the guest was doing
@@ -819,7 +819,7 @@ static const struct MemoryRegionOps imx6ul_ccm_ops = {
 static const struct MemoryRegionOps imx6ul_analog_ops = {
     .read = imx6ul_analog_read,
     .write = imx6ul_analog_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
index 02fc1ae8d0..fa0b270ec0 100644
--- a/hw/misc/imx7_ccm.c
+++ b/hw/misc/imx7_ccm.c
@@ -117,7 +117,7 @@ static void imx7_set_clr_tog_write(void *opaque, hwaddr offset,
 static const struct MemoryRegionOps imx7_set_clr_tog_ops = {
     .read = imx7_set_clr_tog_read,
     .write = imx7_set_clr_tog_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         /*
          * Our device would not work correctly if the guest was doing
@@ -133,7 +133,7 @@ static const struct MemoryRegionOps imx7_set_clr_tog_ops = {
 
 static const struct MemoryRegionOps imx7_digprog_ops = {
     .read = imx7_set_clr_tog_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/imx7_gpr.c b/hw/misc/imx7_gpr.c
index b03341a2eb..31f0b17a5a 100644
--- a/hw/misc/imx7_gpr.c
+++ b/hw/misc/imx7_gpr.c
@@ -78,7 +78,7 @@ static void imx7_gpr_write(void *opaque, hwaddr offset,
 static const struct MemoryRegionOps imx7_gpr_ops = {
     .read = imx7_gpr_read,
     .write = imx7_gpr_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index 45972a5920..ff299fe700 100644
--- a/hw/misc/imx7_snvs.c
+++ b/hw/misc/imx7_snvs.c
@@ -37,7 +37,7 @@ static void imx7_snvs_write(void *opaque, hwaddr offset,
 static const struct MemoryRegionOps imx7_snvs_ops = {
     .read = imx7_snvs_read,
     .write = imx7_snvs_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 5e3b05eae0..a2b2d5c09e 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -276,7 +276,7 @@ static uint64_t ivshmem_io_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps ivshmem_mmio_ops = {
     .read = ivshmem_io_read,
     .write = ivshmem_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index 61e86e6b34..2c11e87e5b 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -113,7 +113,7 @@ static const MemoryRegionOps hpdmc_mmio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void milkymist_hpdmc_reset(DeviceState *d)
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 516825e83d..9882ba0a0f 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -476,7 +476,7 @@ static const MemoryRegionOps pfpu_mmio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void milkymist_pfpu_reset(DeviceState *d)
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 8176d91c0c..f5c324c7ec 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -170,7 +170,7 @@ static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
 static const MemoryRegionOps gcr_ops = {
     .read = gcr_read,
     .write = gcr_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .max_access_size = 8,
     },
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 19ea016b87..b9720fd506 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -113,7 +113,7 @@ static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
 static const MemoryRegionOps cpc_ops = {
     .read = cpc_read,
     .write = cpc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .max_access_size = 8,
     },
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index ea0cf9726b..2918135bcb 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -142,7 +142,7 @@ static const MemoryRegionOps itc_tag_ops = {
     .impl = {
         .max_access_size = 8,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static inline uint32_t get_num_cells(MIPSITUState *s)
@@ -483,7 +483,7 @@ static void itc_storage_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps itc_storage_ops = {
     .read = itc_storage_read,
     .write = itc_storage_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void itc_reset_cells(MIPSITUState *s)
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 57f13db266..3961379558 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -365,7 +365,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 static const MemoryRegionOps mos6522_ops = {
     .read = mos6522_read,
     .write = mos6522_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index ddc5a30c80..211e1909ad 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -96,7 +96,7 @@ static void msf2_sysreg_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps sysreg_ops = {
     .read = msf2_sysreg_read,
     .write = msf2_sysreg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void msf2_sysreg_init(Object *obj)
diff --git a/hw/misc/mst_fpga.c b/hw/misc/mst_fpga.c
index 81abdf8ede..5a0f3a2511 100644
--- a/hw/misc/mst_fpga.c
+++ b/hw/misc/mst_fpga.c
@@ -192,7 +192,7 @@ mst_fpga_writeb(void *opaque, hwaddr addr, uint64_t value,
 static const MemoryRegionOps mst_fpga_ops = {
 	.read = mst_fpga_readb,
 	.write = mst_fpga_writeb,
-	.endianness = DEVICE_NATIVE_ENDIAN,
+	.endianness = MO_TE,
 };
 
 static int mst_fpga_post_load(void *opaque, int version_id)
diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
index 10de7a5523..93bf6c69cd 100644
--- a/hw/misc/omap_gpmc.c
+++ b/hw/misc/omap_gpmc.c
@@ -213,7 +213,7 @@ static void omap_nand_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_nand_ops = {
     .read = omap_nand_read,
     .write = omap_nand_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void fill_prefetch_fifo(struct omap_gpmc_s *s)
@@ -370,7 +370,7 @@ static void omap_gpmc_prefetch_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_prefetch_ops = {
     .read = omap_gpmc_prefetch_read,
     .write = omap_gpmc_prefetch_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl.min_access_size = 1,
     .impl.max_access_size = 1,
 };
@@ -820,7 +820,7 @@ static void omap_gpmc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_gpmc_ops = {
     .read = omap_gpmc_read,
     .write = omap_gpmc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct omap_gpmc_s *omap_gpmc_init(struct omap_mpu_state_s *mpu,
diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
index 61b6df564a..531b77eac9 100644
--- a/hw/misc/omap_l4.c
+++ b/hw/misc/omap_l4.c
@@ -106,7 +106,7 @@ static void omap_l4ta_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_l4ta_ops = {
     .read = omap_l4ta_read,
     .write = omap_l4ta_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct omap_target_agent_s *omap_l4ta_get(struct omap_l4_s *bus,
diff --git a/hw/misc/omap_sdrc.c b/hw/misc/omap_sdrc.c
index f2f72f6810..c9a0e5647f 100644
--- a/hw/misc/omap_sdrc.c
+++ b/hw/misc/omap_sdrc.c
@@ -151,7 +151,7 @@ static void omap_sdrc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_sdrc_ops = {
     .read = omap_sdrc_read,
     .write = omap_sdrc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct omap_sdrc_s *omap_sdrc_init(MemoryRegion *sysmem,
diff --git a/hw/misc/omap_tap.c b/hw/misc/omap_tap.c
index 3f595e8df7..d005ac2093 100644
--- a/hw/misc/omap_tap.c
+++ b/hw/misc/omap_tap.c
@@ -106,7 +106,7 @@ static void omap_tap_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_tap_ops = {
     .read = omap_tap_read,
     .write = omap_tap_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 void omap_tap_init(struct omap_target_agent_s *ta,
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index 279b38dfc7..c41bc49137 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -144,7 +144,7 @@ static uint64_t slavio_cfg_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_cfg_mem_ops = {
     .read = slavio_cfg_mem_readb,
     .write = slavio_cfg_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -174,7 +174,7 @@ static uint64_t slavio_diag_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_diag_mem_ops = {
     .read = slavio_diag_mem_readb,
     .write = slavio_diag_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -204,7 +204,7 @@ static uint64_t slavio_mdm_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_mdm_mem_ops = {
     .read = slavio_mdm_mem_readb,
     .write = slavio_mdm_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -242,7 +242,7 @@ static uint64_t slavio_aux1_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_aux1_mem_ops = {
     .read = slavio_aux1_mem_readb,
     .write = slavio_aux1_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -279,7 +279,7 @@ static uint64_t slavio_aux2_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_aux2_mem_ops = {
     .read = slavio_aux2_mem_readb,
     .write = slavio_aux2_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -307,7 +307,7 @@ static uint64_t apc_mem_readb(void *opaque, hwaddr addr,
 static const MemoryRegionOps apc_mem_ops = {
     .read = apc_mem_readb,
     .write = apc_mem_writeb,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -352,7 +352,7 @@ static void slavio_sysctrl_mem_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_sysctrl_mem_ops = {
     .read = slavio_sysctrl_mem_readl,
     .write = slavio_sysctrl_mem_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -394,7 +394,7 @@ static void slavio_led_mem_writew(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_led_mem_ops = {
     .read = slavio_led_mem_readw,
     .write = slavio_led_mem_writew,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 2,
         .max_access_size = 2,
diff --git a/hw/misc/stm32f2xx_syscfg.c b/hw/misc/stm32f2xx_syscfg.c
index aa59b43549..1efe7e25a1 100644
--- a/hw/misc/stm32f2xx_syscfg.c
+++ b/hw/misc/stm32f2xx_syscfg.c
@@ -126,7 +126,7 @@ static void stm32f2xx_syscfg_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps stm32f2xx_syscfg_ops = {
     .read = stm32f2xx_syscfg_read,
     .write = stm32f2xx_syscfg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void stm32f2xx_syscfg_init(Object *obj)
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 0e1cb24629..5c4f36de06 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -46,7 +46,7 @@ static const MemoryRegionOps unimp_ops = {
     .impl.max_access_size = 8,
     .valid.min_access_size = 1,
     .valid.max_access_size = 8,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void unimp_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/zynq-xadc.c b/hw/misc/zynq-xadc.c
index 7b1972ce06..2d0cca75eb 100644
--- a/hw/misc/zynq-xadc.c
+++ b/hw/misc/zynq-xadc.c
@@ -251,7 +251,7 @@ static void zynq_xadc_write(void *opaque, hwaddr offset, uint64_t val,
 static const MemoryRegionOps xadc_ops = {
     .read = zynq_xadc_read,
     .write = zynq_xadc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void zynq_xadc_init(Object *obj)
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index b9a38272d9..1c0076ef5d 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -415,7 +415,7 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps slcr_ops = {
     .read = zynq_slcr_read,
     .write = zynq_slcr_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void zynq_slcr_init(Object *obj)
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a5678e11fa..f3c1e55390 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -654,7 +654,7 @@ static const MemoryRegionOps dp8393x_ops = {
     .write = dp8393x_write,
     .impl.min_access_size = 2,
     .impl.max_access_size = 2,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void dp8393x_watchdog(void *opaque)
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 8451c17fb8..d6cf92bf8d 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -283,7 +283,7 @@ static void etsec_write(void     *opaque,
 static const MemoryRegionOps etsec_ops = {
     .read = etsec_read,
     .write = etsec_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 8fcf354a4b..3e50bc3959 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -626,7 +626,7 @@ static ssize_t mcf_fec_receive(NetClientState *nc, const uint8_t *buf, size_t si
 static const MemoryRegionOps mcf_fec_ops = {
     .read = mcf_fec_read,
     .write = mcf_fec_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static NetClientInfo net_mcf_fec_info = {
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 86b6d28033..bd2731006a 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -433,7 +433,7 @@ static const MemoryRegionOps minimac2_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void milkymist_minimac2_reset(DeviceState *d)
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 384e72b157..ee38ff2e65 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -168,7 +168,7 @@ eth_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps eth_ops = {
     .read = eth_read,
     .write = eth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index ad8b2fc670..2da4af8f5a 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -91,7 +91,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
 
     /* Register: Altera 16550 UART */
     serial_mm_init(address_space_mem, 0xf8001600, 2, irq[1], 115200,
-                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                   serial_hd(0), MO_TE);
 
     /* Register: Timer sys_clk_timer  */
     dev = qdev_create(NULL, "ALTR.timer");
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 79e70493fc..51b0c5c46b 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -166,7 +166,7 @@ static void openrisc_sim_init(MachineState *machine)
     }
 
     serial_mm_init(get_system_memory(), 0x90000000, 0, serial_irq,
-                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                   115200, serial_hd(0), MO_TE);
 
     openrisc_load_kernel(ram_size, kernel_filename);
 }
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index ceee463a11..8c302ee0d5 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -313,7 +313,7 @@ static uint64_t bonito_readl(void *opaque, hwaddr addr,
 static const MemoryRegionOps bonito_ops = {
     .read = bonito_readl,
     .write = bonito_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -346,7 +346,7 @@ static uint64_t bonito_pciconf_readl(void *opaque, hwaddr addr,
 static const MemoryRegionOps bonito_pciconf_ops = {
     .read = bonito_pciconf_readl,
     .write = bonito_pciconf_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -383,7 +383,7 @@ static void bonito_ldma_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps bonito_ldma_ops = {
     .read = bonito_ldma_readl,
     .write = bonito_ldma_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -420,7 +420,7 @@ static void bonito_cop_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps bonito_cop_ops = {
     .read = bonito_cop_readl,
     .write = bonito_cop_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -526,7 +526,7 @@ static const MemoryRegionOps bonito_spciconf_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 #define BONITO_IRQ_BASE 32
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 14e4dfe8b1..09ba6c3efd 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -117,19 +117,19 @@ static void pxa2xx_pcmcia_io_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pxa2xx_pcmcia_common_ops = {
     .read = pxa2xx_pcmcia_common_read,
     .write = pxa2xx_pcmcia_common_write,
-    .endianness = DEVICE_NATIVE_ENDIAN
+    .endianness = MO_TE
 };
 
 static const MemoryRegionOps pxa2xx_pcmcia_attr_ops = {
     .read = pxa2xx_pcmcia_attr_read,
     .write = pxa2xx_pcmcia_attr_write,
-    .endianness = DEVICE_NATIVE_ENDIAN
+    .endianness = MO_TE
 };
 
 static const MemoryRegionOps pxa2xx_pcmcia_io_ops = {
     .read = pxa2xx_pcmcia_io_read,
     .write = pxa2xx_pcmcia_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN
+    .endianness = MO_TE
 };
 
 static void pxa2xx_pcmcia_set_irq(void *opaque, int line, int level)
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 388cae0b43..e98933fb55 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -383,7 +383,7 @@ static const MemoryRegionOps taihu_cpld_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void taihu_cpld_reset (void *opaque)
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 381720aced..97f0c8687a 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -724,7 +724,7 @@ static void ppc405_gpio_write(void *opaque, hwaddr addr, uint64_t value,
 static const MemoryRegionOps ppc405_gpio_ops = {
     .read = ppc405_gpio_read,
     .write = ppc405_gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void ppc405_gpio_reset (void *opaque)
@@ -1106,7 +1106,7 @@ static const MemoryRegionOps gpt_ops = {
     .write = ppc4xx_gpt_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void ppc4xx_gpt_cb (void *opaque)
diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index 9837b6166f..65cfd22280 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -75,7 +75,7 @@ static void sifive_prci_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sifive_prci_ops = {
     .read = sifive_prci_read,
     .write = sifive_prci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index afbb3aaf34..401755f477 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -53,7 +53,7 @@ static void sifive_test_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sifive_test_ops = {
     .read = sifive_test_read,
     .write = sifive_test_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index 9de42b1680..829d52ccf9 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -134,7 +134,7 @@ uart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps uart_ops = {
     .read = uart_read,
     .write = uart_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 841d79b60e..531cfeff89 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -637,7 +637,7 @@ static uint64_t sysbus_esp_mem_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps sysbus_esp_mem_ops = {
     .read = sysbus_esp_mem_read,
     .write = sysbus_esp_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid.accepts = esp_mem_accepts,
 };
 
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 4a80fbcc86..6b56e2eb91 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -372,7 +372,7 @@ static void bcm2835_sdhost_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps bcm2835_sdhost_ops = {
     .read = bcm2835_sdhost_read,
     .write = bcm2835_sdhost_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static const VMStateDescription vmstate_bcm2835_sdhost = {
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 926e1af475..d66a1ccf2a 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -236,7 +236,7 @@ static const MemoryRegionOps memcard_mmio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void milkymist_memcard_reset(DeviceState *d)
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index c6e516b611..6f9cf61c40 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -571,7 +571,7 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps omap_mmc_ops = {
     .read = omap_mmc_read,
     .write = omap_mmc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void omap_mmc_cover_cb(void *opaque, int line, int level)
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 8f9ab0ec16..431e5e0415 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -472,7 +472,7 @@ static void pxa2xx_mmci_write(void *opaque,
 static const MemoryRegionOps pxa2xx_mmci_ops = {
     .read = pxa2xx_mmci_read,
     .write = pxa2xx_mmci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index ee0840f380..6b59eb99d9 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -179,7 +179,7 @@ static const MemoryRegionOps r2d_fpga_ops = {
     .write = r2d_fpga_write,
     .impl.min_access_size = 2,
     .impl.max_access_size = 2,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static qemu_irq *r2d_fpga_init(MemoryRegion *sysmem,
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index d660714443..696052c56f 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -488,7 +488,7 @@ static const MemoryRegionOps sh7750_mem_ops = {
     .write = sh7750_mem_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 /* sh775x interrupt controller tables for sh_intc.c
@@ -749,7 +749,7 @@ static void sh7750_mmct_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sh7750_mmct_ops = {
     .read = sh7750_mmct_read,
     .write = sh7750_mmct_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 71afd23b67..133a5ac5ae 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -104,7 +104,7 @@ static uint64_t sh_pci_reg_read (void *p, hwaddr addr,
 static const MemoryRegionOps sh_pci_reg_ops = {
     .read = sh_pci_reg_read,
     .write = sh_pci_reg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index ccf46a5147..8f8546e5ae 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -238,7 +238,7 @@ static void iommu_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps iommu_mem_ops = {
     .read = iommu_mem_read,
     .write = iommu_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 1ded2a4c9a..a5d2ee9ba2 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -252,7 +252,7 @@ static void power_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps power_mem_ops = {
     .read = power_mem_read,
     .write = power_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 2dd9a631e1..e9257c517e 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -398,7 +398,7 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
 static const struct MemoryRegionOps imx_spi_ops = {
     .read = imx_spi_read,
     .write = imx_spi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/ssi/omap_spi.c b/hw/ssi/omap_spi.c
index 7c7e689707..08e593bf15 100644
--- a/hw/ssi/omap_spi.c
+++ b/hw/ssi/omap_spi.c
@@ -344,7 +344,7 @@ static void omap_mcspi_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_mcspi_ops = {
     .read = omap_mcspi_read,
     .write = omap_mcspi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct omap_mcspi_s *omap_mcspi_init(struct omap_target_agent_s *ta, int chnum,
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index a1be0de039..be0fe71bcb 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -315,7 +315,7 @@ done:
 static const MemoryRegionOps spi_ops = {
     .read = spi_read,
     .write = spi_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index ca5a905059..94fc234503 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -181,7 +181,7 @@ static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps a10_pit_ops = {
     .read = a10_pit_read,
     .write = a10_pit_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static Property a10_pit_properties[] = {
diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index 936b31311d..5fbe700ecd 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -147,7 +147,7 @@ static void timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index 021c4ef714..59a5796a42 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -122,7 +122,7 @@ static const MemoryRegionOps digic_timer_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void digic_timer_init(Object *obj)
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 77b9af05f4..903449f176 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1416,7 +1416,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps exynos4210_mct_ops = {
     .read = exynos4210_mct_read,
     .write = exynos4210_mct_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 /* MCT init */
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index b7fad2ad44..840c74c8db 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -377,7 +377,7 @@ static void exynos4210_pwm_reset(DeviceState *d)
 static const MemoryRegionOps exynos4210_pwm_ops = {
     .read = exynos4210_pwm_read,
     .write = exynos4210_pwm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 /*
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index ea68904229..7928e3e61a 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -545,7 +545,7 @@ static void exynos4210_rtc_reset(DeviceState *d)
 static const MemoryRegionOps exynos4210_rtc_ops = {
     .read = exynos4210_rtc_read,
     .write = exynos4210_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 /*
diff --git a/hw/timer/omap_gptimer.c b/hw/timer/omap_gptimer.c
index c407190138..ed53d5a43b 100644
--- a/hw/timer/omap_gptimer.c
+++ b/hw/timer/omap_gptimer.c
@@ -489,7 +489,7 @@ static const MemoryRegionOps omap_gp_timer_ops = {
     .write = omap_gp_timer_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct omap_gp_timer_s *omap_gp_timer_init(struct omap_target_agent_s *ta,
diff --git a/hw/timer/omap_synctimer.c b/hw/timer/omap_synctimer.c
index 72b997939b..a3fc08cbf1 100644
--- a/hw/timer/omap_synctimer.c
+++ b/hw/timer/omap_synctimer.c
@@ -93,7 +93,7 @@ static const MemoryRegionOps omap_synctimer_ops = {
     .write = omap_synctimer_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 struct omap_synctimer_s *omap_synctimer_init(struct omap_target_agent_s *ta,
diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 6fe370049b..f1d8a25ecd 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -99,7 +99,7 @@ static const MemoryRegionOps puv3_ost_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void puv3_ost_tick(void *opaque)
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 311cd38aac..5764a6ba91 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -401,7 +401,7 @@ static void pxa2xx_timer_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pxa2xx_timer_ops = {
     .read = pxa2xx_timer_read,
     .write = pxa2xx_timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void pxa2xx_timer_tick(void *opaque)
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index adcc0c138e..80d1571379 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -303,7 +303,7 @@ static void tmu012_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps tmu012_ops = {
     .read = tmu012_read,
     .write = tmu012_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 void tmu012_init(MemoryRegion *sysmem, hwaddr base,
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 38fd32b62a..8b8494735b 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -322,7 +322,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_timer_mem_ops = {
     .read = slavio_timer_mem_readl,
     .write = slavio_timer_mem_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 355518232c..c31d7d7333 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -189,7 +189,7 @@ timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/usb/chipidea.c b/hw/usb/chipidea.c
index 3dcd22ccba..5085a7fcfd 100644
--- a/hw/usb/chipidea.c
+++ b/hw/usb/chipidea.c
@@ -35,7 +35,7 @@ static void chipidea_write(void *opaque, hwaddr offset,
 static const struct MemoryRegionOps chipidea_ops = {
     .read = chipidea_read,
     .write = chipidea_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         /*
          * Our device would not work correctly if the guest was doing
@@ -76,7 +76,7 @@ static void chipidea_dc_write(void *opaque, hwaddr offset,
 static const struct MemoryRegionOps chipidea_dc_ops = {
     .read = chipidea_dc_read,
     .write = chipidea_dc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .impl = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 17580876c6..cf1f6b6cfb 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -679,7 +679,7 @@ static const MemoryRegionOps tusb_async_ops = {
     .write = tusb_async_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void tusb_otg_tick(void *opaque)
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index eccc795f28..25f72fb374 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -316,7 +316,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps virtio_mem_ops = {
     .read = virtio_mmio_read,
     .write = virtio_mmio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 8fbaf2eae9..794a1f5a32 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -437,7 +437,7 @@ static void xen_pt_bar_write(void *o, hwaddr addr, uint64_t val,
 }
 
 static const MemoryRegionOps ops = {
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .read = xen_pt_bar_read,
     .write = xen_pt_bar_write,
 };
diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index fb4b887b92..d12cc1f923 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -507,7 +507,7 @@ static bool pci_msix_accepts(void *opaque, hwaddr addr,
 static const MemoryRegionOps pci_msix_ops = {
     .read = pci_msix_read,
     .write = pci_msix_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index d889f953d1..f4f509ad7a 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -266,7 +266,7 @@ static void xtensa_mx_pic_ext_reg_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps xtensa_mx_pic_ops = {
     .read = xtensa_mx_pic_ext_reg_read,
     .write = xtensa_mx_pic_ext_reg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
     .valid = {
         .unaligned = true,
     },
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 8220c7a379..70c256f87e 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -121,7 +121,7 @@ static void xtfpga_fpga_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps xtfpga_fpga_ops = {
     .read = xtfpga_fpga_read,
     .write = xtfpga_fpga_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static XtfpgaFpgaState *xtfpga_fpga_init(MemoryRegion *address_space,
@@ -216,7 +216,7 @@ static void xtfpga_io_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps xtfpga_io_ops = {
     .read = xtfpga_io_read,
     .write = xtfpga_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
@@ -315,7 +315,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     }
 
     serial_mm_init(system_io, 0x0d050020, 2, extints[0],
-                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                   115200, serial_hd(0), MO_TE);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (dinfo) {
diff --git a/ioport.c b/ioport.c
index 04e360e79a..c8a4128d33 100644
--- a/ioport.c
+++ b/ioport.c
@@ -51,7 +51,7 @@ static void unassigned_io_write(void *opaque, hwaddr addr, uint64_t val,
 const MemoryRegionOps unassigned_io_ops = {
     .read = unassigned_io_read,
     .write = unassigned_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 void cpu_outb(uint32_t addr, uint8_t val)
diff --git a/memory.c b/memory.c
index f30ce520c9..7578ad1dfd 100644
--- a/memory.c
+++ b/memory.c
@@ -1298,7 +1298,7 @@ static bool unassigned_mem_accepts(void *opaque, hwaddr addr,
 
 const MemoryRegionOps unassigned_mem_ops = {
     .valid.accepts = unassigned_mem_accepts,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = MO_TE,
 };
 
 static uint64_t memory_region_ram_device_read(void *opaque,
@@ -3277,7 +3277,7 @@ MemOp devend_memop(enum device_endian end)
     static MemOp conv[] = {
         [DEVICE_LITTLE_ENDIAN] = MO_LE,
         [DEVICE_BIG_ENDIAN] = MO_BE,
-        [DEVICE_NATIVE_ENDIAN] = MO_TE,
+        [MO_TE] = MO_TE,
         [DEVICE_HOST_ENDIAN] = 0,
     };
     switch (end) {
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index c54aee4a95..b321da28de 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -70,7 +70,7 @@ uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
+                                                    MO_TE);
 }
 
 uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
@@ -138,7 +138,7 @@ uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
+                                                    MO_TE);
 }
 
 uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
@@ -240,7 +240,7 @@ uint32_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_lduw_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                     DEVICE_NATIVE_ENDIAN);
+                                                     MO_TE);
 }
 
 uint32_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
@@ -344,7 +344,7 @@ void glue(address_space_stl, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
-                                             result, DEVICE_NATIVE_ENDIAN);
+                                             result, MO_TE);
 }
 
 void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
@@ -440,7 +440,7 @@ void glue(address_space_stw, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stw_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_NATIVE_ENDIAN);
+                                             MO_TE);
 }
 
 void glue(address_space_stw_le, SUFFIX)(ARG1_DECL,
@@ -504,7 +504,7 @@ void glue(address_space_stq, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_NATIVE_ENDIAN);
+                                             MO_TE);
 }
 
 void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
-- 
2.23.0


