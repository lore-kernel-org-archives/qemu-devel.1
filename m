Received: from eggs.gnu.org ([2001:4830:134:3::10]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQ8nP-0002B8-KJ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQ8nO-0000E9-Bp
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:57:59 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:42184)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQ8nN-0000Dc-VP
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:57:58 -0400
Date: Wed, 28 Jun 2017 11:57:47 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170628085747.mdwfwso5inxrvizo@postretch>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-20-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lqhlqmpwk7fqutwx"
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-20-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 19/20] block: Minimize raw
 use of bds->total_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--lqhlqmpwk7fqutwx
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 02:24:57PM -0500, Eric Blake wrote:
>bdrv_is_allocated_above() was relying on intermediate->total_sectors,
>which is a field that can have stale contents depending on the value
>of intermediate->has_variable_length.  An audit shows that we are safe
>(we were first calling through bdrv_co_get_block_status() which in
>turn calls bdrv_nb_sectors() and therefore just refreshed the current
>length), but it's nicer to favor our accessor functions to avoid having
>to repeat such an audit, even if it means refresh_total_sectors() is
>called more frequently.
>
>Suggested-by: John Snow <jsnow@redhat.com>
>Signed-off-by: Eric Blake <eblake@redhat.com>
>
>---
>v2: new patch
>---
> block/io.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/block/io.c b/block/io.c
>index 0545180..5bbf153 100644
>--- a/block/io.c
>+++ b/block/io.c
>@@ -1924,6 +1924,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
>     intermediate =3D top;
>     while (intermediate && intermediate !=3D base) {
>         int64_t pnum_inter;
>+        int64_t size_inter;
>         int psectors_inter;
>
>         ret =3D bdrv_is_allocated(intermediate, sector_num * BDRV_SECTOR_=
SIZE,
>@@ -1941,13 +1942,14 @@ int bdrv_is_allocated_above(BlockDriverState *top,
>
>         /*
>          * [sector_num, nb_sectors] is unallocated on top but intermediate
>-         * might have
>-         *
>-         * [sector_num+x, nr_sectors] allocated.
>+         * might have [sector_num+x, nb_sectors-x] allocated.
>          */
>+        size_inter =3D bdrv_nb_sectors(intermediate);
>+        if (size_inter < 0) {
>+            return size_inter;
>+        }
>         if (n > psectors_inter &&
>-            (intermediate =3D=3D top ||
>-             sector_num + psectors_inter < intermediate->total_sectors)) {
>+            (intermediate =3D=3D top || sector_num + psectors_inter < siz=
e_inter)) {
>             n =3D psectors_inter;
>         }
>
>--=20
>2.9.4

Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

--lqhlqmpwk7fqutwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllTb4sACgkQc2J8L2kN
9xBG+w//Z3sHMFbktbxMiINJAX+KZGt6ItwDbo3WfufFDKX4r5x6M2xc8KzMQtoA
mHJl/xtzwvq3YCpyIhU0LJzP1WWs6BazFeVa93yBEgyfYLvcz9dm1k18Aw06I9dp
8rIlVckUqYEIv0z6BONLCjxi79J8sraqRe20TAdyJ8hWqbsFSiu0SeMJu22S56+U
eJgeOMK+YYp6e1mg493JxQpU5MfhXQFs0qy9FLv6sTy72A9Li68nWFC8MQflyUvH
UwsKn6iwhyey3ZwttP66ySgkmF3FXIKiF/wQvbUTHPFun+UuRMqAuZANEV9PFn0o
xqE+FkX/nIB2mjJHYfkU+xe5SUSXB8OZV9ujZ38qKGyPXo3fnoM2aV/kBCrtiFpl
o8ze/4ce7Fpwgpl2VtciRUb464HBgalkHFqhkgA40HTivulSQ9shuc/9FP1gEZIe
y2YEgW7/YuxnM8o9EhSHxGK0w7Qin0ssuxylhGHLf/+5PI6YOtEoIRzQSkqk9HUd
/2B2k2LmP5roHirz4hR3qBRczmJMCbRZYv0XdXMgrHfVpiXky5w56dZa3h8G+I95
FLjFS32wit0ONwtr2EVUZpzUBZRGLbZkvZWh8cU+/plBmfdATP8OFLIhXhLbfNc+
o6bD+kWgeYLpnMdwjhWqIlPlBZYDPDNJWT5xqc2vL2oTasJnGdo=
=ft64
-----END PGP SIGNATURE-----

--lqhlqmpwk7fqutwx--
