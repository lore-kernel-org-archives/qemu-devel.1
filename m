Received: from eggs.gnu.org ([208.118.235.92]:43665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gfN5z-0006KZ-V2
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gfN5w-0003sa-Uk
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:52:55 -0500
Date: Fri, 4 Jan 2019 16:25:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190104052538.GF2801@umbus.fritz.box>
References: <20190102055743.5052-1-clg@kaod.org>
	<20190102055743.5052-3-clg@kaod.org>
	<20190103035726.GR10853@umbus.fritz.box>
	<76f4f558-5e0d-52ee-5c99-c208d005f643@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <76f4f558-5e0d-52ee-5c99-c208d005f643@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 02/10] ppc/xive: introduce a XiveTCTX
 pointer under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 06:44:30PM +0100, C=E9dric Le Goater wrote:
> On 1/3/19 4:57 AM, David Gibson wrote:
> > On Wed, Jan 02, 2019 at 06:57:35AM +0100, C=E9dric Le Goater wrote:
> >> which will be used by the machine only when the XIVE interrupt mode is
> >> in use.
> >=20
> > I don't love the idea of putting a hook this specific into the
> > PowerPCCPU structure, though it might be the easiest path in the short
> > term.
> >=20
> > A couple of approaches: 1) revisit my changes to allow for a pointer
> > to machine-defined per-cpu data. =20
>=20
> ok but we still need two different presenters objects, one for each
> mode.
>=20
> > or 2) do we actually need a cpu to tctx pointer.
> >=20
> > Expanding on (2) - here you use the pointer to find the right TIMA
> > state to access,
>=20
> yes.=20
>=20
> > but that could also be handled by having different TIMA IO instances=20
> > and mapping those individually to cpu_as. =20
>=20
> It might work for QEMU but I am not sure how to implement the KVM=20
> backend with such a design. We only have a single ram ptr mapping=20
> for the machine in the KVM case.
>=20
> There are a couple of places where we need to loop on the XiveTCTX=20
> (presenter, KVM) and we use the QEMU CPU list and the cpu->tctx for=20
> that. One of the reasons we introduced the cpu->intc pointer some=20
> time ago was to get rid of the ICP array.=20
>=20
> I don't think we want to introduce a XiveTCTX array again.
>=20
> > On the interrupt delivery side I think a tctx to cpu link will suffice.=
 =20
>=20
> yes. that we already have. It is mostly used by KVM in fact.=20
>=20
> > For sPAPR there might be complications with translating cpu numbers in
> > hcalls to the right tctx.
>=20
> The XiveTCTX is not used by the hcalls. We are fine on that side.
>=20
>=20
> The double pointer solution is what I prefer today, but if you are=20
> uncomfortable with it, we can come back to the previous where I was=20
> allocating a XiveTCTX child under the CPU and switching the presenter=20
> objects at reset. The only issue remaining was the child unparenting=20
> in the unrealize() method.

Hm, yes, I see your point.  For now I'm applying patches 1-3, and hope
to clean it up later with a revised version of my machine specific
per-cpu patch when I get the chance.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwu7lEACgkQbDjKyiDZ
s5JIgxAAx9xZhnLCIi+PKFvqoc197aRaMo43Zrc2xStdXGeCEHRp6CoGoQ5vml/2
vhL7L1KKKIQd1ABJOe7DZpIYT91ovWN/OnsqrgJcyBCqx8vEmbbKdcp7t9jaCXBq
yrqZCxquBuLFsLUKFwWLQpSU008Itx7E0XjwHt8tt+xC19NxYtxuUaD9oak91jLq
yJeG1BZlZ29fbyT5kflsDKiu1z9qEFF8GJQM26I4rXWZd4SI/DJFQQZT+17rgwv/
IAHpdYDD7JmcBrBA2f/ERGcDjeW/3bkQShEjinyzk0Ag0s01S+Ya0CsoaoG4U6/v
/1rlH5a4ixA7srs/IsRNm7BwOhuJgos8iSVsBBweu3353Kct2fVsNhWE9iy553p0
vn4+iP6LJc7iJVVAK04OACF7Yvg1hrCFu8nae0gQpcySGW70o18dmfW28zjja09a
fdRZuQC+bn0muVeXBe4JnbtfoSShFSdzjwLjAo/O7DHfGRcu4QP487E3ktVY+wyP
BceOap1niQCVzZTWYwvc/xLVCPPhc1k2a5Sv2iPGcaAUZYJ5/nMXobR0/FlNwbw6
VMmk/qu7/+YI6ETT6W5JKeYAfA9/64+K2E12aw8Jqle3/FltwZJe6xpU9fZ9RDM7
/ouQw2G1C/FIPWUJZ6TMnXMIL2mF1d4e/FsTuytpntbY2mkQvWA=
=UmpT
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
