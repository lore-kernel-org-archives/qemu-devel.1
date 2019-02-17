Received: from eggs.gnu.org ([209.51.188.92]:52617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiA-0008CG-WD
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi9-0005dm-UO
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:06 -0500
Date: Mon, 18 Feb 2019 10:51:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217235144.GK2765@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023083585.1011724.2868047424353921455.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ppIqr1kl39GnwQx"
Content-Disposition: inline
In-Reply-To: <155023083585.1011724.2868047424353921455.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 09/10] spapr/irq: Use the "simple" ICS
 class for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--1ppIqr1kl39GnwQx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 12:40:35PM +0100, Greg Kurz wrote:
> The "simple" ICS class knows how to interract with KVM. Adapt sPAPR to use
> it instead of the ICS KVM class.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_irq.c |   15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 9f43b7b3bf16..4aa8165307c7 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -67,13 +67,12 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr)
>   */
> =20
>  static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
> -                                  const char *type_ics,
>                                    int nr_irqs, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      Object *obj;
> =20
> -    obj =3D object_new(type_ics);
> +    obj =3D object_new(TYPE_ICS_SIMPLE);
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                     &error_abort);
> @@ -98,14 +97,14 @@ static void spapr_irq_init_xics(sPAPRMachineState *sp=
apr, int nr_irqs,
>  {
>      MachineState *machine =3D MACHINE(spapr);
>      Error *local_err =3D NULL;
> +    bool xics_kvm =3D false;
> =20
>      if (kvm_enabled()) {
>          if (machine_kernel_irqchip_allowed(machine) &&
>              !xics_kvm_init(spapr, &local_err)) {
> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
> -                                          &local_err);
> +            xics_kvm =3D true;
>          }
> -        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> +        if (machine_kernel_irqchip_required(machine) && !xics_kvm) {
>              error_prepend(&local_err,
>                            "kernel_irqchip requested but unavailable: ");
>              goto error;
> @@ -114,12 +113,12 @@ static void spapr_irq_init_xics(sPAPRMachineState *=
spapr, int nr_irqs,
>          local_err =3D NULL;
>      }
> =20
> -    if (!spapr->ics) {
> +    if (!xics_kvm) {
>          xics_spapr_init(spapr);
> -        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
> -                                      &local_err);

As C=E9dric suggested, I think this would be nicer if xics_kvm_init()
and xics_spapr_init() were folded together with the KVM fallback
inside.

That can be a follow up patch, though,

Applied.

>      }
> =20
> +    spapr->ics =3D spapr_ics_create(spapr, nr_irqs, &local_err);
> +
>  error:
>      error_propagate(errp, local_err);
>  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1ppIqr1kl39GnwQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp85AACgkQbDjKyiDZ
s5J1uQ/8C6pGQW9ys6GxEQERwXSD8PpwnqsGd3oDMWXIg6RVxjEZKEkLf3pWyMxj
8pXDaai4pqMV7h1sLLD2JZXljcmJSfW/ZCz7gfDqd/KVOZpnR1DhglNYdAk9+ILx
+3vAjvTzZpVim2vSMVcKs42uwPzfL1PeGxPzPmQXJ98Y/73dXBINw24Ufolliqvn
tonWVlFkSTt7awyOnJhFoIrUlqPOp0a7iUFi73oQg3t2k74VGZf7RRY/G60oK/Rb
E3bm57aSiYRVLVfG0GxGfKmNNdzVybFopWygnsBNKJ9UVA2ha3fGnM1P726Y51ie
5hDo+yerxnHZ8D7L5WbGgn+NSSdxblEqJLH2hOOgiBpviYw+9+OqWc1XjKCyJQ+n
oR3X2zy1+UBQayET4OzPiFDD26onUxbz+FUdgJf0tNPJ1wpaRosOZtkKdKYQAQeO
t4GTlJZGXXFtqNVkiK7ChSXOTBrbahjXT4LKPFG6YWDONUK37+s0RHxVN6g8MFRb
/D7kLUklhwL540jCloYEHKUSOMtpPQSDYWQmBGALZVXpRHQDrAgx7cwYPgW9/hu+
iCNLcPpUF0nz0gR6Q+Bi0iGfHiocfEGet9y6XtQw3dBHYKgkGYyCVEULHuOXYR8B
dGXcTne4Fth1wCx3ldJZzMV/jA7tqJCLb95eDeBi2repAkYoCW8=
=Vmcq
-----END PGP SIGNATURE-----

--1ppIqr1kl39GnwQx--
