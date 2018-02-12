Received: from eggs.gnu.org ([2001:4830:134:3::10]:37020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elIFq-00084f-Mg
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elIFp-00045Q-Ra
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:51:02 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-27-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <76ccde5b-7726-58a4-1443-878a3e75d577@redhat.com>
Date: Mon, 12 Feb 2018 18:50:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-27-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cZEYZS8DeKNRs9wSDwfixuO1sWsNZA4Qv"
Subject: Re: [Qemu-devel] [PATCH 26/27] qemu-iotests: Test qcow2 over file
 image creation with QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cZEYZS8DeKNRs9wSDwfixuO1sWsNZA4Qv
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <76ccde5b-7726-58a4-1443-878a3e75d577@redhat.com>
Subject: Re: [PATCH 26/27] qemu-iotests: Test qcow2 over file image creation
 with QMP
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-27-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-27-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/206     | 436 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/206.out | 209 ++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 646 insertions(+)
>  create mode 100755 tests/qemu-iotests/206
>  create mode 100644 tests/qemu-iotests/206.out

Reviewed-by: Max Reitz <mreitz@redhat.com>

> diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
> new file mode 100755
> index 0000000000..0a18b2b19a
> --- /dev/null
> +++ b/tests/qemu-iotests/206
> @@ -0,0 +1,436 @@

[...]

> +# creator
> +owner=3Dkwolf@redhat.com
> +
> +seq=3D`basename $0`
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +status=3D1	# failure is the default!

Hmmm...  Didn't we want to remove this boilerplate at some point?

> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt qcow2
> +_supported_proto file
> +_supported_os Linux
> +

[...]

> +echo
> +echo "=3D=3D=3D Invalid sizes =3D=3D=3D"
> +echo
> +
> +# TODO Negative image sizes aren't handled correctly, but this is a pr=
oblem
> +# with QAPI's implementation of the 'size' type and affects other comm=
ands as
> +# well. Once this is fixed, we may want to add a test case here.
> +
> +# 1. Misaligned image size
> +# 2. 2^64 - 512
> +# 3. 2^63 =3D 8 EB (qemu-img enforces image sizes less than this)
> +# 4. 2^63 - 512 (generally valid, but qcow2 can't handle images this s=
ize)
> +
> +run_qemu -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dno=
de0 <<EOF
> +{ "execute": "qmp_capabilities" }
> +{ "execute": "x-blockdev-create",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "file": "node0",
> +      "size": 1234
> +  }
> +}
> +{ "execute": "x-blockdev-create",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "file": "node0",
> +      "size": 18446744073709551104

I was about to propose $((2**64 - 512)), but then I noticed that yields
-512.  Nice.

> +  }
> +}
> +{ "execute": "x-blockdev-create",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "file": "node0",
> +      "size": 9223372036854775808
> +  }
> +}
> +{ "execute": "x-blockdev-create",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "file": "node0",
> +      "size": 9223372036854775296
> +  }
> +}
> +{ "execute": "quit" }
> +EOF


--cZEYZS8DeKNRs9wSDwfixuO1sWsNZA4Qv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqB1AASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATcUIAKzaK4munw2mIZaM4mJuWaTS7dTqMAuG
YvkCThOYMbeD1YtRIuKDhyBUZ7NaI8nBJ0JqUUUlF7Qv2rBV3dm5suKoD7o3z4Po
HHmUXYvfH7al1mn/qW4eAzxbEAcoFw/JHvB3HdW3O2fxXS5DUi5I5zY+WGr0hWb4
tiayx/gY6aT90nSwJpGFdzYFxAZiQXBu9OTxiygnXiL/UYDi/HpYT6mIEl4UehTe
+g7EhhaXOHxvsCtxs7uCs9W1sq2fsPhJTwn8xE4acoALBKGXqaohedIJVSqzv4qt
5V3ljlF4IpoCFmN1yh8XzKtsZviTGNvigchhy6YkFHHw1phY2L02+9k=
=xyJG
-----END PGP SIGNATURE-----

--cZEYZS8DeKNRs9wSDwfixuO1sWsNZA4Qv--
