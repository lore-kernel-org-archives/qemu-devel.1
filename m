Received: from eggs.gnu.org ([2001:4830:134:3::10]:60858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egBOB-0006Yx-3W
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egBOA-0005Hb-9R
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:30:31 -0500
Date: Mon, 29 Jan 2018 16:30:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129153017.GH6141@localhost.localdomain>
References: <20180122144549.25318-1-vsementsov@virtuozzo.com>
	<20180125113724.GA28396@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20180125113724.GA28396@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] block-backend: fix double
 inc/dec inflight requests number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, den@openvz.org, mreitz@redhat.com, el13635@mail.ntua.gr


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.01.2018 um 12:37 hat Stefan Hajnoczi geschrieben:
> On Mon, Jan 22, 2018 at 05:45:49PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
> > Is it a bug or a feature? Why do we call inc/dec twice for read/write?
> > We don't do this for flush and discard..
>=20
> It's non-obvious and I asked Paolo the same question previously.
>=20
> > -    bdrv_inc_in_flight(bs);
> > -
> >      /* throttling disk I/O */
> >      if (blk->public.throttle_group_member.throttle_state) {
> >          throttle_group_co_io_limits_intercept(&blk->public.throttle_gr=
oup_member,
> >                  bytes, false);
> >      }
>=20
> ^^^ HINT HINT HINT ^^^
>=20
> > =20
> > -    ret =3D bdrv_co_preadv(blk->root, offset, bytes, qiov, flags);
> > -    bdrv_dec_in_flight(bs);
> > -    return ret;
> > +    return bdrv_co_preadv(blk->root, offset, bytes, qiov, flags);
>=20
> The problem is what happens if the request is throttled?
>=20
> Even throttled requests must be counted so that bdrv_drain() and friends
> work.
>=20
> It may be possible to eliminate this now that throttling is a BDS node.
> It used to be implemented as a completely separate API outside the BDS
> node graph.  Now there is a throttling node in the graph, so maybe we
> can stop taking the extra reference but some refactoring may be
> necessary.

The patches to use a throttling node even when the legacy options are
used have not been merged yet.

Kevin

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJabz4JAAoJEH8JsnLIjy/WnYUP/j8eNtMNJWYUuWUHuKyq2Ci8
0YXH/2851RJWy+FQKvwHC3JZPgXGNApv8F2rO5ubBSAi06CTta5j7sfsXWxL3/9P
9F8XX++Tu7MjCgD7Ak6sy9NPJwec/QczW0yT8Fb2Iw/2ApAtoIpS2T1TZTvfoVpN
mT1rSKT+siUYJHe73k3FzIxY5k4Tqc/+vfGaJZ1/HlzGTmhMWW8fbnUK0UxvTp1S
2PGtgW+Kg6O15psRuPun9bmj+j69RvHZ/8lYpDxHXKfrRP9Vaw3r/FcerJEcr4Nj
ICpuEybNlNpO4oyF/LMMpgv+8hoAnnar9+JYxgv1i+gF6bjKbADKeOeiI7c8T6VZ
UHvDn99lEmzQRxATnx7zO2bnhxt8kPjvE0Zzfzv8lFUhGJqD0l8e5NVH3l3XdL34
SUy5LqPpOSUPLAWulPfEVNLY0WC/o4Z8RBl9nUUO7uO6ufoLEEi6pR5jGhed4Klt
lHw8tWDfahzg5iT+6a1guAHBbL4FI6EXRoJWvVZnrW2YjphPCMJdQ450G7IF5YlK
1McPQNJFbC80jan1diJy6Z2rAP7xuoSTTpzdcFaVW/pFNYcI9RjVqlRrFZIi5Rxs
NCW3sesQv2WIWl9fxresjZFb/dxETjbszsVMIj3lfpFeLlhfeyRoX7TP2RgDPTfK
/C/uKCJgVv9VxLSNkTxz
=Rx1k
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
