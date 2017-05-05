Received: from eggs.gnu.org ([2001:4830:134:3::10]:51244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6lNH-0004o7-C6
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6lNG-0004QF-BB
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:06:55 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-9-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8e44075e-7edb-16bb-e98f-d24ead5e0063@redhat.com>
Date: Sat, 6 May 2017 00:06:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170504030755.1001-9-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mWbEJQ8FN0LEx4dPhBWgNwlqJqvGLXW9s"
Subject: Re: [Qemu-devel] [PATCH v12 08/10] qcow2: Optimize write zero of
 unaligned tail cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mWbEJQ8FN0LEx4dPhBWgNwlqJqvGLXW9s
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <8e44075e-7edb-16bb-e98f-d24ead5e0063@redhat.com>
Subject: Re: [PATCH v12 08/10] qcow2: Optimize write zero of unaligned tail
 cluster
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-9-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 05:07, Eric Blake wrote:
> We've already improved discards to operate efficiently on the tail
> of an unaligned qcow2 image; it's time to make a similar improvement
> to write zeroes.  The special case is only valid at the tail
> cluster of a file, where we must recognize that any sectors beyond
> the image end would implicitly read as zero, and therefore should
> not penalize our logic for widening a partial cluster into writing
> the whole cluster as zero.
>=20
> However, note that for now, the special case of end-of-file is only
> recognized if there is no backing file, or if the backing file has
> the same length; that's because when the backing file is shorter
> than the active layer, we don't have code in place to recognize
> that reads of a sector unallocated at the top and beyond the backing
> end-of-file are implicitly zero.  It's not much of a real loss,
> because most people don't use images that aren't cluster-aligned,
> or where the active layer is a different size than the backing
> layer (especially where the difference falls within a single cluster).
>=20
> Update test 154 to cover the new scenarios, using two images of
> intentionally differing length.
>=20
> While at it, fix the test to gracefully skip when run as
> ./check -qcow2 -o compat=3D0.10 154
> since the older format lacks zero clusters already required earlier
> in the test.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v12: fix testsuite problems, document shortcoming of differing
> v11: reserved for blkdebug half of v10
> size of backing file
>=20
> v10: rebase to better reporting of preallocated zero clusters
> v9: new patch
> ---
>  block/qcow2.c              |   7 ++
>  tests/qemu-iotests/154     | 160 +++++++++++++++++++++++++++++++++++++=
+++++++-
>  tests/qemu-iotests/154.out | 129 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 294 insertions(+), 2 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
> index 7ca7219..687b8f3 100755
> --- a/tests/qemu-iotests/154
> +++ b/tests/qemu-iotests/154

[...]

> @@ -299,6 +302,159 @@ $QEMU_IO -c "read -P 0 75k 1k" "$TEST_IMG" | _fil=
ter_qemu_io
>=20
>  $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
>=20
> +echo
> +echo =3D=3D unaligned image tail cluster, no allocation needed =3D=3D

[...]

> +# A preallocated cluster maintains its allocation, whether it stays as=

> +# data due to a partial write:
> +# Convert 128m... | XX XX =3D> ... | XX 00
> +_make_test_img $((size + 1024))
> +$QEMU_IO -c "write -P 1 $((size)) 1024" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "write -z $((size + 512)) 512" "$TEST_IMG.base" | _filter_=
qemu_io

s/\.base//, I suppose?

(You should read your reference output. "Pattern verification failed" is
never good. ;-))

With that (and the reference output) fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--mWbEJQ8FN0LEx4dPhBWgNwlqJqvGLXW9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM93MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AT7kIALWJ2X5I22dz+KaXQ0gm+b5G+RO19cn0
oqIhGRM7NjUmzahDlFFCK/C59NaWjEk0icubGRL5wXDcv7/uTtKGNfPJ3G1Tp9F3
yB+yVYXAJwfqJ1rnFvROqSY/RCtIZNylW8iWIOFtcA0T0EE5/Gg//MmkZS49upTf
fbEVaw2oPAyKoTi7xxcjk63E3Hq0GocyLZf1jTx+M5D6/bvatvNMMKYUt14WlXAR
LpJ67Tmv9S8U93sLVkXa4KFkap8tnRMKE4Wj+aMPnMfzEB5PvUm6Tnl7KgjiAArF
s1X0+Tm2uYf1uQurUuTgeTnnfBGl183D8Ooq4Xmr2kNuewrESJAxysU=
=oSZI
-----END PGP SIGNATURE-----

--mWbEJQ8FN0LEx4dPhBWgNwlqJqvGLXW9s--
