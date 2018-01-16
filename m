Received: from eggs.gnu.org ([2001:4830:134:3::10]:39632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebRVK-0006Ul-Ih
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebRVE-0008KP-KJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:42:18 -0500
Date: Tue, 16 Jan 2018 23:24:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116122432.GJ30352@umbus.fritz.box>
References: <20180116044714.12571-1-david@gibson.dropbear.id.au>
	<20180116044714.12571-2-david@gibson.dropbear.id.au>
	<20180116102018.382fd035@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline
In-Reply-To: <20180116102018.382fd035@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: joserz@linux.vnet.ibm.com, surajjs@au1.ibm.com, sam.bobroff@au1.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 10:20:18AM +0100, Greg Kurz wrote:
> On Tue, 16 Jan 2018 15:47:13 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
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
>=20
> I could check the following on a POWER9 host:
>=20
> $ ./ppc64-softmmu/qemu-system-ppc64 -accel kvm -smp threads=3D1
> qemu-system-ppc64: warning: Failed to set KVM's VSMT mode to 8 (errno -22)
>=20
> and the guest boots.
>=20
> $ ./ppc64-softmmu/qemu-system-ppc64 -accel kvm -smp threads=3D2
> qemu-system-ppc64: Failed to set KVM's VSMT mode to 8 (errno -22)
> On PPC, a VM with 2 threads/core on a host with 1 threads/core requires t=
he
>  use of VSMT mode 8.
> This KVM seems to be too old to support VSMT.
>=20
> and QEMU exits.

I assume the above is with an old kernel that doesn't have the ability
to set the SMT cap?

>=20
> Tested-by: Greg Kurz <groug@kaod.org>
>=20
> Just one minor remark below but anyway:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
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
> Inconsistent use of parens in the left and right operands of &&
>=20
> > +                warn_report_err(local_err);
> > +                local_err =3D NULL;
> > +                goto out;
> > +            } else {
> > +                if (!vsmt_user) {
> > +                    error_append_hint(&local_err,
> > +                                      "On PPC, a VM with %d threads/co=
re"
> > +                                      " on a host with %d threads/core"
> > +                                      " requires the use of VSMT mode =
%d.\n",
> > +                                      smp_threads, kvm_smt, spapr->vsm=
t);
> > +                }
> > +                kvmppc_hint_smt_possible(&local_err);
> > +                goto out;
> >              }
> > -            kvmppc_hint_smt_possible(&local_err);
> > -            goto out;
> >          }
> >      }
> >      /* else TCG: nothing to do currently */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpd7v4ACgkQbDjKyiDZ
s5I68xAAsq30VV2w46w5D6d2dYSlNQeuTbh9cpzCENOd09/Mh7S3dRKKC9ctKqWJ
41IcJswuX+pcdvPoAkZuAfGvbV5lNW9zXXg1JYITOUQMHuU1Azg4fAv1TVGq2A4n
TivDPAq2feg/imRY5zxXei/piuznHmNJ4zD6f+sjmBq53RFC9HANwLdZwteLl3Cu
6VwcdldsfRXj2aDKoIns94JDAJy1tLP6L+j0g+0O+60uVhBqEhGV0H6Iqf4C0NbD
2n6hKAjurvNcVNpwabDGa9xLieRXSZhK96KceGoNa5KKc1mG016cnKojn0xva3wZ
Zz1VebiLx3uNdwODOINEKkOTjhFwFDBrFqyl9LB1zSlYy2NJ7RZXFhdcBCmTli+G
pdI9YXeY4MeHhjfI/gKZCAfWlPsCs1CA4uuXj/9TqkUjdOXdLAyrHXs6AW7TSl1+
0fDpjQWqQh826rMmiZJv320XhYb/l9MmXXpoH08aTORSKbl7XGgaLm8y5c0QcD6o
zQeHFr3uiMHhhhaMlxssuKjlEKTIQ+DGX6Vc3EuCdZuf1mddNehGomWutFcbt0uI
ZRDG4PGIhoZjg9DD8XYGM4HjebCvEe4iWz7QdlW3528rSQ2FMaInw9LZf5qxapsQ
gPKRRcoUKSdTAyYz4PThtDRczcUBCHoVAVjCrwO86Y0ir1VWIFs=
=r4uB
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
