Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B9CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8ADA20578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkVU+VC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8ADA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttFC-0006MY-04
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtt7R-0008OW-Ml
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:31:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44126
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtt7P-0004vz-4f
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594387870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v+xMc4V7opKm0x8twR/ZSCzum4t3aOUGnqJJojBHEEY=;
 b=SkVU+VC8AgJQvwBQO0YJsWzPtqy6On7FonrvIWs6Pqfrn88Qz2FGyfC5jaa6UvHkPqA36l
 C5j7iZ1o0CwdAoBe2VQ+00BkUe7o7RvHCOPTqHFgsw+ecBHSuYZ9leADFceVUgbm8J9I7l
 a/KweH0ZSlpVM5KPvb/DUxC4MJlR3mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-yxZF-XiRMn-3VVpWvpM_qA-1; Fri, 10 Jul 2020 09:31:06 -0400
X-MC-Unique: yxZF-XiRMn-3VVpWvpM_qA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B66580280E;
 Fri, 10 Jul 2020 13:31:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E150C6FEDF;
 Fri, 10 Jul 2020 13:31:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6E7261132FD2; Fri, 10 Jul 2020 15:31:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/53] Error reporting patches patches for 2020-07-07
Date: Fri, 10 Jul 2020 15:30:59 +0200
Message-Id: <20200710133103.2153250-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b6d7e9b66f59ca6ebc6e9b830cd5e7bf849d31cf:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2020-07-10 09:01:28 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-07-07-v2

for you to fetch changes up to 1de7096d8378a57e2d75d9cacc9a119e7e41640d:

  xen: Use ERRP_GUARD() (2020-07-10 15:18:09 +0200)

----------------------------------------------------------------
Error reporting patches patches for 2020-07-07

* Improve documentation
* Codify rules for less clumsy error handling
* Convert a substantial amount of code to adhere to them
* ERRP_GUARD() infrastructure to avoid more clumsiness
* First batch of conversions to it
----------------------------------------------------------------
Markus Armbruster (45):
      error: Fix examples in error.h's big comment
      error: Improve error.h's big comment
      error: Document Error API usage rules
      qdev: Use returned bool to check for qdev_realize() etc. failure
      macio: Tidy up error handling in macio_newworld_realize()
      virtio-crypto-pci: Tidy up virtio_crypto_pci_realize()
      qemu-option: Check return value instead of @err where convenient
      qemu-option: Make uses of find_desc_by_name() more similar
      qemu-option: Factor out helper find_default_by_name()
      qemu-option: Simplify around find_default_by_name()
      qemu-option: Factor out helper opt_create()
      qemu-option: Replace opt_set() by cleaner opt_validate()
      qemu-option: Make functions taking Error ** return bool, not void
      qemu-option: Use returned bool to check for failure
      block: Avoid error accumulation in bdrv_img_create()
      hmp: Eliminate a variable in hmp_migrate_set_parameter()
      qapi: Make visitor functions taking Error ** return bool, not void
      qapi: Use returned bool to check for failure, Coccinelle part
      qapi: Use returned bool to check for failure, manual part
      s390x/pci: Fix harmless mistake in zpci's property fid's setter
      qom: Use error_reportf_err() instead of g_printerr() in examples
      qom: Rename qdev_get_type() to object_get_type()
      qom: Crash more nicely on object_property_get_link() failure
      qom: Don't handle impossible object_property_get_link() failure
      qom: Use return values to check for error where that's simpler
      qom: Put name parameter before value / visitor parameter
      qom: Make functions taking Error ** return bool, not void
      qom: Use returned bool to check for failure, Coccinelle part
      qom: Use returned bool to check for failure, manual part
      qom: Make functions taking Error ** return bool, not 0/-1
      qdev: Make functions taking Error ** return bool, not void
      qdev: Use returned bool to check for failure, Coccinelle part
      error: Avoid unnecessary error_propagate() after error_setg()
      error: Eliminate error_propagate() with Coccinelle, part 1
      error: Eliminate error_propagate() with Coccinelle, part 2
      error: Eliminate error_propagate() manually
      error: Reduce unnecessary error propagation
      block/parallels: Simplify parallels_open() after previous commit
      qapi: Smooth another visitor error checking pattern
      qapi: Smooth visitor error checking in generated code
      qapi: Purge error_propagate() from QAPI core
      error: Avoid error_propagate() after migrate_add_blocker()
      qemu-img: Ignore Error objects where the return value suffices
      qdev: Ignore Error objects where the return value suffices
      hmp: Ignore Error objects where the return value suffices

Vladimir Sementsov-Ogievskiy (8):
      error: New macro ERRP_GUARD()
      scripts: Coccinelle script to use ERRP_GUARD()
      sd: Use ERRP_GUARD()
      pflash: Use ERRP_GUARD()
      fw_cfg: Use ERRP_GUARD()
      virtio-9p: Use ERRP_GUARD()
      nbd: Use ERRP_GUARD()
      xen: Use ERRP_GUARD()

 docs/devel/qapi-code-gen.txt             | 103 ++++------
 scripts/coccinelle/errp-guard.cocci      | 336 +++++++++++++++++++++++++++++++
 include/block/nbd.h                      |   1 +
 include/hw/audio/pcspk.h                 |   2 +-
 include/hw/qdev-properties.h             |   4 +-
 include/qapi/clone-visitor.h             |   8 +-
 include/qapi/error.h                     | 267 ++++++++++++++++++++----
 include/qapi/visitor-impl.h              |  26 +--
 include/qapi/visitor.h                   | 102 ++++++----
 include/qemu/option.h                    |  16 +-
 include/qom/object.h                     | 104 +++++-----
 include/qom/object_interfaces.h          |  12 +-
 include/qom/qom-qobject.h                |   9 +-
 accel/kvm/kvm-all.c                      |  55 +++--
 accel/tcg/tcg-all.c                      |   5 +-
 audio/audio_legacy.c                     |  15 +-
 backends/cryptodev-vhost-user.c          |   3 +-
 backends/cryptodev.c                     |  16 +-
 backends/hostmem-file.c                  |  22 +-
 backends/hostmem-memfd.c                 |  18 +-
 backends/hostmem.c                       |  33 ++-
 backends/rng.c                           |   2 +-
 backends/tpm/tpm_util.c                  |   5 +-
 block.c                                  |  21 +-
 block/blkdebug.c                         |   9 +-
 block/blklogwrites.c                     |   4 +-
 block/blkverify.c                        |   4 +-
 block/crypto.c                           |   5 +-
 block/curl.c                             |   5 +-
 block/file-posix.c                       |  16 +-
 block/file-win32.c                       |   8 +-
 block/gluster.c                          |  17 +-
 block/iscsi.c                            |   4 +-
 block/nbd.c                              |  17 +-
 block/nfs.c                              |   7 +-
 block/parallels.c                        |  29 +--
 block/qcow.c                             |  16 +-
 block/qcow2.c                            |  21 +-
 block/qed.c                              |  10 +-
 block/quorum.c                           |  19 +-
 block/raw-format.c                       |   5 +-
 block/rbd.c                              |   7 +-
 block/replication.c                      |  19 +-
 block/sheepdog.c                         |  16 +-
 block/ssh.c                              |  11 +-
 block/throttle-groups.c                  |  31 +--
 block/throttle.c                         |   5 +-
 block/vdi.c                              |  13 +-
 block/vhdx.c                             |  15 +-
 block/vmdk.c                             |  13 +-
 block/vpc.c                              |  19 +-
 block/vvfat.c                            |  10 +-
 block/vxhs.c                             |  15 +-
 blockdev.c                               |  40 ++--
 bootdevice.c                             |  13 +-
 chardev/char.c                           |   6 +-
 contrib/ivshmem-server/main.c            |   4 +-
 crypto/secret.c                          |   2 +-
 crypto/secret_keyring.c                  |   2 +-
 crypto/tlscredsanon.c                    |   2 +-
 crypto/tlscredspsk.c                     |   2 +-
 crypto/tlscredsx509.c                    |   2 +-
 dump/dump.c                              |   7 +-
 hw/9pfs/9p-local.c                       |  12 +-
 hw/9pfs/9p.c                             |   1 +
 hw/acpi/core.c                           |  19 +-
 hw/acpi/cpu_hotplug.c                    |   4 +-
 hw/acpi/ich9.c                           |   2 +-
 hw/acpi/piix4.c                          |   2 +-
 hw/arm/allwinner-a10.c                   |  27 +--
 hw/arm/armsse.c                          | 208 ++++++-------------
 hw/arm/armv7m.c                          |  47 ++---
 hw/arm/aspeed.c                          |  24 +--
 hw/arm/aspeed_ast2600.c                  | 124 ++++--------
 hw/arm/aspeed_soc.c                      |  85 +++-----
 hw/arm/bcm2835_peripherals.c             |  81 ++------
 hw/arm/bcm2836.c                         |  35 +---
 hw/arm/cubieboard.c                      |  14 +-
 hw/arm/digic.c                           |  18 +-
 hw/arm/digic_boards.c                    |   3 +-
 hw/arm/exynos4210.c                      |  13 +-
 hw/arm/fsl-imx25.c                       |  58 ++----
 hw/arm/fsl-imx31.c                       |  34 +---
 hw/arm/fsl-imx6.c                        |  85 +++-----
 hw/arm/fsl-imx6ul.c                      |  29 ++-
 hw/arm/fsl-imx7.c                        |  31 ++-
 hw/arm/highbank.c                        |  12 +-
 hw/arm/integratorcp.c                    |   2 +-
 hw/arm/mcimx6ul-evk.c                    |   4 +-
 hw/arm/microbit.c                        |   4 +-
 hw/arm/mps2-tz.c                         |  31 ++-
 hw/arm/mps2.c                            |  12 +-
 hw/arm/msf2-soc.c                        |  29 +--
 hw/arm/musca.c                           |  18 +-
 hw/arm/musicpal.c                        |   4 +-
 hw/arm/nrf51_soc.c                       |  36 +---
 hw/arm/orangepi.c                        |  13 +-
 hw/arm/raspi.c                           |   2 +-
 hw/arm/realview.c                        |   6 +-
 hw/arm/sbsa-ref.c                        |  16 +-
 hw/arm/stellaris.c                       |   4 +-
 hw/arm/stm32f205_soc.c                   |  37 +---
 hw/arm/stm32f405_soc.c                   |  48 ++---
 hw/arm/versatilepb.c                     |   4 +-
 hw/arm/vexpress.c                        |   8 +-
 hw/arm/virt.c                            |  44 ++--
 hw/arm/xilinx_zynq.c                     |   6 +-
 hw/arm/xlnx-versal-virt.c                |   8 +-
 hw/arm/xlnx-versal.c                     |  30 ++-
 hw/arm/xlnx-zcu102.c                     |   8 +-
 hw/arm/xlnx-zynqmp.c                     | 117 ++++-------
 hw/block/dataplane/xen-block.c           |  17 +-
 hw/block/fdc.c                           |  12 +-
 hw/block/pflash_cfi01.c                  |   7 +-
 hw/block/pflash_cfi02.c                  |   7 +-
 hw/block/xen-block.c                     | 124 +++++-------
 hw/char/serial-pci-multi.c               |   5 +-
 hw/char/serial-pci.c                     |   5 +-
 hw/char/serial.c                         |  10 +-
 hw/core/bus.c                            |  12 +-
 hw/core/cpu.c                            |   3 +-
 hw/core/machine.c                        |   5 +-
 hw/core/numa.c                           |  55 ++---
 hw/core/platform-bus.c                   |   6 +-
 hw/core/qdev-properties-system.c         |  32 +--
 hw/core/qdev-properties.c                |  95 +++------
 hw/core/qdev.c                           |  16 +-
 hw/cpu/a15mpcore.c                       |   5 +-
 hw/cpu/a9mpcore.c                        |  21 +-
 hw/cpu/arm11mpcore.c                     |  17 +-
 hw/cpu/core.c                            |  10 +-
 hw/cpu/realview_mpcore.c                 |   9 +-
 hw/display/bcm2835_fb.c                  |   8 +-
 hw/display/virtio-gpu-base.c             |   5 +-
 hw/display/virtio-gpu-pci.c              |  11 +-
 hw/display/virtio-vga.c                  |  10 +-
 hw/dma/bcm2835_dma.c                     |   9 +-
 hw/dma/sparc32_dma.c                     |   6 +-
 hw/dma/xilinx_axidma.c                   |   4 +-
 hw/gpio/aspeed_gpio.c                    |   5 +-
 hw/gpio/bcm2835_gpio.c                   |  15 +-
 hw/hyperv/vmbus.c                        |   5 +-
 hw/i386/pc.c                             |  48 ++---
 hw/i386/pc_piix.c                        |   4 +-
 hw/i386/pc_q35.c                         |  28 +--
 hw/i386/x86.c                            |   7 +-
 hw/ide/qdev.c                            |   7 +-
 hw/intc/apic_common.c                    |   5 +-
 hw/intc/arm_gic_kvm.c                    |   4 +-
 hw/intc/arm_gicv3_its_kvm.c              |   5 +-
 hw/intc/arm_gicv3_kvm.c                  |   4 +-
 hw/intc/armv7m_nvic.c                    |   9 +-
 hw/intc/nios2_iic.c                      |   8 +-
 hw/intc/pnv_xive.c                       |  17 +-
 hw/intc/realview_gic.c                   |   5 +-
 hw/intc/spapr_xive.c                     |  17 +-
 hw/intc/xics.c                           |   9 +-
 hw/intc/xics_kvm.c                       |   4 +-
 hw/intc/xive.c                           |  17 +-
 hw/isa/piix4.c                           |   5 +-
 hw/m68k/q800.c                           |   4 +-
 hw/mem/nvdimm.c                          |  30 +--
 hw/mem/pc-dimm.c                         |  18 +-
 hw/microblaze/petalogix_ml605_mmu.c      |  24 +--
 hw/microblaze/petalogix_s3adsp1800_mmu.c |   2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          |  39 ++--
 hw/mips/boston.c                         |   4 +-
 hw/mips/cps.c                            |  41 ++--
 hw/mips/jazz.c                           |   4 +-
 hw/mips/malta.c                          |   4 +-
 hw/misc/aspeed_sdmc.c                    |   8 +-
 hw/misc/bcm2835_mbox.c                   |   9 +-
 hw/misc/bcm2835_property.c               |  17 +-
 hw/misc/iotkit-sysctl.c                  |   2 +-
 hw/misc/ivshmem.c                        |   4 +-
 hw/misc/macio/cuda.c                     |   5 +-
 hw/misc/macio/macio.c                    |  35 ++--
 hw/misc/macio/pmu.c                      |   5 +-
 hw/misc/pca9552.c                        |   5 +-
 hw/misc/tmp105.c                         |   5 +-
 hw/misc/tmp421.c                         |   5 +-
 hw/net/ne2000-isa.c                      |   7 +-
 hw/net/virtio-net.c                      |   7 +-
 hw/net/xilinx_axienet.c                  |   4 +-
 hw/nvram/fw_cfg.c                        |  21 +-
 hw/pci-host/pnv_phb3.c                   |  33 ++-
 hw/pci-host/pnv_phb4.c                   |   9 +-
 hw/pci-host/pnv_phb4_pec.c               |   9 +-
 hw/pci-host/prep.c                       |   4 +-
 hw/pci-host/xen_igd_pt.c                 |   7 +-
 hw/ppc/e500.c                            |   5 +-
 hw/ppc/mac_newworld.c                    |  10 +-
 hw/ppc/mac_oldworld.c                    |   4 +-
 hw/ppc/pnv.c                             | 171 +++++++---------
 hw/ppc/pnv_core.c                        |   4 +-
 hw/ppc/pnv_psi.c                         |  22 +-
 hw/ppc/rs6000_mc.c                       |   9 +-
 hw/ppc/spapr.c                           |  77 +++----
 hw/ppc/spapr_caps.c                      |  15 +-
 hw/ppc/spapr_cpu_core.c                  |  15 +-
 hw/ppc/spapr_drc.c                       |  16 +-
 hw/ppc/spapr_hcall.c                     |   3 +-
 hw/ppc/spapr_irq.c                       |  11 +-
 hw/ppc/spapr_pci.c                       |  16 +-
 hw/ppc/spapr_pci_nvlink2.c               |   3 +-
 hw/riscv/opentitan.c                     |  13 +-
 hw/riscv/sifive_e.c                      |  10 +-
 hw/riscv/sifive_u.c                      |  11 +-
 hw/riscv/spike.c                         |   4 +-
 hw/riscv/virt.c                          |   4 +-
 hw/rx/rx-gdbsim.c                        |  12 +-
 hw/s390x/css.c                           |   5 +-
 hw/s390x/event-facility.c                |  13 +-
 hw/s390x/ipl.c                           |  27 ++-
 hw/s390x/s390-pci-bus.c                  |  14 +-
 hw/s390x/s390-skeys.c                    |   2 +-
 hw/s390x/s390-stattrib.c                 |   2 +-
 hw/s390x/s390-virtio-ccw.c               |  20 +-
 hw/s390x/sclp.c                          |  13 +-
 hw/s390x/virtio-ccw-crypto.c             |  10 +-
 hw/s390x/virtio-ccw-rng.c                |   8 +-
 hw/scsi/scsi-bus.c                       |  15 +-
 hw/scsi/vhost-scsi.c                     |   4 +-
 hw/sd/aspeed_sdhci.c                     |  15 +-
 hw/sd/sd.c                               |   3 +-
 hw/sd/sdhci-pci.c                        |   7 +-
 hw/sd/sdhci.c                            |  21 +-
 hw/sd/ssi-sd.c                           |  15 +-
 hw/smbios/smbios.c                       |  33 +--
 hw/sparc/sun4m.c                         |   2 +-
 hw/sparc64/sun4u.c                       |   2 +-
 hw/usb/bus.c                             |   7 +-
 hw/usb/dev-storage.c                     |   9 +-
 hw/usb/hcd-dwc2.c                        |   9 +-
 hw/vfio/pci-quirks.c                     |   5 +-
 hw/vfio/pci.c                            |  10 +-
 hw/virtio/virtio-balloon.c               |  17 +-
 hw/virtio/virtio-crypto-pci.c            |   9 +-
 hw/virtio/virtio-iommu-pci.c             |   4 +-
 hw/virtio/virtio-mem-pci.c               |   4 +-
 hw/virtio/virtio-pmem-pci.c              |   2 +-
 hw/virtio/virtio-rng-pci.c               |   8 +-
 hw/virtio/virtio-rng.c                   |  11 +-
 hw/xen/xen-backend.c                     |   7 +-
 hw/xen/xen-bus.c                         |  92 ++++-----
 hw/xen/xen-host-pci-device.c             |  27 ++-
 hw/xen/xen_pt.c                          |  25 +--
 hw/xen/xen_pt_config_init.c              |  20 +-
 iothread.c                               |  18 +-
 linux-user/syscall.c                     |   2 +-
 monitor/hmp-cmds.c                       |  11 +-
 monitor/monitor.c                        |  21 +-
 nbd/client.c                             |   5 +
 nbd/server.c                             |   5 +
 net/colo-compare.c                       |  26 +--
 net/dump.c                               |  13 +-
 net/filter-buffer.c                      |  13 +-
 net/filter.c                             |   2 +-
 net/net.c                                |  10 +-
 net/tap.c                                |   6 +-
 qapi/opts-visitor.c                      |  66 +++---
 qapi/qapi-clone-visitor.c                |  69 ++++---
 qapi/qapi-dealloc-visitor.c              |  27 ++-
 qapi/qapi-visit-core.c                   | 197 +++++++++---------
 qapi/qobject-input-visitor.c             | 109 ++++++----
 qapi/qobject-output-visitor.c            |  27 ++-
 qapi/string-input-visitor.c              |  67 +++---
 qapi/string-output-visitor.c             |  32 +--
 qdev-monitor.c                           |  39 ++--
 qemu-img.c                               |  31 +--
 qga/commands-posix.c                     |   4 +-
 qga/commands-win32.c                     |  22 +-
 qom/object.c                             | 244 +++++++++++-----------
 qom/object_interfaces.c                  |  30 +--
 qom/qom-hmp-cmds.c                       |   2 +-
 qom/qom-qmp-cmds.c                       |   2 +-
 qom/qom-qobject.c                        |  14 +-
 softmmu/vl.c                             |  17 +-
 target/arm/cpu64.c                       |  15 +-
 target/arm/monitor.c                     |   7 +-
 target/i386/cpu.c                        |  98 ++++-----
 target/ppc/compat.c                      |   5 +-
 target/ppc/translate_init.inc.c          |   2 +-
 target/s390x/cpu_models.c                |  17 +-
 target/sparc/cpu.c                       |   5 +-
 tpm.c                                    |   5 +-
 ui/console.c                             |   4 +-
 ui/vnc.c                                 |   2 +-
 util/main-loop.c                         |   4 +-
 util/qemu-config.c                       |  25 +--
 util/qemu-option.c                       | 259 ++++++++++++------------
 MAINTAINERS                              |   1 +
 scripts/qapi/commands.py                 |  22 +-
 scripts/qapi/visit.py                    | 107 ++++------
 294 files changed, 3069 insertions(+), 3791 deletions(-)
 create mode 100644 scripts/coccinelle/errp-guard.cocci

-- 
2.26.2


