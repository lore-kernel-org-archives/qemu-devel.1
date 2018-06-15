Received: from eggs.gnu.org ([2001:4830:134:3::10]:59529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTegB-0002hL-SH
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTegA-0000oj-PF
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:41:35 -0400
Date: Fri, 15 Jun 2018 12:41:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615024126.GK4129@umbus.fritz.box>
References: <20180614140043.9231-1-clg@kaod.org>
	<20180614140043.9231-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0FM4RQAc0jwHekq5"
Content-Disposition: inline
In-Reply-To: <20180614140043.9231-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/6] ppc/pnv: move the details of the ISA
 bus creation under the LPC model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--0FM4RQAc0jwHekq5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 04:00:39PM +0200, C=E9dric Le Goater wrote:
> This is a small cleanup to hide to the machine the gory details of the
> creation of the ISA bus. When time comes, the 'qemu_irq_handler' should
> become a LPC controller class attribute.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/pnv_lpc.h |  3 +--
>  hw/ppc/pnv.c             | 15 +--------------
>  hw/ppc/pnv_lpc.c         | 24 ++++++++++++++++++++----
>  3 files changed, 22 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index fddcb1c054b3..fb4b7b83d798 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -72,7 +72,6 @@ typedef struct PnvLpcController {
>      bool   primary;
>  } PnvLpcController;
> =20
> -qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
> -                                 int nirqs);
> +ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, int chip_type);
> =20
>  #endif /* _PPC_PNV_LPC_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index b419d3323100..d2126ee4affc 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -521,22 +521,9 @@ static void pnv_reset(void)
> =20
>  static ISABus *pnv_isa_create(PnvChip *chip)
>  {
> -    PnvLpcController *lpc =3D &chip->lpc;
> -    ISABus *isa_bus;
> -    qemu_irq *irqs;
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> =20
> -    /* let isa_bus_new() create its own bridge on SysBus otherwise
> -     * devices speficied on the command line won't find the bus and
> -     * will fail to create.
> -     */
> -    isa_bus =3D isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io,
> -                          &error_fatal);
> -
> -    irqs =3D pnv_lpc_isa_irq_create(lpc, pcc->chip_type, ISA_NUM_IRQS);
> -
> -    isa_bus_irqs(isa_bus, irqs);
> -    return isa_bus;
> +    return pnv_lpc_isa_create(&chip->lpc, pcc->chip_type);
>  }

This 1-line wrapper doesn't look useful.  Why not just call
pnv_lpc_isa_create() from this thing's caller?

> =20
>  static void pnv_init(MachineState *machine)
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 1e70c8c19d52..7c6c012d5176 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -22,6 +22,7 @@
>  #include "target/ppc/cpu.h"
>  #include "qapi/error.h"
>  #include "qemu/log.h"
> +#include "hw/isa/isa.h"
> =20
>  #include "hw/ppc/pnv.h"
>  #include "hw/ppc/pnv_lpc.h"
> @@ -546,16 +547,31 @@ static void pnv_lpc_isa_irq_handler(void *opaque, i=
nt n, int level)
>      }
>  }
> =20
> -qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
> -                                 int nirqs)
> +ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, int chip_type)
>  {
> +    ISABus *isa_bus;
> +    qemu_irq *irqs;
> +    qemu_irq_handler handler;
> +
> +    /* let isa_bus_new() create its own bridge on SysBus otherwise
> +     * devices speficied on the command line won't find the bus and
> +     * will fail to create.
> +     */
> +    isa_bus =3D isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io,
> +                          &error_fatal);
> +
>      /* Not all variants have a working serial irq decoder. If not,
>       * handling of LPC interrupts becomes a platform issue (some
>       * platforms have a CPLD to do it).
>       */
>      if (chip_type =3D=3D PNV_CHIP_POWER8NVL) {
> -        return qemu_allocate_irqs(pnv_lpc_isa_irq_handler, lpc, nirqs);
> +        handler =3D pnv_lpc_isa_irq_handler;
>      } else {
> -        return qemu_allocate_irqs(pnv_lpc_isa_irq_handler_cpld, lpc, nir=
qs);
> +        handler =3D pnv_lpc_isa_irq_handler_cpld;
>      }
> +
> +    irqs =3D qemu_allocate_irqs(handler, lpc, ISA_NUM_IRQS);
> +
> +    isa_bus_irqs(isa_bus, irqs);
> +    return isa_bus;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0FM4RQAc0jwHekq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjJ1YACgkQbDjKyiDZ
s5JH/w//U28igXnLSfen6EWb/YDAqiopNhp3W7jK8BytiyNK/m+a61TW/ZiMjs6S
o5OnRHXg97abGuGKsx8bVIlq3iyZr2kMAjMe9D7j574k2vUuOfq8uTKH8SesFBLT
1Z5Z8LRBzuogVQgEoo6ucNGg6xXf928pvoB+oGL+94LS05Hf+L8KqTRhF9laNSj/
nCu8d17BvUVXZe9TkCMjMXb+aM1g7uoXeHOUCh2pL1cPN3bkyM/pGqcueDyrzBvA
jKQGttmDZMVcoOMR9zy2suqwlVfLVL2Y7P8324pRVwRvjV3GOJJvfF+1Q21CMEIj
iTe7Bo1PvfRaAZvBMohZUEk7KzslSYmse+QLr6/8z9VyUGpzeLATW1FXrGAxKnAN
mSUEK12pKCwatRiSZEh89UER0Nq/9OPcSUxYqDhx9VjUE/fcgwMb7c8bzCgdQx5b
veFsbY1GgPh8wAUZqFpRZM7fIeUlSkY2G/Tb04Hlfwq8D8jJgl7Ysu/zcDfmcZVa
TWyHzTaUO0JVZKZcwibCb6r+OsMGrECgGUc16Miipr8twvj0oU22IP5kpC8cwhc7
evSGeo+9qsw19foOSuRrRju+3Yl/EtsZBd2dOIZWSaEXWPOcGARF4Fsrak3Og4pf
uoTlBJaddpPb883wgaU8CFNDFn3mdzV2CI/sU3xVUvNO6IdGjr4=
=REm3
-----END PGP SIGNATURE-----

--0FM4RQAc0jwHekq5--
