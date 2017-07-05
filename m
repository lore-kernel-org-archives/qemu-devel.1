Received: from eggs.gnu.org ([2001:4830:134:3::10]:40118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSkYa-00008T-GB
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSkYZ-00069G-EQ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:41:28 -0400
Date: Wed, 5 Jul 2017 15:41:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170705134116.GC5297@noname.redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-5-eblake@redhat.com>
	<20170704150057.GI4253@noname.str.redhat.com>
	<49ade40a-49d2-a888-3c01-041f416b01b2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <49ade40a-49d2-a888-3c01-041f416b01b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/20] stream: Switch stream_run() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.07.2017 um 14:13 hat Eric Blake geschrieben:
> On 07/04/2017 10:00 AM, Kevin Wolf wrote:
> > Am 27.06.2017 um 21:24 hat Eric Blake geschrieben:
> >> We are gradually converting to byte-based interfaces, as they are
> >> easier to reason about than sector-based.  Change the internal
> >> loop iteration of streaming to track by bytes instead of sectors
> >> (although we are still guaranteed that we iterate by steps that
> >> are sector-aligned).
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >> Reviewed-by: John Snow <jsnow@redhat.com>
> >>
> >> ---
> >> v2: no change
> >> ---
> >>  block/stream.c | 24 ++++++++++--------------
> >>  1 file changed, 10 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/block/stream.c b/block/stream.c
> >> index 746d525..2f9618b 100644
> >> --- a/block/stream.c
> >> +++ b/block/stream.c
> >> @@ -108,12 +108,11 @@ static void coroutine_fn stream_run(void *opaque)
> >>      BlockBackend *blk =3D s->common.blk;
> >>      BlockDriverState *bs =3D blk_bs(blk);
> >>      BlockDriverState *base =3D s->base;
> >> -    int64_t sector_num =3D 0;
> >> -    int64_t end =3D -1;
> >=20
> > Here, end was initialised to -1. This made a differnce for early 'goto
> > out' paths because otherwise data->reached_end would incorrectly be true
> > in stream_complete.
>=20
> Oh, good call.
>=20
> >=20
> > Because we also check data->ret, I think the only case where it actually
> > makes a difference is for the !bs->backing case: This used to result in
> > data->reached_end =3D=3D false, but now it ends up as true. This is bec=
ause
> > s->common.len hasn't been set yet, so it is still 0.
>=20
> When !bs->backing, ret is 0; so that means my commit message is wrong
> about there being no semantic change.  But remember, when !bs->backing,
> stream is a no-op (there was no backing file to stream into the current
> layer, anyways) - so which do we want, declaring that the operation
> never reached the end (odd, since we did nothing), or that it is
> complete?  In other words, is this something where I should fix the
> semantics (perhaps as a separate bug-fix patch), or where I need to fix
> this patch to preserve existing semantics?
>=20
> The next code reached is stream_complete().  Before my patch, it skipped
> the main body of the function (because !data->reached_end); with my
> patch, we are now calling bdrv_change_backing_file() (presumably a no-op
> when there is no backing?)

Effectively probably yes, but it involves another write+flush for
rewriting the qcow2 header (even though nothing is expected to change in
it).

But if we wanted to avoid this, I think we could just directly check
bs->backing in stream_complete(). So I wonder why data->reached_end even
exists in the first place.

Kevin

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZXOx8AAoJEH8JsnLIjy/Wg5sP/jzTPMCBAhUo/nuSxckyWTrR
PjD3o1pX3t1nox5Aew9aprEY7vY7EeUll+nopyprb6BiqTPWVQkdTP7rcfMan/Eu
TcRP8QmQ8f9/+nKSM0+UADgj3QaWTKgLE1WWUudfToQiFurNX/vq/TyJ/0Qmh2oo
oTqDiXzQ68hraFqLEQraSPnwNTfupo000Z1dLSAZ2QM9gLKmN8+fMc0+G4ljBUoz
O9GDk/XfzRNbEHpIzhYa4lliE5xemAXjyjHq2/FmHZ/aqzPZYuQHmY8LmQkWEknS
cmHEU1QYaE5CfJtFuBFnQWtYSfJzCnBa9yohbVUv50/rUYbbPANX1SeVWLl/n4iw
KHKT191GURYs4sMqtK4mtEizsq+aKOiSa/gDsYU9m2/5bk3vA3SR4BHQVthmshrr
cWiPRRbIq4COW+hLW5FwiSh5oUaiTiue41BrSJNn07M5y73sJXDBKQY+vY8OJaTG
MI/pp2wde1t8P4lh4ewtV1LZKAJTJ2tWWOjNQutPFpR9G13jJRn1ya6p/0Ge8Fci
YuQ7eS1t+RUasowB/xCN79/MNHDuxpZtimyo+PztFM/pNLthfgcDeJfQK6EysZ6O
Yk92gdadEQKlfFY3GEj3V07aGQjhgUOyKhr9ypGpIZRBbC7rhxOIxbHJZW+qh4Il
7NXZAjld3yrDG/7aKQZs
=3C67
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
