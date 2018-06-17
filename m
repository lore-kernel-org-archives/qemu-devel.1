Received: from eggs.gnu.org ([2001:4830:134:3::10]:52455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUhTm-0003HM-9F
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 19:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUhTl-0007Oq-8Z
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 19:53:06 -0400
Date: Mon, 18 Jun 2018 09:43:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180617234332.GA25461@umbus.fritz.box>
References: <152908188027.303663.3989619661643297289.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <152908188027.303663.3989619661643297289.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix xics_system_init() error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 06:58:00PM +0200, Greg Kurz wrote:
> Commit 3d85885a1b1f3 tried to fix error handling, but it actually
> went into the wrong direction by dropping the local Error *.
>=20
> In the default KVM case, the rationale is to try the in-kernel XICS first,
> and if not possible, to fallback to userland XICS. Passing errp everywhere
> makes this fallback impossible if errp is &error_fatal (which happens to
> be the case). And anyway, if the caller would pass a regular &local_err,
> things would be worse: we could possibly pass an already set *errp to
> error_setg() and crash, or return an error even in case of success.
>=20
> So we definitely need a local Error * and only propagate it when we're
> done with the fallback logic. This is what this patch does.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/ppc/spapr.c |   22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f59999daacfc..db0fb385d4e0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -186,27 +186,33 @@ static int xics_max_server_number(sPAPRMachineState=
 *spapr)
>  static void xics_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> +    Error *local_err =3D NULL;
> =20
>      if (kvm_enabled()) {
>          if (machine_kernel_irqchip_allowed(machine) &&
> -            !xics_kvm_init(spapr, errp)) {
> +            !xics_kvm_init(spapr, &local_err)) {
>              spapr->icp_type =3D TYPE_KVM_ICP;
> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, errp);
> +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
> +                                          &local_err);
>          }
>          if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> -            error_prepend(errp, "kernel_irqchip requested but unavailabl=
e: ");
> -            return;
> +            error_prepend(&local_err,
> +                          "kernel_irqchip requested but unavailable: ");
> +            goto error;
>          }
> +        error_free(local_err);
> +        local_err =3D NULL;
>      }
> =20
>      if (!spapr->ics) {
>          xics_spapr_init(spapr);
>          spapr->icp_type =3D TYPE_ICP;
> -        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
> -        if (!spapr->ics) {
> -            return;
> -        }
> +        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
> +                                      &local_err);
>      }
> +
> +error:
> +    error_propagate(errp, local_err);
>  }
> =20
>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsm8iEACgkQbDjKyiDZ
s5LmgA//RiqQu4UQ5uLAmLbn/Dl58NO+HKx0cZC8MEMtoAk8I11ro/gOvtZIUTKh
oDg/F0bWJWcw2moP+e+wKKTvckQ0icP44pzY7mx/Snk/KeV8KJnI4A3z07ZU/cb0
rFjWNsnCHjSSiouzzvw+3hyg2UxzXrOPxhj3fFY6PUt7UBzT2NRo4lYID/W1pOcl
zCy/OdsvjVXxZych4UIK5+xJHV+vVbg4r84YF10cHEW1RljEK+Ufua85yCcG6g7+
O8lpDN5L0fE5Di+y7X98pHLzKZUxxUNj9XwYe6+T269IYx0sRgVHt36hW8fzSfvq
kjZKa6BwpSzGUmMIUeClHUDfA1XVUXKIez3uyvIs2OANnBsNEyRqrX86sr7UTVlE
mp9rFxt71cyH0EM8ZcDIkiohET6YlOMBzK8iITZ82rcUQ5egXY7SiN3vaMTITxBA
O9kYfhvh6EEEPYhlV/3WZSwzDuCZGpHmLmCcjObDymhHkgAVpcsD7fGCpGnpm1EW
bR+15/k9w5dmugftXESGNtS7Uet0Gc+AKYy34OGHb5p7+sna95dGr3e1H1BBvCZ7
5dZN8jKp2LTMlXRlTv2DATEnu2cTLNnAdE4ZgwMfwN+bzGtjtpxZR82hIdriL+2a
mpEDnEiDJohv+cH5vi3fvSTLtrQe7ATLDgyX4LUZuBCGIcCP0Eo=
=P2sk
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
