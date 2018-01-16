Received: from eggs.gnu.org ([2001:4830:134:3::10]:39636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebRVL-0006VU-Cb
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebRVF-0008L5-Dz
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:42:19 -0500
Date: Wed, 17 Jan 2018 00:39:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116133946.GM30352@umbus.fritz.box>
References: <20180116044714.12571-1-david@gibson.dropbear.id.au>
	<20180116044714.12571-2-david@gibson.dropbear.id.au>
	<ab350665-cb32-72d3-a548-0572f5275775@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="37nyS7qXrnu4wN2o"
Content-Disposition: inline
In-Reply-To: <ab350665-cb32-72d3-a548-0572f5275775@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv2 1/2] spapr: Allow some cases where we
 can't set VSMT mode in the kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: groug@kaod.org, joserz@linux.vnet.ibm.com, surajjs@au1.ibm.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--37nyS7qXrnu4wN2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 11:34:52AM +0100, Laurent Vivier wrote:
> On 16/01/2018 05:47, David Gibson wrote:
> > At present if we require a vsmt mode that's not equal to the kernel's
> > default, and the kernel doesn't let us change it (e.g. because it's an =
old
> > kernel without support) then we always fail.
> >=20
> > But in fact we can cope with the kernel having a different vsmt as long=
 as
> >   a) it's >=3D the actual number of vthreads/vcore (so that guest threa=
ds
> >      that are supposed to be on the same core act like it)
> >   b) it's a submultiple of the requested vsmt mode (so that guest threa=
ds
> >      spaced by the vsmt value will act like they're on different cores)
> >=20
> > Allowing this case gives us a bit more freedom to adjust the vsmt behav=
iour
> > without breaking existing cases.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index e35214bfc3..6d3613d934 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2314,17 +2314,29 @@ static void spapr_set_vsmt_mode(sPAPRMachineSta=
te *spapr, Error **errp)
> >      if (kvm_enabled() && (spapr->vsmt !=3D kvm_smt)) {
> >          ret =3D kvmppc_set_smt_threads(spapr->vsmt);
> >          if (ret) {
> > +            /* Looks like KVM isn't able to change VSMT mode */
> >              error_setg(&local_err,
> >                         "Failed to set KVM's VSMT mode to %d (errno %d)=
",
> >                         spapr->vsmt, ret);
> > -            if (!vsmt_user) {
> > -                error_append_hint(&local_err, "On PPC, a VM with %d th=
reads/"
> > -                             "core on a host with %d threads/core requ=
ires "
> > -                             " the use of VSMT mode %d.\n",
> > -                             smp_threads, kvm_smt, spapr->vsmt);
> > +            /* We can live with that if the default one is big enough
> > +             * for the number of threads, and a submultiple of the one
> > +             * we want.  In this case we'll waste some vcpu ids, but
> > +             * behaviour will be correct */
> > +            if ((kvm_smt >=3D smp_threads) && (spapr->vsmt % kvm_smt) =
=3D=3D 0) {
>=20
> I agree with Greg: inconsistent use of parenthesis, should be
>=20
>     if (kvm_smt >=3D smp_threads && (spapr->vsmt % kvm_smt) =3D=3D 0) {

Corrected in my tree.

> Anyway:
>=20
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>=20
> Thanks,
> Laurent
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--37nyS7qXrnu4wN2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpeAKIACgkQbDjKyiDZ
s5JfTBAA5doUNBZ60eMSxOZRJqB7OxLUZEgMkhs0nf3uurBCZrHpqq9v0L2brx9p
Z5MafHVKlvzRRPNQjove4Vqkv669Pr0mT31dJnJjfHSylmqDsyAprzcvT6yu4A0T
vD8beV24wfIJpxW8/VAerJG3qfs8TtpraL2vhsdmJFO4t/bdsgoX3WdJeYtMl4z8
kiybTWS95mc46tOFct0d+CEFulLL/dt/vXtx0o2ju8pqe93vCsHsd6RjxQrvcNjP
whSv70TUio7bxiLWkaQaIXRORVJYk7+rCUmjat/oAd3a+WB0uXUgepr0l97Gwsv8
SJG92tekVokzIsgJeCUeWRJ7Df4LaZzVMPtDaJXDhXnMTWrCbBurLJrQk5Fqgxj2
IfkUaeCcQFz2UzbtAbdTowMJWKaeg3jzyRLvsbgCGZ1ArDyF4jxGcdLs0c9hZNGF
opwF4XssB+PVjgWl/YSwd+I3LTD3pVW0Ag2b/2WxCWmsW2g+opILoEGae/GBxCyE
gEO7+5Ctxex9r/EsgP9OmaJk8dctgNP5b3F+ILE9ZSu31borhEuzQj6bD0/RUDN4
z3zhvVtxb7IXNUs0WFWnZICXWfm3ovePejpuEWbqXAsqIaOZ+yNNq6FxI6F5boy9
1QJYvygeQP5m7ETMo/SdDJx6zmCxIBPhI7X4ZXe4RYJ5exFXT+M=
=deA8
-----END PGP SIGNATURE-----

--37nyS7qXrnu4wN2o--
