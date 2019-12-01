Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D664C43215
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02202146E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2Ak46ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02202146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNGe-000375-KQ
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNCh-0000wq-9h
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNCc-00081Z-SB
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:15:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47784
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNCc-00080R-Cn
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575198945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zpw12KGddhJ0t4xIz2JllZmDZqglJWzSz9/CmzcRj+E=;
 b=H2Ak46yaTgYzaMGKlMHTbgIoSe6t1uwrNkm8L2hsUeQIwwBSO/g+T24Ud9lVJib9RT5N7v
 QhTygut+9+AcfBc1PVHyb8S86d4mYen72WH1LJcmzd7maOdIKbWCdg849UjSRKw0ikeQg3
 o0Lsvfik2+Gl7LRCpDzKoz76gHBU0UY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-68SicEMzM1u_obMyRoeyRw-1; Sun, 01 Dec 2019 06:15:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 278AD80183C
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:15:41 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A78510013A7;
 Sun,  1 Dec 2019 11:15:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/26] Make QDev use class properties
Date: Sun,  1 Dec 2019 15:15:05 +0400
Message-Id: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 68SicEMzM1u_obMyRoeyRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

QDev properties are registered per instances, although define
statically with the class. With QOM default values support, and "link"
class property, all QDev properties can be registered with the class.

Various other small related fixes and improvements included.

Based-on: <20191120152442.26657-2-marcandre.lureau@redhat.com>

Marc-Andr=C3=A9 Lureau (26):
  object: add extra sanity checks
  qdev: remove duplicated qdev_property_add_static() doc
  qdev: remove extraneous error
  qdev: move helper function to monitor/misc
  object: avoid extra class property key duplication
  object: add class property initializer
  object: add object_property_get_defaut()
  object: make object_class_property_add* return property
  qstring: add qstring_free()
  object: add object_property_set_defaut_{bool,str,int,uint}()
  object: do not free class properties
  object: check strong flag with &
  object: rename link "child" to "target"
  object: add direct link flag
  object: express const link with link property
  object: add object_class_property_add_link()
  object: release all props
  object: return self in object_ref()
  qdev: set properties with device_class_set_props()
  qdev: move instance properties to class properties
  qdev: register properties as class properties
  vl: print default value in object help
  qom: simplify qmp_device_list_properties()
  qom: introduce object_property_help()
  qapi/qmp: add ObjectPropertyInfo.default-value
  qdev: use object_property_help()

 hw/9pfs/virtio-9p-device.c          |   2 +-
 hw/acpi/generic_event_device.c      |   2 +-
 hw/acpi/piix4.c                     |   2 +-
 hw/acpi/vmgenid.c                   |   2 +-
 hw/arm/armsse.c                     |   2 +-
 hw/arm/armv7m.c                     |   4 +-
 hw/arm/aspeed_soc.c                 |   2 +-
 hw/arm/bcm2836.c                    |   2 +-
 hw/arm/integratorcp.c               |   2 +-
 hw/arm/msf2-soc.c                   |   2 +-
 hw/arm/musicpal.c                   |   2 +-
 hw/arm/nrf51_soc.c                  |   2 +-
 hw/arm/pxa2xx.c                     |   4 +-
 hw/arm/pxa2xx_gpio.c                |   2 +-
 hw/arm/smmu-common.c                |   2 +-
 hw/arm/spitz.c                      |   2 +-
 hw/arm/stm32f205_soc.c              |   2 +-
 hw/arm/strongarm.c                  |   2 +-
 hw/arm/xlnx-versal.c                |   2 +-
 hw/arm/xlnx-zynqmp.c                |   2 +-
 hw/audio/ac97.c                     |   2 +-
 hw/audio/adlib.c                    |   2 +-
 hw/audio/cs4231.c                   |   2 +-
 hw/audio/cs4231a.c                  |   2 +-
 hw/audio/es1370.c                   |   2 +-
 hw/audio/gus.c                      |   2 +-
 hw/audio/hda-codec.c                |   2 +-
 hw/audio/intel-hda.c                |   4 +-
 hw/audio/milkymist-ac97.c           |   2 +-
 hw/audio/pcspk.c                    |   2 +-
 hw/audio/pl041.c                    |   2 +-
 hw/audio/sb16.c                     |   2 +-
 hw/audio/wm8750.c                   |   2 +-
 hw/block/fdc.c                      |   8 +-
 hw/block/m25p80.c                   |   2 +-
 hw/block/nand.c                     |   2 +-
 hw/block/nvme.c                     |   2 +-
 hw/block/onenand.c                  |   2 +-
 hw/block/pflash_cfi01.c             |   2 +-
 hw/block/pflash_cfi02.c             |   2 +-
 hw/block/swim.c                     |   2 +-
 hw/block/vhost-user-blk.c           |   2 +-
 hw/block/virtio-blk.c               |   2 +-
 hw/block/xen-block.c                |   2 +-
 hw/char/bcm2835_aux.c               |   2 +-
 hw/char/cadence_uart.c              |   2 +-
 hw/char/cmsdk-apb-uart.c            |   2 +-
 hw/char/debugcon.c                  |   2 +-
 hw/char/digic-uart.c                |   2 +-
 hw/char/escc.c                      |   2 +-
 hw/char/etraxfs_ser.c               |   2 +-
 hw/char/exynos4210_uart.c           |   2 +-
 hw/char/grlib_apbuart.c             |   2 +-
 hw/char/imx_serial.c                |   2 +-
 hw/char/ipoctal232.c                |   2 +-
 hw/char/lm32_juart.c                |   2 +-
 hw/char/lm32_uart.c                 |   2 +-
 hw/char/mcf_uart.c                  |   2 +-
 hw/char/milkymist-uart.c            |   2 +-
 hw/char/nrf51_uart.c                |   2 +-
 hw/char/parallel.c                  |   2 +-
 hw/char/pl011.c                     |   2 +-
 hw/char/sclpconsole-lm.c            |   2 +-
 hw/char/sclpconsole.c               |   2 +-
 hw/char/serial-isa.c                |   2 +-
 hw/char/serial-pci-multi.c          |   4 +-
 hw/char/serial-pci.c                |   2 +-
 hw/char/serial.c                    |   4 +-
 hw/char/spapr_vty.c                 |   2 +-
 hw/char/stm32f2xx_usart.c           |   2 +-
 hw/char/terminal3270.c              |   2 +-
 hw/char/virtio-console.c            |   2 +-
 hw/char/virtio-serial-bus.c         |   4 +-
 hw/char/xilinx_uartlite.c           |   2 +-
 hw/core/cpu.c                       |   2 +-
 hw/core/generic-loader.c            |   2 +-
 hw/core/or-irq.c                    |   2 +-
 hw/core/platform-bus.c              |   2 +-
 hw/core/qdev-properties.c           |  38 ++--
 hw/core/qdev.c                      | 155 ++++++--------
 hw/core/split-irq.c                 |   2 +-
 hw/cpu/a15mpcore.c                  |   2 +-
 hw/cpu/a9mpcore.c                   |   2 +-
 hw/cpu/arm11mpcore.c                |   2 +-
 hw/cpu/cluster.c                    |   2 +-
 hw/cpu/realview_mpcore.c            |   2 +-
 hw/display/ati.c                    |   2 +-
 hw/display/bcm2835_fb.c             |   2 +-
 hw/display/bochs-display.c          |   2 +-
 hw/display/cg3.c                    |   2 +-
 hw/display/cirrus_vga.c             |   2 +-
 hw/display/cirrus_vga_isa.c         |   2 +-
 hw/display/g364fb.c                 |   2 +-
 hw/display/i2c-ddc.c                |   2 +-
 hw/display/macfb.c                  |   4 +-
 hw/display/milkymist-vgafb.c        |   2 +-
 hw/display/qxl.c                    |   2 +-
 hw/display/ramfb-standalone.c       |   2 +-
 hw/display/sm501.c                  |   4 +-
 hw/display/tcx.c                    |   2 +-
 hw/display/vga-isa.c                |   2 +-
 hw/display/vga-pci.c                |   4 +-
 hw/display/vhost-user-gpu.c         |   2 +-
 hw/display/virtio-gpu-pci.c         |   2 +-
 hw/display/virtio-gpu.c             |   2 +-
 hw/display/virtio-vga.c             |   2 +-
 hw/display/vmware_vga.c             |   2 +-
 hw/dma/i82374.c                     |   2 +-
 hw/dma/i8257.c                      |   2 +-
 hw/dma/pl080.c                      |   2 +-
 hw/dma/pl330.c                      |   2 +-
 hw/dma/pxa2xx_dma.c                 |   2 +-
 hw/dma/xilinx_axidma.c              |   2 +-
 hw/dma/xlnx-zdma.c                  |   2 +-
 hw/gpio/imx_gpio.c                  |   2 +-
 hw/gpio/omap_gpio.c                 |   4 +-
 hw/i2c/core.c                       |   2 +-
 hw/i2c/omap_i2c.c                   |   2 +-
 hw/i386/intel_iommu.c               |   2 +-
 hw/i386/kvm/clock.c                 |   2 +-
 hw/i386/kvm/i8254.c                 |   2 +-
 hw/i386/kvm/ioapic.c                |   2 +-
 hw/i386/vmmouse.c                   |   2 +-
 hw/i386/x86-iommu.c                 |   2 +-
 hw/i386/xen/xen_pvdevice.c          |   2 +-
 hw/ide/ahci.c                       |   2 +-
 hw/ide/cmd646.c                     |   2 +-
 hw/ide/isa.c                        |   2 +-
 hw/ide/macio.c                      |   2 +-
 hw/ide/mmio.c                       |   2 +-
 hw/ide/qdev.c                       |   8 +-
 hw/input/adb.c                      |   2 +-
 hw/input/milkymist-softusb.c        |   2 +-
 hw/input/virtio-input-hid.c         |   6 +-
 hw/input/virtio-input-host.c        |   2 +-
 hw/input/virtio-input.c             |   2 +-
 hw/intc/apic_common.c               |   2 +-
 hw/intc/arm_gic_common.c            |   2 +-
 hw/intc/arm_gicv2m.c                |   2 +-
 hw/intc/arm_gicv3_common.c          |   2 +-
 hw/intc/arm_gicv3_its_kvm.c         |   2 +-
 hw/intc/armv7m_nvic.c               |   2 +-
 hw/intc/exynos4210_combiner.c       |   2 +-
 hw/intc/exynos4210_gic.c            |   4 +-
 hw/intc/i8259_common.c              |   2 +-
 hw/intc/ioapic.c                    |   2 +-
 hw/intc/mips_gic.c                  |   2 +-
 hw/intc/omap_intc.c                 |   4 +-
 hw/intc/ompic.c                     |   2 +-
 hw/intc/openpic.c                   |   2 +-
 hw/intc/openpic_kvm.c               |   2 +-
 hw/intc/pnv_xive.c                  |   2 +-
 hw/intc/s390_flic.c                 |   2 +-
 hw/intc/spapr_xive.c                |   2 +-
 hw/intc/xics.c                      |   2 +-
 hw/intc/xilinx_intc.c               |   2 +-
 hw/intc/xive.c                      |   4 +-
 hw/intc/xlnx-pmu-iomod-intc.c       |   2 +-
 hw/ipack/ipack.c                    |   2 +-
 hw/ipmi/ipmi.c                      |   2 +-
 hw/ipmi/ipmi_bmc_extern.c           |   2 +-
 hw/ipmi/ipmi_bmc_sim.c              |   2 +-
 hw/ipmi/isa_ipmi_bt.c               |   2 +-
 hw/ipmi/isa_ipmi_kcs.c              |   2 +-
 hw/isa/lpc_ich9.c                   |   2 +-
 hw/isa/pc87312.c                    |   2 +-
 hw/isa/vt82c686.c                   |   2 +-
 hw/mem/nvdimm.c                     |   2 +-
 hw/mem/pc-dimm.c                    |   2 +-
 hw/mips/cps.c                       |   2 +-
 hw/misc/a9scu.c                     |   2 +-
 hw/misc/applesmc.c                  |   2 +-
 hw/misc/arm11scu.c                  |   2 +-
 hw/misc/arm_l2x0.c                  |   2 +-
 hw/misc/arm_sysctl.c                |   2 +-
 hw/misc/armsse-cpuid.c              |   2 +-
 hw/misc/aspeed_scu.c                |   2 +-
 hw/misc/aspeed_sdmc.c               |   2 +-
 hw/misc/bcm2835_property.c          |   2 +-
 hw/misc/debugexit.c                 |   2 +-
 hw/misc/eccmemctl.c                 |   2 +-
 hw/misc/iotkit-sysctl.c             |   2 +-
 hw/misc/iotkit-sysinfo.c            |   2 +-
 hw/misc/ivshmem.c                   |   4 +-
 hw/misc/macio/cuda.c                |   2 +-
 hw/misc/macio/macio.c               |   4 +-
 hw/misc/macio/pmu.c                 |   2 +-
 hw/misc/mips_cmgcr.c                |   2 +-
 hw/misc/mips_cpc.c                  |   2 +-
 hw/misc/mips_itu.c                  |   2 +-
 hw/misc/mos6522.c                   |   2 +-
 hw/misc/mps2-fpgaio.c               |   2 +-
 hw/misc/mps2-scc.c                  |   2 +-
 hw/misc/msf2-sysreg.c               |   2 +-
 hw/misc/nrf51_rng.c                 |   2 +-
 hw/misc/pci-testdev.c               |   2 +-
 hw/misc/pvpanic.c                   |   2 +-
 hw/misc/tz-mpc.c                    |   2 +-
 hw/misc/tz-msc.c                    |   2 +-
 hw/misc/tz-ppc.c                    |   2 +-
 hw/misc/unimp.c                     |   2 +-
 hw/net/allwinner_emac.c             |   2 +-
 hw/net/cadence_gem.c                |   2 +-
 hw/net/dp8393x.c                    |   2 +-
 hw/net/e1000.c                      |   2 +-
 hw/net/e1000e.c                     |   2 +-
 hw/net/eepro100.c                   |   2 +-
 hw/net/etraxfs_eth.c                |   2 +-
 hw/net/fsl_etsec/etsec.c            |   2 +-
 hw/net/ftgmac100.c                  |   2 +-
 hw/net/imx_fec.c                    |   2 +-
 hw/net/lan9118.c                    |   2 +-
 hw/net/lance.c                      |   2 +-
 hw/net/mcf_fec.c                    |   2 +-
 hw/net/milkymist-minimac2.c         |   2 +-
 hw/net/mipsnet.c                    |   2 +-
 hw/net/ne2000-isa.c                 |   2 +-
 hw/net/ne2000-pci.c                 |   2 +-
 hw/net/opencores_eth.c              |   2 +-
 hw/net/pcnet-pci.c                  |   2 +-
 hw/net/rocker/rocker.c              |   2 +-
 hw/net/rtl8139.c                    |   2 +-
 hw/net/smc91c111.c                  |   2 +-
 hw/net/spapr_llan.c                 |   2 +-
 hw/net/stellaris_enet.c             |   2 +-
 hw/net/sungem.c                     |   2 +-
 hw/net/sunhme.c                     |   2 +-
 hw/net/tulip.c                      |   2 +-
 hw/net/virtio-net.c                 |   2 +-
 hw/net/vmxnet3.c                    |   2 +-
 hw/net/xgmac.c                      |   2 +-
 hw/net/xilinx_axienet.c             |   2 +-
 hw/net/xilinx_ethlite.c             |   2 +-
 hw/nvram/ds1225y.c                  |   2 +-
 hw/nvram/eeprom_at24c.c             |   2 +-
 hw/nvram/fw_cfg.c                   |   4 +-
 hw/nvram/mac_nvram.c                |   2 +-
 hw/nvram/nrf51_nvm.c                |   2 +-
 hw/nvram/spapr_nvram.c              |   2 +-
 hw/pci-bridge/gen_pcie_root_port.c  |   2 +-
 hw/pci-bridge/pci_bridge_dev.c      |   2 +-
 hw/pci-bridge/pci_expander_bridge.c |   4 +-
 hw/pci-bridge/pcie_pci_bridge.c     |   2 +-
 hw/pci-bridge/pcie_root_port.c      |   2 +-
 hw/pci-bridge/xio3130_downstream.c  |   2 +-
 hw/pci-host/grackle.c               |   2 +-
 hw/pci-host/i440fx.c                |   2 +-
 hw/pci-host/ppce500.c               |   2 +-
 hw/pci-host/prep.c                  |   2 +-
 hw/pci-host/q35.c                   |   4 +-
 hw/pci-host/sabre.c                 |   2 +-
 hw/pci-host/uninorth.c              |   2 +-
 hw/pci-host/versatile.c             |   2 +-
 hw/pci-host/xilinx-pcie.c           |   2 +-
 hw/pci/pci.c                        |   2 +-
 hw/pci/pcie_port.c                  |   4 +-
 hw/ppc/pnv.c                        |   2 +-
 hw/ppc/pnv_core.c                   |   4 +-
 hw/ppc/pnv_psi.c                    |   2 +-
 hw/ppc/ppc440_uc.c                  |   2 +-
 hw/ppc/prep_systemio.c              |   2 +-
 hw/ppc/rs6000_mc.c                  |   2 +-
 hw/ppc/spapr_cpu_core.c             |   2 +-
 hw/ppc/spapr_pci.c                  |   2 +-
 hw/ppc/spapr_rng.c                  |   2 +-
 hw/ppc/spapr_tpm_proxy.c            |   2 +-
 hw/rdma/vmw/pvrdma_main.c           |   2 +-
 hw/riscv/riscv_hart.c               |   2 +-
 hw/riscv/sifive_clint.c             |   2 +-
 hw/riscv/sifive_plic.c              |   2 +-
 hw/riscv/sifive_u_otp.c             |   2 +-
 hw/rtc/m48t59-isa.c                 |   2 +-
 hw/rtc/m48t59.c                     |   2 +-
 hw/rtc/mc146818rtc.c                |   2 +-
 hw/rtc/pl031.c                      |   2 +-
 hw/s390x/3270-ccw.c                 |   2 +-
 hw/s390x/ccw-device.c               |   2 +-
 hw/s390x/css-bridge.c               |   2 +-
 hw/s390x/ipl.c                      |   2 +-
 hw/s390x/s390-pci-bus.c             |   2 +-
 hw/s390x/vhost-vsock-ccw.c          |   2 +-
 hw/s390x/virtio-ccw-9p.c            |   2 +-
 hw/s390x/virtio-ccw-balloon.c       |   2 +-
 hw/s390x/virtio-ccw-blk.c           |   2 +-
 hw/s390x/virtio-ccw-crypto.c        |   2 +-
 hw/s390x/virtio-ccw-gpu.c           |   2 +-
 hw/s390x/virtio-ccw-input.c         |   2 +-
 hw/s390x/virtio-ccw-net.c           |   2 +-
 hw/s390x/virtio-ccw-rng.c           |   2 +-
 hw/s390x/virtio-ccw-scsi.c          |   4 +-
 hw/s390x/virtio-ccw-serial.c        |   2 +-
 hw/scsi/megasas.c                   |   2 +-
 hw/scsi/mptsas.c                    |   2 +-
 hw/scsi/scsi-bus.c                  |   2 +-
 hw/scsi/scsi-disk.c                 |   8 +-
 hw/scsi/scsi-generic.c              |   2 +-
 hw/scsi/spapr_vscsi.c               |   2 +-
 hw/scsi/vhost-scsi.c                |   2 +-
 hw/scsi/vhost-user-scsi.c           |   2 +-
 hw/scsi/virtio-scsi.c               |   2 +-
 hw/scsi/vmw_pvscsi.c                |   2 +-
 hw/sd/sd.c                          |   2 +-
 hw/sd/sdhci-pci.c                   |   2 +-
 hw/sd/sdhci.c                       |   2 +-
 hw/sparc/sun4m.c                    |   4 +-
 hw/sparc/sun4m_iommu.c              |   2 +-
 hw/sparc64/sun4u.c                  |   6 +-
 hw/ssi/aspeed_smc.c                 |   2 +-
 hw/ssi/xilinx_spi.c                 |   2 +-
 hw/ssi/xilinx_spips.c               |   4 +-
 hw/timer/a9gtimer.c                 |   2 +-
 hw/timer/allwinner-a10-pit.c        |   2 +-
 hw/timer/altera_timer.c             |   2 +-
 hw/timer/arm_mptimer.c              |   2 +-
 hw/timer/arm_timer.c                |   2 +-
 hw/timer/cmsdk-apb-dualtimer.c      |   2 +-
 hw/timer/cmsdk-apb-timer.c          |   2 +-
 hw/timer/grlib_gptimer.c            |   2 +-
 hw/timer/hpet.c                     |   2 +-
 hw/timer/i8254.c                    |   2 +-
 hw/timer/lm32_timer.c               |   2 +-
 hw/timer/milkymist-sysctl.c         |   2 +-
 hw/timer/mss-timer.c                |   2 +-
 hw/timer/pxa2xx_timer.c             |   4 +-
 hw/timer/slavio_timer.c             |   2 +-
 hw/timer/stm32f2xx_timer.c          |   2 +-
 hw/timer/xilinx_timer.c             |   2 +-
 hw/tpm/tpm_crb.c                    |   2 +-
 hw/tpm/tpm_tis.c                    |   2 +-
 hw/usb/bus.c                        |   2 +-
 hw/usb/ccid-card-emulated.c         |   2 +-
 hw/usb/ccid-card-passthru.c         |   2 +-
 hw/usb/dev-audio.c                  |   2 +-
 hw/usb/dev-hid.c                    |   6 +-
 hw/usb/dev-hub.c                    |   2 +-
 hw/usb/dev-mtp.c                    |   2 +-
 hw/usb/dev-network.c                |   2 +-
 hw/usb/dev-serial.c                 |   4 +-
 hw/usb/dev-smartcard-reader.c       |   4 +-
 hw/usb/dev-storage.c                |   2 +-
 hw/usb/dev-uas.c                    |   2 +-
 hw/usb/hcd-ehci-pci.c               |   2 +-
 hw/usb/hcd-ehci-sysbus.c            |   2 +-
 hw/usb/hcd-ohci-pci.c               |   2 +-
 hw/usb/hcd-ohci.c                   |   2 +-
 hw/usb/hcd-uhci.c                   |   4 +-
 hw/usb/hcd-xhci-nec.c               |   2 +-
 hw/usb/hcd-xhci.c                   |   2 +-
 hw/usb/host-libusb.c                |   2 +-
 hw/usb/redirect.c                   |   2 +-
 hw/vfio/ap.c                        |   2 +-
 hw/vfio/ccw.c                       |   2 +-
 hw/vfio/pci.c                       |   4 +-
 hw/vfio/platform.c                  |   2 +-
 hw/virtio/vhost-scsi-pci.c          |   2 +-
 hw/virtio/vhost-user-blk-pci.c      |   2 +-
 hw/virtio/vhost-user-fs-pci.c       |   2 +-
 hw/virtio/vhost-user-fs.c           |   2 +-
 hw/virtio/vhost-user-scsi-pci.c     |   2 +-
 hw/virtio/vhost-vsock-pci.c         |   2 +-
 hw/virtio/vhost-vsock.c             |   2 +-
 hw/virtio/virtio-9p-pci.c           |   2 +-
 hw/virtio/virtio-balloon-pci.c      |   2 +-
 hw/virtio/virtio-balloon.c          |   2 +-
 hw/virtio/virtio-blk-pci.c          |   2 +-
 hw/virtio/virtio-crypto-pci.c       |   2 +-
 hw/virtio/virtio-crypto.c           |   2 +-
 hw/virtio/virtio-input-pci.c        |   2 +-
 hw/virtio/virtio-mmio.c             |   2 +-
 hw/virtio/virtio-net-pci.c          |   2 +-
 hw/virtio/virtio-pci.c              |   4 +-
 hw/virtio/virtio-pmem.c             |   2 +-
 hw/virtio/virtio-rng.c              |   2 +-
 hw/virtio/virtio-scsi-pci.c         |   2 +-
 hw/virtio/virtio-serial-pci.c       |   2 +-
 hw/virtio/virtio.c                  |   2 +-
 hw/watchdog/cmsdk-apb-watchdog.c    |   2 +-
 hw/xen/xen-bus.c                    |   2 +-
 hw/xen/xen-legacy-backend.c         |   4 +-
 hw/xen/xen_pt.c                     |   2 +-
 include/hw/qdev-core.h              |   8 +-
 include/hw/qdev-properties.h        |   3 +-
 include/qapi/qmp/qstring.h          |   1 +
 include/qom/object.h                | 127 ++++++++++--
 migration/migration.c               |   2 +-
 monitor/misc.c                      |  26 +++
 qapi/qom.json                       |   7 +-
 qdev-monitor.c                      |  15 +-
 qobject/qstring.c                   |  27 ++-
 qom/object.c                        | 305 +++++++++++++++++++++-------
 qom/object_interfaces.c             |  33 ++-
 qom/qom-qmp-cmds.c                  |  54 +----
 target/arm/cpu.c                    |  35 ++--
 target/i386/cpu.c                   |   4 +-
 target/microblaze/cpu.c             |   2 +-
 target/nios2/cpu.c                  |   2 +-
 target/ppc/translate_init.inc.c     |   8 +-
 target/riscv/cpu.c                  |   2 +-
 target/s390x/cpu.c                  |   2 +-
 target/sparc/cpu.c                  |   2 +-
 tests/test-qdev-global-props.c      |   2 +-
 401 files changed, 975 insertions(+), 731 deletions(-)

--=20
2.24.0


