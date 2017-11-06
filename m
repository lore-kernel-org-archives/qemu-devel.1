Received: from eggs.gnu.org ([2001:4830:134:3::10]:50773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eBmhq-0003HQ-3I
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eBmhj-0001ZL-UN
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:05:10 -0500
Date: Tue, 7 Nov 2017 06:04:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171106190455.GA12514@umbus.fritz.box>
References: <150789430473.4410.10317971414202753256.stgit@bahia.lan>
	<20171014093337.GG28032@umbus.fritz.box>
	<20171016102638.6977381f@nial.brq.redhat.com>
	<20171017061609.GL2776@umbus.fritz.box>
	<20171106160307.215d3cbd@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20171106160307.215d3cbd@bahia>
Subject: Re: [Qemu-devel] [PATCH] spapr_cpu_core: instantiate CPUs separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 04:03:07PM +0100, Greg Kurz wrote:
> On Tue, 17 Oct 2017 17:16:09 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Oct 16, 2017 at 10:26:38AM +0200, Igor Mammedov wrote:
> > > On Sat, 14 Oct 2017 20:33:37 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Fri, Oct 13, 2017 at 01:31:44PM +0200, Greg Kurz wrote: =20
> > > > > The current code assumes that only the CPU core object holds a
> > > > > reference on each individual CPU object, and happily frees their
> > > > > allocated memory when the core is unrealized. This is dangerous
> > > > > as some other code can legitimely keep a pointer to a CPU if it
> > > > > calls object_ref(), but it would end up with a dangling pointer.
> > > > >=20
> > > > > Let's allocate all CPUs with object_new() and let QOM frees them
> > > > > when their reference count reaches zero. This greatly simplify the
> > > > > code as we don't have to fiddle with the instance size anymore.
> > > > >=20
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>   =20
> > > >=20
> > > > So, I'm pretty sure my first drafts of the core stuff did things th=
is
> > > > waym and it got nacked, for QOM lifetime reasons that I never really
> > > > understood. =20
> > > From what I remember, Andreas would like to see composite CPU object
> > > allocated in one go and then its children initialized with object_ini=
tialize()
> > > so that no more allocation were needed. =20
> >=20
> > Ah, ok.
> >=20
> > > That potentially would benefit hotplug, since we could gracefully
> > > fail object creation early if there is not enough memory. =20
> >=20
> > Yeah, it sounds nice, but I don't see how we can do it.  In order to
> > do that the core object has to have enough space for all the threads,
> > which means we need both the size of each thread object and the number
> > of them.  The size we have (and will be easier to handle after Igor's
> > cleanups).  The number, we don't.
> >=20
> > > But the way it's implemented currently doesn't really match that init=
ial
> > > goal as array for threads is dynamically allocated later
> > > and then we need to dance around it with pointer arithmetic.
> > >=20
> > > BTW: almost any allocation failure in qemu currently
> > > is fatal so whether we fail on array alloc or on individual
> > > object_new() won't make any difference.
> > >=20
> > > I'd rather see this clean up merged as it simplifies code
> > > in these case. =20
> >=20
> > Ok, works for me.
> >=20
>=20
> Since we're in soft freeze already, I guess this won't go to 2.11. Maybe =
it's
> time to create ppc-for-2.12 and apply it there ?

Yeah, sounds like a plan.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloAslUACgkQbDjKyiDZ
s5LVAg//RYPiiYmnMvbyddM/vixa5mR2kh7G/qZt7kQFjAZ4+/Kachh035ugTLRM
DRbjyBwWOhAy87srMpkaYbIzOmTotfoTMzu69mvCnI9tSFu/dLjCi+IABiLsc3yX
5HS5pQS6EI6txZ6W5Fb4Ycl2iEeybqX60F7VtM4GNtTzTAF7OmNLKORFIdr2Y9Fu
7y9vemLitkFTzoU7XL2hpn9/JTzBdDlDLXrasDzhNxrjDXae88rrJAC2L9mx5Dzb
mVXk4zd1pOwBrGV/atcd0aQiUKbXYVHhqKKpkRb6md/GxID0mMLJe1Oy46U1c3Ct
KkF5THs/TNxRukX84SVVYWVsIAnZSvHNNJN6ujEW43/DXGGGLCZALfahk2UloTgV
HjT3bG73dgOrMh8fXvv8EriW+eHrEM0MGY59p/NmIb0cot+OiT0OvXbjhP/J/nXU
MFblyeZQ5sTS3U9EdyL7frHKOmiUtQBXZca9M9ech9j01KfNS0BzKxq3EblXUUxU
I8Lpfwqus5dwg5Tp3iT4G1loNrOERtjqqe9uLspKkWFXRZngnLvHqN81eNjdvdfD
WIXdN7rFpnfla1LIHywz8Vye0eXpCTYkUOWT5bUhObhLQOd8yQOWC1Rq6ghswafn
HNedtZwc+uBbKnbp0BjS9QmM4mAfFA8R9xNzXJ8451bB5Zj0AJM=
=E0pl
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
