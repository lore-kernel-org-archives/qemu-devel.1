Received: from eggs.gnu.org ([2001:4830:134:3::10]:55983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxz2e-0005qA-F1
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxz2d-0002PM-F0
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:25:36 -0400
References: <20170928120300.58164-1-vsementsov@virtuozzo.com>
	<20170929152255.5431-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <eb39b5cd-74c5-ffe5-7e1c-11cf7f6f2d46@redhat.com>
Date: Fri, 29 Sep 2017 19:25:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170929152255.5431-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1AS1DUI8WEEh87mOIT92KAUNlvbRnnBDq"
Subject: Re: [Qemu-devel] [PATCH] block/mirror: check backing in
 bdrv_mirror_top_flush
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, eblake@redhat.com, qemu-stable@nongnu.org
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1AS1DUI8WEEh87mOIT92KAUNlvbRnnBDq
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, eblake@redhat.com,
 qemu-stable@nongnu.org
Message-ID: <eb39b5cd-74c5-ffe5-7e1c-11cf7f6f2d46@redhat.com>
Subject: Re: [PATCH] block/mirror: check backing in bdrv_mirror_top_flush
References: <20170928120300.58164-1-vsementsov@virtuozzo.com>
 <20170929152255.5431-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170929152255.5431-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-29 17:22, Vladimir Sementsov-Ogievskiy wrote:
> Backing may be zero after failed bdrv_append in mirror_start_job,
> which leads to SIGSEGV.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> similar SIGSEGV.
> looks like (I guess by code, don't have full back-trace because of
> coroutine switch on bdrv_flush):
> mirror_start_job,
>   bdrv_append failed, backing is not set=20
>   bdrv_unref
>     bdrv_delete
>       bdrv_close
>         bdrv_flush
>          ...
>          bdrv_mirror_top_flush=20
>            Segmentation fault on
>            return bdrv_co_flush(bs->backing->bs);
>            as bs->backing =3D 0
>=20
>  block/mirror.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--1AS1DUI8WEEh87mOIT92KAUNlvbRnnBDq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnOgf4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASHQH/2BWaRhdoiTNJKvZQsWdxxOVXxpbWRtt
u/azc0de2DZallP+8C0zZPCPxmhzIHRnZP2mkUCrLCzK/6bQX+lNvmNwHmkn8HYt
HSNvegYDQpmKRvOcDuA3zm3koXRJUR23qrfUFUR7QXcE1X5C1UvWvzokgeghW0Cc
zs2KFoC2tW3Aeitk/DuYrykcC/uf14LfDZFFYIKQH4V+1HnbT7yUItDsvfZrjsLj
jT5hK8czoVQ0kE+NCnvrav0i0s8e2Gom4DSNxSj4QUZemJh8e6eZjiH42yy4MF4t
UMjnQJBOCo+tD1Q90fDMkeQC60g9KLal6ZfqdGPWR85PxbWKZ3r47c8=
=k+ve
-----END PGP SIGNATURE-----

--1AS1DUI8WEEh87mOIT92KAUNlvbRnnBDq--
