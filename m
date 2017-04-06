Received: from eggs.gnu.org ([2001:4830:134:3::10]:46344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cvzwh-00060O-GO
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 01:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cvzwd-0000e0-KH
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 01:26:59 -0400
Date: Thu, 6 Apr 2017 14:23:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170406042318.GA12179@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-5-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-5-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 04/21] ppc/pnv: enable only one LPC bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:29PM +0200, C=E9dric Le Goater wrote:
> Multi chip systems only have one LPC bus, on chip 0. The PnvLPC object
> will still be created under the PnvChip objects but only the one under
> chip 0 will be advertise in the device tree.
>=20
> Also remove the comment which is slightly wrong. Only chip 0 has a LPC
> device node : xscom@3fc0000000000/isa@b0020
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This seems a very round about way of accomplishing the goal.  Wouldn't
it make more sense for the chip to only construct (or only realize)
the LPC if it's chip zero, rather than passing the chip id through to
the lpc object.

> ---
>  hw/ppc/pnv.c             |  2 ++
>  hw/ppc/pnv_lpc.c         | 20 ++++++++++++--------
>  include/hw/ppc/pnv_lpc.h |  2 ++
>  3 files changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 78133e5d20e1..493c7eed7980 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -811,6 +811,8 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
>      g_free(typename);
> =20
>      /* Create LPC controller */
> +    object_property_set_int(OBJECT(&chip->lpc), chip->chip_id, "chip-id",
> +                            &error_fatal);
>      object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
>                               &error_fatal);
>      pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xscom_r=
egs);
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 20cbb6a0dbbd..1a212a2a399f 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -92,14 +92,6 @@ enum {
>  #define LPC_HC_REGS_OPB_SIZE    0x00001000
> =20
> =20
> -/*
> - * TODO: the "primary" cell should only be added on chip 0. This is
> - * how skiboot chooses the default LPC controller on multichip
> - * systems.
> - *
> - * It would be easly done if we can change the populate() interface to
> - * replace the PnvXScomInterface parameter by a PnvChip one
> - */
>  static int pnv_lpc_populate(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
>  {
>      const char compat[] =3D "ibm,power8-lpc\0ibm,lpc";
> @@ -110,6 +102,12 @@ static int pnv_lpc_populate(PnvXScomInterface *dev, =
void *fdt, int xscom_offset)
>          cpu_to_be32(lpc_pcba),
>          cpu_to_be32(PNV_XSCOM_LPC_SIZE)
>      };
> +    PnvLpcController *lpc =3D PNV_LPC(dev);
> +
> +    /* Only populate one LPC bus per system, the one on chip 0.*/
> +    if (lpc->chip_id) {
> +        return 0;
> +    }
> =20
>      name =3D g_strdup_printf("isa@%x", lpc_pcba);
>      offset =3D fdt_add_subnode(fdt, xscom_offset, name);
> @@ -486,6 +484,11 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
>      lpc->psi =3D PNV_PSI(obj);
>  }
> =20
> +static Property pnv_lpc_properties[] =3D {
> +    DEFINE_PROP_UINT32("chip-id", PnvLpcController, chip_id, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void pnv_lpc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -494,6 +497,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, vo=
id *data)
>      xdc->populate =3D pnv_lpc_populate;
> =20
>      dc->realize =3D pnv_lpc_realize;
> +    dc->props =3D pnv_lpc_properties;
>  }
> =20
>  static const TypeInfo pnv_lpc_info =3D {
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index 53040026c37b..dcfadda90090 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -67,6 +67,8 @@ typedef struct PnvLpcController {
> =20
>      /* PSI to generate interrupts */
>      PnvPsi *psi;
> +
> +    uint32_t chip_id;
>  } PnvLpcController;
> =20
>  #define   LPC_HC_IRQ_SERIRQ0            0x80000000 /* all bits down to .=
=2E. */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY5cK0AAoJEGw4ysog2bOSxX8QAJ+3Q42FDLIZRgPeJPZpLQsz
Wa40HHH2kr04hosJMRszsi4hoWenz/5OhB9TcnvYa207shpjJuY05VmL0nAUX/wp
cdkzsy2ci9Q8EoyODvjTtUIbgfvHnTIMBDr8rYCGGdCnO3saa6RVXECnBXgenzIa
JEWM2o/U7Fmz1twjDc+MSC9wIBc/NZwQanP04Ayv9mdlANiD++ER+U3pJvcgQrPg
h5oOiWJcbVKTOFVjERVorgJD7WsHVq1Be1KHAJE0Ie4yujLlOwnPqNC6WwyvJxsE
1p3q36qUlV5jTzFLB8RJy/z47L2wnrGtYEqsDDJz1x4sCUngfbKzcYGrBrsMySQi
M+PiNLtbmWy7gGVdQHuKEI9ZCwJtKNNrppgOMCscNOFXvkhIQWa92Abo7fROxr4u
u5VWHFVaWe9r+subKtstsvb4WKUOrKWbbd0YfpugGWPDcZlKwqPWskb3Io7m28Wn
z9NOKLkv0KZTcA4hSNxEXnKHsAgmPiT6XqZuq8xKS25TSNjsCxvM4ed0MYD524at
mnKbZIqmITA54n9E/fv/XjW+5Gq/Niqwr2fJ7xmQdvkw6MEBP8T5rtjDT3mQDDP+
EtovibEXxTMBDiN9nau0zfX4n0e8cDmGQ92X1/p2bEMqiFwFk2l16r9a4KwlQqlY
Pnwais4Zc3wp2DddaQFL
=9kOv
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
