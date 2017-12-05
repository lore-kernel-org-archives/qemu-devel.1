Received: from eggs.gnu.org ([2001:4830:134:3::10]:47189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMANz-0004td-4y
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMANx-0002yV-Vu
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:35 -0500
Date: Tue, 5 Dec 2017 17:37:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205063710.GH3057@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<5d63d645603b83d24187c3844bd0728bd4c4b682.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Content-Disposition: inline
In-Reply-To: <5d63d645603b83d24187c3844bd0728bd4c4b682.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 10/17] e500: move uarts CCSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:08PM -0600, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/ppc/e500.c      | 13 -------------
>  hw/ppc/e500_ccsr.c | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 1872bb8eaa..2d87d91582 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -22,7 +22,6 @@
>  #include "net/net.h"
>  #include "qemu/config-file.h"
>  #include "hw/hw.h"
> -#include "hw/char/serial.h"
>  #include "hw/pci/pci.h"
>  #include "hw/boards.h"
>  #include "sysemu/sysemu.h"
> @@ -770,18 +769,6 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>      mpicdev =3D DEVICE(object_resolve_path("/machine/pic", 0));
>      assert(mpicdev);
> =20
> -    /* Serial */
> -    if (serial_hds[0]) {
> -        serial_mm_init(ccsr_addr_space, MPC8544_SERIAL0_REGS_OFFSET,
> -                       0, qdev_get_gpio_in(mpicdev, 42), 399193,
> -                       serial_hds[0], DEVICE_BIG_ENDIAN);
> -    }
> -
> -    if (serial_hds[1]) {
> -        serial_mm_init(ccsr_addr_space, MPC8544_SERIAL1_REGS_OFFSET,
> -                       0, qdev_get_gpio_in(mpicdev, 42), 399193,
> -                       serial_hds[1], DEVICE_BIG_ENDIAN);
> -    }
> =20
>      /* PCI */
>      dev =3D qdev_create(NULL, "e500-pcihost");
> diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
> index 68d952794e..f1adba4e54 100644
> --- a/hw/ppc/e500_ccsr.c
> +++ b/hw/ppc/e500_ccsr.c
> @@ -31,6 +31,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
>  #include "hw/sysbus.h"
> +#include "hw/char/serial.h"
>  #include "hw/ppc/openpic.h"
> =20
>  /* E500_ denotes registers common to all */
> @@ -45,6 +46,8 @@
>  #define E500_ERR_DETECT  (0x2e40)
>  #define E500_ERR_DISABLE (0x2e44)
> =20
> +#define E500_DUART_OFFSET(N) (0x4500 + (N) * 0x100)
> +
>  #define E500_PORPLLSR    (0xE0000)
>  #define E500_PVR         (0xE00A0)
>  #define E500_SVR         (0xE00A4)
> @@ -266,6 +269,21 @@ static void e500_ccsr_realize(DeviceState *dev, Erro=
r **errp)
> =20
>      memory_region_add_subregion(&ccsr->iomem, E500_MPIC_OFFSET,
>                                  sysbus_mmio_get_region(pic, 0));
> +    /* Note: MPIC internal interrupts are offset by 16 */
> +
> +    /* DUARTS */
> +    if (serial_hds[0]) {
> +        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(0),

By changing the constants in use here for the base address you're now
creating the actual device and creating the device tree entry from
different (but same valued) constants.  That seems risky.

> +                       0, qdev_get_gpio_in(ccsr->pic, 16 + 26), 399193,
> +                       serial_hds[0], DEVICE_BIG_ENDIAN);
> +    }
> +
> +    if (serial_hds[1]) {
> +        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(1),
> +                       0, qdev_get_gpio_in(ccsr->pic, 16 + 26), 399193,
> +                       serial_hds[1], DEVICE_BIG_ENDIAN);
> +    }
> +
>  }
> =20
>  static Property e500_ccsr_props[] =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlomPpYACgkQbDjKyiDZ
s5IQcBAApm4fPzWFR5cdWSEuOyCLhS2qAeP/thGh2cMvBmNkadO4THJ0IojctNdM
lg7Nu/x6Tb0SowfnGrhEDcL67w1rXPYUMQGYqSEQ4xgV4A942kV6CAY2w0oUfZ2Z
o703Aj2ZefzeuVSMRZi6HctafdA5pTPtCtxrF3d/oJJNrDHe2DnawiFFi/mWYF10
SD7Chbm9TDui2GXyYneRijAtgkMs3pgYpX7E+7xBmktoXdUArbTQG8Gc/HAilloH
t15nQNqHJsF5Tk6mZnBzsvIK5upkaJzhxdSCggEadMnfPFLIKE5URUytVRpWHPA5
9MF28+2nBSHDn5QXCgPbOTc/K5EBTctx9QG+qBy7HCqGjHHyPS6M9axyjlzufVh9
mWsjhyPmrFoVju+Oxsk5ElTxrNEqbOy7gOA7nkwFTRkcRURjRc7nGfUXLox7rGlp
E3wMY6R3wEVxBcAaevLpm62gReJp+2um1UJum30xbagnzda01tZobQahkXAzL5Dv
c++1WcvWU1KA5w4wuvJ9E1xj7/Wh88vyjPxcqeM6Z7UwZ6C9ZorB0KZYzQJ7FD9n
9VMcbt+RR/1TPar0w+tijsOLa5/MlYPkY5DDc7+Z3rA+6S/MS2YNSmBwSuzWp9+f
qXwwotAvHV0ZEXKLmhylC7QZ/tCdmbMSc01oWiIxznXxkSvqAgI=
=aelY
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
