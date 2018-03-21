Received: from eggs.gnu.org ([2001:4830:134:3::10]:45507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eyUdp-0004ZM-NP
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eyUdl-0000nt-Kk
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:42:21 -0400
Date: Wed, 21 Mar 2018 14:42:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180321034207.GR3905@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-20-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tV/+6PImfyFtriLg"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-20-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 19/19] mac_newworld: move wiring of macio
 IRQs to macio_newworld_realize()
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


--tV/+6PImfyFtriLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:31:03PM +0000, Mark Cave-Ayland wrote:
> Since the macio device has a link to the PIC device, we can now wire up t=
he
> IRQs directly via qdev GPIOs rather than having to use an intermediate ar=
ray.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/misc/macio/macio.c         | 37 ++++++++++++++++++++++---------------
>  hw/ppc/mac_newworld.c         | 14 --------------
>  include/hw/misc/macio/macio.h |  1 -
>  3 files changed, 22 insertions(+), 30 deletions(-)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index af1bd46b4b..1aa7bb7c89 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -265,11 +265,10 @@ static void macio_newworld_realize(PCIDevice *d, Er=
ror **errp)
>  {
>      MacIOState *s =3D MACIO(d);
>      NewWorldMacIOState *ns =3D NEWWORLD_MACIO(d);
> +    DeviceState *pic_dev =3D DEVICE(ns->pic);
>      Error *err =3D NULL;
>      SysBusDevice *sysbus_dev;
>      MemoryRegion *timer_memory =3D NULL;
> -    int i;
> -    int cur_irq =3D 0;
> =20
>      macio_common_realize(d, &err);
>      if (err) {
> @@ -278,11 +277,14 @@ static void macio_newworld_realize(PCIDevice *d, Er=
ror **errp)
>      }
> =20
>      sysbus_dev =3D SYS_BUS_DEVICE(&s->cuda);
> -    sysbus_connect_irq(sysbus_dev, 0, ns->irqs[cur_irq++]);
> +    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
> +                                                       NEWWORLD_CUDA_IRQ=
));
> =20
>      sysbus_dev =3D SYS_BUS_DEVICE(&s->escc);
> -    sysbus_connect_irq(sysbus_dev, 0, ns->irqs[cur_irq++]);
> -    sysbus_connect_irq(sysbus_dev, 1, ns->irqs[cur_irq++]);
> +    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
> +                                                       NEWWORLD_ESCCB_IR=
Q));
> +    sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
> +                                                       NEWWORLD_ESCCA_IR=
Q));
> =20
>      /* OpenPIC */
>      sysbus_dev =3D SYS_BUS_DEVICE(ns->pic);
> @@ -290,15 +292,22 @@ static void macio_newworld_realize(PCIDevice *d, Er=
ror **errp)
>                                  sysbus_mmio_get_region(sysbus_dev, 0));
> =20
>      /* IDE buses */
> -    for (i =3D 0; i < ARRAY_SIZE(ns->ide); i++) {
> -        qemu_irq irq0 =3D ns->irqs[cur_irq++];
> -        qemu_irq irq1 =3D ns->irqs[cur_irq++];
> +    macio_realize_ide(s, &ns->ide[0],
> +                      qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_IRQ),
> +                      qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_DMA_IRQ),
> +                      0x16, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> =20
> -        macio_realize_ide(s, &ns->ide[i], irq0, irq1, 0x16 + (i * 4), &e=
rr);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> +    macio_realize_ide(s, &ns->ide[1],
> +                      qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_IRQ),
> +                      qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_DMA_IRQ),
> +                      0x1a, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
>      }
> =20
>      /* Timer */
> @@ -314,8 +323,6 @@ static void macio_newworld_init(Object *obj)
>      NewWorldMacIOState *ns =3D NEWWORLD_MACIO(obj);
>      int i;
> =20
> -    qdev_init_gpio_out(DEVICE(obj), ns->irqs, ARRAY_SIZE(ns->irqs));
> -
>      object_property_add_link(obj, "pic", TYPE_OPENPIC,
>                               (Object **) &ns->pic,
>                               qdev_prop_allow_set_link_before_realize,
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 3cde507065..ae2ce562a4 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -376,20 +376,6 @@ static void ppc_core99_init(MachineState *machine)
>      /* MacIO */
>      macio =3D NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO=
));
>      dev =3D DEVICE(macio);
> -    qdev_connect_gpio_out(dev, 0,
> -        qdev_get_gpio_in(pic_dev, NEWWORLD_CUDA_IRQ));
> -    qdev_connect_gpio_out(dev, 1,
> -        qdev_get_gpio_in(pic_dev, NEWWORLD_ESCCB_IRQ));
> -    qdev_connect_gpio_out(dev, 2,
> -        qdev_get_gpio_in(pic_dev, NEWWORLD_ESCCA_IRQ));
> -    qdev_connect_gpio_out(dev, 3,
> -        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_IRQ));
> -    qdev_connect_gpio_out(dev, 4,
> -        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_DMA_IRQ));
> -    qdev_connect_gpio_out(dev, 5,
> -        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_IRQ));
> -    qdev_connect_gpio_out(dev, 6,
> -        qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_DMA_IRQ));
>      qdev_prop_set_uint64(dev, "frequency", tbfreq);
>      object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
>                               &error_abort);
> diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
> index 4528282b36..e3b9ef48dd 100644
> --- a/include/hw/misc/macio/macio.h
> +++ b/include/hw/misc/macio/macio.h
> @@ -72,7 +72,6 @@ typedef struct NewWorldMacIOState {
>      /*< public >*/
> =20
>      OpenPICState *pic;
> -    qemu_irq irqs[7];
>      MACIOIDEState ide[2];
>  } NewWorldMacIOState;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tV/+6PImfyFtriLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqx1I8ACgkQbDjKyiDZ
s5LDvA//ffoylWaEVn+vMMyzKHHW1rbSiLXCDm75UJ5ElnsGuYHOAVeXUSx31UGY
Nw0W4ovrarOz7FagVrw9w26t5XUFuaBLuJN4FbVziCMqfWXBZxEGKn0Nez4esRjW
exnBsBB/mMxLyinPwnpnqM8ZcG56OpOz5ZHQ1eHIdp5bJZqa/ZEBgFoJiSLJGt3m
nQL5UmUwYL4AlmLYPHArIo5bUR4FlzUqRXqQ6v178I58IHsBWEyxNFQzSrDAywrk
WOC808N94a6G4tJ3ROJnagckdq6njlQJ7RyyavJ/724/Ky0q1n9JKi6K5HFFWFLr
Jq5lZqtAQRRTG/ypGb0lBzqinQmctLfXbqTlM+nGCb2bkgz5XaEeVpaBGqsTIg0O
YOXr/a9YP4exlNQidfN4ncGTfmGio57bmKusbeqyyydR9T2vNg2ETR/Eynjf2S6V
EARUhnujy6TRVKbUs7G6zx/9xTPSZAIFY1oUa0xrt82EVvr2mxVfU5Xs4tovrDpH
QKgNVL87XApHmI7cXQvWFpIzWQTRHYDC0/ycXVicWFK1sLTTJsDoZyjcg3cPQWuq
GO10MPr8qXC+T9ngO5PG4w9Tquhz1jzi4bGdQT77mYb42UmZsxkaVda2uM52zZXH
/1f9g7FtnPqXGy5dnXC89bXz6SAOgZOd2z6E+vgKIE2nYjQ5iU4=
=Sm0w
-----END PGP SIGNATURE-----

--tV/+6PImfyFtriLg--
