Received: from eggs.gnu.org ([2001:4830:134:3::10]:50073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE3mC-0003E2-TA
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE3m9-0000Ro-NF
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:20 -0400
Received: from ozlabs.org ([203.11.71.1]:40895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fE3m8-0000Os-VE
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:17 -0400
Date: Thu, 3 May 2018 12:14:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503021442.GH13229@umbus.fritz.box>
References: <20180417132317.6910-1-bala24@linux.vnet.ibm.com>
	<20180417132317.6910-2-bala24@linux.vnet.ibm.com>
	<20180418005550.GC2317@umbus.fritz.box>
	<20180418005726.GD2317@umbus.fritz.box>
	<20180418064641.GA12871@9.122.211.20>
	<20180418083632.GB2710@work-vm>
	<20180419044452.GA11708@9.122.211.20>
	<20180419114817.GM2317@umbus.fritz.box>
	<20180421191249.GA775@9.122.211.20>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline
In-Reply-To: <20180421191249.GA775@9.122.211.20>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] migration: calculate
 expected_downtime with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@redhat.com, qemu-devel@nongnu.org


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 22, 2018 at 12:42:49AM +0530, Balamuruhan S wrote:
> On Thu, Apr 19, 2018 at 09:48:17PM +1000, David Gibson wrote:
> > On Thu, Apr 19, 2018 at 10:14:52AM +0530, Balamuruhan S wrote:
> > > On Wed, Apr 18, 2018 at 09:36:33AM +0100, Dr. David Alan Gilbert wrot=
e:
> > > > * Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
[snip]
> > That said, I thought a bunch about this a bunch, and I think there is
> > a case to be made for it - although it's a lot more subtle than what's
> > been suggested so far.
> >=20
> > So.  AFAICT the estimate of page dirty rate is based on the assumption
> > that page dirties are independent of each other - one page is as
> > likely to be dirtied as any other.  If we don't make that assumption,
> > I don't see how we can really have an estimate as a single number.
> >=20
> > But if that's the assumption, then predicting downtime based on it is
> > futile: if the dirty rate is less than bandwidth, we can wait long
> > enough and make the downtime as small as we want.  If the dirty rate
> > is higher than bandwidth, then we don't converge and no downtime short
> > of (ram size / bandwidth) will be sufficient.
> >=20
> > The only way a predicted downtime makes any sense is if we assume that
> > although the "instantaneous" dirty rate is high, the pages being
> > dirtied are within a working set that's substantially smaller than the
> > full RAM size.  In that case the expected down time becomes (working
> > set size / bandwidth).
>=20
> Thank you Dave and David for such a nice explanation and for your time.
>=20
> I thought about it after the explanation given by you and Dave, so in
> expected downtime we are trying to predict downtime based on some
> values at that instant, so we need to use that value and integrate it.

No, not really.  The problem is that as you accumulate dirties over a
longer interval, you'll get more duplicate dirties, which means you'll
get a lower effective value than simply integrating the results over
shorter intervals.

> 1. we are currently using bandwidth but actually I think we have to use
> rate of change of bandwidth, because bandwidth is not constant always.

Again, not really.  It's true that bandwidth isn't necessarily
constant, but in most cases it will be pretty close.  The real noise
here is coming in the dirty rate.

> 2. we are using dirty_pages_rate and as Dave suggested,
>=20
> when we enter an iteration with 'Db' bytes dirty we should be
> considering ['Db' + Dr * iteration time of previous one], where for the f=
irst
> iteration, iteration time of previous would be 0.
>=20
> 3. As you have said, that ram_bytes_remaining / bandwidth is the time to
> transfer all RAM, so this should be the limit for our integration. when
> we calculate for any instant it would be 0 to ram_bytes_remaining /
> bandwidth at that instant.
>=20
> Regards,
> Bala
>=20
> >=20
> > Predicting downtime as (ram_bytes_remaining / bandwidth) is
> > essentially always wrong early in the migration, although it will be a
> > poor upper bound - it will basically give you the time to transfer all
> > RAM.
> >=20
> > For a nicely converging migration it will also be wrong (but an upper
> > bound) until it isn't: it will gradually decrease until it dips below
> > the requested downtime threshold, at which point the migration
> > completes.
> >=20
> > For a diverging migration with a working set, as discussed above,
> > ram_bytes_remaining will eventually converge on (roughly) the size of
> > that working set - it won't dip (much) below that, because we can't
> > keep up with the dirties within that working set.  At that point this
> > does become a reasonable estimate of the necessary downtime in order
> > to get the migration to complete, which I believe is the point of the
> > value.
> >=20
> > So the question is: for the purposes of this value, is a gross
> > overestimate that gradually approaches a reasonable value good enough?
> >=20
> > An estimate that would get closer, quicker would be (ram dirtied in
> > interval) / bandwidth.  Where (ram dirtied in interval) is a measure
> > of total ram dirtied over some measurement interval - only counting a
> > page once if its dirtied multiple times during the interval.  And
> > obviously you'd want some sort of averaging on that.  I think that
> > would be a bit of a pain to measure, though.
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqcJIACgkQbDjKyiDZ
s5J2oBAA2SdE2I6wrTLl/rYS4QdfWSJlqttRSPBMaBl7EE39mIgmVnhjUwWNRo4r
AqnHM+/6GfhkKVO+HyB2VUcg/TbelK82bjMLtD9SD92oN7HCDBzI3Plrb8jS1AGK
AFFVUq/EH7D+6ZwqTTppuqvKbFD0TJsj7RPNC0vchY2so2eQjyIl8TVFSnN8m/gX
Rqjd7H4TyO3WpbS6w4MNmv8qZRmH3yBNjFNYQKw7jzyLVERTkWdcMZ0an5UgSuTj
YCLHaPyRDfD4zaVnr8ceG8ThKbu6VMRhJOsfjw9VR08Ep1xNN0qV85ZSj2dMtxDA
g/C9Nqao/dUOH2pRpxMxqU/mZ3CYw22xKqAkWHYRfLFhYlKBJHpWUXw6jgLyLJQH
oeL+WbVFy3Fdlmfw+qDIArzjLyQpxK8hpXMBaKqtUSYlUgDEqEe+f/9IkD+CHzss
WL5hbh0fjniihdpB4c3sA1aCdVaFZmZygP1rX1+byOT4JqA1I3PHe5xy4KnchJjV
yV7zJiduXmiEIB776HaCQB43Pzr1LcaVzpBrGjv4LPy6t/YkZcqtzYcWBVE1u8DZ
ofUItnTYW4INEd9UdnuomF8q/uXUhL/OsuVPI4Oo1LisUpovbRY5sog8+6pGagPD
vtwwg+nKcKf1hdhQs05gqCddeyBjhLKcD1AqdTWoF00oAFUC1F4=
=vaaI
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
