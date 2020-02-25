Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD96C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C96921556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnC+PsqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C96921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YnJ-0005d2-Ee
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yk7-0000C1-B1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yk2-0005HC-Ht
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:14 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yk2-0005Dx-4J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:10 -0500
Received: by mail-wr1-x441.google.com with SMTP id j7so1842559wrp.13
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e9Bm64ekAxxkyn2z9xBC7p66RaTmBC8hGAQkTqwSS0I=;
 b=ZnC+PsqW3su/cF/eteHBARPXad6omnLwnpoumSbX/MJIdoZYwq+99qp7MRDfhNqVDz
 IE9ABNVvMzvnOIpR0u4bIqAzqX20A849Adi3yTlol8FQRy00XpdAE2EDgBWhc9qZJsNL
 wqeItqAiBefVkS9cvQzZR7uZ9TBLDzr1WXLIX5xb43sjnPatLpWOKk9a+N038m2vgWvU
 lIPGyPfAkzcN1lNaryhWPwGgku7HY0cke7mq1h3/l+4yyyTeCkYCrEjaZ98rHokzNRst
 WOZkARYtiNVnb25Gko63BWsMMr2TXSKaqEYwcIIYa50NHWuDvbVyXYwzW/1wQ2xvdIyY
 lPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=e9Bm64ekAxxkyn2z9xBC7p66RaTmBC8hGAQkTqwSS0I=;
 b=htOYYOFmsIpfTaUlZ6OVy/oAKXKZHGZMp0xUvHTUo7vIVBB/vCz+7txMTNEt/tf001
 1SkttEqQm+rwvHGL5AwrUjMfmJ758TsHgw0kSx7Qoz+yufuWcT/dzTnqa6HSoYMYUoVD
 1LELjCEgIxVMArxGfIzbgz+91HNwOIy600dIwpBGPRIzdqj4TdLrmg2LBfv3ji+E3Elj
 rv/3jpSzntVSPgtYN4WWpHA/pt2DPr1yc87p60HTX4VMHoQl1SoubtraeE3akC9ebZDd
 nh0e2gObeWumOnCp7YOvffzIUaPJvltpggLPGXyt7Vg+wRATJUCf17NqmTtXblo2LXIm
 N4+g==
X-Gm-Message-State: APjAAAXri7eV/B9Cor4SkOFJaP3dRGZTXtx6GWNZUQxmHw98NF/erfWU
 3gIJkuUQJx2exfa+9OlfLxNFLS4c
X-Google-Smtp-Source: APXvYqwyDIOecxJmcPFm/UU6728CIXvc8A2UH/VFDQcMJBgbnY5bfZMDSewCEQZTBFd3Fs6CzlR5uQ==
X-Received: by 2002:adf:f288:: with SMTP id k8mr76988042wro.301.1582631467990; 
 Tue, 25 Feb 2020 03:51:07 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 000/136] Misc patches for 2020-02-25 (refactoring and
 Coccinelle edition)
Date: Tue, 25 Feb 2020 12:48:51 +0100
Message-Id: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

The following changes since commit c1e667d2598b9b3ce62b8e89ed22dd38dfe9f57f:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-02-24 11:38:54 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 4db373bef1544b3b5e02ed376d0788c5b6a7548b:

  Merge branch 'exec_rw_const_v4' of https://github.com/philmd/qemu into HEAD (2020-02-25 09:37:42 +0100)

----------------------------------------------------------------

* device_del fix (Julia)
* FXAM fix (myself)
* memdev refactoring (Igor)
* memory region API cleanups (Peter, Philippe)
* ioeventfd optimization (Stefan)
* new WHPX maintainer (Sunil)
* Large guest startup optimizations (Chen)

----------------------------------------------------------------
Igor Mammedov (79):
      numa: remove deprecated -mem-path fallback to anonymous RAM
      machine: introduce memory-backend property
      machine: alias -mem-path and -mem-prealloc into memory-foo backend
      machine: introduce convenience MachineState::ram
      initialize MachineState::ram in NUMA case
      vl.c: move -m parsing after memory backends has been processed
      vl.c: ensure that ram_size matches size of machine.memory-backend
      alpha/dp264: use memdev for RAM
      arm/aspeed: actually check RAM size
      arm/aspeed: use memdev for RAM
      arm/collie: use memdev for RAM
      arm/cubieboard: use memdev for RAM
      arm/digic_boards: use memdev for RAM
      arm/highbank: use memdev for RAM
      arm/imx25_pdk: drop RAM size fixup
      arm/imx25_pdk: use memdev for RAM
      arm/integratorcp: use memdev for RAM
      arm/kzm: drop RAM size fixup
      arm/kzm: use memdev for RAM
      arm/mcimx6ul-evk: use memdev for RAM
      arm/mcimx7d-sabre: use memdev for RAM
      arm/mps2-tz: use memdev for RAM
      arm/mps2: use memdev for RAM
      arm/musicpal: use memdev for RAM
      arm/nseries: use memdev for RAM
      arm/omap_sx1: use memdev for RAM
      arm/palm: use memdev for RAM
      arm/sabrelite: use memdev for RAM
      arm/raspi: use memdev for RAM
      arm/sbsa-ref: use memdev for RAM
      arm/versatilepb: use memdev for RAM
      arm/vexpress: use memdev for RAM
      arm/virt: use memdev for RAM
      arm/xilinx_zynq: drop RAM size fixup
      arm/xilinx_zynq: use memdev for RAM
      arm/xlnx-versal-virt: use memdev for RAM
      arm/xlnx-zcu102: use memdev for RAM
      s390x/s390-virtio-ccw: use memdev for RAM
      null-machine: use memdev for RAM
      cris/axis_dev88: use memdev for RAM
      hppa: use memdev for RAM
      x86/microvm: use memdev for RAM
      x86/pc: use memdev for RAM
      lm32/lm32_boards: use memdev for RAM
      lm32/milkymist: use memdev for RAM
      m68k/an5206: use memdev for RAM
      m68k/q800: use memdev for RAM
      m68k/mcf5208: use memdev for RAM
      m68k/next-cube: use memdev for RAM
      mips/boston: use memdev for RAM
      mips/mips_fulong2e: drop RAM size fixup
      mips/mips_fulong2e: use memdev for RAM
      mips/mips_jazz: use memdev for RAM
      mips/mips_jazz: add max ram size check
      mips/mips_malta: use memdev for RAM
      mips/mips_mipssim: use memdev for RAM
      mips/mips_r4k: use memdev for RAM
      ppc/e500: drop RAM size fixup
      ppc/e500: use memdev for RAM
      ppc/mac_newworld: use memdev for RAM
      ppc/mac_oldworld: use memdev for RAM
      ppc/pnv: use memdev for RAM
      ppc/ppc405_boards: add RAM size checks
      ppc/ppc405_boards: use memdev for RAM
      ppc/{ppc440_bamboo, sam460ex}: drop RAM size fixup
      ppc/{ppc440_bamboo, sam460ex}: use memdev for RAM
      ppc/spapr: use memdev for RAM
      ppc/virtex_ml507: use memdev for RAM
      sparc/leon3: use memdev for RAM
      sparc/sun4m: use memdev for RAM
      sparc/niagara: use memdev for RAM
      remove no longer used memory_region_allocate_system_memory()
      exec: cleanup qemu_minrampagesize()/qemu_maxrampagesize()
      exec: drop bogus mem_path from qemu_ram_alloc_from_fd()
      make mem_path local variable
      hostmem: introduce "prealloc-threads" property
      hostmem: fix strict bind policy
      tests/numa-test: make top level args dynamic and g_autofree(cli) cleanups
      tests:numa-test: use explicit memdev to specify node RAM

Julia Suvorova (1):
      qdev-monitor: Forbid repeated device_del

Paolo Bonzini (4):
      target/i386: check for empty register in FXAM
      Merge tag 'patchew/20200219160953.13771-1-imammedo@redhat.com' of https://github.com/patchew-project/qemu into HEAD
      Merge tag 'patchew/20200224205533.23798-1-philmd@redhat.com' of https://github.com/patchew-project/qemu into HEAD
      Merge branch 'exec_rw_const_v4' of https://github.com/philmd/qemu into HEAD

Peter Maydell (1):
      Avoid address_space_rw() with a constant is_write argument

Philippe Mathieu-Daudé (51):
      scripts/git.orderfile: Display Cocci scripts before code modifications
      hw: Remove unnecessary cast when calling dma_memory_read()
      exec: Rename ram_ptr variable
      exec: Let flatview API take void pointer arguments
      exec: Let the address_space API use void pointer arguments
      hw/net: Avoid casting non-const pointer, use address_space_write()
      Remove unnecessary cast when using the address_space API
      exec: Let the cpu_[physical]_memory API use void pointer arguments
      Remove unnecessary cast when using the cpu_[physical]_memory API
      hw/ide/internal: Remove unused DMARestartFunc typedef
      hw/ide: Let the DMAIntFunc prototype use a boolean 'is_write' argument
      hw/virtio: Let virtqueue_map_iovec() use a boolean 'is_write' argument
      hw/virtio: Let vhost_memory_map() use a boolean 'is_write' argument
      exec: Let address_space_unmap() use a boolean 'is_write' argument
      Let address_space_rw() calls pass a boolean 'is_write' argument
      exec: Let cpu_[physical]_memory API use a boolean 'is_write' argument
      Let cpu_[physical]_memory() calls pass a boolean 'is_write' argument
      Avoid cpu_physical_memory_rw() with a constant is_write argument
      memory: Correctly return alias region type
      memory: Simplify memory_region_init_rom_nomigrate() to ease review
      scripts/cocci: Rename memory-region-{init-ram -> housekeeping}
      scripts/cocci: Patch to replace memory_region_init_{ram, readonly -> rom}
      hw/arm: Use memory_region_init_rom() with read-only regions
      hw/display: Use memory_region_init_rom() with read-only regions
      hw/mips: Use memory_region_init_rom() with read-only regions
      hw/m68k: Use memory_region_init_rom() with read-only regions
      hw/net: Use memory_region_init_rom() with read-only regions
      hw/pci-host: Use memory_region_init_rom() with read-only regions
      hw/ppc: Use memory_region_init_rom() with read-only regions
      hw/riscv: Use memory_region_init_rom() with read-only regions
      hw/sh4: Use memory_region_init_rom() with read-only regions
      hw/sparc: Use memory_region_init_rom() with read-only regions
      scripts/cocci: Patch to detect potential use of memory_region_init_rom
      hw/arm/stm32: Use memory_region_init_rom() with read-only regions
      hw/ppc/ppc405: Use memory_region_init_rom() with read-only regions
      hw/i386/pc_sysfw: Simplify using memory_region_init_alias()
      hw/i386/pc_sysfw: Remove unused 'ram_size' argument
      scripts/cocci: Patch to remove unnecessary memory_region_set_readonly()
      hw/arm: Remove unnecessary memory_region_set_readonly() on ROM alias
      scripts/cocci: Patch to let devices own their MemoryRegions
      hw/arm: Let devices own the MemoryRegion they create
      hw/char: Let devices own the MemoryRegion they create
      hw/core: Let devices own the MemoryRegion they create
      hw/display: Let devices own the MemoryRegion they create
      hw/dma: Let devices own the MemoryRegion they create
      hw/riscv: Let devices own the MemoryRegion they create
      hw/input/milkymist-softusb: Remove unused 'pmem_ptr' field
      hw/input/milkymist-softusb: Let devices own the MemoryRegion they create
      hw/net/milkymist-minimac2: Let devices own the MemoryRegion they create
      hw/block/onenand: Let devices own the MemoryRegion they create
      accel/kvm: Check ioctl(KVM_SET_USER_MEMORY_REGION) return value

Stefan Hajnoczi (1):
      memory: batch allocate ioeventfds[] in address_space_update_ioeventfds()

Sunil Muthuswamy (1):
      WHPX: Assigning maintainer for Windows Hypervisor Platform

bauerchen (1):
      mem-prealloc: optimize large guest startup

 MAINTAINERS                                        |   9 ++
 accel/kvm/kvm-all.c                                |  18 ++-
 backends/hostmem-file.c                            |   8 --
 backends/hostmem-memfd.c                           |   1 -
 backends/hostmem-ram.c                             |   2 -
 backends/hostmem.c                                 |  53 +++++--
 dma-helpers.c                                      |   4 +-
 exec.c                                             | 131 ++++++-----------
 hw/alpha/alpha_sys.h                               |   2 +-
 hw/alpha/dp264.c                                   |   3 +-
 hw/alpha/typhoon.c                                 |   8 +-
 hw/arm/aspeed.c                                    |  18 +--
 hw/arm/boot.c                                      |   6 +-
 hw/arm/collie.c                                    |  16 ++-
 hw/arm/cubieboard.c                                |  25 ++--
 hw/arm/digic_boards.c                              |  40 +++---
 hw/arm/exynos4210.c                                |  14 +-
 hw/arm/fsl-imx25.c                                 |  10 +-
 hw/arm/fsl-imx31.c                                 |   6 +-
 hw/arm/fsl-imx6.c                                  |   6 +-
 hw/arm/fsl-imx6ul.c                                |   9 +-
 hw/arm/highbank.c                                  |  10 +-
 hw/arm/imx25_pdk.c                                 |  19 +--
 hw/arm/integratorcp.c                              |   9 +-
 hw/arm/kzm.c                                       |  18 +--
 hw/arm/mainstone.c                                 |   3 +-
 hw/arm/mcimx6ul-evk.c                              |  25 ++--
 hw/arm/mcimx7d-sabre.c                             |  25 ++--
 hw/arm/mps2-tz.c                                   |  15 +-
 hw/arm/mps2.c                                      |  15 +-
 hw/arm/msf2-soc.c                                  |   6 +-
 hw/arm/musicpal.c                                  |  18 ++-
 hw/arm/nrf51_soc.c                                 |   2 +-
 hw/arm/nseries.c                                   |  32 +++--
 hw/arm/omap_sx1.c                                  |  26 ++--
 hw/arm/palm.c                                      |  22 ++-
 hw/arm/raspi.c                                     |  10 +-
 hw/arm/sabrelite.c                                 |  23 ++-
 hw/arm/sbsa-ref.c                                  |   7 +-
 hw/arm/smmu-common.c                               |   3 +-
 hw/arm/smmuv3.c                                    |  10 +-
 hw/arm/spitz.c                                     |   3 +-
 hw/arm/stellaris.c                                 |   3 +-
 hw/arm/stm32f205_soc.c                             |  11 +-
 hw/arm/stm32f405_soc.c                             |  12 +-
 hw/arm/tosa.c                                      |   3 +-
 hw/arm/versatilepb.c                               |   7 +-
 hw/arm/vexpress.c                                  |  14 +-
 hw/arm/virt.c                                      |   7 +-
 hw/arm/xilinx_zynq.c                               |  20 ++-
 hw/arm/xlnx-versal-virt.c                          |   7 +-
 hw/arm/xlnx-zcu102.c                               |   7 +-
 hw/arm/xlnx-zynqmp.c                               |  11 +-
 hw/block/onenand.c                                 |   7 +-
 hw/char/serial.c                                   |   7 +-
 hw/core/machine.c                                  |  48 +++++++
 hw/core/null-machine.c                             |   8 +-
 hw/core/numa.c                                     | 101 ++++---------
 hw/core/platform-bus.c                             |   3 +-
 hw/cris/axis_dev88.c                               |   8 +-
 hw/display/cg3.c                                   |   5 +-
 hw/display/exynos4210_fimd.c                       |   3 +-
 hw/display/g364fb.c                                |   3 +-
 hw/display/macfb.c                                 |   4 +-
 hw/display/milkymist-tmu2.c                        |   8 +-
 hw/display/omap_dss.c                              |   2 +-
 hw/display/omap_lcdc.c                             |  10 +-
 hw/display/ramfb.c                                 |   2 +-
 hw/display/tcx.c                                   |   5 +-
 hw/dma/etraxfs_dma.c                               |  25 ++--
 hw/dma/i8257.c                                     |   2 +-
 hw/dma/rc4030.c                                    |  14 +-
 hw/dma/xlnx-zdma.c                                 |  11 +-
 hw/hppa/machine.c                                  |  10 +-
 hw/i386/microvm.c                                  |  12 +-
 hw/i386/pc.c                                       |  19 ++-
 hw/i386/pc_sysfw.c                                 |  29 ++--
 hw/ide/ahci.c                                      |   2 +-
 hw/ide/core.c                                      |   2 +-
 hw/ide/macio.c                                     |   2 +-
 hw/ide/pci.c                                       |   2 +-
 hw/input/milkymist-softusb.c                       |  12 +-
 hw/lm32/lm32_boards.c                              |  39 +++--
 hw/lm32/milkymist.c                                |  21 ++-
 hw/m68k/an5206.c                                   |   5 +-
 hw/m68k/mcf5208.c                                  |   5 +-
 hw/m68k/next-cube.c                                |   5 +-
 hw/m68k/q800.c                                     |   9 +-
 hw/mips/boston.c                                   |  11 +-
 hw/mips/mips_fulong2e.c                            |  18 +--
 hw/mips/mips_jazz.c                                |  18 +--
 hw/mips/mips_malta.c                               |  10 +-
 hw/mips/mips_mipssim.c                             |  12 +-
 hw/mips/mips_r4k.c                                 |  15 +-
 hw/misc/aspeed_sdmc.c                              |  83 ++++++++---
 hw/misc/pc-testdev.c                               |   2 +-
 hw/net/cadence_gem.c                               |  21 ++-
 hw/net/dp8393x.c                                   |  75 +++++-----
 hw/net/i82596.c                                    |  25 ++--
 hw/net/lasi_i82596.c                               |   5 +-
 hw/net/milkymist-minimac2.c                        |   8 +-
 hw/nvram/spapr_nvram.c                             |   4 +-
 hw/pci-host/prep.c                                 |   5 +-
 hw/ppc/e500.c                                      |  17 ++-
 hw/ppc/e500plat.c                                  |   1 +
 hw/ppc/mac_newworld.c                              |   9 +-
 hw/ppc/mac_oldworld.c                              |   9 +-
 hw/ppc/mpc8544ds.c                                 |   1 +
 hw/ppc/pnv.c                                       |   8 +-
 hw/ppc/pnv_lpc.c                                   |   8 +-
 hw/ppc/ppc405_boards.c                             |  54 ++++---
 hw/ppc/ppc440_bamboo.c                             |  12 +-
 hw/ppc/ppc440_uc.c                                 |   6 +-
 hw/ppc/ppc4xx_devs.c                               |  67 +++++----
 hw/ppc/sam460ex.c                                  |   6 +-
 hw/ppc/spapr.c                                     |   8 +-
 hw/ppc/spapr_hcall.c                               |   4 +-
 hw/ppc/virtex_ml507.c                              |  12 +-
 hw/riscv/sifive_e.c                                |   9 +-
 hw/riscv/sifive_u.c                                |   2 +-
 hw/s390x/css.c                                     |  12 +-
 hw/s390x/ipl.c                                     |   2 +-
 hw/s390x/s390-pci-bus.c                            |   2 +-
 hw/s390x/s390-virtio-ccw.c                         |   7 +-
 hw/s390x/virtio-ccw.c                              |   2 +-
 hw/scsi/vmw_pvscsi.c                               |   8 +-
 hw/sd/sdhci.c                                      |  15 +-
 hw/sh4/shix.c                                      |   3 +-
 hw/sparc/leon3.c                                   |   9 +-
 hw/sparc/sun4m.c                                   |  74 +++++-----
 hw/sparc64/niagara.c                               |   7 +-
 hw/virtio/vhost.c                                  |   8 +-
 hw/virtio/virtio.c                                 |   7 +-
 hw/xen/xen_pt_graphics.c                           |   2 +-
 include/exec/cpu-all.h                             |   2 +-
 include/exec/cpu-common.h                          |  12 +-
 include/exec/memory.h                              |  16 +--
 include/hw/boards.h                                |  54 +++----
 include/hw/ide/internal.h                          |   3 +-
 include/hw/misc/aspeed_sdmc.h                      |   1 +
 include/hw/ppc/ppc4xx.h                            |   9 +-
 include/sysemu/hostmem.h                           |  20 ++-
 include/sysemu/numa.h                              |   1 +
 include/sysemu/sysemu.h                            |   2 -
 memory.c                                           |  34 +++--
 qdev-monitor.c                                     |   6 +
 qemu-deprecated.texi                               |   9 --
 qtest.c                                            |  52 +++----
 scripts/coccinelle/exec_rw_const.cocci             | 111 ++++++++++++++
 .../coccinelle/memory-region-housekeeping.cocci    | 159 +++++++++++++++++++++
 scripts/coccinelle/memory-region-init-ram.cocci    |  38 -----
 scripts/git.orderfile                              |   3 +
 softmmu/vl.c                                       |  78 ++++++++--
 target/i386/fpu_helper.c                           |   6 +-
 target/i386/hax-all.c                              |   6 +-
 target/i386/hvf/vmx.h                              |   7 +-
 target/i386/hvf/x86_mmu.c                          |  12 +-
 target/i386/whpx-all.c                             |   2 +-
 target/s390x/excp_helper.c                         |   2 +-
 target/s390x/helper.c                              |   6 +-
 target/s390x/mmu_helper.c                          |   2 +-
 tests/qtest/numa-test.c                            | 138 +++++++++---------
 util/oslib-posix.c                                 |  32 +++--
 163 files changed, 1524 insertions(+), 1244 deletions(-)
 create mode 100644 scripts/coccinelle/exec_rw_const.cocci
 create mode 100644 scripts/coccinelle/memory-region-housekeeping.cocci
 delete mode 100644 scripts/coccinelle/memory-region-init-ram.cocci
---
 hw/core/numa.c       | 18 +-----------------
 qemu-deprecated.texi |  9 ---------
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 0d1b4be..840e685 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -784,24 +784,8 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
 {
     if (mem_path) {
 #ifdef __linux__
-        Error *err = NULL;
         memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
-                                         mem_path, &err);
-        if (err) {
-            error_report_err(err);
-            if (mem_prealloc) {
-                exit(1);
-            }
-            warn_report("falling back to regular RAM allocation");
-            error_printf("This is deprecated. Make sure that -mem-path "
-                         " specified path has sufficient resources to allocate"
-                         " -m specified RAM amount\n");
-            /* Legacy behavior: if allocation failed, fall back to
-             * regular RAM allocation.
-             */
-            mem_path = NULL;
-            memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error_fatal);
-        }
+                                         mem_path, &error_fatal);
 #else
         fprintf(stderr, "-mem-path not supported on this host\n");
         exit(1);
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 0671c26..66eca3a 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -113,15 +113,6 @@ QEMU using implicit generic or board specific splitting rule.
 Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem} (if
 it's supported by used machine type) to define mapping explictly instead.
 
-@subsection -mem-path fallback to RAM (since 4.1)
-Currently if guest RAM allocation from file pointed by @option{mem-path}
-fails, QEMU falls back to allocating from RAM, which might result
-in unpredictable behavior since the backing file specified by the user
-is ignored. In the future, users will be responsible for making sure
-the backing storage specified with @option{-mem-path} can actually provide
-the guest RAM configured with @option{-m} and QEMU will fail to start up if
-RAM allocation is unsuccessful.
-
 @subsection RISC-V -bios (since 4.1)
 
 QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for the
-- 
1.8.3.1



