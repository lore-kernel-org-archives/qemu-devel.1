Received: from eggs.gnu.org ([2001:4830:134:3::10]:46189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv0Y1-0003Hc-AH
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv0Xy-00078W-Vu
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:30:12 -0400
References: <20180809223117.7846-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6f7811d6-8317-e1ce-b00d-20068a48038e@redhat.com>
Date: Wed, 29 Aug 2018 15:29:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yepbMcWGAfvwWewclv9uvQCr8wxqRHPWI"
Subject: Re: [Qemu-devel] [PATCH v2 00/11] block: Deal with filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yepbMcWGAfvwWewclv9uvQCr8wxqRHPWI
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6f7811d6-8317-e1ce-b00d-20068a48038e@redhat.com>
Subject: Re: [PATCH v2 00/11] block: Deal with filters
References: <20180809223117.7846-1-mreitz@redhat.com>
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric inadvertently pointed me to the fact that qemu-img needs some
additional work.  Its get_block_status() should completely skip R/W
filters (just adding a "bs =3D bdrv_skip_rw_filters()" at the top of the
loop is enough -- in turn, I can probably drop the
bdrv_skip_implicit_filters() at the bottom), and I suspect the
bdrv_block_status() call in convert_iteration_sectors() should really be

  BlockDriverState *src_bs =3D blk_bs(s->src[src_cur]);
  bdrv_block_status_above(src_bs, bdrv_backing_chain_next(src_bs), ...);

Max


--yepbMcWGAfvwWewclv9uvQCr8wxqRHPWI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGn9cACgkQ9AfbAGHV
z0DY+wf/bu8PenMzVHsOg86uEjelkVtT0TZS7+BMneX8Eb9Rn0wPp82h/xhWLU9M
9sUgpFjU16PqZg9xNsyT+4M70qLZ+MTg95XC7VTWajZL+/CHub1vJk3WI7iKyG8z
Uil77vR9zUita1eYQwpld2iuQziuqBla+TZxhgdXiGZAZ/KCHWai39rAGxp6/ZS6
s8ygDTScyVL9uKdhT261w/Vy4MCTzXmWB/fUrO4wRDOpVJ7w1WBPjuS47706ACAa
dM6qOWRpKT5KWxJkNdWzuNbHLdTCtrIzgexeHWG1gqUyUh1SU7cya5KnC11dkWMz
tCQZ0itSEj56tVn//QE6WQiXXEM25Q==
=+JWE
-----END PGP SIGNATURE-----

--yepbMcWGAfvwWewclv9uvQCr8wxqRHPWI--
