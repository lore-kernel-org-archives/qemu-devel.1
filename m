Received: from eggs.gnu.org ([2001:4830:134:3::10]:44952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCjDf-0007ek-Ez
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCjDc-0002Iz-BD
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:01:39 -0400
Date: Mon, 22 May 2017 19:00:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170522090055.GN30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518993198.24289.7946457258780782948.stgit@bahia.lan>
	<20170520064509.GD30246@umbus.fritz.box>
	<20170521190333.49404422@bahia.lan>
	<87lgpp2v9f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BjavXC7V3ilNTWHC"
Content-Disposition: inline
In-Reply-To: <87lgpp2v9f.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] spapr: fix error reporting in
 xics_system_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, Cedric Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--BjavXC7V3ilNTWHC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 09:41:48AM +0200, Markus Armbruster wrote:
> Greg Kurz <groug@kaod.org> writes:
>=20
> > On Sat, 20 May 2017 16:45:09 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> >> On Fri, May 19, 2017 at 12:32:12PM +0200, Greg Kurz wrote:
> >> > If the user explicitely asked for kernel-irqchip support and "xics-k=
vm"
> >> > initialization fails, we shouldn't fallback to emulated "xics" as we
> >> > do now. It is also awkward to print an error message when we have an
> >> > errp pointer argument.
> >> >=20
> >> > Let's use the errp argument to report the error and let the caller d=
ecide.
> >> > This simplifies the code as we don't need a local Error * here.
> >> >=20
> >> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >>=20
> >> Concept looks good, but..
> >>=20
> >> > ---
> >> > v2: - total rewrite
> >> > ---
> >> >  hw/ppc/spapr.c |   13 ++++++-------
> >> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >> >=20
> >> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> > index 91f7434861a8..75e298b4c6be 100644
> >> > --- a/hw/ppc/spapr.c
> >> > +++ b/hw/ppc/spapr.c
> >> > @@ -128,18 +128,14 @@ static void xics_system_init(MachineState *mac=
hine, int nr_irqs, Error **errp)
> >> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> >> > =20
> >> >      if (kvm_enabled()) {
> >> > -        Error *err =3D NULL;
> >> > -
> >> >          if (machine_kernel_irqchip_allowed(machine) &&
> >> >              !xics_kvm_init(spapr, errp)) {
> >> >              spapr->icp_type =3D TYPE_KVM_ICP;
> >> > -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr=
_irqs, &err);
> >> > +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr=
_irqs, errp); =20
> >>=20
> >> I believe there are reasons you're not supposed to just pass an errp
> >> through to a subordinate function.  Instead you're supposed to have a
> >> local Error * and use error_propagate().
> >>=20
> >
> > You only need to have a local Error * if it is used to check the return=
 status
> > of the function (ie, you cannot check *errp because errp could be NULL)=
 as
> > described in error.h.
>=20
> Correct.  Quote:
>=20
>  * Receive an error and pass it on to the caller:
>  *     Error *err =3D NULL;
>  *     foo(arg, &err);
>  *     if (err) {
>  *         handle the error...
>  *         error_propagate(errp, err);
>  *     }
>  * where Error **errp is a parameter, by convention the last one.
>  *
>  * Do *not* "optimize" this to
>  *     foo(arg, errp);
>  *     if (*errp) { // WRONG!
>  *         handle the error...
>  *     }
>  * because errp may be NULL!
>  *
>  * But when all you do with the error is pass it on, please use
>  *     foo(arg, errp);
>  * for readability.

So, I already merged based on Greg's comment, but it's nice to have
confirmation; thanks Markus.


> >                       This isn't the case here but...
> >
> >> >          }
> >> >          if (machine_kernel_irqchip_required(machine) && !spapr->ics=
) {
> >> > -            error_reportf_err(err,
> >> > -                              "kernel_irqchip requested but unavail=
able: ");
> >> > -        } else {
> >> > -            error_free(err);
> >> > +            error_prepend(errp, "kernel_irqchip requested but unava=
ilable: ");
> >> > +            return;
> >> >          }
> >> >      }
> >> > =20
> >> > @@ -147,6 +143,9 @@ static void xics_system_init(MachineState *machi=
ne, int nr_irqs, Error **errp)
> >> >          xics_spapr_init(spapr);
> >> >          spapr->icp_type =3D TYPE_ICP;
> >> >          spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_=
irqs, errp);
> >> > +        if (!spapr->ics) { =20
> >>=20
> >> It would also be more standard to check the returned error, rather
> >> than the other result.
> >>=20
> >
> > ... if you prefer to use a local Error *, I'll gladly do that. :)
>=20
> Opinions and practice vary on this one.
>=20
> I prefer checking the return value because it lets me avoid the
> error_propagate() boiler-plate more often.

Noted for future reference.

> Having both an Error parameter and an error return value begs the
> question whether the two agree.

[Irrelevant aside: this is not what "begging the question" means.  Or
 at least, it's not what it used to mean; it's probably a lost cause
 at this point, even with those who don't get a free pass for being
 non-native speakers.  https://en.wikipedia.org/wiki/Begging_the_question]
=20
> You can assert they do, but it's distracting.  We generally don't.
>=20
> When there's no success value to transmit, you avoid the problem by
> making the function return void.  We used to favor that, but it has
> turned out not to be a success, because it leads to cumbersome code.
> For what it's worth, GLib wants you to transmit success / failure in the
> return value, too:
>=20
> https://developer.gnome.org/glib/unstable/glib-Error-Reporting.html#gerro=
r-rules

Also noted, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BjavXC7V3ilNTWHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIqjEAAoJEGw4ysog2bOSZ48QAIJfVZRqvjsjSrWBWPrWPnV+
m/rKltfSuDviHpGNwkEbu8MMEm8c+xjLHWGb2lptlRZhtwfP3tomoOBQatRFYb7Z
Nt5q8rD5W4FqrUwPoe0NSttULY56pa0QfYoep9b7y2EkIDMKnGTYT/KGoNa+41QE
wzMk/cZpE6VYnHxz1VO6wSRHay4gDXs0ie2P4D/3OJpXYsHqiKlKPiQtMr563RCA
Rju3rupNDV/oCVUoedmsnDKU36vQeMyf8MdM1HsK4Yqi+rZrv0Z6rkxVLzuFSu1y
3VWDA1gt8UeY3aueh7u71l/Ma8dLq/3coZsFuMXvaJHD+pGdV1Rq+RtA1kGx+fgD
g1Tj3TOsvEQQz5xaANnyhOuoM62C2WNtx7pWZJr8qUoJzNnvSWND0Kvih7/UHfKN
cdNJEfPRDDC+da5j1w31s3P2KnMmDkGovpFnmPKA3jgyVxlXl8cJyh+vdKltSRjN
X2o2ULj+CSPTOXrSBBzz2lN+57s1ZsF2WSlmwa9mneEOvJUG7wsfMT3D0U3DNG2K
iQlS6xoQTABo4SoFex+GJ7k5pHDKin25cZzUPzaTfmdtgpbaD6R/IYqai8zpSNWb
BxUEUjrwzRlPAi5uNvpuRmGxYZji3dNVcvdk5T261nSygJCIOS28vFHQBwXYOllW
OCrDSVFBWGwkyODyR/bE
=DKEK
-----END PGP SIGNATURE-----

--BjavXC7V3ilNTWHC--
