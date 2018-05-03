Received: from eggs.gnu.org ([2001:4830:134:3::10]:50268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE3mg-0003WP-BL
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE3md-0001Lv-HE
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:50 -0400
Received: from ozlabs.org ([203.11.71.1]:36755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fE3mc-0001Ev-Qq
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:47 -0400
Date: Thu, 3 May 2018 12:08:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503020837.GG13229@umbus.fritz.box>
References: <20180417132317.6910-1-bala24@linux.vnet.ibm.com>
	<20180417132317.6910-2-bala24@linux.vnet.ibm.com>
	<20180418005550.GC2317@umbus.fritz.box>
	<20180418005726.GD2317@umbus.fritz.box>
	<20180418064641.GA12871@9.122.211.20>
	<20180418083632.GB2710@work-vm>
	<20180419044452.GA11708@9.122.211.20>
	<20180419114817.GM2317@umbus.fritz.box>
	<20180420185733.GG2533@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
Content-Disposition: inline
In-Reply-To: <20180420185733.GG2533@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Balamuruhan S <bala24@linux.vnet.ibm.com>, quintela@redhat.com, qemu-devel@nongnu.org


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 07:57:34PM +0100, Dr. David Alan Gilbert wrote:
> * David Gibson (david@gibson.dropbear.id.au) wrote:
>=20
> <snip>
>=20
> > So.  AFAICT the estimate of page dirty rate is based on the assumption
> > that page dirties are independent of each other - one page is as
> > likely to be dirtied as any other.  If we don't make that assumption,
> > I don't see how we can really have an estimate as a single number.
>=20
> I don't think that's entirely true; at the moment we're calculating
> it by looking at the number of bits that become set during a sync
> operation, and the time since the last time we did the same calculation.
> Multiple writes to that page in that period will only count it once.
> Since it only counts it once I don't think it quite meets that
> statement.  Except see the bit at the bottom.

Ah, good point.  I was assuming the dirty rate variable here
represented the "instantaneous" rate, but of course it doesn't.  Rather
it's a "deduplicated" rate over one iteration.  Of course that
iteration time could vary which might make one iterations value not
quite comparable to another's.

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
> I don't think it needs to be a working set - it can be gently scribbling
> all over ram at a low rate and still satisfy the termination; but
> yes

Not really.  If we assume we're scribbling all ram then if dirty-rate
< bandwidth, we'll eventually catch up to being a single page behind -
in which case we can make the downtime as small as we want down to
pagesize/bandwidth.  If dirty-rate > bandwidth, then we
lose ground on every iteration and we won't be able to migrate with
any downtime less than ramsize/bandwidth.

If dirty-rate =3D=3D bandwidth, to within the noise on both those
parameters, then the downtime we need to migrate will essentially
random walk based on that noise, so I don't think we can make any
meaningful estimate of it.

I think the only case where "expected downtime" is a meaningful and
useful value is where we have some sort of working set.  The working
set in this case being defined by the fact that the dirty rate within
it is > bandwidth, but the dirty rate outside it is < bandwidth.

> if what you're trying to do is estimate the working set it makes sense.
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
>=20
> It's complicated a bit by the fact we redo the calculations when we
> limit the bandwidth, so it's not always calculated at the end of a full
> dirty sync set.
> But I do wonder about whether using this value after a few iterations
> makes sense - when as you say it's settling into a working set.
>=20
> > An estimate that would get closer, quicker would be (ram dirtied in
> > interval) / bandwidth.  Where (ram dirtied in interval) is a measure
> > of total ram dirtied over some measurement interval - only counting a
> > page once if its dirtied multiple times during the interval.  And
> > obviously you'd want some sort of averaging on that.  I think that
> > would be a bit of a pain to measure, though.
>=20
> If you look at the code in ram.c it has:
>=20
>     /* more than 1 second =3D 1000 millisecons */
>     if (end_time > rs->time_last_bitmap_sync + 1000) {
>         /* calculate period counters */
>         ram_counters.dirty_pages_rate =3D rs->num_dirty_pages_period * 10=
00
>             / (end_time - rs->time_last_bitmap_sync);
>=20
>=20
>   what I think that means is that, when we get stuck near the end with
> lots of iterations, we do get some averaging over short iterations.
> But the iterations that are long, does it need any averaging - that
> depends whether you think 'one second' is over the period you want to
> average over.

So, thinking over this further, I don't think having the same (wall
clock time) duration for each interval is as important as I previously
did.  I think working on the basis of iterations is ok - at least
apart from the wrinkle you mention of bandwidth alterations causing a
short iteration.

Let's define an "interval" as being a single pass over all of guest
RAM, transmitting the pages dirtied since the last interval.  IIUC
that will correspond to the current iteration, with the exception of
that wrinkle.

In the very first interval, all RAM is dirty, and I think we should
just decline to provide any downtime estimate at all.

On subsequent iterations, I think the total RAM dirtied in the last
interval is a fair to middling estimate of that working set size.
Consider: if the guest is in a steady state with a really strict
working set - e.g. it is cyclically dirtying everything in that set
and *nothing* outside it, then that ram-dirtied-in-interval will
accurately measure that working set on just the second interval.
Realistically, of course, there will be some accesses outside that
working set, so the second-interval value will be an overestimate
because we've had all the time of sending the first pass of RAM to
dirty pages outside the working set.  Still, I think it's probably
about the best we'll be able to do easily.  It should approach a
decent estimate of the working set size reasonably quickly on
subsequent iterations - assuming there is one, anyway.  If it's a true
converging migration it will just shrink gradually down to a single
page, and we're likely to hit our downtime target and stop caring long
before that.

In practice, to handle spikes & noise a bit better, I'd suggest that
we have our "working set" estimate as a weighted average of the
previous estimate and the ram dirtied in the last interval.  That's
equivalent to a weighted average of all the interval observations.  Or
we can use the Jacobson/Karels algorithm which makes an estimate of
variance as well, which might be nice.


Thinking about this yet more, and a bit more formally, it occurs to me
the model I'm using for how the guest dirties RAM is this:
    * Assume RAM is partitioned into a bunch of pieces P1..Pn (not
      necessarily contiguous, and not known to the host)
    * For each piece we have a different (instantaneous) dirty rate
      r1..rn
    * We assume that dirties _within a single piece_ are randomly /
      evenly scattered

What we're looking for is essentially the total size of the pieces we
need to *exclude* to get the total dirty rate below the bandwidth.

It shouldn't be too hard, and might be interesting, to make a test
exerciser based on that model.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqbyIACgkQbDjKyiDZ
s5J55xAAnGFPYv0tzT/VFb1icS/KdDh5HIs5sCz9LF2jPXKCpS7/lG+9FtnO1I7e
EOUtmt0I/AwpwEZYOXcIFSMjm950ARZnI7H6R/viZgz7FjsQlSJc2pTzO3Syuqtb
71QQTzZCKvS4f+/V5cSrRFEEeZ8dLcxD2KEL8x+L8drIYp+dKYV/FfFkJ4feo7l8
TFBdrKDE5A4QXicOM48Sf0h0NsRpwlUiJNH2TVstzvynFmWdWTiplIwksQSr/nJX
gdb8SrEu+b+rI6uZ60fBLXRyBCtOxax8U9neoRQkDC6KDwT99/LJjVnkIkdwX/Rr
NgEYp3FAJv0IfeQjRmf0+Td9f2ub2yC387nI38HL5dr2LlYaLn8MCrTKgxKuZa11
QaJiIQG5iNeKeugziJQi663pNtqf+SMkrpXw18jV2ZTjUXejkZTGj1kLIPuM4U+t
UbpU2SPXa9S5KKhgMBy5e8wvl6pB6CGF6SebDGVANc9kVRbECOqQmsTuculG/fAY
B5lYdWJn0Ad8C0d2adTeWrAcxFAULvq35HIRMmRGBWOD7oCxvk/HFh248dPPdYp4
/NHTvIo0mUDe+yi8kdUU0XQRV2S2LjlaFpcyJfCKxPMK3GV96v3dai7BRZ/nk+BD
P3PlHw6mmuLr/7rrG8xtlF0nOglampcpKOWP7hyn1Gbjo1cULqU=
=iB+D
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--
