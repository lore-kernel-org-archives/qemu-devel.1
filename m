Received: from eggs.gnu.org ([2001:4830:134:3::10]:45499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eyUdm-0004ZB-PD
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eyUdl-0000nz-PK
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:42:18 -0400
Date: Wed, 21 Mar 2018 14:40:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180321034040.GQ3905@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-19-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vIXBmblrD40XNCy4"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-19-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 18/19] mac_newworld: remove pics IRQ array
 and wire up macio to OpenPIC directly
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


--vIXBmblrD40XNCy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:31:02PM +0000, Mark Cave-Ayland wrote:
> Introduce constants for the pre-defined New World IRQs to help keep things
> readable.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/mac.h          |  8 ++++++++
>  hw/ppc/mac_newworld.c | 29 +++++++++++++++--------------
>  2 files changed, 23 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index 5f5916252a..3819058310 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -47,6 +47,14 @@
> =20
>  #define ESCC_CLOCK 3686400
> =20
> +/* New World IRQs */
> +#define NEWWORLD_CUDA_IRQ      0x19
> +#define NEWWORLD_ESCCB_IRQ     0x24
> +#define NEWWORLD_ESCCA_IRQ     0x25
> +#define NEWWORLD_IDE0_IRQ      0xd
> +#define NEWWORLD_IDE0_DMA_IRQ  0x2
> +#define NEWWORLD_IDE1_IRQ      0xe
> +#define NEWWORLD_IDE1_DMA_IRQ  0x3
> =20
>  /* MacIO */
>  #define TYPE_MACIO_IDE "macio-ide"
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 2fcb101982..3cde507065 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -115,7 +115,7 @@ static void ppc_core99_init(MachineState *machine)
>      PowerPCCPU *cpu =3D NULL;
>      CPUPPCState *env =3D NULL;
>      char *filename;
> -    qemu_irq *pic, **openpic_irqs;
> +    qemu_irq **openpic_irqs;
>      int linux_boot, i, j, k;
>      MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(Memory=
Region, 1);
>      hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
> @@ -292,8 +292,6 @@ static void ppc_core99_init(MachineState *machine)
>          }
>      }
> =20
> -    pic =3D g_new0(qemu_irq, 64);
> -
>      pic_dev =3D qdev_create(NULL, TYPE_OPENPIC);
>      qdev_prop_set_uint32(pic_dev, "model", OPENPIC_MODEL_KEYLARGO);
>      qdev_init_nofail(pic_dev);
> @@ -305,10 +303,6 @@ static void ppc_core99_init(MachineState *machine)
>          }
>      }
> =20
> -    for (i =3D 0; i < 64; i++) {
> -        pic[i] =3D qdev_get_gpio_in(pic_dev, i);
> -    }
> -
>      if (PPC_INPUT(env) =3D=3D PPC_FLAGS_INPUT_970) {
>          /* 970 gets a U3 bus */
>          /* Uninorth AGP bus */
> @@ -382,13 +376,20 @@ static void ppc_core99_init(MachineState *machine)
>      /* MacIO */
>      macio =3D NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO=
));
>      dev =3D DEVICE(macio);
> -    qdev_connect_gpio_out(dev, 0, pic[0x19]); /* CUDA */
> -    qdev_connect_gpio_out(dev, 1, pic[0x24]); /* ESCC-B */
> -    qdev_connect_gpio_out(dev, 2, pic[0x25]); /* ESCC-A */
> -    qdev_connect_gpio_out(dev, 3, pic[0x0d]); /* IDE */
> -    qdev_connect_gpio_out(dev, 4, pic[0x02]); /* IDE DMA */
> -    qdev_connect_gpio_out(dev, 5, pic[0x0e]); /* IDE */
> -    qdev_connect_gpio_out(dev, 6, pic[0x03]); /* IDE DMA */
> +    qdev_connect_gpio_out(dev, 0,
> +        qdev_get_gpio_in(pic_dev, NEWWORLD_CUDA_IRQ));
> +    qdev_connect_gpio_out(dev, 1,
> +        qdev_get_gpio_in(pic_dev, NEWWORLD_ESCCB_IRQ));
> +    qdev_connect_gpio_out(dev, 2,
> +        qdev_get_gpio_in(pic_dev, NEWWORLD_ESCCA_IRQ));
> +    qdev_connect_gpio_out(dev, 3,
> +        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_IRQ));
> +    qdev_connect_gpio_out(dev, 4,
> +        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_DMA_IRQ));
> +    qdev_connect_gpio_out(dev, 5,
> +        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_IRQ));
> +    qdev_connect_gpio_out(dev, 6,
> +        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_DMA_IRQ));
>      qdev_prop_set_uint64(dev, "frequency", tbfreq);
>      object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
>                               &error_abort);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vIXBmblrD40XNCy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqx1DUACgkQbDjKyiDZ
s5KCmhAAu3HHjxeWJ9CDKloOH+l3hCslLajOcyujvr9wOu4OXrcZDsJNX9Q6QlkE
CuHBNB+Rj0PAAu5Rsj8ZVhO7ZCcZOohNbG5FC+a8DMmyc5VT08wH0K+6FwavyC3y
uW6eozUgTYmlUFdw0N527yohZmbyJaIpZ9k4Mzw3XwOQYzQ6KKbNJL+YRiEwaWqu
tAxcZlE8lJil4XLkDmFWVAHxurLAMGDnotlJpxwcr22peDZKFX6rLphsa7/PQKqN
9rZ2aXh8gKDOiP0SGeO67F6F2q3iWFErNwKpXwvzuEu9BKW9VssDQN5Ijg0pPUn8
GOS2JdRBRG9EC2is/rkDUzxuvoyrJIlV0CJbSdhrsIlCRwFXmLN953a284AYU47q
yqpVoAz4edrQG+YVhOtFUFbBdWVQJStVbalRsiw37cHg92G8R0aerTyKDvTCVFTT
ulB47UMcuy+Xn0TModhhlZf6i6Ep13gdO+06q+9aDNUmGfNqKeLK0xljjUJjCW++
UfK7Vt6wMge7sO4uwJvRm6FlVWM1liVIShiahtrQnkGoTQK60/Fo9D+Dpd09i4iD
jyCw8PzoESjaQxMs0IDPfSoO0XulHhN+9r1MQANg1DvAMc9/4SuNeQZvuYkWN555
83dg7u744O5rvHkj4YKAD5ucKdiTUX0w00SZNqP39SBxjFCkzS0=
=o7Wy
-----END PGP SIGNATURE-----

--vIXBmblrD40XNCy4--
