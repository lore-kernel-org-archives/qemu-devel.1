Received: from eggs.gnu.org ([2001:4830:134:3::10]:56013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVZA-00078i-VU
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVZ7-0000T1-PQ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:05:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUVZ7-0000Rr-Fe
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:05:17 -0400
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <438bc671-4d94-9efc-540a-151be39583e2@redhat.com>
Date: Mon, 10 Jul 2017 12:05:00 +0200
MIME-Version: 1.0
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/11] Make memory_region_init_ram() and
 friends handle migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>



On 07/07/2017 16:42, Peter Maydell wrote:
> This patchset changes the memory region functions
>  - memory_region_init_ram()
>  - memory_region_init_rom()
>  - memory_region_init_rom_device()
> to all automatically register the backing memory they allocate
> for migration using vmstate_register_ram(). Renamed functions
>  - memory_region_init_ram_nomigrate()
>  - memory_region_init_rom_nomigrate()
>  - memory_region_init_rom_device_nomigrate()
> are provided which only do the MR init, for the oddball
> cases which want to manage migration of the backing memory
> themselves (and to avoid behavioural changes for callers
> which weren't managing correctly migration themselves...)
> 
> The idea is based on discussion from a previous patchset:
>  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00764.html
> 
> The series includes a largish coccinelle-scripted patch and a
> few by-hand conversions which change callsites which previously
> manually created the region and registered its backing ram in
> two separate steps to use the new functions.
> 
> This series does not include any patches to fix bugs like:
>  * caller forgot to call vmstate_register_ram() so region
>    is not actually migrated (eg hw/arm/highbank.c)
>  * caller used vmstate_register_ram_global() even though it is
>    a device, so you can't create 2 copies of the device (eg sm501)
> because I wanted to stick to strictly no-behaviour-change
> for this patch -- we can fix the bugs separately (fixes will
> tend to imply migration compat breaks so can only be done
> for some boards.) Most of the remaining callers of the
> _nomigrate functions are buggy, I think (and a demonstration
> that our current API does not score well on the "hard to
> get wrong by accident" scale).

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

> 
> thanks
> -- PMM
> 
> Peter Maydell (11):
>   include/hw/boards.h: Document memory_region_allocate_system_memory()
>   memory: Document that the RAM MR initializers do not handle migration
>   memory: Rename memory_region_init_ram() to
>     memory_region_init_ram_nomigrate()
>   memory: Rename memory_region_init_rom() and _rom_device() to
>     _nomigrate()
>   memory.h: Add memory_region_init_{ram,rom,rom_device}() handling
>     migration
>   scripts/coccinelle/memory-region-init-ram.cocci: New script
>   hw: Use new memory_region_init_{ram,rom,rom_device}() functions
>   hw/block/pflash_cfi01, pflash_cfi02: Use
>     memory_region_init_rom_device()
>   hw/pci/pci.c: Use memory_region_init_rom()
>   hw/display/qxl.c Use memory_region_init_ram()
>   docs/devel/memory.txt: Add section about RAM migration
> 
>  docs/devel/memory.txt                           |  31 +++++
>  include/exec/memory.h                           | 161 ++++++++++++++++++++----
>  include/hw/boards.h                             |  29 +++++
>  backends/hostmem-ram.c                          |   2 +-
>  hw/arm/aspeed.c                                 |   2 +-
>  hw/arm/aspeed_soc.c                             |   2 +-
>  hw/arm/exynos4210.c                             |   2 -
>  hw/arm/exynos4_boards.c                         |   2 -
>  hw/arm/fsl-imx25.c                              |   5 +-
>  hw/arm/fsl-imx31.c                              |   5 +-
>  hw/arm/fsl-imx6.c                               |   5 +-
>  hw/arm/highbank.c                               |   2 +-
>  hw/arm/integratorcp.c                           |   2 +-
>  hw/arm/mainstone.c                              |   1 -
>  hw/arm/musicpal.c                               |   1 -
>  hw/arm/omap1.c                                  |   1 -
>  hw/arm/omap2.c                                  |   1 -
>  hw/arm/omap_sx1.c                               |   6 +-
>  hw/arm/palm.c                                   |   1 -
>  hw/arm/pxa2xx.c                                 |   4 -
>  hw/arm/realview.c                               |   3 -
>  hw/arm/spitz.c                                  |   1 -
>  hw/arm/stellaris.c                              |   2 -
>  hw/arm/stm32f205_soc.c                          |   3 -
>  hw/arm/tosa.c                                   |   1 -
>  hw/arm/vexpress.c                               |   3 -
>  hw/arm/virt.c                                   |   4 +-
>  hw/arm/xilinx_zynq.c                            |   1 -
>  hw/arm/xlnx-zynqmp.c                            |   1 -
>  hw/block/onenand.c                              |   2 +-
>  hw/block/pflash_cfi01.c                         |   1 -
>  hw/block/pflash_cfi02.c                         |   1 -
>  hw/cris/axis_dev88.c                            |   5 +-
>  hw/display/cg3.c                                |   3 +-
>  hw/display/qxl.c                                |   3 -
>  hw/display/sm501.c                              |   2 +-
>  hw/display/tc6393xb.c                           |   1 -
>  hw/display/tcx.c                                |   4 +-
>  hw/display/vga.c                                |   2 +-
>  hw/display/vmware_vga.c                         |   1 -
>  hw/i386/pc.c                                    |   1 -
>  hw/i386/pc_sysfw.c                              |   2 -
>  hw/i386/pci-assign-load-rom.c                   |   2 +-
>  hw/i386/xen/xen-hvm.c                           |   1 -
>  hw/input/milkymist-softusb.c                    |   4 +-
>  hw/m68k/an5206.c                                |   1 -
>  hw/m68k/mcf5208.c                               |   1 -
>  hw/microblaze/petalogix_ml605_mmu.c             |   2 -
>  hw/microblaze/petalogix_s3adsp1800_mmu.c        |   2 -
>  hw/mips/boston.c                                |   2 +-
>  hw/mips/mips_fulong2e.c                         |   1 -
>  hw/mips/mips_jazz.c                             |   2 -
>  hw/mips/mips_malta.c                            |   2 +-
>  hw/mips/mips_mipssim.c                          |   1 -
>  hw/mips/mips_r4k.c                              |   1 -
>  hw/moxie/moxiesim.c                             |   4 +-
>  hw/net/dp8393x.c                                |   2 +-
>  hw/net/milkymist-minimac2.c                     |   2 +-
>  hw/nios2/10m50_devboard.c                       |   8 +-
>  hw/openrisc/openrisc_sim.c                      |   1 -
>  hw/pci-host/prep.c                              |   2 +-
>  hw/pci-host/xilinx-pcie.c                       |   2 +-
>  hw/pci/pci.c                                    |   1 -
>  hw/ppc/mac_newworld.c                           |   1 -
>  hw/ppc/mac_oldworld.c                           |   1 -
>  hw/ppc/ppc405_boards.c                          |   3 -
>  hw/ppc/ppc405_uc.c                              |   1 -
>  hw/s390x/sclp.c                                 |   1 -
>  hw/sh4/r2d.c                                    |   1 -
>  hw/sh4/shix.c                                   |   3 -
>  hw/sparc/leon3.c                                |   1 -
>  hw/sparc/sun4m.c                                |   6 +-
>  hw/sparc64/sun4u.c                              |   4 +-
>  hw/tricore/tricore_testboard.c                  |  26 ++--
>  hw/unicore32/puv3.c                             |   1 -
>  hw/xtensa/sim.c                                 |   4 +-
>  hw/xtensa/xtfpga.c                              |   4 +-
>  memory.c                                        | 110 +++++++++++++---
>  numa.c                                          |   4 +-
>  scripts/coccinelle/memory-region-init-ram.cocci |  38 ++++++
>  80 files changed, 385 insertions(+), 180 deletions(-)
>  create mode 100644 scripts/coccinelle/memory-region-init-ram.cocci
> 
