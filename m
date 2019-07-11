Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C124C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233A220872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233A220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYCj-0005nO-EP
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hlYBf-0004xf-Dn
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hlYBb-0001ry-I3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hlYBb-0001oy-5O
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7671783F51;
 Thu, 11 Jul 2019 12:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E531960BFB;
 Thu, 11 Jul 2019 12:28:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69EE01138648; Thu, 11 Jul 2019 14:28:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 14:28:24 +0200
Message-Id: <20190711122827.18970-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 11 Jul 2019 12:28:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC v5 0/3] Baby steps towards saner headers
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

Back in 2016, we discussed rules for headers, and these were
generally liked:

1. Have a carefully curated header that's included everywhere first.  We
   got that already thanks to Peter: osdep.h.

2. Headers should normally include everything they need beyond osdep.h.
   If exceptions are needed for some reason, they must be documented in
   the header.  If all that's needed from a header is typedefs, put
   those into qemu/typedefs.h instead of including the header.

3. Cyclic inclusion is forbidden.

Message-ID: <87h9g8j57d.fsf@blackfin.pond.sub.org>
http://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg03345.html

Trouble is we're not exactly close to obeying 2.  This series
demonstrates a possible path towards obeying it: enforce it in "make
check", except for known-bad headers.  We can then whittle down
known-bad headers step by step in future patches.

PATCH 1 adds the tests, but only for include/.  764 headers, 179
known-bad.

PATCH 2 cleans up include/ somewhat.  The work remaining should be
fairly obvious now.  I plan to spin out my cleanups as a separate
non-RFC patch submission.

PATCH 3 makes the tests more thorough in a simple and stupid way.
Massive overkill, painfully slow.  I'm open for better ideas.

Previous iterations had additional patches to test all headers, not
just include/.  I decided to focus in include/ and shelve them for
now.

Testing:

I tested various configurations on an x86 host (everything enabled,
everything disabled, KVM only (TCG disabled), user only, MinGW).  I
also tested lightly on ARM and PPC hosts.  Exhaustive testing is not
practical.  I can't exclude the possibility that the new test fails in
configurations I didn't test.

Known issues:

(1) Many headers are (meant to be) only included into certain
    contexts.  In two places, the code makes its intent explicit:

    * include/exec/cpu-defs.h #errors out when included into
      target-independent code (#ifndef NEED_CPU_H)

    * include/hw/hw.h #errors out when included into user emulation
      code (#ifdef CONFIG_USER_ONLY)

    I manually marked headers including them, so that the test can
    treat them specially.  Better ideas welcome.

    Such #erroring isn't done for other contexts (perhaps it should
    be).  Inclusion into the wrong context fails in various ways
    instead.  The resulting test failures are marked FIXME.  The ones
    that fail by accident (if any) should be fixed.  The ones that
    aren't meant to succeed need to be treated specially by the test.

(2) A few headers are only included into code that's compiled with
    special CFLAGS.  The test doesn't know, and the resulting test
    failures are marked FIXME.  Known instances: include/ui/gtk.h and
    GTK_CFLAGS, include/ui/sdl2.h and SDL_CFLAGS.

Please have a look and tell me what you think.

v5:
* Old PATCH 1-4: Merged in commit 234e256511e
* Old PATCH 6-7: Shelved for now
* PATCH 1:
  - Rebased (uff)
  - Suppress debug info to save disk space
  - Fix .SECONDARY for $(check-bad-target-header-tests)
  - Minor tweaks to make PATCH 3 simpler
  - Add include/hw/xen/interface/ to excluded-headers
  - Rewrite the Make code to find magic comments
  - Test with -Wunused-function to cope with static inline functions
* PATCH 2-3: New

v4:
* PATCH 1-4: New.
* PATCH 5:
  - Implement testing of target-dependent headers
  - Replace crude "expected to fail with WIN32" by a set of "expected
    to fail without FOO".
* Old PATCH 3-5: Dropped.  These were examples for whittling down
  known-bad headers.

v3:
* Old PATH 1 moved to another series
* PATCH 1:
  - Skip the test unless $(SRC_PATH)/.git exists
  - Exclude third-party headers [Peter]
  - Exclude Coccinelle header
  - Fix egrep vs. fgrep typos
  - Mark and exclude headers that die due to poison.h, because testing
    them isn't implemented, yet
  - tests/header-test-template.c not omitted (d'oh)
* PATCH 3: Replaced
* PATCH 5: New

v2:
* PATCH 2:
  - Use fixed-format FIXME comments in headers instead of a blacklist
    in the makefile [Paolo]
  - Make target check-source [Peter]
  - Special-case CONFIG_WIN32
* PATCH 3:
  - replaced by an unrelated one that makes actual sense (I hope)

Markus Armbruster (3):
  tests: New make target check-source
  include: Make headers more self-contained
  tests: Check target-independent headers for each target, too

 Makefile                                  |   4 +-
 Makefile.target                           |  20 ++++
 include/block/raw-aio.h                   |   2 +
 include/block/write-threshold.h           |   2 +
 include/chardev/char-win.h                |   3 +
 include/chardev/spice.h                   |   2 +
 include/disas/disas.h                     |   1 +
 include/exec/cpu-all.h                    |   4 +
 include/exec/cpu-defs.h                   |   3 +
 include/exec/cpu_ldst.h                   |   4 +
 include/exec/cpu_ldst_template.h          |   3 +
 include/exec/cpu_ldst_useronly_template.h |   3 +
 include/exec/cputlb.h                     |   3 +
 include/exec/exec-all.h                   |   3 +
 include/exec/gen-icount.h                 |   2 +
 include/exec/helper-gen.h                 |   2 +
 include/exec/helper-proto.h               |   2 +
 include/exec/helper-tcg.h                 |   2 +
 include/exec/ioport.h                     |   4 +
 include/exec/memory-internal.h            |   4 +
 include/exec/memory_ldst.inc.h            |   2 +
 include/exec/memory_ldst_cached.inc.h     |   2 +
 include/exec/memory_ldst_phys.inc.h       |   2 +
 include/exec/ram_addr.h                   |   3 +
 include/exec/softmmu-semi.h               |   4 +
 include/exec/tb-hash.h                    |   4 +
 include/exec/tb-lookup.h                  |   3 +
 include/exec/translator.h                 |   2 +
 include/exec/user/abitypes.h              |   2 +
 include/exec/user/thunk.h                 |   4 +
 include/fpu/softfloat-macros.h            |   4 +
 include/fpu/softfloat.h                   |   2 +
 include/hw/acpi/acpi.h                    |   2 +
 include/hw/acpi/acpi_dev_interface.h      |   2 +
 include/hw/acpi/cpu.h                     |   3 +
 include/hw/acpi/cpu_hotplug.h             |   2 +
 include/hw/acpi/ich9.h                    |   2 +
 include/hw/acpi/memory_hotplug.h          |   2 +
 include/hw/acpi/pci.h                     |   3 +
 include/hw/acpi/pcihp.h                   |   2 +
 include/hw/acpi/tco.h                     |   5 +
 include/hw/acpi/utils.h                   |   2 +
 include/hw/acpi/vmgenid.h                 |   2 +
 include/hw/adc/stm32f2xx_adc.h            |   4 +
 include/hw/arm/allwinner-a10.h            |   5 +
 include/hw/arm/armsse.h                   |   4 +
 include/hw/arm/armv7m.h                   |   4 +
 include/hw/arm/aspeed.h                   |   3 +
 include/hw/arm/aspeed_soc.h               |   5 +
 include/hw/arm/bcm2835_peripherals.h      |   2 +
 include/hw/arm/bcm2836.h                  |   5 +
 include/hw/arm/digic.h                    |   4 +
 include/hw/arm/exynos4210.h               |   5 +-
 include/hw/arm/fsl-imx25.h                |   5 +
 include/hw/arm/fsl-imx31.h                |   5 +
 include/hw/arm/fsl-imx6.h                 |   4 +
 include/hw/arm/fsl-imx6ul.h               |   4 +
 include/hw/arm/fsl-imx7.h                 |   4 +
 include/hw/arm/msf2-soc.h                 |   4 +
 include/hw/arm/nrf51_soc.h                |   4 +
 include/hw/arm/omap.h                     |   2 +
 include/hw/arm/pxa.h                      |   2 +
 include/hw/arm/sharpsl.h                  |   3 +
 include/hw/arm/smmu-common.h              |   3 +-
 include/hw/arm/smmuv3.h                   |   2 +
 include/hw/arm/soc_dma.h                  |   2 +
 include/hw/arm/stm32f205_soc.h            |   4 +
 include/hw/arm/virt.h                     |   2 +
 include/hw/arm/xlnx-versal.h              |   2 +
 include/hw/arm/xlnx-zynqmp.h              |   5 +
 include/hw/audio/pcspk.h                  |   2 +
 include/hw/audio/wm8750.h                 |   3 +
 include/hw/block/fdc.h                    |   2 +
 include/hw/block/flash.h                  |   3 +
 include/hw/boards.h                       |   2 +
 include/hw/char/bcm2835_aux.h             |   2 +
 include/hw/char/cadence_uart.h            |   2 +
 include/hw/char/cmsdk-apb-uart.h          |   2 +
 include/hw/char/digic-uart.h              |   3 +-
 include/hw/char/escc.h                    |   3 +
 include/hw/char/imx_serial.h              |   2 +
 include/hw/char/lm32_juart.h              |   2 +
 include/hw/char/nrf51_uart.h              |   2 +
 include/hw/char/parallel.h                |   2 +
 include/hw/char/pl011.h                   |   2 +
 include/hw/char/serial.h                  |   2 +
 include/hw/char/stm32f2xx_usart.h         |   2 +
 include/hw/char/xilinx_uartlite.h         |   4 +
 include/hw/core/generic-loader.h          |   1 +
 include/hw/core/split-irq.h               |   3 +
 include/hw/cpu/a15mpcore.h                |   3 +
 include/hw/cpu/a9mpcore.h                 |   3 +
 include/hw/cpu/arm11mpcore.h              |   2 +
 include/hw/cpu/cluster.h                  |   3 +
 include/hw/cpu/core.h                     |   3 +
 include/hw/cris/etraxfs.h                 |   3 +
 include/hw/cris/etraxfs_dma.h             |   3 +
 include/hw/display/bcm2835_fb.h           |   2 +
 include/hw/display/edid.h                 |   2 +
 include/hw/display/i2c-ddc.h              |   3 +
 include/hw/display/milkymist_tmu2.h       |   3 +-
 include/hw/display/vga.h                  |   3 +
 include/hw/display/xlnx_dp.h              |   2 +
 include/hw/dma/bcm2835_dma.h              |   2 +
 include/hw/dma/i8257.h                    |   2 +
 include/hw/dma/pl080.h                    |   2 +
 include/hw/dma/xlnx-zdma.h                |   2 +
 include/hw/dma/xlnx-zynq-devcfg.h         |   2 +
 include/hw/dma/xlnx_dpdma.h               |   2 +
 include/hw/elf_ops.h                      |   2 +
 include/hw/empty_slot.h                   |   2 +
 include/hw/gpio/bcm2835_gpio.h            |   3 +
 include/hw/gpio/imx_gpio.h                |   2 +
 include/hw/gpio/nrf51_gpio.h              |   4 +-
 include/hw/hw.h                           |   2 +
 include/hw/hyperv/hyperv.h                |   2 +
 include/hw/i2c/aspeed_i2c.h               |   4 +
 include/hw/i2c/bitbang_i2c.h              |   2 +
 include/hw/i2c/i2c.h                      |   2 +
 include/hw/i2c/imx_i2c.h                  |   3 +-
 include/hw/i2c/microbit_i2c.h             |   2 +
 include/hw/i2c/pm_smbus.h                 |   2 +
 include/hw/i2c/ppc4xx_i2c.h               |   2 +
 include/hw/i2c/smbus_eeprom.h             |   2 +
 include/hw/i2c/smbus_master.h             |   2 +
 include/hw/i2c/smbus_slave.h              |   2 +
 include/hw/i386/apic_internal.h           |   5 +
 include/hw/i386/ich9.h                    |   2 +
 include/hw/i386/intel_iommu.h             |   2 +
 include/hw/i386/ioapic_internal.h         |   3 +
 include/hw/i386/pc.h                      |   2 +
 include/hw/i386/x86-iommu.h               |   2 +
 include/hw/ide.h                          |   2 +
 include/hw/ide/ahci.h                     |   3 +-
 include/hw/ide/internal.h                 |   2 +
 include/hw/ide/pci.h                      |   2 +
 include/hw/input/adb.h                    |   2 +
 include/hw/input/i8042.h                  |   3 +
 include/hw/input/tsc2xxx.h                |   2 +
 include/hw/intc/allwinner-a10-pic.h       |   4 +
 include/hw/intc/arm_gic.h                 |   2 +
 include/hw/intc/arm_gic_common.h          |   2 +
 include/hw/intc/arm_gicv3.h               |   2 +
 include/hw/intc/arm_gicv3_common.h        |   2 +
 include/hw/intc/arm_gicv3_its_common.h    |   2 +
 include/hw/intc/armv7m_nvic.h             |   4 +
 include/hw/intc/aspeed_vic.h              |   3 +
 include/hw/intc/bcm2835_ic.h              |   2 +
 include/hw/intc/bcm2836_control.h         |   2 +
 include/hw/intc/heathrow_pic.h            |   4 +
 include/hw/intc/imx_avic.h                |   3 +
 include/hw/intc/imx_gpcv2.h               |   2 +
 include/hw/intc/mips_gic.h                |   5 +
 include/hw/intc/realview_gic.h            |   2 +
 include/hw/intc/xlnx-pmu-iomod-intc.h     |   2 +
 include/hw/intc/xlnx-zynqmp-ipi.h         |   2 +
 include/hw/ipack/ipack.h                  |   2 +
 include/hw/ipmi/ipmi.h                    |   2 +
 include/hw/isa/apm.h                      |   2 +
 include/hw/isa/i8259_internal.h           |   2 +
 include/hw/isa/isa.h                      |   2 +
 include/hw/isa/pc87312.h                  |   3 +
 include/hw/isa/superio.h                  |   3 +
 include/hw/isa/vt82c686.h                 |   2 +
 include/hw/kvm/clock.h                    |   2 +
 include/hw/loader.h                       |   2 +
 include/hw/mem/memory-device.h            |   2 +
 include/hw/mem/nvdimm.h                   |   2 +
 include/hw/mem/pc-dimm.h                  |   3 +-
 include/hw/mips/bios.h                    |   2 +
 include/hw/mips/cps.h                     |   5 +
 include/hw/mips/cpudevs.h                 |   2 +
 include/hw/misc/a9scu.h                   |   3 +
 include/hw/misc/arm11scu.h                |   2 +
 include/hw/misc/armsse-cpuid.h            |   2 +
 include/hw/misc/armsse-mhu.h              |   2 +
 include/hw/misc/aspeed_scu.h              |   3 +
 include/hw/misc/aspeed_sdmc.h             |   3 +
 include/hw/misc/aspeed_xdma.h             |   2 +
 include/hw/misc/auxbus.h                  |   3 +-
 include/hw/misc/bcm2835_mbox.h            |   2 +
 include/hw/misc/bcm2835_property.h        |   2 +
 include/hw/misc/bcm2835_rng.h             |   2 +
 include/hw/misc/imx25_ccm.h               |   2 +
 include/hw/misc/imx2_wdt.h                |   2 +
 include/hw/misc/imx31_ccm.h               |   2 +
 include/hw/misc/imx6_ccm.h                |   2 +
 include/hw/misc/imx6_src.h                |   2 +
 include/hw/misc/imx6ul_ccm.h              |   2 +
 include/hw/misc/imx7_ccm.h                |   2 +
 include/hw/misc/imx7_gpr.h                |   2 +
 include/hw/misc/imx7_snvs.h               |   2 +
 include/hw/misc/imx_ccm.h                 |   2 +
 include/hw/misc/iotkit-secctl.h           |   2 +
 include/hw/misc/iotkit-sysctl.h           |   2 +
 include/hw/misc/iotkit-sysinfo.h          |   2 +
 include/hw/misc/macio/cuda.h              |   4 +
 include/hw/misc/macio/gpio.h              |   5 +
 include/hw/misc/macio/macio.h             |   4 +
 include/hw/misc/macio/pmu.h               |   5 +
 include/hw/misc/mips_cmgcr.h              |   5 +-
 include/hw/misc/mips_cpc.h                |   4 +
 include/hw/misc/mips_itu.h                |   2 +
 include/hw/misc/mos6522.h                 |   2 +
 include/hw/misc/mps2-fpgaio.h             |   2 +
 include/hw/misc/mps2-scc.h                |   2 +
 include/hw/misc/msf2-sysreg.h             |   2 +
 include/hw/misc/nrf51_rng.h               |   3 +-
 include/hw/misc/pca9552.h                 |   3 +
 include/hw/misc/pvpanic.h                 |   3 +
 include/hw/misc/stm32f2xx_syscfg.h        |   2 +
 include/hw/misc/tz-mpc.h                  |   2 +
 include/hw/misc/tz-msc.h                  |   2 +
 include/hw/misc/tz-ppc.h                  |   2 +
 include/hw/misc/unimp.h                   |   2 +
 include/hw/misc/vmcoreinfo.h              |   4 +-
 include/hw/misc/zynq-xadc.h               |   2 +
 include/hw/net/allwinner_emac.h           |   4 +-
 include/hw/net/cadence_gem.h              |   2 +
 include/hw/net/ftgmac100.h                |   2 +
 include/hw/net/imx_fec.h                  |   2 +
 include/hw/net/lance.h                    |   3 +
 include/hw/net/ne2000-isa.h               |   2 +
 include/hw/nvram/chrp_nvram.h             |   2 +
 include/hw/nvram/fw_cfg.h                 |   2 +
 include/hw/nvram/nrf51_nvm.h              |   4 +-
 include/hw/or-irq.h                       |   2 +
 include/hw/pci-bridge/simba.h             |   2 +
 include/hw/pci-host/designware.h          |   2 +
 include/hw/pci-host/gpex.h                |   2 +
 include/hw/pci-host/pam.h                 |   2 +
 include/hw/pci-host/q35.h                 |   2 +
 include/hw/pci-host/sabre.h               |   4 +
 include/hw/pci-host/spapr.h               |   3 +
 include/hw/pci-host/uninorth.h            |   4 +-
 include/hw/pci-host/xilinx-pcie.h         |   2 +
 include/hw/pci/msi.h                      |   2 +
 include/hw/pci/msix.h                     |   2 +
 include/hw/pci/pci.h                      |   2 +
 include/hw/pci/pci_bridge.h               |   3 +-
 include/hw/pci/pci_bus.h                  |   2 +
 include/hw/pci/pci_host.h                 |   2 +
 include/hw/pci/pcie.h                     |   2 +
 include/hw/pci/pcie_aer.h                 |   3 +
 include/hw/pci/pcie_host.h                |   2 +
 include/hw/pci/pcie_port.h                |   2 +
 include/hw/pci/shpc.h                     |   2 +
 include/hw/pcmcia.h                       |   2 +
 include/hw/platform-bus.h                 |   2 +
 include/hw/ppc/fdt.h                      |   2 +
 include/hw/ppc/mac_dbdma.h                |   2 +
 include/hw/ppc/openpic.h                  |   2 +
 include/hw/ppc/pnv.h                      |   3 +
 include/hw/ppc/pnv_core.h                 |   4 +
 include/hw/ppc/pnv_lpc.h                  |   2 +
 include/hw/ppc/pnv_occ.h                  |   2 +
 include/hw/ppc/pnv_psi.h                  |   2 +
 include/hw/ppc/pnv_xive.h                 |   2 +
 include/hw/ppc/pnv_xscom.h                |   2 +
 include/hw/ppc/ppc.h                      |   2 +
 include/hw/ppc/ppc4xx.h                   |   7 ++
 include/hw/ppc/spapr.h                    |   3 +
 include/hw/ppc/spapr_cpu_core.h           |   4 +
 include/hw/ppc/spapr_drc.h                |   2 +
 include/hw/ppc/spapr_irq.h                |   5 +
 include/hw/ppc/spapr_ovec.h               |   2 +
 include/hw/ppc/spapr_vio.h                |  11 +-
 include/hw/ppc/spapr_xive.h               |   5 +
 include/hw/ppc/xics.h                     |   3 +-
 include/hw/ppc/xics_spapr.h               |   3 +
 include/hw/ppc/xive.h                     |   3 +-
 include/hw/ppc/xive_regs.h                |   3 +
 include/hw/qdev.h                         |   2 +
 include/hw/register.h                     |   2 +
 include/hw/riscv/boot.h                   |   4 +
 include/hw/riscv/riscv_hart.h             |   6 ++
 include/hw/riscv/riscv_htif.h             |   3 +
 include/hw/riscv/sifive_clint.h           |   4 +
 include/hw/riscv/sifive_e.h               |   4 +
 include/hw/riscv/sifive_gpio.h            |   3 +
 include/hw/riscv/sifive_plic.h            |   4 +-
 include/hw/riscv/sifive_prci.h            |   4 +
 include/hw/riscv/sifive_test.h            |   4 +
 include/hw/riscv/sifive_u.h               |   4 +
 include/hw/riscv/sifive_uart.h            |   5 +
 include/hw/riscv/spike.h                  |   6 ++
 include/hw/riscv/virt.h                   |   6 ++
 include/hw/s390x/3270-ccw.h               |   3 +
 include/hw/s390x/ap-device.h              |   3 +
 include/hw/s390x/css-bridge.h             |   5 +-
 include/hw/s390x/css.h                    |   4 +
 include/hw/s390x/event-facility.h         |   3 +-
 include/hw/s390x/s390-ccw.h               |   3 +
 include/hw/s390x/s390-virtio-ccw.h        |   3 +
 include/hw/s390x/s390_flic.h              |   2 +
 include/hw/s390x/sclp.h                   |   3 +-
 include/hw/s390x/storage-attributes.h     |   3 +
 include/hw/s390x/storage-keys.h           |   2 +
 include/hw/s390x/tod.h                    |   4 +-
 include/hw/s390x/vfio-ccw.h               |   3 +
 include/hw/scsi/esp.h                     |   2 +
 include/hw/scsi/scsi.h                    |   2 +
 include/hw/sd/bcm2835_sdhost.h            |   2 +
 include/hw/sd/sd.h                        |   2 +
 include/hw/sd/sdhci.h                     |   2 +
 include/hw/semihosting/console.h          |   4 +
 include/hw/sh4/sh.h                       |   2 +
 include/hw/sh4/sh_intc.h                  |   3 +
 include/hw/sparc/grlib.h                  |   2 +
 include/hw/sparc/sparc32_dma.h            |   2 +
 include/hw/sparc/sparc64.h                |   4 +
 include/hw/sparc/sun4m_iommu.h            |   2 +
 include/hw/sparc/sun4u_iommu.h            |   2 +
 include/hw/ssi/aspeed_smc.h               |   3 +
 include/hw/ssi/imx_spi.h                  |   2 +
 include/hw/ssi/mss-spi.h                  |   2 +
 include/hw/ssi/pl022.h                    |   2 +
 include/hw/ssi/ssi.h                      |   2 +
 include/hw/ssi/stm32f2xx_spi.h            |   2 +
 include/hw/ssi/xilinx_spips.h             |   3 +
 include/hw/sysbus.h                       |   2 +
 include/hw/timer/a9gtimer.h               |   2 +
 include/hw/timer/allwinner-a10-pit.h      |   3 +
 include/hw/timer/arm_mptimer.h            |   3 +
 include/hw/timer/armv7m_systick.h         |   2 +
 include/hw/timer/aspeed_rtc.h             |   3 +
 include/hw/timer/aspeed_timer.h           |   3 +
 include/hw/timer/cmsdk-apb-dualtimer.h    |   2 +
 include/hw/timer/cmsdk-apb-timer.h        |   2 +
 include/hw/timer/digic-timer.h            |   3 +-
 include/hw/timer/i8254.h                  |   2 +
 include/hw/timer/i8254_internal.h         |   3 +
 include/hw/timer/imx_epit.h               |   2 +
 include/hw/timer/imx_gpt.h                |   2 +
 include/hw/timer/m48t59.h                 |   2 +
 include/hw/timer/mc146818rtc.h            |   2 +
 include/hw/timer/mc146818rtc_regs.h       |   2 +
 include/hw/timer/mss-timer.h              |   2 +
 include/hw/timer/nrf51_timer.h            |   3 +
 include/hw/timer/pl031.h                  |   2 +
 include/hw/timer/stm32f2xx_timer.h        |   2 +
 include/hw/timer/sun4v-rtc.h              |   7 ++
 include/hw/timer/xlnx-zynqmp-rtc.h        |   3 +
 include/hw/usb.h                          |   2 +
 include/hw/usb/chipidea.h                 |   2 +
 include/hw/vfio/vfio-amd-xgbe.h           |   2 +
 include/hw/vfio/vfio-calxeda-xgmac.h      |   2 +
 include/hw/vfio/vfio-common.h             |   2 +
 include/hw/vfio/vfio-platform.h           |   2 +
 include/hw/virtio/vhost-backend.h         |   3 +-
 include/hw/virtio/vhost-scsi-common.h     |   3 +-
 include/hw/virtio/vhost-scsi.h            |   3 +-
 include/hw/virtio/vhost-user-blk.h        |   3 +-
 include/hw/virtio/vhost-user-scsi.h       |   3 +-
 include/hw/virtio/vhost-user.h            |   2 +
 include/hw/virtio/vhost-vsock.h           |   2 +
 include/hw/virtio/vhost.h                 |   2 +
 include/hw/virtio/virtio-access.h         |   4 +
 include/hw/virtio/virtio-balloon.h        |   3 +-
 include/hw/virtio/virtio-blk.h            |   3 +-
 include/hw/virtio/virtio-bus.h            |   3 +-
 include/hw/virtio/virtio-crypto.h         |   2 +
 include/hw/virtio/virtio-gpu-bswap.h      |   1 +
 include/hw/virtio/virtio-gpu-pci.h        |   2 +
 include/hw/virtio/virtio-gpu-pixman.h     |   2 +
 include/hw/virtio/virtio-gpu.h            |   2 +
 include/hw/virtio/virtio-input.h          |   2 +
 include/hw/virtio/virtio-net.h            |   3 +-
 include/hw/virtio/virtio-pmem.h           |   2 +
 include/hw/virtio/virtio-rng.h            |   3 +
 include/hw/virtio/virtio-scsi.h           |   3 +-
 include/hw/virtio/virtio-serial.h         |   3 +-
 include/hw/virtio/virtio.h                |   3 +-
 include/hw/watchdog/cmsdk-apb-watchdog.h  |   2 +
 include/hw/watchdog/wdt_aspeed.h          |   3 +
 include/hw/watchdog/wdt_diag288.h         |   2 +
 include/hw/xen/xen-backend.h              |   3 +
 include/hw/xen/xen-block.h                |   3 +
 include/hw/xen/xen-bus-helper.h           |   3 +
 include/hw/xen/xen-bus.h                  |   3 +
 include/hw/xen/xen-legacy-backend.h       |   3 +
 include/hw/xen/xen.h                      |   2 +
 include/hw/xen/xen_common.h               |   3 +
 include/hw/xen/xen_pvdev.h                |   3 +
 include/libdecnumber/decNumberLocal.h     |   1 +
 include/migration/cpu.h                   |   5 +
 include/monitor/hmp-target.h              |   4 +
 include/net/vhost_net.h                   |   2 +
 include/qemu/atomic128.h                  |   2 +
 include/qemu/cpuid.h                      |   2 +
 include/qemu/futex.h                      |   2 +
 include/qemu/iova-tree.h                  |   3 +
 include/qemu/ratelimit.h                  |   2 +
 include/qemu/thread-win32.h               |   4 +-
 include/qemu/xattr.h                      |   3 +
 include/sysemu/balloon.h                  |   4 +-
 include/sysemu/cryptodev-vhost-user.h     |   6 +-
 include/sysemu/cryptodev-vhost.h          |   4 +-
 include/sysemu/dma.h                      |   2 +
 include/sysemu/dump.h                     |   3 +
 include/sysemu/hostmem.h                  |   2 +
 include/sysemu/hvf.h                      |   3 +
 include/sysemu/iothread.h                 |   1 +
 include/sysemu/kvm_int.h                  |   5 +-
 include/sysemu/memory_mapping.h           |   5 +
 include/sysemu/numa.h                     |   2 +
 include/sysemu/os-posix.h                 |   2 +
 include/sysemu/os-win32.h                 |   2 +
 include/sysemu/vhost-user-backend.h       |   3 +
 include/sysemu/xen-mapcache.h             |   5 +-
 include/trace-tcg.h                       |   2 +
 include/ui/console.h                      |   2 +
 include/ui/egl-context.h                  |   3 +
 include/ui/egl-helpers.h                  |   6 ++
 include/ui/gtk.h                          |   2 +
 include/ui/input.h                        |   1 +
 include/ui/pixel_ops.h                    |   5 +
 include/ui/qemu-pixman.h                  |   2 +
 include/ui/sdl2.h                         |   2 +
 include/ui/shader.h                       |   2 +
 include/ui/spice-display.h                |   4 +
 target/hppa/cpu.h                         |   2 +-
 tests/Makefile.include                    |  33 +++++-
 tests/check-headers.mak                   | 116 ++++++++++++++++++++++
 tests/header-test-template.c              |  23 +++++
 425 files changed, 1292 insertions(+), 50 deletions(-)
 create mode 100644 tests/check-headers.mak
 create mode 100644 tests/header-test-template.c

--=20
2.21.0


