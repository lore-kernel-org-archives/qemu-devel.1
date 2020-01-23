Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA59C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601C621734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YshZpqrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601C621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufTZ-0006bu-6O
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucs0-0005yW-HO
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrq-0004fy-6N
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:50:04 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:52982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrp-0004dc-B8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id p9so2646254wmc.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4jPXnQmwELiNj9kqW2n0AlsjIfg6aTN6AfZpHbt1gi4=;
 b=YshZpqrB9cFeHskOikdm5mnuxb4+P7ggPNok5YF7h5SbpZ/PhFYitjMARhFuFZ2TAq
 ejYDQBc18YXkeuSwfl73dFv11ajIVwR02XivDvTzkze95p6hDaNnTyHndDPxTw7dD30C
 pxdz7alm9aqOoj/8q0MXOtv20oyPRnWQlrWqau+aBIV6Q4YCZ996Mh73yzmRXGwNnTyy
 I3jAl2ETipEt7wdp+hGMZWcoiEscwRwyEQm3ynquoddqLUPAxm50SYzvsj3Wqy6jig0K
 S0zZ23U0cshvkvCBYTTMEpZniu3NfpkUMnbJoXJa6H6ywB50UfkBfRWTbXyiLSuA2rKs
 DtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4jPXnQmwELiNj9kqW2n0AlsjIfg6aTN6AfZpHbt1gi4=;
 b=BV8WwSBPqQZ52MJQSJG8wSIR1oBhrSH7uOmK+iDekenxgaOqtGIC7uMJ5yes2itJtD
 wNoqYxFexlhFJkk50F9lsREFSkW4jWQOXjVXLhGrib8GBUH4dEoG9JoKjECvDLudt0dL
 0wZxK5q6iZ6hNvRMGHVEf4NTX21UlegVsgqf/NpudnKAfqCvHeYKrEJb60L6pi0o4Msf
 QJ9YUkkLnHjqJKiJSSbfY+szEggqhk0ZflqHnGm/fl2bgmr43wROAbkNLpMUP7Ch6A6i
 U5JmI2EksPrW1GSALsNdh1amZHkgXAL+BeRvyQHdkXvdUZVyfGTYKWg4Ut3dqQLloYFU
 BnAg==
X-Gm-Message-State: APjAAAW24uwh8u0N6pZWCp+r80kQtf8zLF8ivTm+1vzCKnhStcToqxbQ
 8YBQD4cvvMc2g0ztCynQxYLhRn7s
X-Google-Smtp-Source: APXvYqxXpiDU6SPj5Y3wceoBrcRFq6PuomRcqsjf45Np3+B7vVjpEhwJew1qM6pM0lUm8Yl8GzlsJQ==
X-Received: by 2002:a05:600c:2318:: with SMTP id
 24mr4457561wmo.48.1579787389879; 
 Thu, 23 Jan 2020 05:49:49 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/59] qdev: set properties with device_class_set_props()
Date: Thu, 23 Jan 2020 14:48:52 +0100
Message-Id: <1579787342-27146-50-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following patch will need to handle properties registration during
class_init time. Let's use a device_class_set_props() setter.

spatch --macro-file scripts/cocci-macro-file.h  --sp-file
./scripts/coccinelle/qdev-set-props.cocci --keep-comments --in-place
--dir .

@@
typedef DeviceClass;
DeviceClass *d;
expression val;
@@
- d->props = val
+ device_class_set_props(d, val)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-20-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/9pfs/virtio-9p-device.c          |  2 +-
 hw/acpi/generic_event_device.c      |  2 +-
 hw/acpi/piix4.c                     |  2 +-
 hw/acpi/vmgenid.c                   |  2 +-
 hw/arm/armsse.c                     |  2 +-
 hw/arm/armv7m.c                     |  4 ++--
 hw/arm/aspeed_soc.c                 |  2 +-
 hw/arm/bcm2836.c                    |  2 +-
 hw/arm/integratorcp.c               |  2 +-
 hw/arm/msf2-soc.c                   |  2 +-
 hw/arm/musicpal.c                   |  2 +-
 hw/arm/nrf51_soc.c                  |  2 +-
 hw/arm/pxa2xx.c                     |  4 ++--
 hw/arm/pxa2xx_gpio.c                |  2 +-
 hw/arm/smmu-common.c                |  2 +-
 hw/arm/spitz.c                      |  2 +-
 hw/arm/stm32f205_soc.c              |  2 +-
 hw/arm/strongarm.c                  |  2 +-
 hw/arm/xlnx-versal.c                |  2 +-
 hw/arm/xlnx-zynqmp.c                |  2 +-
 hw/audio/ac97.c                     |  2 +-
 hw/audio/adlib.c                    |  2 +-
 hw/audio/cs4231.c                   |  2 +-
 hw/audio/cs4231a.c                  |  2 +-
 hw/audio/es1370.c                   |  2 +-
 hw/audio/gus.c                      |  2 +-
 hw/audio/hda-codec.c                |  2 +-
 hw/audio/intel-hda.c                |  4 ++--
 hw/audio/milkymist-ac97.c           |  2 +-
 hw/audio/pcspk.c                    |  2 +-
 hw/audio/pl041.c                    |  2 +-
 hw/audio/sb16.c                     |  2 +-
 hw/audio/wm8750.c                   |  2 +-
 hw/block/fdc.c                      |  8 ++++----
 hw/block/m25p80.c                   |  2 +-
 hw/block/nand.c                     |  2 +-
 hw/block/nvme.c                     |  2 +-
 hw/block/onenand.c                  |  2 +-
 hw/block/pflash_cfi01.c             |  2 +-
 hw/block/pflash_cfi02.c             |  2 +-
 hw/block/swim.c                     |  2 +-
 hw/block/vhost-user-blk.c           |  2 +-
 hw/block/virtio-blk.c               |  2 +-
 hw/block/xen-block.c                |  2 +-
 hw/char/bcm2835_aux.c               |  2 +-
 hw/char/cadence_uart.c              |  2 +-
 hw/char/cmsdk-apb-uart.c            |  2 +-
 hw/char/debugcon.c                  |  2 +-
 hw/char/digic-uart.c                |  2 +-
 hw/char/escc.c                      |  2 +-
 hw/char/etraxfs_ser.c               |  2 +-
 hw/char/exynos4210_uart.c           |  2 +-
 hw/char/grlib_apbuart.c             |  2 +-
 hw/char/imx_serial.c                |  2 +-
 hw/char/ipoctal232.c                |  2 +-
 hw/char/lm32_juart.c                |  2 +-
 hw/char/lm32_uart.c                 |  2 +-
 hw/char/mcf_uart.c                  |  2 +-
 hw/char/milkymist-uart.c            |  2 +-
 hw/char/nrf51_uart.c                |  2 +-
 hw/char/parallel.c                  |  2 +-
 hw/char/pl011.c                     |  2 +-
 hw/char/sclpconsole-lm.c            |  2 +-
 hw/char/sclpconsole.c               |  2 +-
 hw/char/serial-isa.c                |  2 +-
 hw/char/serial-pci-multi.c          |  4 ++--
 hw/char/serial-pci.c                |  2 +-
 hw/char/serial.c                    |  4 ++--
 hw/char/spapr_vty.c                 |  2 +-
 hw/char/stm32f2xx_usart.c           |  2 +-
 hw/char/terminal3270.c              |  2 +-
 hw/char/virtio-console.c            |  2 +-
 hw/char/virtio-serial-bus.c         |  4 ++--
 hw/char/xilinx_uartlite.c           |  2 +-
 hw/core/cpu.c                       |  2 +-
 hw/core/generic-loader.c            |  2 +-
 hw/core/or-irq.c                    |  2 +-
 hw/core/platform-bus.c              |  2 +-
 hw/core/qdev.c                      |  5 +++++
 hw/core/split-irq.c                 |  2 +-
 hw/cpu/a15mpcore.c                  |  2 +-
 hw/cpu/a9mpcore.c                   |  2 +-
 hw/cpu/arm11mpcore.c                |  2 +-
 hw/cpu/cluster.c                    |  2 +-
 hw/cpu/realview_mpcore.c            |  2 +-
 hw/display/ati.c                    |  2 +-
 hw/display/bcm2835_fb.c             |  2 +-
 hw/display/bochs-display.c          |  2 +-
 hw/display/cg3.c                    |  2 +-
 hw/display/cirrus_vga.c             |  2 +-
 hw/display/cirrus_vga_isa.c         |  2 +-
 hw/display/g364fb.c                 |  2 +-
 hw/display/i2c-ddc.c                |  2 +-
 hw/display/macfb.c                  |  4 ++--
 hw/display/milkymist-vgafb.c        |  2 +-
 hw/display/qxl.c                    |  2 +-
 hw/display/ramfb-standalone.c       |  2 +-
 hw/display/sm501.c                  |  4 ++--
 hw/display/tcx.c                    |  2 +-
 hw/display/vga-isa.c                |  2 +-
 hw/display/vga-pci.c                |  4 ++--
 hw/display/vhost-user-gpu.c         |  2 +-
 hw/display/virtio-gpu-pci.c         |  2 +-
 hw/display/virtio-gpu.c             |  2 +-
 hw/display/virtio-vga.c             |  2 +-
 hw/display/vmware_vga.c             |  2 +-
 hw/dma/i82374.c                     |  2 +-
 hw/dma/i8257.c                      |  2 +-
 hw/dma/pl080.c                      |  2 +-
 hw/dma/pl330.c                      |  2 +-
 hw/dma/pxa2xx_dma.c                 |  2 +-
 hw/dma/xilinx_axidma.c              |  2 +-
 hw/dma/xlnx-zdma.c                  |  2 +-
 hw/gpio/imx_gpio.c                  |  2 +-
 hw/gpio/omap_gpio.c                 |  4 ++--
 hw/i2c/aspeed_i2c.c                 |  2 +-
 hw/i2c/core.c                       |  2 +-
 hw/i2c/omap_i2c.c                   |  2 +-
 hw/i386/intel_iommu.c               |  2 +-
 hw/i386/kvm/clock.c                 |  2 +-
 hw/i386/kvm/i8254.c                 |  2 +-
 hw/i386/kvm/ioapic.c                |  2 +-
 hw/i386/vmmouse.c                   |  2 +-
 hw/i386/x86-iommu.c                 |  2 +-
 hw/i386/xen/xen_pvdevice.c          |  2 +-
 hw/ide/ahci.c                       |  2 +-
 hw/ide/cmd646.c                     |  2 +-
 hw/ide/isa.c                        |  2 +-
 hw/ide/macio.c                      |  2 +-
 hw/ide/mmio.c                       |  2 +-
 hw/ide/qdev.c                       |  8 ++++----
 hw/input/adb.c                      |  2 +-
 hw/input/milkymist-softusb.c        |  2 +-
 hw/input/virtio-input-hid.c         |  6 +++---
 hw/input/virtio-input-host.c        |  2 +-
 hw/input/virtio-input.c             |  2 +-
 hw/intc/apic_common.c               |  2 +-
 hw/intc/arm_gic_common.c            |  2 +-
 hw/intc/arm_gicv2m.c                |  2 +-
 hw/intc/arm_gicv3_common.c          |  2 +-
 hw/intc/arm_gicv3_its_kvm.c         |  2 +-
 hw/intc/armv7m_nvic.c               |  2 +-
 hw/intc/exynos4210_combiner.c       |  2 +-
 hw/intc/exynos4210_gic.c            |  4 ++--
 hw/intc/i8259_common.c              |  2 +-
 hw/intc/ioapic.c                    |  2 +-
 hw/intc/mips_gic.c                  |  2 +-
 hw/intc/omap_intc.c                 |  4 ++--
 hw/intc/ompic.c                     |  2 +-
 hw/intc/openpic.c                   |  2 +-
 hw/intc/openpic_kvm.c               |  2 +-
 hw/intc/pnv_xive.c                  |  2 +-
 hw/intc/s390_flic.c                 |  2 +-
 hw/intc/spapr_xive.c                |  2 +-
 hw/intc/xics.c                      |  4 ++--
 hw/intc/xilinx_intc.c               |  2 +-
 hw/intc/xive.c                      |  6 +++---
 hw/intc/xlnx-pmu-iomod-intc.c       |  2 +-
 hw/ipack/ipack.c                    |  2 +-
 hw/ipmi/ipmi.c                      |  2 +-
 hw/ipmi/ipmi_bmc_extern.c           |  2 +-
 hw/ipmi/ipmi_bmc_sim.c              |  2 +-
 hw/ipmi/isa_ipmi_bt.c               |  2 +-
 hw/ipmi/isa_ipmi_kcs.c              |  2 +-
 hw/isa/lpc_ich9.c                   |  2 +-
 hw/isa/pc87312.c                    |  2 +-
 hw/isa/vt82c686.c                   |  2 +-
 hw/mem/nvdimm.c                     |  2 +-
 hw/mem/pc-dimm.c                    |  2 +-
 hw/mips/cps.c                       |  2 +-
 hw/misc/a9scu.c                     |  2 +-
 hw/misc/applesmc.c                  |  2 +-
 hw/misc/arm11scu.c                  |  2 +-
 hw/misc/arm_l2x0.c                  |  2 +-
 hw/misc/arm_sysctl.c                |  2 +-
 hw/misc/armsse-cpuid.c              |  2 +-
 hw/misc/aspeed_scu.c                |  2 +-
 hw/misc/aspeed_sdmc.c               |  2 +-
 hw/misc/bcm2835_property.c          |  2 +-
 hw/misc/debugexit.c                 |  2 +-
 hw/misc/eccmemctl.c                 |  2 +-
 hw/misc/iotkit-sysctl.c             |  2 +-
 hw/misc/iotkit-sysinfo.c            |  2 +-
 hw/misc/ivshmem.c                   |  4 ++--
 hw/misc/mac_via.c                   |  2 +-
 hw/misc/macio/cuda.c                |  2 +-
 hw/misc/macio/macio.c               |  4 ++--
 hw/misc/macio/pmu.c                 |  2 +-
 hw/misc/mips_cmgcr.c                |  2 +-
 hw/misc/mips_cpc.c                  |  2 +-
 hw/misc/mips_itu.c                  |  2 +-
 hw/misc/mos6522.c                   |  2 +-
 hw/misc/mps2-fpgaio.c               |  2 +-
 hw/misc/mps2-scc.c                  |  2 +-
 hw/misc/msf2-sysreg.c               |  2 +-
 hw/misc/nrf51_rng.c                 |  2 +-
 hw/misc/pci-testdev.c               |  2 +-
 hw/misc/pvpanic.c                   |  2 +-
 hw/misc/tz-mpc.c                    |  2 +-
 hw/misc/tz-msc.c                    |  2 +-
 hw/misc/tz-ppc.c                    |  2 +-
 hw/misc/unimp.c                     |  2 +-
 hw/net/allwinner_emac.c             |  2 +-
 hw/net/cadence_gem.c                |  2 +-
 hw/net/dp8393x.c                    |  2 +-
 hw/net/e1000.c                      |  2 +-
 hw/net/e1000e.c                     |  2 +-
 hw/net/eepro100.c                   |  2 +-
 hw/net/etraxfs_eth.c                |  2 +-
 hw/net/fsl_etsec/etsec.c            |  2 +-
 hw/net/ftgmac100.c                  |  4 ++--
 hw/net/imx_fec.c                    |  2 +-
 hw/net/lan9118.c                    |  2 +-
 hw/net/lance.c                      |  2 +-
 hw/net/mcf_fec.c                    |  2 +-
 hw/net/milkymist-minimac2.c         |  2 +-
 hw/net/mipsnet.c                    |  2 +-
 hw/net/ne2000-isa.c                 |  2 +-
 hw/net/ne2000-pci.c                 |  2 +-
 hw/net/opencores_eth.c              |  2 +-
 hw/net/pcnet-pci.c                  |  2 +-
 hw/net/rocker/rocker.c              |  2 +-
 hw/net/rtl8139.c                    |  2 +-
 hw/net/smc91c111.c                  |  2 +-
 hw/net/spapr_llan.c                 |  2 +-
 hw/net/stellaris_enet.c             |  2 +-
 hw/net/sungem.c                     |  2 +-
 hw/net/sunhme.c                     |  2 +-
 hw/net/tulip.c                      |  2 +-
 hw/net/virtio-net.c                 |  2 +-
 hw/net/vmxnet3.c                    |  2 +-
 hw/net/xgmac.c                      |  2 +-
 hw/net/xilinx_axienet.c             |  2 +-
 hw/net/xilinx_ethlite.c             |  2 +-
 hw/nvram/ds1225y.c                  |  2 +-
 hw/nvram/eeprom_at24c.c             |  2 +-
 hw/nvram/fw_cfg.c                   |  4 ++--
 hw/nvram/mac_nvram.c                |  2 +-
 hw/nvram/nrf51_nvm.c                |  2 +-
 hw/nvram/spapr_nvram.c              |  2 +-
 hw/pci-bridge/gen_pcie_root_port.c  |  2 +-
 hw/pci-bridge/pci_bridge_dev.c      |  2 +-
 hw/pci-bridge/pci_expander_bridge.c |  4 ++--
 hw/pci-bridge/pcie_pci_bridge.c     |  2 +-
 hw/pci-bridge/pcie_root_port.c      |  2 +-
 hw/pci-bridge/xio3130_downstream.c  |  2 +-
 hw/pci-host/grackle.c               |  2 +-
 hw/pci-host/i440fx.c                |  2 +-
 hw/pci-host/ppce500.c               |  2 +-
 hw/pci-host/prep.c                  |  2 +-
 hw/pci-host/q35.c                   |  4 ++--
 hw/pci-host/sabre.c                 |  2 +-
 hw/pci-host/uninorth.c              |  2 +-
 hw/pci-host/versatile.c             |  2 +-
 hw/pci-host/xilinx-pcie.c           |  2 +-
 hw/pci/pci.c                        |  2 +-
 hw/pci/pcie_port.c                  |  4 ++--
 hw/ppc/pnv.c                        |  2 +-
 hw/ppc/pnv_core.c                   |  4 ++--
 hw/ppc/pnv_homer.c                  |  2 +-
 hw/ppc/pnv_lpc.c                    |  2 +-
 hw/ppc/pnv_occ.c                    |  2 +-
 hw/ppc/pnv_pnor.c                   |  2 +-
 hw/ppc/pnv_psi.c                    |  2 +-
 hw/ppc/ppc440_uc.c                  |  2 +-
 hw/ppc/prep_systemio.c              |  2 +-
 hw/ppc/rs6000_mc.c                  |  2 +-
 hw/ppc/spapr_cpu_core.c             |  2 +-
 hw/ppc/spapr_pci.c                  |  2 +-
 hw/ppc/spapr_rng.c                  |  2 +-
 hw/ppc/spapr_tpm_proxy.c            |  2 +-
 hw/rdma/vmw/pvrdma_main.c           |  2 +-
 hw/riscv/riscv_hart.c               |  2 +-
 hw/riscv/sifive_clint.c             |  2 +-
 hw/riscv/sifive_plic.c              |  2 +-
 hw/riscv/sifive_u_otp.c             |  2 +-
 hw/rtc/m48t59-isa.c                 |  2 +-
 hw/rtc/m48t59.c                     |  2 +-
 hw/rtc/mc146818rtc.c                |  2 +-
 hw/rtc/pl031.c                      |  2 +-
 hw/s390x/3270-ccw.c                 |  2 +-
 hw/s390x/ccw-device.c               |  2 +-
 hw/s390x/css-bridge.c               |  2 +-
 hw/s390x/ipl.c                      |  2 +-
 hw/s390x/s390-pci-bus.c             |  2 +-
 hw/s390x/vhost-vsock-ccw.c          |  2 +-
 hw/s390x/virtio-ccw-9p.c            |  2 +-
 hw/s390x/virtio-ccw-balloon.c       |  2 +-
 hw/s390x/virtio-ccw-blk.c           |  2 +-
 hw/s390x/virtio-ccw-crypto.c        |  2 +-
 hw/s390x/virtio-ccw-gpu.c           |  2 +-
 hw/s390x/virtio-ccw-input.c         |  2 +-
 hw/s390x/virtio-ccw-net.c           |  2 +-
 hw/s390x/virtio-ccw-rng.c           |  2 +-
 hw/s390x/virtio-ccw-scsi.c          |  4 ++--
 hw/s390x/virtio-ccw-serial.c        |  2 +-
 hw/scsi/megasas.c                   |  2 +-
 hw/scsi/mptsas.c                    |  2 +-
 hw/scsi/scsi-bus.c                  |  2 +-
 hw/scsi/scsi-disk.c                 |  8 ++++----
 hw/scsi/scsi-generic.c              |  2 +-
 hw/scsi/spapr_vscsi.c               |  2 +-
 hw/scsi/vhost-scsi.c                |  2 +-
 hw/scsi/vhost-user-scsi.c           |  2 +-
 hw/scsi/virtio-scsi.c               |  2 +-
 hw/scsi/vmw_pvscsi.c                |  2 +-
 hw/sd/sd.c                          |  2 +-
 hw/sd/sdhci-pci.c                   |  2 +-
 hw/sd/sdhci.c                       |  2 +-
 hw/sparc/sun4m.c                    |  4 ++--
 hw/sparc/sun4m_iommu.c              |  2 +-
 hw/sparc64/sun4u.c                  |  6 +++---
 hw/ssi/aspeed_smc.c                 |  2 +-
 hw/ssi/xilinx_spi.c                 |  2 +-
 hw/ssi/xilinx_spips.c               |  4 ++--
 hw/timer/a9gtimer.c                 |  2 +-
 hw/timer/allwinner-a10-pit.c        |  2 +-
 hw/timer/altera_timer.c             |  2 +-
 hw/timer/arm_mptimer.c              |  2 +-
 hw/timer/arm_timer.c                |  2 +-
 hw/timer/aspeed_timer.c             |  2 +-
 hw/timer/cmsdk-apb-dualtimer.c      |  2 +-
 hw/timer/cmsdk-apb-timer.c          |  2 +-
 hw/timer/grlib_gptimer.c            |  2 +-
 hw/timer/hpet.c                     |  2 +-
 hw/timer/i8254.c                    |  2 +-
 hw/timer/lm32_timer.c               |  2 +-
 hw/timer/milkymist-sysctl.c         |  2 +-
 hw/timer/mss-timer.c                |  2 +-
 hw/timer/pxa2xx_timer.c             |  4 ++--
 hw/timer/slavio_timer.c             |  2 +-
 hw/timer/stm32f2xx_timer.c          |  2 +-
 hw/timer/xilinx_timer.c             |  2 +-
 hw/tpm/tpm_crb.c                    |  2 +-
 hw/tpm/tpm_tis.c                    |  2 +-
 hw/usb/bus.c                        |  2 +-
 hw/usb/ccid-card-emulated.c         |  2 +-
 hw/usb/ccid-card-passthru.c         |  2 +-
 hw/usb/dev-audio.c                  |  2 +-
 hw/usb/dev-hid.c                    |  6 +++---
 hw/usb/dev-hub.c                    |  2 +-
 hw/usb/dev-mtp.c                    |  2 +-
 hw/usb/dev-network.c                |  2 +-
 hw/usb/dev-serial.c                 |  4 ++--
 hw/usb/dev-smartcard-reader.c       |  4 ++--
 hw/usb/dev-storage.c                |  2 +-
 hw/usb/dev-uas.c                    |  2 +-
 hw/usb/hcd-ehci-pci.c               |  2 +-
 hw/usb/hcd-ehci-sysbus.c            |  2 +-
 hw/usb/hcd-ohci-pci.c               |  2 +-
 hw/usb/hcd-ohci.c                   |  2 +-
 hw/usb/hcd-uhci.c                   |  4 ++--
 hw/usb/hcd-xhci-nec.c               |  2 +-
 hw/usb/hcd-xhci.c                   |  2 +-
 hw/usb/host-libusb.c                |  2 +-
 hw/usb/redirect.c                   |  2 +-
 hw/vfio/ap.c                        |  2 +-
 hw/vfio/ccw.c                       |  2 +-
 hw/vfio/pci.c                       |  4 ++--
 hw/vfio/platform.c                  |  2 +-
 hw/virtio/vhost-scsi-pci.c          |  2 +-
 hw/virtio/vhost-user-blk-pci.c      |  2 +-
 hw/virtio/vhost-user-fs-pci.c       |  2 +-
 hw/virtio/vhost-user-fs.c           |  2 +-
 hw/virtio/vhost-user-scsi-pci.c     |  2 +-
 hw/virtio/vhost-vsock-pci.c         |  2 +-
 hw/virtio/vhost-vsock.c             |  2 +-
 hw/virtio/virtio-9p-pci.c           |  2 +-
 hw/virtio/virtio-balloon-pci.c      |  2 +-
 hw/virtio/virtio-balloon.c          |  2 +-
 hw/virtio/virtio-blk-pci.c          |  2 +-
 hw/virtio/virtio-crypto-pci.c       |  2 +-
 hw/virtio/virtio-crypto.c           |  2 +-
 hw/virtio/virtio-input-pci.c        |  2 +-
 hw/virtio/virtio-mmio.c             |  2 +-
 hw/virtio/virtio-net-pci.c          |  2 +-
 hw/virtio/virtio-pci.c              |  4 ++--
 hw/virtio/virtio-pmem.c             |  2 +-
 hw/virtio/virtio-rng.c              |  2 +-
 hw/virtio/virtio-scsi-pci.c         |  2 +-
 hw/virtio/virtio-serial-pci.c       |  2 +-
 hw/virtio/virtio.c                  |  2 +-
 hw/watchdog/cmsdk-apb-watchdog.c    |  2 +-
 hw/watchdog/wdt_aspeed.c            |  2 +-
 hw/xen/xen-bus.c                    |  2 +-
 hw/xen/xen-legacy-backend.c         |  4 ++--
 hw/xen/xen_pt.c                     |  2 +-
 include/hw/qdev-core.h              |  2 ++
 migration/migration.c               |  2 +-
 target/i386/cpu.c                   |  4 ++--
 target/microblaze/cpu.c             |  2 +-
 target/nios2/cpu.c                  |  2 +-
 target/ppc/translate_init.inc.c     | 10 +++++-----
 target/riscv/cpu.c                  |  2 +-
 target/s390x/cpu.c                  |  2 +-
 target/sparc/cpu.c                  |  2 +-
 tests/test-qdev-global-props.c      |  2 +-
 397 files changed, 455 insertions(+), 448 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 991e175..963a58c 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -245,7 +245,7 @@ static void virtio_9p_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
-    dc->props = virtio_9p_properties;
+    device_class_set_props(dc, virtio_9p_properties);
     dc->vmsd = &vmstate_virtio_9p;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = virtio_9p_device_realize;
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 9cee90c..375272e 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -282,7 +282,7 @@ static void acpi_ged_class_init(ObjectClass *class, void *data)
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
 
     dc->desc = "ACPI Generic Event Device";
-    dc->props = acpi_ged_properties;
+    device_class_set_props(dc, acpi_ged_properties);
     dc->vmsd = &vmstate_acpi_ged;
 
     hc->plug = acpi_ged_device_plug_cb;
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 93aec2d..6d621c3 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -653,7 +653,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
     dc->reset = piix4_pm_reset;
     dc->desc = "PM";
     dc->vmsd = &vmstate_acpi;
-    dc->props = piix4_pm_properties;
+    device_class_set_props(dc, piix4_pm_properties);
     /*
      * Reason: part of PIIX4 southbridge, needs to be wired up,
      * e.g. by mips_malta_init()
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 6e11b0f..2df7623 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -226,7 +226,7 @@ static void vmgenid_device_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_vmgenid;
     dc->realize = vmgenid_realize;
-    dc->props = vmgenid_device_properties;
+    device_class_set_props(dc, vmgenid_device_properties);
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index e5263aa..174ca7e 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1283,7 +1283,7 @@ static void armsse_class_init(ObjectClass *klass, void *data)
 
     dc->realize = armsse_realize;
     dc->vmsd = &armsse_vmstate;
-    dc->props = info->props;
+    device_class_set_props(dc, info->props);
     dc->reset = armsse_reset;
     iic->check = armsse_idau_check;
     asc->info = info;
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7a3c48f..5d4a581 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -288,7 +288,7 @@ static void armv7m_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = armv7m_realize;
-    dc->props = armv7m_properties;
+    device_class_set_props(dc, armv7m_properties);
 }
 
 static const TypeInfo armv7m_info = {
@@ -367,7 +367,7 @@ static void bitband_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = bitband_realize;
-    dc->props = bitband_properties;
+    device_class_set_props(dc, bitband_properties);
 }
 
 static const TypeInfo bitband_info = {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index a6237e5..99892cb 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -449,7 +449,7 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
     dc->realize = aspeed_soc_realize;
     /* Reason: Uses serial_hds and nd_table in realize() directly */
     dc->user_creatable = false;
-    dc->props = aspeed_soc_properties;
+    device_class_set_props(dc, aspeed_soc_properties);
 }
 
 static const TypeInfo aspeed_soc_type_info = {
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 221ff06..38e2941 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -180,7 +180,7 @@ static void bcm283x_class_init(ObjectClass *oc, void *data)
 
     bc->info = data;
     dc->realize = bcm2836_realize;
-    dc->props = bcm2836_props;
+    device_class_set_props(dc, bcm2836_props);
     /* Reason: Must be wired up in code (see raspi_init() function) */
     dc->user_creatable = false;
 }
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 5249708..0cd94d9 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -673,7 +673,7 @@ static void core_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = core_properties;
+    device_class_set_props(dc, core_properties);
     dc->realize = integratorcm_realize;
     dc->vmsd = &vmstate_integratorcm;
 }
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 008fd93..8f84692 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -229,7 +229,7 @@ static void m2sxxx_soc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = m2sxxx_soc_realize;
-    dc->props = m2sxxx_soc_properties;
+    device_class_set_props(dc, m2sxxx_soc_properties);
 }
 
 static const TypeInfo m2sxxx_soc_info = {
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index f68a399..dc551bb 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -435,7 +435,7 @@ static void mv88w8618_eth_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &mv88w8618_eth_vmsd;
-    dc->props = mv88w8618_eth_properties;
+    device_class_set_props(dc, mv88w8618_eth_properties);
     dc->realize = mv88w8618_eth_realize;
 }
 
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 7402916..4817a76 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -224,7 +224,7 @@ static void nrf51_soc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = nrf51_soc_realize;
-    dc->props = nrf51_soc_properties;
+    device_class_set_props(dc, nrf51_soc_properties);
 }
 
 static const TypeInfo nrf51_soc_info = {
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 950ff42..b33f8f1 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1531,7 +1531,7 @@ static void pxa2xx_i2c_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "PXA2xx I2C Bus Controller";
     dc->vmsd = &vmstate_pxa2xx_i2c;
-    dc->props = pxa2xx_i2c_properties;
+    device_class_set_props(dc, pxa2xx_i2c_properties);
 }
 
 static const TypeInfo pxa2xx_i2c_info = {
@@ -2015,7 +2015,7 @@ static void pxa2xx_fir_class_init(ObjectClass *klass, void *data)
 
     dc->realize = pxa2xx_fir_realize;
     dc->vmsd = &pxa2xx_fir_vmsd;
-    dc->props = pxa2xx_fir_properties;
+    device_class_set_props(dc, pxa2xx_fir_properties);
     dc->reset = pxa2xx_fir_reset;
 }
 
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index 86a0e86..f8df3cc 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -347,7 +347,7 @@ static void pxa2xx_gpio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "PXA2xx GPIO controller";
-    dc->props = pxa2xx_gpio_properties;
+    device_class_set_props(dc, pxa2xx_gpio_properties);
     dc->vmsd = &vmstate_pxa2xx_gpio_regs;
     dc->realize = pxa2xx_gpio_realize;
 }
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 245817d..23eb117 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -461,7 +461,7 @@ static void smmu_base_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     SMMUBaseClass *sbc = ARM_SMMU_CLASS(klass);
 
-    dc->props = smmu_dev_properties;
+    device_class_set_props(dc, smmu_dev_properties);
     device_class_set_parent_realize(dc, smmu_base_realize,
                                     &sbc->parent_realize);
     dc->reset = smmu_base_reset;
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 25bd0f5..e001088 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -1083,7 +1083,7 @@ static void sl_nand_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_sl_nand_info;
-    dc->props = sl_nand_properties;
+    device_class_set_props(dc, sl_nand_properties);
     dc->realize = sl_nand_realize;
     /* Reason: init() method uses drive_get() */
     dc->user_creatable = false;
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index f5a5c2d..627fd44 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -207,7 +207,7 @@ static void stm32f205_soc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = stm32f205_soc_realize;
-    dc->props = stm32f205_soc_properties;
+    device_class_set_props(dc, stm32f205_soc_properties);
 }
 
 static const TypeInfo stm32f205_soc_info = {
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index c6776e8..cd8a99a 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1327,7 +1327,7 @@ static void strongarm_uart_class_init(ObjectClass *klass, void *data)
     dc->desc = "StrongARM UART controller";
     dc->reset = strongarm_uart_reset;
     dc->vmsd = &vmstate_strongarm_uart_regs;
-    dc->props = strongarm_uart_properties;
+    device_class_set_props(dc, strongarm_uart_properties);
     dc->realize = strongarm_uart_realize;
 }
 
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 8b3d8d8..1cf3daa 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -305,7 +305,7 @@ static void versal_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = versal_realize;
-    dc->props = versal_properties;
+    device_class_set_props(dc, versal_properties);
     /* No VMSD since we haven't got any top-level SoC state to save.  */
 }
 
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index fb03c60..cab0160 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -657,7 +657,7 @@ static void xlnx_zynqmp_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->props = xlnx_zynqmp_props;
+    device_class_set_props(dc, xlnx_zynqmp_props);
     dc->realize = xlnx_zynqmp_realize;
     /* Reason: Uses serial_hds in realize function, thus can't be used twice */
     dc->user_creatable = false;
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 78cda88..1ec87fe 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1420,7 +1420,7 @@ static void ac97_class_init (ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc = "Intel 82801AA AC97 Audio";
     dc->vmsd = &vmstate_ac97;
-    dc->props = ac97_properties;
+    device_class_set_props(dc, ac97_properties);
     dc->reset = ac97_on_reset;
 }
 
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index cb4178d..d6c1fb0 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -312,7 +312,7 @@ static void adlib_class_initfn (ObjectClass *klass, void *data)
     dc->realize = adlib_realizefn;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc = ADLIB_DESC;
-    dc->props = adlib_properties;
+    device_class_set_props(dc, adlib_properties);
 }
 
 static const TypeInfo adlib_info = {
diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index b5d3e89..11a6328 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -168,7 +168,7 @@ static void cs4231_class_init(ObjectClass *klass, void *data)
 
     dc->reset = cs_reset;
     dc->vmsd = &vmstate_cs4231;
-    dc->props = cs4231_properties;
+    device_class_set_props(dc, cs4231_properties);
 }
 
 static const TypeInfo cs4231_info = {
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index c7b8067..ffdbb58 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -706,7 +706,7 @@ static void cs4231a_class_initfn (ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc = "Crystal Semiconductor CS4231A";
     dc->vmsd = &vmstate_cs4231a;
-    dc->props = cs4231a_properties;
+    device_class_set_props(dc, cs4231a_properties);
 }
 
 static const TypeInfo cs4231a_info = {
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index f9e9f2a..89c4dab 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -908,7 +908,7 @@ static void es1370_class_init (ObjectClass *klass, void *data)
     dc->desc = "ENSONIQ AudioPCI ES1370";
     dc->vmsd = &vmstate_es1370;
     dc->reset = es1370_on_reset;
-    dc->props = es1370_properties;
+    device_class_set_props(dc, es1370_properties);
 }
 
 static const TypeInfo es1370_info = {
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 2b6b7c4..eb4a803 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -315,7 +315,7 @@ static void gus_class_initfn (ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc = "Gravis Ultrasound GF1";
     dc->vmsd = &vmstate_gus;
-    dc->props = gus_properties;
+    device_class_set_props(dc, gus_properties);
 }
 
 static const TypeInfo gus_info = {
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index e711a99..cbd92b7 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -892,7 +892,7 @@ static void hda_audio_base_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->reset = hda_audio_reset;
     dc->vmsd = &vmstate_hda_audio;
-    dc->props = hda_audio_properties;
+    device_class_set_props(dc, hda_audio_properties);
 }
 
 static const TypeInfo hda_audio_info = {
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 6ecd383..e96a707 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1233,7 +1233,7 @@ static void intel_hda_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_MULTIMEDIA_HD_AUDIO;
     dc->reset = intel_hda_reset;
     dc->vmsd = &vmstate_intel_hda;
-    dc->props = intel_hda_properties;
+    device_class_set_props(dc, intel_hda_properties);
 }
 
 static void intel_hda_class_init_ich6(ObjectClass *klass, void *data)
@@ -1289,7 +1289,7 @@ static void hda_codec_device_class_init(ObjectClass *klass, void *data)
     k->unrealize = hda_codec_dev_unrealize;
     set_bit(DEVICE_CATEGORY_SOUND, k->categories);
     k->bus_type = TYPE_HDA_BUS;
-    k->props = hda_props;
+    device_class_set_props(k, hda_props);
 }
 
 static const TypeInfo hda_codec_device_type_info = {
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index 6d409ef..0fa38ad 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -342,7 +342,7 @@ static void milkymist_ac97_class_init(ObjectClass *klass, void *data)
     dc->realize = milkymist_ac97_realize;
     dc->reset = milkymist_ac97_reset;
     dc->vmsd = &vmstate_milkymist_ac97;
-    dc->props = milkymist_ac97_properties;
+    device_class_set_props(dc, milkymist_ac97_properties);
 }
 
 static const TypeInfo milkymist_ac97_info = {
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index d773eb8..29dc00b 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -222,7 +222,7 @@ static void pcspk_class_initfn(ObjectClass *klass, void *data)
     dc->realize = pcspk_realizefn;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->vmsd = &vmstate_spk;
-    dc->props = pcspk_properties;
+    device_class_set_props(dc, pcspk_properties);
     /* Reason: realize sets global pcspk_state */
     /* Reason: pit object link */
     dc->user_creatable = false;
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index c30417d..c3d3eab 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -640,7 +640,7 @@ static void pl041_device_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->reset = pl041_device_reset;
     dc->vmsd = &vmstate_pl041;
-    dc->props = pl041_device_properties;
+    device_class_set_props(dc, pl041_device_properties);
 }
 
 static const TypeInfo pl041_device_info = {
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index a354f94..df6f755 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1439,7 +1439,7 @@ static void sb16_class_initfn (ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc = "Creative Sound Blaster 16";
     dc->vmsd = &vmstate_sb16;
-    dc->props = sb16_properties;
+    device_class_set_props(dc, sb16_properties);
 }
 
 static const TypeInfo sb16_info = {
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 601ed04..92b2902 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -717,7 +717,7 @@ static void wm8750_class_init(ObjectClass *klass, void *data)
     sc->recv = wm8750_rx;
     sc->send = wm8750_tx;
     dc->vmsd = &vmstate_wm8750;
-    dc->props = wm8750_properties;
+    device_class_set_props(dc, wm8750_properties);
 }
 
 static const TypeInfo wm8750_info = {
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index ac5d31e..22e954e 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -606,7 +606,7 @@ static void floppy_drive_class_init(ObjectClass *klass, void *data)
     k->realize = floppy_drive_realize;
     set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
     k->bus_type = TYPE_FLOPPY_BUS;
-    k->props = floppy_drive_properties;
+    device_class_set_props(k, floppy_drive_properties);
     k->desc = "virtual floppy drive";
 }
 
@@ -2827,7 +2827,7 @@ static void isabus_fdc_class_init(ObjectClass *klass, void *data)
     dc->fw_name = "fdc";
     dc->reset = fdctrl_external_reset_isa;
     dc->vmsd = &vmstate_isa_fdc;
-    dc->props = isa_fdc_properties;
+    device_class_set_props(dc, isa_fdc_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
@@ -2880,7 +2880,7 @@ static void sysbus_fdc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = sysbus_fdc_properties;
+    device_class_set_props(dc, sysbus_fdc_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
@@ -2906,7 +2906,7 @@ static void sun4m_fdc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = sun4m_fdc_properties;
+    device_class_set_props(dc, sun4m_fdc_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 11ff5b9..61f2fb8 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1391,7 +1391,7 @@ static void m25p80_class_init(ObjectClass *klass, void *data)
     k->set_cs = m25p80_cs;
     k->cs_polarity = SSI_CS_LOW;
     dc->vmsd = &vmstate_m25p80;
-    dc->props = m25p80_properties;
+    device_class_set_props(dc, m25p80_properties);
     dc->reset = m25p80_reset;
     mc->pi = data;
 }
diff --git a/hw/block/nand.c b/hw/block/nand.c
index e396004..bba8968 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -448,7 +448,7 @@ static void nand_class_init(ObjectClass *klass, void *data)
     dc->realize = nand_realize;
     dc->reset = nand_reset;
     dc->vmsd = &vmstate_nand;
-    dc->props = nand_properties;
+    device_class_set_props(dc, nand_properties);
 }
 
 static const TypeInfo nand_info = {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 12d8254..d28335c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1475,7 +1475,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->desc = "Non-Volatile Memory Express";
-    dc->props = nvme_props;
+    device_class_set_props(dc, nvme_props);
     dc->vmsd = &nvme_vmstate;
 }
 
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 9c233c1..898ac56 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -845,7 +845,7 @@ static void onenand_class_init(ObjectClass *klass, void *data)
 
     dc->realize = onenand_realize;
     dc->reset = onenand_system_reset;
-    dc->props = onenand_properties;
+    device_class_set_props(dc, onenand_properties);
 }
 
 static const TypeInfo onenand_info = {
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 54e6ebd..24f3bce 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -930,7 +930,7 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
 
     dc->reset = pflash_cfi01_system_reset;
     dc->realize = pflash_cfi01_realize;
-    dc->props = pflash_cfi01_properties;
+    device_class_set_props(dc, pflash_cfi01_properties);
     dc->vmsd = &vmstate_pflash;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c7d92c3..7c4744c 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -963,7 +963,7 @@ static void pflash_cfi02_class_init(ObjectClass *klass, void *data)
 
     dc->realize = pflash_cfi02_realize;
     dc->unrealize = pflash_cfi02_unrealize;
-    dc->props = pflash_cfi02_properties;
+    device_class_set_props(dc, pflash_cfi02_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
diff --git a/hw/block/swim.c b/hw/block/swim.c
index c6d117e..8f12478 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -239,7 +239,7 @@ static void swim_drive_class_init(ObjectClass *klass, void *data)
     k->realize = swim_drive_realize;
     set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
     k->bus_type = TYPE_SWIM_BUS;
-    k->props = swim_drive_properties;
+    device_class_set_props(k, swim_drive_properties);
     k->desc = "virtual SWIM drive";
 }
 
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 98b383f..d8c459c 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -511,7 +511,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
-    dc->props = vhost_user_blk_properties;
+    device_class_set_props(dc, vhost_user_blk_properties);
     dc->vmsd = &vmstate_vhost_user_blk;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vhost_user_blk_device_realize;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9bee514..09f46ed 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1294,7 +1294,7 @@ static void virtio_blk_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
-    dc->props = virtio_blk_properties;
+    device_class_set_props(dc, virtio_blk_properties);
     dc->vmsd = &vmstate_virtio_blk;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = virtio_blk_device_realize;
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 879fc31..686bbc3 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -554,7 +554,7 @@ static void xen_block_class_init(ObjectClass *class, void *data)
     xendev_class->frontend_changed = xen_block_frontend_changed;
     xendev_class->unrealize = xen_block_unrealize;
 
-    dev_class->props = xen_block_props;
+    device_class_set_props(dev_class, xen_block_props);
 }
 
 static const TypeInfo xen_block_type_info = {
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index a6fc1bf..ee3dd40 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -299,7 +299,7 @@ static void bcm2835_aux_class_init(ObjectClass *oc, void *data)
     dc->realize = bcm2835_aux_realize;
     dc->vmsd = &vmstate_bcm2835_aux;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-    dc->props = bcm2835_aux_props;
+    device_class_set_props(dc, bcm2835_aux_props);
 }
 
 static const TypeInfo bcm2835_aux_info = {
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 51791bd..22e4797 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -550,7 +550,7 @@ static void cadence_uart_class_init(ObjectClass *klass, void *data)
     dc->realize = cadence_uart_realize;
     dc->vmsd = &vmstate_cadence_uart;
     dc->reset = cadence_uart_reset;
-    dc->props = cadence_uart_properties;
+    device_class_set_props(dc, cadence_uart_properties);
   }
 
 static const TypeInfo cadence_uart_info = {
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 9e1aa43..626b68f 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -389,7 +389,7 @@ static void cmsdk_apb_uart_class_init(ObjectClass *klass, void *data)
     dc->realize = cmsdk_apb_uart_realize;
     dc->vmsd = &cmsdk_apb_uart_vmstate;
     dc->reset = cmsdk_apb_uart_reset;
-    dc->props = cmsdk_apb_uart_properties;
+    device_class_set_props(dc, cmsdk_apb_uart_properties);
 }
 
 static const TypeInfo cmsdk_apb_uart_info = {
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 5c592e0..c8d938e 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -125,7 +125,7 @@ static void debugcon_isa_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = debugcon_isa_realizefn;
-    dc->props = debugcon_isa_properties;
+    device_class_set_props(dc, debugcon_isa_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 033eba0..e130cb4 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -183,7 +183,7 @@ static void digic_uart_class_init(ObjectClass *klass, void *data)
     dc->realize = digic_uart_realize;
     dc->reset = digic_uart_reset;
     dc->vmsd = &vmstate_digic_uart;
-    dc->props = digic_uart_properties;
+    device_class_set_props(dc, digic_uart_properties);
 }
 
 static const TypeInfo digic_uart_info = {
diff --git a/hw/char/escc.c b/hw/char/escc.c
index c40c1d2..7d16ee8 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -865,7 +865,7 @@ static void escc_class_init(ObjectClass *klass, void *data)
     dc->reset = escc_reset;
     dc->realize = escc_realize;
     dc->vmsd = &vmstate_escc;
-    dc->props = escc_properties;
+    device_class_set_props(dc, escc_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index f34f767..947bdb6 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -244,7 +244,7 @@ static void etraxfs_ser_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = etraxfs_ser_reset;
-    dc->props = etraxfs_ser_properties;
+    device_class_set_props(dc, etraxfs_ser_properties);
     dc->realize = etraxfs_ser_realize;
 }
 
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 7e5c5ce..238aa0a 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -645,7 +645,7 @@ static void exynos4210_uart_class_init(ObjectClass *klass, void *data)
 
     dc->realize = exynos4210_uart_realize;
     dc->reset = exynos4210_uart_reset;
-    dc->props = exynos4210_uart_properties;
+    device_class_set_props(dc, exynos4210_uart_properties);
     dc->vmsd = &vmstate_exynos4210_uart;
 }
 
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 8e59c3b..16d0fea 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -285,7 +285,7 @@ static void grlib_apbuart_class_init(ObjectClass *klass, void *data)
 
     dc->realize = grlib_apbuart_realize;
     dc->reset = grlib_apbuart_reset;
-    dc->props = grlib_apbuart_properties;
+    device_class_set_props(dc, grlib_apbuart_properties);
 }
 
 static const TypeInfo grlib_apbuart_info = {
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index d09c210..731b8fc 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -372,7 +372,7 @@ static void imx_serial_class_init(ObjectClass *klass, void *data)
     dc->reset = imx_serial_reset_at_boot;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     dc->desc = "i.MX series UART";
-    dc->props = imx_serial_properties;
+    device_class_set_props(dc, imx_serial_properties);
 }
 
 static const TypeInfo imx_serial_info = {
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 80e9dff..d7c497b 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -588,7 +588,7 @@ static void ipoctal_class_init(ObjectClass *klass, void *data)
 
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     dc->desc    = "GE IP-Octal 232 8-channel RS-232 IndustryPack";
-    dc->props   = ipoctal_properties;
+    device_class_set_props(dc, ipoctal_properties);
     dc->vmsd    = &vmstate_ipoctal;
 }
 
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index da9dd56..3f34861 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -146,7 +146,7 @@ static void lm32_juart_class_init(ObjectClass *klass, void *data)
 
     dc->reset = juart_reset;
     dc->vmsd = &vmstate_lm32_juart;
-    dc->props = lm32_juart_properties;
+    device_class_set_props(dc, lm32_juart_properties);
     dc->realize = lm32_juart_realize;
 }
 
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 8d7a475..b0b1092 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -293,7 +293,7 @@ static void lm32_uart_class_init(ObjectClass *klass, void *data)
 
     dc->reset = uart_reset;
     dc->vmsd = &vmstate_lm32_uart;
-    dc->props = lm32_uart_properties;
+    device_class_set_props(dc, lm32_uart_properties);
     dc->realize = lm32_uart_realize;
 }
 
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 2de3680..97e4bbc 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -320,7 +320,7 @@ static void mcf_uart_class_init(ObjectClass *oc, void *data)
 
     dc->realize = mcf_uart_realize;
     dc->reset = mcf_uart_reset;
-    dc->props = mcf_uart_properties;
+    device_class_set_props(dc, mcf_uart_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 1c7b614..1439efb 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -239,7 +239,7 @@ static void milkymist_uart_class_init(ObjectClass *klass, void *data)
     dc->realize = milkymist_uart_realize;
     dc->reset = milkymist_uart_reset;
     dc->vmsd = &vmstate_milkymist_uart;
-    dc->props = milkymist_uart_properties;
+    device_class_set_props(dc, milkymist_uart_properties);
 }
 
 static const TypeInfo milkymist_uart_info = {
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index b67fd21..d1fef77 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -314,7 +314,7 @@ static void nrf51_uart_class_init(ObjectClass *klass, void *data)
 
     dc->reset = nrf51_uart_reset;
     dc->realize = nrf51_uart_realize;
-    dc->props = nrf51_uart_properties;
+    device_class_set_props(dc, nrf51_uart_properties);
     dc->vmsd = &nrf51_uart_vmstate;
 }
 
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 40174ee..8dd67d1 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -627,7 +627,7 @@ static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
 
     dc->realize = parallel_isa_realizefn;
     dc->vmsd = &vmstate_parallel_isa;
-    dc->props = parallel_isa_properties;
+    device_class_set_props(dc, parallel_isa_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 23cd544..13e784f 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -356,7 +356,7 @@ static void pl011_class_init(ObjectClass *oc, void *data)
 
     dc->realize = pl011_realize;
     dc->vmsd = &vmstate_pl011;
-    dc->props = pl011_properties;
+    device_class_set_props(dc, pl011_properties);
 }
 
 static const TypeInfo pl011_arm_info = {
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 3926062..c420dc0 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -342,7 +342,7 @@ static void console_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCLPEventClass *ec = SCLP_EVENT_CLASS(klass);
 
-    dc->props = console_properties;
+    device_class_set_props(dc, console_properties);
     dc->reset = console_reset;
     dc->vmsd = &vmstate_sclplmconsole;
     ec->init = console_init;
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index da126f0..1fa124d 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -258,7 +258,7 @@ static void console_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCLPEventClass *ec = SCLP_EVENT_CLASS(klass);
 
-    dc->props = console_properties;
+    device_class_set_props(dc, console_properties);
     dc->reset = console_reset;
     dc->vmsd = &vmstate_sclpconsole;
     ec->init = console_init;
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index db86445..f9b6eed 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -106,7 +106,7 @@ static void serial_isa_class_initfn(ObjectClass *klass, void *data)
 
     dc->realize = serial_isa_realizefn;
     dc->vmsd = &vmstate_isa_serial;
-    dc->props = serial_isa_properties;
+    device_class_set_props(dc, serial_isa_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index e343a12..1742cb7 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -161,7 +161,7 @@ static void multi_2x_serial_pci_class_initfn(ObjectClass *klass, void *data)
     pc->revision = 1;
     pc->class_id = PCI_CLASS_COMMUNICATION_SERIAL;
     dc->vmsd = &vmstate_pci_multi_serial;
-    dc->props = multi_2x_serial_pci_properties;
+    device_class_set_props(dc, multi_2x_serial_pci_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
@@ -176,7 +176,7 @@ static void multi_4x_serial_pci_class_initfn(ObjectClass *klass, void *data)
     pc->revision = 1;
     pc->class_id = PCI_CLASS_COMMUNICATION_SERIAL;
     dc->vmsd = &vmstate_pci_multi_serial;
-    dc->props = multi_4x_serial_pci_properties;
+    device_class_set_props(dc, multi_4x_serial_pci_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index b6a73c6..743552c 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -100,7 +100,7 @@ static void serial_pci_class_initfn(ObjectClass *klass, void *data)
     pc->revision = 1;
     pc->class_id = PCI_CLASS_COMMUNICATION_SERIAL;
     dc->vmsd = &vmstate_pci_serial;
-    dc->props = serial_pci_properties;
+    device_class_set_props(dc, serial_pci_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index d167c43..9298881 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1044,7 +1044,7 @@ static void serial_class_init(ObjectClass *klass, void* data)
     dc->realize = serial_realize;
     dc->unrealize = serial_unrealize;
     dc->vmsd = &vmstate_serial;
-    dc->props = serial_properties;
+    device_class_set_props(dc, serial_properties);
 }
 
 static const TypeInfo serial_info = {
@@ -1159,7 +1159,7 @@ static void serial_mm_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->props = serial_mm_properties;
+    device_class_set_props(dc, serial_mm_properties);
     dc->realize = serial_mm_realize;
 }
 
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 8f4d9fe..ecb94f5 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -193,7 +193,7 @@ static void spapr_vty_class_init(ObjectClass *klass, void *data)
     k->dt_type = "serial";
     k->dt_compatible = "hvterm1";
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-    dc->props = spapr_vty_properties;
+    device_class_set_props(dc, spapr_vty_properties);
     dc->vmsd = &vmstate_spapr_vty;
 }
 
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 4ec843d..0d661be 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -222,7 +222,7 @@ static void stm32f2xx_usart_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = stm32f2xx_usart_reset;
-    dc->props = stm32f2xx_usart_properties;
+    device_class_set_props(dc, stm32f2xx_usart_properties);
     dc->realize = stm32f2xx_usart_realize;
 }
 
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index f7aba12..2c47ebf 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -288,7 +288,7 @@ static void terminal_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     EmulatedCcw3270Class *ck = EMULATED_CCW_3270_CLASS(klass);
 
-    dc->props = terminal_properties;
+    device_class_set_props(dc, terminal_properties);
     dc->vmsd = &terminal3270_vmstate;
     ck->init = terminal_init;
     ck->read_payload_3270 = read_payload_3270;
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index a7d34fe..b010c21 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -287,7 +287,7 @@ static void virtserialport_class_init(ObjectClass *klass, void *data)
     k->set_guest_connected = set_guest_connected;
     k->enable_backend = virtconsole_enable_backend;
     k->guest_writable = guest_writable;
-    dc->props = virtserialport_properties;
+    device_class_set_props(dc, virtserialport_properties);
 }
 
 static const TypeInfo virtserialport_info = {
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index e1cbce3..941ed5a 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1110,7 +1110,7 @@ static void virtio_serial_port_class_init(ObjectClass *klass, void *data)
     k->bus_type = TYPE_VIRTIO_SERIAL_BUS;
     k->realize = virtser_port_device_realize;
     k->unrealize = virtser_port_device_unrealize;
-    k->props = virtser_props;
+    device_class_set_props(k, virtser_props);
 }
 
 static const TypeInfo virtio_serial_port_type_info = {
@@ -1179,7 +1179,7 @@ static void virtio_serial_class_init(ObjectClass *klass, void *data)
 
     QLIST_INIT(&vserdevices.devices);
 
-    dc->props = virtio_serial_properties;
+    device_class_set_props(dc, virtio_serial_properties);
     dc->vmsd = &vmstate_virtio_console;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     vdc->realize = virtio_serial_device_realize;
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index aa6bf02..c651228 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -236,7 +236,7 @@ static void xilinx_uartlite_class_init(ObjectClass *klass, void *data)
 
     dc->reset = xilinx_uartlite_reset;
     dc->realize = xilinx_uartlite_realize;
-    dc->props = xilinx_uartlite_properties;
+    device_class_set_props(dc, xilinx_uartlite_properties);
 }
 
 static const TypeInfo xilinx_uartlite_info = {
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index fde5fd3..fe65ca6 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -440,7 +440,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
-    dc->props = cpu_common_props;
+    device_class_set_props(dc, cpu_common_props);
     /*
      * Reason: CPUs still need special care by board code: wiring up
      * IRQs, adding reset handlers, halting non-first CPUs, ...
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 4b1fc86..e7eb57e 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -201,7 +201,7 @@ static void generic_loader_class_init(ObjectClass *klass, void *data)
      */
     dc->realize = generic_loader_realize;
     dc->unrealize = generic_loader_unrealize;
-    dc->props = generic_loader_props;
+    device_class_set_props(dc, generic_loader_props);
     dc->desc = "Generic Loader";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 18d6383..4bbdbcb 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -125,7 +125,7 @@ static void or_irq_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = or_irq_reset;
-    dc->props = or_irq_properties;
+    device_class_set_props(dc, or_irq_properties);
     dc->realize = or_irq_realize;
     dc->vmsd = &vmstate_or_irq;
 
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index edb0da1..22c5f76 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -211,7 +211,7 @@ static void platform_bus_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = platform_bus_realize;
-    dc->props = platform_bus_properties;
+    device_class_set_props(dc, platform_bus_properties);
 }
 
 static const TypeInfo platform_bus_info = {
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 8708605..8047ac9 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1061,6 +1061,11 @@ static void device_class_init(ObjectClass *class, void *data)
     vc->get_id = device_vmstate_if_get_id;
 }
 
+void device_class_set_props(DeviceClass *dc, Property *props)
+{
+    dc->props = props;
+}
+
 void device_class_set_parent_reset(DeviceClass *dc,
                                    DeviceReset dev_reset,
                                    DeviceReset *parent_reset)
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
index b5acc66..3b90af2 100644
--- a/hw/core/split-irq.c
+++ b/hw/core/split-irq.c
@@ -69,7 +69,7 @@ static void split_irq_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     /* No state to reset or migrate */
-    dc->props = split_irq_properties;
+    device_class_set_props(dc, split_irq_properties);
     dc->realize = split_irq_realize;
 
     /* Reason: Needs to be wired up to work */
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 7e9983a..4f65911 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -164,7 +164,7 @@ static void a15mp_priv_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = a15mp_priv_realize;
-    dc->props = a15mp_priv_properties;
+    device_class_set_props(dc, a15mp_priv_properties);
     /* We currently have no savable state */
 }
 
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 6872a3a..1f8bc8a 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -175,7 +175,7 @@ static void a9mp_priv_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = a9mp_priv_realize;
-    dc->props = a9mp_priv_properties;
+    device_class_set_props(dc, a9mp_priv_properties);
 }
 
 static const TypeInfo a9mp_priv_info = {
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index e78f5d0..2e3e87c 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -156,7 +156,7 @@ static void mpcore_priv_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = mpcore_priv_realize;
-    dc->props = mpcore_priv_properties;
+    device_class_set_props(dc, mpcore_priv_properties);
 }
 
 static const TypeInfo mpcore_priv_info = {
diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index 349a883..e444b7c 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -78,7 +78,7 @@ static void cpu_cluster_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = cpu_cluster_properties;
+    device_class_set_props(dc, cpu_cluster_properties);
     dc->realize = cpu_cluster_realize;
 
     /* This is not directly for users, CPU children must be attached by code */
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index ae2c991..cc2767c 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -125,7 +125,7 @@ static void mpcore_rirq_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = realview_mpcore_realize;
-    dc->props = mpcore_rirq_properties;
+    device_class_set_props(dc, mpcore_rirq_properties);
 }
 
 static const TypeInfo mpcore_rirq_info = {
diff --git a/hw/display/ati.c b/hw/display/ati.c
index db3b254..58ec829 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -980,7 +980,7 @@ static void ati_vga_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     dc->reset = ati_vga_reset;
-    dc->props = ati_vga_properties;
+    device_class_set_props(dc, ati_vga_properties);
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
 
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 85aaa54..d6bf337 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -451,7 +451,7 @@ static void bcm2835_fb_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = bcm2835_fb_props;
+    device_class_set_props(dc, bcm2835_fb_props);
     dc->realize = bcm2835_fb_realize;
     dc->reset = bcm2835_fb_reset;
     dc->vmsd = &vmstate_bcm2835_fb;
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 215db9a..62085f9 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -364,7 +364,7 @@ static void bochs_display_class_init(ObjectClass *klass, void *data)
     k->romfile   = "vgabios-bochs-display.bin";
     k->exit      = bochs_display_exit;
     dc->vmsd     = &vmstate_bochs_display;
-    dc->props    = bochs_display_properties;
+    device_class_set_props(dc, bochs_display_properties);
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
 }
 
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index f90baae..4fb67c6 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -382,7 +382,7 @@ static void cg3_class_init(ObjectClass *klass, void *data)
     dc->realize = cg3_realizefn;
     dc->reset = cg3_reset;
     dc->vmsd = &vmstate_cg3;
-    dc->props = cg3_properties;
+    device_class_set_props(dc, cg3_properties);
 }
 
 static const TypeInfo cg3_info = {
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index cd283e5..0d391e1 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3031,7 +3031,7 @@ static void cirrus_vga_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->desc = "Cirrus CLGD 54xx VGA";
     dc->vmsd = &vmstate_pci_cirrus_vga;
-    dc->props = pci_vga_cirrus_properties;
+    device_class_set_props(dc, pci_vga_cirrus_properties);
     dc->hotpluggable = false;
 }
 
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 7ef8e59..825ba57 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -80,7 +80,7 @@ static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd  = &vmstate_cirrus_vga;
     dc->realize = isa_cirrus_vga_realizefn;
-    dc->props = isa_cirrus_vga_properties;
+    device_class_set_props(dc, isa_cirrus_vga_properties);
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
 }
 
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 839d26e..55185c9 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -526,7 +526,7 @@ static void g364fb_sysbus_class_init(ObjectClass *klass, void *data)
     dc->desc = "G364 framebuffer";
     dc->reset = g364fb_sysbus_reset;
     dc->vmsd = &vmstate_g364fb;
-    dc->props = g364fb_sysbus_properties;
+    device_class_set_props(dc, g364fb_sysbus_properties);
 }
 
 static const TypeInfo g364fb_sysbus_info = {
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index fc70b79..13eb529 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -107,7 +107,7 @@ static void i2c_ddc_class_init(ObjectClass *oc, void *data)
 
     dc->reset = i2c_ddc_reset;
     dc->vmsd = &vmstate_i2c_ddc;
-    dc->props = i2c_ddc_properties;
+    device_class_set_props(dc, i2c_ddc_properties);
     isc->event = i2c_ddc_event;
     isc->recv = i2c_ddc_rx;
     isc->send = i2c_ddc_tx;
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index f4fa8e3..8bff16d 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -437,7 +437,7 @@ static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
     dc->desc = "SysBus Macintosh framebuffer";
     dc->reset = macfb_sysbus_reset;
     dc->vmsd = &vmstate_macfb;
-    dc->props = macfb_sysbus_properties;
+    device_class_set_props(dc, macfb_sysbus_properties);
 }
 
 static void macfb_nubus_class_init(ObjectClass *klass, void *data)
@@ -450,7 +450,7 @@ static void macfb_nubus_class_init(ObjectClass *klass, void *data)
     dc->desc = "Nubus Macintosh framebuffer";
     dc->reset = macfb_nubus_reset;
     dc->vmsd = &vmstate_macfb;
-    dc->props = macfb_nubus_properties;
+    device_class_set_props(dc, macfb_nubus_properties);
 }
 
 static TypeInfo macfb_sysbus_info = {
diff --git a/hw/display/milkymist-vgafb.c b/hw/display/milkymist-vgafb.c
index 8b0da46..6a6441e 100644
--- a/hw/display/milkymist-vgafb.c
+++ b/hw/display/milkymist-vgafb.c
@@ -341,7 +341,7 @@ static void milkymist_vgafb_class_init(ObjectClass *klass, void *data)
 
     dc->reset = milkymist_vgafb_reset;
     dc->vmsd = &vmstate_milkymist_vgafb;
-    dc->props = milkymist_vgafb_properties;
+    device_class_set_props(dc, milkymist_vgafb_properties);
     dc->realize = milkymist_vgafb_realize;
 }
 
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 6d43b74..944c02c 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2478,7 +2478,7 @@ static void qxl_pci_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->reset = qxl_reset_handler;
     dc->vmsd = &qxl_vmstate;
-    dc->props = qxl_properties;
+    device_class_set_props(dc, qxl_properties);
 }
 
 static const TypeInfo qxl_pci_type_info = {
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 1f72450..d76a9d0 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -52,7 +52,7 @@ static void ramfb_class_initfn(ObjectClass *klass, void *data)
 
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->realize = ramfb_realizefn;
-    dc->props = ramfb_properties;
+    device_class_set_props(dc, ramfb_properties);
     dc->desc = "ram framebuffer standalone device";
     dc->user_creatable = true;
 }
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 66a1bfb..de0ab9d 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1995,7 +1995,7 @@ static void sm501_sysbus_class_init(ObjectClass *klass, void *data)
     dc->realize = sm501_realize_sysbus;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->desc = "SM501 Multimedia Companion";
-    dc->props = sm501_sysbus_properties;
+    device_class_set_props(dc, sm501_sysbus_properties);
     dc->reset = sm501_reset_sysbus;
     dc->vmsd = &vmstate_sm501_sysbus;
 }
@@ -2085,7 +2085,7 @@ static void sm501_pci_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_DISPLAY_OTHER;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->desc = "SM501 Display Controller";
-    dc->props = sm501_pci_properties;
+    device_class_set_props(dc, sm501_pci_properties);
     dc->reset = sm501_reset_pci;
     dc->hotpluggable = false;
     dc->vmsd = &vmstate_sm501_pci;
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index abbeb30..ca458f9 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -893,7 +893,7 @@ static void tcx_class_init(ObjectClass *klass, void *data)
     dc->realize = tcx_realizefn;
     dc->reset = tcx_reset;
     dc->vmsd = &vmstate_tcx;
-    dc->props = tcx_properties;
+    device_class_set_props(dc, tcx_properties);
 }
 
 static const TypeInfo tcx_info = {
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 08a2730..0633ed3 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -95,7 +95,7 @@ static void vga_isa_class_initfn(ObjectClass *klass, void *data)
     dc->realize = vga_isa_realizefn;
     dc->reset = vga_isa_reset;
     dc->vmsd = &vmstate_vga_common;
-    dc->props = vga_isa_properties;
+    device_class_set_props(dc, vga_isa_properties);
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
 }
 
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index cfe0957..b346324 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -383,7 +383,7 @@ static void vga_class_init(ObjectClass *klass, void *data)
     k->realize = pci_std_vga_realize;
     k->romfile = "vgabios-stdvga.bin";
     k->class_id = PCI_CLASS_DISPLAY_VGA;
-    dc->props = vga_pci_properties;
+    device_class_set_props(dc, vga_pci_properties);
     dc->hotpluggable = false;
 }
 
@@ -395,7 +395,7 @@ static void secondary_class_init(ObjectClass *klass, void *data)
     k->realize = pci_secondary_vga_realize;
     k->exit = pci_secondary_vga_exit;
     k->class_id = PCI_CLASS_DISPLAY_OTHER;
-    dc->props = secondary_pci_properties;
+    device_class_set_props(dc, secondary_pci_properties);
     dc->reset = pci_secondary_vga_reset;
 }
 
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 2798778..f0c7c6f 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -588,7 +588,7 @@ vhost_user_gpu_class_init(ObjectClass *klass, void *data)
     vdc->get_config = vhost_user_gpu_get_config;
     vdc->set_config = vhost_user_gpu_set_config;
 
-    dc->props = vhost_user_gpu_properties;
+    device_class_set_props(dc, vhost_user_gpu_properties);
 }
 
 static const TypeInfo vhost_user_gpu_info = {
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 25e4038..3d152ff 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -56,7 +56,7 @@ static void virtio_gpu_pci_base_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-    dc->props = virtio_gpu_pci_base_properties;
+    device_class_set_props(dc, virtio_gpu_pci_base_properties);
     dc->hotpluggable = false;
     k->realize = virtio_gpu_pci_base_realize;
     pcidev_k->class_id = PCI_CLASS_DISPLAY_OTHER;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 28e868c..5f0dd7c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1254,7 +1254,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
     vdc->set_config = virtio_gpu_set_config;
 
     dc->vmsd = &vmstate_virtio_gpu;
-    dc->props = virtio_gpu_properties;
+    device_class_set_props(dc, virtio_gpu_properties);
 }
 
 static const TypeInfo virtio_gpu_info = {
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index cc6e66e..2b4c2aa 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -184,7 +184,7 @@ static void virtio_vga_base_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-    dc->props = virtio_vga_base_properties;
+    device_class_set_props(dc, virtio_vga_base_properties);
     dc->vmsd = &vmstate_virtio_vga_base;
     dc->hotpluggable = false;
     device_class_set_parent_reset(dc, virtio_vga_base_reset,
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index ead754e..58ea82e 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1336,7 +1336,7 @@ static void vmsvga_class_init(ObjectClass *klass, void *data)
     k->subsystem_id = SVGA_PCI_DEVICE_ID;
     dc->reset = vmsvga_reset;
     dc->vmsd = &vmstate_vmware_vga;
-    dc->props = vga_vmware_properties;
+    device_class_set_props(dc, vga_vmware_properties);
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
 }
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index b788b36..6977d85 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -149,7 +149,7 @@ static void i82374_class_init(ObjectClass *klass, void *data)
     
     dc->realize = i82374_realize;
     dc->vmsd = &vmstate_i82374;
-    dc->props = i82374_properties;
+    device_class_set_props(dc, i82374_properties);
 }
 
 static const TypeInfo i82374_info = {
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 792f617..bad8deb 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -595,7 +595,7 @@ static void i8257_class_init(ObjectClass *klass, void *data)
     dc->realize = i8257_realize;
     dc->reset = i8257_reset;
     dc->vmsd = &vmstate_i8257;
-    dc->props = i8257_properties;
+    device_class_set_props(dc, i8257_properties);
 
     idc->get_transfer_mode = i8257_dma_get_transfer_mode;
     idc->has_autoinitialization = i8257_dma_has_autoinitialization;
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 52ba23f..f1a586b 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -421,7 +421,7 @@ static void pl080_class_init(ObjectClass *oc, void *data)
 
     dc->vmsd = &vmstate_pl080;
     dc->realize = pl080_realize;
-    dc->props = pl080_properties;
+    device_class_set_props(dc, pl080_properties);
     dc->reset = pl080_reset;
 }
 
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index f2bb2d9..8c9625c 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -1656,7 +1656,7 @@ static void pl330_class_init(ObjectClass *klass, void *data)
 
     dc->realize = pl330_realize;
     dc->reset = pl330_reset;
-    dc->props = pl330_properties;
+    device_class_set_props(dc, pl330_properties);
     dc->vmsd = &vmstate_pl330;
 }
 
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index 18e7a0b..88ed4b6 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -566,7 +566,7 @@ static void pxa2xx_dma_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "PXA2xx DMA controller";
     dc->vmsd = &vmstate_pxa2xx_dma;
-    dc->props = pxa2xx_dma_properties;
+    device_class_set_props(dc, pxa2xx_dma_properties);
     dc->realize = pxa2xx_dma_realize;
 }
 
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index fb3a978..018f369 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -599,7 +599,7 @@ static void axidma_class_init(ObjectClass *klass, void *data)
 
     dc->realize = xilinx_axidma_realize,
     dc->reset = xilinx_axidma_reset;
-    dc->props = axidma_properties;
+    device_class_set_props(dc, axidma_properties);
 }
 
 static StreamSlaveClass xilinx_axidma_data_stream_class = {
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 75b6609..8fb83f5 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -820,7 +820,7 @@ static void zdma_class_init(ObjectClass *klass, void *data)
 
     dc->reset = zdma_reset;
     dc->realize = zdma_realize;
-    dc->props = zdma_props;
+    device_class_set_props(dc, zdma_props);
     dc->vmsd = &vmstate_zdma;
 }
 
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index ac8304e..7a59180 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -335,7 +335,7 @@ static void imx_gpio_class_init(ObjectClass *klass, void *data)
 
     dc->realize = imx_gpio_realize;
     dc->reset = imx_gpio_reset;
-    dc->props = imx_gpio_properties;
+    device_class_set_props(dc, imx_gpio_properties);
     dc->vmsd = &vmstate_imx_gpio;
     dc->desc = "i.MX GPIO controller";
 }
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 85c1689..f662c4c 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -755,7 +755,7 @@ static void omap_gpio_class_init(ObjectClass *klass, void *data)
 
     dc->realize = omap_gpio_realize;
     dc->reset = omap_gpif_reset;
-    dc->props = omap_gpio_properties;
+    device_class_set_props(dc, omap_gpio_properties);
     /* Reason: pointer property "clk" */
     dc->user_creatable = false;
 }
@@ -790,7 +790,7 @@ static void omap2_gpio_class_init(ObjectClass *klass, void *data)
 
     dc->realize = omap2_gpio_realize;
     dc->reset = omap2_gpif_reset;
-    dc->props = omap2_gpio_properties;
+    device_class_set_props(dc, omap2_gpio_properties);
     /* Reason: pointer properties "iclk", "fclk0", ..., "fclk5" */
     dc->user_creatable = false;
 }
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 2da04a4..9cda968 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -832,7 +832,7 @@ static void aspeed_i2c_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &aspeed_i2c_vmstate;
     dc->reset = aspeed_i2c_reset;
-    dc->props = aspeed_i2c_properties;
+    device_class_set_props(dc, aspeed_i2c_properties);
     dc->realize = aspeed_i2c_realize;
     dc->desc = "Aspeed I2C Controller";
 }
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index d770035..d413a19 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -281,7 +281,7 @@ static void i2c_slave_class_init(ObjectClass *klass, void *data)
     DeviceClass *k = DEVICE_CLASS(klass);
     set_bit(DEVICE_CATEGORY_MISC, k->categories);
     k->bus_type = TYPE_I2C_BUS;
-    k->props = i2c_props;
+    device_class_set_props(k, i2c_props);
 }
 
 static const TypeInfo i2c_slave_type_info = {
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 3ccbd5c..e5d205d 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -520,7 +520,7 @@ static void omap_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = omap_i2c_properties;
+    device_class_set_props(dc, omap_i2c_properties);
     dc->reset = omap_i2c_reset;
     /* Reason: pointer properties "iclk", "fclk" */
     dc->user_creatable = false;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a523ef0..6258c58 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3845,7 +3845,7 @@ static void vtd_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vtd_reset;
     dc->vmsd = &vtd_vmstate;
-    dc->props = vtd_properties;
+    device_class_set_props(dc, vtd_properties);
     dc->hotpluggable = false;
     x86_class->realize = vtd_realize;
     x86_class->int_remap = vtd_int_remap;
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 2c59b68..6428335 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -317,7 +317,7 @@ static void kvmclock_class_init(ObjectClass *klass, void *data)
 
     dc->realize = kvmclock_realize;
     dc->vmsd = &kvmclock_vmsd;
-    dc->props = kvmclock_properties;
+    device_class_set_props(dc, kvmclock_properties);
 }
 
 static const TypeInfo kvmclock_info = {
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 6a911e2..876f5aa6 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -322,7 +322,7 @@ static void kvm_pit_class_init(ObjectClass *klass, void *data)
     k->set_channel_gate = kvm_pit_set_gate;
     k->get_channel_info = kvm_pit_get_channel_info;
     dc->reset = kvm_pit_reset;
-    dc->props = kvm_pit_properties;
+    device_class_set_props(dc, kvm_pit_properties);
 }
 
 static const TypeInfo kvm_pit_info = {
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 973e2b2..4ba8e47 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -149,7 +149,7 @@ static void kvm_ioapic_class_init(ObjectClass *klass, void *data)
     k->pre_save  = kvm_ioapic_get;
     k->post_load = kvm_ioapic_put;
     dc->reset    = kvm_ioapic_reset;
-    dc->props    = kvm_ioapic_properties;
+    device_class_set_props(dc, kvm_ioapic_properties);
 }
 
 static const TypeInfo kvm_ioapic_info = {
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index c0c329f..7c2a375 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -286,7 +286,7 @@ static void vmmouse_class_initfn(ObjectClass *klass, void *data)
     dc->realize = vmmouse_realizefn;
     dc->reset = vmmouse_reset;
     dc->vmsd = &vmstate_vmmouse;
-    dc->props = vmmouse_properties;
+    device_class_set_props(dc, vmmouse_properties);
 }
 
 static const TypeInfo vmmouse_info = {
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 1eaf2dd..4104060 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -153,7 +153,7 @@ static void x86_iommu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = x86_iommu_realize;
-    dc->props = x86_iommu_properties;
+    device_class_set_props(dc, x86_iommu_properties);
 }
 
 bool x86_iommu_ir_supported(X86IOMMUState *s)
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index 27f646d..ee2610c 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -131,7 +131,7 @@ static void xen_pv_class_init(ObjectClass *klass, void *data)
     k->realize = xen_pv_realize;
     k->class_id = PCI_CLASS_SYSTEM_OTHER;
     dc->desc = "Xen PV Device";
-    dc->props = xen_pv_props;
+    device_class_set_props(dc, xen_pv_props);
     dc->vmsd = &vmstate_xen_pvdevice;
 }
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index d45393c..68264a2 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1795,7 +1795,7 @@ static void sysbus_ahci_class_init(ObjectClass *klass, void *data)
 
     dc->realize = sysbus_ahci_realize;
     dc->vmsd = &vmstate_sysbus_ahci;
-    dc->props = sysbus_ahci_properties;
+    device_class_set_props(dc, sysbus_ahci_properties);
     dc->reset = sysbus_ahci_reset;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 3f9be96..335c060 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -347,7 +347,7 @@ static void cmd646_ide_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_STORAGE_IDE;
     k->config_read = cmd646_pci_config_read;
     k->config_write = cmd646_pci_config_write;
-    dc->props = cmd646_ide_properties;
+    device_class_set_props(dc, cmd646_ide_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 9c7f88b..8395807 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -117,7 +117,7 @@ static void isa_ide_class_initfn(ObjectClass *klass, void *data)
     dc->realize = isa_ide_realizefn;
     dc->fw_name = "ide";
     dc->reset = isa_ide_reset;
-    dc->props = isa_ide_properties;
+    device_class_set_props(dc, isa_ide_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 79f787c..7a8470e 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -474,7 +474,7 @@ static void macio_ide_class_init(ObjectClass *oc, void *data)
 
     dc->realize = macio_ide_realizefn;
     dc->reset = macio_ide_reset;
-    dc->props = macio_ide_properties;
+    device_class_set_props(dc, macio_ide_properties);
     dc->vmsd = &vmstate_pmac;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 7149a9c..d233bd8 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -154,7 +154,7 @@ static void mmio_ide_class_init(ObjectClass *oc, void *data)
 
     dc->realize = mmio_ide_realizefn;
     dc->reset = mmio_ide_reset;
-    dc->props = mmio_ide_properties;
+    device_class_set_props(dc, mmio_ide_properties);
     dc->vmsd = &vmstate_ide_mmio;
 }
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 374a791..c22afdb 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -319,7 +319,7 @@ static void ide_hd_class_init(ObjectClass *klass, void *data)
     k->realize  = ide_hd_realize;
     dc->fw_name = "drive";
     dc->desc    = "virtual IDE disk";
-    dc->props   = ide_hd_properties;
+    device_class_set_props(dc, ide_hd_properties);
 }
 
 static const TypeInfo ide_hd_info = {
@@ -342,7 +342,7 @@ static void ide_cd_class_init(ObjectClass *klass, void *data)
     k->realize  = ide_cd_realize;
     dc->fw_name = "drive";
     dc->desc    = "virtual IDE CD-ROM";
-    dc->props   = ide_cd_properties;
+    device_class_set_props(dc, ide_cd_properties);
 }
 
 static const TypeInfo ide_cd_info = {
@@ -365,7 +365,7 @@ static void ide_drive_class_init(ObjectClass *klass, void *data)
     k->realize  = ide_drive_realize;
     dc->fw_name = "drive";
     dc->desc    = "virtual IDE disk or CD-ROM (legacy)";
-    dc->props   = ide_drive_properties;
+    device_class_set_props(dc, ide_drive_properties);
 }
 
 static const TypeInfo ide_drive_info = {
@@ -381,7 +381,7 @@ static void ide_device_class_init(ObjectClass *klass, void *data)
     k->realize = ide_qdev_realize;
     set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
     k->bus_type = TYPE_IDE_BUS;
-    k->props = ide_props;
+    device_class_set_props(k, ide_props);
 }
 
 static const TypeInfo ide_device_type_info = {
diff --git a/hw/input/adb.c b/hw/input/adb.c
index 478a90f..b1ac4a3 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -128,7 +128,7 @@ static void adb_device_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = adb_device_realizefn;
-    dc->props = adb_device_properties;
+    device_class_set_props(dc, adb_device_properties);
     dc->bus_type = TYPE_ADB_BUS;
 }
 
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 67fcb35..3e0a7eb 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -302,7 +302,7 @@ static void milkymist_softusb_class_init(ObjectClass *klass, void *data)
     dc->realize = milkymist_softusb_realize;
     dc->reset = milkymist_softusb_reset;
     dc->vmsd = &vmstate_milkymist_softusb;
-    dc->props = milkymist_softusb_properties;
+    device_class_set_props(dc, milkymist_softusb_properties);
 }
 
 static const TypeInfo milkymist_softusb_info = {
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 386a363..e8ae6c1 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -222,7 +222,7 @@ static void virtio_input_hid_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOInputClass *vic = VIRTIO_INPUT_CLASS(klass);
 
-    dc->props          = virtio_input_hid_properties;
+    device_class_set_props(dc, virtio_input_hid_properties);
     vic->realize       = virtio_input_hid_realize;
     vic->unrealize     = virtio_input_hid_unrealize;
     vic->change_active = virtio_input_hid_change_active;
@@ -362,7 +362,7 @@ static void virtio_mouse_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props  = virtio_mouse_properties;
+    device_class_set_props(dc, virtio_mouse_properties);
 }
 
 static void virtio_mouse_init(Object *obj)
@@ -486,7 +486,7 @@ static void virtio_tablet_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props  = virtio_tablet_properties;
+    device_class_set_props(dc, virtio_tablet_properties);
 }
 
 static void virtio_tablet_init(Object *obj)
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index 1c3b12b..f2ab6df 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -226,7 +226,7 @@ static void virtio_input_host_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd           = &vmstate_virtio_input_host;
-    dc->props          = virtio_input_host_properties;
+    device_class_set_props(dc, virtio_input_host_properties);
     vic->realize       = virtio_input_host_realize;
     vic->unrealize     = virtio_input_host_unrealize;
     vic->handle_status = virtio_input_host_handle_status;
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 9c013af..4d49790 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -316,7 +316,7 @@ static void virtio_input_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
-    dc->props          = virtio_input_properties;
+    device_class_set_props(dc, virtio_input_properties);
     dc->vmsd           = &vmstate_virtio_input;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     vdc->realize      = virtio_input_device_realize;
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index b5dbeb6..9ec0f2d 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -453,7 +453,7 @@ static void apic_common_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = apic_reset_common;
-    dc->props = apic_properties_common;
+    device_class_set_props(dc, apic_properties_common);
     dc->realize = apic_common_realize;
     dc->unrealize = apic_common_unrealize;
     /*
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index f0d0d7c..e6c4fe7 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -367,7 +367,7 @@ static void arm_gic_common_class_init(ObjectClass *klass, void *data)
 
     dc->reset = arm_gic_common_reset;
     dc->realize = arm_gic_common_realize;
-    dc->props = arm_gic_common_properties;
+    device_class_set_props(dc, arm_gic_common_properties);
     dc->vmsd = &vmstate_gic;
     albifc->arm_linux_init = arm_gic_common_linux_init;
 }
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index 6e45f4f..0b7e2b4 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -179,7 +179,7 @@ static void gicv2m_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = gicv2m_properties;
+    device_class_set_props(dc, gicv2m_properties);
     dc->realize = gicv2m_realize;
 }
 
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index f0c551d..58ef65f 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -507,7 +507,7 @@ static void arm_gicv3_common_class_init(ObjectClass *klass, void *data)
 
     dc->reset = arm_gicv3_common_reset;
     dc->realize = arm_gicv3_common_realize;
-    dc->props = arm_gicv3_common_properties;
+    device_class_set_props(dc, arm_gicv3_common_properties);
     dc->vmsd = &vmstate_gicv3;
     albifc->arm_linux_init = arm_gic_common_linux_init;
 }
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index d66f243..ad0ebab 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -246,7 +246,7 @@ static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
     KVMARMITSClass *ic = KVM_ARM_ITS_CLASS(klass);
 
     dc->realize = kvm_arm_its_realize;
-    dc->props   = kvm_arm_its_props;
+    device_class_set_props(dc, kvm_arm_its_props);
     device_class_set_parent_reset(dc, kvm_arm_its_reset, &ic->parent_reset);
     icc->send_msi = kvm_its_send_msi;
     icc->pre_save = kvm_arm_its_pre_save;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index e8c74f9..f9e0eea 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2749,7 +2749,7 @@ static void armv7m_nvic_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd  = &vmstate_nvic;
-    dc->props = props_nvic;
+    device_class_set_props(dc, props_nvic);
     dc->reset = armv7m_nvic_reset;
     dc->realize = armv7m_nvic_realize;
 }
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 5b33ca6..b8561e4 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -442,7 +442,7 @@ static void exynos4210_combiner_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = exynos4210_combiner_reset;
-    dc->props = exynos4210_combiner_properties;
+    device_class_set_props(dc, exynos4210_combiner_properties);
     dc->vmsd = &vmstate_exynos4210_combiner;
 }
 
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index 9a84d85..82c8f41 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -355,7 +355,7 @@ static void exynos4210_gic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = exynos4210_gic_properties;
+    device_class_set_props(dc, exynos4210_gic_properties);
     dc->realize = exynos4210_gic_realize;
 }
 
@@ -462,7 +462,7 @@ static void exynos4210_irq_gate_class_init(ObjectClass *klass, void *data)
 
     dc->reset = exynos4210_irq_gate_reset;
     dc->vmsd = &vmstate_exynos4210_irq_gate;
-    dc->props = exynos4210_irq_gate_properties;
+    device_class_set_props(dc, exynos4210_irq_gate_properties);
     dc->realize = exynos4210_irq_gate_realize;
 }
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index e7b1a10..99f8f6a 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -184,7 +184,7 @@ static void pic_common_class_init(ObjectClass *klass, void *data)
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->vmsd = &vmstate_pic_common;
-    dc->props = pic_properties_common;
+    device_class_set_props(dc, pic_properties_common);
     dc->realize = pic_common_realize;
     /*
      * Reason: unlike ordinary ISA devices, the PICs need additional
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 4f55776..15747fe 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -477,7 +477,7 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
      */
     k->post_load = ioapic_update_kvm_routes;
     dc->reset = ioapic_reset_common;
-    dc->props = ioapic_properties;
+    device_class_set_props(dc, ioapic_properties);
 }
 
 static const TypeInfo ioapic_info = {
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 54b3059..bda4549 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -448,7 +448,7 @@ static void mips_gic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = mips_gic_properties;
+    device_class_set_props(dc, mips_gic_properties);
     dc->realize = mips_gic_realize;
 }
 
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 73bb1c2..b8a1d1f 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -407,7 +407,7 @@ static void omap_intc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = omap_inth_reset;
-    dc->props = omap_intc_properties;
+    device_class_set_props(dc, omap_intc_properties);
     /* Reason: pointer property "clk" */
     dc->user_creatable = false;
     dc->realize = omap_intc_realize;
@@ -660,7 +660,7 @@ static void omap2_intc_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = omap_inth_reset;
-    dc->props = omap2_intc_properties;
+    device_class_set_props(dc, omap2_intc_properties);
     /* Reason: pointer property "iclk", "fclk" */
     dc->user_creatable = false;
     dc->realize = omap2_intc_realize;
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index ca9614f..c354427 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -161,7 +161,7 @@ static void or1k_ompic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = or1k_ompic_properties;
+    device_class_set_props(dc, or1k_ompic_properties);
     dc->realize = or1k_ompic_realize;
     dc->vmsd = &vmstate_or1k_ompic;
 }
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index c797ba7..65970e1 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1628,7 +1628,7 @@ static void openpic_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = openpic_realize;
-    dc->props = openpic_properties;
+    device_class_set_props(dc, openpic_properties);
     dc->reset = openpic_reset;
     dc->vmsd = &vmstate_openpic;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index c09bebe..e4bf47d 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -274,7 +274,7 @@ static void kvm_openpic_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = kvm_openpic_realize;
-    dc->props = kvm_openpic_properties;
+    device_class_set_props(dc, kvm_openpic_properties);
     dc->reset = kvm_openpic_reset;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 715fca6..aeda488 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1957,7 +1957,7 @@ static void pnv_xive_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV XIVE Interrupt Controller";
     device_class_set_parent_realize(dc, pnv_xive_realize, &pxc->parent_realize);
     dc->realize = pnv_xive_realize;
-    dc->props = pnv_xive_properties;
+    device_class_set_props(dc, pnv_xive_properties);
 
     xrc->get_eas = pnv_xive_get_eas;
     xrc->get_end = pnv_xive_get_end;
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index a159c0c..5f290f5 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -427,7 +427,7 @@ static void s390_flic_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->props = s390_flic_common_properties;
+    device_class_set_props(dc, s390_flic_common_properties);
     dc->realize = s390_flic_common_realize;
 }
 
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 7663123..024b8ce 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -770,7 +770,7 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
     SpaprXiveClass *sxc = SPAPR_XIVE_CLASS(klass);
 
     dc->desc    = "sPAPR XIVE Interrupt Controller";
-    dc->props   = spapr_xive_properties;
+    device_class_set_props(dc, spapr_xive_properties);
     device_class_set_parent_realize(dc, spapr_xive_realize,
                                     &sxc->parent_realize);
     dc->vmsd    = &vmstate_spapr_xive;
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 1952009..785b607 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -358,7 +358,7 @@ static void icp_class_init(ObjectClass *klass, void *data)
 
     dc->realize = icp_realize;
     dc->unrealize = icp_unrealize;
-    dc->props = icp_properties;
+    device_class_set_props(dc, icp_properties);
     /*
      * Reason: part of XICS interrupt controller, needs to be wired up
      * by icp_create().
@@ -680,7 +680,7 @@ static void ics_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = ics_realize;
-    dc->props = ics_properties;
+    device_class_set_props(dc, ics_properties);
     dc->reset = ics_reset;
     dc->vmsd = &vmstate_ics;
     /*
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index e15cb42..3e65e68 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -185,7 +185,7 @@ static void xilinx_intc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = xilinx_intc_properties;
+    device_class_set_props(dc, xilinx_intc_properties);
 }
 
 static const TypeInfo xilinx_intc_info = {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index bc8019c..7fb29a4 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -740,7 +740,7 @@ static void xive_tctx_class_init(ObjectClass *klass, void *data)
     dc->desc = "XIVE Interrupt Thread Context";
     dc->realize = xive_tctx_realize;
     dc->vmsd = &vmstate_xive_tctx;
-    dc->props = xive_tctx_properties;
+    device_class_set_props(dc, xive_tctx_properties);
     /*
      * Reason: part of XIVE interrupt controller, needs to be wired up
      * by xive_tctx_create().
@@ -1192,7 +1192,7 @@ static void xive_source_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc    = "XIVE Interrupt Source";
-    dc->props   = xive_source_properties;
+    device_class_set_props(dc, xive_source_properties);
     dc->realize = xive_source_realize;
     dc->vmsd    = &vmstate_xive_source;
     /*
@@ -1899,7 +1899,7 @@ static void xive_end_source_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc    = "XIVE END Source";
-    dc->props   = xive_end_source_properties;
+    device_class_set_props(dc, xive_end_source_properties);
     dc->realize = xive_end_source_realize;
     /*
      * Reason: part of XIVE interrupt controller, needs to be wired up,
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index f9a1401..acaa1c3 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -539,7 +539,7 @@ static void xlnx_pmu_io_intc_class_init(ObjectClass *klass, void *data)
     dc->reset = xlnx_pmu_io_intc_reset;
     dc->realize = xlnx_pmu_io_intc_realize;
     dc->vmsd = &vmstate_xlnx_pmu_io_intc;
-    dc->props = xlnx_pmu_io_intc_properties;
+    device_class_set_props(dc, xlnx_pmu_io_intc_properties);
 }
 
 static const TypeInfo xlnx_pmu_io_intc_info = {
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index 30e1669..49787a1 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -88,7 +88,7 @@ static void ipack_device_class_init(ObjectClass *klass, void *data)
     k->bus_type = TYPE_IPACK_BUS;
     k->realize = ipack_device_realize;
     k->unrealize = ipack_device_unrealize;
-    k->props = ipack_device_props;
+    device_class_set_props(k, ipack_device_props);
 }
 
 const VMStateDescription vmstate_ipack_device = {
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index cbe158f..46c6a79 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -118,7 +118,7 @@ static void bmc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->props = ipmi_bmc_properties;
+    device_class_set_props(dc, ipmi_bmc_properties);
 }
 
 static TypeInfo ipmi_bmc_type_info = {
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 16a4117..f9a13e0 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -528,7 +528,7 @@ static void ipmi_bmc_extern_class_init(ObjectClass *oc, void *data)
     bk->handle_reset = ipmi_bmc_extern_handle_reset;
     dc->hotpluggable = false;
     dc->realize = ipmi_bmc_extern_realize;
-    dc->props = ipmi_bmc_extern_properties;
+    device_class_set_props(dc, ipmi_bmc_extern_properties);
 }
 
 static const TypeInfo ipmi_bmc_extern_type = {
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6670cf0..0b97e04 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -1989,7 +1989,7 @@ static void ipmi_sim_class_init(ObjectClass *oc, void *data)
 
     dc->hotpluggable = false;
     dc->realize = ipmi_sim_realize;
-    dc->props = ipmi_sim_properties;
+    device_class_set_props(dc, ipmi_sim_properties);
     bk->handle_command = ipmi_sim_handle_command;
 }
 
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 9fba5ed..c8dc0a0 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -147,7 +147,7 @@ static void isa_ipmi_bt_class_init(ObjectClass *oc, void *data)
     IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
 
     dc->realize = isa_ipmi_bt_realize;
-    dc->props = ipmi_isa_properties;
+    device_class_set_props(dc, ipmi_isa_properties);
 
     iic->get_backend_data = isa_ipmi_bt_get_backend_data;
     ipmi_bt_class_init(iic);
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index cc6bd81..4b421c3 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -154,7 +154,7 @@ static void isa_ipmi_kcs_class_init(ObjectClass *oc, void *data)
     IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
 
     dc->realize = ipmi_isa_realize;
-    dc->props = ipmi_isa_properties;
+    device_class_set_props(dc, ipmi_isa_properties);
 
     iic->get_backend_data = isa_ipmi_kcs_get_backend_data;
     ipmi_kcs_class_init(iic);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 170792a..f85b484 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -784,7 +784,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
     dc->reset = ich9_lpc_reset;
     k->realize = ich9_lpc_realize;
     dc->vmsd = &vmstate_ich9_lpc;
-    dc->props = ich9_lpc_properties;
+    device_class_set_props(dc, ich9_lpc_properties);
     k->config_write = ich9_lpc_config_write;
     dc->desc = "ICH9 LPC bridge";
     k->vendor_id = PCI_VENDOR_ID_INTEL;
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index b9bd574..0cacbbc 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -342,7 +342,7 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
     dc->realize = pc87312_realize;
     dc->reset = pc87312_reset;
     dc->vmsd = &vmstate_pc87312;
-    dc->props = pc87312_properties;
+    device_class_set_props(dc, pc87312_properties);
 
     sc->parallel = (ISASuperIOFuncs){
         .count = 1,
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index f828708..d9b51fc 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -417,7 +417,7 @@ static void via_pm_class_init(ObjectClass *klass, void *data)
     dc->desc = "PM";
     dc->vmsd = &vmstate_acpi;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    dc->props = via_pm_properties;
+    device_class_set_props(dc, via_pm_properties);
 }
 
 static const TypeInfo via_pm_info = {
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 375f9a5..39f1426 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -202,7 +202,7 @@ static void nvdimm_class_init(ObjectClass *oc, void *data)
 
     ddc->realize = nvdimm_realize;
     mdc->get_memory_region = nvdimm_md_get_memory_region;
-    dc->props = nvdimm_properties;
+    device_class_set_props(dc, nvdimm_properties);
 
     nvc->read_label_data = nvdimm_read_label_data;
     nvc->write_label_data = nvdimm_write_label_data;
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 99e2faf..8f50b8a 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -271,7 +271,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
 
     dc->realize = pc_dimm_realize;
     dc->unrealize = pc_dimm_unrealize;
-    dc->props = pc_dimm_properties;
+    device_class_set_props(dc, pc_dimm_properties);
     dc->desc = "DIMM memory module";
 
     ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index c49868d..92b9b1a 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -178,7 +178,7 @@ static void mips_cps_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = mips_cps_realize;
-    dc->props = mips_cps_properties;
+    device_class_set_props(dc, mips_cps_properties);
 }
 
 static const TypeInfo mips_cps_info = {
diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 45c91db..324371a 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -135,7 +135,7 @@ static void a9_scu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = a9_scu_properties;
+    device_class_set_props(dc, a9_scu_properties);
     dc->vmsd = &vmstate_a9_scu;
     dc->reset = a9_scu_reset;
 }
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 24d57e8..1c4addb 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -353,7 +353,7 @@ static void qdev_applesmc_class_init(ObjectClass *klass, void *data)
 
     dc->realize = applesmc_isa_realize;
     dc->reset = qdev_applesmc_isa_reset;
-    dc->props = applesmc_isa_properties;
+    device_class_set_props(dc, applesmc_isa_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
index 3023284..17c36a0 100644
--- a/hw/misc/arm11scu.c
+++ b/hw/misc/arm11scu.c
@@ -85,7 +85,7 @@ static void arm11_scu_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = arm11_scu_realize;
-    dc->props = arm11_scu_properties;
+    device_class_set_props(dc, arm11_scu_properties);
 }
 
 static const TypeInfo arm11_scu_type_info = {
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index af2c7af..2066c97 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -182,7 +182,7 @@ static void l2x0_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_l2x0;
-    dc->props = l2x0_properties;
+    device_class_set_props(dc, l2x0_properties);
     dc->reset = l2x0_priv_reset;
 }
 
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index fc79522..a474bbd 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -642,7 +642,7 @@ static void arm_sysctl_class_init(ObjectClass *klass, void *data)
     dc->realize = arm_sysctl_realize;
     dc->reset = arm_sysctl_reset;
     dc->vmsd = &vmstate_arm_sysctl;
-    dc->props = arm_sysctl_properties;
+    device_class_set_props(dc, arm_sysctl_properties);
 }
 
 static const TypeInfo arm_sysctl_info = {
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index 8ab15fe..d58138d 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -116,7 +116,7 @@ static void armsse_cpuid_class_init(ObjectClass *klass, void *data)
      * does not need a reset function or VMState.
      */
 
-    dc->props = armsse_cpuid_props;
+    device_class_set_props(dc, armsse_cpuid_props);
 }
 
 static const TypeInfo armsse_cpuid_info = {
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index f62fa25..ce2f956 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -447,7 +447,7 @@ static void aspeed_scu_class_init(ObjectClass *klass, void *data)
     dc->reset = aspeed_scu_reset;
     dc->desc = "ASPEED System Control Unit";
     dc->vmsd = &vmstate_aspeed_scu;
-    dc->props = aspeed_scu_properties;
+    device_class_set_props(dc, aspeed_scu_properties);
 }
 
 static const TypeInfo aspeed_scu_info = {
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 2df3244..9c18479 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -261,7 +261,7 @@ static void aspeed_sdmc_class_init(ObjectClass *klass, void *data)
     dc->reset = aspeed_sdmc_reset;
     dc->desc = "ASPEED SDRAM Memory Controller";
     dc->vmsd = &vmstate_aspeed_sdmc;
-    dc->props = aspeed_sdmc_properties;
+    device_class_set_props(dc, aspeed_sdmc_properties);
 }
 
 static const TypeInfo aspeed_sdmc_info = {
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 0eea2e2..df91280 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -426,7 +426,7 @@ static void bcm2835_property_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = bcm2835_property_props;
+    device_class_set_props(dc, bcm2835_property_props);
     dc->realize = bcm2835_property_realize;
     dc->vmsd = &vmstate_bcm2835_property;
 }
diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index ccf02bd..99a814f 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -65,7 +65,7 @@ static void debug_exit_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = debug_exit_realizefn;
-    dc->props = debug_exit_properties;
+    device_class_set_props(dc, debug_exit_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index 4b1f2b6..aec4473 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -336,7 +336,7 @@ static void ecc_class_init(ObjectClass *klass, void *data)
     dc->realize = ecc_realize;
     dc->reset = ecc_reset;
     dc->vmsd = &vmstate_ecc;
-    dc->props = ecc_properties;
+    device_class_set_props(dc, ecc_properties);
 }
 
 static const TypeInfo ecc_info = {
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 9aa8109..ec1cc19 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -508,7 +508,7 @@ static void iotkit_sysctl_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &iotkit_sysctl_vmstate;
     dc->reset = iotkit_sysctl_reset;
-    dc->props = iotkit_sysctl_props;
+    device_class_set_props(dc, iotkit_sysctl_props);
     dc->realize = iotkit_sysctl_realize;
 }
 
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 783e613..b2dcfc4 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -121,7 +121,7 @@ static void iotkit_sysinfo_class_init(ObjectClass *klass, void *data)
      * does not need a reset function or VMState.
      */
 
-    dc->props = iotkit_sysinfo_props;
+    device_class_set_props(dc, iotkit_sysinfo_props);
 }
 
 static const TypeInfo iotkit_sysinfo_info = {
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 710cdb72..1a0fad7 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1055,7 +1055,7 @@ static void ivshmem_plain_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = ivshmem_plain_realize;
-    dc->props = ivshmem_plain_properties;
+    device_class_set_props(dc, ivshmem_plain_properties);
     dc->vmsd = &ivshmem_plain_vmsd;
 }
 
@@ -1115,7 +1115,7 @@ static void ivshmem_doorbell_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = ivshmem_doorbell_realize;
-    dc->props = ivshmem_doorbell_properties;
+    device_class_set_props(dc, ivshmem_doorbell_properties);
     dc->vmsd = &ivshmem_doorbell_vmsd;
 }
 
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index e9e6a95..b7d0012 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1021,7 +1021,7 @@ static void mac_via_class_init(ObjectClass *oc, void *data)
     dc->realize = mac_via_realize;
     dc->reset = mac_via_reset;
     dc->vmsd = &vmstate_mac_via;
-    dc->props = mac_via_properties;
+    device_class_set_props(dc, mac_via_properties);
 }
 
 static TypeInfo mac_via_info = {
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index e38becb..e0cc0aa 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -571,7 +571,7 @@ static void cuda_class_init(ObjectClass *oc, void *data)
     dc->realize = cuda_realize;
     dc->reset = cuda_reset;
     dc->vmsd = &vmstate_cuda;
-    dc->props = cuda_properties;
+    device_class_set_props(dc, cuda_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 50f20d8..7922219 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -466,7 +466,7 @@ static void macio_newworld_class_init(ObjectClass *oc, void *data)
     pdc->realize = macio_newworld_realize;
     pdc->device_id = PCI_DEVICE_ID_APPLE_UNI_N_KEYL;
     dc->vmsd = &vmstate_macio_newworld;
-    dc->props = macio_newworld_properties;
+    device_class_set_props(dc, macio_newworld_properties);
 }
 
 static Property macio_properties[] = {
@@ -481,7 +481,7 @@ static void macio_class_init(ObjectClass *klass, void *data)
 
     k->vendor_id = PCI_VENDOR_ID_APPLE;
     k->class_id = PCI_CLASS_OTHERS << 8;
-    dc->props = macio_properties;
+    device_class_set_props(dc, macio_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     /* Reason: Uses serial_hds in macio_instance_init */
     dc->user_creatable = false;
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 769aed8..b8466a4 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -795,7 +795,7 @@ static void pmu_class_init(ObjectClass *oc, void *data)
     dc->realize = pmu_realize;
     dc->reset = pmu_reset;
     dc->vmsd = &vmstate_pmu;
-    dc->props = pmu_properties;
+    device_class_set_props(dc, pmu_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 8176d91..3c8b37f 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -233,7 +233,7 @@ static void mips_gcr_realize(DeviceState *dev, Error **errp)
 static void mips_gcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    dc->props = mips_gcr_properties;
+    device_class_set_props(dc, mips_gcr_properties);
     dc->vmsd = &vmstate_mips_gcr;
     dc->reset = mips_gcr_reset;
     dc->realize = mips_gcr_realize;
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 19ea016..2f7b2c9 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -175,7 +175,7 @@ static void mips_cpc_class_init(ObjectClass *klass, void *data)
     dc->realize = mips_cpc_realize;
     dc->reset = mips_cpc_reset;
     dc->vmsd = &vmstate_mips_cpc;
-    dc->props = mips_cpc_properties;
+    device_class_set_props(dc, mips_cpc_properties);
 }
 
 static const TypeInfo mips_cpc_info = {
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index ea0cf97..3540985 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -561,7 +561,7 @@ static void mips_itu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = mips_itu_properties;
+    device_class_set_props(dc, mips_itu_properties);
     dc->realize = mips_itu_realize;
     dc->reset = mips_itu_reset;
 }
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 10b85bf..19e154b 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -502,7 +502,7 @@ static void mos6522_class_init(ObjectClass *oc, void *data)
 
     dc->reset = mos6522_reset;
     dc->vmsd = &vmstate_mos6522;
-    dc->props = mos6522_properties;
+    device_class_set_props(dc, mos6522_properties);
     mdc->parent_reset = dc->reset;
     mdc->set_sr_int = mos6522_set_sr_int;
     mdc->portB_write = mos6522_portB_write;
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 5e8b103..2f3fbee 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -300,7 +300,7 @@ static void mps2_fpgaio_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &mps2_fpgaio_vmstate;
     dc->reset = mps2_fpgaio_reset;
-    dc->props = mps2_fpgaio_properties;
+    device_class_set_props(dc, mps2_fpgaio_properties);
 }
 
 static const TypeInfo mps2_fpgaio_info = {
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 25779a1..9d0909e 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -293,7 +293,7 @@ static void mps2_scc_class_init(ObjectClass *klass, void *data)
     dc->realize = mps2_scc_realize;
     dc->vmsd = &mps2_scc_vmstate;
     dc->reset = mps2_scc_reset;
-    dc->props = mps2_scc_properties;
+    device_class_set_props(dc, mps2_scc_properties);
 }
 
 static const TypeInfo mps2_scc_info = {
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index ddc5a30..2dce55c 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -143,7 +143,7 @@ static void msf2_sysreg_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_msf2_sysreg;
     dc->reset = msf2_sysreg_reset;
-    dc->props = msf2_sysreg_properties;
+    device_class_set_props(dc, msf2_sysreg_properties);
     dc->realize = msf2_sysreg_realize;
 }
 
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index 5140981..fc86e1b 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -245,7 +245,7 @@ static void nrf51_rng_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = nrf51_rng_properties;
+    device_class_set_props(dc, nrf51_rng_properties);
     dc->vmsd = &vmstate_rng;
     dc->reset = nrf51_rng_reset;
 }
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 74d8571..188de4d 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -339,7 +339,7 @@ static void pci_testdev_class_init(ObjectClass *klass, void *data)
     dc->desc = "PCI Test Device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->reset = qdev_pci_testdev_reset;
-    dc->props = pci_testdev_properties;
+    device_class_set_props(dc, pci_testdev_properties);
 }
 
 static const TypeInfo pci_testdev_info = {
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 4ebda78..abb10bb 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -118,7 +118,7 @@ static void pvpanic_isa_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pvpanic_isa_realizefn;
-    dc->props = pvpanic_isa_properties;
+    device_class_set_props(dc, pvpanic_isa_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 49dd605..98f1512 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -596,7 +596,7 @@ static void tz_mpc_class_init(ObjectClass *klass, void *data)
     dc->realize = tz_mpc_realize;
     dc->vmsd = &tz_mpc_vmstate;
     dc->reset = tz_mpc_reset;
-    dc->props = tz_mpc_properties;
+    device_class_set_props(dc, tz_mpc_properties);
 }
 
 static const TypeInfo tz_mpc_info = {
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index 7d522ac..acbe944 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -293,7 +293,7 @@ static void tz_msc_class_init(ObjectClass *klass, void *data)
     dc->realize = tz_msc_realize;
     dc->vmsd = &tz_msc_vmstate;
     dc->reset = tz_msc_reset;
-    dc->props = tz_msc_properties;
+    device_class_set_props(dc, tz_msc_properties);
 }
 
 static const TypeInfo tz_msc_info = {
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 181a5f1..6431257 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -319,7 +319,7 @@ static void tz_ppc_class_init(ObjectClass *klass, void *data)
     dc->realize = tz_ppc_realize;
     dc->vmsd = &tz_ppc_vmstate;
     dc->reset = tz_ppc_reset;
-    dc->props = tz_ppc_properties;
+    device_class_set_props(dc, tz_ppc_properties);
 }
 
 static const TypeInfo tz_ppc_info = {
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 0e1cb24..bc4084d 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -79,7 +79,7 @@ static void unimp_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = unimp_realize;
-    dc->props = unimp_properties;
+    device_class_set_props(dc, unimp_properties);
 }
 
 static const TypeInfo unimp_info = {
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index e055a66..e9bbff8 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -519,7 +519,7 @@ static void aw_emac_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aw_emac_realize;
-    dc->props = aw_emac_properties;
+    device_class_set_props(dc, aw_emac_properties);
     dc->reset = aw_emac_reset;
     dc->vmsd = &vmstate_aw_emac;
 }
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index b8be73d..871fcf2 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1627,7 +1627,7 @@ static void gem_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = gem_realize;
-    dc->props = gem_properties;
+    device_class_set_props(dc, gem_properties);
     dc->vmsd = &vmstate_cadence_gem;
     dc->reset = gem_reset;
 }
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index cdc2631..a134d43 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -963,7 +963,7 @@ static void dp8393x_class_init(ObjectClass *klass, void *data)
     dc->realize = dp8393x_realize;
     dc->reset = dp8393x_reset;
     dc->vmsd = &vmstate_dp8393x;
-    dc->props = dp8393x_properties;
+    device_class_set_props(dc, dp8393x_properties);
 }
 
 static const TypeInfo dp8393x_info = {
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index a73f8d4..0b833d5 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1764,7 +1764,7 @@ static void e1000_class_init(ObjectClass *klass, void *data)
     dc->desc = "Intel Gigabit Ethernet";
     dc->reset = qdev_e1000_reset;
     dc->vmsd = &vmstate_e1000;
-    dc->props = e1000_properties;
+    device_class_set_props(dc, e1000_properties);
 }
 
 static void e1000_instance_init(Object *obj)
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index b69fd7d..a91dbdc 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -684,7 +684,6 @@ static void e1000e_class_init(ObjectClass *class, void *data)
     dc->desc = "Intel 82574L GbE Controller";
     dc->reset = e1000e_qdev_reset;
     dc->vmsd = &e1000e_vmstate;
-    dc->props = e1000e_properties;
 
     e1000e_prop_disable_vnet = qdev_prop_uint8;
     e1000e_prop_disable_vnet.description = "Do not use virtio headers, "
@@ -697,6 +696,7 @@ static void e1000e_class_init(ObjectClass *class, void *data)
     e1000e_prop_subsys = qdev_prop_uint16;
     e1000e_prop_subsys.description = "PCI device Subsystem ID";
 
+    device_class_set_props(dc, e1000e_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 6cc9776..f6474f0 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -2060,7 +2060,7 @@ static void eepro100_class_init(ObjectClass *klass, void *data)
     info = eepro100_get_class_by_name(object_class_get_name(klass));
 
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
-    dc->props = e100_properties;
+    device_class_set_props(dc, e100_properties);
     dc->desc = info->desc;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index f30d963..27fd069 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -639,7 +639,7 @@ static void etraxfs_eth_class_init(ObjectClass *klass, void *data)
 
     dc->realize = etraxfs_eth_realize;
     dc->reset = etraxfs_eth_reset;
-    dc->props = etraxfs_eth_properties;
+    device_class_set_props(dc, etraxfs_eth_properties);
     /* Reason: dma_out, dma_in are not user settable */
     dc->user_creatable = false;
 }
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 717de76..475f3c8 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -423,7 +423,7 @@ static void etsec_class_init(ObjectClass *klass, void *data)
 
     dc->realize = etsec_realize;
     dc->reset = etsec_reset;
-    dc->props = etsec_properties;
+    device_class_set_props(dc, etsec_properties);
     /* Supported by ppce500 machine */
     dc->user_creatable = true;
 }
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 86ac258..4ad2594 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1075,7 +1075,7 @@ static void ftgmac100_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_ftgmac100;
     dc->reset = ftgmac100_reset;
-    dc->props = ftgmac100_properties;
+    device_class_set_props(dc, ftgmac100_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->realize = ftgmac100_realize;
     dc->desc = "Faraday FTGMAC100 Gigabit Ethernet emulation";
@@ -1237,7 +1237,7 @@ static void aspeed_mii_class_init(ObjectClass *klass, void *data)
     dc->reset = aspeed_mii_reset;
     dc->realize = aspeed_mii_realize;
     dc->desc = "Aspeed MII controller";
-    dc->props = aspeed_mii_properties;
+    device_class_set_props(dc, aspeed_mii_properties);
 }
 
 static const TypeInfo aspeed_mii_info = {
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 5a83678..6a124a1 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1338,7 +1338,7 @@ static void imx_eth_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd    = &vmstate_imx_eth;
     dc->reset   = imx_eth_reset;
-    dc->props   = imx_eth_properties;
+    device_class_set_props(dc, imx_eth_properties);
     dc->realize = imx_eth_realize;
     dc->desc    = "i.MX FEC/ENET Ethernet Controller";
 }
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index ed551f2..da7e0bb 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1369,7 +1369,7 @@ static void lan9118_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = lan9118_reset;
-    dc->props = lan9118_properties;
+    device_class_set_props(dc, lan9118_properties);
     dc->vmsd = &vmstate_lan9118;
     dc->realize = lan9118_realize;
 }
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 4d96299..688724d 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -153,7 +153,7 @@ static void lance_class_init(ObjectClass *klass, void *data)
     dc->fw_name = "ethernet";
     dc->reset = lance_reset;
     dc->vmsd = &vmstate_lance;
-    dc->props = lance_properties;
+    device_class_set_props(dc, lance_properties);
 }
 
 static const TypeInfo lance_info = {
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 8fcf354..9327ac8 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -670,7 +670,7 @@ static void mcf_fec_class_init(ObjectClass *oc, void *data)
     dc->realize = mcf_fec_realize;
     dc->desc = "MCF Fast Ethernet Controller network device";
     dc->reset = mcf_fec_reset;
-    dc->props = mcf_fec_properties;
+    device_class_set_props(dc, mcf_fec_properties);
 }
 
 static const TypeInfo mcf_fec_info = {
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 86b6d28..1ba0175 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -530,7 +530,7 @@ static void milkymist_minimac2_class_init(ObjectClass *klass, void *data)
     dc->realize = milkymist_minimac2_realize;
     dc->reset = milkymist_minimac2_reset;
     dc->vmsd = &vmstate_milkymist_minimac2;
-    dc->props = milkymist_minimac2_properties;
+    device_class_set_props(dc, milkymist_minimac2_properties);
 }
 
 static const TypeInfo milkymist_minimac2_info = {
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 380ff5a..0c578c4 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -278,7 +278,7 @@ static void mipsnet_class_init(ObjectClass *klass, void *data)
     dc->desc = "MIPS Simulator network device";
     dc->reset = mipsnet_sysbus_reset;
     dc->vmsd = &vmstate_mipsnet;
-    dc->props = mipsnet_properties;
+    device_class_set_props(dc, mipsnet_properties);
 }
 
 static const TypeInfo mipsnet_info = {
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 6fcf3d5..e744eff 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -89,7 +89,7 @@ static void isa_ne2000_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = isa_ne2000_realizefn;
-    dc->props = ne2000_isa_properties;
+    device_class_set_props(dc, ne2000_isa_properties);
     dc->vmsd = &vmstate_isa_ne2000;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index 9a20d42..e11d67b 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -112,7 +112,7 @@ static void ne2000_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_REALTEK_8029;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     dc->vmsd = &vmstate_pci_ne2000;
-    dc->props = ne2000_properties;
+    device_class_set_props(dc, ne2000_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 84a95da..6b338c2 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -755,7 +755,7 @@ static void open_eth_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->desc = "Opencores 10/100 Mbit Ethernet";
     dc->reset = qdev_open_eth_reset;
-    dc->props = open_eth_properties;
+    device_class_set_props(dc, open_eth_properties);
 }
 
 static const TypeInfo open_eth_info = {
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index d067d21..d1f31e0 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -272,7 +272,7 @@ static void pcnet_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     dc->reset = pci_reset;
     dc->vmsd = &vmstate_pci_pcnet;
-    dc->props = pcnet_properties;
+    device_class_set_props(dc, pcnet_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 50f9e33..81dd3b5 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1519,7 +1519,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->desc = "Rocker Switch";
     dc->reset = rocker_reset;
-    dc->props = rocker_properties;
+    device_class_set_props(dc, rocker_properties);
     dc->vmsd = &rocker_vmsd;
 }
 
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 88a97d7..ae4739b 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3435,7 +3435,7 @@ static void rtl8139_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     dc->reset = rtl8139_reset;
     dc->vmsd = &vmstate_rtl8139;
-    dc->props = rtl8139_properties;
+    device_class_set_props(dc, rtl8139_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index e574635..e9eb6f6 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -798,7 +798,7 @@ static void smc91c111_class_init(ObjectClass *klass, void *data)
     dc->realize = smc91c111_realize;
     dc->reset = smc91c111_reset;
     dc->vmsd = &vmstate_smc91c111;
-    dc->props = smc91c111_properties;
+    device_class_set_props(dc, smc91c111_properties);
 }
 
 static const TypeInfo smc91c111_info = {
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 3d96884..80f5a1d 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -856,7 +856,7 @@ static void spapr_vlan_class_init(ObjectClass *klass, void *data)
     k->dt_compatible = "IBM,l-lan";
     k->signal_mask = 0x1;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
-    dc->props = spapr_vlan_properties;
+    device_class_set_props(dc, spapr_vlan_properties);
     k->rtce_window_size = 0x10000000;
     dc->vmsd = &vmstate_spapr_llan;
 }
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 3aca2a0..cb6e250 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -507,7 +507,7 @@ static void stellaris_enet_class_init(ObjectClass *klass, void *data)
 
     dc->realize = stellaris_enet_realize;
     dc->reset = stellaris_enet_reset;
-    dc->props = stellaris_enet_properties;
+    device_class_set_props(dc, stellaris_enet_properties);
     dc->vmsd = &vmstate_stellaris_enet;
 }
 
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index f31d41a..89da51f 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1429,7 +1429,7 @@ static void sungem_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     dc->vmsd = &vmstate_sungem;
     dc->reset = sungem_reset;
-    dc->props = sungem_properties;
+    device_class_set_props(dc, sungem_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 2243b7c..8863601 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -958,7 +958,7 @@ static void sunhme_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     dc->vmsd = &vmstate_hme;
     dc->reset = sunhme_reset;
-    dc->props = sunhme_properties;
+    device_class_set_props(dc, sunhme_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index f85f543..cfac271 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -1004,7 +1004,7 @@ static void tulip_class_init(ObjectClass *klass, void *data)
     k->subsystem_id = 0x104f;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     dc->vmsd = &vmstate_pci_tulip;
-    dc->props = tulip_properties;
+    device_class_set_props(dc, tulip_properties);
     dc->reset = tulip_qdev_reset;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d7d3ad6..3627bb1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3236,7 +3236,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
-    dc->props = virtio_net_properties;
+    device_class_set_props(dc, virtio_net_properties);
     dc->vmsd = &vmstate_virtio_net;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     vdc->realize = virtio_net_device_realize;
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 39ff662..6d91cd8 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2506,7 +2506,7 @@ static void vmxnet3_class_init(ObjectClass *class, void *data)
     dc->desc = "VMWare Paravirtualized Ethernet v3";
     dc->reset = vmxnet3_qdev_reset;
     dc->vmsd = &vmstate_vmxnet3;
-    dc->props = vmxnet3_properties;
+    device_class_set_props(dc, vmxnet3_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 2ea8d2e..574dd47 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -414,7 +414,7 @@ static void xgmac_enet_class_init(ObjectClass *klass, void *data)
 
     dc->realize = xgmac_enet_realize;
     dc->vmsd = &vmstate_xgmac;
-    dc->props = xgmac_properties;
+    device_class_set_props(dc, xgmac_properties);
 }
 
 static const TypeInfo xgmac_enet_info = {
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 2c8c065..7047888 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -1025,7 +1025,7 @@ static void xilinx_enet_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = xilinx_enet_realize;
-    dc->props = xilinx_enet_properties;
+    device_class_set_props(dc, xilinx_enet_properties);
     dc->reset = xilinx_axienet_reset;
 }
 
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 384e72b..cf07e69 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -262,7 +262,7 @@ static void xilinx_ethlite_class_init(ObjectClass *klass, void *data)
 
     dc->realize = xilinx_ethlite_realize;
     dc->reset = xilinx_ethlite_reset;
-    dc->props = xilinx_ethlite_properties;
+    device_class_set_props(dc, xilinx_ethlite_properties);
 }
 
 static const TypeInfo xilinx_ethlite_info = {
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 934e09b..d5cb922 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -153,7 +153,7 @@ static void nvram_sysbus_class_init(ObjectClass *klass, void *data)
 
     dc->realize = nvram_sysbus_realize;
     dc->vmsd = &vmstate_nvram;
-    dc->props = nvram_sysbus_properties;
+    device_class_set_props(dc, nvram_sysbus_properties);
 }
 
 static const TypeInfo nvram_sysbus_info = {
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 3416367..d46a2be 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -182,7 +182,7 @@ void at24c_eeprom_class_init(ObjectClass *klass, void *data)
     k->recv = &at24c_eeprom_recv;
     k->send = &at24c_eeprom_send;
 
-    dc->props = at24c_eeprom_props;
+    device_class_set_props(dc, at24c_eeprom_props);
     dc->reset = at24c_eeprom_reset;
 }
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 5d879c4..179b302 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1171,7 +1171,7 @@ static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = fw_cfg_io_realize;
-    dc->props = fw_cfg_io_properties;
+    device_class_set_props(dc, fw_cfg_io_properties);
 }
 
 static const TypeInfo fw_cfg_io_info = {
@@ -1234,7 +1234,7 @@ static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = fw_cfg_mem_realize;
-    dc->props = fw_cfg_mem_properties;
+    device_class_set_props(dc, fw_cfg_mem_properties);
 }
 
 static const TypeInfo fw_cfg_mem_info = {
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index 9a47e35..2e8a1e3 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -128,7 +128,7 @@ static void macio_nvram_class_init(ObjectClass *oc, void *data)
     dc->unrealize = macio_nvram_unrealizefn;
     dc->reset = macio_nvram_reset;
     dc->vmsd = &vmstate_macio_nvram;
-    dc->props = macio_nvram_properties;
+    device_class_set_props(dc, macio_nvram_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index 4d678f9..f2283c1 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -369,7 +369,7 @@ static void nrf51_nvm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = nrf51_nvm_properties;
+    device_class_set_props(dc, nrf51_nvm_properties);
     dc->vmsd = &vmstate_nvm;
     dc->realize = nrf51_nvm_realize;
     dc->reset = nrf51_nvm_reset;
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 838082b..877ddef 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -269,7 +269,7 @@ static void spapr_nvram_class_init(ObjectClass *klass, void *data)
     k->dt_type = "nvram";
     k->dt_compatible = "qemu,spapr-nvram";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props = spapr_nvram_properties;
+    device_class_set_props(dc, spapr_nvram_properties);
     dc->vmsd = &vmstate_spapr_nvram;
     /* Reason: Internal device only, uses spapr_rtas_register() in realize() */
     dc->user_creatable = false;
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 9eaefeb..bb26e27 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -147,7 +147,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_RP;
     dc->desc = "PCI Express Root Port";
     dc->vmsd = &vmstate_rp_dev;
-    dc->props = gen_rp_props;
+    device_class_set_props(dc, gen_rp_props);
 
     device_class_set_parent_realize(dc, gen_rp_realize, &rpc->parent_realize);
 
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index cc80cb4..4a080b7 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -258,7 +258,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
     k->is_bridge = true;
     dc->desc = "Standard PCI Bridge";
     dc->reset = qdev_pci_bridge_dev_reset;
-    dc->props = pci_bridge_dev_properties;
+    device_class_set_props(dc, pci_bridge_dev_properties);
     dc->vmsd = &pci_bridge_dev_vmstate;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hc->plug = pci_bridge_dev_plug_cb;
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 0592818..47aaaf8 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -309,7 +309,7 @@ static void pxb_dev_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_BRIDGE_HOST;
 
     dc->desc = "PCI Expander Bridge";
-    dc->props = pxb_dev_properties;
+    device_class_set_props(dc, pxb_dev_properties);
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
@@ -347,7 +347,7 @@ static void pxb_pcie_dev_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_BRIDGE_HOST;
 
     dc->desc = "PCI Express Expander Bridge";
-    dc->props = pxb_dev_properties;
+    device_class_set_props(dc, pxb_dev_properties);
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 7679bef..eade133 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -152,7 +152,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     k->exit = pcie_pci_bridge_exit;
     k->config_write = pcie_pci_bridge_write_config;
     dc->vmsd = &pcie_pci_bridge_dev_vmstate;
-    dc->props = pcie_pci_bridge_dev_properties;
+    device_class_set_props(dc, pcie_pci_bridge_dev_properties);
     dc->reset = &pcie_pci_bridge_reset;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hc->plug = pci_bridge_dev_plug_cb;
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 012c2cb..0ba4e4d 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -174,7 +174,7 @@ static void rp_class_init(ObjectClass *klass, void *data)
     k->exit = rp_exit;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->reset = rp_reset;
-    dc->props = rp_props;
+    device_class_set_props(dc, rp_props);
 }
 
 static const TypeInfo rp_info = {
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index a9f084b..153a4ac 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -169,7 +169,7 @@ static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
     dc->desc = "TI X3130 Downstream Port of PCI Express Switch";
     dc->reset = xio3130_downstream_reset;
     dc->vmsd = &vmstate_xio3130_downstream;
-    dc->props = xio3130_downstream_props;
+    device_class_set_props(dc, xio3130_downstream_props);
 }
 
 static const TypeInfo xio3130_downstream_info = {
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 537273e..24ccdf6 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -168,7 +168,7 @@ static void grackle_class_init(ObjectClass *klass, void *data)
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
 
     dc->realize = grackle_realize;
-    dc->props = grackle_properties;
+    device_class_set_props(dc, grackle_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     sbc->explicit_ofw_unit_address = grackle_ofw_unit_address;
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index bae7b42..11050a0 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -396,7 +396,7 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
     hc->root_bus_path = i440fx_pcihost_root_bus_path;
     dc->realize = i440fx_pcihost_realize;
     dc->fw_name = "pci";
-    dc->props = i440fx_props;
+    device_class_set_props(dc, i440fx_props);
     /* Reason: needs to be wired up by pc_init1 */
     dc->user_creatable = false;
 }
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 8bed8e8..d710727 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -531,7 +531,7 @@ static void e500_pcihost_class_init(ObjectClass *klass, void *data)
 
     dc->realize = e500_pcihost_realize;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    dc->props = pcihost_properties;
+    device_class_set_props(dc, pcihost_properties);
     dc->vmsd = &vmstate_ppce500_pci;
 }
 
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index afa136d..f2f8821 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -415,7 +415,7 @@ static void raven_pcihost_class_init(ObjectClass *klass, void *data)
 
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->realize = raven_pcihost_realizefn;
-    dc->props = raven_pcihost_properties;
+    device_class_set_props(dc, raven_pcihost_properties);
     dc->fw_name = "pci";
 }
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 158d270..0d5dbba 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -202,7 +202,7 @@ static void q35_host_class_init(ObjectClass *klass, void *data)
 
     hc->root_bus_path = q35_host_root_bus_path;
     dc->realize = q35_host_realize;
-    dc->props = q35_host_props;
+    device_class_set_props(dc, q35_host_props);
     /* Reason: needs to be wired up by pc_q35_init */
     dc->user_creatable = false;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
@@ -612,7 +612,7 @@ static void mch_class_init(ObjectClass *klass, void *data)
     k->realize = mch_realize;
     k->config_write = mch_write_config;
     dc->reset = mch_reset;
-    dc->props = mch_props;
+    device_class_set_props(dc, mch_props);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "Host bridge";
     dc->vmsd = &vmstate_mch;
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index fae20ee..2b8503b 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -521,7 +521,7 @@ static void sabre_class_init(ObjectClass *klass, void *data)
 
     dc->realize = sabre_realize;
     dc->reset = sabre_reset;
-    dc->props = sabre_properties;
+    device_class_set_props(dc, sabre_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     sbc->explicit_ofw_unit_address = sabre_ofw_unit_address;
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 75bc506..cf70b76 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -476,7 +476,7 @@ static void pci_unin_main_class_init(ObjectClass *klass, void *data)
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
 
     dc->realize = pci_unin_main_realize;
-    dc->props = pci_unin_main_pci_host_props;
+    device_class_set_props(dc, pci_unin_main_pci_host_props);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     sbc->explicit_ofw_unit_address = pci_unin_main_ofw_unit_address;
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index b731d05..cfb9a78 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -509,7 +509,7 @@ static void pci_vpb_class_init(ObjectClass *klass, void *data)
     dc->realize = pci_vpb_realize;
     dc->reset = pci_vpb_reset;
     dc->vmsd = &pci_vpb_vmstate;
-    dc->props = pci_vpb_properties;
+    device_class_set_props(dc, pci_vpb_properties);
 }
 
 static const TypeInfo pci_vpb_info = {
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 17d5024..e06f2b5 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -177,7 +177,7 @@ static void xilinx_pcie_host_class_init(ObjectClass *klass, void *data)
     dc->realize = xilinx_pcie_host_realize;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
-    dc->props = xilinx_pcie_host_props;
+    device_class_set_props(dc, xilinx_pcie_host_props);
 }
 
 static const TypeInfo xilinx_pcie_host_info = {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3ac7961..e1ed667 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2624,7 +2624,7 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
     k->realize = pci_qdev_realize;
     k->unrealize = pci_qdev_unrealize;
     k->bus_type = TYPE_PCI_BUS;
-    k->props = pci_props;
+    device_class_set_props(k, pci_props);
 }
 
 static void pci_device_class_base_init(ObjectClass *klass, void *data)
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index c19a9be..f8263cb 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -133,7 +133,7 @@ static void pcie_port_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->props = pcie_port_props;
+    device_class_set_props(dc, pcie_port_props);
 }
 
 static const TypeInfo pcie_port_type_info = {
@@ -155,7 +155,7 @@ static void pcie_slot_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
-    dc->props = pcie_slot_props;
+    device_class_set_props(dc, pcie_slot_props);
     hc->pre_plug = pcie_cap_slot_pre_plug_cb;
     hc->plug = pcie_cap_slot_plug_cb;
     hc->unplug = pcie_cap_slot_unplug_cb;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e2735bb..e61994c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1614,7 +1614,7 @@ static void pnv_chip_class_init(ObjectClass *klass, void *data)
 
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = pnv_chip_realize;
-    dc->props = pnv_chip_properties;
+    device_class_set_props(dc, pnv_chip_properties);
     dc->desc = "PowerNV Chip";
 }
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 2651044..8ca5fbd 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -323,7 +323,7 @@ static void pnv_core_class_init(ObjectClass *oc, void *data)
 
     dc->realize = pnv_core_realize;
     dc->unrealize = pnv_core_unrealize;
-    dc->props = pnv_core_properties;
+    device_class_set_props(dc, pnv_core_properties);
 }
 
 #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
@@ -421,7 +421,7 @@ static void pnv_quad_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = pnv_quad_realize;
-    dc->props = pnv_quad_properties;
+    device_class_set_props(dc, pnv_quad_properties);
 }
 
 static const TypeInfo pnv_quad_info = {
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index a08b791..93ae42f 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -359,7 +359,7 @@ static void pnv_homer_class_init(ObjectClass *klass, void *data)
 
     dc->realize = pnv_homer_realize;
     dc->desc = "PowerNV HOMER Memory";
-    dc->props = pnv_homer_properties;
+    device_class_set_props(dc, pnv_homer_properties);
 }
 
 static const TypeInfo pnv_homer_type_info = {
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 18256d9..22b2055 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -761,7 +761,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, void *data)
 
     dc->realize = pnv_lpc_realize;
     dc->desc = "PowerNV LPC Controller";
-    dc->props = pnv_lpc_properties;
+    device_class_set_props(dc, pnv_lpc_properties);
 }
 
 static const TypeInfo pnv_lpc_info = {
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 924fdab..2173fac 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -279,7 +279,7 @@ static void pnv_occ_class_init(ObjectClass *klass, void *data)
 
     dc->realize = pnv_occ_realize;
     dc->desc = "PowerNV OCC Controller";
-    dc->props = pnv_occ_properties;
+    device_class_set_props(dc, pnv_occ_properties);
 }
 
 static const TypeInfo pnv_occ_type_info = {
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index b061106..f761d8d 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -121,7 +121,7 @@ static void pnv_pnor_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pnv_pnor_realize;
-    dc->props = pnv_pnor_properties;
+    device_class_set_props(dc, pnv_pnor_properties);
 }
 
 static const TypeInfo pnv_pnor_info = {
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 1d8da31..6baf950 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -937,7 +937,7 @@ static void pnv_psi_class_init(ObjectClass *klass, void *data)
     xdc->dt_xscom = pnv_psi_dt_xscom;
 
     dc->desc = "PowerNV PSI Controller";
-    dc->props = pnv_psi_properties;
+    device_class_set_props(dc, pnv_psi_properties);
     dc->reset = pnv_psi_reset;
 }
 
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 95475c9..1a6a8fa 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1296,7 +1296,7 @@ static void ppc460ex_pcie_class_init(ObjectClass *klass, void *data)
 
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->realize = ppc460ex_pcie_realize;
-    dc->props = ppc460ex_pcie_props;
+    device_class_set_props(dc, ppc460ex_pcie_props);
     dc->hotpluggable = false;
 }
 
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 86e83e2..bbc51b6 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -289,7 +289,7 @@ static void prep_systemio_class_initfn(ObjectClass *klass, void *data)
 
     dc->realize = prep_systemio_realize;
     dc->vmsd = &vmstate_prep_systemio;
-    dc->props = prep_systemio_properties;
+    device_class_set_props(dc, prep_systemio_properties);
 }
 
 static TypeInfo prep_systemio800_info = {
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index 66b14db..f8a498b 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -222,7 +222,7 @@ static void rs6000mc_class_initfn(ObjectClass *klass, void *data)
 
     dc->realize = rs6000mc_realize;
     dc->vmsd = &vmstate_rs6000mc;
-    dc->props = rs6000mc_properties;
+    device_class_set_props(dc, rs6000mc_properties);
 }
 
 static const TypeInfo rs6000mc_info = {
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 8339c4c..d09125d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -383,7 +383,7 @@ static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
     dc->realize = spapr_cpu_core_realize;
     dc->unrealize = spapr_cpu_core_unrealize;
     dc->reset = spapr_cpu_core_reset;
-    dc->props = spapr_cpu_core_properties;
+    device_class_set_props(dc, spapr_cpu_core_properties);
     scc->cpu_type = data;
 }
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 723373d..e82bfc5 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2217,7 +2217,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
     hc->root_bus_path = spapr_phb_root_bus_path;
     dc->realize = spapr_phb_realize;
     dc->unrealize = spapr_phb_unrealize;
-    dc->props = spapr_phb_properties;
+    device_class_set_props(dc, spapr_phb_properties);
     dc->reset = spapr_phb_reset;
     dc->vmsd = &vmstate_spapr_pci;
     /* Supported by TYPE_SPAPR_MACHINE */
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 954e4ae..e8e8d65 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -146,7 +146,7 @@ static void spapr_rng_class_init(ObjectClass *oc, void *data)
 
     dc->realize = spapr_rng_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props = spapr_rng_properties;
+    device_class_set_props(dc, spapr_rng_properties);
     dc->hotpluggable = false;
 }
 
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index ca1caec..991615d 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -159,7 +159,7 @@ static void spapr_tpm_proxy_class_init(ObjectClass *k, void *data)
     dk->realize = spapr_tpm_proxy_realize;
     dk->unrealize = spapr_tpm_proxy_unrealize;
     dk->user_creatable = true;
-    dk->props = spapr_tpm_proxy_properties;
+    device_class_set_props(dk, spapr_tpm_proxy_properties);
 }
 
 static const TypeInfo spapr_tpm_proxy_info = {
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 6f0fc40..3254aad 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -690,7 +690,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_NETWORK_OTHER;
 
     dc->desc = "RDMA Device";
-    dc->props = pvrdma_dev_properties;
+    device_class_set_props(dc, pvrdma_dev_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 
     ir->print_statistics = pvrdma_print_statistics;
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 5b98227..276a9ba 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -74,7 +74,7 @@ static void riscv_harts_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = riscv_harts_props;
+    device_class_set_props(dc, riscv_harts_props);
     dc->realize = riscv_harts_realize;
 }
 
diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index e5a8f75..e2feee8 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -205,7 +205,7 @@ static void sifive_clint_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = sifive_clint_realize;
-    dc->props = sifive_clint_properties;
+    device_class_set_props(dc, sifive_clint_properties);
 }
 
 static const TypeInfo sifive_clint_info = {
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 98e4304..c1e04cb 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -466,7 +466,7 @@ static void sifive_plic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = sifive_plic_properties;
+    device_class_set_props(dc, sifive_plic_properties);
     dc->realize = sifive_plic_realize;
 }
 
diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
index ea0eee5..f6ecbaa 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/riscv/sifive_u_otp.c
@@ -171,7 +171,7 @@ static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = sifive_u_otp_properties;
+    device_class_set_props(dc, sifive_u_otp_properties);
     dc->realize = sifive_u_otp_realize;
     dc->reset = sifive_u_otp_reset;
 }
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 7fde854..131eb5b 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -137,7 +137,7 @@ static void m48txx_isa_class_init(ObjectClass *klass, void *data)
 
     dc->realize = m48t59_isa_realize;
     dc->reset = m48t59_reset_isa;
-    dc->props = m48t59_isa_properties;
+    device_class_set_props(dc, m48t59_isa_properties);
     nc->read = m48txx_isa_read;
     nc->write = m48txx_isa_write;
     nc->toggle_lock = m48txx_isa_toggle_lock;
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index fc592b9..1269134 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -667,7 +667,7 @@ static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
 
     dc->realize = m48t59_realize;
     dc->reset = m48t59_reset_sysbus;
-    dc->props = m48t59_sysbus_properties;
+    device_class_set_props(dc, m48t59_sysbus_properties);
     dc->vmsd = &vmstate_m48t59;
     nc->read = m48txx_sysbus_read;
     nc->write = m48txx_sysbus_write;
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 74ae74b..dc4269c 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -1015,7 +1015,7 @@ static void rtc_class_initfn(ObjectClass *klass, void *data)
     dc->realize = rtc_realizefn;
     dc->reset = rtc_resetdev;
     dc->vmsd = &vmstate_rtc;
-    dc->props = mc146818rtc_properties;
+    device_class_set_props(dc, mc146818rtc_properties);
 }
 
 static const TypeInfo mc146818rtc_info = {
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index c57cf83..ae47f09 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -321,7 +321,7 @@ static void pl031_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_pl031;
-    dc->props = pl031_properties;
+    device_class_set_props(dc, pl031_properties);
 }
 
 static const TypeInfo pl031_info = {
diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index c19a75b..821319e 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -155,7 +155,7 @@ static void emulated_ccw_3270_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = emulated_ccw_3270_properties;
+    device_class_set_props(dc, emulated_ccw_3270_properties);
     dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
     dc->realize = emulated_ccw_3270_realize;
     dc->hotpluggable = false;
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 4d222ad..c970711 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -57,7 +57,7 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
 
     k->realize = ccw_device_realize;
     k->refill_ids = ccw_device_refill_ids;
-    dc->props = ccw_device_properties;
+    device_class_set_props(dc, ccw_device_properties);
     dc->reset = ccw_device_reset;
 }
 
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 15a8ed9..a306a78 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -139,7 +139,7 @@ static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
 
     hc->unplug = ccw_device_unplug;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    dc->props = virtual_css_bridge_properties;
+    device_class_set_props(dc, virtual_css_bridge_properties);
     object_class_property_add_bool(klass, "cssid-unrestricted",
                                    prop_get_true, NULL, NULL);
     object_class_property_set_description(klass, "cssid-unrestricted",
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ca544d6..b3ae901 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -666,7 +666,7 @@ static void s390_ipl_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = s390_ipl_realize;
-    dc->props = s390_ipl_properties;
+    device_class_set_props(dc, s390_ipl_properties);
     dc->reset = s390_ipl_reset;
     dc->vmsd = &vmstate_ipl;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2d2f4a7..7c6a2b3 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1314,7 +1314,7 @@ static void s390_pci_device_class_init(ObjectClass *klass, void *data)
     dc->reset = s390_pci_device_reset;
     dc->bus_type = TYPE_S390_PCI_BUS;
     dc->realize = s390_pci_device_realize;
-    dc->props = s390_pci_device_properties;
+    device_class_set_props(dc, s390_pci_device_properties);
     dc->vmsd = &s390_pci_device_vmstate;
 }
 
diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index 1835812..12dee15 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -35,7 +35,7 @@ static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
 
     k->realize = vhost_vsock_ccw_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props = vhost_vsock_ccw_properties;
+    device_class_set_props(dc, vhost_vsock_ccw_properties);
 }
 
 static void vhost_vsock_ccw_instance_init(Object *obj)
diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
index 5453a96..08e1d5d 100644
--- a/hw/s390x/virtio-ccw-9p.c
+++ b/hw/s390x/virtio-ccw-9p.c
@@ -47,7 +47,7 @@ static void virtio_ccw_9p_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_9p_realize;
-    dc->props = virtio_ccw_9p_properties;
+    device_class_set_props(dc, virtio_ccw_9p_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
diff --git a/hw/s390x/virtio-ccw-balloon.c b/hw/s390x/virtio-ccw-balloon.c
index 7088612..5d28e72 100644
--- a/hw/s390x/virtio-ccw-balloon.c
+++ b/hw/s390x/virtio-ccw-balloon.c
@@ -52,7 +52,7 @@ static void virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_balloon_realize;
-    dc->props = virtio_ccw_balloon_properties;
+    device_class_set_props(dc, virtio_ccw_balloon_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index 1512af8..bf8520e 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -49,7 +49,7 @@ static void virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_blk_realize;
-    dc->props = virtio_ccw_blk_properties;
+    device_class_set_props(dc, virtio_ccw_blk_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index 086b397..1a2690c 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -57,7 +57,7 @@ static void virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_crypto_realize;
-    dc->props = virtio_ccw_crypto_properties;
+    device_class_set_props(dc, virtio_ccw_crypto_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/s390x/virtio-ccw-gpu.c b/hw/s390x/virtio-ccw-gpu.c
index be46ca7..f69e3ff 100644
--- a/hw/s390x/virtio-ccw-gpu.c
+++ b/hw/s390x/virtio-ccw-gpu.c
@@ -48,7 +48,7 @@ static void virtio_ccw_gpu_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_gpu_realize;
-    dc->props = virtio_ccw_gpu_properties;
+    device_class_set_props(dc, virtio_ccw_gpu_properties);
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
 }
diff --git a/hw/s390x/virtio-ccw-input.c b/hw/s390x/virtio-ccw-input.c
index 370b776..b257dfd 100644
--- a/hw/s390x/virtio-ccw-input.c
+++ b/hw/s390x/virtio-ccw-input.c
@@ -38,7 +38,7 @@ static void virtio_ccw_input_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_input_realize;
-    dc->props = virtio_ccw_input_properties;
+    device_class_set_props(dc, virtio_ccw_input_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
index 12c03d7..cd02699 100644
--- a/hw/s390x/virtio-ccw-net.c
+++ b/hw/s390x/virtio-ccw-net.c
@@ -52,7 +52,7 @@ static void virtio_ccw_net_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_net_realize;
-    dc->props = virtio_ccw_net_properties;
+    device_class_set_props(dc, virtio_ccw_net_properties);
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index 854254d..d575e30 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -56,7 +56,7 @@ static void virtio_ccw_rng_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_rng_realize;
-    dc->props = virtio_ccw_rng_properties;
+    device_class_set_props(dc, virtio_ccw_rng_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/s390x/virtio-ccw-scsi.c b/hw/s390x/virtio-ccw-scsi.c
index 4662288..3cb3ad6 100644
--- a/hw/s390x/virtio-ccw-scsi.c
+++ b/hw/s390x/virtio-ccw-scsi.c
@@ -59,7 +59,7 @@ static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_scsi_realize;
-    dc->props = virtio_ccw_scsi_properties;
+    device_class_set_props(dc, virtio_ccw_scsi_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
@@ -102,7 +102,7 @@ static void vhost_ccw_scsi_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = vhost_ccw_scsi_realize;
-    dc->props = vhost_ccw_scsi_properties;
+    device_class_set_props(dc, vhost_ccw_scsi_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
diff --git a/hw/s390x/virtio-ccw-serial.c b/hw/s390x/virtio-ccw-serial.c
index eafb7d5..1764db2 100644
--- a/hw/s390x/virtio-ccw-serial.c
+++ b/hw/s390x/virtio-ccw-serial.c
@@ -60,7 +60,7 @@ static void virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_serial_realize;
-    dc->props = virtio_ccw_serial_properties;
+    device_class_set_props(dc, virtio_ccw_serial_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index de9bd20..af18c88 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2511,7 +2511,7 @@ static void megasas_class_init(ObjectClass *oc, void *data)
     e->osts = info->osts;
     e->product_name = info->product_name;
     e->product_version = info->product_version;
-    dc->props = info->props;
+    device_class_set_props(dc, info->props);
     dc->reset = megasas_scsi_reset;
     dc->vmsd = info->vmsd;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index b8a4b37..14cbed8 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1431,7 +1431,7 @@ static void mptsas1068_class_init(ObjectClass *oc, void *data)
     pc->subsystem_vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
     pc->subsystem_id = 0x8000;
     pc->class_id = PCI_CLASS_STORAGE_SCSI;
-    dc->props = mptsas_properties;
+    device_class_set_props(dc, mptsas_properties);
     dc->reset = mptsas_reset;
     dc->vmsd = &vmstate_mptsas;
     dc->desc = "LSI SAS 1068";
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index ad0e7f6..1c980ca 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1728,7 +1728,7 @@ static void scsi_device_class_init(ObjectClass *klass, void *data)
     k->bus_type  = TYPE_SCSI_BUS;
     k->realize   = scsi_qdev_realize;
     k->unrealize = scsi_qdev_unrealize;
-    k->props     = scsi_props;
+    device_class_set_props(k, scsi_props);
 }
 
 static void scsi_dev_instance_init(Object *obj)
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e44c61e..10d0794 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3036,7 +3036,7 @@ static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
     sc->alloc_req    = scsi_new_request;
     sc->unit_attention_reported = scsi_disk_unit_attention_reported;
     dc->desc = "virtual SCSI disk";
-    dc->props = scsi_hd_properties;
+    device_class_set_props(dc, scsi_hd_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
 }
 
@@ -3067,7 +3067,7 @@ static void scsi_cd_class_initfn(ObjectClass *klass, void *data)
     sc->alloc_req    = scsi_new_request;
     sc->unit_attention_reported = scsi_disk_unit_attention_reported;
     dc->desc = "virtual SCSI CD-ROM";
-    dc->props = scsi_cd_properties;
+    device_class_set_props(dc, scsi_cd_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
 }
 
@@ -3106,7 +3106,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
     sdc->update_sense = scsi_block_update_sense;
     sdc->need_fua_emulation = scsi_block_no_fua;
     dc->desc = "SCSI block device passthrough";
-    dc->props = scsi_block_properties;
+    device_class_set_props(dc, scsi_block_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
 }
 
@@ -3146,7 +3146,7 @@ static void scsi_disk_class_initfn(ObjectClass *klass, void *data)
     dc->fw_name = "disk";
     dc->desc = "virtual SCSI disk or CD-ROM (legacy)";
     dc->reset = scsi_disk_reset;
-    dc->props = scsi_disk_properties;
+    device_class_set_props(dc, scsi_disk_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
 }
 
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index e7798eb..86ed0a3 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -768,7 +768,7 @@ static void scsi_generic_class_initfn(ObjectClass *klass, void *data)
     dc->fw_name = "disk";
     dc->desc = "pass through generic scsi device (/dev/sg*)";
     dc->reset = scsi_generic_reset;
-    dc->props = scsi_generic_properties;
+    device_class_set_props(dc, scsi_generic_properties);
     dc->vmsd  = &vmstate_scsi_device;
 }
 
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 2120ceb..7d584e7 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1267,7 +1267,7 @@ static void spapr_vscsi_class_init(ObjectClass *klass, void *data)
     k->dt_compatible = "IBM,v-scsi";
     k->signal_mask = 0x00000001;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = spapr_vscsi_properties;
+    device_class_set_props(dc, spapr_vscsi_properties);
     k->rtce_window_size = 0x10000000;
     dc->vmsd = &vmstate_spapr_vscsi;
 }
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 26f710d..f052377 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -293,7 +293,7 @@ static void vhost_scsi_class_init(ObjectClass *klass, void *data)
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(klass);
 
-    dc->props = vhost_scsi_properties;
+    device_class_set_props(dc, vhost_scsi_properties);
     dc->vmsd = &vmstate_virtio_vhost_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vhost_scsi_realize;
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 23f972d..a01bf63 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -197,7 +197,7 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(klass);
 
-    dc->props = vhost_user_scsi_properties;
+    device_class_set_props(dc, vhost_user_scsi_properties);
     dc->vmsd = &vmstate_vhost_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vhost_user_scsi_realize;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index d3af42e..3b61563 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1006,7 +1006,7 @@ static void virtio_scsi_class_init(ObjectClass *klass, void *data)
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-    dc->props = virtio_scsi_properties;
+    device_class_set_props(dc, virtio_scsi_properties);
     dc->vmsd = &vmstate_virtio_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = virtio_scsi_device_realize;
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 452a3b6..8f1aaf9 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1292,7 +1292,7 @@ static void pvscsi_class_init(ObjectClass *klass, void *data)
                                     &pvs_k->parent_dc_realize);
     dc->reset = pvscsi_reset;
     dc->vmsd = &vmstate_pvscsi;
-    dc->props = pvscsi_properties;
+    device_class_set_props(dc, pvscsi_properties);
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     hc->unplug = pvscsi_hot_unplug;
     hc->plug = pvscsi_hotplug;
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 49b8357..71a9af0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2118,7 +2118,7 @@ static void sd_class_init(ObjectClass *klass, void *data)
     SDCardClass *sc = SD_CARD_CLASS(klass);
 
     dc->realize = sd_realize;
-    dc->props = sd_properties;
+    device_class_set_props(dc, sd_properties);
     dc->vmsd = &sd_vmstate;
     dc->reset = sd_reset;
     dc->bus_type = TYPE_SD_BUS;
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 2c8d8f5..19fa8bd 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -64,7 +64,7 @@ static void sdhci_pci_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_SDHCI;
     k->class_id = PCI_CLASS_SYSTEM_SDHCI;
-    dc->props = sdhci_pci_properties;
+    device_class_set_props(dc, sdhci_pci_properties);
 
     sdhci_common_class_init(klass, data);
 }
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 18c0c05..69dc3e6 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1499,7 +1499,7 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = sdhci_sysbus_properties;
+    device_class_set_props(dc, sdhci_sysbus_properties);
     dc->realize = sdhci_sysbus_realize;
     dc->unrealize = sdhci_sysbus_unrealize;
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 2aaa5bf..df33b32 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -761,7 +761,7 @@ static void prom_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = prom_properties;
+    device_class_set_props(dc, prom_properties);
     dc->realize = prom_realize;
 }
 
@@ -827,7 +827,7 @@ static void ram_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = ram_realize;
-    dc->props = ram_properties;
+    device_class_set_props(dc, ram_properties);
 }
 
 static const TypeInfo ram_info = {
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index ccf46a5..71f5465 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -379,7 +379,7 @@ static void iommu_class_init(ObjectClass *klass, void *data)
 
     dc->reset = iommu_reset;
     dc->vmsd = &vmstate_iommu;
-    dc->props = iommu_properties;
+    device_class_set_props(dc, iommu_properties);
 }
 
 static const TypeInfo iommu_info = {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 9550827..5d710d6 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -389,7 +389,7 @@ static void ebus_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_SUN_EBUS;
     k->revision = 0x01;
     k->class_id = PCI_CLASS_BRIDGE_OTHER;
-    dc->props = ebus_properties;
+    device_class_set_props(dc, ebus_properties);
 }
 
 static const TypeInfo ebus_info = {
@@ -479,7 +479,7 @@ static void prom_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = prom_properties;
+    device_class_set_props(dc, prom_properties);
     dc->realize = prom_realize;
 }
 
@@ -540,7 +540,7 @@ static void ram_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = ram_realize;
-    dc->props = ram_properties;
+    device_class_set_props(dc, ram_properties);
 }
 
 static const TypeInfo ram_info = {
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 7755eca..23c8d2f 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1401,7 +1401,7 @@ static void aspeed_smc_class_init(ObjectClass *klass, void *data)
 
     dc->realize = aspeed_smc_realize;
     dc->reset = aspeed_smc_reset;
-    dc->props = aspeed_smc_properties;
+    device_class_set_props(dc, aspeed_smc_properties);
     dc->vmsd = &vmstate_aspeed_smc;
     mc->ctrl = data;
 }
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index a1be0de..eba7ccd 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -372,7 +372,7 @@ static void xilinx_spi_class_init(ObjectClass *klass, void *data)
 
     dc->realize = xilinx_spi_realize;
     dc->reset = xlx_spi_reset;
-    dc->props = xilinx_spi_properties;
+    device_class_set_props(dc, xilinx_spi_properties);
     dc->vmsd = &vmstate_xilinx_spi;
 }
 
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 0d6c2e1..6c9ef59 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1455,7 +1455,7 @@ static void xilinx_spips_class_init(ObjectClass *klass, void *data)
 
     dc->realize = xilinx_spips_realize;
     dc->reset = xilinx_spips_reset;
-    dc->props = xilinx_spips_properties;
+    device_class_set_props(dc, xilinx_spips_properties);
     dc->vmsd = &vmstate_xilinx_spips;
 
     xsc->reg_ops = &spips_ops;
@@ -1471,7 +1471,7 @@ static void xlnx_zynqmp_qspips_class_init(ObjectClass *klass, void * data)
     dc->realize = xlnx_zynqmp_qspips_realize;
     dc->reset = xlnx_zynqmp_qspips_reset;
     dc->vmsd = &vmstate_xlnx_zynqmp_qspips;
-    dc->props = xilinx_zynqmp_qspips_properties;
+    device_class_set_props(dc, xilinx_zynqmp_qspips_properties);
     xsc->reg_ops = &xlnx_zynqmp_qspips_ops;
     xsc->rx_fifo_size = RXFF_A_Q;
     xsc->tx_fifo_size = TXFF_A_Q;
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 4c634c8..7233068 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -359,7 +359,7 @@ static void a9_gtimer_class_init(ObjectClass *klass, void *data)
     dc->realize = a9_gtimer_realize;
     dc->vmsd = &vmstate_a9_gtimer;
     dc->reset = a9_gtimer_reset;
-    dc->props = a9_gtimer_properties;
+    device_class_set_props(dc, a9_gtimer_properties);
 }
 
 static const TypeInfo a9_gtimer_info = {
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index aae880f..f84fc0e 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -284,7 +284,7 @@ static void a10_pit_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = a10_pit_reset;
-    dc->props = a10_pit_properties;
+    device_class_set_props(dc, a10_pit_properties);
     dc->desc = "allwinner a10 timer";
     dc->vmsd = &vmstate_a10_pit;
 }
diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index 79fc381..be81b7a 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -224,7 +224,7 @@ static void altera_timer_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = altera_timer_realize;
-    dc->props = altera_timer_properties;
+    device_class_set_props(dc, altera_timer_properties);
     dc->reset = altera_timer_reset;
 }
 
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 2bf11f7..cdfca30 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -312,7 +312,7 @@ static void arm_mptimer_class_init(ObjectClass *klass, void *data)
     dc->realize = arm_mptimer_realize;
     dc->vmsd = &vmstate_arm_mptimer;
     dc->reset = arm_mptimer_reset;
-    dc->props = arm_mptimer_properties;
+    device_class_set_props(dc, arm_mptimer_properties);
 }
 
 static const TypeInfo arm_mptimer_info = {
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index beaa285..9607366 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -397,7 +397,7 @@ static void sp804_class_init(ObjectClass *klass, void *data)
     DeviceClass *k = DEVICE_CLASS(klass);
 
     k->realize = sp804_realize;
-    k->props = sp804_properties;
+    device_class_set_props(k, sp804_properties);
     k->vmsd = &vmstate_sp804;
 }
 
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index c91f184..42c47d2 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -685,7 +685,7 @@ static void timer_class_init(ObjectClass *klass, void *data)
     dc->reset = aspeed_timer_reset;
     dc->desc = "ASPEED Timer";
     dc->vmsd = &vmstate_aspeed_timer_state;
-    dc->props = aspeed_timer_properties;
+    device_class_set_props(dc, aspeed_timer_properties);
 }
 
 static const TypeInfo aspeed_timer_info = {
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index e28ba9c..f653424 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -510,7 +510,7 @@ static void cmsdk_apb_dualtimer_class_init(ObjectClass *klass, void *data)
     dc->realize = cmsdk_apb_dualtimer_realize;
     dc->vmsd = &cmsdk_apb_dualtimer_vmstate;
     dc->reset = cmsdk_apb_dualtimer_reset;
-    dc->props = cmsdk_apb_dualtimer_properties;
+    device_class_set_props(dc, cmsdk_apb_dualtimer_properties);
 }
 
 static const TypeInfo cmsdk_apb_dualtimer_info = {
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 40728e8..f85f130 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -260,7 +260,7 @@ static void cmsdk_apb_timer_class_init(ObjectClass *klass, void *data)
     dc->realize = cmsdk_apb_timer_realize;
     dc->vmsd = &cmsdk_apb_timer_vmstate;
     dc->reset = cmsdk_apb_timer_reset;
-    dc->props = cmsdk_apb_timer_properties;
+    device_class_set_props(dc, cmsdk_apb_timer_properties);
 }
 
 static const TypeInfo cmsdk_apb_timer_info = {
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 7a9371c..eff0ee3 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -415,7 +415,7 @@ static void grlib_gptimer_class_init(ObjectClass *klass, void *data)
 
     dc->realize = grlib_gptimer_realize;
     dc->reset = grlib_gptimer_reset;
-    dc->props = grlib_gptimer_properties;
+    device_class_set_props(dc, grlib_gptimer_properties);
 }
 
 static const TypeInfo grlib_gptimer_info = {
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 9f17aaa..8dbcbdc 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -800,7 +800,7 @@ static void hpet_device_class_init(ObjectClass *klass, void *data)
     dc->realize = hpet_realize;
     dc->reset = hpet_reset;
     dc->vmsd = &vmstate_hpet;
-    dc->props = hpet_device_properties;
+    device_class_set_props(dc, hpet_device_properties);
 }
 
 static const TypeInfo hpet_device_info = {
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index a4be733..29f62e5 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -364,7 +364,7 @@ static void pit_class_initfn(ObjectClass *klass, void *data)
     k->get_channel_info = pit_get_channel_info_common;
     k->post_load = pit_post_load;
     dc->reset = pit_reset;
-    dc->props = pit_properties;
+    device_class_set_props(dc, pit_properties);
 }
 
 static const TypeInfo pit_info = {
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index 3fdecd0..f703f40 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -230,7 +230,7 @@ static void lm32_timer_class_init(ObjectClass *klass, void *data)
     dc->realize = lm32_timer_realize;
     dc->reset = timer_reset;
     dc->vmsd = &vmstate_lm32_timer;
-    dc->props = lm32_timer_properties;
+    device_class_set_props(dc, lm32_timer_properties);
 }
 
 static const TypeInfo lm32_timer_info = {
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 7a62e21..94389820 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -343,7 +343,7 @@ static void milkymist_sysctl_class_init(ObjectClass *klass, void *data)
     dc->realize = milkymist_sysctl_realize;
     dc->reset = milkymist_sysctl_reset;
     dc->vmsd = &vmstate_milkymist_sysctl;
-    dc->props = milkymist_sysctl_properties;
+    device_class_set_props(dc, milkymist_sysctl_properties);
 }
 
 static const TypeInfo milkymist_sysctl_info = {
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index b1c9a80..29943fd 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -278,7 +278,7 @@ static void mss_timer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = mss_timer_properties;
+    device_class_set_props(dc, mss_timer_properties);
     dc->vmsd = &vmstate_mss_timer;
 }
 
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 311cd38..cd172cc 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -562,7 +562,7 @@ static void pxa25x_timer_dev_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "PXA25x timer";
-    dc->props = pxa25x_timer_dev_properties;
+    device_class_set_props(dc, pxa25x_timer_dev_properties);
 }
 
 static const TypeInfo pxa25x_timer_dev_info = {
@@ -584,7 +584,7 @@ static void pxa27x_timer_dev_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "PXA27x timer";
-    dc->props = pxa27x_timer_dev_properties;
+    device_class_set_props(dc, pxa27x_timer_dev_properties);
 }
 
 static const TypeInfo pxa27x_timer_dev_info = {
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index c55e8d0..4c5d65e 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -427,7 +427,7 @@ static void slavio_timer_class_init(ObjectClass *klass, void *data)
 
     dc->reset = slavio_timer_reset;
     dc->vmsd = &vmstate_slavio_timer;
-    dc->props = slavio_timer_properties;
+    device_class_set_props(dc, slavio_timer_properties);
 }
 
 static const TypeInfo slavio_timer_info = {
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index edc557a..fb370ce 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -323,7 +323,7 @@ static void stm32f2xx_timer_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = stm32f2xx_timer_reset;
-    dc->props = stm32f2xx_timer_properties;
+    device_class_set_props(dc, stm32f2xx_timer_properties);
     dc->vmsd = &vmstate_stm32f2xx_timer;
 }
 
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 7191ea5..0190aa4 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -253,7 +253,7 @@ static void xilinx_timer_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = xilinx_timer_realize;
-    dc->props = xilinx_timer_properties;
+    device_class_set_props(dc, xilinx_timer_properties);
 }
 
 static const TypeInfo xilinx_timer_info = {
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index faae733..cd004e7 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -313,7 +313,7 @@ static void tpm_crb_class_init(ObjectClass *klass, void *data)
     TPMIfClass *tc = TPM_IF_CLASS(klass);
 
     dc->realize = tpm_crb_realize;
-    dc->props = tpm_crb_properties;
+    device_class_set_props(dc, tpm_crb_properties);
     dc->vmsd  = &vmstate_tpm_crb;
     dc->user_creatable = true;
     tc->model = TPM_MODEL_TPM_CRB;
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 7aaf9b9..5362df2 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1023,7 +1023,7 @@ static void tpm_tis_class_init(ObjectClass *klass, void *data)
     TPMIfClass *tc = TPM_IF_CLASS(klass);
 
     dc->realize = tpm_tis_realizefn;
-    dc->props = tpm_tis_properties;
+    device_class_set_props(dc, tpm_tis_properties);
     dc->reset = tpm_tis_reset;
     dc->vmsd  = &vmstate_tpm_tis;
     tc->model = TPM_MODEL_TPM_TIS;
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index a6522f5..c9a3900 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -768,7 +768,7 @@ static void usb_device_class_init(ObjectClass *klass, void *data)
     k->bus_type = TYPE_USB_BUS;
     k->realize  = usb_qdev_realize;
     k->unrealize = usb_qdev_unrealize;
-    k->props    = usb_props;
+    device_class_set_props(k, usb_props);
 }
 
 static const TypeInfo usb_device_type_info = {
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 291e41d..3083124 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -603,7 +603,7 @@ static void emulated_class_initfn(ObjectClass *klass, void *data)
     cc->apdu_from_guest = emulated_apdu_from_guest;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     dc->desc = "emulated smartcard";
-    dc->props = emulated_card_properties;
+    device_class_set_props(dc, emulated_card_properties);
 }
 
 static const TypeInfo emulated_card_info = {
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 3d40b70..bb325db 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -403,7 +403,7 @@ static void passthru_class_initfn(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     dc->desc = "passthrough smartcard";
     dc->vmsd = &passthru_vmstate;
-    dc->props = passthru_card_properties;
+    device_class_set_props(dc, passthru_card_properties);
 }
 
 static const TypeInfo passthru_card_info = {
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index ea604bb..6fa213f 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -1002,7 +1002,7 @@ static void usb_audio_class_init(ObjectClass *klass, void *data)
     USBDeviceClass *k = USB_DEVICE_CLASS(klass);
 
     dc->vmsd          = &vmstate_usb_audio;
-    dc->props         = usb_audio_properties;
+    device_class_set_props(dc, usb_audio_properties);
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     k->product_desc   = "QEMU USB Audio Interface";
     k->realize        = usb_audio_realize;
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 88492f2..67ec8b6 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -819,7 +819,7 @@ static void usb_tablet_class_initfn(ObjectClass *klass, void *data)
     uc->realize        = usb_tablet_realize;
     uc->product_desc   = "QEMU USB Tablet";
     dc->vmsd = &vmstate_usb_ptr;
-    dc->props = usb_tablet_properties;
+    device_class_set_props(dc, usb_tablet_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
@@ -842,7 +842,7 @@ static void usb_mouse_class_initfn(ObjectClass *klass, void *data)
     uc->realize        = usb_mouse_realize;
     uc->product_desc   = "QEMU USB Mouse";
     dc->vmsd = &vmstate_usb_ptr;
-    dc->props = usb_mouse_properties;
+    device_class_set_props(dc, usb_mouse_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
@@ -866,7 +866,7 @@ static void usb_keyboard_class_initfn(ObjectClass *klass, void *data)
     uc->realize        = usb_keyboard_realize;
     uc->product_desc   = "QEMU USB Keyboard";
     dc->vmsd = &vmstate_usb_kbd;
-    dc->props = usb_keyboard_properties;
+    device_class_set_props(dc, usb_keyboard_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 07ecfef..49a573b 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -686,7 +686,7 @@ static void usb_hub_class_initfn(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "hub";
     dc->vmsd = &vmstate_usb_hub;
-    dc->props = usb_hub_properties;
+    device_class_set_props(dc, usb_hub_properties);
 }
 
 static const TypeInfo hub_info = {
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 7c07295..20717f0 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -2105,7 +2105,7 @@ static void usb_mtp_class_initfn(ObjectClass *klass, void *data)
     dc->desc = "USB Media Transfer Protocol device";
     dc->fw_name = "mtp";
     dc->vmsd = &vmstate_usb_mtp;
-    dc->props = mtp_properties;
+    device_class_set_props(dc, mtp_properties);
 }
 
 static TypeInfo mtp_info = {
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index b81a8ab..9a78ad9 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1409,7 +1409,7 @@ static void usb_net_class_initfn(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     dc->fw_name = "network";
     dc->vmsd = &vmstate_usb_net;
-    dc->props = net_properties;
+    device_class_set_props(dc, net_properties);
 }
 
 static const TypeInfo net_info = {
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 9646fe7..9846599 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -567,7 +567,7 @@ static void usb_serial_class_initfn(ObjectClass *klass, void *data)
 
     uc->product_desc   = "QEMU USB Serial";
     uc->usb_desc       = &desc_serial;
-    dc->props = serial_properties;
+    device_class_set_props(dc, serial_properties);
 }
 
 static const TypeInfo serial_info = {
@@ -588,7 +588,7 @@ static void usb_braille_class_initfn(ObjectClass *klass, void *data)
 
     uc->product_desc   = "QEMU USB Braille";
     uc->usb_desc       = &desc_braille;
-    dc->props = braille_properties;
+    device_class_set_props(dc, braille_properties);
 }
 
 static const TypeInfo braille_info = {
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 4568db2..02693a2 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1456,7 +1456,7 @@ static void ccid_class_initfn(ObjectClass *klass, void *data)
     uc->unrealize      = ccid_unrealize;
     dc->desc = "CCID Rev 1.1 smartcard reader";
     dc->vmsd = &ccid_vmstate;
-    dc->props = ccid_properties;
+    device_class_set_props(dc, ccid_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
     hc->unplug = qdev_simple_device_unplug_cb;
 }
@@ -1478,7 +1478,7 @@ static void ccid_card_class_init(ObjectClass *klass, void *data)
     k->bus_type = TYPE_CCID_BUS;
     k->realize = ccid_card_realize;
     k->unrealize = ccid_card_unrealize;
-    k->props = ccid_props;
+    device_class_set_props(k, ccid_props);
 }
 
 static const TypeInfo ccid_card_type_info = {
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 8545193..90da008 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -702,7 +702,7 @@ static void usb_msd_class_storage_initfn(ObjectClass *klass, void *data)
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
 
     uc->realize = usb_msd_storage_realize;
-    dc->props = msd_properties;
+    device_class_set_props(dc, msd_properties);
 }
 
 static void usb_msd_get_bootindex(Object *obj, Visitor *v, const char *name,
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 6d6d107..9825ec3 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -952,7 +952,7 @@ static void usb_uas_class_initfn(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->fw_name = "storage";
     dc->vmsd = &vmstate_usb_uas;
-    dc->props = uas_properties;
+    device_class_set_props(dc, uas_properties);
 }
 
 static const TypeInfo uas_info = {
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 5b9a8d3..fc73a05 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -161,7 +161,7 @@ static void ehci_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_SERIAL_USB;
     k->config_write = usb_ehci_pci_write_config;
     dc->vmsd = &vmstate_ehci_pci;
-    dc->props = ehci_pci_properties;
+    device_class_set_props(dc, ehci_pci_properties);
     dc->reset = usb_ehci_pci_reset;
 }
 
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 020211f..8d47385 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -82,7 +82,7 @@ static void ehci_sysbus_class_init(ObjectClass *klass, void *data)
 
     dc->realize = usb_ehci_sysbus_realize;
     dc->vmsd = &vmstate_ehci_sysbus;
-    dc->props = ehci_sysbus_properties;
+    device_class_set_props(dc, ehci_sysbus_properties);
     dc->reset = usb_ehci_sysbus_reset;
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index c052f10..a7fb166 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -139,7 +139,7 @@ static void ohci_pci_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_SERIAL_USB;
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
     dc->desc = "Apple USB Controller";
-    dc->props = ohci_pci_properties;
+    device_class_set_props(dc, ohci_pci_properties);
     dc->hotpluggable = false;
     dc->vmsd = &vmstate_ohci;
     dc->reset = usb_ohci_reset_pci;
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 145ee21..8a94bd0 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -2000,7 +2000,7 @@ static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
     dc->realize = ohci_realize_pxa;
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
     dc->desc = "OHCI USB Controller";
-    dc->props = ohci_sysbus_properties;
+    device_class_set_props(dc, ohci_sysbus_properties);
     dc->reset = usb_ohci_reset_sysbus;
 }
 
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 23507ad..37f7beb 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1349,9 +1349,9 @@ static void uhci_data_class_init(ObjectClass *klass, void *data)
     if (!info->unplug) {
         /* uhci controllers in companion setups can't be hotplugged */
         dc->hotpluggable = false;
-        dc->props = uhci_properties_companion;
+        device_class_set_props(dc, uhci_properties_companion);
     } else {
-        dc->props = uhci_properties_standalone;
+        device_class_set_props(dc, uhci_properties_standalone);
     }
     u->info = *info;
 }
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 05fb3f5..e6a5a22 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -44,7 +44,7 @@ static void nec_xhci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props       = nec_xhci_properties;
+    device_class_set_props(dc, nec_xhci_properties);
     k->vendor_id    = PCI_VENDOR_ID_NEC;
     k->device_id    = PCI_DEVICE_ID_NEC_UPD720200;
     k->revision     = 0x03;
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index fb05de4..b330e36 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3707,7 +3707,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd    = &vmstate_xhci;
-    dc->props   = xhci_properties;
+    device_class_set_props(dc, xhci_properties);
     dc->reset   = xhci_reset;
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
     k->realize      = usb_xhci_realize;
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 00e0e36..2594700 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1635,7 +1635,7 @@ static void usb_host_class_initfn(ObjectClass *klass, void *data)
     uc->alloc_streams  = usb_host_alloc_streams;
     uc->free_streams   = usb_host_free_streams;
     dc->vmsd = &vmstate_usb_host;
-    dc->props = usb_host_dev_properties;
+    device_class_set_props(dc, usb_host_dev_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index efdbcc0..45d8b76 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2584,7 +2584,7 @@ static void usbredir_class_initfn(ObjectClass *klass, void *data)
     uc->alloc_streams  = usbredir_alloc_streams;
     uc->free_streams   = usbredir_free_streams;
     dc->vmsd           = &usbredir_vmstate;
-    dc->props          = usbredir_properties;
+    device_class_set_props(dc, usbredir_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 8fbaa72..8649ac1 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -161,7 +161,7 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = vfio_ap_properties;
+    device_class_set_props(dc, vfio_ap_properties);
     dc->vmsd = &vfio_ap_vmstate;
     dc->desc = "VFIO-based AP device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 3b5520a..50cc2ec 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -561,7 +561,7 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
 
-    dc->props = vfio_ccw_properties;
+    device_class_set_props(dc, vfio_ccw_properties);
     dc->vmsd = &vfio_ccw_vmstate;
     dc->desc = "VFIO-based subchannel assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 337a173..5e75a95 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3199,7 +3199,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
     dc->reset = vfio_pci_reset;
-    dc->props = vfio_pci_dev_properties;
+    device_class_set_props(dc, vfio_pci_dev_properties);
     dc->desc = "VFIO-based PCI device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
@@ -3231,7 +3231,7 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = vfio_pci_dev_nohotplug_properties;
+    device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
     dc->hotpluggable = false;
 }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index d7598c6..6b2952c 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -699,7 +699,7 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
     SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
 
     dc->realize = vfio_platform_realize;
-    dc->props = vfio_platform_dev_properties;
+    device_class_set_props(dc, vfio_platform_dev_properties);
     dc->vmsd = &vfio_platform_vmstate;
     dc->desc = "VFIO-based platform device assignment";
     sbc->connect_irq_notifier = vfio_start_irqfd_injection;
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index e8dfbfc..5dce640 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -64,7 +64,7 @@ static void vhost_scsi_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     k->realize = vhost_scsi_pci_realize;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = vhost_scsi_pci_properties;
+    device_class_set_props(dc, vhost_scsi_pci_properties);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
     pcidev_k->revision = 0x00;
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index 1dc834a..8d3d766 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -69,7 +69,7 @@ static void vhost_user_blk_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = vhost_user_blk_pci_properties;
+    device_class_set_props(dc, vhost_user_blk_pci_properties);
     k->realize = vhost_user_blk_pci_realize;
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
index e3a649d..ae36f11 100644
--- a/hw/virtio/vhost-user-fs-pci.c
+++ b/hw/virtio/vhost-user-fs-pci.c
@@ -55,7 +55,7 @@ static void vhost_user_fs_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     k->realize = vhost_user_fs_pci_realize;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = vhost_user_fs_pci_properties;
+    device_class_set_props(dc, vhost_user_fs_pci_properties);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
     pcidev_k->revision = 0x00;
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index ca0b7fc..33b1784 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -271,7 +271,7 @@ static void vuf_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
-    dc->props = vuf_properties;
+    device_class_set_props(dc, vuf_properties);
     dc->vmsd = &vuf_vmstate;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vuf_device_realize;
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index ff13af7..32febb2 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -70,7 +70,7 @@ static void vhost_user_scsi_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     k->realize = vhost_user_scsi_pci_realize;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = vhost_user_scsi_pci_properties;
+    device_class_set_props(dc, vhost_user_scsi_pci_properties);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
     pcidev_k->revision = 0x00;
diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index 4ca097f..01effe3 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -55,7 +55,7 @@ static void vhost_vsock_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     k->realize = vhost_vsock_pci_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props = vhost_vsock_pci_properties;
+    device_class_set_props(dc, vhost_vsock_pci_properties);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_VSOCK;
     pcidev_k->revision = 0x00;
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index f574436..87c45d8 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -393,7 +393,7 @@ static void vhost_vsock_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
-    dc->props = vhost_vsock_properties;
+    device_class_set_props(dc, vhost_vsock_properties);
     dc->vmsd = &vmstate_virtio_vhost_vsock;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     vdc->realize = vhost_vsock_device_realize;
diff --git a/hw/virtio/virtio-9p-pci.c b/hw/virtio/virtio-9p-pci.c
index 22a183c..6507ce3 100644
--- a/hw/virtio/virtio-9p-pci.c
+++ b/hw/virtio/virtio-9p-pci.c
@@ -61,7 +61,7 @@ static void virtio_9p_pci_class_init(ObjectClass *klass, void *data)
     pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
     pcidev_k->class_id = 0x2;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = virtio_9p_pci_properties;
+    device_class_set_props(dc, virtio_9p_pci_properties);
 }
 
 static void virtio_9p_pci_instance_init(Object *obj)
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
index 69ca057..56962ae 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -59,7 +59,7 @@ static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     k->realize = virtio_balloon_pci_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props = virtio_balloon_pci_properties;
+    device_class_set_props(dc, virtio_balloon_pci_properties);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BALLOON;
     pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 57f3b9f..a4729f7 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -932,7 +932,7 @@ static void virtio_balloon_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
-    dc->props = virtio_balloon_properties;
+    device_class_set_props(dc, virtio_balloon_properties);
     dc->vmsd = &vmstate_virtio_balloon;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     vdc->realize = virtio_balloon_device_realize;
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index d9b69a5..efb2c22 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -66,7 +66,7 @@ static void virtio_blk_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = virtio_blk_pci_properties;
+    device_class_set_props(dc, virtio_blk_pci_properties);
     k->realize = virtio_blk_pci_realize;
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index d853dc4..0bebe01 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -69,7 +69,7 @@ static void virtio_crypto_pci_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_crypto_pci_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props = virtio_crypto_pci_properties;
+    device_class_set_props(dc, virtio_crypto_pci_properties);
     pcidev_k->class_id = PCI_CLASS_OTHERS;
 }
 
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 6d42f95..7351ab0 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -955,7 +955,7 @@ static void virtio_crypto_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
-    dc->props = virtio_crypto_properties;
+    device_class_set_props(dc, virtio_crypto_properties);
     dc->vmsd = &vmstate_virtio_crypto;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     vdc->realize = virtio_crypto_device_realize;
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index 80b1172..5a96540 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -60,7 +60,7 @@ static void virtio_input_pci_class_init(ObjectClass *klass, void *data)
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
-    dc->props = virtio_input_pci_properties;
+    device_class_set_props(dc, virtio_input_pci_properties);
     k->realize = virtio_input_pci_realize;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 872f2cd..f12d159 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -712,7 +712,7 @@ static void virtio_mmio_class_init(ObjectClass *klass, void *data)
     dc->realize = virtio_mmio_realizefn;
     dc->reset = virtio_mmio_reset;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props = virtio_mmio_properties;
+    device_class_set_props(dc, virtio_mmio_properties);
 }
 
 static const TypeInfo virtio_mmio_info = {
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index f670aed..5ca71d4 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -68,7 +68,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
-    dc->props = virtio_net_properties;
+    device_class_set_props(dc, virtio_net_properties);
     vpciklass->realize = virtio_net_pci_realize;
 }
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f723b9f..4cb7843 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1886,7 +1886,7 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
 
-    dc->props = virtio_pci_properties;
+    device_class_set_props(dc, virtio_pci_properties);
     k->realize = virtio_pci_realize;
     k->exit = virtio_pci_exit;
     k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
@@ -1925,7 +1925,7 @@ static void virtio_pci_generic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = virtio_pci_generic_properties;
+    device_class_set_props(dc, virtio_pci_generic_properties);
 }
 
 static void virtio_pci_transitional_instance_init(Object *obj)
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index c0c9395..97287e9 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -165,7 +165,7 @@ static void virtio_pmem_class_init(ObjectClass *klass, void *data)
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     VirtIOPMEMClass *vpc = VIRTIO_PMEM_CLASS(klass);
 
-    dc->props = virtio_pmem_properties;
+    device_class_set_props(dc, virtio_pmem_properties);
 
     vdc->realize = virtio_pmem_realize;
     vdc->unrealize = virtio_pmem_unrealize;
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index b498a20..1e363ad 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -269,7 +269,7 @@ static void virtio_rng_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
 
-    dc->props = virtio_rng_properties;
+    device_class_set_props(dc, virtio_rng_properties);
     dc->vmsd = &vmstate_virtio_rng;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     vdc->realize = virtio_rng_device_realize;
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index 3c55dc1..e82e7e5 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -76,7 +76,7 @@ static void virtio_scsi_pci_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_scsi_pci_realize;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = virtio_scsi_pci_properties;
+    device_class_set_props(dc, virtio_scsi_pci_properties);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
     pcidev_k->revision = 0x00;
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.c
index 953abbd..22ab4d8 100644
--- a/hw/virtio/virtio-serial-pci.c
+++ b/hw/virtio/virtio-serial-pci.c
@@ -84,7 +84,7 @@ static void virtio_serial_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
     k->realize = virtio_serial_pci_realize;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-    dc->props = virtio_serial_pci_properties;
+    device_class_set_props(dc, virtio_serial_pci_properties);
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_CONSOLE;
     pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7b861e0..2c5410e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3713,7 +3713,7 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
     dc->realize = virtio_device_realize;
     dc->unrealize = virtio_device_unrealize;
     dc->bus_type = TYPE_VIRTIO_BUS;
-    dc->props = virtio_properties;
+    device_class_set_props(dc, virtio_properties);
     vdc->start_ioeventfd = virtio_device_start_ioeventfd_impl;
     vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
 
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index e6f3b93..1541365 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -371,7 +371,7 @@ static void cmsdk_apb_watchdog_class_init(ObjectClass *klass, void *data)
     dc->realize = cmsdk_apb_watchdog_realize;
     dc->vmsd = &cmsdk_apb_watchdog_vmstate;
     dc->reset = cmsdk_apb_watchdog_reset;
-    dc->props = cmsdk_apb_watchdog_properties;
+    device_class_set_props(dc, cmsdk_apb_watchdog_properties);
 }
 
 static const TypeInfo cmsdk_apb_watchdog_info = {
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index f50dab9..6352ba1 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -271,7 +271,7 @@ static void aspeed_wdt_class_init(ObjectClass *klass, void *data)
     dc->reset = aspeed_wdt_reset;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->vmsd = &vmstate_aspeed_wdt;
-    dc->props = aspeed_wdt_properties;
+    device_class_set_props(dc, aspeed_wdt_properties);
 }
 
 static const TypeInfo aspeed_wdt_info = {
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index c2ad22a..919e661 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1332,7 +1332,7 @@ static void xen_device_class_init(ObjectClass *class, void *data)
 
     dev_class->realize = xen_device_realize;
     dev_class->unrealize = xen_device_unrealize;
-    dev_class->props = xen_device_props;
+    device_class_set_props(dev_class, xen_device_props);
     dev_class->bus_type = TYPE_XEN_BUS;
 }
 
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 4412d7aa..4a373b2 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -786,7 +786,7 @@ static void xendev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = xendev_properties;
+    device_class_set_props(dc, xendev_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     /* xen-backend devices can be plugged/unplugged dynamically */
     dc->user_creatable = true;
@@ -824,7 +824,7 @@ static void xen_sysdev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->props = xen_sysdev_properties;
+    device_class_set_props(dc, xen_sysdev_properties);
     dc->bus_type = TYPE_XENSYSBUS;
 }
 
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 9e767d4..b91082c 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -964,7 +964,7 @@ static void xen_pci_passthrough_class_init(ObjectClass *klass, void *data)
     k->config_write = xen_pt_pci_write_config;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "Assign an host PCI device with Xen";
-    dc->props = xen_pci_passthrough_properties;
+    device_class_set_props(dc, xen_pci_passthrough_properties);
 };
 
 static void xen_pci_passthrough_finalize(Object *obj)
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 6b0e7b2..4065162 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -433,6 +433,8 @@ void qdev_machine_init(void);
  */
 void device_reset(DeviceState *dev);
 
+void device_class_set_props(DeviceClass *dc, Property *props);
+
 void device_class_set_parent_reset(DeviceClass *dc,
                                    DeviceReset dev_reset,
                                    DeviceReset *parent_reset);
diff --git a/migration/migration.c b/migration/migration.c
index 990bff0..efd5350 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3514,7 +3514,7 @@ static void migration_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->user_creatable = false;
-    dc->props = migration_properties;
+    device_class_set_props(dc, migration_properties);
 }
 
 static void migration_instance_finalize(Object *obj)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ffe5de0..5fa6acc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4144,7 +4144,7 @@ static void max_x86_cpu_class_init(ObjectClass *oc, void *data)
     xcc->model_description =
         "Enables all features supported by the accelerator in the current host";
 
-    dc->props = max_x86_cpu_properties;
+    device_class_set_props(dc, max_x86_cpu_properties);
 }
 
 static void max_x86_cpu_initfn(Object *obj)
@@ -7161,7 +7161,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
                                     &xcc->parent_realize);
     device_class_set_parent_unrealize(dc, x86_cpu_unrealizefn,
                                       &xcc->parent_unrealize);
-    dc->props = x86_cpu_properties;
+    device_class_set_props(dc, x86_cpu_properties);
 
     cpu_class_set_parent_reset(cc, x86_cpu_reset, &xcc->parent_reset);
     cc->reset_dump_flags = CPU_DUMP_FPU | CPU_DUMP_CCOP;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 71d88f6..8c90110 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -308,7 +308,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_phys_page_debug = mb_cpu_get_phys_page_debug;
 #endif
     dc->vmsd = &vmstate_mb_cpu;
-    dc->props = mb_properties;
+    device_class_set_props(dc, mb_properties);
     cc->gdb_num_core_regs = 32 + 5;
 
     cc->disas_set_info = mb_disas_set_info;
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index bbdbc0c..1c0c855 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -187,7 +187,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, nios2_cpu_realizefn,
                                     &ncc->parent_realize);
-    dc->props = nios2_properties;
+    device_class_set_props(dc, nios2_properties);
     cpu_class_set_parent_reset(cc, nios2_cpu_reset, &ncc->parent_reset);
 
     cc->class_by_name = nios2_cpu_class_by_name;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 5ffd07c..2d3efad 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8599,7 +8599,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER7";
     dc->desc = "POWER7";
-    dc->props = powerpc_servercpu_properties;
+    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match = ppc_pvr_match_power7;
     pcc->pcr_mask = PCR_VEC_DIS | PCR_VSX_DIS | PCR_COMPAT_2_05;
     pcc->pcr_supported = PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -8764,7 +8764,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER8";
     dc->desc = "POWER8";
-    dc->props = powerpc_servercpu_properties;
+    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match = ppc_pvr_match_power8;
     pcc->pcr_mask = PCR_TM_DIS | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->pcr_supported = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -8976,7 +8976,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER9";
     dc->desc = "POWER9";
-    dc->props = powerpc_servercpu_properties;
+    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match = ppc_pvr_match_power9;
     pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07;
     pcc->pcr_supported = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
@@ -9186,7 +9186,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER10";
     dc->desc = "POWER10";
-    dc->props = powerpc_servercpu_properties;
+    device_class_set_props(dc, powerpc_servercpu_properties);
     pcc->pvr_match = ppc_pvr_match_power10;
     pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07 |
                     PCR_COMPAT_3_00;
@@ -10871,7 +10871,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                       &pcc->parent_unrealize);
     pcc->pvr_match = ppc_pvr_match_default;
     pcc->interrupts_big_endian = ppc_cpu_interrupts_big_endian_always;
-    dc->props = ppc_cpu_properties;
+    device_class_set_props(dc, ppc_cpu_properties);
 
     cpu_class_set_parent_reset(cc, ppc_cpu_reset, &pcc->parent_reset);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d6f1872..8c86ebc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -492,7 +492,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 #endif
     /* For now, mark unmigratable: */
     cc->vmsd = &vmstate_riscv_cpu;
-    dc->props = riscv_cpu_properties;
+    device_class_set_props(dc, riscv_cpu_properties);
 }
 
 char *riscv_isa_string(RISCVCPU *cpu)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index ca487f5..cf84d30 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -453,7 +453,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, s390_cpu_realizefn,
                                     &scc->parent_realize);
-    dc->props = s390x_cpu_properties;
+    device_class_set_props(dc, s390x_cpu_properties);
     dc->user_creatable = true;
 
     cpu_class_set_parent_reset(cc, s390_cpu_reset_full, &scc->parent_reset);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 9c306e5..eeaecbd 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -857,7 +857,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, sparc_cpu_realizefn,
                                     &scc->parent_realize);
-    dc->props = sparc_cpu_properties;
+    device_class_set_props(dc, sparc_cpu_properties);
 
     cpu_class_set_parent_reset(cc, sparc_cpu_reset, &scc->parent_reset);
 
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index 4ed3d06..270c690 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -55,7 +55,7 @@ static void static_prop_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = NULL;
-    dc->props = static_props;
+    device_class_set_props(dc, static_props);
 }
 
 static const TypeInfo static_prop_type = {
-- 
1.8.3.1



