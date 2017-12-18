Received: from eggs.gnu.org ([2001:4830:134:3::10]:52123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQmkm-0001Mw-Ly
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQmkk-0007O3-AP
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:10:12 -0500
Date: Mon, 18 Dec 2017 15:09:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218040946.GS7753@umbus.fritz.box>
References: <20171216224842.EE8C17456B3@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8DtChEGCcMdSgkU2"
Content-Disposition: inline
In-Reply-To: <20171216224842.EE8C17456B3@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2] hw/ide: Emulate SiI3112 SATA controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, John Snow <jsnow@redhat.com>


--8DtChEGCcMdSgkU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2017 at 11:42:39PM +0100, BALATON Zoltan wrote:
> This is a common generic PCI SATA controller that is also used in PCs
> but more importantly guests running on the Sam460ex board prefer this
> card and have a driver for it (unlike for other SATA controllers
> already emulated).
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

I don't know enough about IDE to give this any more than a quick check
for anything obviously bogus looking.  So,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

John, can you take this through your tree, or should I take it through
the ppc tree?

> ---
> v2: Addressed review comments:
> - Replaced debug printf with trace
> - Added comments about BAR mappings and reference to data sheet
> - Maintained with the sam460ex PPC machine and not with rest of hw/ide
>=20
>  MAINTAINERS                        |   6 +
>  default-configs/ppcemb-softmmu.mak |   1 +
>  hw/ide/Makefile.objs               |   1 +
>  hw/ide/sii3112.c                   | 368 +++++++++++++++++++++++++++++++=
++++++
>  hw/ide/trace-events                |   5 +
>  5 files changed, 381 insertions(+)
>  create mode 100644 hw/ide/sii3112.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 45e2e20..2ec47db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -761,6 +761,12 @@ L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/virtex_ml507.c
> =20
> +sam460ex
> +M: BALATON Zoltan <balaton@eik.bme.hu>
> +L: qemu-ppc@nongnu.org
> +S: Maintained
> +F: hw/ide/sii3112.c
> +
>  SH4 Machines
>  ------------
>  R2D
> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-=
softmmu.mak
> index 13917fb..5db4618 100644
> --- a/default-configs/ppcemb-softmmu.mak
> +++ b/default-configs/ppcemb-softmmu.mak
> @@ -16,3 +16,4 @@ CONFIG_I8259=3Dy
>  CONFIG_XILINX=3Dy
>  CONFIG_XILINX_ETHLITE=3Dy
>  CONFIG_SM501=3Dy
> +CONFIG_IDE_SII3112=3Dy
> diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
> index f0edca3..fc328ff 100644
> --- a/hw/ide/Makefile.objs
> +++ b/hw/ide/Makefile.objs
> @@ -11,3 +11,4 @@ common-obj-$(CONFIG_MICRODRIVE) +=3D microdrive.o
>  common-obj-$(CONFIG_AHCI) +=3D ahci.o
>  common-obj-$(CONFIG_AHCI) +=3D ich.o
>  common-obj-$(CONFIG_ALLWINNER_A10) +=3D ahci-allwinner.o
> +common-obj-$(CONFIG_IDE_SII3112) +=3D sii3112.o
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> new file mode 100644
> index 0000000..e2f5562
> --- /dev/null
> +++ b/hw/ide/sii3112.c
> @@ -0,0 +1,368 @@
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
> +/* For documentation on this and similar cards see:
> + * http://wiki.osdev.org/User:Quok/Silicon_Image_Datasheets
> + */
> +
> +#include <qemu/osdep.h>
> +#include <hw/ide/pci.h>
> +#include "trace.h"
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
> +/* The sii3112_reg_read and sii3112_reg_write functions implement the
> + * Internal Register Space - BAR5 (section 6.7 of the data sheet).
> + */
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
> +    trace_sii3112_read(size, addr, val);
> +    return val;
> +}
> +
> +static void sii3112_reg_write(void *opaque, hwaddr addr,
> +                              uint64_t val, unsigned int size)
> +{
> +    SiI3112PCIState *d =3D opaque;
> +
> +    trace_sii3112_write(size, addr, val);
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
> +    trace_sii3112_set_irq(channel, level);
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
> +    /* BAR5 is in PCI memory space */
> +    memory_region_init_io(&d->mmio, OBJECT(d), &sii3112_reg_ops, d,
> +                         "sii3112.bar5", 0x200);
> +    pci_register_bar(dev, 5, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
> +
> +    /* BAR0-BAR4 are PCI I/O space aliases into BAR5 */
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
> diff --git a/hw/ide/trace-events b/hw/ide/trace-events
> index 601bd97..0c39cab 100644
> --- a/hw/ide/trace-events
> +++ b/hw/ide/trace-events
> @@ -37,6 +37,11 @@ bmdma_addr_write(uint64_t data) "data: 0x%016"PRIx64
>  bmdma_read(uint64_t addr, uint8_t val) "bmdma: readb 0x%"PRIx64" : 0x%02=
x"
>  bmdma_write(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x=
%02"PRIx64
> =20
> +# hw/ide/sii3112.c
> +sii3112_read(int size, uint64_t addr, uint64_t val) "bmdma: read (size %=
d) 0x%"PRIx64" : 0x%02"PRIx64
> +sii3112_write(int size, uint64_t addr, uint64_t val) "bmdma: write (size=
 %d) 0x%"PRIx64" : 0x%02"PRIx64
> +sii3112_set_irq(int channel, int level) "channel %d level %d"
> +
>  # hw/ide/via.c
>  bmdma_read_via(uint64_t addr, uint32_t val) "bmdma: readb 0x%"PRIx64" : =
0x%02x"
>  bmdma_write_via(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" =
: 0x%02"PRIx64
> --=20
> 2.7.6
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8DtChEGCcMdSgkU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3P4oACgkQbDjKyiDZ
s5Je2hAA02fzGKTI9mPs872fEZvNf4P9fWDehf4Ia9agqwDFep/5HAvVv6BQNyDb
OdySHNWWTkuJPKWyeiRVaG3rrUMNFITcPZ8xRMaW3c4SbLw1PNWa+ypGeiJNgh4c
wELi/IWzSIydCwmY8OQdpYubVNHMNQx9U2/KHVx3wGqgnonzclJp4agmmjKIV55E
zT+2WoLB4313xHF88TXCGYMiC2poEqYdoKaxEPRBP40+dd+prp+37yMtP8i+jrcB
cxp2pRy0e2smmdkw99BxhcPUnEwx1hoOnBxy2QcYB4SDA385ZoUSrPyGWXRLJ+if
epiz9laUDLayqTnsiuvPCsc/PQRlqWbJ2dyPZX/bt11ViKoMIEm+pthCDhx98Yoc
Y5e2FtSXXm0vLiigyFNEi2PUp4jDHshzEt33uLRauXkfxfLZ8FTlwj40+JzageL7
0bFSJRPvRNcFu1yhUKIzECJpmZcNoyorBJoCcuAtQMeht9I6dueyBI2DuhSS1f6T
77/zwSe0BeElU8vdeHNDfE6HIgkP/HyXc2mOvZ/pu61bv3GB7ZwPvH2nbSVIw2bM
vt3gw9tsqLmVsNbu/eXIDNaQ1DwUXPuRVfORCu9l8WEaQa3i43lojlaxU/8fLXX0
cWN335c4BXfgwObXcbh53QJV9ixmrnSWmy8m6QB7YyCnKJZR+vg=
=Y5Y7
-----END PGP SIGNATURE-----

--8DtChEGCcMdSgkU2--
