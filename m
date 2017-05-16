Received: from eggs.gnu.org ([2001:4830:134:3::10]:49631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUTh-0000Jp-2I
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUTg-0003VV-1o
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:52:57 -0400
Date: Tue, 16 May 2017 14:37:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170516043729.GF30022@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484837602.20089.6188552126304330653.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline
In-Reply-To: <149484837602.20089.6188552126304330653.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 3/6] spapr: fix error reporting in
 xics_system_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 01:39:36PM +0200, Greg Kurz wrote:
> The xics_system_init() function passes its errp argument to xics_kvm_init=
().
> If the call fails and the user requested in-kernel irqchip, it then ends =
up
> passing a NULL Error * to error_reportf_err() and the error message is
> silently dropped.
>=20
> Passing an errp argument is generally wrong, unless you really just need
> to convey an error to the caller.
>=20
> This patch converts xics_system_init() to *only* pass a pointer to its own
> Error * and then to propagate it with error_propagate(), as recommended
> in error.h.
>=20
> The local_err name is used for consistency with the rest of the code.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

The change is good, but will need updating to work with the problem in
the previous patch.

> ---
>  hw/ppc/spapr.c |   17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f477d7b8a210..44f7dc7f40e9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -121,29 +121,32 @@ static ICSState *spapr_ics_create(sPAPRMachineState=
 *spapr,
>  static void xics_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> +    Error *local_err =3D NULL;
> =20
>      if (kvm_enabled()) {
> -        Error *err =3D NULL;
> -
>          if (machine_kernel_irqchip_allowed(machine) &&
> -            !xics_kvm_init(spapr, errp)) {
> +            !xics_kvm_init(spapr, &local_err)) {
>              spapr->icp_type =3D TYPE_KVM_ICP;
> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
, &err);
> +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
> +                                          &local_err);
>          }
>          if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> -            error_reportf_err(err,
> +            error_reportf_err(local_err,
>                                "kernel_irqchip requested but unavailable:=
 ");
>              exit(EXIT_FAILURE);
>          } else {
> -            error_free(err);
> +            error_free(local_err);
>          }
>      }
> =20
>      if (!spapr->ics) {
>          xics_spapr_init(spapr);
>          spapr->icp_type =3D TYPE_ICP;
> -        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
> +        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
> +                                      &local_err);
>      }
> +
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

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGoIJAAoJEGw4ysog2bOSIQAP/jtlyGiH/R8HZUFFVdCiR/m0
1yYuuptCFqQk7mNaxZUH/lLYPQLxB3FGjbsBH6WczX0kR/ZVR4ryGIraix6GgsuG
qdSigvR72kwJem1xZt6nif6CAcV6Qar0V+YbqN3dzkyr7ZkYZa+wBhcI2E2vdeIe
o6vXqlx7ooRNrjqMC03P1O2QenXLV8AGutu/Lod6GprhcHmV8i8zjwGFnU69jnjO
q8Keua/P6Y3DiRbwlt6PlKAFxdYx4NUuaq7sl18GbFrGU7gOAqU+Lm/OIF6P0gMM
JOJ3QYW+VFNFyHcteapL6Tw/VB39t9Pzfj9bmysW3lTF+y5Pzf1k6t1CUvgGBWjL
y9ZUino+BiBf/e35sZxxu72SFMQX3zOw35k7pGm1xWQAQC8tcHFdI93yMiJ+8nTf
3vnNmbuqy2ikDK4XtSNCbZ+moqNFSCpJyPCRLupHjYjPb/hcrACqYlP0b3rynTDj
RllMK0o+985WCHnKz0zY1up76VSYL3RxJCnri1pMBpcCN+oFP9LbWPpp2KvAdVm4
UXN57bbBXGJUH8DeeFol32DaLFyoCuLC6rE+HjbtUVZetSnxOcV5X50ozZndUNdA
pYItTke7h7NzJRu6OSRwXhidsyYKqFZOKr4xYpwo2E36ha0BRW8gcV/cL6pZQXnv
fBTe7lvn5TucJy5HRXup
=vozJ
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
