Received: from eggs.gnu.org ([2001:4830:134:3::10]:35524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dju98-0006oi-Mh
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 17:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dju94-0008Hq-AS
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 17:22:06 -0400
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<1815e11378b48532e902e0138a58557c297c3eb2.1503249785.git.balaton@eik.bme.hu>
From: John Snow <jsnow@redhat.com>
Message-ID: <088c08f0-d4cd-e1c2-6715-3aeb33b7f4b9@redhat.com>
Date: Mon, 21 Aug 2017 17:14:04 -0400
MIME-Version: 1.0
In-Reply-To: <1815e11378b48532e902e0138a58557c297c3eb2.1503249785.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/15] hw/ide: Emulate SiI3112 SATA
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>



On 08/20/2017 01:23 PM, BALATON Zoltan wrote:
> This is a common generic PCI SATA conroller that is also used in PCs
> but more importantly guests running on the Sam460ex board prefer this
> card and have a driver for it (unlike for other SATA controllers
> already emulated).
> 

Oh, interesting. This is basically an alternative to the PCI BMDMA
interface and not really an alternative to AHCI. It doesn't really seem
to use any of the SATA-specific interfaces to SATA drives (cough, not
that we currently emulate a difference in QEMU... ATA and SATA both are
simply IDEState*) so this really seems like another PCI IDE interface
akin to the PCI BMDMA adapter we already have.

It's just that guests will think they're using SATA, except... not. Not
a big deal, *I think*...

...It isn't a problem that our support for NCQ commands is tied to AHCI,
is it? Some of our current "SATA" support is tied very directly to AHCI
(see is_ncq() in ahci.c) -- is that relevant here?

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

I'd like to invite you to create a Sam460ex MAINTAINERS stanza, add
yourself, and add hw/ide/sii3112.c to that stanza.

--js

> ---
>  hw/ide/Makefile.objs |   1 +
>  hw/ide/sii3112.c     | 369 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 370 insertions(+)
>  create mode 100644 hw/ide/sii3112.c
> 
> diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
> index 729e9bd..76f3d6d 100644
> --- a/hw/ide/Makefile.objs
> +++ b/hw/ide/Makefile.objs
> @@ -10,3 +10,4 @@ common-obj-$(CONFIG_IDE_VIA) += via.o
>  common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
>  common-obj-$(CONFIG_AHCI) += ahci.o
>  common-obj-$(CONFIG_AHCI) += ich.o
> +common-obj-$(CONFIG_IDE_SII3112) += sii3112.o
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> new file mode 100644
> index 0000000..9ec8cd1
> --- /dev/null
> +++ b/hw/ide/sii3112.c
> @@ -0,0 +1,369 @@
> +/*
> + * QEMU SiI3112A PCI to Serial ATA Controller Emulation
> + *
> + * Copyright (C) 2017 BALATON Zoltan <balaton@eik.bme.hu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +/* For documentation on this and similar cards see:
> + * http://wiki.osdev.org/User:Quok/Silicon_Image_Datasheets
> + */

Thank you so much for including docs!

> +
> +#include <qemu/osdep.h>
> +#include <hw/ide/pci.h>
> +
> +#ifdef DEBUG_IDE
> +#define DPRINTF(fmt, ...) fprintf(stderr, fmt, ## __VA_ARGS__);
> +#else
> +#define DPRINTF(fmt, ...)
> +#endif /* DEBUG */
> +

Please use trace events instead of DPRINTF; I'm in the process of
removing them from the rest of IDE.

> +#define TYPE_SII3112_PCI "sii3112"
> +#define SII3112_PCI(obj) OBJECT_CHECK(SiI3112PCIState, (obj), \
> +                         TYPE_SII3112_PCI)
> +
> +typedef struct SiI3112Regs {
> +    uint32_t confstat;
> +    uint32_t scontrol;
> +    uint16_t sien;
> +    uint8_t swdata;
> +} SiI3112Regs;
> +
> +typedef struct SiI3112PCIState {
> +    PCIIDEState i;
> +    MemoryRegion mmio;
> +    SiI3112Regs regs[2];
> +} SiI3112PCIState;
> +
> +static uint64_t sii3112_reg_read(void *opaque, hwaddr addr,
> +                                unsigned int size)
> +{
> +    SiI3112PCIState *d = opaque;
> +    uint64_t val = 0;
> +
> +    switch (addr) {
> +    case 0x00:
> +        val = d->i.bmdma[0].cmd;
> +        break;
> +    case 0x01:
> +        val = d->regs[0].swdata;
> +        break;
> +    case 0x02:
> +        val = d->i.bmdma[0].status;
> +        break;
> +    case 0x03:
> +        val = 0;
> +        break;
> +    case 0x04 ... 0x07:
> +        val = bmdma_addr_ioport_ops.read(&d->i.bmdma[0], addr - 4, size);
> +        break;
> +    case 0x08:
> +        val = d->i.bmdma[1].cmd;
> +        break;
> +    case 0x09:
> +        val = d->regs[1].swdata;
> +        break;
> +    case 0x0a:
> +        val = d->i.bmdma[1].status;
> +        break;
> +    case 0x0b:
> +        val = 0;
> +        break;
> +    case 0x0c ... 0x0f:
> +        val = bmdma_addr_ioport_ops.read(&d->i.bmdma[1], addr - 12, size);
> +        break;
> +    case 0x10:
> +        val = d->i.bmdma[0].cmd;
> +        val |= (d->regs[0].confstat & (1UL << 11) ? (1 << 4) : 0); /*SATAINT0*/
> +        val |= (d->regs[1].confstat & (1UL << 11) ? (1 << 6) : 0); /*SATAINT1*/
> +        val |= (d->i.bmdma[1].status & BM_STATUS_INT ? (1 << 14) : 0);
> +        val |= d->i.bmdma[0].status << 16;
> +        val |= d->i.bmdma[1].status << 24;
> +        break;
> +    case 0x18:
> +        val = d->i.bmdma[1].cmd;
> +        val |= (d->regs[1].confstat & (1UL << 11) ? (1 << 4) : 0);
> +        val |= d->i.bmdma[1].status << 16;
> +        break;
> +    case 0x80 ... 0x87:
> +        if (size == 1) {
> +            val = ide_ioport_read(&d->i.bus[0], addr - 0x80);
> +        } else if (addr == 0x80) {
> +            val = (size == 2) ? ide_data_readw(&d->i.bus[0], 0) :
> +                                ide_data_readl(&d->i.bus[0], 0);
> +        } else {
> +            val = (1ULL << (size * 8)) - 1;
> +        }
> +        break;
> +    case 0x8a:
> +        val = (size == 1) ? ide_status_read(&d->i.bus[0], 4) :
> +                            (1ULL << (size * 8)) - 1;
> +        break;
> +    case 0xa0:
> +        val = d->regs[0].confstat;
> +        break;
> +    case 0xc0 ... 0xc7:
> +        if (size == 1) {
> +            val = ide_ioport_read(&d->i.bus[1], addr - 0xc0);
> +        } else if (addr == 0xc0) {
> +            val = (size == 2) ? ide_data_readw(&d->i.bus[1], 0) :
> +                                ide_data_readl(&d->i.bus[1], 0);
> +        } else {
> +            val = (1ULL << (size * 8)) - 1;
> +        }
> +        break;
> +    case 0xca:
> +        val = (size == 1) ? ide_status_read(&d->i.bus[0], 4) :
> +                            (1ULL << (size * 8)) - 1;
> +        break;
> +    case 0xe0:
> +        val = d->regs[1].confstat;
> +        break;
> +    case 0x100:
> +        val = d->regs[0].scontrol;
> +        break;
> +    case 0x104:
> +        val = (d->i.bus[0].ifs[0].blk) ? 0x113 : 0;
> +        break;
> +    case 0x148:
> +        val = d->regs[0].sien << 16;
> +        break;
> +    case 0x180:
> +        val = d->regs[1].scontrol;
> +        break;
> +    case 0x184:
> +        val = (d->i.bus[1].ifs[0].blk) ? 0x113 : 0;
> +        break;
> +    case 0x1c8:
> +        val = d->regs[1].sien << 16;
> +        break;
> +    default:
> +        val = 0;
> +    }
> +    DPRINTF("%s: addr 0x%"PRIx64 " size %d = %"PRIx64 "\n",
> +            __func__, addr, size, val);
> +    return val;
> +}
> +
> +static void sii3112_reg_write(void *opaque, hwaddr addr,
> +                              uint64_t val, unsigned int size)
> +{
> +    SiI3112PCIState *d = opaque;
> +
> +    DPRINTF("%s: addr 0x%"PRIx64 " size %d = %"PRIx64 "\n",
> +            __func__, addr, size, val);
> +    switch (addr) {
> +    case 0x00:
> +    case 0x10:
> +        bmdma_cmd_writeb(&d->i.bmdma[0], val);
> +        break;
> +    case 0x01:
> +    case 0x11:
> +        d->regs[0].swdata = val & 0x3f;
> +        break;
> +    case 0x02:
> +    case 0x12:
> +        d->i.bmdma[0].status = (val & 0x60) | (d->i.bmdma[0].status & 1) |
> +                               (d->i.bmdma[0].status & ~val & 6);
> +        break;
> +    case 0x04 ... 0x07:
> +        bmdma_addr_ioport_ops.write(&d->i.bmdma[0], addr - 4, val, size);
> +        break;
> +    case 0x08:
> +    case 0x18:
> +        bmdma_cmd_writeb(&d->i.bmdma[1], val);
> +        break;
> +    case 0x09:
> +    case 0x19:
> +        d->regs[1].swdata = val & 0x3f;
> +        break;
> +    case 0x0a:
> +    case 0x1a:
> +        d->i.bmdma[1].status = (val & 0x60) | (d->i.bmdma[1].status & 1) |
> +                               (d->i.bmdma[1].status & ~val & 6);
> +        break;
> +    case 0x0c ... 0x0f:
> +        bmdma_addr_ioport_ops.write(&d->i.bmdma[1], addr - 12, val, size);
> +        break;


What register(s) sit at [0x10 - 0x1a]?
Isn't BAR4 only 0x00 through 0x0F?


> +    case 0x80 ... 0x87:
> +        if (size == 1) {
> +            ide_ioport_write(&d->i.bus[0], addr - 0x80, val);
> +        } else if (addr == 0x80) {
> +            if (size == 2) {
> +                ide_data_writew(&d->i.bus[0], 0, val);
> +            } else {
> +                ide_data_writel(&d->i.bus[0], 0, val);
> +            }
> +        }
> +        break;
> +    case 0x8a:
> +        if (size == 1) {
> +            ide_cmd_write(&d->i.bus[0], 4, val);
> +        }
> +        break;

IDE0 stuff.

> +    case 0xc0 ... 0xc7:
> +        if (size == 1) {
> +            ide_ioport_write(&d->i.bus[1], addr - 0xc0, val);
> +        } else if (addr == 0xc0) {
> +            if (size == 2) {
> +                ide_data_writew(&d->i.bus[1], 0, val);
> +            } else {
> +                ide_data_writel(&d->i.bus[1], 0, val);
> +            }
> +        }
> +        break;
> +    case 0xca:
> +        if (size == 1) {
> +            ide_cmd_write(&d->i.bus[1], 4, val);
> +        }
> +        break;

IDE1 stuff.

> +    case 0x100:
> +        d->regs[0].scontrol = val & 0xfff;
> +        if (val & 1) {
> +            ide_bus_reset(&d->i.bus[0]);
> +        }
> +        break;
> +    case 0x148:
> +        d->regs[0].sien = (val >> 16) & 0x3eed;
> +        break;
> +    case 0x180:
> +        d->regs[1].scontrol = val & 0xfff;
> +        if (val & 1) {
> +            ide_bus_reset(&d->i.bus[1]);
> +        }
> +        break;
> +    case 0x1c8:
> +        d->regs[1].sien = (val >> 16) & 0x3eed;
> +        break;

Not sure what these ones are.

> +    default:
> +        val = 0;
> +    }
> +}
> +
> +static const MemoryRegionOps sii3112_reg_ops = {
> +    .read = sii3112_reg_read,
> +    .write = sii3112_reg_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +/* the PCI irq level is the logical OR of the two channels */
> +static void sii3112_update_irq(SiI3112PCIState *s)
> +{
> +    int i, set = 0;
> +
> +    for (i = 0; i < 2; i++) {
> +        set |= s->regs[i].confstat & (1UL << 11);
> +    }
> +    pci_set_irq(PCI_DEVICE(s), (set ? 1 : 0));
> +}
> +
> +static void sii3112_set_irq(void *opaque, int channel, int level)
> +{
> +    SiI3112PCIState *s = opaque;
> +
> +    DPRINTF("%s: channel %d level %d\n", __func__, channel, level);
> +    if (level) {
> +        s->regs[channel].confstat |= (1UL << 11);
> +    } else {
> +        s->regs[channel].confstat &= ~(1UL << 11);
> +    }
> +
> +    sii3112_update_irq(s);
> +}
> +
> +static void sii3112_reset(void *opaque)
> +{
> +    SiI3112PCIState *s = opaque;
> +    int i;
> +
> +    for (i = 0; i < 2; i++) {
> +        s->regs[i].confstat = 0x6515 << 16;
> +        ide_bus_reset(&s->i.bus[i]);
> +    }
> +}
> +
> +static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
> +{
> +    SiI3112PCIState *d = SII3112_PCI(dev);
> +    PCIIDEState *s = PCI_IDE(dev);
> +    MemoryRegion *mr;
> +    qemu_irq *irq;
> +    int i;
> +
> +    pci_config_set_interrupt_pin(dev->config, 1);
> +    pci_set_byte(dev->config + PCI_CACHE_LINE_SIZE, 8);
> +
> +    memory_region_init_io(&d->mmio, OBJECT(d), &sii3112_reg_ops, d,
> +                         "sii3112.bar5", 0x200);
> +    pci_register_bar(dev, 5, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
> +
> +    mr = g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar0", &d->mmio, 0x80, 8);
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, mr);
> +    mr = g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar1", &d->mmio, 0x88, 4);
> +    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, mr);
> +    mr = g_new(MemoryRegion, 1);

BARS 0 and 1 for IDE0 occupy 0x80 through 0x8C;

> +    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar2", &d->mmio, 0xc0, 8);
> +    pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_IO, mr);
> +    mr = g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar3", &d->mmio, 0xc8, 4);
> +    pci_register_bar(dev, 3, PCI_BASE_ADDRESS_SPACE_IO, mr);
> +    mr = g_new(MemoryRegion, 1);

BARS 1 and 2 for IDE1 occupy 0xC0 through 0xCC;

> +    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0, 16);
> +    pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);

BAR4 at 0x00 through 0x0F which houses the BMDMA registers.

What occupies 0x10 through 0x7F or 0x8D through 0x1FF?

> +
> +    irq = qemu_allocate_irqs(sii3112_set_irq, d, 2);
> +    for (i = 0; i < 2; i++) {
> +        ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1);
> +        ide_init2(&s->bus[i], irq[i]);
> +
> +        bmdma_init(&s->bus[i], &s->bmdma[i], s);
> +        s->bmdma[i].bus = &s->bus[i];
> +        ide_register_restart_cb(&s->bus[i]);
> +    }
> +    qemu_register_reset(sii3112_reset, s);
> +}
> +
> +static void sii3112_pci_exitfn(PCIDevice *dev)
> +{
> +    PCIIDEState *d = PCI_IDE(dev);
> +    int i;
> +
> +    for (i = 0; i < 2; ++i) {
> +        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].extra_io);
> +        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].addr_ioport);
> +    }
> +}
> +
> +static void sii3112_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pd = PCI_DEVICE_CLASS(klass);
> +
> +    pd->vendor_id = 0x1095;
> +    pd->device_id = 0x3112;
> +    pd->class_id = PCI_CLASS_STORAGE_RAID;
> +    pd->revision = 1;
> +    pd->realize = sii3112_pci_realize;
> +    pd->exit = sii3112_pci_exitfn;
> +    dc->desc = "SiI3112A SATA controller";
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +}
> +
> +static const TypeInfo sii3112_pci_info = {
> +    .name = TYPE_SII3112_PCI,
> +    .parent = TYPE_PCI_IDE,
> +    .instance_size = sizeof(SiI3112PCIState),
> +    .class_init = sii3112_pci_class_init,
> +};
> +
> +static void sii3112_register_types(void)
> +{
> +    type_register_static(&sii3112_pci_info);
> +}
> +
> +type_init(sii3112_register_types)
> 
