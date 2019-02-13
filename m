Received: from eggs.gnu.org ([209.51.188.92]:38524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3Qw-0005oy-N3
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3Qv-0008PP-Qg
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:55:14 -0500
References: <20181203175211.8230-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ad897e02-e1d3-5623-d829-55b2c3b98307@redhat.com>
Date: Wed, 13 Feb 2019 23:55:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181203175211.8230-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PoFWM37HT75Sg5Ce3bbVPd6tlVUDR1a1g"
Subject: Re: [Qemu-devel] [PATCH for-next 0/6] qemu-img: Add salvaging mode
 to convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PoFWM37HT75Sg5Ce3bbVPd6tlVUDR1a1g
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <ad897e02-e1d3-5623-d829-55b2c3b98307@redhat.com>
Subject: Re: [PATCH for-next 0/6] qemu-img: Add salvaging mode to convert
References: <20181203175211.8230-1-mreitz@redhat.com>
In-Reply-To: <20181203175211.8230-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Any opinions?

On 03.12.18 18:52, Max Reitz wrote:
> Hi,
>=20
> This series adds a --salvage option to qemu-img convert.  With this,
> qemu-img will not abort when it encounters an I/O error.  Instead, it
> tries to narrow it down and will treat the affected sectors as being
> completely 0 (and print a warning).
>=20
> Testing this is not so easy, because while real I/O errors during read
> operations should be treated as described above, errors encountered
> during bdrv_block_status() should just be ignored and the affected
> sectors should be considered allocated.  But blkdebug does not yet have=

> a way to intercept this, and:
>=20
> (1) Just adding a new block-status event would be silly, because I don'=
t
>     want an event, I want it to fail on a certain kind of operation, on=

>     a certain sector range, independently of any events, so why can't w=
e
>     just do that?  See patch 4.
>=20
> (2) If we just make blkdebug intercept .bdrv_co_block_status() like all=

>     other kinds of operations, at least iotest 041 fails, which does
>     exactly that silly thing: It uses the read_aio event to wait for an=
y
>     read.  But it turns out that there may be a bdrv_*block_status()
>     call in between, so suddenly the wrong operation yields an error.
>     As I said, the real fault here is that it does not really make sens=
e
>     to pray that the operation you want to fail is the one that is
>     immediately executed after some event that you hope will trigger
>     that operation.
>     See patch 3.
>=20
> So patch 3 allows blkdebug users to select which kind of I/O operation
> they actually want to make fail, and patch 4 allows them to not use any=

> event, but to have a rule active all the time.
>=20
> Together, we can then enable error injection for block-status in patch =
5
> and make use of event=3Dnone iotype=3Dblock-status in patch 6.
>=20
>=20
> Max Reitz (6):
>   qemu-img: Move quiet into ImgConvertState
>   qemu-img: Add salvaging mode to convert
>   blkdebug: Add @iotype error option
>   blkdebug: Add "none" event
>   blkdebug: Inject errors on .bdrv_co_block_status()
>   iotests: Test qemu-img convert --salvage
>=20
>  qapi/block-core.json       |  33 +++++++-
>  block/blkdebug.c           |  60 ++++++++++++--
>  qemu-img.c                 |  97 ++++++++++++++++------
>  qemu-img-cmds.hx           |   4 +-
>  qemu-img.texi              |   5 ++
>  tests/qemu-iotests/236     | 164 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/236.out |  43 ++++++++++
>  tests/qemu-iotests/group   |   1 +
>  8 files changed, 370 insertions(+), 37 deletions(-)
>  create mode 100755 tests/qemu-iotests/236
>  create mode 100644 tests/qemu-iotests/236.out
>=20



--PoFWM37HT75Sg5Ce3bbVPd6tlVUDR1a1g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxkoEsACgkQ9AfbAGHV
z0Afzgf/floD+HosMbfwmdy5YDsTwZxwg7VDAyZ4yDypPbjxD5Vv3OIe5mQ21VQM
OSpx+ePflXV72hfTZPnmnSHe34GiXlWIwdn1uaFik1rVxIf8Y2VDjBV6Xcbi+n2y
UcjdO++pXW7KM4t55toP6Zp27Amp+ylGFpd5e9TfFomBYlsFwl1X7BTNJtKOjYzl
NtRr1hObI/oF+8p91zcpatft7WPbNQxf1wB7mFWpdew6X+pGRy052SLPiVKBpn8r
z/ZzyUWTf2bSvizqIvGNm6efN+o4NQDTsdErqP7a+cRJK9GUIqZi4If0bLRwzkfP
+RkjX4Cn1RrFiMerCkTlh6ELtVFLcQ==
=tkhx
-----END PGP SIGNATURE-----

--PoFWM37HT75Sg5Ce3bbVPd6tlVUDR1a1g--
