Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8067C74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBDA20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBDA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYDk-0006VW-H0
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53283)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hlYBm-0004zq-CF
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hlYBc-0001sc-01
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54104)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hlYBb-0001pY-5N
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2F1830842AC;
 Thu, 11 Jul 2019 12:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1F9560BFC;
 Thu, 11 Jul 2019 12:28:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 76C1D113860E; Thu, 11 Jul 2019 14:28:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 14:28:27 +0200
Message-Id: <20190711122827.18970-4-armbru@redhat.com>
In-Reply-To: <20190711122827.18970-1-armbru@redhat.com>
References: <20190711122827.18970-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 11 Jul 2019 12:28:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC v5 3/3] tests: Check target-independent
 headers for each target, too
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Testing target-independent headers for each target is massive
overkill, and may well be inacceptably slow.  But let's see what
explodes.

Numerous target-independent headers don't pass this test, by design or
by accident.  Fortunately, they all fail for a user emulation target.

Most failing headers may not be included into user emulation code:
they include hw/hw.h.  Mark them with a comment

    /* NOTE: May not be included into user emulation code */

so that the test skips them for user emulation targets.

Add the customary

    /* FIXME Does not pass make check-headers for user emulation, yet! */

to the remaining ones.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/exec/ioport.h                    |  2 ++
 include/hw/acpi/acpi.h                   |  2 ++
 include/hw/acpi/acpi_dev_interface.h     |  2 ++
 include/hw/acpi/cpu.h                    |  3 +++
 include/hw/acpi/cpu_hotplug.h            |  2 ++
 include/hw/acpi/ich9.h                   |  2 ++
 include/hw/acpi/memory_hotplug.h         |  2 ++
 include/hw/acpi/pcihp.h                  |  2 ++
 include/hw/acpi/tco.h                    |  2 ++
 include/hw/acpi/utils.h                  |  2 ++
 include/hw/acpi/vmgenid.h                |  2 ++
 include/hw/adc/stm32f2xx_adc.h           |  2 ++
 include/hw/arm/aspeed.h                  |  3 +++
 include/hw/arm/exynos4210.h              |  2 ++
 include/hw/arm/pxa.h                     |  2 ++
 include/hw/arm/smmu-common.h             |  3 ++-
 include/hw/arm/smmuv3.h                  |  2 ++
 include/hw/arm/soc_dma.h                 |  2 ++
 include/hw/arm/virt.h                    |  2 ++
 include/hw/arm/xlnx-versal.h             |  2 ++
 include/hw/audio/pcspk.h                 |  2 ++
 include/hw/audio/wm8750.h                |  3 +++
 include/hw/block/flash.h                 |  2 ++
 include/hw/boards.h                      |  2 ++
 include/hw/char/bcm2835_aux.h            |  2 ++
 include/hw/char/cadence_uart.h           |  2 ++
 include/hw/char/cmsdk-apb-uart.h         |  2 ++
 include/hw/char/digic-uart.h             |  3 ++-
 include/hw/char/escc.h                   |  2 ++
 include/hw/char/imx_serial.h             |  2 ++
 include/hw/char/lm32_juart.h             |  2 ++
 include/hw/char/nrf51_uart.h             |  2 ++
 include/hw/char/parallel.h               |  2 ++
 include/hw/char/pl011.h                  |  2 ++
 include/hw/char/serial.h                 |  2 ++
 include/hw/char/stm32f2xx_usart.h        |  2 ++
 include/hw/char/xilinx_uartlite.h        |  2 ++
 include/hw/core/split-irq.h              |  3 +++
 include/hw/cpu/a15mpcore.h               |  3 +++
 include/hw/cpu/a9mpcore.h                |  3 +++
 include/hw/cpu/arm11mpcore.h             |  2 ++
 include/hw/cpu/cluster.h                 |  3 +++
 include/hw/cpu/core.h                    |  3 +++
 include/hw/cris/etraxfs.h                |  2 ++
 include/hw/display/edid.h                |  2 ++
 include/hw/display/i2c-ddc.h             |  2 ++
 include/hw/display/milkymist_tmu2.h      |  3 ++-
 include/hw/display/vga.h                 |  3 +++
 include/hw/dma/bcm2835_dma.h             |  2 ++
 include/hw/dma/i8257.h                   |  2 ++
 include/hw/dma/pl080.h                   |  2 ++
 include/hw/dma/xlnx-zdma.h               |  2 ++
 include/hw/dma/xlnx-zynq-devcfg.h        |  2 ++
 include/hw/gpio/bcm2835_gpio.h           |  2 ++
 include/hw/gpio/imx_gpio.h               |  2 ++
 include/hw/gpio/nrf51_gpio.h             |  4 +++-
 include/hw/hw.h                          |  2 ++
 include/hw/i2c/aspeed_i2c.h              |  2 ++
 include/hw/i2c/bitbang_i2c.h             |  2 ++
 include/hw/i2c/i2c.h                     |  2 ++
 include/hw/i2c/imx_i2c.h                 |  3 ++-
 include/hw/i2c/microbit_i2c.h            |  2 ++
 include/hw/i2c/pm_smbus.h                |  2 ++
 include/hw/i2c/ppc4xx_i2c.h              |  2 ++
 include/hw/i2c/smbus_eeprom.h            |  2 ++
 include/hw/i2c/smbus_master.h            |  2 ++
 include/hw/i2c/smbus_slave.h             |  2 ++
 include/hw/i386/ich9.h                   |  2 ++
 include/hw/i386/intel_iommu.h            |  2 ++
 include/hw/i386/ioapic_internal.h        |  2 ++
 include/hw/i386/pc.h                     |  2 ++
 include/hw/i386/x86-iommu.h              |  2 ++
 include/hw/ide.h                         |  2 ++
 include/hw/ide/ahci.h                    |  3 ++-
 include/hw/ide/internal.h                |  2 ++
 include/hw/ide/pci.h                     |  2 ++
 include/hw/input/adb.h                   |  2 ++
 include/hw/input/i8042.h                 |  3 +++
 include/hw/intc/allwinner-a10-pic.h      |  2 ++
 include/hw/intc/arm_gic.h                |  2 ++
 include/hw/intc/arm_gic_common.h         |  2 ++
 include/hw/intc/arm_gicv3.h              |  2 ++
 include/hw/intc/arm_gicv3_common.h       |  2 ++
 include/hw/intc/arm_gicv3_its_common.h   |  2 ++
 include/hw/intc/aspeed_vic.h             |  3 +++
 include/hw/intc/bcm2835_ic.h             |  2 ++
 include/hw/intc/bcm2836_control.h        |  2 ++
 include/hw/intc/heathrow_pic.h           |  2 ++
 include/hw/intc/imx_avic.h               |  3 +++
 include/hw/intc/imx_gpcv2.h              |  2 ++
 include/hw/intc/realview_gic.h           |  2 ++
 include/hw/intc/xlnx-pmu-iomod-intc.h    |  2 ++
 include/hw/intc/xlnx-zynqmp-ipi.h        |  2 ++
 include/hw/ipack/ipack.h                 |  2 ++
 include/hw/ipmi/ipmi.h                   |  2 ++
 include/hw/isa/apm.h                     |  2 ++
 include/hw/isa/i8259_internal.h          |  2 ++
 include/hw/isa/isa.h                     |  2 ++
 include/hw/isa/pc87312.h                 |  3 +++
 include/hw/isa/superio.h                 |  3 +++
 include/hw/loader.h                      |  2 ++
 include/hw/mem/memory-device.h           |  2 ++
 include/hw/mem/nvdimm.h                  |  2 ++
 include/hw/mem/pc-dimm.h                 |  3 ++-
 include/hw/misc/a9scu.h                  |  3 +++
 include/hw/misc/arm11scu.h               |  2 ++
 include/hw/misc/armsse-cpuid.h           |  2 ++
 include/hw/misc/armsse-mhu.h             |  2 ++
 include/hw/misc/aspeed_scu.h             |  3 +++
 include/hw/misc/aspeed_sdmc.h            |  3 +++
 include/hw/misc/aspeed_xdma.h            |  2 ++
 include/hw/misc/auxbus.h                 |  3 ++-
 include/hw/misc/bcm2835_mbox.h           |  2 ++
 include/hw/misc/bcm2835_rng.h            |  2 ++
 include/hw/misc/imx25_ccm.h              |  2 ++
 include/hw/misc/imx2_wdt.h               |  2 ++
 include/hw/misc/imx31_ccm.h              |  2 ++
 include/hw/misc/imx6_ccm.h               |  2 ++
 include/hw/misc/imx6_src.h               |  2 ++
 include/hw/misc/imx6ul_ccm.h             |  2 ++
 include/hw/misc/imx7_ccm.h               |  2 ++
 include/hw/misc/imx7_gpr.h               |  2 ++
 include/hw/misc/imx7_snvs.h              |  2 ++
 include/hw/misc/imx_ccm.h                |  2 ++
 include/hw/misc/iotkit-secctl.h          |  2 ++
 include/hw/misc/iotkit-sysctl.h          |  2 ++
 include/hw/misc/iotkit-sysinfo.h         |  2 ++
 include/hw/misc/macio/cuda.h             |  2 ++
 include/hw/misc/macio/gpio.h             |  2 ++
 include/hw/misc/macio/macio.h            |  2 ++
 include/hw/misc/macio/pmu.h              |  2 ++
 include/hw/misc/mips_cmgcr.h             |  3 ++-
 include/hw/misc/mips_cpc.h               |  2 ++
 include/hw/misc/mips_itu.h               |  2 ++
 include/hw/misc/mos6522.h                |  2 ++
 include/hw/misc/mps2-fpgaio.h            |  2 ++
 include/hw/misc/mps2-scc.h               |  2 ++
 include/hw/misc/msf2-sysreg.h            |  2 ++
 include/hw/misc/nrf51_rng.h              |  3 ++-
 include/hw/misc/pca9552.h                |  3 +++
 include/hw/misc/stm32f2xx_syscfg.h       |  2 ++
 include/hw/misc/tz-mpc.h                 |  2 ++
 include/hw/misc/tz-msc.h                 |  2 ++
 include/hw/misc/tz-ppc.h                 |  2 ++
 include/hw/misc/unimp.h                  |  2 ++
 include/hw/misc/vmcoreinfo.h             |  4 +++-
 include/hw/misc/zynq-xadc.h              |  2 ++
 include/hw/net/allwinner_emac.h          |  3 ++-
 include/hw/net/cadence_gem.h             |  2 ++
 include/hw/net/ftgmac100.h               |  2 ++
 include/hw/net/imx_fec.h                 |  2 ++
 include/hw/net/lance.h                   |  2 ++
 include/hw/net/ne2000-isa.h              |  2 ++
 include/hw/nvram/fw_cfg.h                |  2 ++
 include/hw/nvram/nrf51_nvm.h             |  4 +++-
 include/hw/or-irq.h                      |  2 ++
 include/hw/pci-bridge/simba.h            |  2 ++
 include/hw/pci-host/designware.h         |  2 ++
 include/hw/pci-host/gpex.h               |  2 ++
 include/hw/pci-host/pam.h                |  2 ++
 include/hw/pci-host/q35.h                |  2 ++
 include/hw/pci-host/sabre.h              |  2 ++
 include/hw/pci-host/uninorth.h           |  2 ++
 include/hw/pci-host/xilinx-pcie.h        |  2 ++
 include/hw/pci/msi.h                     |  2 ++
 include/hw/pci/msix.h                    |  2 ++
 include/hw/pci/pci.h                     |  2 ++
 include/hw/pci/pci_bridge.h              |  3 ++-
 include/hw/pci/pci_bus.h                 |  2 ++
 include/hw/pci/pci_host.h                |  2 ++
 include/hw/pci/pcie.h                    |  2 ++
 include/hw/pci/pcie_aer.h                |  2 ++
 include/hw/pci/pcie_host.h               |  2 ++
 include/hw/pci/pcie_port.h               |  2 ++
 include/hw/pci/shpc.h                    |  2 ++
 include/hw/pcmcia.h                      |  2 ++
 include/hw/platform-bus.h                |  2 ++
 include/hw/ppc/mac_dbdma.h               |  2 ++
 include/hw/ppc/openpic.h                 |  2 ++
 include/hw/ppc/pnv_lpc.h                 |  2 ++
 include/hw/ppc/pnv_occ.h                 |  2 ++
 include/hw/ppc/pnv_psi.h                 |  2 ++
 include/hw/ppc/pnv_xive.h                |  2 ++
 include/hw/ppc/spapr_drc.h               |  2 ++
 include/hw/ppc/xics.h                    |  3 ++-
 include/hw/ppc/xive.h                    |  3 ++-
 include/hw/qdev.h                        |  2 ++
 include/hw/register.h                    |  2 ++
 include/hw/riscv/sifive_clint.h          |  2 ++
 include/hw/riscv/sifive_gpio.h           |  3 +++
 include/hw/riscv/sifive_plic.h           |  2 ++
 include/hw/riscv/sifive_prci.h           |  2 ++
 include/hw/riscv/sifive_test.h           |  2 ++
 include/hw/riscv/sifive_uart.h           |  2 ++
 include/hw/s390x/css-bridge.h            |  2 ++
 include/hw/s390x/event-facility.h        |  3 ++-
 include/hw/s390x/s390-virtio-ccw.h       |  3 +++
 include/hw/s390x/s390_flic.h             |  2 ++
 include/hw/s390x/sclp.h                  |  3 ++-
 include/hw/s390x/storage-keys.h          |  2 ++
 include/hw/s390x/tod.h                   |  2 ++
 include/hw/scsi/esp.h                    |  2 ++
 include/hw/scsi/scsi.h                   |  2 ++
 include/hw/sd/bcm2835_sdhost.h           |  2 ++
 include/hw/sd/sd.h                       |  2 ++
 include/hw/sd/sdhci.h                    |  2 ++
 include/hw/sh4/sh.h                      |  2 ++
 include/hw/sh4/sh_intc.h                 |  2 ++
 include/hw/sparc/grlib.h                 |  2 ++
 include/hw/sparc/sparc32_dma.h           |  2 ++
 include/hw/sparc/sun4m_iommu.h           |  2 ++
 include/hw/sparc/sun4u_iommu.h           |  2 ++
 include/hw/ssi/aspeed_smc.h              |  2 ++
 include/hw/ssi/imx_spi.h                 |  2 ++
 include/hw/ssi/mss-spi.h                 |  2 ++
 include/hw/ssi/pl022.h                   |  2 ++
 include/hw/ssi/ssi.h                     |  2 ++
 include/hw/ssi/stm32f2xx_spi.h           |  2 ++
 include/hw/ssi/xilinx_spips.h            |  2 ++
 include/hw/sysbus.h                      |  2 ++
 include/hw/timer/a9gtimer.h              |  2 ++
 include/hw/timer/allwinner-a10-pit.h     |  2 ++
 include/hw/timer/arm_mptimer.h           |  3 +++
 include/hw/timer/armv7m_systick.h        |  2 ++
 include/hw/timer/aspeed_rtc.h            |  3 +++
 include/hw/timer/aspeed_timer.h          |  3 +++
 include/hw/timer/cmsdk-apb-dualtimer.h   |  2 ++
 include/hw/timer/cmsdk-apb-timer.h       |  2 ++
 include/hw/timer/digic-timer.h           |  3 ++-
 include/hw/timer/i8254.h                 |  2 ++
 include/hw/timer/i8254_internal.h        |  2 ++
 include/hw/timer/imx_epit.h              |  2 ++
 include/hw/timer/imx_gpt.h               |  2 ++
 include/hw/timer/mc146818rtc.h           |  2 ++
 include/hw/timer/mss-timer.h             |  2 ++
 include/hw/timer/nrf51_timer.h           |  3 +++
 include/hw/timer/pl031.h                 |  2 ++
 include/hw/timer/stm32f2xx_timer.h       |  2 ++
 include/hw/timer/xlnx-zynqmp-rtc.h       |  2 ++
 include/hw/usb.h                         |  2 ++
 include/hw/usb/chipidea.h                |  2 ++
 include/hw/virtio/vhost-backend.h        |  3 ++-
 include/hw/virtio/vhost-scsi-common.h    |  3 ++-
 include/hw/virtio/vhost-scsi.h           |  3 ++-
 include/hw/virtio/vhost-user-blk.h       |  3 ++-
 include/hw/virtio/vhost-user-scsi.h      |  3 ++-
 include/hw/virtio/vhost-user.h           |  2 ++
 include/hw/virtio/vhost-vsock.h          |  2 ++
 include/hw/virtio/vhost.h                |  2 ++
 include/hw/virtio/virtio-balloon.h       |  3 ++-
 include/hw/virtio/virtio-blk.h           |  3 ++-
 include/hw/virtio/virtio-bus.h           |  3 ++-
 include/hw/virtio/virtio-crypto.h        |  2 ++
 include/hw/virtio/virtio-input.h         |  2 ++
 include/hw/virtio/virtio-net.h           |  3 ++-
 include/hw/virtio/virtio-pmem.h          |  2 ++
 include/hw/virtio/virtio-rng.h           |  2 ++
 include/hw/virtio/virtio-scsi.h          |  3 ++-
 include/hw/virtio/virtio-serial.h        |  3 ++-
 include/hw/virtio/virtio.h               |  3 ++-
 include/hw/watchdog/cmsdk-apb-watchdog.h |  2 ++
 include/hw/watchdog/wdt_aspeed.h         |  2 ++
 include/hw/watchdog/wdt_diag288.h        |  2 ++
 include/hw/xen/xen.h                     |  2 ++
 include/net/vhost_net.h                  |  2 ++
 include/qemu/iova-tree.h                 |  3 +++
 include/sysemu/balloon.h                 |  3 ++-
 include/sysemu/cryptodev-vhost-user.h    |  3 ++-
 include/sysemu/cryptodev-vhost.h         |  4 +++-
 include/sysemu/dma.h                     |  2 ++
 include/sysemu/hostmem.h                 |  2 ++
 include/sysemu/kvm_int.h                 |  3 ++-
 include/sysemu/numa.h                    |  2 ++
 include/sysemu/vhost-user-backend.h      |  3 +++
 include/sysemu/xen-mapcache.h            |  3 ++-
 tests/check-headers.mak                  | 14 ++++++++++----
 276 files changed, 590 insertions(+), 40 deletions(-)

diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index 97feb296d2..7368812ba4 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 /***********************************************************************=
***
  * IO ports API
  */
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index c91e2b9df2..1a42e077a4 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_HW_ACPI_H
 #define QEMU_HW_ACPI_H
=20
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_=
dev_interface.h
index 43ff119179..f169574f3c 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ACPI_DEV_INTERFACE_H
 #define ACPI_DEV_INTERFACE_H
=20
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 62f0278ba2..6b5e4efe1b 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -9,6 +9,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ACPI_CPU_H
 #define ACPI_CPU_H
=20
diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.=
h
index 3b932abbbb..63a1f7f1bb 100644
--- a/include/hw/acpi/cpu_hotplug.h
+++ b/include/hw/acpi/cpu_hotplug.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ACPI_CPU_HOTPLUG_H
 #define HW_ACPI_CPU_HOTPLUG_H
=20
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 41568d1837..2e2845afe6 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -18,6 +18,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ACPI_ICH9_H
 #define HW_ACPI_ICH9_H
=20
diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_ho=
tplug.h
index 77c65765d6..693f16e6d5 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_HW_ACPI_MEMORY_HOTPLUG_H
 #define QEMU_HW_ACPI_MEMORY_HOTPLUG_H
=20
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 8bc4a4c01d..79aa1e4868 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -24,6 +24,8 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ACPI_PCIHP_H
 #define HW_ACPI_PCIHP_H
=20
diff --git a/include/hw/acpi/tco.h b/include/hw/acpi/tco.h
index 726f840cce..a9079d4abd 100644
--- a/include/hw/acpi/tco.h
+++ b/include/hw/acpi/tco.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef HW_ACPI_TCO_H
 #define HW_ACPI_TCO_H
=20
diff --git a/include/hw/acpi/utils.h b/include/hw/acpi/utils.h
index 140b4de603..ac86b6f8ed 100644
--- a/include/hw/acpi/utils.h
+++ b/include/hw/acpi/utils.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ACPI_UTILS_H
 #define HW_ACPI_UTILS_H
=20
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index 38586ecbdf..fbeb4dd8a8 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ACPI_VMGENID_H
 #define ACPI_VMGENID_H
=20
diff --git a/include/hw/adc/stm32f2xx_adc.h b/include/hw/adc/stm32f2xx_ad=
c.h
index 663b79f4f3..f9eafe12b9 100644
--- a/include/hw/adc/stm32f2xx_adc.h
+++ b/include/hw/adc/stm32f2xx_adc.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_STM32F2XX_ADC_H
 #define HW_STM32F2XX_ADC_H
=20
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 02073a6b4d..42edd4a0fe 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -6,6 +6,9 @@
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ARM_ASPEED_H
 #define ARM_ASPEED_H
=20
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index f0f23b0e9b..04a9e38fc9 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -21,6 +21,8 @@
  *  with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef EXYNOS4210_H
 #define EXYNOS4210_H
=20
diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index f6dfb5c0cf..3a4e157cad 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -7,6 +7,8 @@
  * This code is licensed under the GNU GPL v2.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PXA_H
 #define PXA_H
=20
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 1f37844e5c..95b96e582d 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -13,9 +13,10 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ARM_SMMU_COMMON_H
 #define HW_ARM_SMMU_COMMON_H
=20
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 36b2f45253..cc1c7502b7 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -16,6 +16,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ARM_SMMUV3_H
 #define HW_ARM_SMMUV3_H
=20
diff --git a/include/hw/arm/soc_dma.h b/include/hw/arm/soc_dma.h
index fae322997e..6a8a9721ee 100644
--- a/include/hw/arm/soc_dma.h
+++ b/include/hw/arm/soc_dma.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef HW_SOC_DMA_H
 #define HW_SOC_DMA_H
=20
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index a72094204e..f317017823 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -27,6 +27,8 @@
  * This is essentially the same approach kvmtool uses.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_ARM_VIRT_H
 #define QEMU_ARM_VIRT_H
=20
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 14405c1465..fb703b19bb 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -9,6 +9,8 @@
  * (at your option) any later version.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef XLNX_VERSAL_H
 #define XLNX_VERSAL_H
=20
diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
index 172afbf146..70f3018608 100644
--- a/include/hw/audio/pcspk.h
+++ b/include/hw/audio/pcspk.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_PCSPK_H
 #define HW_PCSPK_H
=20
diff --git a/include/hw/audio/wm8750.h b/include/hw/audio/wm8750.h
index e12cb886d1..9781e81ac4 100644
--- a/include/hw/audio/wm8750.h
+++ b/include/hw/audio/wm8750.h
@@ -11,6 +11,9 @@
  * You should have received a copy of the GNU General Public License alo=
ng with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_DAC_WM8750_H
 #define HW_DAC_WM8750_H
=20
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 83a75f3170..170f9dff4d 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef HW_FLASH_H
 #define HW_FLASH_H
=20
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a71d1a53a5..ffd72515bc 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -1,5 +1,7 @@
 /* Declarations for use by board files for creating devices.  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_BOARDS_H
 #define HW_BOARDS_H
=20
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.=
h
index cdbf7e3e37..f0227d330d 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -5,6 +5,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef BCM2835_AUX_H
 #define BCM2835_AUX_H
=20
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uar=
t.h
index e1cf33e94c..3f76d3a4ae 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -16,6 +16,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef CADENCE_UART_H
 #define CADENCE_UART_H
=20
diff --git a/include/hw/char/cmsdk-apb-uart.h b/include/hw/char/cmsdk-apb=
-uart.h
index c41fba9a27..126b36fd7e 100644
--- a/include/hw/char/cmsdk-apb-uart.h
+++ b/include/hw/char/cmsdk-apb-uart.h
@@ -9,6 +9,8 @@
  *  (at your option) any later version.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef CMSDK_APB_UART_H
 #define CMSDK_APB_UART_H
=20
diff --git a/include/hw/char/digic-uart.h b/include/hw/char/digic-uart.h
index de9a3e3551..1aae939226 100644
--- a/include/hw/char/digic-uart.h
+++ b/include/hw/char/digic-uart.h
@@ -12,9 +12,10 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_CHAR_DIGIC_UART_H
 #define HW_CHAR_DIGIC_UART_H
=20
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index d5196c53e6..5127b5b655 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ESCC_H
 #define HW_ESCC_H
=20
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index c8b74284f8..1e27383d52 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -15,6 +15,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX_SERIAL_H
 #define IMX_SERIAL_H
=20
diff --git a/include/hw/char/lm32_juart.h b/include/hw/char/lm32_juart.h
index e7c6fb5a3b..d86c8de178 100644
--- a/include/hw/char/lm32_juart.h
+++ b/include/hw/char/lm32_juart.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_HW_CHAR_LM32_JUART_H
 #define QEMU_HW_CHAR_LM32_JUART_H
=20
diff --git a/include/hw/char/nrf51_uart.h b/include/hw/char/nrf51_uart.h
index eb1c15b490..41b1bf1617 100644
--- a/include/hw/char/nrf51_uart.h
+++ b/include/hw/char/nrf51_uart.h
@@ -8,6 +8,8 @@
  * (at your option) any later version.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef NRF51_UART_H
 #define NRF51_UART_H
=20
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index d6dd62fb9f..a607986c8b 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_PARALLEL_H
 #define HW_PARALLEL_H
=20
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index dad3cf2912..ee4e0269f0 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -12,6 +12,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_PL011_H
 #define HW_PL011_H
=20
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index abd5cf71a9..c4e409509e 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SERIAL_H
 #define HW_SERIAL_H
=20
diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2x=
x_usart.h
index 84c4029777..4793b3cebd 100644
--- a/include/hw/char/stm32f2xx_usart.h
+++ b/include/hw/char/stm32f2xx_usart.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_STM32F2XX_USART_H
 #define HW_STM32F2XX_USART_H
=20
diff --git a/include/hw/char/xilinx_uartlite.h b/include/hw/char/xilinx_u=
artlite.h
index 99d8bbf405..1fa64a15c6 100644
--- a/include/hw/char/xilinx_uartlite.h
+++ b/include/hw/char/xilinx_uartlite.h
@@ -12,6 +12,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef XILINX_UARTLITE_H
 #define XILINX_UARTLITE_H
=20
diff --git a/include/hw/core/split-irq.h b/include/hw/core/split-irq.h
index bb87157c5a..a9695a8e66 100644
--- a/include/hw/core/split-irq.h
+++ b/include/hw/core/split-irq.h
@@ -32,6 +32,9 @@
  *  + N unnamed GPIO outputs: the output lines
  *  + QOM property "num-lines": sets the number of output lines
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SPLIT_IRQ_H
 #define HW_SPLIT_IRQ_H
=20
diff --git a/include/hw/cpu/a15mpcore.h b/include/hw/cpu/a15mpcore.h
index b423533d20..3617e850b7 100644
--- a/include/hw/cpu/a15mpcore.h
+++ b/include/hw/cpu/a15mpcore.h
@@ -17,6 +17,9 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_CPU_A15MPCORE_H
 #define HW_CPU_A15MPCORE_H
=20
diff --git a/include/hw/cpu/a9mpcore.h b/include/hw/cpu/a9mpcore.h
index 5d67ca22c4..c8167aca66 100644
--- a/include/hw/cpu/a9mpcore.h
+++ b/include/hw/cpu/a9mpcore.h
@@ -7,6 +7,9 @@
  *
  * This code is licensed under the GPL.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_CPU_A9MPCORE_H
 #define HW_CPU_A9MPCORE_H
=20
diff --git a/include/hw/cpu/arm11mpcore.h b/include/hw/cpu/arm11mpcore.h
index 6196109ca2..606f641ce3 100644
--- a/include/hw/cpu/arm11mpcore.h
+++ b/include/hw/cpu/arm11mpcore.h
@@ -7,6 +7,8 @@
  * This code is licensed under the GPL.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_CPU_ARM11MPCORE_H
 #define HW_CPU_ARM11MPCORE_H
=20
diff --git a/include/hw/cpu/cluster.h b/include/hw/cpu/cluster.h
index 01c1e50cd2..8238ee9a1e 100644
--- a/include/hw/cpu/cluster.h
+++ b/include/hw/cpu/cluster.h
@@ -17,6 +17,9 @@
  * along with this program; if not, see
  * <http://www.gnu.org/licenses/gpl-2.0.html>
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_CPU_CLUSTER_H
 #define HW_CPU_CLUSTER_H
=20
diff --git a/include/hw/cpu/core.h b/include/hw/cpu/core.h
index b7470644d8..388886c282 100644
--- a/include/hw/cpu/core.h
+++ b/include/hw/cpu/core.h
@@ -6,6 +6,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_CPU_CORE_H
 #define HW_CPU_CORE_H
=20
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 494222d315..8606e8536a 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ETRAXFS_H
 #define HW_ETRAXFS_H
=20
diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index 7948bd2c40..63957010e5 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef EDID_H
 #define EDID_H
=20
diff --git a/include/hw/display/i2c-ddc.h b/include/hw/display/i2c-ddc.h
index 1cf53a0c8d..3796f94a3b 100644
--- a/include/hw/display/i2c-ddc.h
+++ b/include/hw/display/i2c-ddc.h
@@ -16,6 +16,8 @@
  *  with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef I2C_DDC_H
 #define I2C_DDC_H
=20
diff --git a/include/hw/display/milkymist_tmu2.h b/include/hw/display/mil=
kymist_tmu2.h
index 148a119a1d..81e9318661 100644
--- a/include/hw/display/milkymist_tmu2.h
+++ b/include/hw/display/milkymist_tmu2.h
@@ -21,9 +21,10 @@
  *
  * Specification available at:
  *   http://milkymist.walle.cc/socdoc/tmu2.pdf
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_DISPLAY_MILKYMIST_TMU2_H
 #define HW_DISPLAY_MILKYMIST_TMU2_H
=20
diff --git a/include/hw/display/vga.h b/include/hw/display/vga.h
index 0401a3a292..51032e7ee6 100644
--- a/include/hw/display/vga.h
+++ b/include/hw/display/vga.h
@@ -6,6 +6,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef QEMU_HW_DISPLAY_VGA_H
 #define QEMU_HW_DISPLAY_VGA_H
=20
diff --git a/include/hw/dma/bcm2835_dma.h b/include/hw/dma/bcm2835_dma.h
index 91ed8d05d1..7a0293f999 100644
--- a/include/hw/dma/bcm2835_dma.h
+++ b/include/hw/dma/bcm2835_dma.h
@@ -3,6 +3,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef BCM2835_DMA_H
 #define BCM2835_DMA_H
=20
diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
index 2cab50bb6c..c6c0d3accc 100644
--- a/include/hw/dma/i8257.h
+++ b/include/hw/dma/i8257.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_I8257_H
 #define HW_I8257_H
=20
diff --git a/include/hw/dma/pl080.h b/include/hw/dma/pl080.h
index 9d4b3df143..8ae0927458 100644
--- a/include/hw/dma/pl080.h
+++ b/include/hw/dma/pl080.h
@@ -25,6 +25,8 @@
  *   bus master transactions are made
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_DMA_PL080_H
 #define HW_DMA_PL080_H
=20
diff --git a/include/hw/dma/xlnx-zdma.h b/include/hw/dma/xlnx-zdma.h
index 0b240b4c3c..2991771f14 100644
--- a/include/hw/dma/xlnx-zdma.h
+++ b/include/hw/dma/xlnx-zdma.h
@@ -26,6 +26,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef XLNX_ZDMA_H
 #define XLNX_ZDMA_H
=20
diff --git a/include/hw/dma/xlnx-zynq-devcfg.h b/include/hw/dma/xlnx-zynq=
-devcfg.h
index 1d3969d91f..56c1b9bf6f 100644
--- a/include/hw/dma/xlnx-zynq-devcfg.h
+++ b/include/hw/dma/xlnx-zynq-devcfg.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef XLNX_ZYNQ_DEVCFG_H
 #define XLNX_ZYNQ_DEVCFG_H
=20
diff --git a/include/hw/gpio/bcm2835_gpio.h b/include/hw/gpio/bcm2835_gpi=
o.h
index b0de0a3c74..242c81f9bb 100644
--- a/include/hw/gpio/bcm2835_gpio.h
+++ b/include/hw/gpio/bcm2835_gpio.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef BCM2835_GPIO_H
 #define BCM2835_GPIO_H
=20
diff --git a/include/hw/gpio/imx_gpio.h b/include/hw/gpio/imx_gpio.h
index ffab437f23..60e729e031 100644
--- a/include/hw/gpio/imx_gpio.h
+++ b/include/hw/gpio/imx_gpio.h
@@ -17,6 +17,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX_GPIO_H
 #define IMX_GPIO_H
=20
diff --git a/include/hw/gpio/nrf51_gpio.h b/include/hw/gpio/nrf51_gpio.h
index 337ee534bb..d692d6636f 100644
--- a/include/hw/gpio/nrf51_gpio.h
+++ b/include/hw/gpio/nrf51_gpio.h
@@ -21,8 +21,10 @@
  *
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
- *
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef NRF51_GPIO_H
 #define NRF51_GPIO_H
=20
diff --git a/include/hw/hw.h b/include/hw/hw.h
index b1b79964b5..596845ba75 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 /* Declarations for use by hardware emulation.  */
 #ifndef QEMU_HW_H
 #define QEMU_HW_H
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index a2753f0bbb..de6fea31d4 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -18,6 +18,8 @@
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ASPEED_I2C_H
 #define ASPEED_I2C_H
=20
diff --git a/include/hw/i2c/bitbang_i2c.h b/include/hw/i2c/bitbang_i2c.h
index 92334e9016..73c043d04e 100644
--- a/include/hw/i2c/bitbang_i2c.h
+++ b/include/hw/i2c/bitbang_i2c.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef BITBANG_I2C_H
 #define BITBANG_I2C_H
=20
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 75c5bd638b..fce4deb244 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_I2C_H
 #define QEMU_I2C_H
=20
diff --git a/include/hw/i2c/imx_i2c.h b/include/hw/i2c/imx_i2c.h
index 7c73a1fa28..2acb129e60 100644
--- a/include/hw/i2c/imx_i2c.h
+++ b/include/hw/i2c/imx_i2c.h
@@ -15,9 +15,10 @@
  *
  *  You should have received a copy of the GNU General Public License al=
ong
  *  with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX_I2C_H
 #define IMX_I2C_H
=20
diff --git a/include/hw/i2c/microbit_i2c.h b/include/hw/i2c/microbit_i2c.=
h
index aad636127e..61159b3f0e 100644
--- a/include/hw/i2c/microbit_i2c.h
+++ b/include/hw/i2c/microbit_i2c.h
@@ -8,6 +8,8 @@
  * the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MICROBIT_I2C_H
 #define MICROBIT_I2C_H
=20
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index fb55c44444..48a0c089ba 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PM_SMBUS_H
 #define PM_SMBUS_H
=20
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index f6f837fbec..c1f768c8c0 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PPC4XX_I2C_H
 #define PPC4XX_I2C_H
=20
diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.=
h
index 0f96836bab..4adef59ef1 100644
--- a/include/hw/i2c/smbus_eeprom.h
+++ b/include/hw/i2c/smbus_eeprom.h
@@ -20,6 +20,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SMBUS_EEPROM_H
 #define HW_SMBUS_EEPROM_H
=20
diff --git a/include/hw/i2c/smbus_master.h b/include/hw/i2c/smbus_master.=
h
index bb13bc423c..891133fc15 100644
--- a/include/hw/i2c/smbus_master.h
+++ b/include/hw/i2c/smbus_master.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SMBUS_MASTER_H
 #define HW_SMBUS_MASTER_H
=20
diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
index ebe068304e..fdd010a33e 100644
--- a/include/hw/i2c/smbus_slave.h
+++ b/include/hw/i2c/smbus_slave.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SMBUS_SLAVE_H
 #define HW_SMBUS_SLAVE_H
=20
diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 046bcf33be..3cc1e787d4 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ICH9_H
 #define HW_ICH9_H
=20
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h
index 12f3d266e2..04febf831f 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -19,6 +19,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef INTEL_IOMMU_H
 #define INTEL_IOMMU_H
 #include "hw/qdev.h"
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_i=
nternal.h
index 3d2eec2aa7..aa74ab108b 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -19,6 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_IOAPIC_INTERNAL_H
 #define QEMU_IOAPIC_INTERNAL_H
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 859b64c51d..9a7770fb83 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_PC_H
 #define HW_PC_H
=20
diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index 8e10383b11..910d4dfe86 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -17,6 +17,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_I386_X86_IOMMU_H
 #define HW_I386_X86_IOMMU_H
=20
diff --git a/include/hw/ide.h b/include/hw/ide.h
index 28d8a06439..3f62d45e41 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_IDE_H
 #define HW_IDE_H
=20
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index b44e3000cf..9b9c6d38c2 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -18,9 +18,10 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_IDE_AHCI_H
 #define HW_IDE_AHCI_H
=20
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 8efd03132b..d5eee2d2a5 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_IDE_INTERNAL_H
 #define HW_IDE_INTERNAL_H
=20
diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index a9f2c33e68..6d76e84350 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_IDE_PCI_H
 #define HW_IDE_PCI_H
=20
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index f99d478252..9edd7d8e40 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ADB_H
 #define ADB_H
=20
diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
index f6ff146364..34821919e7 100644
--- a/include/hw/input/i8042.h
+++ b/include/hw/input/i8042.h
@@ -5,6 +5,9 @@
  *
  * SPDX-License-Identifier: MIT
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_INPUT_I8042_H
 #define HW_INPUT_I8042_H
=20
diff --git a/include/hw/intc/allwinner-a10-pic.h b/include/hw/intc/allwin=
ner-a10-pic.h
index a5895401d1..248a5f5218 100644
--- a/include/hw/intc/allwinner-a10-pic.h
+++ b/include/hw/intc/allwinner-a10-pic.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ALLWINNER_A10_PIC_H
 #define ALLWINNER_A10_PIC_H
=20
diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index ed703a1720..c520fabd1e 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -61,6 +61,8 @@
  *      ...
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ARM_GIC_H
 #define HW_ARM_GIC_H
=20
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_c=
ommon.h
index b5585fec45..c46693b9bd 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ARM_GIC_COMMON_H
 #define HW_ARM_GIC_COMMON_H
=20
diff --git a/include/hw/intc/arm_gicv3.h b/include/hw/intc/arm_gicv3.h
index 4a6fd85e22..5a1e973175 100644
--- a/include/hw/intc/arm_gicv3.h
+++ b/include/hw/intc/arm_gicv3.h
@@ -9,6 +9,8 @@
  * any later version.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ARM_GICV3_H
 #define HW_ARM_GICV3_H
=20
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gic=
v3_common.h
index 31ec9a1ae4..c82cee7052 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -21,6 +21,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ARM_GICV3_COMMON_H
 #define HW_ARM_GICV3_COMMON_H
=20
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm=
_gicv3_its_common.h
index fd1fe64c03..e792750998 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_ARM_GICV3_ITS_COMMON_H
 #define QEMU_ARM_GICV3_ITS_COMMON_H
=20
diff --git a/include/hw/intc/aspeed_vic.h b/include/hw/intc/aspeed_vic.h
index 107ff17c3b..ce1457dfb6 100644
--- a/include/hw/intc/aspeed_vic.h
+++ b/include/hw/intc/aspeed_vic.h
@@ -10,6 +10,9 @@
  *
  * Need to add SVIC and CVIC support
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ASPEED_VIC_H
 #define ASPEED_VIC_H
=20
diff --git a/include/hw/intc/bcm2835_ic.h b/include/hw/intc/bcm2835_ic.h
index fb75fa0064..17cc8f6ea6 100644
--- a/include/hw/intc/bcm2835_ic.h
+++ b/include/hw/intc/bcm2835_ic.h
@@ -3,6 +3,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef BCM2835_IC_H
 #define BCM2835_IC_H
=20
diff --git a/include/hw/intc/bcm2836_control.h b/include/hw/intc/bcm2836_=
control.h
index de061b8929..f8c4761bbc 100644
--- a/include/hw/intc/bcm2836_control.h
+++ b/include/hw/intc/bcm2836_control.h
@@ -11,6 +11,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef BCM2836_CONTROL_H
 #define BCM2836_CONTROL_H
=20
diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pi=
c.h
index b163e27ab9..2102197e05 100644
--- a/include/hw/intc/heathrow_pic.h
+++ b/include/hw/intc/heathrow_pic.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_INTC_HEATHROW_PIC_H
 #define HW_INTC_HEATHROW_PIC_H
=20
diff --git a/include/hw/intc/imx_avic.h b/include/hw/intc/imx_avic.h
index 1b80769018..7fcf37119f 100644
--- a/include/hw/intc/imx_avic.h
+++ b/include/hw/intc/imx_avic.h
@@ -14,6 +14,9 @@
  *
  * TODO: implement vectors.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX_AVIC_H
 #define IMX_AVIC_H
=20
diff --git a/include/hw/intc/imx_gpcv2.h b/include/hw/intc/imx_gpcv2.h
index ed978b24bb..7b58a9adda 100644
--- a/include/hw/intc/imx_gpcv2.h
+++ b/include/hw/intc/imx_gpcv2.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX_GPCV2_H
 #define IMX_GPCV2_H
=20
diff --git a/include/hw/intc/realview_gic.h b/include/hw/intc/realview_gi=
c.h
index 1783ea11b9..47d5dcfd1b 100644
--- a/include/hw/intc/realview_gic.h
+++ b/include/hw/intc/realview_gic.h
@@ -7,6 +7,8 @@
  * This code is licensed under the GPL.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_INTC_REALVIEW_GIC_H
 #define HW_INTC_REALVIEW_GIC_H
=20
diff --git a/include/hw/intc/xlnx-pmu-iomod-intc.h b/include/hw/intc/xlnx=
-pmu-iomod-intc.h
index 0bd118884a..065717b7bc 100644
--- a/include/hw/intc/xlnx-pmu-iomod-intc.h
+++ b/include/hw/intc/xlnx-pmu-iomod-intc.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_INTC_XLNX_PMU_IOMOD_INTC_H
 #define HW_INTC_XLNX_PMU_IOMOD_INTC_H
=20
diff --git a/include/hw/intc/xlnx-zynqmp-ipi.h b/include/hw/intc/xlnx-zyn=
qmp-ipi.h
index 866c719c6f..effb50ce49 100644
--- a/include/hw/intc/xlnx-zynqmp-ipi.h
+++ b/include/hw/intc/xlnx-zynqmp-ipi.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef XLNX_ZYNQMP_IPI_H
 #define XLNX_ZYNQMP_IPI_H
=20
diff --git a/include/hw/ipack/ipack.h b/include/hw/ipack/ipack.h
index e33e032ced..839f18ee2f 100644
--- a/include/hw/ipack/ipack.h
+++ b/include/hw/ipack/ipack.h
@@ -8,6 +8,8 @@
  * later version.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_IPACK_H
 #define QEMU_IPACK_H
=20
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 011faf22e9..67d33dc415 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_IPMI_H
 #define HW_IPMI_H
=20
diff --git a/include/hw/isa/apm.h b/include/hw/isa/apm.h
index 0f93602936..51897f2e38 100644
--- a/include/hw/isa/apm.h
+++ b/include/hw/isa/apm.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef APM_H
 #define APM_H
=20
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_inter=
nal.h
index f742c2a726..4b04a29154 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_I8259_INTERNAL_H
 #define QEMU_I8259_INTERNAL_H
=20
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index e62ac91c19..e2b44ed653 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ISA_H
 #define HW_ISA_H
=20
diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
index e16263d4b1..cb5bd952a2 100644
--- a/include/hw/isa/pc87312.h
+++ b/include/hw/isa/pc87312.h
@@ -22,6 +22,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_PC87312_H
 #define QEMU_PC87312_H
=20
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index b151dcd753..806efdd6e6 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -7,6 +7,9 @@
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_ISA_SUPERIO_H
 #define HW_ISA_SUPERIO_H
=20
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 3e1b3a4566..29930fc9cd 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef LOADER_H
 #define LOADER_H
 #include "hw/nvram/fw_cfg.h"
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-devic=
e.h
index 0293a96abb..af1ce670bb 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MEMORY_DEVICE_H
 #define MEMORY_DEVICE_H
=20
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 523a9b3d4a..a596c390ad 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -20,6 +20,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_NVDIMM_H
 #define QEMU_NVDIMM_H
=20
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 01436b9f50..c74f1c9c1e 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -10,9 +10,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_PC_DIMM_H
 #define QEMU_PC_DIMM_H
=20
diff --git a/include/hw/misc/a9scu.h b/include/hw/misc/a9scu.h
index efb0c305c2..6a0476fdc1 100644
--- a/include/hw/misc/a9scu.h
+++ b/include/hw/misc/a9scu.h
@@ -7,6 +7,9 @@
  *
  * This code is licensed under the GPL.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MISC_A9SCU_H
 #define HW_MISC_A9SCU_H
=20
diff --git a/include/hw/misc/arm11scu.h b/include/hw/misc/arm11scu.h
index 5ad0f3d339..72335bd789 100644
--- a/include/hw/misc/arm11scu.h
+++ b/include/hw/misc/arm11scu.h
@@ -8,6 +8,8 @@
  * This code is licensed under the GPL.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MISC_ARM11SCU_H
 #define HW_MISC_ARM11SCU_H
=20
diff --git a/include/hw/misc/armsse-cpuid.h b/include/hw/misc/armsse-cpui=
d.h
index 0ef33fcaba..6dfbe87215 100644
--- a/include/hw/misc/armsse-cpuid.h
+++ b/include/hw/misc/armsse-cpuid.h
@@ -19,6 +19,8 @@
  *  + sysbus MMIO region 0: the system information register bank
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MISC_ARMSSE_CPUID_H
 #define HW_MISC_ARMSSE_CPUID_H
=20
diff --git a/include/hw/misc/armsse-mhu.h b/include/hw/misc/armsse-mhu.h
index cf5d8a73e6..ba731630c5 100644
--- a/include/hw/misc/armsse-mhu.h
+++ b/include/hw/misc/armsse-mhu.h
@@ -20,6 +20,8 @@
  *  + sysbus IRQ 1: interrupt for CPU 1
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MISC_ARMSSE_MHU_H
 #define HW_MISC_ARMSSE_MHU_H
=20
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 38996adc59..2470c15b6b 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -8,6 +8,9 @@
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ASPEED_SCU_H
 #define ASPEED_SCU_H
=20
diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.=
h
index b3c926acae..b2a29c3deb 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -6,6 +6,9 @@
  * This code is licensed under the GPL version 2 or later. See the
  * COPYING file in the top-level directory.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ASPEED_SDMC_H
 #define ASPEED_SDMC_H
=20
diff --git a/include/hw/misc/aspeed_xdma.h b/include/hw/misc/aspeed_xdma.=
h
index 00b45d931f..e334842342 100644
--- a/include/hw/misc/aspeed_xdma.h
+++ b/include/hw/misc/aspeed_xdma.h
@@ -6,6 +6,8 @@
  * SPDX-License-Identifer: GPL-2.0-or-later
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ASPEED_XDMA_H
 #define ASPEED_XDMA_H
=20
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index c15b444748..27e1cf571e 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -19,9 +19,10 @@
  *
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MISC_AUXBUS_H
 #define HW_MISC_AUXBUS_H
=20
diff --git a/include/hw/misc/bcm2835_mbox.h b/include/hw/misc/bcm2835_mbo=
x.h
index 7e8f3ce86d..9bc9de8dc9 100644
--- a/include/hw/misc/bcm2835_mbox.h
+++ b/include/hw/misc/bcm2835_mbox.h
@@ -3,6 +3,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef BCM2835_MBOX_H
 #define BCM2835_MBOX_H
=20
diff --git a/include/hw/misc/bcm2835_rng.h b/include/hw/misc/bcm2835_rng.=
h
index 41a531bce7..a5f9291ee8 100644
--- a/include/hw/misc/bcm2835_rng.h
+++ b/include/hw/misc/bcm2835_rng.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef BCM2835_RNG_H
 #define BCM2835_RNG_H
=20
diff --git a/include/hw/misc/imx25_ccm.h b/include/hw/misc/imx25_ccm.h
index 296321c612..5f95c9f4e4 100644
--- a/include/hw/misc/imx25_ccm.h
+++ b/include/hw/misc/imx25_ccm.h
@@ -8,6 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX25_CCM_H
 #define IMX25_CCM_H
=20
diff --git a/include/hw/misc/imx2_wdt.h b/include/hw/misc/imx2_wdt.h
index b91b002528..41b53f7591 100644
--- a/include/hw/misc/imx2_wdt.h
+++ b/include/hw/misc/imx2_wdt.h
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX2_WDT_H
 #define IMX2_WDT_H
=20
diff --git a/include/hw/misc/imx31_ccm.h b/include/hw/misc/imx31_ccm.h
index c376fad14c..55e0961794 100644
--- a/include/hw/misc/imx31_ccm.h
+++ b/include/hw/misc/imx31_ccm.h
@@ -8,6 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX31_CCM_H
 #define IMX31_CCM_H
=20
diff --git a/include/hw/misc/imx6_ccm.h b/include/hw/misc/imx6_ccm.h
index 80505809b4..a7d9d5fc0e 100644
--- a/include/hw/misc/imx6_ccm.h
+++ b/include/hw/misc/imx6_ccm.h
@@ -8,6 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX6_CCM_H
 #define IMX6_CCM_H
=20
diff --git a/include/hw/misc/imx6_src.h b/include/hw/misc/imx6_src.h
index eb3640732e..b561e5bbaa 100644
--- a/include/hw/misc/imx6_src.h
+++ b/include/hw/misc/imx6_src.h
@@ -8,6 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX6_SRC_H
 #define IMX6_SRC_H
=20
diff --git a/include/hw/misc/imx6ul_ccm.h b/include/hw/misc/imx6ul_ccm.h
index 377ddca244..8abf48aa16 100644
--- a/include/hw/misc/imx6ul_ccm.h
+++ b/include/hw/misc/imx6ul_ccm.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX6UL_CCM_H
 #define IMX6UL_CCM_H
=20
diff --git a/include/hw/misc/imx7_ccm.h b/include/hw/misc/imx7_ccm.h
index 9538f37d98..ad180b8d31 100644
--- a/include/hw/misc/imx7_ccm.h
+++ b/include/hw/misc/imx7_ccm.h
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX7_CCM_H
 #define IMX7_CCM_H
=20
diff --git a/include/hw/misc/imx7_gpr.h b/include/hw/misc/imx7_gpr.h
index e19373d274..3d0aaf2087 100644
--- a/include/hw/misc/imx7_gpr.h
+++ b/include/hw/misc/imx7_gpr.h
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX7_GPR_H
 #define IMX7_GPR_H
=20
diff --git a/include/hw/misc/imx7_snvs.h b/include/hw/misc/imx7_snvs.h
index 255f8f26f9..773af6d5bf 100644
--- a/include/hw/misc/imx7_snvs.h
+++ b/include/hw/misc/imx7_snvs.h
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX7_SNVS_H
 #define IMX7_SNVS_H
=20
diff --git a/include/hw/misc/imx_ccm.h b/include/hw/misc/imx_ccm.h
index 33cbc09952..f561877694 100644
--- a/include/hw/misc/imx_ccm.h
+++ b/include/hw/misc/imx_ccm.h
@@ -8,6 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX_CCM_H
 #define IMX_CCM_H
=20
diff --git a/include/hw/misc/iotkit-secctl.h b/include/hw/misc/iotkit-sec=
ctl.h
index bcb0437be5..d3e1c92090 100644
--- a/include/hw/misc/iotkit-secctl.h
+++ b/include/hw/misc/iotkit-secctl.h
@@ -52,6 +52,8 @@
  *  + named GPIO outputs mscexp_ns[0..15]
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IOTKIT_SECCTL_H
 #define IOTKIT_SECCTL_H
=20
diff --git a/include/hw/misc/iotkit-sysctl.h b/include/hw/misc/iotkit-sys=
ctl.h
index 601c8ecc0d..716c84aee8 100644
--- a/include/hw/misc/iotkit-sysctl.h
+++ b/include/hw/misc/iotkit-sysctl.h
@@ -24,6 +24,8 @@
  *  + sysbus MMIO region 1: the system control register bank
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MISC_IOTKIT_SYSCTL_H
 #define HW_MISC_IOTKIT_SYSCTL_H
=20
diff --git a/include/hw/misc/iotkit-sysinfo.h b/include/hw/misc/iotkit-sy=
sinfo.h
index d84eb203b9..1f8b341993 100644
--- a/include/hw/misc/iotkit-sysinfo.h
+++ b/include/hw/misc/iotkit-sysinfo.h
@@ -19,6 +19,8 @@
  *  + sysbus MMIO region 0: the system information register bank
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MISC_IOTKIT_SYSINFO_H
 #define HW_MISC_IOTKIT_SYSINFO_H
=20
diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
index 5768075ac5..6fb02c102f 100644
--- a/include/hw/misc/macio/cuda.h
+++ b/include/hw/misc/macio/cuda.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef CUDA_H
 #define CUDA_H
=20
diff --git a/include/hw/misc/macio/gpio.h b/include/hw/misc/macio/gpio.h
index 24a4364b39..b691322273 100644
--- a/include/hw/misc/macio/gpio.h
+++ b/include/hw/misc/macio/gpio.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MACIO_GPIO_H
 #define MACIO_GPIO_H
=20
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.=
h
index 070a694eb5..446ce74c11 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MACIO_H
 #define MACIO_H
=20
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
index 7ef83dee4c..8d95483813 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -7,6 +7,8 @@
  * Copyright (C) 2016 Ben Herrenschmidt
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PMU_H
 #define PMU_H
=20
diff --git a/include/hw/misc/mips_cmgcr.h b/include/hw/misc/mips_cmgcr.h
index 3e6e223273..c0eb309f48 100644
--- a/include/hw/misc/mips_cmgcr.h
+++ b/include/hw/misc/mips_cmgcr.h
@@ -4,9 +4,10 @@
  * for more details.
  *
  * Copyright (C) 2015 Imagination Technologies
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MIPS_CMGCR_H
 #define MIPS_CMGCR_H
=20
diff --git a/include/hw/misc/mips_cpc.h b/include/hw/misc/mips_cpc.h
index 3f670578b0..907737f306 100644
--- a/include/hw/misc/mips_cpc.h
+++ b/include/hw/misc/mips_cpc.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MIPS_CPC_H
 #define MIPS_CPC_H
=20
diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index c44e7672b6..2733ada5c9 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MIPS_ITU_H
 #define MIPS_ITU_H
=20
diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index 03d9f0c059..7c1a2d93cf 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MOS6522_H
 #define MOS6522_H
=20
diff --git a/include/hw/misc/mps2-fpgaio.h b/include/hw/misc/mps2-fpgaio.=
h
index 69e265cd4b..cf447dfc0b 100644
--- a/include/hw/misc/mps2-fpgaio.h
+++ b/include/hw/misc/mps2-fpgaio.h
@@ -18,6 +18,8 @@
  *  + sysbus MMIO region 0: the register bank
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MPS2_FPGAIO_H
 #define MPS2_FPGAIO_H
=20
diff --git a/include/hw/misc/mps2-scc.h b/include/hw/misc/mps2-scc.h
index 7045473788..c2ddf7a29d 100644
--- a/include/hw/misc/mps2-scc.h
+++ b/include/hw/misc/mps2-scc.h
@@ -9,6 +9,8 @@
  *  (at your option) any later version.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MPS2_SCC_H
 #define MPS2_SCC_H
=20
diff --git a/include/hw/misc/msf2-sysreg.h b/include/hw/misc/msf2-sysreg.=
h
index 5993f67b4e..41029df3d8 100644
--- a/include/hw/misc/msf2-sysreg.h
+++ b/include/hw/misc/msf2-sysreg.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MSF2_SYSREG_H
 #define HW_MSF2_SYSREG_H
=20
diff --git a/include/hw/misc/nrf51_rng.h b/include/hw/misc/nrf51_rng.h
index b0133bf665..909d4158fc 100644
--- a/include/hw/misc/nrf51_rng.h
+++ b/include/hw/misc/nrf51_rng.h
@@ -28,9 +28,10 @@
  *
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef NRF51_RNG_H
 #define NRF51_RNG_H
=20
diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index ebb43c63fe..fce7a03810 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -6,6 +6,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or
  * later. See the COPYING file in the top-level directory.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PCA9552_H
 #define PCA9552_H
=20
diff --git a/include/hw/misc/stm32f2xx_syscfg.h b/include/hw/misc/stm32f2=
xx_syscfg.h
index 69e6a30fc5..23f48122b8 100644
--- a/include/hw/misc/stm32f2xx_syscfg.h
+++ b/include/hw/misc/stm32f2xx_syscfg.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_STM32F2XX_SYSCFG_H
 #define HW_STM32F2XX_SYSCFG_H
=20
diff --git a/include/hw/misc/tz-mpc.h b/include/hw/misc/tz-mpc.h
index 6f15945410..95ab9f98d8 100644
--- a/include/hw/misc/tz-mpc.h
+++ b/include/hw/misc/tz-mpc.h
@@ -28,6 +28,8 @@
  * + Named GPIO output "irq": set for a transaction-failed interrupt
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef TZ_MPC_H
 #define TZ_MPC_H
=20
diff --git a/include/hw/misc/tz-msc.h b/include/hw/misc/tz-msc.h
index 116b96ae9b..f3654b7b13 100644
--- a/include/hw/misc/tz-msc.h
+++ b/include/hw/misc/tz-msc.h
@@ -47,6 +47,8 @@
  *   make memory transactions to
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef TZ_MSC_H
 #define TZ_MSC_H
=20
diff --git a/include/hw/misc/tz-ppc.h b/include/hw/misc/tz-ppc.h
index 080d6e2ec1..e4e74337f0 100644
--- a/include/hw/misc/tz-ppc.h
+++ b/include/hw/misc/tz-ppc.h
@@ -62,6 +62,8 @@
  *   parameter.)
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef TZ_PPC_H
 #define TZ_PPC_H
=20
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 2a291ca42d..c54a2f4871 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -5,6 +5,8 @@
  * Written by Peter Maydell
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MISC_UNIMP_H
 #define HW_MISC_UNIMP_H
=20
diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index 0d11578059..59964b0c0e 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -7,8 +7,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
- *
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef VMCOREINFO_H
 #define VMCOREINFO_H
=20
diff --git a/include/hw/misc/zynq-xadc.h b/include/hw/misc/zynq-xadc.h
index f1a410a376..65c8b3480c 100644
--- a/include/hw/misc/zynq-xadc.h
+++ b/include/hw/misc/zynq-xadc.h
@@ -12,6 +12,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ZYNQ_XADC_H
 #define ZYNQ_XADC_H
=20
diff --git a/include/hw/net/allwinner_emac.h b/include/hw/net/allwinner_e=
mac.h
index 5013207d15..c2a84682c6 100644
--- a/include/hw/net/allwinner_emac.h
+++ b/include/hw/net/allwinner_emac.h
@@ -17,9 +17,10 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ALLWINNER_EMAC_H
 #define ALLWINNER_EMAC_H
=20
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 5c83036ade..fa94136e56 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef CADENCE_GEM_H
 #define CADENCE_GEM_H
=20
diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index 94cfe05332..f7088321c7 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef FTGMAC100_H
 #define FTGMAC100_H
=20
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 7b3faa4019..5b879c66ea 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -21,6 +21,8 @@
  *  with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX_FEC_H
 #define IMX_FEC_H
=20
diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
index 0357f5f65c..7e7747f536 100644
--- a/include/hw/net/lance.h
+++ b/include/hw/net/lance.h
@@ -26,6 +26,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef LANCE_H
 #define LANCE_H
=20
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index 5acf4a494e..1a90173e1e 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_NET_NE2000_ISA_H
 #define HW_NET_NE2000_ISA_H
=20
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 80e435d303..9e7f4b8644 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef FW_CFG_H
 #define FW_CFG_H
=20
diff --git a/include/hw/nvram/nrf51_nvm.h b/include/hw/nvram/nrf51_nvm.h
index 3792e4a9fe..083d132143 100644
--- a/include/hw/nvram/nrf51_nvm.h
+++ b/include/hw/nvram/nrf51_nvm.h
@@ -17,8 +17,10 @@
  *
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
- *
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef NRF51_NVM_H
 #define NRF51_NVM_H
=20
diff --git a/include/hw/or-irq.h b/include/hw/or-irq.h
index 5a31e5a188..6da7d5f6ac 100644
--- a/include/hw/or-irq.h
+++ b/include/hw/or-irq.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_OR_IRQ_H
 #define HW_OR_IRQ_H
=20
diff --git a/include/hw/pci-bridge/simba.h b/include/hw/pci-bridge/simba.=
h
index d8649973ee..63db2a8e5a 100644
--- a/include/hw/pci-bridge/simba.h
+++ b/include/hw/pci-bridge/simba.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_PCI_BRIDGE_SIMBA_H
 #define HW_PCI_BRIDGE_SIMBA_H
=20
diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/desig=
nware.h
index 186bb36238..4e22252964 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -18,6 +18,8 @@
  * <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef DESIGNWARE_H
 #define DESIGNWARE_H
=20
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index 2af1c4a37e..4192fe8da4 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -17,6 +17,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_GPEX_H
 #define HW_GPEX_H
=20
diff --git a/include/hw/pci-host/pam.h b/include/hw/pci-host/pam.h
index fec5cd35d6..50c9fcf0f7 100644
--- a/include/hw/pci-host/pam.h
+++ b/include/hw/pci-host/pam.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef QEMU_PAM_H
 #define QEMU_PAM_H
=20
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 5ed77facd0..2671c868cf 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -19,6 +19,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_Q35_H
 #define HW_Q35_H
=20
diff --git a/include/hw/pci-host/sabre.h b/include/hw/pci-host/sabre.h
index 99b5aefbec..cff4ec9b53 100644
--- a/include/hw/pci-host/sabre.h
+++ b/include/hw/pci-host/sabre.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_PCI_HOST_SABRE_H
 #define HW_PCI_HOST_SABRE_H
=20
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
index 9a5cabd4c5..e1fae2eccd 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef UNINORTH_H
 #define UNINORTH_H
=20
diff --git a/include/hw/pci-host/xilinx-pcie.h b/include/hw/pci-host/xili=
nx-pcie.h
index 74c04dc9bb..957143c8bc 100644
--- a/include/hw/pci-host/xilinx-pcie.h
+++ b/include/hw/pci-host/xilinx-pcie.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_XILINX_PCIE_H
 #define HW_XILINX_PCIE_H
=20
diff --git a/include/hw/pci/msi.h b/include/hw/pci/msi.h
index 4087688486..775e3c05a0 100644
--- a/include/hw/pci/msi.h
+++ b/include/hw/pci/msi.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_MSI_H
 #define QEMU_MSI_H
=20
diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
index 4c4a60c739..6624223ae2 100644
--- a/include/hw/pci/msix.h
+++ b/include/hw/pci/msix.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_MSIX_H
 #define QEMU_MSIX_H
=20
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index aaf1b9f70d..5d4f0d607f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_PCI_H
 #define QEMU_PCI_H
=20
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index ba488818d2..7bd53c6ce2 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -20,9 +20,10 @@
  * split out pci bus specific stuff from pci.[hc] to pci_bridge.[hc]
  * Copyright (c) 2009 Isaku Yamahata <yamahata at valinux co jp>
  *                    VA Linux Systems Japan K.K.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_PCI_BRIDGE_H
 #define QEMU_PCI_BRIDGE_H
=20
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 0714f578af..1e668e9596 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_PCI_BUS_H
 #define QEMU_PCI_BUS_H
=20
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index ba31595fc7..d07d557501 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -25,6 +25,8 @@
 /* Worker routines for a PCI host controller that uses an {address,data}
    register pair to access PCI configuration space.  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PCI_HOST_H
 #define PCI_HOST_H
=20
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 34f277735c..a70e66583f 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_PCIE_H
 #define QEMU_PCIE_H
=20
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 502dcd7eba..85e501854d 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_PCIE_AER_H
 #define QEMU_PCIE_AER_H
=20
diff --git a/include/hw/pci/pcie_host.h b/include/hw/pci/pcie_host.h
index 3f7b9886d1..e5ad2eceb8 100644
--- a/include/hw/pci/pcie_host.h
+++ b/include/hw/pci/pcie_host.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PCIE_HOST_H
 #define PCIE_HOST_H
=20
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 09586f4641..683cd61764 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_PCIE_PORT_H
 #define QEMU_PCIE_PORT_H
=20
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index bd8204f64e..5a966276eb 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef SHPC_H
 #define SHPC_H
=20
diff --git a/include/hw/pcmcia.h b/include/hw/pcmcia.h
index 1b4080764f..166e41ea93 100644
--- a/include/hw/pcmcia.h
+++ b/include/hw/pcmcia.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_PCMCIA_H
 #define HW_PCMCIA_H
=20
diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
index 19e20c57ce..511b1c4f16 100644
--- a/include/hw/platform-bus.h
+++ b/include/hw/platform-bus.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_PLATFORM_BUS_H
 #define HW_PLATFORM_BUS_H
=20
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 26cc469de4..35e5c92074 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -20,6 +20,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MAC_DBDMA_H
 #define HW_MAC_DBDMA_H
=20
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index 7642a8ea1d..ea4210ca37 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef OPENPIC_H
 #define OPENPIC_H
=20
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index f659410716..1e2ea00cb1 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PPC_PNV_LPC_H
 #define PPC_PNV_LPC_H
=20
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index ed0709bfc0..6e8e71e927 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PPC_PNV_OCC_H
 #define PPC_PNV_OCC_H
=20
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index e82df9709f..df7864b322 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PPC_PNV_PSI_H
 #define PPC_PNV_PSI_H
=20
diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index 4fdaa9247d..5f10d64267 100644
--- a/include/hw/ppc/pnv_xive.h
+++ b/include/hw/ppc/pnv_xive.h
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PPC_PNV_XIVE_H
 #define PPC_PNV_XIVE_H
=20
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index c2c543a591..80fba16a74 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SPAPR_DRC_H
 #define HW_SPAPR_DRC_H
=20
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1eb7b5cd68..f777dd22f0 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -22,9 +22,10 @@
  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef XICS_H
 #define XICS_H
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 55c53c7417..d181857bc7 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -134,9 +134,10 @@
  *
  * This code is licensed under the GPL version 2 or later. See the
  * COPYING file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef PPC_XIVE_H
 #define PPC_XIVE_H
=20
diff --git a/include/hw/qdev.h b/include/hw/qdev.h
index 5cb8b080a6..405bb798e6 100644
--- a/include/hw/qdev.h
+++ b/include/hw/qdev.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QDEV_H
 #define QDEV_H
=20
diff --git a/include/hw/register.h b/include/hw/register.h
index 5796584588..7bd60b7035 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -8,6 +8,8 @@
  * the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef REGISTER_H
 #define REGISTER_H
=20
diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_cl=
int.h
index ae8286c884..29829932bc 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -17,6 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SIFIVE_CLINT_H
 #define HW_SIFIVE_CLINT_H
=20
diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/riscv/sifive_gpi=
o.h
index fce03d6c41..56c8bfce7b 100644
--- a/include/hw/riscv/sifive_gpio.h
+++ b/include/hw/riscv/sifive_gpio.h
@@ -10,6 +10,9 @@
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef SIFIVE_GPIO_H
 #define SIFIVE_GPIO_H
=20
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_pli=
c.h
index b0edba2884..0b06df45d0 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -18,6 +18,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SIFIVE_PLIC_H
 #define HW_SIFIVE_PLIC_H
=20
diff --git a/include/hw/riscv/sifive_prci.h b/include/hw/riscv/sifive_prc=
i.h
index 8b7de134f8..76564fdf69 100644
--- a/include/hw/riscv/sifive_prci.h
+++ b/include/hw/riscv/sifive_prci.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SIFIVE_PRCI_H
 #define HW_SIFIVE_PRCI_H
=20
diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_tes=
t.h
index 3a603a6ead..e6c4a18f8f 100644
--- a/include/hw/riscv/sifive_test.h
+++ b/include/hw/riscv/sifive_test.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SIFIVE_TEST_H
 #define HW_SIFIVE_TEST_H
=20
diff --git a/include/hw/riscv/sifive_uart.h b/include/hw/riscv/sifive_uar=
t.h
index 65668825a3..36bef84374 100644
--- a/include/hw/riscv/sifive_uart.h
+++ b/include/hw/riscv/sifive_uart.h
@@ -17,6 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SIFIVE_UART_H
 #define HW_SIFIVE_UART_H
=20
diff --git a/include/hw/s390x/css-bridge.h b/include/hw/s390x/css-bridge.=
h
index f7ed2d9a03..2956ca11f5 100644
--- a/include/hw/s390x/css-bridge.h
+++ b/include/hw/s390x/css-bridge.h
@@ -10,6 +10,8 @@
  * directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_S390X_CSS_BRIDGE_H
 #define HW_S390X_CSS_BRIDGE_H
=20
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-f=
acility.h
index 6cf71cec38..59ee4b5e36 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -9,9 +9,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t your
  * option) any later version.  See the COPYING file in the top-level dir=
ectory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_S390_SCLP_EVENT_FACILITY_H
 #define HW_S390_SCLP_EVENT_FACILITY_H
=20
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-v=
irtio-ccw.h
index 8aa27199c9..821f5098cb 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -8,6 +8,9 @@
  * your option) any later version. See the COPYING file in the top-level
  * directory.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_S390X_S390_VIRTIO_CCW_H
 #define HW_S390X_S390_VIRTIO_CCW_H
=20
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 4687ecfe83..fb78e601c3 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -10,6 +10,8 @@
  * directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_S390_FLIC_H
 #define HW_S390_FLIC_H
=20
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index f9db243484..fc08c07119 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -8,9 +8,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t your
  * option) any later version.  See the COPYING file in the top-level dir=
ectory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_S390_SCLP_H
 #define HW_S390_SCLP_H
=20
diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-k=
eys.h
index 62df48ec06..633b534b51 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -9,6 +9,8 @@
  * directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef S390_STORAGE_KEYS_H
 #define S390_STORAGE_KEYS_H
=20
diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index d71f4ea8a7..23294050e8 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -8,6 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_S390_TOD_H
 #define HW_S390_TOD_H
=20
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index adab63d1c9..4760aa9bfe 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_HW_ESP_H
 #define QEMU_HW_ESP_H
=20
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 426566a5c6..6b6a038678 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_HW_SCSI_H
 #define QEMU_HW_SCSI_H
=20
diff --git a/include/hw/sd/bcm2835_sdhost.h b/include/hw/sd/bcm2835_sdhos=
t.h
index 7520dd6507..81aea28e6d 100644
--- a/include/hw/sd/bcm2835_sdhost.h
+++ b/include/hw/sd/bcm2835_sdhost.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef BCM2835_SDHOST_H
 #define BCM2835_SDHOST_H
=20
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index b865aafc33..5d19fc1d6a 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -27,6 +27,8 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SD_H
 #define HW_SD_H
=20
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index cbf415e43a..de9589eafa 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -22,6 +22,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef SDHCI_H
 #define SDHCI_H
=20
diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index 767a2df7e2..02151a6c68 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef QEMU_SH_H
 #define QEMU_SH_H
 /* Definitions for SH board emulation.  */
diff --git a/include/hw/sh4/sh_intc.h b/include/hw/sh4/sh_intc.h
index 3d3efde059..585342f2dd 100644
--- a/include/hw/sh4/sh_intc.h
+++ b/include/hw/sh4/sh_intc.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef SH_INTC_H
 #define SH_INTC_H
=20
diff --git a/include/hw/sparc/grlib.h b/include/hw/sparc/grlib.h
index 5606ff0a97..0dd51246bd 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/sparc/grlib.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef GRLIB_H
 #define GRLIB_H
=20
diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dm=
a.h
index ab42c5421b..951bd7a6d5 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef SPARC32_DMA_H
 #define SPARC32_DMA_H
=20
diff --git a/include/hw/sparc/sun4m_iommu.h b/include/hw/sparc/sun4m_iomm=
u.h
index 482266c6a7..dc42f8bb28 100644
--- a/include/hw/sparc/sun4m_iommu.h
+++ b/include/hw/sparc/sun4m_iommu.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef SUN4M_IOMMU_H
 #define SUN4M_IOMMU_H
=20
diff --git a/include/hw/sparc/sun4u_iommu.h b/include/hw/sparc/sun4u_iomm=
u.h
index 5472d489cf..d0caf0fa42 100644
--- a/include/hw/sparc/sun4u_iommu.h
+++ b/include/hw/sparc/sun4u_iommu.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef SUN4U_IOMMU_H
 #define SUN4U_IOMMU_H
=20
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index aa07dac4fe..8f1acbf810 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ASPEED_SMC_H
 #define ASPEED_SMC_H
=20
diff --git a/include/hw/ssi/imx_spi.h b/include/hw/ssi/imx_spi.h
index 7103953581..6437c82f88 100644
--- a/include/hw/ssi/imx_spi.h
+++ b/include/hw/ssi/imx_spi.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX_SPI_H
 #define IMX_SPI_H
=20
diff --git a/include/hw/ssi/mss-spi.h b/include/hw/ssi/mss-spi.h
index f0cf3243e0..dbb142fd71 100644
--- a/include/hw/ssi/mss-spi.h
+++ b/include/hw/ssi/mss-spi.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MSS_SPI_H
 #define HW_MSS_SPI_H
=20
diff --git a/include/hw/ssi/pl022.h b/include/hw/ssi/pl022.h
index a080519366..62172e3c73 100644
--- a/include/hw/ssi/pl022.h
+++ b/include/hw/ssi/pl022.h
@@ -18,6 +18,8 @@
  * + sysbus MMIO region 0: MemoryRegion for the device's registers
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SSI_PL022_H
 #define HW_SSI_PL022_H
=20
diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 6a0c3c3cdb..63561e3bac 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -8,6 +8,8 @@
    It is assumed that master and slave are both using the same transfer =
width.
    */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_SSI_H
 #define QEMU_SSI_H
=20
diff --git a/include/hw/ssi/stm32f2xx_spi.h b/include/hw/ssi/stm32f2xx_sp=
i.h
index 1cd73e4cd4..71367a62b7 100644
--- a/include/hw/ssi/stm32f2xx_spi.h
+++ b/include/hw/ssi/stm32f2xx_spi.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_STM32F2XX_SPI_H
 #define HW_STM32F2XX_SPI_H
=20
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.=
h
index 6a39b55a7b..9a7b54326a 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef XILINX_SPIPS_H
 #define XILINX_SPIPS_H
=20
diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 4c668fbbdc..d905217d5c 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_SYSBUS_H
 #define HW_SYSBUS_H
=20
diff --git a/include/hw/timer/a9gtimer.h b/include/hw/timer/a9gtimer.h
index 81c4388784..12e4be0ec7 100644
--- a/include/hw/timer/a9gtimer.h
+++ b/include/hw/timer/a9gtimer.h
@@ -20,6 +20,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef A9GTIMER_H
 #define A9GTIMER_H
=20
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allw=
inner-a10-pit.h
index 871c95b512..96c1f0f024 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ALLWINNER_A10_PIT_H
 #define ALLWINNER_A10_PIT_H
=20
diff --git a/include/hw/timer/arm_mptimer.h b/include/hw/timer/arm_mptime=
r.h
index c46d8d2309..130d99a393 100644
--- a/include/hw/timer/arm_mptimer.h
+++ b/include/hw/timer/arm_mptimer.h
@@ -18,6 +18,9 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_TIMER_ARM_MPTIMER_H
 #define HW_TIMER_ARM_MPTIMER_H
=20
diff --git a/include/hw/timer/armv7m_systick.h b/include/hw/timer/armv7m_=
systick.h
index 25e5ceacc8..a0d7266e68 100644
--- a/include/hw/timer/armv7m_systick.h
+++ b/include/hw/timer/armv7m_systick.h
@@ -9,6 +9,8 @@
  * This code is licensed under the GPL (version 2 or later).
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_TIMER_ARMV7M_SYSTICK_H
 #define HW_TIMER_ARMV7M_SYSTICK_H
=20
diff --git a/include/hw/timer/aspeed_rtc.h b/include/hw/timer/aspeed_rtc.=
h
index 1f1155a676..b90e41c566 100644
--- a/include/hw/timer/aspeed_rtc.h
+++ b/include/hw/timer/aspeed_rtc.h
@@ -5,6 +5,9 @@
  * Copyright 2019 IBM Corp
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ASPEED_RTC_H
 #define ASPEED_RTC_H
=20
diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_ti=
mer.h
index 1fb949e167..e3f5e87d41 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -19,6 +19,9 @@
  *  with this program; if not, write to the Free Software Foundation, In=
c.,
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef ASPEED_TIMER_H
 #define ASPEED_TIMER_H
=20
diff --git a/include/hw/timer/cmsdk-apb-dualtimer.h b/include/hw/timer/cm=
sdk-apb-dualtimer.h
index 9843a9dbb1..fafa1d89c9 100644
--- a/include/hw/timer/cmsdk-apb-dualtimer.h
+++ b/include/hw/timer/cmsdk-apb-dualtimer.h
@@ -23,6 +23,8 @@
  *  + sysbus IRQ 2: timer block 2 interrupt TIMINT2
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef CMSDK_APB_DUALTIMER_H
 #define CMSDK_APB_DUALTIMER_H
=20
diff --git a/include/hw/timer/cmsdk-apb-timer.h b/include/hw/timer/cmsdk-=
apb-timer.h
index f21686d26b..697d92036c 100644
--- a/include/hw/timer/cmsdk-apb-timer.h
+++ b/include/hw/timer/cmsdk-apb-timer.h
@@ -9,6 +9,8 @@
  *  (at your option) any later version.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef CMSDK_APB_TIMER_H
 #define CMSDK_APB_TIMER_H
=20
diff --git a/include/hw/timer/digic-timer.h b/include/hw/timer/digic-time=
r.h
index d9e67fe291..fcde81d4ab 100644
--- a/include/hw/timer/digic-timer.h
+++ b/include/hw/timer/digic-timer.h
@@ -12,9 +12,10 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_TIMER_DIGIC_TIMER_H
 #define HW_TIMER_DIGIC_TIMER_H
=20
diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 5b12eb918e..a380824cea 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_I8254_H
 #define HW_I8254_H
=20
diff --git a/include/hw/timer/i8254_internal.h b/include/hw/timer/i8254_i=
nternal.h
index e611c6f227..4422c1963a 100644
--- a/include/hw/timer/i8254_internal.h
+++ b/include/hw/timer/i8254_internal.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_I8254_INTERNAL_H
 #define QEMU_I8254_INTERNAL_H
=20
diff --git a/include/hw/timer/imx_epit.h b/include/hw/timer/imx_epit.h
index 0730ac35e6..16a1580b08 100644
--- a/include/hw/timer/imx_epit.h
+++ b/include/hw/timer/imx_epit.h
@@ -26,6 +26,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX_EPIT_H
 #define IMX_EPIT_H
=20
diff --git a/include/hw/timer/imx_gpt.h b/include/hw/timer/imx_gpt.h
index 20ccb327c4..d14c2f4e28 100644
--- a/include/hw/timer/imx_gpt.h
+++ b/include/hw/timer/imx_gpt.h
@@ -26,6 +26,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef IMX_GPT_H
 #define IMX_GPT_H
=20
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rt=
c.h
index fe6ed63f71..97e3a3d63c 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef MC146818RTC_H
 #define MC146818RTC_H
=20
diff --git a/include/hw/timer/mss-timer.h b/include/hw/timer/mss-timer.h
index d15d1732f8..ed8246b28d 100644
--- a/include/hw/timer/mss-timer.h
+++ b/include/hw/timer/mss-timer.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_MSS_TIMER_H
 #define HW_MSS_TIMER_H
=20
diff --git a/include/hw/timer/nrf51_timer.h b/include/hw/timer/nrf51_time=
r.h
index 85cad2300d..4d67a1f68f 100644
--- a/include/hw/timer/nrf51_timer.h
+++ b/include/hw/timer/nrf51_timer.h
@@ -10,6 +10,9 @@
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef NRF51_TIMER_H
 #define NRF51_TIMER_H
=20
diff --git a/include/hw/timer/pl031.h b/include/hw/timer/pl031.h
index 8857c24ca5..314a2472ae 100644
--- a/include/hw/timer/pl031.h
+++ b/include/hw/timer/pl031.h
@@ -11,6 +11,8 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_TIMER_PL031_H
 #define HW_TIMER_PL031_H
=20
diff --git a/include/hw/timer/stm32f2xx_timer.h b/include/hw/timer/stm32f=
2xx_timer.h
index e6a83237a5..1f72ae6e97 100644
--- a/include/hw/timer/stm32f2xx_timer.h
+++ b/include/hw/timer/stm32f2xx_timer.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_STM32F2XX_TIMER_H
 #define HW_STM32F2XX_TIMER_H
=20
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-z=
ynqmp-rtc.h
index 97e32322ed..4ba2644f2b 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_TIMER_XLNX_ZYNQMP_RTC_H
 #define HW_TIMER_XLNX_ZYNQMP_RTC_H
=20
diff --git a/include/hw/usb.h b/include/hw/usb.h
index c21f41c8a9..df72f05112 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_USB_H
 #define QEMU_USB_H
=20
diff --git a/include/hw/usb/chipidea.h b/include/hw/usb/chipidea.h
index 1ec2e9dbda..abc8073086 100644
--- a/include/hw/usb/chipidea.h
+++ b/include/hw/usb/chipidea.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef CHIPIDEA_H
 #define CHIPIDEA_H
=20
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
index 6f6670783f..e8ddcf0cb5 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -5,9 +5,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
- *
  */
=20
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef VHOST_BACKEND_H
 #define VHOST_BACKEND_H
=20
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vh=
ost-scsi-common.h
index 54357164f0..b26a0936b6 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -8,9 +8,10 @@
  *
  * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
  * See the COPYING.LIB file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef VHOST_SCSI_COMMON_H
 #define VHOST_SCSI_COMMON_H
=20
diff --git a/include/hw/virtio/vhost-scsi.h b/include/hw/virtio/vhost-scs=
i.h
index df5bfdb188..b1b5a05e6f 100644
--- a/include/hw/virtio/vhost-scsi.h
+++ b/include/hw/virtio/vhost-scsi.h
@@ -8,9 +8,10 @@
  *
  * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
  * See the COPYING.LIB file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef VHOST_SCSI_H
 #define VHOST_SCSI_H
=20
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
index 8dbf11c6f0..28fa790e6d 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -9,9 +9,10 @@
  *
  * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
  * See the COPYING.LIB file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef VHOST_USER_BLK_H
 #define VHOST_USER_BLK_H
=20
diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhos=
t-user-scsi.h
index 1b332ea910..707fba45da 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -11,9 +11,10 @@
  *
  * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
  * See the COPYING.LIB file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef VHOST_USER_SCSI_H
 #define VHOST_USER_SCSI_H
=20
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
index 811e325f42..a2d3ab21e6 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -5,6 +5,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_VIRTIO_VHOST_USER_H
 #define HW_VIRTIO_VHOST_USER_H
=20
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vs=
ock.h
index d509d67c4a..c86de7a8d3 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -11,6 +11,8 @@
  * top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VHOST_VSOCK_H
 #define QEMU_VHOST_VSOCK_H
=20
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 619498c8f4..8c18a4409f 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef VHOST_H
 #define VHOST_H
=20
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
index 1afafb12f6..b9c4736656 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -9,9 +9,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VIRTIO_BALLOON_H
 #define QEMU_VIRTIO_BALLOON_H
=20
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-bl=
k.h
index cddcfbebe9..4947202519 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -8,9 +8,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VIRTIO_BLK_H
 #define QEMU_VIRTIO_BLK_H
=20
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bu=
s.h
index 7fec9dc929..7e72b4aa3c 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -19,9 +19,10 @@
  *
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef VIRTIO_BUS_H
 #define VIRTIO_BUS_H
=20
diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio=
-crypto.h
index ffe2391ece..4f2d1e80ce 100644
--- a/include/hw/virtio/virtio-crypto.h
+++ b/include/hw/virtio/virtio-crypto.h
@@ -11,6 +11,8 @@
  * top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VIRTIO_CRYPTO_H
 #define QEMU_VIRTIO_CRYPTO_H
=20
diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-=
input.h
index 4fca03e796..8b84ec71a6 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VIRTIO_INPUT_H
 #define QEMU_VIRTIO_INPUT_H
=20
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
index b96f0c643f..b7858a4fc0 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -8,9 +8,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VIRTIO_NET_H
 #define QEMU_VIRTIO_NET_H
=20
diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-p=
mem.h
index 19b6ee6d75..ed3679fae3 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef HW_VIRTIO_PMEM_H
 #define HW_VIRTIO_PMEM_H
=20
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rn=
g.h
index ff699335e3..9868edee18 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -9,6 +9,8 @@
  * top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VIRTIO_RNG_H
 #define QEMU_VIRTIO_RNG_H
=20
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-s=
csi.h
index 4c0bcdb788..84db6e7874 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -8,9 +8,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VIRTIO_SCSI_H
 #define QEMU_VIRTIO_SCSI_H
=20
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio=
-serial.h
index 12657a9f39..091f9c5dc0 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -10,9 +10,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VIRTIO_SERIAL_H
 #define QEMU_VIRTIO_SERIAL_H
=20
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b189788cb2..7d2fd4063b 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -8,9 +8,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VIRTIO_H
 #define QEMU_VIRTIO_H
=20
diff --git a/include/hw/watchdog/cmsdk-apb-watchdog.h b/include/hw/watchd=
og/cmsdk-apb-watchdog.h
index 6ae9531370..b9c9bbc348 100644
--- a/include/hw/watchdog/cmsdk-apb-watchdog.h
+++ b/include/hw/watchdog/cmsdk-apb-watchdog.h
@@ -28,6 +28,8 @@
  * to watchdog_perform_action(), at least for the moment.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef CMSDK_APB_WATCHDOG_H
 #define CMSDK_APB_WATCHDOG_H
=20
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_a=
speed.h
index 8c5691ce20..8e9c301177 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef WDT_ASPEED_H
 #define WDT_ASPEED_H
=20
diff --git a/include/hw/watchdog/wdt_diag288.h b/include/hw/watchdog/wdt_=
diag288.h
index 706d96b753..f637df74a6 100644
--- a/include/hw/watchdog/wdt_diag288.h
+++ b/include/hw/watchdog/wdt_diag288.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef WDT_DIAG288_H
 #define WDT_DIAG288_H
=20
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 9c7b5f78dc..e24b9e41cc 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef QEMU_HW_XEN_H
 #define QEMU_HW_XEN_H
=20
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 77e47398c4..6f14740e84 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef VHOST_NET_H
 #define VHOST_NET_H
=20
diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index b66cf93c4b..21bffa7f8c 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -8,6 +8,9 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  */
+
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef IOVA_TREE_H
 #define IOVA_TREE_H
=20
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index aea0c44985..30f244cbaa 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -8,9 +8,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
- *
  */
=20
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef QEMU_BALLOON_H
 #define QEMU_BALLOON_H
=20
diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/sysemu/crypt=
odev-vhost-user.h
index 0d3421e7e8..06c0213c29 100644
--- a/include/sysemu/cryptodev-vhost-user.h
+++ b/include/sysemu/cryptodev-vhost-user.h
@@ -18,9 +18,10 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef CRYPTODEV_VHOST_USER_H
 #define CRYPTODEV_VHOST_USER_H
=20
diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-=
vhost.h
index f42824fbde..59d55704f9 100644
--- a/include/sysemu/cryptodev-vhost.h
+++ b/include/sysemu/cryptodev-vhost.h
@@ -19,8 +19,10 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
- *
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef CRYPTODEV_VHOST_H
 #define CRYPTODEV_VHOST_H
=20
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 5da3c4e3c5..07fa2d5a04 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -7,6 +7,8 @@
  * (GNU GPL), version 2 or later.
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef DMA_H
 #define DMA_H
=20
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 92fa0e458c..34f753d89c 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef SYSEMU_HOSTMEM_H
 #define SYSEMU_HOSTMEM_H
=20
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 7a1c3cdcb1..a5f1198af4 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -3,9 +3,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
- *
  */
=20
+/* FIXME Does not pass make check-headers for user emulation, yet! */
+
 #ifndef QEMU_KVM_INT_H
 #define QEMU_KVM_INT_H
=20
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 01a263eba2..5e481b4de6 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -1,3 +1,5 @@
+/* NOTE: May not be included into user emulation code */
+
 #ifndef SYSEMU_NUMA_H
 #define SYSEMU_NUMA_H
=20
diff --git a/include/sysemu/vhost-user-backend.h b/include/sysemu/vhost-u=
ser-backend.h
index 9abf8f06a1..b505fe386a 100644
--- a/include/sysemu/vhost-user-backend.h
+++ b/include/sysemu/vhost-user-backend.h
@@ -9,6 +9,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
+/* NOTE: May not be included into user emulation code */
+
 #ifndef QEMU_VHOST_USER_BACKEND_H
 #define QEMU_VHOST_USER_BACKEND_H
=20
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.=
h
index c8e7c2f6cf..6f3cadcfeb 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -3,9 +3,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
- *
  */
=20
+/* NOTE: May not be included into user emulation code */
+
 #ifndef XEN_MAPCACHE_H
 #define XEN_MAPCACHE_H
=20
diff --git a/tests/check-headers.mak b/tests/check-headers.mak
index fee538c33b..0186adabb0 100644
--- a/tests/check-headers.mak
+++ b/tests/check-headers.mak
@@ -21,6 +21,10 @@ target-headers :=3D $(shell cd $(SRC_PATH) && egrep -l=
 '$(target-header-regexp)' $
 # Headers for target-independent code only
 untarget-headers :=3D include/exec/poison.h
=20
+# Headers not for user emulation (include hw/hw.h)
+hw-header-regexp :=3D NOTE: May not be included into user emulation code
+hw-headers :=3D $(shell cd $(SRC_PATH) && egrep -l '$(hw-header-regexp)'=
 $(src-headers))
+
 # Headers carrying a FIXME about this test
 # Extended regular expression matching the FIXME comment in headers
 # not expected to pass the test in this build's configuration:
@@ -93,10 +97,12 @@ checked-headers :=3D $(filter-out $(excluded-headers)=
 $(bad-headers) $(target-head
 check-header-tests :=3D $(patsubst %.h, tests/headers/%.c, $(checked-hea=
ders))
 # to be checked for each target: all less excluded, bad, and untarget
 checked-target-headers :=3D $(filter-out $(excluded-headers) $(bad-heade=
rs) $(untarget-headers), $(src-headers))
-# Testing target-independent headers for each target is massive
-# overkill, limit to target-dependent headers for now.  This leaves
-# gaps in testing.  TODO accept the overkill or pick something in betwee=
n
-checked-target-headers :=3D $(filter $(target-headers), $(checked-target=
-headers))
+# less hw for user emulation targets
+ifneq ($(TARGET_DIR),)
+ifneq ($(CONFIG_USER_ONLY),)
+checked-target-headers :=3D $(filter-out $(hw-headers), $(checked-target=
-headers))
+endif
+endif
 check-target-header-tests :=3D $(patsubst %.h, tests/headers-tgt/%.c, $(=
checked-target-headers))
=20
 # Bad headers (all less excluded and checked):
--=20
2.21.0


