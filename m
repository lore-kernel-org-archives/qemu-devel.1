Received: from eggs.gnu.org ([2001:4830:134:3::10]:33591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDpr-00027K-Oq
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDm5-0005yx-73
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:26:10 -0400
Date: Mon, 10 Sep 2018 13:48:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180910034837.GD2890@umbus.fritz.box>
References: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
	<20180908090820.15591-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20180908090820.15591-4-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] 40p: add fixed IRQ routing for LSI
 SCSI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: hpoussin@reactos.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 08, 2018 at 10:08:20AM +0100, Mark Cave-Ayland wrote:
> Whilst the PReP specification describes how all PCI IRQs are routed via I=
RQ
> 15 on the interrupt controller, the real 40p machine has routing quirk in
> that the LSI SCSI device is routed to IRQ 13.
>=20
> This is implemented using a little hack: the existing IRQ routing code us=
es
> (irq_num + (pci_dev->devfn >> 3)) & 1 to give the PCI interrupt pin, where
> the "& 1" ensures that the only pins A and B (0 and 1) will ever be used.
>=20
> Rather than fix the mask to "& 3" we leave the existing routing above as-=
is
> and then force the LSI SCSI device to use pin C (2). This enables us to
> route pin 2 permanantly to IRQ 13 since the LSI SCSI device will be its
> only user.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

I don't think this is really the right approach.

As noted in an earlier mail, it's really common for on-board devices
on pre-express PCI boards to have their LSIs wired specially, rather
than via the PCI irq pins which are used for "slotted" devices.

I think we should explicitly model it like that: wiring the SCSI
device's irq directly to system IRQ 13, rather than wiring it via a
PCI LSI pin.

Wiring the SCSI to an otherwise unused pin, then routing that
specially to the system irq is confusing.  It also might be incorrect
if we tried to add a "slotted" device that actually used PINC (rare,
I'll grant you).

> ---
>  hw/pci-host/prep.c | 35 +++++++++++++++++++++++++++++++++--
>  hw/ppc/prep.c      | 10 +++++++---
>  2 files changed, 40 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index b1b6b16bad..87270605b5 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -58,6 +58,7 @@ typedef struct PRePPCIState {
> =20
>      qemu_or_irq *or_irq;
>      qemu_irq pci_irqs[PCI_NUM_PINS];
> +    qemu_irq scsi_irq;
>      PCIBus pci_bus;
>      AddressSpace pci_io_as;
>      MemoryRegion pci_io;
> @@ -192,14 +193,41 @@ static const MemoryRegionOps raven_io_ops =3D {
> =20
>  static int raven_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
> -    return (irq_num + (pci_dev->devfn >> 3)) & 1;
> +    switch (pci_dev->devfn) {
> +    case PCI_DEVFN(1, 0):
> +        /* Whilst legacy PReP machine exists we need to make
> +         * sure that this fixed interrupt routing is 40p only */
> +        if (strcmp(object_get_typename(OBJECT(pci_dev)),
> +                                       "lsi53c810") =3D=3D 0) {
> +            /* LSI SCSI */
> +            return 2;
> +        } else {
> +            /* Normal PCI IRQ mapping */
> +            return (irq_num + (pci_dev->devfn >> 3)) & 1;
> +        }
> +    default:
> +        /* Normal PCI IRQ mapping */
> +        return (irq_num + (pci_dev->devfn >> 3)) & 1;
> +    }
>  }
> =20
>  static void raven_set_irq(void *opaque, int irq_num, int level)
>  {
>      PREPPCIState *s =3D opaque;
> =20
> -    qemu_set_irq(s->pci_irqs[irq_num], level);
> +    if (s->is_legacy_prep) {
> +        qemu_set_irq(s->pci_irqs[irq_num], level);
> +    } else {
> +        switch (irq_num) {
> +        case 2:
> +            /* LSI SCSI */
> +            qemu_set_irq(s->scsi_irq, level);
> +            break;
> +        default:
> +            /* Normal PCI IRQ mapping */
> +            qemu_set_irq(s->pci_irqs[irq_num], level);
> +        }
> +    }
>  }
> =20
>  static AddressSpace *raven_pcihost_set_iommu(PCIBus *bus, void *opaque,
> @@ -242,6 +270,9 @@ static void raven_pcihost_realizefn(DeviceState *d, E=
rror **errp)
>          for (i =3D 0; i < PCI_NUM_PINS; i++) {
>              s->pci_irqs[i] =3D qdev_get_gpio_in(DEVICE(s->or_irq), i);
>          }
> +
> +        /* 40p LSI SCSI has fixed routing via IRQ 13 */
> +        sysbus_init_irq(dev, &s->scsi_irq);
>      }
> =20
>      qdev_init_gpio_in(d, raven_change_gpio, 1);
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 615865e46c..0412a56d98 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -626,6 +626,7 @@ static void ibm_40p_init(MachineState *machine)
>      Nvram *m48t59 =3D NULL;
>      PCIBus *pci_bus;
>      ISABus *isa_bus;
> +    PCIDevice *pci;
>      void *fw_cfg;
>      int i;
>      uint32_t kernel_base =3D 0, initrd_base =3D 0;
> @@ -670,6 +671,7 @@ static void ibm_40p_init(MachineState *machine)
>      qdev_connect_gpio_out(dev, 0,
>                            cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
>      sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
> +    sysbus_connect_irq(pcihost, 1, qdev_get_gpio_in(dev, 13));
>      isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
> =20
>      /* Memory controller */
> @@ -700,9 +702,11 @@ static void ibm_40p_init(MachineState *machine)
>          qdev_prop_set_uint32(dev, "equipment", 0xc0);
>          qdev_init_nofail(dev);
> =20
> -        dev =3D DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
> -                                       "lsi53c810"));
> -        lsi53c8xx_handle_legacy_cmdline(dev);
> +        pci =3D PCI_DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
> +                                           "lsi53c810"));
> +        /* Interrupt pin C for fixed LSI SCSI IRQ routing */
> +        pci->config[PCI_INTERRUPT_PIN] =3D 0x3;
> +        lsi53c8xx_handle_legacy_cmdline(DEVICE(pci));
> =20
>          /* XXX: s3-trio at PCI_DEVFN(2, 0) */
>          pci_vga_init(pci_bus);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluV6ZIACgkQbDjKyiDZ
s5JU/BAAhSV8fXAYbT7aljvxICwnv11zo2rL/nvSwuhbFcWK7qrAYTOPfGloW6Y3
2YwgI1UyXq2/xXDaTJ1mn2o1Fi6+BKai+r8Wh9TmKBbS60DaFap4GMTuKV3Ddu5H
VZY2JlKnU5wZhRC7EJJlZHEKdACEygF1sYNvaNNk92SzWIJAVLnYv9eNFkDoDZZk
7jZM4Wjw1Eccf7fOoW8sIkbvKXyz/l1xxQVmxCBmCBKG1Qowaipp9VqCihNBd/fS
5EdD9/WHQ0r0uHijEd0gc52SyX08dopWRq4b1OwLRsG3oGiVU3lL6SG+iEMEAvTq
kSPSFJ0ajy2Ye1kdT7qQltvVZgv8iG4kn1zUqx7pgt7DO7LtEPmhrptcLxDaMMw7
yLtmsV2idKsmXRfqR4YVklfdxDf8vxHlu8rpM4zvtzhcvRItOVUQoiaZtQ6TGSwM
G8YvIeOuJGBj2Au/W4N8nsCo+6ryRKH91fnGF9lNylwCPO3iTY0Aj/PoDlBXv4bH
i+gH4o+Z9ba/5tZTf8iiQvn9IsZXKdP3+I0PA6j++IVRb4O5epVP5sNJSF9LAt5V
WP8yDekxYl8tfzY/RupgqgYky4JHdKklALnuqj4BlR0zQ+uDZhAA/6ErbhIJ+qF/
366dEG/rqJ6l94DUb4SuXYnffnUGORtj9M9KwxJxXew4Xt91J2E=
=R27y
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
