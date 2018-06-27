Received: from eggs.gnu.org ([2001:4830:134:3::10]:40580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXyLg-0006pd-2p
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 20:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXyLc-0007II-QH
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 20:30:16 -0400
Date: Wed, 27 Jun 2018 10:14:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180627001415.GE14434@umbus.fritz.box>
References: <20180625091718.18544-1-clg@kaod.org>
	<20180626152733.5050d9e3@bahia.lan>
	<120947ab-6846-aded-b946-59908ca8c4ae@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <120947ab-6846-aded-b946-59908ca8c4ae@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/5] rework the ICS classes
 inheritance tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 06:37:12PM +0200, C=E9dric Le Goater wrote:
1;5202;0c> On 06/26/2018 03:27 PM, Greg Kurz wrote:
> > On Mon, 25 Jun 2018 11:17:13 +0200
> > C=E9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> Hello,
> >>
> >=20
> > Hello,
> >=20
> > Sorry I didn't manage to look at this before it got merged :)
> >=20
> >> It makes the class hierarchy much cleaner and removes duplicated
> >> code. As we are touching the location of the objects states, migration
> >> compatibility was checked and the following tests were performed under
> >> KVM :
> >>
> >>   qemu-3.0 (pseries-3.0)   -> qemu-3.0  (pseries-3.0)   OK
> >>   qemu-3.0 (pseries-2.12)  -> qemu-2.12 (pseries-2.12)  OK
> >>   qemu-3.0 (pseries-2.11)  -> qemu-2.11 (pseries-2.11)  OK
> >>   qemu-3.0 (pseries-2.10)  -> qemu-2.10 (pseries-2.10)  OK
> >>   qemu-3.0 (pseries-2.9)   -> qemu-2.9  (pseries-2.9)   OK
> >>   qemu-3.0 (pseries-2.8)   -> qemu-2.8  (pseries-2.8)   OK
> >>   qemu-3.0 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
> >=20
> > What's the failure ?
>=20
> qemu-system-ppc64: error while loading state for instance 0x0 of device '=
cpu'
> qemu-system-ppc64: load of migration failed: Invalid argument
>=20
> and to be more precise :
>=20
>    qemu-3.0  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>    qemu-2.12 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>    qemu-2.11 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>    qemu-2.10 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>    qemu-2.9  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>    qemu-2.8  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>    qemu-2.7  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   OK
>=20
>=20
> So it has been a while.

Yeah, IIRC that's a known problem.  If you try 2.7.1, I think it will work.

>=20
> C.=20
>=20
>=20
> >=20
> >>
> >> and back :
> >>
> >>   qemu-3.0 (pseries-3.0)  <-  qemu-3.0  (pseries-3.0)   OK
> >>   qemu-3.0 (pseries-2.12) <-  qemu-2.12 (pseries-2.12)  OK
> >>   qemu-3.0 (pseries-2.11) <-  qemu-2.11 (pseries-2.11)  OK
> >>   qemu-3.0 (pseries-2.10) <-  qemu-2.10 (pseries-2.10)  OK
> >>   qemu-3.0 (pseries-2.9)  <-  qemu-2.9  (pseries-2.9)   OK
> >>   qemu-3.0 (pseries-2.8)  <-  qemu-2.8  (pseries-2.8)   OK
> >>   qemu-3.0 (pseries-2.7)  <-  qemu-2.7  (pseries-2.7)   OK
> >>
> >> under TCG, same scenarios were run but up to 2.10 only, in which case
> >> the migration fails for other reasons.
> >>
> >> I wouldn't mind some extra cross checking from someone else.
> >>
> >> Thanks,
> >>
> >> C.
> >>
> >> Changes since v2:
> >>
> >>  - split the patch in smaller units. The migration tests were not
> >>    rerun because the code is very much the same. make check was run on
> >>    each patch.
> >>
> >>
> >> C=E9dric Le Goater (5):
> >>   ppc/xics: introduce a parent_realize in ICSStateClass
> >>   ppc/xics: move the instance_init handler under the ics-base class
> >>   ppx/xics: introduce a parent_reset in ICSStateClass
> >>   ppc/xics: move the vmstate structures under the ics-base class
> >>   ppc/xics: rework the ICS classes inheritance tree
> >>
> >>  include/hw/ppc/xics.h |   4 +-
> >>  hw/intc/xics.c        | 164 ++++++++++++++++++++++++++++-------------=
---------
> >>  hw/intc/xics_kvm.c    |  46 +++++++-------
> >>  hw/ppc/spapr.c        |   2 +-
> >>  4 files changed, 121 insertions(+), 95 deletions(-)
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsy1tQACgkQbDjKyiDZ
s5JE3w/+MLSgfaj1R7EnqOi421rWlH50CJGvOCFTnwAxE1G0boV82syxOdMQfChZ
62S5r3Sv58uy57krMx5gsMJcB7SDda7foupU16a1S4SXVwMQ+lfB62bRbtCgIrVp
uBhjmuvYtOUh9aEhLhxtGv9yN8iEYegcI0dr0TbuMGm+Uydk/HRTD4J/u2Kv171l
gTiUmyJ+TwaZCLV0C9yE7oBR1ekkLwUbHmpShPLIIriE8ydBCyoa7wygWVjLz6+X
NRXQQqZaLoeOITZ922pLo+gvGTqQEy0ukcRbN9JBq70NQynJLrmN5cpfnJCvzm3Z
e7gScooTMbgVk2EuQTSy+r1L81oFzVr5xhwMVjM2Hvc11kY7uqpCjFtDEUrOWSbx
GPFVUHFizjk0YcTGfpG2EAtjtGDvTppuNF/Z0Ul7vjqbpGkkH7qahfN9wyYdKcz8
Tk8C/O2PSVhqnX3Mul0eF2I9EzcUR8jITcf6N7s6Vk8QSqcujRITeqPf66UZE6U+
hWY2Wj2e5cxDCM2sdRy6Hld1nLNuSBXpQr2j/w1UcOFGOttoD0K8tEUh3GC5uaLg
f2xqVl9u1+QhG4LMyueVI7FaY2WRLE57jUDyX5161rdjMVVIx7ih1FD+zV+syw8x
BAQ8+Wwtk6rUaiGosXvRuhQgrbXl45eGzzg2GezLAj5hL9K1WxM=
=cU2g
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
