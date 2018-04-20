Received: from eggs.gnu.org ([2001:4830:134:3::10]:60748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9OtL-0000qz-3j
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 01:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9OtJ-0001wq-5L
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 01:47:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1f9OtI-0001tG-6S
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 01:47:25 -0400
Date: Fri, 20 Apr 2018 15:47:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420054712.GH2434@umbus.fritz.box>
References: <20180417132317.6910-1-bala24@linux.vnet.ibm.com>
	<20180417132317.6910-2-bala24@linux.vnet.ibm.com>
	<20180418005550.GC2317@umbus.fritz.box>
	<20180418005726.GD2317@umbus.fritz.box>
	<20180418064641.GA12871@9.122.211.20>
	<20180418083632.GB2710@work-vm>
	<20180419044452.GA11708@9.122.211.20>
	<20180419112404.GC2730@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3ecMC0kzqsE2ddMN"
Content-Disposition: inline
In-Reply-To: <20180419112404.GC2730@work-vm>
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


--3ecMC0kzqsE2ddMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 12:24:04PM +0100, Dr. David Alan Gilbert wrote:
> * Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> > On Wed, Apr 18, 2018 at 09:36:33AM +0100, Dr. David Alan Gilbert wrote:
> > > * Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> > > > On Wed, Apr 18, 2018 at 10:57:26AM +1000, David Gibson wrote:
> > > > > On Wed, Apr 18, 2018 at 10:55:50AM +1000, David Gibson wrote:
> > > > > > On Tue, Apr 17, 2018 at 06:53:17PM +0530, Balamuruhan S wrote:
> > > > > > > expected_downtime value is not accurate with dirty_pages_rate=
 * page_size,
> > > > > > > using ram_bytes_remaining would yeild it correct.
> > > > > >=20
> > > > > > This commit message hasn't been changed since v1, but the patch=
 is
> > > > > > doing something completely different.  I think most of the info=
 from
> > > > > > your cover letter needs to be in here.
> > > > > >=20
> > > > > > >=20
> > > > > > > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > > > > > > ---
> > > > > > >  migration/migration.c | 6 +++---
> > > > > > >  migration/migration.h | 1 +
> > > > > > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > > > > index 52a5092add..4d866bb920 100644
> > > > > > > --- a/migration/migration.c
> > > > > > > +++ b/migration/migration.c
> > > > > > > @@ -614,7 +614,7 @@ static void populate_ram_info(MigrationIn=
fo *info, MigrationState *s)
> > > > > > >      }
> > > > > > > =20
> > > > > > >      if (s->state !=3D MIGRATION_STATUS_COMPLETED) {
> > > > > > > -        info->ram->remaining =3D ram_bytes_remaining();
> > > > > > > +        info->ram->remaining =3D s->ram_bytes_remaining;
> > > > > > >          info->ram->dirty_pages_rate =3D ram_counters.dirty_p=
ages_rate;
> > > > > > >      }
> > > > > > >  }
> > > > > > > @@ -2227,6 +2227,7 @@ static void migration_update_counters(M=
igrationState *s,
> > > > > > >      transferred =3D qemu_ftell(s->to_dst_file) - s->iteratio=
n_initial_bytes;
> > > > > > >      time_spent =3D current_time - s->iteration_start_time;
> > > > > > >      bandwidth =3D (double)transferred / time_spent;
> > > > > > > +    s->ram_bytes_remaining =3D ram_bytes_remaining();
> > > > > > >      s->threshold_size =3D bandwidth * s->parameters.downtime=
_limit;
> > > > > > > =20
> > > > > > >      s->mbps =3D (((double) transferred * 8.0) /
> > > > > > > @@ -2237,8 +2238,7 @@ static void migration_update_counters(M=
igrationState *s,
> > > > > > >       * recalculate. 10000 is a small enough number for our p=
urposes
> > > > > > >       */
> > > > > > >      if (ram_counters.dirty_pages_rate && transferred > 10000=
) {
> > > > > > > -        s->expected_downtime =3D ram_counters.dirty_pages_ra=
te *
> > > > > > > -            qemu_target_page_size() / bandwidth;
> > > > > > > +        s->expected_downtime =3D s->ram_bytes_remaining / ba=
ndwidth;
> > > > > > >      }
> > > > >=20
> > > > > ..but more importantly, I still think this change is bogus.  expe=
cted
> > > > > downtime is not the same thing as remaining ram / bandwidth.
> > > >=20
> > > > I tested precopy migration of 16M HP backed P8 guest from P8 to 1G =
P9 host
> > > > and observed precopy migration was infinite with expected_downtime =
set as
> > > > downtime-limit.
> > >=20
> > > Did you debug why it was infinite? Which component of the calculation
> > > had gone wrong and why?
> > >=20
> > > > During the discussion for Bug RH1560562, Michael Roth quoted that
> > > >=20
> > > > One thing to note: in my testing I found that the "expected downtim=
e" value
> > > > seems inaccurate in this scenario. To find a max downtime that allo=
wed
> > > > migration to complete I had to divide "remaining ram" by "throughpu=
t" from
> > > > "info migrate" (after the initial pre-copy pass through ram, i.e. o=
nce
> > > > "dirty pages" value starts getting reported and we're just sending =
dirtied
> > > > pages).
> > > >=20
> > > > Later by trying it precopy migration could able to complete with th=
is
> > > > approach.
> > > >=20
> > > > adding Michael Roth in cc.
> > >=20
> > > We should try and _understand_ the rational for the change, not just =
go
> > > with it.  Now, remember that whatever we do is just an estimate and
> >=20
> > I have made the change based on my understanding,
> >=20
> > Currently the calculation is,
> >=20
> > expected_downtime =3D (dirty_pages_rate * qemu_target_page_size) / band=
width
> >=20
> > dirty_pages_rate =3D No of dirty pages / time =3D>  its unit (1 / secon=
ds)
> > qemu_target_page_size =3D> its unit (bytes)
> >=20
> > dirty_pages_rate * qemu_target_page_size =3D> bytes/seconds
> >=20
> > bandwidth =3D bytes transferred / time =3D> bytes/seconds
> >=20
> > dividing this would not be a measurement of time.
>=20
> OK, that argument makes sense to me about why it feels broken; but see
> below.
>=20
> > > there will be lots of cases where it's bad - so be careful what you're
> > > using it for - you definitely should NOT use the value in any automat=
ed
> > > system.
> >=20
> > I agree with it and I would not use it in automated system.
> >=20
> > > My problem with just using ram_bytes_remaining is that it doesn't take
> > > into account the rate at which the guest is changing RAM - which feels
> > > like it's the important measure for expected downtime.
> >=20
> > ram_bytes_remaining =3D ram_state->migration_dirty_pages * TARGET_PAGE_=
SIZE
> >=20
> > This means ram_bytes_remaining is proportional to guest changing RAM, so
> > we can consider this change would yield expected_downtime
>=20
> ram_bytes_remaining comes from the *current* number of dirty pages, so it
> tells you how much you have to transmit, but if the guest wasn't
> changing RAM, then that just tells you how much longer you have to keep
> going - not the amount of downtime required.  e.g. right at the start of
> migration you might have 16G of dirty-pages, but you don't need downtime
> to transmit them all.
>=20
> It's actually slightly different, because migration_update_counters is
> called in the main iteration loop after an iteration and I think that
> means it only ends up there either at the end of migration OR when
> qemu_file_rate_limit(f) causes ram_save_iterate to return to the main
> loop; so you've got the number of dirty pages when it's interrupted by
> rate limiting.
>=20
> So I don't think the use of ram_bytes_remaining is right either.
>=20
> What is the right answer?
> I'm not sure; but:
>=20
>    a) If the bandwidth is lower then you can see the downtime should be
> longer; so  having x/bandwidth  makes sense
>    b) If the guest is dirtying RAM faster then you can see the downtime
> should be longer;  so having  dirty_pages_rate on the top seems right.
>=20
> So you can kind of see where the calculation above comes from.
>=20
> I can't convince myself of any calculation that actually works!
>=20
> Lets imagine a setup with a guest dirtying memory at 'Dr' Bytes/s
> with the bandwidth (Bw), and we enter an iteration with
> 'Db' bytes dirty:
>=20
>   The time for that iteration is:
>      It   =3D Db / Bw
>=20
>   during that time we've dirtied 'Dr' more RAM, so at the end of
> it we have:
>      Db' =3D Dr * It
>          =3D Dr * Db
>            -------
>               Bw
>=20
> But then if you follow that, in any case where Dr < Bw that iterates
> down to Db' being ~0  irrespective of what that ration is - but that
> makes no sense.

So, as per our IRC discussion, this is pretty hard.

That said, I think Bala's proposed patch is better than what we have
now.  It will initially be a gross over-estimate, but for for
non-converging migrations it should approach a reasonable estimate
later on.  What we have now can never really be right.

So while it would be nice to have some better modelling of this long
term, in the short term I think it makes sense to apply Bala's patch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3ecMC0kzqsE2ddMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZfuAACgkQbDjKyiDZ
s5KBLA//S3gD72n4O5thiRKJTOVGjyg/2CDuablvpIzxQY8A8SwFXXBCc2xjWw+M
UO8LBQt6EEsXOxnJ2IWZlid/YREkaOLkiJ8cTNvk4xQ70Ww3yqtRwrcKL9mEbIwE
TBrZqgb0F7AayH1GKDYxviWtblIVhqWTutLtpaJ1g60kStXlP4f33AHQKWAZVPP5
UmNUn0olE1vJW1F1xgYV7mLrrfQXczQZ7L4zh5ucMUR5qWjuwLKpb0Cdd604NlDT
6s5zG2Cw/IMrWN/zR9pGRmgCPOs03Xg0mhiQMT1YtLD8eB+n4CXIHaDjUqJqKmrQ
Dpt3H7b5nnEDhXtDY5poYuWrZobu2endVe0M3lZ1gs3Y6IqhU8Nu00Zx4tEs23kN
lSKqdW9FyizjWIZwB6w+MuTLHyp1T1XmxOxigSZTRm3/M73e1TG+LoaPKKTuMTzk
EqFAGkXxWqxBr9aYdeHs3xxpisJU0MNpmyvhnlLLjBpjGpYXvfmIF46QrmfxhRBk
vQoDI5+wuzi1g+yGoanxIEK62hHhpIBmWpGB5lSsS9P/vWt/swSDUR6AzyEh7ozE
xO/kUisg1Ww7FbpnJiZfdaBpMlyBxpAbasumOfPWqMFue+Os1j66TCopvYLeAEK+
bLBaFYHwpxmIKUdfsyG5w3Wx6HPI1zhFii3ifzQjXdSofhde3Sk=
=W8zU
-----END PGP SIGNATURE-----

--3ecMC0kzqsE2ddMN--
