Received: from eggs.gnu.org ([2001:4830:134:3::10]:50917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPoTj-0006rj-V2
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPoTi-0001lV-Tl
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:20:51 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:47100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPoTi-0001kv-Fq
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:20:50 -0400
Received: by mail-ot0-x231.google.com with SMTP id q1-v6so3880875oth.13
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 05:20:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Khsu3HTPbsJW-gBvbzrzJkb=z3tpmELwGyw3rQObJFA@mail.gmail.com>
References: <CAFEAcA8Khsu3HTPbsJW-gBvbzrzJkb=z3tpmELwGyw3rQObJFA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 13:20:29 +0100
Message-ID: <CAFEAcA8AFApznN92TvtSrDYDzOrvd3DyQvVEbbrvxzGY5UiCmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] unique (or otherwise) RAM block names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 1 June 2018 at 18:34, Peter Maydell <peter.maydell@linaro.org> wrote:
> In particular, this means that if you create what you expect to
> be a local-to-this-device RAM memory region in a SysBusDevice,
> then (because SysBus doesn't implement get_dev_path), there is
> no per-device qualification added to the region name, and so the
> code silently creates a globally-namespaced RAM region.
> Trying to create multiple instances of the device therefore fails.

I did an audit of everywhere that creates a RAM region with an
owner (either by calling vmstate_register_ram() with a non-NULL
owner, or by calling memory_region_init_{ram,rom,rom_device} with
a non-NULL owner:

hw/display/g364fb.c:    vmstate_register_ram(&s->mem_vram, dev);
  TYPE_G364 (sysbus)
hw/display/vga.c:    vmstate_register_ram(&s->vram, global_vmstate ?
NULL : DEVICE(obj));
  NULL dev, or passed by caller of vga_common_init()
     TYPE_ISA_CIRRUS_VGA (ISA) (but OK as it passes global_vmstate = true)
     TYPE_PCI_CIRRUS_VGA (PCI)
     TYPE_PCI_QXL (PCI)
     TYPE_PCI_VGA (PCI)
     TYPE_VIRTIO_VGA (PCI)
     TYPE_VMWARE_SVGA (PCI)
hw/mem/pc-dimm.c:    vmstate_register_ram(vmstate_mr, dev);
  TYPE_PC_DIMM (?)
hw/misc/ivshmem.c:    vmstate_register_ram(s->ivshmem_bar2, DEVICE(s));
  TYPE_IVSHMEM_COMMON (PCI)

hw/display/qxl.c:    memory_region_init_ram(&qxl->rom_bar,
OBJECT(qxl), "qxl.vrom",
hw/display/qxl.c:    memory_region_init_ram(&qxl->vram_bar,
OBJECT(qxl), "qxl.vram",
hw/display/qxl.c:    memory_region_init_ram(&qxl->vga.vram,
OBJECT(dev), "qxl.vgavram",
  TYPE_PCI_QXL (PCI)
hw/pci/pci.c:    memory_region_init_rom(&pdev->rom, OBJECT(pdev),
name, size, &error_fatal);
  -- PCIDevice
hw/arm/aspeed_soc.c:    memory_region_init_ram(&s->sram, OBJECT(dev),
"aspeed.sram",
  TYPE_ASPEED_SOC (sysbus)
hw/arm/integratorcp.c:    memory_region_init_ram(&s->flash, OBJECT(d),
"integrator.flash", 0x100000,
  TYPE_INTEGRATOR_CM (sysbus)
hw/display/bochs-display.c:    memory_region_init_ram(&s->vram, obj,
"bochs-display-vram", s->vgamem,
  TYPE_BOCHS_DISPLAY (PCI)
hw/display/sm501.c:    memory_region_init_ram(&s->local_mem_region,
OBJECT(dev), "sm501.local",
  TYPE_SYSBUS_SM501 (sysbus)
  TYPE_PCI_SM501 (PCI)
hw/tpm/tpm_crb.c:    memory_region_init_ram(&s->cmdmem, OBJECT(s),
  TYPE_TPM_CRB (TYPE_DEVICE)
hw/xen/xen_pt_load_rom.c:    memory_region_init_ram(&dev->rom, owner,
name, st.st_size, &error_abort);
  PCI device
hw/arm/aspeed.c:        memory_region_init_rom(boot_rom, OBJECT(bmc),
"aspeed.boot_rom",
   -- this is bogus because BMC isn't really an object; it happens
that its first member is an AspeedSoCState; TYPE_ASPEED_SOC is a
TYPE_DEVICE

memory_region_init_rom_device()
hw/block/pflash_cfi01.c:    memory_region_init_rom_device(
 TYPE_CFI_PFLASH01 (sysbus)
hw/block/pflash_cfi02.c:
memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
 TYPE_CFI_PFLASH02 (sysbus)

PCI implements get_dev_path. The other uses of RAM regions with
owners but unexpectedly non-local names thus are:
  TYPE_G364 (sysbus)
  TYPE_PC_DIMM (?)
  TYPE_ASPEED_SOC (sysbus)
  TYPE_INTEGRATOR_CM (sysbus)
  TYPE_SYSBUS_SM501 (sysbus)
  TYPE_TPM_CRB (TYPE_DEVICE)
  TYPE_CFI_PFLASH01 (sysbus)
  TYPE_CFI_PFLASH02 (sysbus)

thanks
-- PMM
