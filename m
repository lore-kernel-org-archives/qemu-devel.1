Received: from eggs.gnu.org ([2001:4830:134:3::10]:42448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9oGx-0004hb-BK
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 04:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9oGs-00080I-El
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 04:53:31 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:55935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f9oGs-0007te-2q
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 04:53:26 -0400
Received: from player796.ha.ovh.net (unknown [10.109.108.60])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 114C0ACAB1
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 10:53:16 +0200 (CEST)
References: <20180413075200.15217-1-clg@kaod.org>
	<CAFEAcA9SKjBV-eKcSbNXPZexWnLMGT0n-xxOphfo47o1d7hxFA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <550f552e-059c-f611-11d5-4793c733babd@kaod.org>
Date: Sat, 21 Apr 2018 10:52:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9SKjBV-eKcSbNXPZexWnLMGT0n-xxOphfo47o1d7hxFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paolo Bonzini <pbonzini@redhat.com>

On 04/20/2018 02:09 PM, Peter Maydell wrote:
> On 13 April 2018 at 08:52, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> On the POWER9 processor, the XIVE interrupt controller can control
>> interrupt sources using MMIO to trigger events, to EOI or to turn off
>> the sources. Priority management and interrupt acknowledgment is also
>> controlled by MMIO in the presenter sub-engine.
>>
>> These MMIO regions are exposed to guests in QEMU with a set of 'ram
>> device' memory mappings, similarly to VFIO, and the VMAs are populated
>> dynamically with the appropriate pages using a fault handler.
>>
>> But, these regions are an issue for migration. We need to discard the
>> associated RAMBlocks from the RAM state on the source VM and let the
>> destination VM rebuild the memory mappings on the new host in the
>> post_load() operation just before resuming the system.
>>
>> To achieve this goal, the following introduces a new RAMBlock flag
>> RAM_MIGRATABLE which is updated in the vmstate_register_ram() and
>> vmstate_unregister_ram() routines. This flag is then used by the
>> migration to identify RAMBlocks to discard on the source. Some checks
>> are also performed on the destination to make sure nothing invalid was
>> sent.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> So, this is conceptually the right thing, but it is a migration
> compat break for any board which has a ram block which it doesn't
> call vmstate_register_ram() for. These are mostly going to be
> places that call one of the _nomigrate() functions to create an
> MMIO region, and then don't register the ram by hand either.> Those are=
 bugs, in my view, but we should consider fixing
> them while we're here.
>
> Here's the results of a grep and eyeballing of the results:
>=20
> These places are OK, because they register the memory region
> by hand one way or another:
>=20
> numa stuff, registers it when the backend is used:
> backends/hostmem-ram.c:
> memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backend),
> path,
>=20
> registers it globally by hand:
> numa.c:            memory_region_init_ram_nomigrate(mr, owner, name,
> ram_size, &error_fatal);
> numa.c:        memory_region_init_ram_nomigrate(mr, owner, name,
> ram_size, &error_fatal);
> hw/arm/aspeed_soc.c:    memory_region_init_ram_nomigrate(&s->sram,
> OBJECT(dev), "aspeed.sram",
> hw/block/onenand.c:    memory_region_init_ram_nomigrate(&s->ram,
> OBJECT(s), "onenand.ram",
> hw/display/cg3.c:    memory_region_init_ram_nomigrate(&s->rom, obj,
> "cg3.prom", FCODE_MAX_ROM_SIZE,
> hw/display/tcx.c:    memory_region_init_ram_nomigrate(&s->rom, obj,
> "tcx.prom", FCODE_MAX_ROM_SIZE,
> hw/display/tcx.c:    memory_region_init_ram_nomigrate(&s->vram_mem,
> OBJECT(s), "tcx.vram",
> hw/display/vga.c:    memory_region_init_ram_nomigrate(&s->vram, obj,
> "vga.vram", s->vram_size,
> hw/input/milkymist-softusb.c:
> memory_region_init_ram_nomigrate(&s->pmem, OBJECT(s),
> "milkymist-softusb.pmem",
> hw/input/milkymist-softusb.c:
> memory_region_init_ram_nomigrate(&s->dmem, OBJECT(s),
> "milkymist-softusb.dmem",
> hw/net/milkymist-minimac2.c:
> memory_region_init_ram_nomigrate(&s->buffers, OBJECT(dev),
> "milkymist-minimac2.buffers",
> hw/pci-host/prep.c:    memory_region_init_ram_nomigrate(&s->bios,
> OBJECT(s), "bios", BIOS_SIZE,
> hw/sparc/sun4m.c:    memory_region_init_ram_nomigrate(&s->mem, obj,
> hw/sparc/sun4m.c:    memory_region_init_ram_nomigrate(&s->mem, obj,
> "sun4m.afx", 4, &error_fatal);
> hw/sparc/sun4m.c:    memory_region_init_ram_nomigrate(&s->prom, obj,
> "sun4m.prom", PROM_SIZE_MAX,
> hw/sparc64/sun4u.c:    memory_region_init_ram_nomigrate(&s->prom, obj,
> "sun4u.prom", PROM_SIZE_MAX,
> hw/sparc64/sun4u.c:    memory_region_init_ram_nomigrate(&d->ram,
> OBJECT(d), "sun4u.ram", d->size,
> hw/xtensa/xtfpga.c:    memory_region_init_ram_nomigrate(ram,
> OBJECT(s), "open_eth.ram", 16384,
>=20
> registers it non-globally by hand:
> hw/xen/xen_pt_load_rom.c:
> memory_region_init_ram_nomigrate(&dev->rom, owner, name, st.st_size,
> &error_abort);
>=20
> These callsites are not OK, because they don't register the ram:
>=20
> hw/arm/aspeed.c:        memory_region_init_rom_nomigrate(boot_rom,
> OBJECT(bmc), "aspeed.boot_rom",
> hw/arm/highbank.c:    memory_region_init_ram_nomigrate(sysram, NULL,
> "highbank.sysram", 0x8000,
> hw/mips/boston.c:    memory_region_init_rom_nomigrate(flash, NULL,
> hw/mips/mips_malta.c:    memory_region_init_ram_nomigrate(bios_copy,
> NULL, "bios.1fc", BIOS_SIZE,
> hw/net/dp8393x.c:    memory_region_init_ram_nomigrate(&s->prom, OBJECT(=
dev),
>   [device only used on mips jazz board]
> hw/pci-host/xilinx-pcie.c:    memory_region_init_ram_nomigrate(&s->io,
> OBJECT(s), "io", 16, NULL);
>   [device only used on mips boston board]
>=20
> Notes:
>  * any device that registers a ramblock globally is a bit dodgy, becaus=
e
> it means you can't have more than one of it (the ramblock names would
> clash). We should fix those devices for the cases where we're willing
> to take the migration compat break.

There are quite a few models calling memory_region_init_ram() with=20
a NULL owner, see below. Should we fix all these ?=20

Thanks,

C.=20

>  * the xen_pt_load_rom.c case could be cleaned up to use memory_region_=
init_ram
>    rather than the _nomigrate function without breaking compat
>=20
> NB: I haven't actually tested whether this is a migration compat break,
> I merely believe it to be so :-)
>=20
> I think we can take the compat break on aspeed, highbank, malta and jaz=
z.
> Not sure about boston, but I guess so given the board doesn't have
> per-QEMU-version machine models.
>=20
> thanks
> -- PMM
>=20


hw/arm/msf2-soc.c:    memory_region_init_ram(sram, NULL, "MSF2.eSRAM", s-=
>esram_size,
hw/arm/vexpress.c:    memory_region_init_ram(sram, NULL, "vexpress.a15sra=
m", 0x10000,
hw/arm/vexpress.c:    memory_region_init_ram(sram, NULL, "vexpress.sram",=
 sram_size,
hw/arm/vexpress.c:    memory_region_init_ram(vram, NULL, "vexpress.vram",=
 vram_size,
hw/arm/palm.c:    memory_region_init_ram(flash, NULL, "palmte.flash", fla=
sh_size,
hw/arm/omap1.c:    memory_region_init_ram(&s->imif_ram, NULL, "omap1.sram=
", s->sram_size,
hw/arm/omap2.c:    memory_region_init_ram(&s->sram, NULL, "omap2.sram", s=
->sram_size,
hw/arm/fsl-imx6.c:    memory_region_init_ram(&s->ocram, NULL, "imx6.ocram=
", FSL_IMX6_OCRAM_SIZE,
hw/arm/mps2-tz.c:    memory_region_init_ram(mr, NULL, name, size, &error_=
fatal);
hw/arm/mainstone.c:    memory_region_init_ram(rom, NULL, "mainstone.rom",=
 MAINSTONE_ROM,
hw/arm/tosa.c:    memory_region_init_ram(rom, NULL, "tosa.rom", TOSA_ROM,=
 &error_fatal);
hw/arm/spitz.c:    memory_region_init_ram(rom, NULL, "spitz.rom", SPITZ_R=
OM, &error_fatal);
hw/arm/exynos4210.c:    memory_region_init_ram(&s->irom_mem, NULL, "exyno=
s4210.irom",
hw/arm/exynos4210.c:    memory_region_init_ram(&s->iram_mem, NULL, "exyno=
s4210.iram",
hw/arm/omap_sx1.c:    memory_region_init_ram(flash, NULL, "omap_sx1.flash=
0-0", flash_size,
hw/arm/omap_sx1.c:        memory_region_init_ram(flash_1, NULL, "omap_sx1=
.flash1-0",
hw/arm/stm32f205_soc.c:    memory_region_init_ram(flash, NULL, "STM32F205=
.flash", FLASH_SIZE,
hw/arm/stm32f205_soc.c:    memory_region_init_ram(sram, NULL, "STM32F205.=
sram", SRAM_SIZE,
hw/arm/iotkit.c:    memory_region_init_ram(&s->sram0, NULL, "iotkit.sram0=
", 0x00008000, &err);
hw/arm/fsl-imx31.c:    memory_region_init_ram(&s->iram, NULL, "imx31.iram=
", FSL_IMX31_IRAM_SIZE,
hw/arm/xilinx_zynq.c:    memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_=
ram", 256 << 10,
hw/arm/xlnx-zynqmp.c:        memory_region_init_ram(&s->ocm_ram[i], NULL,=
 ocm_name,
hw/arm/musicpal.c:    memory_region_init_ram(sram, NULL, "musicpal.sram",=
 MP_SRAM_SIZE,
hw/arm/virt.c:    memory_region_init_ram(secram, NULL, "virt.secure-ram",=
 size,
hw/arm/exynos4_boards.c:        memory_region_init_ram(&s->dram1_mem, NUL=
L, "exynos4210.dram1",
hw/arm/exynos4_boards.c:    memory_region_init_ram(&s->dram0_mem, NULL, "=
exynos4210.dram0", mem_size,
hw/arm/stellaris.c:    memory_region_init_ram(flash, NULL, "stellaris.fla=
sh", flash_size,
hw/arm/stellaris.c:    memory_region_init_ram(sram, NULL, "stellaris.sram=
", sram_size,
hw/arm/pxa2xx.c:    memory_region_init_ram(&s->sdram, NULL, "pxa270.sdram=
", sdram_size,
hw/arm/pxa2xx.c:    memory_region_init_ram(&s->internal, NULL, "pxa270.in=
ternal", 0x40000,
hw/arm/pxa2xx.c:    memory_region_init_ram(&s->sdram, NULL, "pxa255.sdram=
", sdram_size,
hw/arm/pxa2xx.c:    memory_region_init_ram(&s->internal, NULL, "pxa255.in=
ternal",
hw/arm/fsl-imx25.c:    memory_region_init_ram(&s->iram, NULL, "imx25.iram=
", FSL_IMX25_IRAM_SIZE,
hw/arm/mps2.c:    memory_region_init_ram(mr, NULL, name, size, &error_fat=
al);
hw/arm/msf2-som.c:    memory_region_init_ram(ddr, NULL, "ddr-ram", DDR_SI=
ZE,
hw/arm/realview.c:        memory_region_init_ram(ram_lo, NULL, "realview.=
lowmem", low_ram_size,
hw/arm/realview.c:    memory_region_init_ram(ram_hi, NULL, "realview.high=
mem", ram_size,
hw/arm/realview.c:    memory_region_init_ram(ram_hack, NULL, "realview.ha=
ck", 0x1000,
hw/tricore/tricore_testboard.c:    memory_region_init_ram(ext_cram, NULL,=
 "powerlink_ext_c.ram",
hw/tricore/tricore_testboard.c:    memory_region_init_ram(ext_dram, NULL,=
 "powerlink_ext_d.ram",
hw/tricore/tricore_testboard.c:    memory_region_init_ram(int_cram, NULL,=
 "powerlink_int_c.ram", 48 * 1024,
hw/tricore/tricore_testboard.c:    memory_region_init_ram(int_dram, NULL,=
 "powerlink_int_d.ram", 48 * 1024,
hw/tricore/tricore_testboard.c:    memory_region_init_ram(pcp_data, NULL,=
 "powerlink_pcp_data.ram",
hw/tricore/tricore_testboard.c:    memory_region_init_ram(pcp_text, NULL,=
 "powerlink_pcp_text.ram",
hw/nios2/10m50_devboard.c:    memory_region_init_ram(phys_tcm, NULL, "nio=
s2.tcm", tcm_size,
hw/nios2/10m50_devboard.c:    memory_region_init_ram(phys_ram, NULL, "nio=
s2.ram", ram_size,
hw/xtensa/xtensa_memory.c:        memory_region_init_ram(m, NULL, num_nam=
e->str,
hw/ppc/ppc405_boards.c:    memory_region_init_ram(sram, NULL, "ef405ep.sr=
am", sram_size,
hw/ppc/ppc405_boards.c:        memory_region_init_ram(bios, NULL, "ef405e=
p.bios", BIOS_SIZE,
hw/ppc/ppc405_boards.c:        memory_region_init_ram(bios, NULL, "taihu_=
405ep.bios", BIOS_SIZE,
hw/ppc/mac_newworld.c:    memory_region_init_ram(bios, NULL, "ppc_core99.=
bios", BIOS_SIZE,
hw/ppc/mac_oldworld.c:    memory_region_init_ram(bios, NULL, "ppc_heathro=
w.bios", BIOS_SIZE,
hw/ppc/ppc440_uc.c:    memory_region_init_ram(&l2sram->bank[0], NULL, "pp=
c4xx.l2sram_bank0",
hw/ppc/ppc440_uc.c:    memory_region_init_ram(&l2sram->bank[1], NULL, "pp=
c4xx.l2sram_bank1",
hw/ppc/ppc440_uc.c:    memory_region_init_ram(&l2sram->bank[2], NULL, "pp=
c4xx.l2sram_bank2",
hw/ppc/ppc440_uc.c:    memory_region_init_ram(&l2sram->bank[3], NULL, "pp=
c4xx.l2sram_bank3",
hw/ppc/ppc405_uc.c:    memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc=
405.ocm", 4096,
hw/ppc/sam460ex.c:    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l=
2cache_ram", 256 << 10,
hw/mips/mips_mipssim.c:    memory_region_init_ram(bios, NULL, "mips_mipss=
im.bios", BIOS_SIZE,
hw/mips/mips_fulong2e.c:    memory_region_init_ram(bios, NULL, "fulong2e.=
bios", bios_size,
hw/mips/mips_jazz.c:    memory_region_init_ram(bios, NULL, "mips_jazz.bio=
s", MAGNUM_BIOS_SIZE,
hw/mips/mips_jazz.c:            memory_region_init_ram(rom_mr, NULL, "g36=
4fb.rom", 0x80000,
hw/mips/mips_r4k.c:        memory_region_init_ram(bios, NULL, "mips_r4k.b=
ios", BIOS_SIZE,
hw/sparc/leon3.c:    memory_region_init_ram(prom, NULL, "Leon3.bios", pro=
m_size, &error_fatal);
hw/microblaze/petalogix_ml605_mmu.c:    memory_region_init_ram(phys_lmb_b=
ram, NULL, "petalogix_ml605.lmb_bram",
hw/microblaze/petalogix_ml605_mmu.c:    memory_region_init_ram(phys_ram, =
NULL, "petalogix_ml605.ram", ram_size,
hw/microblaze/petalogix_s3adsp1800_mmu.c:    memory_region_init_ram(phys_=
lmb_bram, NULL,
hw/microblaze/petalogix_s3adsp1800_mmu.c:    memory_region_init_ram(phys_=
ram, NULL, "petalogix_s3adsp1800.ram",
hw/microblaze/xlnx-zynqmp-pmu.c:    memory_region_init_ram(pmu_ram, NULL,=
 "xlnx-zynqmp-pmu.ram",
hw/cris/axis_dev88.c:    memory_region_init_ram(phys_intmem, NULL, "axisd=
ev88.chipram",
hw/riscv/sifive_u.c:    memory_region_init_ram(main_mem, NULL, "riscv.sif=
ive.u.ram",
hw/riscv/sifive_u.c:    memory_region_init_ram(boot_rom, NULL, "riscv.sif=
ive.u.mrom",
hw/riscv/sifive_e.c:    memory_region_init_ram(mock_mmio, NULL, name, len=
gth, &error_fatal);
hw/riscv/sifive_e.c:    memory_region_init_ram(main_mem, NULL, "riscv.sif=
ive.e.ram",
hw/riscv/sifive_e.c:    memory_region_init_ram(mask_rom, NULL, "riscv.sif=
ive.e.mrom",
hw/riscv/sifive_e.c:    memory_region_init_ram(xip_mem, NULL, "riscv.sifi=
ve.e.xip",
hw/riscv/spike.c:    memory_region_init_ram(main_mem, NULL, "riscv.spike.=
ram",
hw/riscv/spike.c:    memory_region_init_ram(boot_rom, NULL, "riscv.spike.=
bootrom",
hw/riscv/spike.c:    memory_region_init_ram(main_mem, NULL, "riscv.spike.=
ram",
hw/riscv/spike.c:    memory_region_init_ram(boot_rom, NULL, "riscv.spike.=
bootrom",
hw/riscv/virt.c:    memory_region_init_ram(main_mem, NULL, "riscv_virt_bo=
ard.ram",
hw/riscv/virt.c:    memory_region_init_ram(boot_rom, NULL, "riscv_virt_bo=
ard.bootrom",
hw/sh4/shix.c:    memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &=
error_fatal);
hw/sh4/shix.c:    memory_region_init_ram(&sdram[0], NULL, "shix.sdram1", =
0x01000000,
hw/sh4/shix.c:    memory_region_init_ram(&sdram[1], NULL, "shix.sdram2", =
0x01000000,
hw/sh4/r2d.c:    memory_region_init_ram(sdram, NULL, "r2d.sdram", SDRAM_S=
IZE, &error_fatal);
hw/moxie/moxiesim.c:    memory_region_init_ram(ram, NULL, "moxiesim.ram",=
 ram_size, &error_fatal);
hw/moxie/moxiesim.c:    memory_region_init_ram(rom, NULL, "moxie.rom", FI=
RMWARE_SIZE, &error_fatal);
hw/m68k/mcf5208.c:    memory_region_init_ram(sram, NULL, "mcf5208.sram", =
16384, &error_fatal);
hw/m68k/an5206.c:    memory_region_init_ram(sram, NULL, "an5206.sram", 51=
2, &error_fatal);
hw/i386/pc_sysfw.c:    memory_region_init_ram(isa_bios, NULL, "isa-bios",=
 isa_bios_size,
hw/i386/pc_sysfw.c:    memory_region_init_ram(bios, NULL, "pc.bios", bios=
_size, &error_fatal);
hw/i386/xen/xen-hvm.c:    memory_region_init_ram(&ram_memory, NULL, "xen.=
ram", block_len,
hw/i386/pc.c:    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC=
_ROM_SIZE,
hw/display/tc6393xb.c:    memory_region_init_ram(&s->vram, NULL, "tc6393x=
b.vram", 0x100000,
hw/display/vmware_vga.c:    memory_region_init_ram(&s->fifo_ram, NULL, "v=
msvga.fifo", s->fifo_size,
hw/display/cg3.c:    memory_region_init_ram(&s->vram_mem, NULL, "cg3.vram=
", s->vram_size,
hw/openrisc/openrisc_sim.c:    memory_region_init_ram(ram, NULL, "openris=
c.ram", ram_size, &error_fatal);
hw/unicore32/puv3.c:    memory_region_init_ram(ram_memory, NULL, "puv3.ra=
m", ram_size,
