Received: from eggs.gnu.org ([2001:4830:134:3::10]:53852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f983G-0008Ln-Ga
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f983F-0003t6-1e
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:48:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1f983D-0003o2-Ma
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:48:32 -0400
Date: Thu, 19 Apr 2018 21:48:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180419114817.GM2317@umbus.fritz.box>
References: <20180417132317.6910-1-bala24@linux.vnet.ibm.com>
	<20180417132317.6910-2-bala24@linux.vnet.ibm.com>
	<20180418005550.GC2317@umbus.fritz.box>
	<20180418005726.GD2317@umbus.fritz.box>
	<20180418064641.GA12871@9.122.211.20>
	<20180418083632.GB2710@work-vm>
	<20180419044452.GA11708@9.122.211.20>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S66JdqtemGhvbcZP"
Content-Disposition: inline
In-Reply-To: <20180419044452.GA11708@9.122.211.20>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, amit.shah@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org


--S66JdqtemGhvbcZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 10:14:52AM +0530, Balamuruhan S wrote:
> On Wed, Apr 18, 2018 at 09:36:33AM +0100, Dr. David Alan Gilbert wrote:
> > * Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> > > On Wed, Apr 18, 2018 at 10:57:26AM +1000, David Gibson wrote:
> > > > On Wed, Apr 18, 2018 at 10:55:50AM +1000, David Gibson wrote:
> > > > > On Tue, Apr 17, 2018 at 06:53:17PM +0530, Balamuruhan S wrote:
> > > > > > expected_downtime value is not accurate with dirty_pages_rate *=
 page_size,
> > > > > > using ram_bytes_remaining would yeild it correct.
> > > > >=20
> > > > > This commit message hasn't been changed since v1, but the patch is
> > > > > doing something completely different.  I think most of the info f=
rom
> > > > > your cover letter needs to be in here.
> > > > >=20
> > > > > >=20
> > > > > > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > > > > > ---
> > > > > >  migration/migration.c | 6 +++---
> > > > > >  migration/migration.h | 1 +
> > > > > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > > > > >=20
> > > > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > > > index 52a5092add..4d866bb920 100644
> > > > > > --- a/migration/migration.c
> > > > > > +++ b/migration/migration.c
> > > > > > @@ -614,7 +614,7 @@ static void populate_ram_info(MigrationInfo=
 *info, MigrationState *s)
> > > > > >      }
> > > > > > =20
> > > > > >      if (s->state !=3D MIGRATION_STATUS_COMPLETED) {
> > > > > > -        info->ram->remaining =3D ram_bytes_remaining();
> > > > > > +        info->ram->remaining =3D s->ram_bytes_remaining;
> > > > > >          info->ram->dirty_pages_rate =3D ram_counters.dirty_pag=
es_rate;
> > > > > >      }
> > > > > >  }
> > > > > > @@ -2227,6 +2227,7 @@ static void migration_update_counters(Mig=
rationState *s,
> > > > > >      transferred =3D qemu_ftell(s->to_dst_file) - s->iteration_=
initial_bytes;
> > > > > >      time_spent =3D current_time - s->iteration_start_time;
> > > > > >      bandwidth =3D (double)transferred / time_spent;
> > > > > > +    s->ram_bytes_remaining =3D ram_bytes_remaining();
> > > > > >      s->threshold_size =3D bandwidth * s->parameters.downtime_l=
imit;
> > > > > > =20
> > > > > >      s->mbps =3D (((double) transferred * 8.0) /
> > > > > > @@ -2237,8 +2238,7 @@ static void migration_update_counters(Mig=
rationState *s,
> > > > > >       * recalculate. 10000 is a small enough number for our pur=
poses
> > > > > >       */
> > > > > >      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> > > > > > -        s->expected_downtime =3D ram_counters.dirty_pages_rate=
 *
> > > > > > -            qemu_target_page_size() / bandwidth;
> > > > > > +        s->expected_downtime =3D s->ram_bytes_remaining / band=
width;
> > > > > >      }
> > > >=20
> > > > ..but more importantly, I still think this change is bogus.  expect=
ed
> > > > downtime is not the same thing as remaining ram / bandwidth.
> > >=20
> > > I tested precopy migration of 16M HP backed P8 guest from P8 to 1G P9=
 host
> > > and observed precopy migration was infinite with expected_downtime se=
t as
> > > downtime-limit.
> >=20
> > Did you debug why it was infinite? Which component of the calculation
> > had gone wrong and why?
> >=20
> > > During the discussion for Bug RH1560562, Michael Roth quoted that
> > >=20
> > > One thing to note: in my testing I found that the "expected downtime"=
 value
> > > seems inaccurate in this scenario. To find a max downtime that allowed
> > > migration to complete I had to divide "remaining ram" by "throughput"=
 from
> > > "info migrate" (after the initial pre-copy pass through ram, i.e. once
> > > "dirty pages" value starts getting reported and we're just sending di=
rtied
> > > pages).
> > >=20
> > > Later by trying it precopy migration could able to complete with this
> > > approach.
> > >=20
> > > adding Michael Roth in cc.
> >=20
> > We should try and _understand_ the rational for the change, not just go
> > with it.  Now, remember that whatever we do is just an estimate and
>=20
> I have made the change based on my understanding,
>=20
> Currently the calculation is,
>=20
> expected_downtime =3D (dirty_pages_rate * qemu_target_page_size) / bandwi=
dth
>=20
> dirty_pages_rate =3D No of dirty pages / time =3D>  its unit (1 / seconds)
> qemu_target_page_size =3D> its unit (bytes)
>=20
> dirty_pages_rate * qemu_target_page_size =3D> bytes/seconds
>=20
> bandwidth =3D bytes transferred / time =3D> bytes/seconds
>=20
> dividing this would not be a measurement of time.

Hm, that's a good point, the units are not right here.  And thinking
about it more, it doesn't really make sense for it to be linear
either.  After all if the page dirty rate exceeds the bandwidth then
the expected downtime is infinite... well size of ram over bandwidth,
at least.

> > there will be lots of cases where it's bad - so be careful what you're
> > using it for - you definitely should NOT use the value in any automated
> > system.
>=20
> I agree with it and I would not use it in automated system.
>=20
> > My problem with just using ram_bytes_remaining is that it doesn't take
> > into account the rate at which the guest is changing RAM - which feels
> > like it's the important measure for expected downtime.
>=20
> ram_bytes_remaining =3D ram_state->migration_dirty_pages * TARGET_PAGE_SI=
ZE
>=20
> This means ram_bytes_remaining is proportional to guest changing RAM, so
> we can consider this change would yield expected_downtime

Well, just because the existing estimate is wrong doesn't mean this
one is right.  Having the right units is a necessary but not
sufficient condition.

That said, I thought a bunch about this a bunch, and I think there is
a case to be made for it - although it's a lot more subtle than what's
been suggested so far.

So.  AFAICT the estimate of page dirty rate is based on the assumption
that page dirties are independent of each other - one page is as
likely to be dirtied as any other.  If we don't make that assumption,
I don't see how we can really have an estimate as a single number.

But if that's the assumption, then predicting downtime based on it is
futile: if the dirty rate is less than bandwidth, we can wait long
enough and make the downtime as small as we want.  If the dirty rate
is higher than bandwidth, then we don't converge and no downtime short
of (ram size / bandwidth) will be sufficient.

The only way a predicted downtime makes any sense is if we assume that
although the "instantaneous" dirty rate is high, the pages being
dirtied are within a working set that's substantially smaller than the
full RAM size.  In that case the expected down time becomes (working
set size / bandwidth).

Predicting downtime as (ram_bytes_remaining / bandwidth) is
essentially always wrong early in the migration, although it will be a
poor upper bound - it will basically give you the time to transfer all
RAM.

For a nicely converging migration it will also be wrong (but an upper
bound) until it isn't: it will gradually decrease until it dips below
the requested downtime threshold, at which point the migration
completes.

For a diverging migration with a working set, as discussed above,
ram_bytes_remaining will eventually converge on (roughly) the size of
that working set - it won't dip (much) below that, because we can't
keep up with the dirties within that working set.  At that point this
does become a reasonable estimate of the necessary downtime in order
to get the migration to complete, which I believe is the point of the
value.

So the question is: for the purposes of this value, is a gross
overestimate that gradually approaches a reasonable value good enough?

An estimate that would get closer, quicker would be (ram dirtied in
interval) / bandwidth.  Where (ram dirtied in interval) is a measure
of total ram dirtied over some measurement interval - only counting a
page once if its dirtied multiple times during the interval.  And
obviously you'd want some sort of averaging on that.  I think that
would be a bit of a pain to measure, though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--S66JdqtemGhvbcZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrYgf4ACgkQbDjKyiDZ
s5K9fA/5AeJFDnIUmgPJXTTI7O/hswp5CHmWHN9swZ0AqBbb1KFxvBKXXocI5JE2
/gpNdg+H/SgQUXbZpb7G0aB2dX6qaH8SK9mvoZoE8WnwCN+GEd682w4QbPqyU3b6
GmHzDJa3S+88SMXSFTCDvO5SdszFGQUBrwJbPTGXn+yvxwixQO6PwhFSMV3GMvzt
Z88j2hKWWmW88/6T4qvvGufzKm8P2AGfM80g6x0LdYRge7LUqiuzgTHl0S+z1wCt
9LaQgkhrX68IEqXhib7Q+7e6pvanuyxJmTV+3hUsp6B3eIKQYt6rTozg2VhfU8nK
4lztV1xtF85D41F4gIICEtzs0SJc1yeI9aeJVgGnuh9Wm5YeydNS2JUOB5dH6EwH
cDMuX3ehRE5DXJQJPtewx5C5X2xDrhZSRQh6be4gQqpwdketr54oEgFevvjVPvYH
ResST30Aef3sj8eJKmepNDS4AdW+g9aOwvJz1S2UpqEZYOZN66K2fZnOw3yXciTi
FDYGpAa11mDowcU2ivdB6qho1HDUbMcvg7ofpLx0msvZHQPbi9/z7EQXpWWuPMNF
YvKXUdCiebQZEayHFmxP2Ttqz0s8lWCXa1bw9Rxa+lgVJC+ZeUEFK7ECElMPxDKN
CQAAj5GBwpt4oZl5DEBfRAkct0MGiQV5p2gvijHikCO4H1BlRCI=
=4M6F
-----END PGP SIGNATURE-----

--S66JdqtemGhvbcZP--
