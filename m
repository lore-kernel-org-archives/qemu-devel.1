Received: from eggs.gnu.org ([2001:4830:134:3::10]:60028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn9qL-000110-9K
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn9qI-0007Ta-4K
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dn9qH-0007TS-Q5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:44:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C097C4A6EF
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:44:04 +0000 (UTC)
References: <20170830113319.6749-1-quintela@redhat.com>
	<20170830113319.6749-2-quintela@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <14f7fc10-be58-0204-06f2-ea5a33484018@redhat.com>
Date: Wed, 30 Aug 2017 16:44:00 -0400
MIME-Version: 1.0
In-Reply-To: <20170830113319.6749-2-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TaWovnaMFeqXskNUpLOlfXFEwv3T07flv"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] tests: Use real size for iov tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TaWovnaMFeqXskNUpLOlfXFEwv3T07flv
From: Cleber Rosa <crosa@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com
Message-ID: <14f7fc10-be58-0204-06f2-ea5a33484018@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] tests: Use real size for iov tests
References: <20170830113319.6749-1-quintela@redhat.com>
 <20170830113319.6749-2-quintela@redhat.com>
In-Reply-To: <20170830113319.6749-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/30/2017 07:33 AM, Juan Quintela wrote:
> We were using -1 instead of the real size because the functions check
> what is bigger, size in bytes or the size of the iov.  Recent gcc's
> barf at this.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> --
>=20
> Remove comments about this feature.
> Fix missing -1.
> ---
>  include/qemu/iov.h |  6 ------
>  tests/test-iov.c   | 10 +++++-----
>  2 files changed, 5 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> index bd9fd55b0a..72d4c559b4 100644
> --- a/include/qemu/iov.h
> +++ b/include/qemu/iov.h
> @@ -31,11 +31,6 @@ size_t iov_size(const struct iovec *iov, const unsig=
ned int iov_cnt);
>   * Number of bytes actually copied will be returned, which is
>   *  min(bytes, iov_size(iov)-offset)
>   * `Offset' must point to the inside of iovec.
> - * It is okay to use very large value for `bytes' since we're
> - * limited by the size of the iovec anyway, provided that the
> - * buffer pointed to by buf has enough space.  One possible
> - * such "large" value is -1 (sinice size_t is unsigned),
> - * so specifying `-1' as `bytes' means 'up to the end of iovec'.
>   */
>  size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt=
,
>                           size_t offset, const void *buf, size_t bytes)=
;
> @@ -76,7 +71,6 @@ iov_to_buf(const struct iovec *iov, const unsigned in=
t iov_cnt,
>   * up to the end of it, will be filled with the specified value.
>   * Function return actual number of bytes processed, which is
>   * min(size, iov_size(iov) - offset).
> - * Again, it is okay to use large value for `bytes' to mean "up to the=
 end".
>   */
>  size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,=

>                    size_t offset, int fillc, size_t bytes);
> diff --git a/tests/test-iov.c b/tests/test-iov.c
> index a22d71fd2c..f40f8f5260 100644
> --- a/tests/test-iov.c
> +++ b/tests/test-iov.c
> @@ -81,17 +81,17 @@ static void test_to_from_buf_1(void)
>            * skip whole vector and process exactly 0 bytes */
> =20
>           /* first set bytes [i..sz) to some "random" value */
> -         n =3D iov_memset(iov, niov, 0, 0xff, -1);
> +         n =3D iov_memset(iov, niov, 0, 0xff, sz);
>           g_assert(n =3D=3D sz);
> =20
>           /* next copy bytes [i..sz) from ibuf to iovec */
> -         n =3D iov_from_buf(iov, niov, i, ibuf + i, -1);
> +         n =3D iov_from_buf(iov, niov, i, ibuf + i, sz - i);
>           g_assert(n =3D=3D sz - i);
> =20
>           /* clear part of obuf */
>           memset(obuf + i, 0, sz - i);
>           /* and set this part of obuf to values from iovec */
> -         n =3D iov_to_buf(iov, niov, i, obuf + i, -1);
> +         n =3D iov_to_buf(iov, niov, i, obuf + i, sz - i);
>           g_assert(n =3D=3D sz - i);
> =20
>           /* now compare resulting buffers */
> @@ -109,7 +109,7 @@ static void test_to_from_buf_1(void)
>                * with j in [i..sz]. */
> =20
>               /* clear iovec */
> -             n =3D iov_memset(iov, niov, 0, 0xff, -1);
> +             n =3D iov_memset(iov, niov, 0, 0xff, sz);
>               g_assert(n =3D=3D sz);
> =20
>               /* copy bytes [i..j) from ibuf to iovec */
> @@ -226,7 +226,7 @@ static void test_io(void)
>         for (i =3D 0; i <=3D sz; ++i) {
>             for (j =3D i; j <=3D sz; ++j) {
>                 k =3D i;
> -               iov_memset(iov, niov, 0, 0xff, -1);
> +               iov_memset(iov, niov, 0, 0xff, sz);
>                 do {
>                     s =3D g_test_rand_int_range(0, j - k + 1);
>                     r =3D iov_recv(sv[0], iov, niov, k, s);
>=20

Tested-by: Cleber Rosa <crosa@redhat.com>


--TaWovnaMFeqXskNUpLOlfXFEwv3T07flv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmnI5AACgkQZX6NM6Xy
CfNgcw//erPTY+bsbqVePHh/GwK00Zzxjh+f3y65iqHU4pbW0nD7OIO5KqlCFSMi
bI7SJdHlSGtuq7QTHQIjqbVu8DrDqffxpmjvWESs+AiuUvzSgHsZFuCb/MvWnc4g
pdVDKPjSgzr6o6uHl/3iggvppUdmvSdlLVPcCoI3lGWfCCOAGPe0rRzMW6WScgGz
ePbaJZNuM6Vx6uuUi5uOfyMBZPiJsW+0IGcgb+gFO8tGUVVyB3WwUMToDPBP5jU4
hvWgXLZAsNyaNTbsdYg79FJ/1QDxjj7pcs5GTAUpez7l0e9KPAMBjacbxTlxDMDd
KPfgQkdm4pkqEwOxw+mkgwjXDzP2PbseZ909w/jkjGJqaQXd3m6IfX+t5fo4kmdv
QZNAc2FASUSCi4EKKinfz5h//Iu1tN+ipiqZEbj82g/37cbn8osWdJZzyoqWnOWe
toeom0r5WvYnu22wA4YXwup89Hg4uivfQpaowgBmLtP5wSilyTYFdtguMoibN/S0
M1VX+543gVIbUqVgyPJ3bUx+wyomFuKTWeJEVWLDu6R25p/gOLPUBLly0naJPYMB
+i8/1S20NPGoOahEfV7PsyvuDpOknv2inPK5TDQmgdj/Ri4GxC5PEDgKxiodyjEX
2sNSiIAKPIMn6cTA3YRTpSNDpo1yEFN1Nn5BZgsTR1uBelTmkbI=
=9p5E
-----END PGP SIGNATURE-----

--TaWovnaMFeqXskNUpLOlfXFEwv3T07flv--
