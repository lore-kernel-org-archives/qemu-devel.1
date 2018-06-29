Received: from eggs.gnu.org ([2001:4830:134:3::10]:39930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYv76-0000so-B6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYv75-0005Nc-2Z
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:15:08 -0400
Date: Fri, 29 Jun 2018 17:14:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629151455.GG15588@localhost.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-15-kwolf@redhat.com>
	<dd88cb0f-1b0e-ce65-7418-78a25d3b8855@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <dd88cb0f-1b0e-ce65-7418-78a25d3b8855@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/19] block: Defer .bdrv_drain_begin
 callback to polling phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 27.06.2018 um 16:30 hat Max Reitz geschrieben:
> On 2018-04-11 18:39, Kevin Wolf wrote:
> > We cannot allow aio_poll() in bdrv_drain_invoke(begin=3Dtrue) until we'=
re
> > done with propagating the drain through the graph and are doing the
> > single final BDRV_POLL_WHILE().
> >=20
> > Just schedule the coroutine with the callback and increase bs->in_flight
> > to make sure that the polling phase will wait for it.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/io.c | 28 +++++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
>=20
> According to bisect, this breaks blockdev-snapshot with QED:

I have no idea why it would trigger only with qed, but I think the real
bug is in commit dcf94a23b1 ('block: Don't poll in parent drain
callbacks').

The crash is specifically in the place where the new overlay needs to be
drained because it's new backing file is drained. First,
bdrv_drain_invoke() creates new activity on the overlay when it gets the
old active layer attached as a backing file:

#0  0x000055b90eb73b88 in bdrv_drain_invoke (bs=3D0x55b910fd8440, begin=3D<=
optimized out>) at block/io.c:217
#1  0x000055b90eb1e2b0 in bdrv_replace_child_noperm (child=3D0x55b911f32450=
, new_bs=3D<optimized out>) at block.c:2069
#2  0x000055b90eb20875 in bdrv_replace_child (child=3D<optimized out>, new_=
bs=3D0x55b910fd2130) at block.c:2098
#3  0x000055b90eb20c53 in bdrv_root_attach_child (child_bs=3Dchild_bs@entry=
=3D0x55b910fd2130, child_name=3Dchild_name@entry=3D0x55b90eda75e5 "backing"=
, child_role=3Dchild_role@entry=3D0x55b90f3d3300 <child_backing>, perm=3D0,=
 shared_perm=3D31, opaque=3Dopaque@entry=3D0x55b910fd8440, errp=3D0x7fffb89=
43620) at block.c:2141
#4  0x000055b90eb20d60 in bdrv_attach_child (parent_bs=3Dparent_bs@entry=3D=
0x55b910fd8440, child_bs=3Dchild_bs@entry=3D0x55b910fd2130, child_name=3Dch=
ild_name@entry=3D0x55b90eda75e5 "backing", child_role=3Dchild_role@entry=3D=
0x55b90f3d3300 <child_backing>, errp=3D0x7fffb8943620) at block.c:2162
#5  0x000055b90eb23c30 in bdrv_set_backing_hd (bs=3Dbs@entry=3D0x55b910fd84=
40, backing_hd=3Dbacking_hd@entry=3D0x55b910fd2130, errp=3Derrp@entry=3D0x7=
fffb8943620) at block.c:2249
#6  0x000055b90eb24a76 in bdrv_append (bs_new=3D0x55b910fd8440, bs_top=3D0x=
55b910fd2130, errp=3Derrp@entry=3D0x7fffb8943680) at block.c:3535
#7  0x000055b90e937a89 in external_snapshot_prepare (common=3D0x55b910f5cf9=
0, errp=3D0x7fffb89436f8) at blockdev.c:1680

And then, when trying to move all users of the old active layer to the
new overlay, it turns out that the bdrv_drain_invoke() BH hasn't been
executed yet:

#0  0x00007fdfcef5d9fb in raise () at /lib64/libc.so.6
#1  0x00007fdfcef5f800 in abort () at /lib64/libc.so.6
#2  0x00007fdfcef560da in __assert_fail_base () at /lib64/libc.so.6
#3  0x00007fdfcef56152 in  () at /lib64/libc.so.6
#4  0x000055b90eb24867 in bdrv_replace_node (from=3D<optimized out>, to=3D0=
x55b910fd8440, errp=3D0x7fffb8943620) at block.c:3470
#5  0x000055b90eb24abe in bdrv_append (bs_new=3D0x55b910fd8440, bs_top=3D0x=
55b910fd2130, errp=3Derrp@entry=3D0x7fffb8943680) at block.c:3541
#6  0x000055b90e937a89 in external_snapshot_prepare (common=3D0x55b910f5cf9=
0, errp=3D0x7fffb89436f8) at blockdev.c:1680

Not polling in bdrv_child_cb_drained_begin() is great if the original
drain is still polling, but if the original drain_begin has already
returned, we obviously do need to poll so we don't enter a drained
section while requests are still running.

Another thing I noticed is that qmp_transaction() only calls a one-time
bdrv_drain_all() instead of using a proper begin/end section. I suppose
this should be fixed as well.

Kevin

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbNkzvAAoJEH8JsnLIjy/WwPMP/2lIMWQKbxm/59GCBCyDVbLn
VaAf03GOIgwDjpcqdVkLer0B6E+XLi1d/oF4Bqf14oxx3hnc4gzNZHlAuN1cHf+n
GLT1ByXDwpZ4GTleuOz1oRi+79yknNbDbPKDBacA0Q2tOZjA4OcCoqp1Jc5GHXvi
y8AirxVW8xmWJVRSrTXU0GEvrrdma08lZ898G/vUr7HNW2/RFeqXlv9DWuU5i+yS
0GoIqOjWic0OJ1RrPpKa1UO4oyTaAbJZWP8jySW72xu7tbX0PQNXB+QskrDR9PfF
BE1epZK41hJnmvbpr2NHYZFpYwO6fflDNpZCtQyRZaY13M1+SMgM2miLePazdgTn
SPR2zfh3R4AIr5L/649nmxPFi02/8MrEQz5LIKc5h512/geRKxE+ZRP915KdVbil
cEjlfQATsDJLJR0lfVWzSfR2lrbSWYHCfVknP+lpHvVh+//NAIGF7T3n0YR6Q+R0
j0u9VPV9GOyiYTq7B8NzDyV0W7rVCPVb4olLGOK0NPuS++wfX1Pdmm8iQG5Yjx1Q
tiDGs3nXiiECBmceQBeq2p7L9jxZIqlhRjnGbufHvjg+6WmmhK5mSFsGO0S1JJDl
SZWGYlUefC1cT0vSzMDTjmXs7uHKM3hNvRym6WOtkSzgbz227ys6lL9aLVjuP/SD
Ex7JOnpVeQJsAj9TZ4Sw
=b6Dj
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
