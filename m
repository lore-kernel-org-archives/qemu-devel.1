Received: from eggs.gnu.org ([2001:4830:134:3::10]:57754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTAZ9-00028C-Dx
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTAZ8-0001M3-5C
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:27:47 -0400
Date: Thu, 6 Jul 2017 19:27:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706172730.GP5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-21-eblake@redhat.com>
	<20170706164820.GN5975@noname.redhat.com>
	<f3709c9e-8d99-b40e-a2a5-0299f151a40c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <f3709c9e-8d99-b40e-a2a5-0299f151a40c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 20/21] block: Minimize raw use of
 bds->total_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.07.2017 um 19:03 hat Eric Blake geschrieben:
> On 07/06/2017 11:48 AM, Kevin Wolf wrote:
> > Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> >> bdrv_is_allocated_above() was relying on intermediate->total_sectors,
> >> which is a field that can have stale contents depending on the value
> >> of intermediate->has_variable_length.  An audit shows that we are safe
> >> (we were first calling through bdrv_co_get_block_status() which in
> >> turn calls bdrv_nb_sectors() and therefore just refreshed the current
> >> length), but it's nicer to favor our accessor functions to avoid having
> >> to repeat such an audit, even if it means refresh_total_sectors() is
> >> called more frequently.
> >>
> >> @@ -1969,13 +1970,14 @@ int bdrv_is_allocated_above(BlockDriverState *=
top,
> >>
> >>          /*
> >>           * [sector_num, nb_sectors] is unallocated on top but interme=
diate
> >> -         * might have
> >> -         *
> >> -         * [sector_num+x, nr_sectors] allocated.
> >> +         * might have [sector_num+x, nb_sectors-x] allocated.
> >>           */
> >=20
> > I tried to figure out what this comment wants to tell us, and neither
> > the original version nor your changed one seemed to make a lot of sense
> > to me.
>=20
> The original one was definitely weird. I'm fine with bike-shedding on my
> replacement (including deleting the comment altogether).
>=20
> > The only case that I can see that actually needs the following
> > block is a case like this:
> >=20
> >     (. =3D unallocated, # =3D allocated)
> >=20
> >     top             ....####
> >     intermediate    ........
> >=20
> > Our initial request was for 8 sectors, but when going to the
> > intermediate node, we need to reduce this to 4 sectors, otherwise we
> > would return unallocated for sectors 5 to 8 even though they are
> > allocated in top.
> >=20
> > That's kind of the opposite of what the comment says, though...
>=20
> I think the comment was trying to worry about:
>=20
>     top             ........
>     intermediate    ....####
>=20
> then our first query says we have 8 sectors unallocated, but we can't
> return 8 unless we also check 8 sectors of the intermediate image
> (because the intermediate image may have sectors 4-7 allocated).  So it
> is explaining why the for loop is continuing down the backing chain.

Oh, that might be it. It just looked weird because it was directly above
the code that reduces n, so I thought it was related to that. (It looks
even more like that in the original commit c8c3080f.)

Maybe add "so we have to look at the next backing file" or something to
make the context clearer?

Of course, the exact values still aren't correct. [sector_num,
psectors_inter] is the unallocated part in top, and the allocated area
in the intermediate image can start anywhere, including at sector_num,
and have any length <=3D nb_sectors - x.

> If we ever get an answer of allocated, we can return immediately; we
> only have to keep looking (on potentially smaller prefixes) as long as
> we have an answer of unallocated and more backing chain to still check.
>=20
> On the other hand, there's this situation:
>=20
> top           ....####
> intermediate  ####....
>=20
> Right now (whether or not you apply my patch), the code only returns a
> pnum of 4 sectors allocated (the first query on top sees 4 unallocated,
> the second query on intermediate sees 4 allocated).  But in reality, we
> COULD return a pnum of 8 (between the two images being queries, we can
> account for an allocation of 8 sectors), although doing so requires
> additional bookkeeping and calls into the drivers (get_status(top, 0, 8)
> returns pnum of 4, get_status(intermediate, 0, 4) returns pnum of 4,
> then get_status(top, 4, 4) returns pnum of 4, so that the overall
> is_allocated(top, intermediate, 0, 8) sets pnum of 8).  Maybe it's worth
> doing, but not in the same series that converts to byte-based.

Callers will generally loop anyway, so it's probably useless overhead to
check the first non-matching block twice.

Kevin

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZXnMCAAoJEH8JsnLIjy/W/T0QAK0feageOYtLXIjcsEcsza7w
mGbxGbhbZ3fO8cwhpf/5XCnRqj8q+hi3Y/vXjJ1p9FxRMteBzQxBCXgevy7QyU4j
MeDF/0XjD0eEW46p2zkH9TWsKLrs6mAobG2b/+pRo7WnNJgztciZRycc8lThNkDG
yhnY5iAReMgFiHEW69bvFu5gbbhSmHKpYSAj0azkjHSkhiagyxVR702tyHFElBp3
0KLivgbVYfzZX+QuihKMxL7DN1YvYFcLqgwQtHYT+6LewlE2yVDT1OsfHpoxACHH
l48G7/BC8x1wyPmrpvKRrYtYmSJ5Drel9ZOsMLE1dZ20H0h2Mptga75NtFkrKB5c
egENwckDSkJEPrrD9M/9dmP6lClGa3tpMphx46ojkHz0VD/hzcScE7sUhha1OMk3
Q5K5A7C4llLxwrGTAjbMztItfjhBGlGQ772SP22D3e1CnNaGU4xzwoUXMqw6nXV+
mMkTI6Fc1tUwGmarlrBR0Itl6Gfa/8p8PNneRr2PyAqsXT7hPajVvqC/SaTwolWc
O9hDz4Oq7Aw8rtb1jMTcUGKZTJNIM9tfZs7vpilkoUQKPk26VIZe1bjgbuFZOV8/
vrmLaIkS6q9iklfAudyGdgVi24m8g6OBkosqCTuklmHEZ7ni+SaIn/OiNVJ5r8Sa
LYKEs3QgrJiDoCQRWaa/
=3cvo
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
