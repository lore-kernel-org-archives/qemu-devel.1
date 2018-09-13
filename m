Received: from eggs.gnu.org ([2001:4830:134:3::10]:40369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0IvS-0001Qr-PX
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0IvO-0006wj-KD
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 00:08:18 -0400
Date: Thu, 13 Sep 2018 12:25:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180913022534.GU7978@umbus.fritz.box>
References: <20180911055503.2303-1-clg@kaod.org>
	<20180911055503.2303-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eNjIDde0W37E3OQP"
Content-Disposition: inline
In-Reply-To: <20180911055503.2303-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] spapr: increase the size of the IRQ
 number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--eNjIDde0W37E3OQP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2018 at 07:55:03AM +0200, C=E9dric Le Goater wrote:
> The new layout using static IRQ number does not leave much space to
> the dynamic MSI range, only 0x100 IRQ numbers. Increase the total
> number of IRQS for newer machines and introduce a legacy XICS backend
> for pre-3.1 machines to maintain compatibility.
>=20
> For the old backend, provide a 'nr_msis' value covering the full IRQ
> number space as it does not use the bitmap allocator to allocate MSI
> interrupt numbers.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.1, thanks.

> ---
>  include/hw/ppc/spapr_irq.h |  1 +
>  hw/ppc/spapr.c             |  1 +
>  hw/ppc/spapr_irq.c         | 15 ++++++++++++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 650f810ad2aa..a467ce696ee4 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -41,6 +41,7 @@ typedef struct sPAPRIrq {
>  } sPAPRIrq;
> =20
>  extern sPAPRIrq spapr_irq_xics;
> +extern sPAPRIrq spapr_irq_xics_legacy;
> =20
>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4a9dd4d9bc14..eba7d60a30a7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3971,6 +3971,7 @@ static void spapr_machine_3_0_class_options(Machine=
Class *mc)
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_0);
> =20
>      smc->legacy_irq_allocation =3D true;
> +    smc->irq =3D &spapr_irq_xics_legacy;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index fe8be5f5217a..e77b94cc685e 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -195,7 +195,7 @@ static void spapr_irq_print_info_xics(sPAPRMachineSta=
te *spapr, Monitor *mon)
>      ics_pic_print_info(spapr->ics, mon);
>  }
> =20
> -#define SPAPR_IRQ_XICS_NR_IRQS     0x400
> +#define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> =20
> @@ -289,3 +289,16 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num=
, bool align, Error **errp)
> =20
>      return first + ics->offset;
>  }
> +
> +#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
> +
> +sPAPRIrq spapr_irq_xics_legacy =3D {
> +    .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> +    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> +
> +    .init        =3D spapr_irq_init_xics,
> +    .claim       =3D spapr_irq_claim_xics,
> +    .free        =3D spapr_irq_free_xics,
> +    .qirq        =3D spapr_qirq_xics,
> +    .print_info  =3D spapr_irq_print_info_xics,
> +};

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eNjIDde0W37E3OQP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluZyp4ACgkQbDjKyiDZ
s5JL+g//aBEU+JIbhTr3Y3IxeEFkO/76Tn0vyB6SiDk9sPYUwFnBy0Wrao+d1mC/
zp1Ap9XsvqGxqc0LnJT8xDZP6VtdCu3Ju3/3yXLk0M5AF7ipTmoq32I5GgYOG8of
e94k3L/+3CFRZ3+sUQlq7S1yCJDMvZM5R0CmJiPxxgez/v2I/De9U1/mWpRQi4V+
OeoXaT4YU7ljes99bo5te22hp9Y+bXPCs5C1OzpKnWSvivydFJ97ReURTd2g8il7
RirROM9R2EC5wWSroM3LiJRtYYaC40QdbupZCVJJJ+/DXi0FkbGKUbXrQ+E+T+WZ
OZ1rJxZROthGEQRPzgQdJVqtXGe1gN3q0fUBtr01/gfQ109KLPNEqGN3UptjIMYM
Wht30XjA32jEjPNTkD0Ytd2HgsCy1+Y9NOqgYozBcjCf8n5UWpNJW9tVqAlq5EOh
SniYsHm9vs6/c/z4rtrLtJ8UqrXDPIYoi0+WmCh7PsbfQpfVCiX5eIKNmYdgPD3S
CqAyTOSw4Ze1VYtw7/K3Ck/+3rezhNm8vmD9C870R7s8cvw25onl+ruckG6p5gqV
JYDlL9vCeJ8FSCt/eZFQUuq6Qt2RtNPlZ1GTl32tkVnjBXkl7bmOIsXCekC4mFBF
p4w+4XsV5L3jSVGlp+25V8xfQquPTd4G7O6jSB18t+P57S7oOx4=
=VxLT
-----END PGP SIGNATURE-----

--eNjIDde0W37E3OQP--
