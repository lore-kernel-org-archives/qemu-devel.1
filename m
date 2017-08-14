Received: from eggs.gnu.org ([2001:4830:134:3::10]:56215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh8ff-0000dM-Tb
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh8fd-0005cG-Nw
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:16:15 -0400
Date: Mon, 14 Aug 2017 14:42:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170814044233.GF3452@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<9a1b25fc97fa35cd8c6294b1014931d832ef8240.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <9a1b25fc97fa35cd8c6294b1014931d832ef8240.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 08/12] hw/ide: Emulate SiI3112 SATA
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Needs a commit message: where does this controller appear? what's
distinctive about it? is there a link to a datasheet or programming manual?

> ---
>  hw/ide/Makefile.objs |   1 +
>  hw/ide/sii3112.c     | 365 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 366 insertions(+)
>  create mode 100644 hw/ide/sii3112.c
>=20
> diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
> index 729e9bd..76f3d6d 100644
> --- a/hw/ide/Makefile.objs
> +++ b/hw/ide/Makefile.objs
> @@ -10,3 +10,4 @@ common-obj-$(CONFIG_IDE_VIA) +=3D via.o
>  common-obj-$(CONFIG_MICRODRIVE) +=3D microdrive.o
>  common-obj-$(CONFIG_AHCI) +=3D ahci.o
>  common-obj-$(CONFIG_AHCI) +=3D ich.o
> +common-obj-$(CONFIG_IDE_SII3112) +=3D sii3112.o
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> new file mode 100644
> index 0000000..d3f34b5
> --- /dev/null
> +++ b/hw/ide/sii3112.c
> @@ -0,0 +1,365 @@
> +/*
> + * QEMU SiI3112A PCI to Serial ATA Controller Emulation
> + *
> + * Copyright (C) 2017 BALATON Zoltan <balaton@eik.bme.hu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
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
> +    SiI3112PCIState *d =3D opaque;
> +    uint64_t val =3D 0;
> +
> +    switch (addr) {
> +    case 0x00:
> +        val =3D d->i.bmdma[0].cmd;
> +        break;
> +    case 0x01:
> +        val =3D d->regs[0].swdata;
> +        break;
> +    case 0x02:
> +        val =3D d->i.bmdma[0].status;
> +        break;
> +    case 0x03:
> +        val =3D 0;
> +        break;
> +    case 0x04 ... 0x07:
> +        val =3D bmdma_addr_ioport_ops.read(&d->i.bmdma[0], addr - 4, siz=
e);
> +        break;
> +    case 0x08:
> +        val =3D d->i.bmdma[1].cmd;
> +        break;
> +    case 0x09:
> +        val =3D d->regs[1].swdata;
> +        break;
> +    case 0x0a:
> +        val =3D d->i.bmdma[1].status;
> +        break;
> +    case 0x0b:
> +        val =3D 0;
> +        break;
> +    case 0x0c ... 0x0f:
> +        val =3D bmdma_addr_ioport_ops.read(&d->i.bmdma[1], addr - 12, si=
ze);
> +        break;
> +    case 0x10:
> +        val =3D d->i.bmdma[0].cmd;
> +        val |=3D (d->regs[0].confstat & (1UL << 11) ? (1 << 4) : 0); /*S=
ATAINT0*/
> +        val |=3D (d->regs[1].confstat & (1UL << 11) ? (1 << 6) : 0); /*S=
ATAINT1*/
> +        val |=3D (d->i.bmdma[1].status & BM_STATUS_INT ? (1 << 14) : 0);
> +        val |=3D d->i.bmdma[0].status << 16;
> +        val |=3D d->i.bmdma[1].status << 24;
> +        break;
> +    case 0x18:
> +        val =3D d->i.bmdma[1].cmd;
> +        val |=3D (d->regs[1].confstat & (1UL << 11) ? (1 << 4) : 0);
> +        val |=3D d->i.bmdma[1].status << 16;
> +        break;
> +    case 0x80 ... 0x87:
> +        if (size =3D=3D 1) {
> +            val =3D ide_ioport_read(&d->i.bus[0], addr - 0x80);
> +        } else if (addr =3D=3D 0x80) {
> +            val =3D (size =3D=3D 2) ? ide_data_readw(&d->i.bus[0], 0) :
> +                                ide_data_readl(&d->i.bus[0], 0);
> +        } else {
> +            val =3D (1ULL << (size * 8)) - 1;
> +        }
> +        break;
> +    case 0x8a:
> +        val =3D (size =3D=3D 1) ? ide_status_read(&d->i.bus[0], 4) :
> +                            (1ULL << (size * 8)) - 1;
> +        break;
> +    case 0xa0:
> +        val =3D d->regs[0].confstat;
> +        break;
> +    case 0xc0 ... 0xc7:
> +        if (size =3D=3D 1) {
> +            val =3D ide_ioport_read(&d->i.bus[1], addr - 0xc0);
> +        } else if (addr =3D=3D 0xc0) {
> +            val =3D (size =3D=3D 2) ? ide_data_readw(&d->i.bus[1], 0) :
> +                                ide_data_readl(&d->i.bus[1], 0);
> +        } else {
> +            val =3D (1ULL << (size * 8)) - 1;
> +        }
> +        break;
> +    case 0xca:
> +        val =3D (size =3D=3D 1) ? ide_status_read(&d->i.bus[0], 4) :
> +                            (1ULL << (size * 8)) - 1;
> +        break;
> +    case 0xe0:
> +        val =3D d->regs[1].confstat;
> +        break;
> +    case 0x100:
> +        val =3D d->regs[0].scontrol;
> +        break;
> +    case 0x104:
> +        val =3D (d->i.bus[0].ifs[0].blk) ? 0x113 : 0;
> +        break;
> +    case 0x148:
> +        val =3D d->regs[0].sien << 16;
> +        break;
> +    case 0x180:
> +        val =3D d->regs[1].scontrol;
> +        break;
> +    case 0x184:
> +        val =3D (d->i.bus[1].ifs[0].blk) ? 0x113 : 0;
> +        break;
> +    case 0x1c8:
> +        val =3D d->regs[1].sien << 16;
> +        break;
> +    default:
> +        val =3D 0;
> +    }
> +    DPRINTF("%s: addr 0x%"PRIx64 " size %d =3D %"PRIx64 "\n",
> +            __func__, addr, size, val);
> +    return val;
> +}
> +
> +static void sii3112_reg_write(void *opaque, hwaddr addr,
> +                              uint64_t val, unsigned int size)
> +{
> +    SiI3112PCIState *d =3D opaque;
> +
> +    DPRINTF("%s: addr 0x%"PRIx64 " size %d =3D %"PRIx64 "\n",
> +            __func__, addr, size, val);
> +    switch (addr) {
> +    case 0x00:
> +    case 0x10:
> +        bmdma_cmd_writeb(&d->i.bmdma[0], val);
> +        break;
> +    case 0x01:
> +    case 0x11:
> +        d->regs[0].swdata =3D val & 0x3f;
> +        break;
> +    case 0x02:
> +    case 0x12:
> +        d->i.bmdma[0].status =3D (val & 0x60) | (d->i.bmdma[0].status & =
1) |
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
> +        d->regs[1].swdata =3D val & 0x3f;
> +        break;
> +    case 0x0a:
> +    case 0x1a:
> +        d->i.bmdma[1].status =3D (val & 0x60) | (d->i.bmdma[1].status & =
1) |
> +                               (d->i.bmdma[1].status & ~val & 6);
> +        break;
> +    case 0x0c ... 0x0f:
> +        bmdma_addr_ioport_ops.write(&d->i.bmdma[1], addr - 12, val, size=
);
> +        break;
> +    case 0x80 ... 0x87:
> +        if (size =3D=3D 1) {
> +            ide_ioport_write(&d->i.bus[0], addr - 0x80, val);
> +        } else if (addr =3D=3D 0x80) {
> +            if (size =3D=3D 2) {
> +                ide_data_writew(&d->i.bus[0], 0, val);
> +            } else {
> +                ide_data_writel(&d->i.bus[0], 0, val);
> +            }
> +        }
> +        break;
> +    case 0x8a:
> +        if (size =3D=3D 1) {
> +            ide_cmd_write(&d->i.bus[0], 4, val);
> +        }
> +        break;
> +    case 0xc0 ... 0xc7:
> +        if (size =3D=3D 1) {
> +            ide_ioport_write(&d->i.bus[1], addr - 0xc0, val);
> +        } else if (addr =3D=3D 0xc0) {
> +            if (size =3D=3D 2) {
> +                ide_data_writew(&d->i.bus[1], 0, val);
> +            } else {
> +                ide_data_writel(&d->i.bus[1], 0, val);
> +            }
> +        }
> +        break;
> +    case 0xca:
> +        if (size =3D=3D 1) {
> +            ide_cmd_write(&d->i.bus[1], 4, val);
> +        }
> +        break;
> +    case 0x100:
> +        d->regs[0].scontrol =3D val & 0xfff;
> +        if (val & 1) {
> +            ide_bus_reset(&d->i.bus[0]);
> +        }
> +        break;
> +    case 0x148:
> +        d->regs[0].sien =3D (val >> 16) & 0x3eed;
> +        break;
> +    case 0x180:
> +        d->regs[1].scontrol =3D val & 0xfff;
> +        if (val & 1) {
> +            ide_bus_reset(&d->i.bus[1]);
> +        }
> +        break;
> +    case 0x1c8:
> +        d->regs[1].sien =3D (val >> 16) & 0x3eed;
> +        break;
> +    default:
> +        val =3D 0;
> +    }
> +}
> +
> +static const MemoryRegionOps sii3112_reg_ops =3D {
> +    .read =3D sii3112_reg_read,
> +    .write =3D sii3112_reg_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +};
> +
> +/* the PCI irq level is the logical OR of the two channels */
> +static void sii3112_update_irq(SiI3112PCIState *s)
> +{
> +    int i, set =3D 0;
> +
> +    for (i =3D 0; i < 2; i++) {
> +        set |=3D s->regs[i].confstat & (1UL << 11);
> +    }
> +    pci_set_irq(PCI_DEVICE(s), (set ? 1 : 0));
> +}
> +
> +static void sii3112_set_irq(void *opaque, int channel, int level)
> +{
> +    SiI3112PCIState *s =3D opaque;
> +
> +    DPRINTF("%s: channel %d level %d\n", __func__, channel, level);
> +    if (level) {
> +        s->regs[channel].confstat |=3D (1UL << 11);
> +    } else {
> +        s->regs[channel].confstat &=3D ~(1UL << 11);
> +    }
> +
> +    sii3112_update_irq(s);
> +}
> +
> +static void sii3112_reset(void *opaque)
> +{
> +    SiI3112PCIState *s =3D opaque;
> +    int i;
> +
> +    for (i =3D 0; i < 2; i++) {
> +        s->regs[i].confstat =3D 0x6515 << 16;
> +        ide_bus_reset(&s->i.bus[i]);
> +    }
> +}
> +
> +static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
> +{
> +    SiI3112PCIState *d =3D SII3112_PCI(dev);
> +    PCIIDEState *s =3D PCI_IDE(dev);
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
> +    mr =3D g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar0", &d->mmio, 0x=
80, 8);
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, mr);
> +    mr =3D g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar1", &d->mmio, 0x=
88, 4);
> +    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, mr);
> +    mr =3D g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar2", &d->mmio, 0x=
c0, 8);
> +    pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_IO, mr);
> +    mr =3D g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar3", &d->mmio, 0x=
c8, 4);
> +    pci_register_bar(dev, 3, PCI_BASE_ADDRESS_SPACE_IO, mr);
> +    mr =3D g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0,=
 16);
> +    pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
> +
> +    irq =3D qemu_allocate_irqs(sii3112_set_irq, d, 2);
> +    for (i =3D 0; i < 2; i++) {
> +        ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1);
> +        ide_init2(&s->bus[i], irq[i]);
> +
> +        bmdma_init(&s->bus[i], &s->bmdma[i], s);
> +        s->bmdma[i].bus =3D &s->bus[i];
> +        ide_register_restart_cb(&s->bus[i]);
> +    }
> +    qemu_register_reset(sii3112_reset, s);
> +}
> +
> +static void sii3112_pci_exitfn(PCIDevice *dev)
> +{
> +    PCIIDEState *d =3D PCI_IDE(dev);
> +    int i;
> +
> +    for (i =3D 0; i < 2; ++i) {
> +        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].extra_io=
);
> +        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].addr_iop=
ort);
> +    }
> +}
> +
> +static void sii3112_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PCIDeviceClass *pd =3D PCI_DEVICE_CLASS(klass);
> +
> +    pd->vendor_id =3D 0x1095;
> +    pd->device_id =3D 0x3112;
> +    pd->class_id =3D PCI_CLASS_STORAGE_RAID;
> +    pd->revision =3D 1;
> +    pd->realize =3D sii3112_pci_realize;
> +    pd->exit =3D sii3112_pci_exitfn;
> +    dc->desc =3D "SiI3112A SATA controller";
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +}
> +
> +static const TypeInfo sii3112_pci_info =3D {
> +    .name =3D TYPE_SII3112_PCI,
> +    .parent =3D TYPE_PCI_IDE,
> +    .instance_size =3D sizeof(SiI3112PCIState),
> +    .class_init =3D sii3112_pci_class_init,
> +};
> +
> +static void sii3112_register_types(void)
> +{
> +    type_register_static(&sii3112_pci_info);
> +}
> +
> +type_init(sii3112_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmRKjgACgkQbDjKyiDZ
s5JudQ/+MkZg+cgsvSupND1ry+bj7gtzUakjRiemqC0FtU/W4aixagm0JPpbXgKY
1vYLY1RpZERUBDezFWTcvEKcIc2M4NcUUtjaNSbo2hyNNEhOtivNQ8lWMZvZEnA0
LqLYmAKjzSWkxprs/2alQKVEKkYbccqQQN0gauuZCt6BDCTwfOgiYCxwaPdS4IYw
zik9ZgM8duLiqCyYxVvztnUe0lg5xdCkKvJt5oPkRIBVy7OjzmYKKMlnvsa+0146
uV5zCWBG2+0HA/ayovGejzXkpcVU7O7FUjwD/2RhEN6pJZmbL8ase9LUMQxSrKrm
XRbMXDGKAwQ9cL25uI56GY0wgK55yNAyGoTlfv7L0L+3QAABY3DHfXfv/y7t3d7O
Tuy8i55Q1vmFi7DCM37SDplLdZBoxO/s+v/cAH65QwiyGGs8zqZep7aZGmGCc3WK
0h2S2roQxkOlWXAwkU86lzxQwcDFZ8QMPStLgVhFmYviGBrNGJrDGeZbGIMMQJW4
dInar3kJ7R5Q5sTPjnIvakX9sCs0X9mgbTwXPgJYnPDfpiY+R0C9L+nnv8QIMRSY
rGHXraznh+n+3o//JPx6vuQgpevBU+GH1bXQ3vv0hQfNpf1A0RbSkqot4bp7txpf
K+LQ9D8CNNOSw8A4hkcFhAfy5rKft1OFnOUNUXEvcqi5ZuF627Y=
=otrx
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
