Received: from eggs.gnu.org ([2001:4830:134:3::10]:53805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eefqW-0005y0-BY
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eefqS-0007va-4I
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:37:32 -0500
Date: Thu, 25 Jan 2018 11:37:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180125113724.GA28396@stefanha-x1.localdomain>
References: <20180122144549.25318-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180122144549.25318-1-vsementsov@virtuozzo.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, den@openvz.org, mreitz@redhat.com


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 05:45:49PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Is it a bug or a feature? Why do we call inc/dec twice for read/write?
> We don't do this for flush and discard..

It's non-obvious and I asked Paolo the same question previously.

> -    bdrv_inc_in_flight(bs);
> -
>      /* throttling disk I/O */
>      if (blk->public.throttle_group_member.throttle_state) {
>          throttle_group_co_io_limits_intercept(&blk->public.throttle_grou=
p_member,
>                  bytes, false);
>      }

^^^ HINT HINT HINT ^^^

> =20
> -    ret =3D bdrv_co_preadv(blk->root, offset, bytes, qiov, flags);
> -    bdrv_dec_in_flight(bs);
> -    return ret;
> +    return bdrv_co_preadv(blk->root, offset, bytes, qiov, flags);

The problem is what happens if the request is throttled?

Even throttled requests must be counted so that bdrv_drain() and friends
work.

It may be possible to eliminate this now that throttling is a BDS node.
It used to be implemented as a completely separate API outside the BDS
node graph.  Now there is a throttling node in the graph, so maybe we
can stop taking the extra reference but some refactoring may be
necessary.

Stefan

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaacF0AAoJEJykq7OBq3PIQa0H/jhQnlN72V/4UcrY+uGKOIJ0
wz+sXZKM7DXJwysh8Cc3ilTNiWDvGq+HaiEDGvHk40x9SlATQv0naed6vCuHLIvR
g6Qmn3AHOy7HO/LuC18BXti40iBY+aW7YuR3a0UGpBegr7xXJpXg5Qa3hu9jiEbe
0RPtsd+cA17o1oy2rKMrs5NbnO93LuFbdqAIW3pO+r2bAY6dUdH1zEWOn3q3/CWu
3Y2ImPbU0+uFxd82L0L8S5kvSqMkGTmbOm/52JbjhYtvsjyMtbrHpoxvg+RPY4+w
shsxijBd+bRf6dRrouUk9blcjaIaifoTQZnZvtUos4yF92RQ/cM4W40o10Z0O4E=
=nKyd
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
