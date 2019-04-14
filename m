Received: from eggs.gnu.org ([209.51.188.92]:54212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hFk0B-0005ji-BF
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hFk0A-0000Bb-4v
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:37:15 -0400
MIME-Version: 1.0
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-2-git-send-email-atar4qemu@gmail.com>
	<e9e9724c-4a8f-e374-8ddf-4e9d4586fa40@reactos.org>
In-Reply-To: <e9e9724c-4a8f-e374-8ddf-4e9d4586fa40@reactos.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sun, 14 Apr 2019 20:36:59 +0200
Message-ID: <CACXAS8BFciYO3MsAgfX+OLy0wGf=hZYdbph4U_LQ6PiMOwtRAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] lsi53c895a: hide 53c895a registers in
 53c810
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, "open list:PReP" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

On Sun, Apr 14, 2019 at 5:43 PM Herv=C3=A9 Poussineau <hpoussin@reactos.org=
> wrote:
>
> Le 12/04/2019 =C3=A0 23:06, Artyom Tarasenko a =C3=A9crit :
> > AIX/PReP does access to the aliased IO registers of 53810.
> > Implement aliasing to make the AIX driver work.
> >
> > Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> > ---
> >   hw/scsi/lsi53c895a.c | 31 ++++++++++++++++++++++++++-----
> >   1 file changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> > index da7239d..08841e0 100644
> > --- a/hw/scsi/lsi53c895a.c
> > +++ b/hw/scsi/lsi53c895a.c
> > @@ -2266,11 +2266,13 @@ static const struct SCSIBusInfo lsi_scsi_info =
=3D {
> >       .cancel =3D lsi_request_cancelled
> >   };
> >
> > -static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
> > +static void lsi_scsi_realize_8xx(PCIDevice *dev, Error **errp, uint16_=
t type)
>
> You can probably remove this change, and replace it by
> uint16_t type =3D PCI_DEVICE_GET_CLASS(dev)->device_id;

Brilliant! Will do in V2, thainks.

Regards,
Artyom
> >   {
> >       LSIState *s =3D LSI53C895A(dev);
> >       DeviceState *d =3D DEVICE(dev);
> >       uint8_t *pci_conf;
> > +    uint64_t mmio_size;
> > +    MemoryRegion *mr;
> >
> >       pci_conf =3D dev->config;
> >
> > @@ -2279,13 +2281,21 @@ static void lsi_scsi_realize(PCIDevice *dev, Er=
ror **errp)
> >       /* Interrupt pin A */
> >       pci_conf[PCI_INTERRUPT_PIN] =3D 0x01;
> >
> > -    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
> > -                          "lsi-mmio", 0x400);
> >       memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
> >                             "lsi-ram", 0x2000);
> >       memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
> >                             "lsi-io", 256);
> > -
> > +    if (type =3D=3D PCI_DEVICE_ID_LSI_53C895A) {
> > +        mmio_size =3D 0x400;
> > +    } else {
> > +        mr =3D g_new(MemoryRegion, 1);
> > +        memory_region_init_alias(mr, OBJECT(d), "lsi-io-alias", &s->io=
_io,
> > +                                 0, 0x80);
> > +        memory_region_add_subregion_overlap(&s->io_io, 0x80, mr, -1);
> > +        mmio_size =3D 0x80;
> > +    }
> > +    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
> > +                          "lsi-mmio", mmio_size);
> >       address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi=
-pci-io");
> >       qdev_init_gpio_out(d, &s->ext_irq, 1);
> >
> > @@ -2297,6 +2307,16 @@ static void lsi_scsi_realize(PCIDevice *dev, Err=
or **errp)
> >       scsi_bus_new(&s->bus, sizeof(s->bus), d, &lsi_scsi_info, NULL);
> >   }
> >
> > +static void lsi_scsi_realize_895A(PCIDevice *dev, Error **errp)
> > +{
> > +    lsi_scsi_realize_8xx(dev, errp, PCI_DEVICE_ID_LSI_53C895A);
> > +}
> > +
> > +static void lsi_scsi_realize_810(PCIDevice *dev, Error **errp)
> > +{
> > +    lsi_scsi_realize_8xx(dev, errp, PCI_DEVICE_ID_LSI_53C810);
> > +}
>
> ... so you can also remove these functions
> > +
> >   static void lsi_scsi_unrealize(DeviceState *dev, Error **errp)
> >   {
> >       LSIState *s =3D LSI53C895A(dev);
> > @@ -2309,7 +2329,7 @@ static void lsi_class_init(ObjectClass *klass, vo=
id *data)
> >       DeviceClass *dc =3D DEVICE_CLASS(klass);
> >       PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> >
> > -    k->realize =3D lsi_scsi_realize;
> > +    k->realize =3D lsi_scsi_realize_895A;
>
> ... so you can also remove this change
> >       k->vendor_id =3D PCI_VENDOR_ID_LSI_LOGIC;
> >       k->device_id =3D PCI_DEVICE_ID_LSI_53C895A;
> >       k->class_id =3D PCI_CLASS_STORAGE_SCSI;
> > @@ -2335,6 +2355,7 @@ static void lsi53c810_class_init(ObjectClass *kla=
ss, void *data)
> >   {
> >       PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> >
> > +    k->realize =3D lsi_scsi_realize_810;
> ... and this one.
>
> >       k->device_id =3D PCI_DEVICE_ID_LSI_53C810;
> >   }
> >
> >
>
> Herv=C3=A9



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
