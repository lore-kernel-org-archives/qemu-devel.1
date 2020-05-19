Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04339C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54B12075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbEqJ6KY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54B12075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4A0-0006Cj-Uk
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3fO-0001zm-70
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f4-0003Ye-Nl
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SSAJkj7Upw4+GjA3bthSuswUhlL6hNXBycRT3DeJxuI=;
 b=DbEqJ6KYdmnrGwyub4oeBiWPD6kL1uvp+aUSXoXjLmr2XE9BI1RSlWFXBbxeuJEDqlmbzX
 ZsGfxkilhTohFfJOvwt4BCckpIrSVF4K3ovFFDpY2MbFdYfWkIE9wFo4J2e4eK/sdDMTek
 XKrzt6sy9/01rQ0/kJrazz5Qz1TuSUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-Qax84jMuOjexOnFKpLoWLQ-1; Tue, 19 May 2020 10:56:01 -0400
X-MC-Unique: Qax84jMuOjexOnFKpLoWLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00084805726;
 Tue, 19 May 2020 14:55:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 384AD79B6;
 Tue, 19 May 2020 14:55:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE31911358BC; Tue, 19 May 2020 16:55:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/55] qdev: Rework how we plug into the parent bus
Date: Tue, 19 May 2020 16:54:56 +0200
Message-Id: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo recently suggested "to move the bus argument (and thus
qdev_set_parent_bus) to qdev_init"[1], and that it "would be quite
large but hopefully scriptable"[2].  Nerd sniped!

The series is big, but at least the bigger patches are all mechanical.

It is based on my "[PATCH 00/24] Fixes around device realization".

I'm abstaining from cc'ing maintainers on mechanical conversions.  I
still cc: for patches I deem interesting, with related patches thrown
in for context.  Let me know if you think I should cc: more widely.

PATCH 01-02  	Preliminary cleanup
PATCH 03     	New qdev infrastructure
      	     	Commit message explains why the current state is
      	     	problematic, and how my work improves it.
PATCH 04-11  	Convert direct users of qdev
PATCH 12-16  	Convert PCI
PATCH 17-20  	Convert ISA
PATCH 21-24  	Convert SSI
PATCH 25-28  	Convert USB
PATCH 29     	Garbage collection
PATCH 30-32  	Convert aux-bus
PATCH 33-40  	Clean up around child device initialization
PATCH 41-49  	Convert sysbus
PATCH 50     	Stop pretending recursive realization is about to become
      	     	real
PATCH 51-53  	Convert bus-less devices
PATCH 54	Garbage collection
PATCH 55	Maintain MAINTAINERS

Enjoy!


[1]
Subject: Re: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
Date: Mon, 4 May 2020 16:58:54 +0200
Message-ID: <6fc8633a-6d91-b83a-e6cd-5f714ccaf9ea@redhat.com>

[2]
Subject: Re: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
Date: Tue, 5 May 2020 18:26:57 +0200
Message-ID: <a4df3ba3-4759-56ac-68f8-f75eea93e27e@redhat.com>

Based-on: <20200518050408.4579-1-armbru@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Alistair Francis <alistair@alistair23.me>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>

Markus Armbruster (55):
  qdev: Rename qbus_realize() to qbus_init()
  qdev: Drop redundant bus realization
  qdev: New qdev_new(), qdev_realize(), etc.
  qdev: Put qdev_new() to use with Coccinelle
  qdev: Convert to qbus_realize(), qbus_unrealize()
  qdev: Convert to qdev_unrealize() with Coccinelle
  qdev: Convert to qdev_unrealize() manually
  qdev: Convert uses of qdev_create() with Coccinelle
  qdev: Convert uses of qdev_create() manually
  qdev: Convert uses of qdev_set_parent_bus() with Coccinelle
  qdev: Convert uses of qdev_set_parent_bus() manually
  pci: New pci_new(), pci_realize_and_unref() etc.
  hw/ppc: Eliminate two superfluous QOM casts
  pci: Convert uses of pci_create() etc. with Coccinelle
  pci: Convert uses of pci_create() etc. manually
  pci: pci_create(), pci_create_multifunction() are now unused, drop
  isa: New isa_new(), isa_realize_and_unref() etc.
  isa: Convert uses of isa_create() with Coccinelle
  isa: Convert uses of isa_create(), isa_try_create() manually
  isa: isa_create(), isa_try_create() are now unused, drop
  ssi: ssi_auto_connect_slaves() never does anything, drop
  ssi: Convert uses of ssi_create_slave_no_init() with Coccinelle
  ssi: Convert last use of ssi_create_slave_no_init() manually
  ssi: ssi_create_slave_no_init() is now unused, drop
  usb: New usb_new(), usb_realize_and_unref()
  usb: Convert uses of usb_create()
  usb: usb_create() is now unused, drop
  usb: Eliminate usb_try_create_simple()
  qdev: qdev_create(), qdev_try_create() are now unused, drop
  auxbus: New aux_realize_bus(), pairing with aux_init_bus()
  auxbus: Convert a use of qdev_set_parent_bus()
  auxbus: Eliminate aux_create_slave()
  qom: Tidy up a few object_initialize_child() calls
  qom: Less verbose object_initialize_child()
  macio: Convert use of qdev_set_parent_bus()
  macio: Eliminate macio_init_child_obj()
  sysbus: Drop useless OBJECT() in sysbus_init_child_obj() calls
  microbit: Tidy up sysbus_init_child_obj() @child argument
  sysbus: Tidy up sysbus_init_child_obj()'s @childsize arg, part 1
  hw/arm/armsse: Pass correct child size to sysbus_init_child_obj()
  sysbus: Tidy up sysbus_init_child_obj()'s @childsize arg, part 2
  sysbus: New sysbus_realize(), sysbus_realize_and_unref()
  sysbus: Convert to sysbus_realize() etc. with Coccinelle
  qdev: Drop qdev_realize() support for null bus
  sysbus: Convert qdev_set_parent_bus() use with Coccinelle, part 1
  sysbus: Convert qdev_set_parent_bus() use with Coccinelle, part 2
  sysbus: Convert qdev_set_parent_bus() use with Coccinelle, part 3
  sysbus: Convert qdev_set_parent_bus() use with Coccinelle, part 4
  sysbus: sysbus_init_child_obj() is now unused, drop
  s390x/event-facility: Simplify creation of SCLP event devices
  qdev: Make qdev_realize() support bus-less devices
  qdev: Use qdev_realize() in qdev_device_add()
  qdev: Convert bus-less devices to qdev_realize() with Coccinelle
  qdev: qdev_init_nofail() is now unused, drop
  MAINTAINERS: Make section QOM cover hw/core/*bus.c as well

 hw/lm32/lm32.h                           |  13 +-
 hw/lm32/milkymist-hw.h                   |  37 ++---
 include/hw/audio/pcspk.h                 |   5 +-
 include/hw/char/cadence_uart.h           |   5 +-
 include/hw/char/cmsdk-apb-uart.h         |   4 +-
 include/hw/char/pl011.h                  |   9 +-
 include/hw/char/xilinx_uartlite.h        |   4 +-
 include/hw/cris/etraxfs.h                |   4 +-
 include/hw/isa/isa.h                     |   5 +-
 include/hw/misc/auxbus.h                 |  14 +-
 include/hw/misc/unimp.h                  |   5 +-
 include/hw/net/ne2000-isa.h              |   5 +-
 include/hw/pci/pci.h                     |   6 +-
 include/hw/qdev-core.h                   |  13 +-
 include/hw/ssi/ssi.h                     |   5 -
 include/hw/sysbus.h                      |  19 +--
 include/hw/timer/cmsdk-apb-timer.h       |   4 +-
 include/hw/timer/i8254.h                 |   9 +-
 include/hw/usb.h                         |   6 +-
 include/qom/object.h                     |  30 +++-
 hw/acpi/pcihp.c                          |   2 +-
 hw/acpi/piix4.c                          |   6 +-
 hw/alpha/typhoon.c                       |   4 +-
 hw/arm/allwinner-a10.c                   |  50 +++----
 hw/arm/allwinner-h3.c                    |  57 +++-----
 hw/arm/armsse.c                          | 174 +++++++++--------------
 hw/arm/armv7m.c                          |  12 +-
 hw/arm/aspeed.c                          |  18 ++-
 hw/arm/aspeed_ast2600.c                  | 110 ++++++--------
 hw/arm/aspeed_soc.c                      |  84 +++++------
 hw/arm/bcm2835_peripherals.c             |  71 ++++-----
 hw/arm/bcm2836.c                         |  17 +--
 hw/arm/cubieboard.c                      |   6 +-
 hw/arm/digic.c                           |  16 +--
 hw/arm/digic_boards.c                    |   2 +-
 hw/arm/exynos4210.c                      |  48 +++----
 hw/arm/exynos4_boards.c                  |  11 +-
 hw/arm/fsl-imx25.c                       |  60 ++++----
 hw/arm/fsl-imx31.c                       |  39 +++--
 hw/arm/fsl-imx6.c                        |  76 ++++------
 hw/arm/fsl-imx6ul.c                      | 105 +++++---------
 hw/arm/fsl-imx7.c                        | 100 +++++--------
 hw/arm/highbank.c                        |  28 ++--
 hw/arm/imx25_pdk.c                       |  10 +-
 hw/arm/integratorcp.c                    |   6 +-
 hw/arm/kzm.c                             |   5 +-
 hw/arm/mcimx6ul-evk.c                    |   7 +-
 hw/arm/mcimx7d-sabre.c                   |   7 +-
 hw/arm/microbit.c                        |  12 +-
 hw/arm/mps2-tz.c                         |  79 +++++-----
 hw/arm/mps2.c                            |  26 ++--
 hw/arm/msf2-soc.c                        |  25 ++--
 hw/arm/msf2-som.c                        |  12 +-
 hw/arm/musca.c                           |  60 ++++----
 hw/arm/musicpal.c                        |   8 +-
 hw/arm/netduino2.c                       |   4 +-
 hw/arm/netduinoplus2.c                   |   4 +-
 hw/arm/nrf51_soc.c                       |  30 ++--
 hw/arm/nseries.c                         |   8 +-
 hw/arm/omap1.c                           |  16 +--
 hw/arm/omap2.c                           |  16 +--
 hw/arm/orangepi.c                        |   6 +-
 hw/arm/pxa2xx.c                          |   8 +-
 hw/arm/pxa2xx_gpio.c                     |   5 +-
 hw/arm/pxa2xx_pic.c                      |   5 +-
 hw/arm/raspi.c                           |  10 +-
 hw/arm/realview.c                        |  22 +--
 hw/arm/sabrelite.c                       |   6 +-
 hw/arm/sbsa-ref.c                        |  26 ++--
 hw/arm/spitz.c                           |   4 +-
 hw/arm/stellaris.c                       |  12 +-
 hw/arm/stm32f205_soc.c                   |  34 ++---
 hw/arm/stm32f405_soc.c                   |  45 +++---
 hw/arm/strongarm.c                       |   9 +-
 hw/arm/versatilepb.c                     |  18 +--
 hw/arm/vexpress.c                        |  18 +--
 hw/arm/virt.c                            |  38 ++---
 hw/arm/xilinx_zynq.c                     |  44 +++---
 hw/arm/xlnx-versal-virt.c                |  15 +-
 hw/arm/xlnx-versal.c                     |  53 +++----
 hw/arm/xlnx-zcu102.c                     |  26 ++--
 hw/arm/xlnx-zynqmp.c                     |  92 +++++-------
 hw/audio/intel-hda.c                     |   4 +-
 hw/block/fdc.c                           |  16 +--
 hw/block/nand.c                          |   4 +-
 hw/block/pflash_cfi01.c                  |   4 +-
 hw/block/pflash_cfi02.c                  |   4 +-
 hw/block/xen-block.c                     |   4 +-
 hw/char/exynos4210_uart.c                |   5 +-
 hw/char/mcf_uart.c                       |   5 +-
 hw/char/parallel-isa.c                   |   5 +-
 hw/char/serial-isa.c                     |   9 +-
 hw/char/serial-pci-multi.c               |   8 +-
 hw/char/serial-pci.c                     |   7 +-
 hw/char/serial.c                         |  14 +-
 hw/char/spapr_vty.c                      |   4 +-
 hw/core/bus.c                            |  23 ++-
 hw/core/cpu.c                            |   2 +-
 hw/core/empty_slot.c                     |   5 +-
 hw/core/qdev.c                           | 132 +++++++++--------
 hw/core/sysbus.c                         |  27 ++--
 hw/cpu/a15mpcore.c                       |   5 +-
 hw/cpu/a9mpcore.c                        |  23 ++-
 hw/cpu/arm11mpcore.c                     |  18 ++-
 hw/cpu/realview_mpcore.c                 |  10 +-
 hw/cris/axis_dev88.c                     |   4 +-
 hw/display/ati.c                         |   4 +-
 hw/display/milkymist-tmu2.c              |   4 +-
 hw/display/sm501.c                       |  12 +-
 hw/display/virtio-gpu-pci.c              |   3 +-
 hw/display/virtio-vga.c                  |   3 +-
 hw/display/xlnx_dp.c                     |  11 +-
 hw/dma/i8257.c                           |   9 +-
 hw/dma/pxa2xx_dma.c                      |   8 +-
 hw/dma/rc4030.c                          |   5 +-
 hw/dma/sparc32_dma.c                     |  16 +--
 hw/dma/xilinx_axidma.c                   |   9 +-
 hw/hppa/dino.c                           |   4 +-
 hw/hppa/lasi.c                           |   4 +-
 hw/hppa/machine.c                        |   4 +-
 hw/hyperv/hyperv.c                       |   2 +-
 hw/i2c/core.c                            |   5 +-
 hw/i2c/smbus_eeprom.c                    |   4 +-
 hw/i386/amd_iommu.c                      |   3 +-
 hw/i386/pc.c                             |  12 +-
 hw/i386/pc_q35.c                         |  14 +-
 hw/i386/pc_sysfw.c                       |   4 +-
 hw/i386/x86.c                            |   8 +-
 hw/ide/isa.c                             |   5 +-
 hw/ide/microdrive.c                      |   3 +-
 hw/ide/qdev.c                            |   4 +-
 hw/intc/armv7m_nvic.c                    |  15 +-
 hw/intc/exynos4210_gic.c                 |   5 +-
 hw/intc/i8259_common.c                   |   5 +-
 hw/intc/pnv_xive.c                       |  10 +-
 hw/intc/realview_gic.c                   |   4 +-
 hw/intc/s390_flic.c                      |   6 +-
 hw/intc/spapr_xive.c                     |  10 +-
 hw/intc/xics.c                           |   2 +-
 hw/intc/xive.c                           |   2 +-
 hw/isa/isa-bus.c                         |  27 ++--
 hw/isa/isa-superio.c                     |  20 +--
 hw/isa/piix4.c                           |   3 +-
 hw/isa/vt82c686.c                        |  13 +-
 hw/m68k/mcf5208.c                        |   4 +-
 hw/m68k/mcf_intc.c                       |   5 +-
 hw/m68k/next-cube.c                      |  12 +-
 hw/m68k/q800.c                           |  36 ++---
 hw/microblaze/petalogix_ml605_mmu.c      |  26 ++--
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  14 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          |  21 ++-
 hw/mips/boston.c                         |  13 +-
 hw/mips/cps.c                            |  20 ++-
 hw/mips/gt64xxx_pci.c                    |   5 +-
 hw/mips/mips_fulong2e.c                  |   6 +-
 hw/mips/mips_jazz.c                      |  16 +--
 hw/mips/mips_malta.c                     |   9 +-
 hw/mips/mips_mipssim.c                   |   8 +-
 hw/misc/auxbus.c                         |  16 +--
 hw/misc/mac_via.c                        |  12 +-
 hw/misc/macio/cuda.c                     |   7 +-
 hw/misc/macio/macio.c                    |  56 +++-----
 hw/misc/macio/pmu.c                      |   7 +-
 hw/net/etraxfs_eth.c                     |   4 +-
 hw/net/fsl_etsec/etsec.c                 |   5 +-
 hw/net/lan9118.c                         |   5 +-
 hw/net/lasi_i82596.c                     |   5 +-
 hw/net/smc91c111.c                       |   5 +-
 hw/net/spapr_llan.c                      |   4 +-
 hw/net/xilinx_axienet.c                  |   9 +-
 hw/nios2/10m50_devboard.c                |  12 +-
 hw/nvram/fw_cfg.c                        |   8 +-
 hw/openrisc/openrisc_sim.c               |   8 +-
 hw/pci-bridge/dec.c                      |   6 +-
 hw/pci-bridge/pci_expander_bridge.c      |   8 +-
 hw/pci-host/bonito.c                     |   9 +-
 hw/pci-host/designware.c                 |   6 +-
 hw/pci-host/gpex.c                       |   6 +-
 hw/pci-host/i440fx.c                     |   4 +-
 hw/pci-host/pnv_phb3.c                   |  21 ++-
 hw/pci-host/pnv_phb4.c                   |  11 +-
 hw/pci-host/pnv_phb4_pec.c               |   8 +-
 hw/pci-host/prep.c                       |   7 +-
 hw/pci-host/q35.c                        |   6 +-
 hw/pci-host/sabre.c                      |  13 +-
 hw/pci-host/versatile.c                  |   4 +-
 hw/pci-host/xilinx-pcie.c                |   6 +-
 hw/pci/pci.c                             |  31 ++--
 hw/pci/pcie.c                            |   2 +-
 hw/pci/shpc.c                            |   2 +-
 hw/pcmcia/pxa2xx.c                       |   5 +-
 hw/ppc/e500.c                            |  32 ++---
 hw/ppc/mac_newworld.c                    |  46 +++---
 hw/ppc/mac_oldworld.c                    |  26 ++--
 hw/ppc/pnv.c                             | 103 ++++++--------
 hw/ppc/pnv_bmc.c                         |   2 +-
 hw/ppc/pnv_core.c                        |   2 +-
 hw/ppc/pnv_psi.c                         |  10 +-
 hw/ppc/ppc440_uc.c                       |   8 +-
 hw/ppc/prep.c                            |  35 +++--
 hw/ppc/sam460ex.c                        |   4 +-
 hw/ppc/spapr.c                           |  27 ++--
 hw/ppc/spapr_cpu_core.c                  |   2 +-
 hw/ppc/spapr_drc.c                       |   2 +-
 hw/ppc/spapr_iommu.c                     |   2 +-
 hw/ppc/spapr_irq.c                       |   6 +-
 hw/ppc/spapr_pci.c                       |   3 +-
 hw/ppc/spapr_vio.c                       |   4 +-
 hw/ppc/virtex_ml507.c                    |   9 +-
 hw/riscv/riscv_hart.c                    |   7 +-
 hw/riscv/sifive_clint.c                  |   5 +-
 hw/riscv/sifive_e.c                      |  20 +--
 hw/riscv/sifive_e_prci.c                 |   5 +-
 hw/riscv/sifive_plic.c                   |   5 +-
 hw/riscv/sifive_test.c                   |   5 +-
 hw/riscv/sifive_u.c                      |  52 +++----
 hw/riscv/spike.c                         |  21 ++-
 hw/riscv/virt.c                          |  15 +-
 hw/rtc/m48t59-isa.c                      |   7 +-
 hw/rtc/m48t59.c                          |   5 +-
 hw/rtc/mc146818rtc.c                     |   4 +-
 hw/rtc/sun4v-rtc.c                       |   5 +-
 hw/s390x/ap-bridge.c                     |   4 +-
 hw/s390x/css-bridge.c                    |   6 +-
 hw/s390x/event-facility.c                |  59 ++++----
 hw/s390x/s390-pci-bus.c                  |   8 +-
 hw/s390x/s390-skeys.c                    |   2 +-
 hw/s390x/s390-stattrib.c                 |   2 +-
 hw/s390x/s390-virtio-ccw.c               |  16 +--
 hw/s390x/sclp.c                          |  12 +-
 hw/s390x/tod.c                           |   2 +-
 hw/s390x/vhost-vsock-ccw.c               |   3 +-
 hw/s390x/virtio-ccw-9p.c                 |   3 +-
 hw/s390x/virtio-ccw-balloon.c            |   3 +-
 hw/s390x/virtio-ccw-blk.c                |   3 +-
 hw/s390x/virtio-ccw-crypto.c             |   3 +-
 hw/s390x/virtio-ccw-gpu.c                |   3 +-
 hw/s390x/virtio-ccw-input.c              |   3 +-
 hw/s390x/virtio-ccw-net.c                |   3 +-
 hw/s390x/virtio-ccw-rng.c                |   3 +-
 hw/s390x/virtio-ccw-scsi.c               |   6 +-
 hw/s390x/virtio-ccw-serial.c             |   3 +-
 hw/scsi/scsi-bus.c                       |   4 +-
 hw/scsi/spapr_vscsi.c                    |   4 +-
 hw/sd/aspeed_sdhci.c                     |   2 +-
 hw/sd/milkymist-memcard.c                |   4 +-
 hw/sd/pxa2xx_mmci.c                      |   8 +-
 hw/sd/ssi-sd.c                           |   4 +-
 hw/sh4/r2d.c                             |  12 +-
 hw/sparc/leon3.c                         |  20 +--
 hw/sparc/sun4m.c                         |  64 ++++-----
 hw/sparc64/sun4u.c                       |  50 ++++---
 hw/ssi/aspeed_smc.c                      |   1 -
 hw/ssi/imx_spi.c                         |   2 -
 hw/ssi/mss-spi.c                         |   1 -
 hw/ssi/ssi.c                             |  43 +-----
 hw/ssi/xilinx_spi.c                      |   1 -
 hw/ssi/xilinx_spips.c                    |   4 -
 hw/usb/bus.c                             |  52 +++----
 hw/usb/dev-serial.c                      |   4 +-
 hw/virtio/vhost-scsi-pci.c               |   3 +-
 hw/virtio/vhost-user-blk-pci.c           |   3 +-
 hw/virtio/vhost-user-fs-pci.c            |   3 +-
 hw/virtio/vhost-user-scsi-pci.c          |   3 +-
 hw/virtio/vhost-vsock-pci.c              |   3 +-
 hw/virtio/virtio-9p-pci.c                |   3 +-
 hw/virtio/virtio-balloon-pci.c           |   3 +-
 hw/virtio/virtio-blk-pci.c               |   3 +-
 hw/virtio/virtio-crypto-pci.c            |   3 +-
 hw/virtio/virtio-input-pci.c             |   3 +-
 hw/virtio/virtio-iommu-pci.c             |   3 +-
 hw/virtio/virtio-net-pci.c               |   3 +-
 hw/virtio/virtio-pmem-pci.c              |   3 +-
 hw/virtio/virtio-rng-pci.c               |   3 +-
 hw/virtio/virtio-scsi-pci.c              |   3 +-
 hw/virtio/virtio-serial-pci.c            |   3 +-
 hw/virtio/virtio.c                       |   5 +-
 hw/xen/xen-bus.c                         |   4 +-
 hw/xen/xen-legacy-backend.c              |   7 +-
 hw/xtensa/virt.c                         |   4 +-
 hw/xtensa/xtfpga.c                       |   8 +-
 migration/migration.c                    |   2 +-
 qdev-monitor.c                           |   8 +-
 qom/object.c                             |  19 ++-
 target/i386/cpu.c                        |   3 +-
 tests/test-qdev-global-props.c           |   8 +-
 MAINTAINERS                              |   2 +
 287 files changed, 1942 insertions(+), 2348 deletions(-)

-- 
2.21.1


