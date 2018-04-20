Received: from eggs.gnu.org ([2001:4830:134:3::10]:48942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Urf-0004Ky-M2
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Urb-0003ih-5k
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:10:07 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:37731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9Ura-0003hW-VN
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:10:03 -0400
Received: by mail-ot0-x231.google.com with SMTP id 77-v6so3247443otd.4
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 05:10:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180413075200.15217-1-clg@kaod.org>
References: <20180413075200.15217-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 13:09:41 +0100
Message-ID: <CAFEAcA9SKjBV-eKcSbNXPZexWnLMGT0n-xxOphfo47o1d7hxFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paolo Bonzini <pbonzini@redhat.com>

On 13 April 2018 at 08:52, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On the POWER9 processor, the XIVE interrupt controller can control
> interrupt sources using MMIO to trigger events, to EOI or to turn off
> the sources. Priority management and interrupt acknowledgment is also
> controlled by MMIO in the presenter sub-engine.
>
> These MMIO regions are exposed to guests in QEMU with a set of 'ram
> device' memory mappings, similarly to VFIO, and the VMAs are populated
> dynamically with the appropriate pages using a fault handler.
>
> But, these regions are an issue for migration. We need to discard the
> associated RAMBlocks from the RAM state on the source VM and let the
> destination VM rebuild the memory mappings on the new host in the
> post_load() operation just before resuming the system.
>
> To achieve this goal, the following introduces a new RAMBlock flag
> RAM_MIGRATABLE which is updated in the vmstate_register_ram() and
> vmstate_unregister_ram() routines. This flag is then used by the
> migration to identify RAMBlocks to discard on the source. Some checks
> are also performed on the destination to make sure nothing invalid was
> sent.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

So, this is conceptually the right thing, but it is a migration
compat break for any board which has a ram block which it doesn't
call vmstate_register_ram() for. These are mostly going to be
places that call one of the _nomigrate() functions to create an
MMIO region, and then don't register the ram by hand either.
Those are bugs, in my view, but we should consider fixing
them while we're here.

Here's the results of a grep and eyeballing of the results:

These places are OK, because they register the memory region
by hand one way or another:

numa stuff, registers it when the backend is used:
backends/hostmem-ram.c:
memory_region_init_ram_shared_nomigrate(&backend->mr, OBJECT(backend),
path,

registers it globally by hand:
numa.c:            memory_region_init_ram_nomigrate(mr, owner, name,
ram_size, &error_fatal);
numa.c:        memory_region_init_ram_nomigrate(mr, owner, name,
ram_size, &error_fatal);
hw/arm/aspeed_soc.c:    memory_region_init_ram_nomigrate(&s->sram,
OBJECT(dev), "aspeed.sram",
hw/block/onenand.c:    memory_region_init_ram_nomigrate(&s->ram,
OBJECT(s), "onenand.ram",
hw/display/cg3.c:    memory_region_init_ram_nomigrate(&s->rom, obj,
"cg3.prom", FCODE_MAX_ROM_SIZE,
hw/display/tcx.c:    memory_region_init_ram_nomigrate(&s->rom, obj,
"tcx.prom", FCODE_MAX_ROM_SIZE,
hw/display/tcx.c:    memory_region_init_ram_nomigrate(&s->vram_mem,
OBJECT(s), "tcx.vram",
hw/display/vga.c:    memory_region_init_ram_nomigrate(&s->vram, obj,
"vga.vram", s->vram_size,
hw/input/milkymist-softusb.c:
memory_region_init_ram_nomigrate(&s->pmem, OBJECT(s),
"milkymist-softusb.pmem",
hw/input/milkymist-softusb.c:
memory_region_init_ram_nomigrate(&s->dmem, OBJECT(s),
"milkymist-softusb.dmem",
hw/net/milkymist-minimac2.c:
memory_region_init_ram_nomigrate(&s->buffers, OBJECT(dev),
"milkymist-minimac2.buffers",
hw/pci-host/prep.c:    memory_region_init_ram_nomigrate(&s->bios,
OBJECT(s), "bios", BIOS_SIZE,
hw/sparc/sun4m.c:    memory_region_init_ram_nomigrate(&s->mem, obj,
hw/sparc/sun4m.c:    memory_region_init_ram_nomigrate(&s->mem, obj,
"sun4m.afx", 4, &error_fatal);
hw/sparc/sun4m.c:    memory_region_init_ram_nomigrate(&s->prom, obj,
"sun4m.prom", PROM_SIZE_MAX,
hw/sparc64/sun4u.c:    memory_region_init_ram_nomigrate(&s->prom, obj,
"sun4u.prom", PROM_SIZE_MAX,
hw/sparc64/sun4u.c:    memory_region_init_ram_nomigrate(&d->ram,
OBJECT(d), "sun4u.ram", d->size,
hw/xtensa/xtfpga.c:    memory_region_init_ram_nomigrate(ram,
OBJECT(s), "open_eth.ram", 16384,

registers it non-globally by hand:
hw/xen/xen_pt_load_rom.c:
memory_region_init_ram_nomigrate(&dev->rom, owner, name, st.st_size,
&error_abort);

These callsites are not OK, because they don't register the ram:

hw/arm/aspeed.c:        memory_region_init_rom_nomigrate(boot_rom,
OBJECT(bmc), "aspeed.boot_rom",
hw/arm/highbank.c:    memory_region_init_ram_nomigrate(sysram, NULL,
"highbank.sysram", 0x8000,
hw/mips/boston.c:    memory_region_init_rom_nomigrate(flash, NULL,
hw/mips/mips_malta.c:    memory_region_init_ram_nomigrate(bios_copy,
NULL, "bios.1fc", BIOS_SIZE,
hw/net/dp8393x.c:    memory_region_init_ram_nomigrate(&s->prom, OBJECT(dev)=
,
  [device only used on mips jazz board]
hw/pci-host/xilinx-pcie.c:    memory_region_init_ram_nomigrate(&s->io,
OBJECT(s), "io", 16, NULL);
  [device only used on mips boston board]

Notes:
 * any device that registers a ramblock globally is a bit dodgy, because
it means you can't have more than one of it (the ramblock names would
clash). We should fix those devices for the cases where we're willing
to take the migration compat break.
 * the xen_pt_load_rom.c case could be cleaned up to use memory_region_init=
_ram
   rather than the _nomigrate function without breaking compat

NB: I haven't actually tested whether this is a migration compat break,
I merely believe it to be so :-)

I think we can take the compat break on aspeed, highbank, malta and jazz.
Not sure about boston, but I guess so given the board doesn't have
per-QEMU-version machine models.

thanks
-- PMM
