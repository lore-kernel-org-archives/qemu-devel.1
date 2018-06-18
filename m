Received: from eggs.gnu.org ([2001:4830:134:3::10]:52172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlQt-0007m0-5U
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlQr-0006eD-NX
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:06:23 -0400
Date: Mon, 18 Jun 2018 14:05:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618040547.GV25461@umbus.fritz.box>
References: <20180615152536.30093-1-clg@kaod.org>
	<20180615152536.30093-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zd8I2GZVcdxtyaG/"
Content-Disposition: inline
In-Reply-To: <20180615152536.30093-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] ppc/pnv: introduce a new
 isa_create() operation to the chip model
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


--Zd8I2GZVcdxtyaG/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 05:25:34PM +0200, C=E9dric Le Goater wrote:
> This moves the details of the ISA bus creation under the LPC model but
> more important, the new PnvChip operation will let us choose the chip
> class to use when we introduce the different chip classes for Power9
> and Power8. It hides away the processor chip controllers from the
> machine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>=20
>  pnv_isa_create() is a onliner but it looks better like that than to
>  use it directly with pnv->chips[0]
>=20
>  include/hw/ppc/pnv.h     |  1 +
>  include/hw/ppc/pnv_lpc.h |  3 +--
>  hw/ppc/pnv.c             | 34 +++++++++++++++++++---------------
>  hw/ppc/pnv_lpc.c         | 30 +++++++++++++++++++++++++-----
>  4 files changed, 46 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index e934e84f555e..563279f3e00c 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -77,6 +77,7 @@ typedef struct PnvChipClass {
> =20
>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
>      Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp);
> +    ISABus *(*isa_create)(PnvChip *chip, Error **errp);
>  } PnvChipClass;
> =20
>  #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index 53fdd5bb6450..d657489b07ce 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -70,7 +70,6 @@ typedef struct PnvLpcController {
>      PnvPsi *psi;
>  } PnvLpcController;
> =20
> -qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
> -                                 int nirqs);
> +ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error *=
*errp);
> =20
>  #endif /* _PPC_PNV_LPC_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c7e127ae97db..ac828d133173 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -529,24 +529,24 @@ static void pnv_reset(void)
>      cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>  }
> =20
> -static ISABus *pnv_isa_create(PnvChip *chip)
> +static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
>  {
> -    PnvLpcController *lpc =3D &chip->lpc;
> -    ISABus *isa_bus;
> -    qemu_irq *irqs;
> -    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> +    return pnv_lpc_isa_create(&chip->lpc, true, errp);
> +}
> =20
> -    /* let isa_bus_new() create its own bridge on SysBus otherwise
> -     * devices speficied on the command line won't find the bus and
> -     * will fail to create.
> -     */
> -    isa_bus =3D isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io,
> -                          &error_fatal);
> +static ISABus *pnv_chip_power8nvl_isa_create(PnvChip *chip, Error **errp)
> +{
> +    return pnv_lpc_isa_create(&chip->lpc, false, errp);
> +}
> =20
> -    irqs =3D pnv_lpc_isa_irq_create(lpc, pcc->chip_type, ISA_NUM_IRQS);
> +static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp)
> +{
> +    return NULL;
> +}
> =20
> -    isa_bus_irqs(isa_bus, irqs);
> -    return isa_bus;
> +static ISABus *pnv_isa_create(PnvChip *chip, Error **errp)
> +{
> +    return PNV_CHIP_GET_CLASS(chip)->isa_create(chip, errp);
>  }
> =20
>  static void pnv_init(MachineState *machine)
> @@ -646,7 +646,7 @@ static void pnv_init(MachineState *machine)
>      g_free(chip_typename);
> =20
>      /* Instantiate ISA bus on chip 0 */
> -    pnv->isa_bus =3D pnv_isa_create(pnv->chips[0]);
> +    pnv->isa_bus =3D pnv_isa_create(pnv->chips[0], &error_fatal);
> =20
>      /* Create serial port */
>      serial_hds_isa_init(pnv->isa_bus, 0, MAX_ISA_SERIAL_PORTS);
> @@ -735,6 +735,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
>      k->cores_mask =3D POWER8E_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
> +    k->isa_create =3D pnv_chip_power8_isa_create;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8E";
>  }
> @@ -749,6 +750,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
>      k->cores_mask =3D POWER8_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
> +    k->isa_create =3D pnv_chip_power8_isa_create;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8";
>  }
> @@ -763,6 +765,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
>      k->cores_mask =3D POWER8_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
> +    k->isa_create =3D pnv_chip_power8nvl_isa_create;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8NVL";
>  }
> @@ -777,6 +780,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
>      k->cores_mask =3D POWER9_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p9;
>      k->intc_create =3D pnv_chip_power9_intc_create;
> +    k->isa_create =3D pnv_chip_power9_isa_create;
>      k->xscom_base =3D 0x00603fc00000000ull;
>      dc->desc =3D "PowerNV Chip POWER9";
>  }
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 402c4fefa886..d7721320a25b 100644
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
> @@ -535,16 +536,35 @@ static void pnv_lpc_isa_irq_handler(void *opaque, i=
nt n, int level)
>      }
>  }
> =20
> -qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,
> -                                 int nirqs)
> +ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error *=
*errp)
>  {
> +    Error *local_err =3D NULL;
> +    ISABus *isa_bus;
> +    qemu_irq *irqs;
> +    qemu_irq_handler handler;
> +
> +    /* let isa_bus_new() create its own bridge on SysBus otherwise
> +     * devices speficied on the command line won't find the bus and
> +     * will fail to create.
> +     */
> +    isa_bus =3D isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io, &local_er=
r);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
>      /* Not all variants have a working serial irq decoder. If not,
>       * handling of LPC interrupts becomes a platform issue (some
>       * platforms have a CPLD to do it).
>       */
> -    if (chip_type =3D=3D PNV_CHIP_POWER8NVL) {
> -        return qemu_allocate_irqs(pnv_lpc_isa_irq_handler, lpc, nirqs);
> +    if (use_cpld) {
> +        handler =3D pnv_lpc_isa_irq_handler_cpld;
>      } else {
> -        return qemu_allocate_irqs(pnv_lpc_isa_irq_handler_cpld, lpc, nir=
qs);
> +        handler =3D pnv_lpc_isa_irq_handler;
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

--Zd8I2GZVcdxtyaG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnL5oACgkQbDjKyiDZ
s5Kvqw/7Bzk4H52uFSxxWO6tD16X4/niIyXEjWp78Pj/zW1WGh9MGBOdbr+1diOl
Pr0yYuvwZO2/V9qf8c83c4abD7UZuMPCkiIhEBjCCwEou2e5xYEu0cGBOxgzPS2h
dAdpK2w/0+KwjRWlFiHV/8fyLKFcu0K2eViRr+PGG64Ff7co5GrkrrDM9Vl0hx1M
eNm7GvKjOpaMoPjDPFjC2BF8m0sb2G/5pwZTk/lPYtQxlGmo34iIjY57IVdCO3P5
UBkGtI0IJfQRZIKQCYtYUt7pc5BW3tE5Y8ZYIOXFYp3x4n08gdIQUzk/vrplaT6U
gizR9vbmxQXO6TqG1kMg/aC333/1N/7MsZhjxThreXHljy5JRC0Pnb+2SFHm3Yuw
YUcMHIfyQMSmEc4PCjxCSq3suLCWap1Z78/nptPjbaId3Gpg1iuzwkZEyswmeaJW
Ig34T5rtCzjwT0XVhhKqK2dlpoo4ejMNKVyrr++Kj7O04muviq2nYYBZNGrADOhY
mWRaOSUOrJQ0mLQNSWLyD0dFoEHn2SkLroRC3en3GaeVRPpBttTcUDyAWDP+W2+Z
Y8FKMKDIdMEsKyjbnycFj6cY7C5GHB/ddtgBE2iFq70sJoTtd8hwk9+0okdzP9Ld
PnzkyutZw6EZAtgO4bG59KPOUv8pGEKhSfw8/ae1o85WXzXI2T4=
=WJ/9
-----END PGP SIGNATURE-----

--Zd8I2GZVcdxtyaG/--
