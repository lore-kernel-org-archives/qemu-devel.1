Received: from eggs.gnu.org ([2001:4830:134:3::10]:39125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxix7-0000He-6D
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 20:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxix6-00013x-11
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 20:14:49 -0400
Date: Thu, 28 Sep 2017 23:20:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170928132002.GG6445@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-8-clg@kaod.org>
	<20170919025747.GM27153@umbus>
	<771e897f-f304-3616-2e9c-e582f556b914@kaod.org>
	<1506587342.25626.26.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
In-Reply-To: <1506587342.25626.26.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 07/21] ppc/xive: add MMIO handlers
 for the XIVE interrupt sources
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
List-ID: <qemu-devel.nongnu.org>


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2017 at 10:29:02AM +0200, Benjamin Herrenschmidt wrote:
> On Wed, 2017-09-20 at 15:05 +0200, C=E9dric Le Goater wrote:
> > > > +/*
> > > > + * XIVE Interrupt Source MMIOs
> > > > + */
> > > > +static uint64_t spapr_xive_esb_read(void *opaque, hwaddr addr, uns=
igned size)
> > > > +{
> > > > +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
> > > > +    uint32_t offset =3D addr & 0xF00;
> > > > +    uint32_t srcno =3D addr >> xive->esb_shift;
> > > > +    XiveIVE *ive;
> > > > +    uint64_t ret =3D -1;
> > > > +
> > > > +    ive =3D spapr_xive_get_ive(xive, srcno);
> > > > +    if (!ive || !(ive->w & IVE_VALID))  {
> > > > +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", =
srcno);
> > > > +        goto out;
> > >=20
> > > Since there's a whole (4k) page for each source, I wonder if we should
> > > actually map each one as a separate MMIO region to allow us to tweak
> > > the mappings more flexibly
> >=20
> > yes we could have a subregion for each source. In that case,=20
> > we should also handle IVE_VALID properly. That will require=20
> > a specific XIVE allocator which was difficult to do while
> > keeping the compatibility with XICS for migration and CAS.
>=20
> That will be a serious bloat with lots of interrupts. We also cannot
> possibly have a KVM mm region per interrupt or even a vma.

Yeah.  I'd been thinking in terms of thousands of sources, which
wouldn't be too unreasonable in terms of separate regions.  With all
the IPIs sounds like it could be more in the hundres of thousands at
which point that would get very nasty.

So I agree, I think we want to keep it one region.

AIUI, how we do that shouldn't affect the guest, though.

> I'm thinking of some kind of /dev/xive (or some other KVM or irqfd
> orignated fd) that allows you to mmap a single big region whose content
> is demand-faulted and invalidated by the kernel to map the various
> interrupts.
>=20
> So that it looks like a single VMA (and KVM memory block).
>=20
> Ben.
>=20
> > C.
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnM9wIACgkQbDjKyiDZ
s5LqrhAA3MWbmhph6JsoGzDWrg951cYRZnFBPaCHpr8J6tzQZehRFnBz5rDpBYW5
om1ac4cKoclCJApEWXkmal1W4ns+NBMHi4bUulw6tw+age2hdhlgLfdwBGnfgXq7
F1DBR5x1yCBdNpSWcsaOIXtwf96Tc2RlLhHSLH40f0hKHm1kcGG2Tiv01gFcmqBg
PSVmINKOrENtuGHOqrc4TEKeg4JMnnRLJdtxNzNTSuCHAgirgyW5QbAxF03Jj1Pl
lrtqeLKaNq2sU8PS2L5zIpVVAvKHIQRAOt4ffrONZOs7hde9p8jey2rD718DY0fx
9/HyqjpJWNS0NKNYvZDkhVjTs0+NGN1av96f362oq0nkRVU24Bk+I5x93KejXUUa
dfUOaGu5BIGCjO2Annwdg/sY3VUTFUFVWH76aAcnD/PdEFTIqhFjS75y28zOr/qx
NVwfI2XP5bqqf79iIlRqoTENieOGS32Isl2857CVHhWpOGZ6zGCsgosRLQr2tRN6
yQ/fDd5/v7KQluxXlVYlku0ZitKqm946pTxsIlSnbiwS8lEFeR7tDZAS7XipSveD
P0LQNia3ZLbA2l8tSbKpMj4wTWDZVA2vn20A9oOvwa0ITMaRJ8+LvNkrY2FYu/8F
twxtBve38BN4RWqZHg1km5Yk/I/ikozEsKewS0qhbqinnxeUXwA=
=XyMz
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
