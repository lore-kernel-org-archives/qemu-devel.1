Received: from eggs.gnu.org ([2001:4830:134:3::10]:33212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enzox-0001fa-7z
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enzot-0000Vn-7Z
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:46:27 -0500
Date: Tue, 20 Feb 2018 15:42:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180220044208.GP1109@umbus.fritz.box>
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-8-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IihjUyvzd0n5Ehsu"
Content-Disposition: inline
In-Reply-To: <20180219181922.21586-8-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 07/11] mac_oldworld: use object link to
 pass heathrow PIC object to macio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--IihjUyvzd0n5Ehsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 06:19:18PM +0000, Mark Cave-Ayland wrote:
> Also switch macio_oldworld_realize() over to use it rather than using the=
 pic_mem
> memory region directly.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/misc/macio/macio.c         | 14 ++++++++++----
>  hw/ppc/mac_oldworld.c         |  8 +++++---
>  include/hw/misc/macio/macio.h |  2 ++
>  3 files changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 4e502ede2e..d4c1d190c4 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -31,6 +31,7 @@
>  #include "hw/ppc/mac_dbdma.h"
>  #include "hw/char/escc.h"
>  #include "hw/misc/macio/macio.h"
> +#include "hw/intc/heathrow_pic.h"
> =20
>  /*
>   * The mac-io has two interfaces to the ESCC. One is called "escc-legacy=
",
> @@ -167,10 +168,10 @@ static void macio_oldworld_realize(PCIDevice *d, Er=
ror **errp)
>                                  sysbus_mmio_get_region(sysbus_dev, 0));
>      pmac_format_nvram_partition(&os->nvram, os->nvram.size);
> =20
> -    if (s->pic_mem) {
> -        /* Heathrow PIC */
> -        memory_region_add_subregion(&s->bar, 0x00000, s->pic_mem);
> -    }
> +    /* Heathrow PIC */
> +    sysbus_dev =3D SYS_BUS_DEVICE(os->pic);
> +    memory_region_add_subregion(&s->bar, 0x0,
> +                                sysbus_mmio_get_region(sysbus_dev, 0));
> =20
>      /* IDE buses */
>      for (i =3D 0; i < ARRAY_SIZE(os->ide); i++) {
> @@ -208,6 +209,11 @@ static void macio_oldworld_init(Object *obj)
> =20
>      qdev_init_gpio_out(DEVICE(obj), os->irqs, ARRAY_SIZE(os->irqs));
> =20
> +    object_property_add_link(obj, "pic", TYPE_HEATHROW,
> +                             (Object **) &os->pic,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             0, NULL);
> +
>      object_initialize(&os->nvram, sizeof(os->nvram), TYPE_MACIO_NVRAM);
>      dev =3D DEVICE(&os->nvram);
>      qdev_prop_set_uint32(dev, "size", 0x2000);
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 5903ff47d3..3ac5b19073 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -93,7 +93,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      uint32_t kernel_base, initrd_base, cmdline_base =3D 0;
>      int32_t kernel_size, initrd_size;
>      PCIBus *pci_bus;
> -    PCIDevice *macio;
> +    OldWorldMacIOState *macio;
>      MACIOIDEState *macio_ide;
>      DeviceState *dev, *pic_dev;
>      SysBusDevice *sbd;
> @@ -271,7 +271,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      ide_drive_get(hd, ARRAY_SIZE(hd));
> =20
>      /* MacIO */
> -    macio =3D pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO);
> +    macio =3D OLDWORLD_MACIO(pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO=
));
>      dev =3D DEVICE(macio);
>      qdev_connect_gpio_out(dev, 0, pic[0x12]); /* CUDA */
>      qdev_connect_gpio_out(dev, 1, pic[0x10]); /* ESCC-B */
> @@ -281,8 +281,10 @@ static void ppc_heathrow_init(MachineState *machine)
>      qdev_connect_gpio_out(dev, 5, pic[0x0E]); /* IDE-1 */
>      qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE-1 DMA */
>      qdev_prop_set_uint64(dev, "frequency", tbfreq);
> +    object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
> +                             &error_abort);
>      sbd =3D SYS_BUS_DEVICE(pic_dev);
> -    macio_init(macio, sysbus_mmio_get_region(sbd, 0));
> +    macio_init(PCI_DEVICE(macio), sysbus_mmio_get_region(sbd, 0));
> =20
>      macio_ide =3D MACIO_IDE(object_resolve_path_component(OBJECT(macio),
>                                                          "ide[0]"));
> diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
> index e1e249f898..843c114c07 100644
> --- a/include/hw/misc/macio/macio.h
> +++ b/include/hw/misc/macio/macio.h
> @@ -26,6 +26,7 @@
>  #ifndef MACIO_H
>  #define MACIO_H
> =20
> +#include "hw/intc/heathrow_pic.h"
>  #include "hw/misc/macio/cuda.h"
>  #include "hw/ppc/mac_dbdma.h"
> =20
> @@ -54,6 +55,7 @@ typedef struct OldWorldMacIOState {
>      MacIOState parent_obj;
>      /*< public >*/
> =20
> +    HeathrowState *pic;
>      qemu_irq irqs[7];
> =20
>      MacIONVRAMState nvram;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IihjUyvzd0n5Ehsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqLpx8ACgkQbDjKyiDZ
s5LDdRAAyos1Yi4Q/j0+Z3DyB6Jm68cYZrpkjxeuQKpsfRowphf0cbDqwDwUMnVZ
eovqGPbcwl0KllKKzeLea78yLeW1niu64qTZS+6FgsdiJxGAkZ8A3wJxx3a25GZ0
XSWJQZAA9XrmQAfHuOmwnupv17QOPe3hxwSzy+jw9EwpdwHSdq39kQdmy/2i1Evi
bHEbOThA+geE+RipNj/exFYQUbOFUgblM5fjTK6u5D7dDQCfA+cMdIsYz9FnFIBK
S0LTaVMnxyBJ4chvShfF70WWjW1ZU7KL6xFO7Vckt2jOvoXXN/hMOrod58qDCzhK
1CdIMKfZ1r1Gp27FxGhWZ5GopZLNWCzSjlnWcvqiXLpQvEV8bWXuze4USC7FOwzz
Cr5zQYj313PNJZNOwYYwMRC5Y/qxGtQuoaSv5cszB3uGnjAz+6LvKKoCmZdg9bSN
XAzLCZ2IPYL3WKyC3NjFmVQqC19EySsCge2wsw+/r6wH9lqCxgYx9IPlsrV/qtcK
JCFs92SuRxl/scgiCZ+pGLM5wheC6gnTcLnUhdpp9dJxF6I4VYMiTA8hq3ls2pyI
n0cqorKxGkxiE15XvgnGcxNidpJf7GUSZecDFl8J3WYZ6Qt6eiNvtwmgXDCIyv/S
yy0siPrWKbUV1pAkA00SzmCB6/8SySDfPFN2EM1txB/XeWw1Hkk=
=j1GL
-----END PGP SIGNATURE-----

--IihjUyvzd0n5Ehsu--
