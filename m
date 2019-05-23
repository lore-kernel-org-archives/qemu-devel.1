Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AEDC04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D227220881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D227220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59819 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTjAT-0000kP-7R
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 04:33:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTj2W-0002Lr-FO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTit6-0000sO-AL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:15:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTit4-0000rc-Hw
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:15:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 883675946B;
	Thu, 23 May 2019 08:15:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5604B1001F41;
	Thu, 23 May 2019 08:15:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id DA34C1138648; Thu, 23 May 2019 10:15:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 10:15:31 +0200
Message-Id: <20190523081538.2291-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 23 May 2019 08:15:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 0/7] Baby steps towards saner headers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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

PATCH 1-4 are preparatory build system improvements.  I think they are
useful by themselves.  If reviewers agree, I can extract them into
their own non-RFC series.

PATCH 5 adds the tests, but only for include/.  764 headers, 179
known-bad.  We may decide to clean up include/ some before we apply
PATCH 6+7.

PATCH 6 extends them to all headers, except for generated ones.  Adds
797 headers, 409 known-bad.

PATCH 7 extends them to generated headers.  Adds 177 headers, 3
known-bad.

Known issues:

(1) More testing needed.

(2) PATCH 7 has a FIXME on computation of generated target-dependent
    headers.

(3) Some "known-bad" headers aren't actually bad, but intended for
    special configurations only.  The test should be taught how to
    test these correctly.

We obviously want (1) before we merge the test.

I think we can and should address (3) when we whittle down known-bad
headers in future patches.

I think leaving PATCH 6-7 for later would make sense.  No need to
crack (2) right now then.

Please have a look and tell me what you think.


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

Markus Armbruster (7):
  Makefile: Remove code to smooth transition to config.status
  Makefile: Drop bogus cleaning of $(ALL_SUBDIRS)/qemu-options.def
  Makefile: Rename targets for make recursion
  Makefile: Reuse all's recursion machinery for clean and install
  tests: New make target check-source
  tests: Don't limit check-headers to include/
  tests: Make check-source cover generated headers

 Makefile                                   | 75 +++++++++++-----------
 Makefile.target                            | 19 ++++++
 accel/tcg/atomic_template.h                |  3 +
 accel/tcg/tcg-runtime.h                    |  3 +
 accel/tcg/translate-all.h                  |  4 ++
 audio/audio_int.h                          |  2 +
 audio/audio_template.h                     |  2 +
 audio/audio_win_int.h                      |  2 +
 audio/dsound_template.h                    |  3 +
 audio/mixeng_template.h                    |  2 +
 audio/rate_template.h                      |  2 +
 block/crypto.h                             |  2 +
 block/qcow2.h                              |  2 +
 block/vhdx.h                               |  2 +
 bsd-user/i386/target_signal.h              |  3 +
 bsd-user/i386/target_syscall.h             |  2 +
 bsd-user/qemu.h                            |  4 ++
 bsd-user/sparc/target_signal.h             |  3 +
 bsd-user/sparc/target_syscall.h            |  2 +
 bsd-user/sparc64/target_signal.h           |  3 +
 bsd-user/sparc64/target_syscall.h          |  2 +
 bsd-user/syscall_defs.h                    |  2 +
 bsd-user/x86_64/target_signal.h            |  3 +
 bsd-user/x86_64/target_syscall.h           |  2 +
 configure                                  |  6 +-
 contrib/ivshmem-client/ivshmem-client.h    |  2 +
 contrib/ivshmem-server/ivshmem-server.h    |  2 +
 contrib/libvhost-user/libvhost-user-glib.h |  2 +
 contrib/libvhost-user/libvhost-user.h      |  2 +
 contrib/rdmacm-mux/rdmacm-mux.h            |  2 +
 crypto/afalgpriv.h                         |  2 +
 crypto/cipherpriv.h                        |  2 +
 crypto/hashpriv.h                          |  2 +
 crypto/hmacpriv.h                          |  2 +
 disas/nanomips.h                           |  2 +
 fpu/softfloat-specialize.h                 |  3 +
 fsdev/file-op-9p.h                         |  2 +
 fsdev/qemu-fsdev.h                         |  3 +
 hw/9pfs/9p-local.h                         |  2 +
 hw/9pfs/9p-proxy.h                         |  2 +
 hw/9pfs/9p-synth.h                         |  2 +
 hw/9pfs/9p-util.h                          |  2 +
 hw/9pfs/9p-xattr.h                         |  2 +
 hw/9pfs/9p.h                               |  2 +
 hw/9pfs/coth.h                             |  2 +
 hw/9pfs/virtio-9p.h                        |  2 +
 hw/9pfs/xen-9pfs.h                         |  3 +-
 hw/arm/smmu-internal.h                     |  2 +
 hw/arm/smmuv3-internal.h                   |  2 +
 hw/audio/hda-codec-common.h                |  3 +-
 hw/audio/lm4549.h                          |  2 +
 hw/block/dataplane/xen-block.h             |  2 +
 hw/block/nvme.h                            |  2 +
 hw/block/xen_blkif.h                       |  2 +
 hw/cris/boot.h                             |  2 +
 hw/display/ati_int.h                       |  2 +
 hw/display/cirrus_vga_internal.h           |  2 +
 hw/display/cirrus_vga_rop.h                |  2 +
 hw/display/cirrus_vga_rop2.h               |  2 +
 hw/display/framebuffer.h                   |  2 +
 hw/display/milkymist-vgafb_template.h      |  3 +-
 hw/display/omap_lcd_template.h             |  3 +
 hw/display/pl110_template.h                |  2 +
 hw/display/pxa2xx_template.h               |  2 +
 hw/display/qxl.h                           |  4 ++
 hw/display/sm501_template.h                |  2 +
 hw/display/tc6393xb_template.h             |  2 +
 hw/display/vga-helpers.h                   |  2 +
 hw/display/vga_int.h                       |  2 +
 hw/ide/ahci_internal.h                     |  2 +
 hw/input/adb-internal.h                    |  2 +
 hw/lm32/lm32.h                             |  2 +
 hw/lm32/lm32_hwsetup.h                     |  3 +
 hw/lm32/milkymist-hw.h                     |  2 +
 hw/microblaze/boot.h                       |  2 +
 hw/net/can/can_sja1000.h                   |  3 +
 hw/net/e1000e_core.h                       |  2 +
 hw/net/e1000x_common.h                     |  2 +
 hw/net/pcnet.h                             |  2 +
 hw/net/rocker/rocker_desc.h                |  2 +
 hw/net/rocker/rocker_fp.h                  |  2 +
 hw/net/rocker/rocker_of_dpa.h              |  2 +
 hw/net/rocker/rocker_tlv.h                 |  2 +
 hw/net/rocker/rocker_world.h               |  2 +
 hw/net/vmware_utils.h                      |  2 +
 hw/net/vmxnet3_defs.h                      |  3 +-
 hw/nios2/boot.h                            |  3 +
 hw/ppc/ppc405.h                            |  2 +
 hw/ppc/ppc440.h                            |  2 +
 hw/rdma/rdma_backend.h                     |  2 +
 hw/rdma/rdma_backend_defs.h                |  2 +
 hw/rdma/rdma_rm.h                          |  2 +
 hw/rdma/rdma_rm_defs.h                     |  2 +
 hw/rdma/vmw/pvrdma.h                       |  2 +
 hw/rdma/vmw/pvrdma_dev_ring.h              |  2 +
 hw/rdma/vmw/pvrdma_qp_ops.h                |  2 +
 hw/s390x/ccw-device.h                      |  3 +
 hw/s390x/ipl.h                             |  3 +
 hw/s390x/s390-pci-bus.h                    |  3 +
 hw/s390x/s390-pci-inst.h                   |  3 +
 hw/s390x/s390-virtio-hcall.h               |  2 +
 hw/s390x/virtio-ccw.h                      |  3 +
 hw/scsi/mptsas.h                           |  2 +
 hw/scsi/viosrp.h                           |  3 +
 hw/sd/sdhci-internal.h                     |  3 +
 hw/timer/m48t59-internal.h                 |  2 +
 hw/tpm/tpm_ioctl.h                         |  2 +
 hw/usb/desc.h                              |  2 +
 hw/usb/hcd-ohci.h                          |  2 +
 hw/usb/hcd-xhci.h                          |  2 +
 hw/usb/quirks.h                            |  2 +
 hw/vfio/pci.h                              |  3 +
 hw/xen/xen_pt.h                            |  2 +
 hw/xtensa/bootparam.h                      |  2 +
 hw/xtensa/xtensa_memory.h                  |  3 +
 include/block/raw-aio.h                    |  3 +
 include/block/write-threshold.h            |  3 +
 include/chardev/char-win.h                 |  3 +
 include/chardev/spice.h                    |  2 +
 include/disas/disas.h                      |  2 +
 include/exec/cpu-all.h                     |  4 ++
 include/exec/cpu-defs.h                    |  4 ++
 include/exec/cpu_ldst.h                    |  4 ++
 include/exec/cpu_ldst_template.h           |  3 +
 include/exec/cpu_ldst_useronly_template.h  |  3 +
 include/exec/cputlb.h                      |  3 +
 include/exec/exec-all.h                    |  3 +
 include/exec/gen-icount.h                  |  2 +
 include/exec/helper-gen.h                  |  2 +
 include/exec/helper-proto.h                |  2 +
 include/exec/helper-tcg.h                  |  2 +
 include/exec/ioport.h                      |  2 +
 include/exec/memory-internal.h             |  2 +
 include/exec/memory_ldst.inc.h             |  2 +
 include/exec/memory_ldst_cached.inc.h      |  2 +
 include/exec/memory_ldst_phys.inc.h        |  2 +
 include/exec/ram_addr.h                    |  3 +
 include/exec/softmmu-semi.h                |  3 +
 include/exec/tb-hash.h                     |  3 +
 include/exec/tb-lookup.h                   |  3 +
 include/exec/translator.h                  |  3 +
 include/exec/user/abitypes.h               |  2 +
 include/exec/user/thunk.h                  |  4 ++
 include/fpu/softfloat-macros.h             |  2 +
 include/fpu/softfloat.h                    |  2 +
 include/hw/acpi/piix4.h                    |  2 +
 include/hw/acpi/tco.h                      |  3 +
 include/hw/adc/stm32f2xx_adc.h             |  2 +
 include/hw/arm/allwinner-a10.h             |  2 +
 include/hw/arm/armsse.h                    |  3 +
 include/hw/arm/armv7m.h                    |  3 +
 include/hw/arm/aspeed_soc.h                |  2 +
 include/hw/arm/bcm2835_peripherals.h       |  2 +
 include/hw/arm/bcm2836.h                   |  2 +
 include/hw/arm/digic.h                     |  3 +
 include/hw/arm/fsl-imx25.h                 |  2 +
 include/hw/arm/fsl-imx31.h                 |  2 +
 include/hw/arm/fsl-imx6.h                  |  3 +
 include/hw/arm/fsl-imx6ul.h                |  3 +
 include/hw/arm/fsl-imx7.h                  |  3 +
 include/hw/arm/msf2-soc.h                  |  3 +
 include/hw/arm/nrf51_soc.h                 |  3 +
 include/hw/arm/omap.h                      |  3 +
 include/hw/arm/sharpsl.h                   |  3 +
 include/hw/arm/stm32f205_soc.h             |  3 +
 include/hw/arm/xlnx-zynqmp.h               |  2 +
 include/hw/block/fdc.h                     |  2 +
 include/hw/block/flash.h                   |  2 +
 include/hw/char/escc.h                     |  2 +
 include/hw/char/xilinx_uartlite.h          |  2 +
 include/hw/core/generic-loader.h           |  2 +
 include/hw/cris/etraxfs.h                  |  2 +
 include/hw/cris/etraxfs_dma.h              |  2 +
 include/hw/display/bcm2835_fb.h            |  2 +
 include/hw/display/i2c-ddc.h               |  2 +
 include/hw/display/xlnx_dp.h               |  2 +
 include/hw/dma/xlnx_dpdma.h                |  2 +
 include/hw/elf_ops.h                       |  2 +
 include/hw/empty_slot.h                    |  2 +
 include/hw/gpio/bcm2835_gpio.h             |  2 +
 include/hw/hyperv/hyperv.h                 |  2 +
 include/hw/i2c/aspeed_i2c.h                |  3 +
 include/hw/i386/apic_internal.h            |  3 +
 include/hw/i386/ioapic_internal.h          |  2 +
 include/hw/input/hid.h                     |  2 +
 include/hw/input/tsc2xxx.h                 |  2 +
 include/hw/intc/allwinner-a10-pic.h        |  2 +
 include/hw/intc/armv7m_nvic.h              |  3 +
 include/hw/intc/heathrow_pic.h             |  2 +
 include/hw/intc/mips_gic.h                 |  3 +
 include/hw/isa/vt82c686.h                  |  2 +
 include/hw/kvm/clock.h                     |  4 +-
 include/hw/mips/bios.h                     |  2 +
 include/hw/mips/cps.h                      |  3 +
 include/hw/mips/cpudevs.h                  |  2 +
 include/hw/misc/bcm2835_property.h         |  2 +
 include/hw/misc/macio/cuda.h               |  2 +
 include/hw/misc/macio/gpio.h               |  2 +
 include/hw/misc/macio/macio.h              |  2 +
 include/hw/misc/macio/pmu.h                |  2 +
 include/hw/misc/mips_cmgcr.h               |  2 +
 include/hw/misc/mips_cpc.h                 |  2 +
 include/hw/misc/pvpanic.h                  |  3 +
 include/hw/net/allwinner_emac.h            |  2 +
 include/hw/net/lance.h                     |  2 +
 include/hw/nvram/chrp_nvram.h              |  2 +
 include/hw/pci-bridge/simba.h              |  2 +
 include/hw/pci-host/sabre.h                |  2 +
 include/hw/pci-host/spapr.h                |  3 +
 include/hw/pci-host/uninorth.h             |  2 +
 include/hw/pci/pcie_aer.h                  |  2 +
 include/hw/ppc/fdt.h                       |  2 +
 include/hw/ppc/pnv.h                       |  2 +
 include/hw/ppc/pnv_core.h                  |  2 +
 include/hw/ppc/pnv_xscom.h                 |  2 +
 include/hw/ppc/ppc.h                       |  2 +
 include/hw/ppc/ppc4xx.h                    |  2 +
 include/hw/ppc/spapr.h                     |  3 +
 include/hw/ppc/spapr_cpu_core.h            |  4 ++
 include/hw/ppc/spapr_irq.h                 |  2 +
 include/hw/ppc/spapr_ovec.h                |  2 +
 include/hw/ppc/spapr_vio.h                 |  2 +
 include/hw/ppc/spapr_xive.h                |  2 +
 include/hw/ppc/xics_spapr.h                |  3 +
 include/hw/ppc/xive_regs.h                 |  2 +
 include/hw/riscv/riscv_hart.h              |  2 +
 include/hw/riscv/riscv_htif.h              |  3 +
 include/hw/riscv/sifive_clint.h            |  2 +
 include/hw/riscv/sifive_e.h                |  2 +
 include/hw/riscv/sifive_plic.h             |  2 +
 include/hw/riscv/sifive_prci.h             |  2 +
 include/hw/riscv/sifive_test.h             |  2 +
 include/hw/riscv/sifive_u.h                |  2 +
 include/hw/riscv/sifive_uart.h             |  2 +
 include/hw/riscv/spike.h                   |  2 +
 include/hw/riscv/virt.h                    |  2 +
 include/hw/s390x/3270-ccw.h                |  3 +
 include/hw/s390x/ap-device.h               |  3 +
 include/hw/s390x/css-bridge.h              |  2 +
 include/hw/s390x/css.h                     |  3 +
 include/hw/s390x/s390-ccw.h                |  3 +
 include/hw/s390x/storage-attributes.h      |  3 +
 include/hw/s390x/tod.h                     |  2 +
 include/hw/s390x/vfio-ccw.h                |  3 +
 include/hw/sh4/sh.h                        |  2 +
 include/hw/sh4/sh_intc.h                   |  2 +
 include/hw/sparc/grlib.h                   |  2 +
 include/hw/sparc/sparc64.h                 |  1 +
 include/hw/ssi/aspeed_smc.h                |  2 +
 include/hw/ssi/xilinx_spips.h              |  2 +
 include/hw/timer/allwinner-a10-pit.h       |  2 +
 include/hw/timer/i8254_internal.h          |  2 +
 include/hw/timer/m48t59.h                  |  2 +
 include/hw/timer/mc146818rtc.h             |  2 +
 include/hw/timer/mc146818rtc_regs.h        |  2 +
 include/hw/timer/sun4v-rtc.h               |  2 +
 include/hw/timer/xlnx-zynqmp-rtc.h         |  2 +
 include/hw/vfio/vfio-amd-xgbe.h            |  2 +
 include/hw/vfio/vfio-calxeda-xgmac.h       |  2 +
 include/hw/vfio/vfio-common.h              |  2 +
 include/hw/vfio/vfio-platform.h            |  2 +
 include/hw/virtio/virtio-access.h          |  3 +
 include/hw/virtio/virtio-gpu.h             |  2 +
 include/hw/virtio/virtio-input.h           |  2 +
 include/hw/virtio/virtio-rng.h             |  2 +
 include/hw/xen/io/ring.h                   |  2 +
 include/hw/xen/xen-backend.h               |  2 +
 include/hw/xen/xen-block.h                 |  2 +
 include/hw/xen/xen-bus-helper.h            |  2 +
 include/hw/xen/xen-bus.h                   |  2 +
 include/hw/xen/xen-legacy-backend.h        |  2 +
 include/hw/xen/xen_common.h                |  2 +
 include/hw/xen/xen_pvdev.h                 |  2 +
 include/libdecnumber/decNumberLocal.h      |  2 +
 include/migration/cpu.h                    |  4 ++
 include/monitor/hmp-target.h               |  3 +
 include/qemu/atomic128.h                   |  2 +
 include/qemu/futex.h                       |  2 +
 include/qemu/ratelimit.h                   |  2 +
 include/qemu/thread-win32.h                |  2 +
 include/qemu/xattr.h                       |  3 +
 include/sysemu/balloon.h                   |  2 +
 include/sysemu/cryptodev-vhost-user.h      |  3 +
 include/sysemu/dump.h                      |  2 +
 include/sysemu/hvf.h                       |  3 +
 include/sysemu/iothread.h                  |  2 +
 include/sysemu/kvm_int.h                   |  2 +
 include/sysemu/memory_mapping.h            |  2 +
 include/sysemu/os-posix.h                  |  2 +
 include/sysemu/os-win32.h                  |  2 +
 include/sysemu/xen-mapcache.h              |  2 +
 include/trace-tcg.h                        |  2 +
 include/ui/console.h                       |  2 +
 include/ui/egl-context.h                   |  3 +
 include/ui/egl-helpers.h                   |  2 +
 include/ui/gtk.h                           |  2 +
 include/ui/input.h                         |  2 +
 include/ui/pixel_ops.h                     |  2 +
 include/ui/qemu-pixman.h                   |  2 +
 include/ui/sdl2.h                          |  2 +
 include/ui/shader.h                        |  2 +
 include/ui/spice-display.h                 |  2 +
 linux-user/aarch64/target_cpu.h            |  3 +
 linux-user/aarch64/target_fcntl.h          |  3 +
 linux-user/aarch64/target_signal.h         |  2 +
 linux-user/aarch64/target_structs.h        |  3 +
 linux-user/aarch64/target_syscall.h        |  3 +
 linux-user/aarch64/termbits.h              |  2 +
 linux-user/alpha/target_cpu.h              |  3 +
 linux-user/alpha/target_fcntl.h            |  3 +
 linux-user/alpha/target_signal.h           |  2 +
 linux-user/alpha/target_structs.h          |  3 +
 linux-user/alpha/target_syscall.h          |  2 +
 linux-user/alpha/termbits.h                |  2 +
 linux-user/arm/nwfpe/fpa11.h               |  3 +
 linux-user/arm/nwfpe/fpopcode.h            |  2 +
 linux-user/arm/target_cpu.h                |  3 +
 linux-user/arm/target_fcntl.h              |  3 +
 linux-user/arm/target_signal.h             |  2 +
 linux-user/arm/target_structs.h            |  3 +
 linux-user/arm/target_syscall.h            |  3 +
 linux-user/arm/termbits.h                  |  2 +
 linux-user/cpu_loop-common.h               |  3 +
 linux-user/cris/target_cpu.h               |  3 +
 linux-user/cris/target_fcntl.h             |  3 +
 linux-user/cris/target_signal.h            |  2 +
 linux-user/cris/target_structs.h           |  3 +
 linux-user/cris/termbits.h                 |  2 +
 linux-user/fd-trans.h                      |  2 +
 linux-user/flat.h                          |  2 +
 linux-user/generic/fcntl.h                 |  3 +
 linux-user/host/aarch64/hostdep.h          |  2 +
 linux-user/host/arm/hostdep.h              |  2 +
 linux-user/host/i386/hostdep.h             |  2 +
 linux-user/host/ppc64/hostdep.h            |  2 +
 linux-user/host/riscv64/hostdep.h          |  2 +
 linux-user/host/s390x/hostdep.h            |  2 +
 linux-user/host/x86_64/hostdep.h           |  2 +
 linux-user/hppa/target_cpu.h               |  3 +
 linux-user/hppa/target_fcntl.h             |  3 +
 linux-user/hppa/target_signal.h            |  2 +
 linux-user/hppa/target_structs.h           |  3 +
 linux-user/hppa/target_syscall.h           |  2 +
 linux-user/hppa/termbits.h                 |  2 +
 linux-user/i386/target_cpu.h               |  3 +
 linux-user/i386/target_fcntl.h             |  3 +
 linux-user/i386/target_signal.h            |  2 +
 linux-user/i386/target_structs.h           |  3 +
 linux-user/i386/target_syscall.h           |  2 +
 linux-user/i386/termbits.h                 |  2 +
 linux-user/ioctls.h                        |  2 +
 linux-user/linux_loop.h                    |  2 +
 linux-user/m68k/target_cpu.h               |  2 +
 linux-user/m68k/target_elf.h               |  2 +
 linux-user/m68k/target_fcntl.h             |  3 +
 linux-user/m68k/target_signal.h            |  2 +
 linux-user/m68k/target_structs.h           |  3 +
 linux-user/m68k/target_syscall.h           |  2 +
 linux-user/m68k/termbits.h                 |  2 +
 linux-user/microblaze/target_cpu.h         |  3 +
 linux-user/microblaze/target_fcntl.h       |  3 +
 linux-user/microblaze/target_signal.h      |  2 +
 linux-user/microblaze/target_structs.h     |  3 +
 linux-user/microblaze/termbits.h           |  2 +
 linux-user/mips/target_cpu.h               |  3 +
 linux-user/mips/target_elf.h               |  2 +
 linux-user/mips/target_fcntl.h             |  3 +
 linux-user/mips/target_signal.h            |  3 +
 linux-user/mips/target_structs.h           |  3 +
 linux-user/mips/target_syscall.h           |  2 +
 linux-user/mips/termbits.h                 |  2 +
 linux-user/mips64/syscall_nr.h             |  2 +
 linux-user/mips64/target_cpu.h             |  3 +
 linux-user/mips64/target_elf.h             |  2 +
 linux-user/mips64/target_fcntl.h           |  3 +
 linux-user/mips64/target_signal.h          |  2 +
 linux-user/mips64/target_structs.h         |  2 +
 linux-user/mips64/target_syscall.h         |  2 +
 linux-user/mips64/termbits.h               |  2 +
 linux-user/nios2/target_cpu.h              |  2 +
 linux-user/nios2/target_fcntl.h            |  3 +
 linux-user/nios2/target_signal.h           |  2 +
 linux-user/nios2/target_structs.h          |  3 +
 linux-user/nios2/termbits.h                |  2 +
 linux-user/openrisc/target_cpu.h           |  2 +
 linux-user/openrisc/target_fcntl.h         |  3 +
 linux-user/openrisc/target_signal.h        |  2 +
 linux-user/openrisc/target_structs.h       |  3 +
 linux-user/openrisc/target_syscall.h       |  3 +
 linux-user/openrisc/termbits.h             |  2 +
 linux-user/ppc/syscall_nr.h                |  3 +
 linux-user/ppc/target_cpu.h                |  4 ++
 linux-user/ppc/target_elf.h                |  2 +
 linux-user/ppc/target_fcntl.h              |  3 +
 linux-user/ppc/target_signal.h             |  3 +
 linux-user/ppc/target_structs.h            |  3 +
 linux-user/ppc/target_syscall.h            |  3 +
 linux-user/ppc/termbits.h                  |  2 +
 linux-user/qemu.h                          |  2 +
 linux-user/riscv/target_cpu.h              |  2 +
 linux-user/riscv/target_fcntl.h            |  3 +
 linux-user/riscv/target_signal.h           |  2 +
 linux-user/riscv/target_structs.h          |  3 +
 linux-user/riscv/target_syscall.h          |  2 +
 linux-user/riscv/termbits.h                |  2 +
 linux-user/s390x/syscall_nr.h              |  2 +
 linux-user/s390x/target_cpu.h              |  3 +
 linux-user/s390x/target_fcntl.h            |  3 +
 linux-user/s390x/target_signal.h           |  2 +
 linux-user/s390x/target_structs.h          |  3 +
 linux-user/s390x/target_syscall.h          |  2 +
 linux-user/s390x/termbits.h                |  2 +
 linux-user/sh4/target_cpu.h                |  3 +
 linux-user/sh4/target_fcntl.h              |  3 +
 linux-user/sh4/target_signal.h             |  2 +
 linux-user/sh4/target_structs.h            |  3 +
 linux-user/sh4/target_syscall.h            |  2 +
 linux-user/sh4/termbits.h                  |  2 +
 linux-user/signal-common.h                 |  3 +
 linux-user/socket.h                        |  2 +
 linux-user/sparc/target_cpu.h              |  4 ++
 linux-user/sparc/target_elf.h              |  2 +
 linux-user/sparc/target_fcntl.h            |  3 +
 linux-user/sparc/target_signal.h           |  2 +
 linux-user/sparc/target_structs.h          |  3 +
 linux-user/sparc/target_syscall.h          |  2 +
 linux-user/sparc/termbits.h                |  2 +
 linux-user/sparc64/target_cpu.h            |  3 +
 linux-user/sparc64/target_fcntl.h          |  3 +
 linux-user/sparc64/target_signal.h         |  2 +
 linux-user/sparc64/target_structs.h        |  3 +
 linux-user/sparc64/target_syscall.h        |  3 +
 linux-user/sparc64/termbits.h              |  2 +
 linux-user/syscall_defs.h                  |  2 +
 linux-user/syscall_types.h                 |  2 +
 linux-user/tilegx/target_cpu.h             |  3 +
 linux-user/tilegx/target_fcntl.h           |  3 +
 linux-user/tilegx/target_signal.h          |  2 +
 linux-user/tilegx/target_structs.h         |  3 +
 linux-user/tilegx/target_syscall.h         |  2 +
 linux-user/uname.h                         |  2 +
 linux-user/x86_64/target_cpu.h             |  3 +
 linux-user/x86_64/target_fcntl.h           |  3 +
 linux-user/x86_64/target_signal.h          |  2 +
 linux-user/x86_64/target_structs.h         |  3 +
 linux-user/x86_64/target_syscall.h         |  2 +
 linux-user/x86_64/termbits.h               |  2 +
 linux-user/xtensa/target_cpu.h             |  3 +
 linux-user/xtensa/target_elf.h             |  2 +
 linux-user/xtensa/target_fcntl.h           |  3 +
 linux-user/xtensa/target_signal.h          |  2 +
 linux-user/xtensa/target_structs.h         |  3 +
 linux-user/xtensa/target_syscall.h         |  2 +
 linux-user/xtensa/termbits.h               |  2 +
 migration/postcopy-ram.h                   |  3 +
 migration/qemu-file.h                      |  2 +
 net/colo-compare.h                         |  2 +
 qemu-options-wrapper.h                     |  1 +
 qga/guest-agent-core.h                     |  3 +
 qga/service-win32.h                        |  2 +
 qga/vss-win32.h                            |  2 +
 qga/vss-win32/install.h                    |  2 +
 qga/vss-win32/requester.h                  |  2 +
 qga/vss-win32/vss-common.h                 |  2 +
 replay/replay-internal.h                   |  2 +
 replication.h                              |  2 +
 target/alpha/cpu.h                         |  3 +
 target/alpha/helper.h                      |  2 +
 target/arm/arm-powerctl.h                  |  3 +
 target/arm/arm_ldst.h                      |  3 +
 target/arm/cpu.h                           |  3 +
 target/arm/helper-a64.h                    |  3 +
 target/arm/helper-sve.h                    |  2 +
 target/arm/helper.h                        |  3 +
 target/arm/internals.h                     |  2 +
 target/arm/kvm-consts.h                    |  4 ++
 target/arm/kvm_arm.h                       |  3 +
 target/arm/op_addsub.h                     |  2 +
 target/arm/translate-a64.h                 |  2 +
 target/arm/translate.h                     |  3 +
 target/cris/cpu.h                          |  3 +
 target/cris/helper.h                       |  2 +
 target/cris/mmu.h                          |  2 +
 target/hppa/cpu.h                          |  3 +
 target/hppa/helper.h                       |  2 +
 target/i386/cc_helper_template.h           |  2 +
 target/i386/cpu-qom.h                      |  3 +
 target/i386/cpu.h                          |  3 +
 target/i386/hax-i386.h                     |  3 +
 target/i386/hax-posix.h                    |  2 +
 target/i386/hax-windows.h                  |  2 +
 target/i386/helper.h                       |  3 +
 target/i386/hvf/hvf-i386.h                 |  3 +
 target/i386/hvf/vmcs.h                     |  2 +
 target/i386/hvf/vmx.h                      |  2 +
 target/i386/hvf/x86.h                      |  2 +
 target/i386/hvf/x86_decode.h               |  3 +
 target/i386/hvf/x86_descr.h                |  2 +
 target/i386/hvf/x86_emu.h                  |  3 +
 target/i386/hvf/x86_flags.h                |  3 +
 target/i386/hvf/x86_mmu.h                  |  2 +
 target/i386/hvf/x86_task.h                 |  2 +
 target/i386/hvf/x86hvf.h                   |  4 ++
 target/i386/hyperv.h                       |  3 +
 target/i386/kvm_i386.h                     |  3 +
 target/i386/ops_sse.h                      |  3 +
 target/i386/ops_sse_header.h               |  4 ++
 target/i386/sev_i386.h                     |  3 +
 target/i386/shift_helper_template.h        |  2 +
 target/i386/whp-dispatch.h                 |  2 +
 target/lm32/cpu.h                          |  3 +
 target/lm32/helper.h                       |  2 +
 target/m68k/cpu.h                          |  3 +
 target/m68k/helper.h                       |  3 +
 target/m68k/softfloat.h                    |  2 +
 target/m68k/softfloat_fpsp_tables.h        |  2 +
 target/microblaze/cpu.h                    |  3 +
 target/microblaze/helper.h                 |  2 +
 target/microblaze/mmu.h                    |  2 +
 target/mips/cpu-qom.h                      |  3 +
 target/mips/cpu.h                          |  3 +
 target/mips/helper.h                       |  3 +
 target/mips/internal.h                     |  3 +
 target/mips/kvm_mips.h                     |  2 +
 target/mips/mips-defs.h                    |  2 +
 target/moxie/cpu.h                         |  3 +
 target/moxie/helper.h                      |  2 +
 target/moxie/machine.h                     |  2 +
 target/moxie/mmu.h                         |  2 +
 target/nios2/cpu.h                         |  3 +
 target/nios2/helper.h                      |  2 +
 target/nios2/mmu.h                         |  2 +
 target/openrisc/cpu.h                      |  3 +
 target/openrisc/exception.h                |  3 +
 target/openrisc/helper.h                   |  2 +
 target/ppc/cpu-models.h                    |  3 +
 target/ppc/cpu-qom.h                       |  3 +
 target/ppc/cpu.h                           |  3 +
 target/ppc/helper.h                        |  3 +
 target/ppc/helper_regs.h                   |  3 +
 target/ppc/internal.h                      |  3 +
 target/ppc/kvm_ppc.h                       |  3 +
 target/ppc/mmu-book3s-v3.h                 |  3 +
 target/ppc/mmu-hash32.h                    |  2 +
 target/ppc/mmu-hash64.h                    |  3 +
 target/ppc/mmu-radix64.h                   |  3 +
 target/riscv/cpu.h                         |  3 +
 target/riscv/helper.h                      |  2 +
 target/riscv/instmap.h                     |  2 +
 target/riscv/pmp.h                         |  2 +
 target/s390x/cpu.h                         |  2 +
 target/s390x/cpu_features.h                |  2 +
 target/s390x/cpu_models.h                  |  2 +
 target/s390x/helper.h                      |  2 +
 target/s390x/internal.h                    |  2 +
 target/s390x/tcg_s390x.h                   |  2 +
 target/sh4/cpu.h                           |  3 +
 target/sh4/helper.h                        |  2 +
 target/sparc/cpu-qom.h                     |  3 +
 target/sparc/cpu.h                         |  3 +
 target/sparc/helper.h                      |  3 +
 target/tilegx/cpu.h                        |  3 +
 target/tilegx/helper.h                     |  2 +
 target/tricore/cpu.h                       |  3 +
 target/tricore/helper.h                    |  2 +
 target/tricore/tricore-defs.h              |  2 +
 target/tricore/tricore-opcodes.h           |  2 +
 target/unicore32/cpu.h                     |  3 +
 target/unicore32/helper.h                  |  2 +
 target/xtensa/cpu.h                        |  3 +
 target/xtensa/helper.h                     |  2 +
 target/xtensa/overlay_tool.h               |  3 +
 target/xtensa/xtensa-isa-internal.h        |  2 +
 tcg/aarch64/tcg-target.h                   |  2 +
 tcg/aarch64/tcg-target.opc.h               |  3 +
 tcg/arm/tcg-target.h                       |  2 +
 tcg/i386/tcg-target.h                      |  3 +
 tcg/i386/tcg-target.opc.h                  |  2 +
 tcg/mips/tcg-target.h                      |  2 +
 tcg/ppc/tcg-target.h                       |  2 +
 tcg/riscv/tcg-target.h                     |  3 +
 tcg/s390/tcg-target.h                      |  3 +
 tcg/tcg-gvec-desc.h                        |  2 +
 tcg/tcg-op-gvec.h                          |  2 +
 tcg/tcg-op.h                               |  2 +
 tcg/tcg-opc.h                              |  4 ++
 tcg/tcg.h                                  |  2 +
 tcg/tci/tcg-target.h                       |  2 +
 tests/Makefile.include                     | 35 +++++++++-
 tests/check-headers.mak                    | 54 ++++++++++++++++
 tests/crypto-tls-x509-helpers.h            |  2 +
 tests/fp/platform.h                        |  3 +
 tests/header-test-template.c               | 16 +++++
 tests/libqos/virtio-9p.h                   |  2 +
 tests/libqos/virtio-balloon.h              |  2 +
 tests/libqos/virtio-blk.h                  |  2 +
 tests/libqos/virtio-net.h                  |  2 +
 tests/libqos/virtio-rng.h                  |  2 +
 tests/libqos/virtio-scsi.h                 |  2 +
 tests/libqos/virtio-serial.h               |  2 +
 tests/migration/Makefile                   |  2 +
 tests/migration/aarch64/a-b-kernel.h       |  3 +
 tests/migration/i386/a-b-bootblock.h       |  3 +
 tests/migration/s390x/a-b-bios.h           |  2 +
 tests/ptimer-test.h                        |  2 +
 tests/socket-helpers.h                     |  3 +-
 tests/tpm-emu.h                            |  2 +
 tests/tpm-tests.h                          |  2 +
 tests/tpm-util.h                           |  2 +
 trace/control-internal.h                   |  2 +
 trace/mem-internal.h                       |  2 +
 trace/mem.h                                |  2 +
 ui/curses_keys.h                           |  2 +
 ui/vgafont.h                               |  2 +
 ui/vnc-auth-sasl.h                         |  2 +
 ui/vnc-auth-vencrypt.h                     |  2 +
 ui/vnc-enc-hextile-template.h              |  2 +
 ui/vnc-jobs.h                              |  2 +
 ui/vnc-ws.h                                |  2 +
 ui/vnc.h                                   |  2 +
 ui/vnc_keysym.h                            |  1 +
 ui/x_keymap.h                              |  2 +
 util/qemu-thread-common.h                  |  2 +
 win_dump.h                                 |  2 +
 624 files changed, 1623 insertions(+), 51 deletions(-)
 create mode 100644 tests/check-headers.mak
 create mode 100644 tests/header-test-template.c

-- 
2.17.2


