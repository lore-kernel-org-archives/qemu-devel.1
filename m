Received: from eggs.gnu.org ([2001:4830:134:3::10]:33927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEojX-0007tx-BD
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEojV-0006Se-Tl
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:23:43 -0400
Date: Sat, 5 May 2018 14:23:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180505042321.GI13229@umbus.fritz.box>
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
	<20180504113724.64b7b1c0@bahia.lan>
	<152543629398.15508.17426624020859105239@sif>
	<20180504155028.75f1ad45@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZcSASNCKFtrdv99s"
Content-Disposition: inline
In-Reply-To: <20180504155028.75f1ad45@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: only save guest
 timebase once after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org


--ZcSASNCKFtrdv99s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 03:50:28PM +0200, Greg Kurz wrote:
> On Fri, 04 May 2018 07:18:13 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>=20
> > Quoting Greg Kurz (2018-05-04 04:37:24)
> > > On Thu,  3 May 2018 23:20:44 -0500
> > > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > >  =20
> > > > In some cases (e.g. spapr) we record guest timebase after qmp_stop()
> > > > via a runstate hook so we can restore it on qmp_cont(). If a migrat=
ion
> > > > occurs in between those events we end up saving it again, this time
> > > > based on the current timebase the guest would be seeing had it been
> > > > running. This has the effect of advancing the guest timebase while
> > > > it is stopped, which is not what the code intends.
> > > >  =20
> > >=20
> > > Hi Mike,
> > >=20
> > > The current behavior was introduced by:
> > >=20
> > > commit 42043e4f1241eeb77f87f5816b5cf0b6e9583ed7
> > > Author: Laurent Vivier <lvivier@redhat.com>
> > > Date:   Fri Jan 27 13:24:58 2017 +0100
> > >=20
> > >     spapr: clock should count only if vm is running
> > >=20
> > > and we have this in the changelog:
> > >=20
> > >     We keep timebase_pre_save to reduce the clock difference on
> > >     migration like in:
> > >         6053a86 kvmclock: reduce kvmclock difference on migration
> > >=20
> > >=20
> > > So your patch totally negates ^^ ? Also, I can't see a case where =20
> >=20
> > Yah... this is a bit confusing. On one hand, the patch/summary is clear=
ly
> > trying to avoid the guest time from advancing while it is stopped, which
> > is in the spirit of this patch. But at the same time it is trying to
> > compensate for loss of time (relative to host) due to downtime window.
> >=20
>=20
> Yeah... not sure why Laurent decided to address both in the same patch...
> maybe just because we already had the pre_save hook ?
>=20
> > I think the subtlety is in the amount of time... saving at pre_save
> > rather than vm_stop() compensates for the normal downtime window, which
> > is *usually* small (5s is the figure they quote in the notes there and
> > in the motivating 6053a86 "kvmclock: reduce kvmclock difference on
> > migration"). The delays between vm_stop and vm_cont via something like
> > virsh suspend/resume is unbounded, unhowever, hence the rationale for
> > the runstate hook (?).
> >=20
>=20
> That's my understanding as well.
>=20
> > So maybe small jumps are considered okay, and large ones not? If that's
> > the reasoning, then this patch is addressing the later, so it's not
> > necessarily in conflict with that motivation, but the implementation
> > does negate the small jumps we try to avoid via pre_save hook since
> > we'll end up keep the version we saved just after vm_stop instead.
> >=20
> > I would note that the downtime window itself, while usually small, can
> > also be quite large. With 1GB hugepages we've seen some guests requiring
> > downtime windows to be set to 25s until QEMU would start cut-over. Also
> > rcu_cpu_stall_timeout is configurable...it's possible if we set it to
> > 5s it could trigger on the jump the guest experiences from pre_save (I
> > haven't tested that though).
> >=20
> > Maybe trying to compensate for downtime is a generally bad idea and we
> > should just leave it up to NTP/etc?=20
>=20
> My understanding of NTP is that it isn't designed to cope with sudden
> time differences, which is exactly what happens in our case.

I think so too.  I mean it will correct things right eventually,
unless the jump is *really* huge, but it's not a good enough solution
that we shouldn't at least try to keep the guest's wall-time clock
correct across the migration.

> > Or maybe we should choose a specific
> > upper bound on how much migration downtime we're willing to compensate
> > for and enforce that directly? E.g. tb->saved becomes tb->saved_time and
> > we check the difference in pre_save before calling timebase_save()
> > again.
> >=20
>=20
> This would maybe allow to reach a compromise between the current code
> and your patch... but it would still be difficult to come up with
> a sensible value for this upper bound, wouldn't it ?
>=20
> > > So your patch totally negates ^^ ? Also, I can't see a case where
> > > timebase_save() could be called from vmstate_save_state() while the
> > > VM is running, ie, you could drop timebase_pre_save()... or am I
> > > *probably* missing something ? =20
> >=20
> > Yah, I didn't notice that my patch completely negated the pre_save
> > hook... for some reason I was thinking that would continue to function
> > normally if we didn't call qmp_stop() explicitly but that's clearly not
> > the case. So yah, dropping timebase_pre_save() is essentially what my
> > patch is doing...
> >=20
>=20
> <thinking aloud>
> How does Linux cope with standard software suspend or hibernate ? It also
> causes a downtime and it doesn't generate RCU stalls AFAIK... would it
> be possible/make sense for migration to look like an hibernate ?
> </thinking aloud>

In that case the guest is aware of the stoppage, and knows to a)
correct its internal clock afterwards (usually by looking at the RTC),
and b) not see the sudden clock jump as an error.

By design, guests are not aware of a migration, so they can't do that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZcSASNCKFtrdv99s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrtMbkACgkQbDjKyiDZ
s5JUvg/+KrRtlgiEusagssVVtHyXtRAYIRL5tyiQ+EzIsNImhn6otMq3uZx1QE6m
x/HLNguU0mxuwSQTwdQ/Fwtm3xudGKYYH5FhSeB0cfnY/OdO0PxkgpVS3oERQKpj
/tZrXXugQnLKJ8HX41v+RflKvCdTskCiE6zEdnqOXnF1CoMzwa85azV5jOg3oeH7
WNABkDyq50Rh7RL57ytJidlZbHKDRbxSV/hWHUL51W4DzQyqxRSKRr0QGLWVwbL1
DqbKxWg0HTEL7w7mQOD7fW0uL5Tea32gE/FOvf4rLhdBtNt3QjLCC1mTPhcddPIQ
Bjd8ksFT2u3bb2sQUVTy1DsPfjTrz/bdAl95RXkXnZQ8PScdBtrvTNVmU47ptZ/0
0HrZB7myHLp1EIeHBOLw0iXzaV+261006u1g6qbGP1tCaSCJE6hxVQZ/pDOgg7hr
jZWXACEZeFfEZJNJ61OcgQj5Me1VVq8YNEX1HqFoXhmyhjFdQue1c653wEMrBAw0
1V9UO98JyWsipJ3OC0UMOIqhyTqaYI1RGdb5voGBTUhT4BkxtiOmLiTAql41M1sr
0UkDqUnytsNbqd7TYwU1sidwuHyGychwUx9fzHesiHmCXHwxifBrAZOp3ZJfAXst
9NxtoBloqhX/WS3OIiiCYW3exwngkMhBad7SzOTI5nmpAyM4vPo=
=sPx/
-----END PGP SIGNATURE-----

--ZcSASNCKFtrdv99s--
