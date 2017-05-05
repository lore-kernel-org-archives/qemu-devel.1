Received: from eggs.gnu.org ([2001:4830:134:3::10]:36464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6kJM-0004d1-90
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6kJL-0005b7-9i
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:58:48 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-7-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f573947e-d97b-ff59-5881-15d1a1b3b8d4@redhat.com>
Date: Fri, 5 May 2017 22:58:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170504030755.1001-7-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3DP0wSpbnTLvHj2FQMjckHvF64rxWTqvH"
Subject: Re: [Qemu-devel] [PATCH v12 06/10] iotests: Improve
 _filter_qemu_img_map
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
--3DP0wSpbnTLvHj2FQMjckHvF64rxWTqvH
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <f573947e-d97b-ff59-5881-15d1a1b3b8d4@redhat.com>
Subject: Re: [PATCH v12 06/10] iotests: Improve _filter_qemu_img_map
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-7-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 05:07, Eric Blake wrote:
> Although _filter_qemu_img_map documents that it scrubs offsets, it
> was only doing so for human mode.  Of the existing tests using the
> filter (97, 122, 150, 154, 176), two of them are affected, but it
> does not hurt the validity of the tests to not require particular
> mappings (another test, 66, uses offsets but intentionally does not
> pass through _filter_qemu_img_map, because it checks that offsets
> are unchanged before and after an operation).
>=20
> Another justification for this patch is that it will allow a future
> patch to utilize 'qemu-img map --output=3Djson' to check the status of
> preallocated zero clusters without regards to the mapping (since
> the qcow2 mapping can be very sensitive to the chosen cluster size,
> when preallocation is not in use).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v12: new patch
> ---
>  tests/qemu-iotests/common.filter |  4 +++-
>  tests/qemu-iotests/122.out       | 16 ++++++++--------
>  tests/qemu-iotests/154.out       | 30 +++++++++++++++---------------
>  3 files changed, 26 insertions(+), 24 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/comm=
on.filter
> index f58548d..2c14f15 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -152,10 +152,12 @@ _filter_img_info()
>          -e "/log_size: [0-9]\\+/d"
>  }
>=20
> -# filter out offsets and file names from qemu-img map
> +# filter out offsets and file names from qemu-img map; good for both
> +# human and json output
>  _filter_qemu_img_map()
>  {
>      sed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
> +	-e 's/"offset": [0-9]\+/"offset": OFFSET/g' \>          -e 's/Mapped =
to *//' | _filter_testdir | _filter_imgfmt

This makes my OCD very sad.

With the alignment fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

(Without this fixed: Will-change-when-applying-and-then-add-the-R-b)

>  }


--3DP0wSpbnTLvHj2FQMjckHvF64rxWTqvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM538SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyVMH/iEChxrchppQTl7Xc7tgTepaCRDQNKmN
o3kHWsgFi+CHdiyiWSRkLyqd786ewJ9NzTr7zV/YA+je/wfAhCgE1p5g4NvrD2yX
QUfbtserpcfkHNuGcy4NQwu1i9QHq4CCmzM8wSdjHWYeb/aZOD12wfSsOzeCMkvO
ODStjweL/6SyOadKP9v+kQ01/y90lcifpw9m040gT2CWmLPi4wDC7VYZmHc2+RzZ
tXSaIkWCyUFdg9536Gck9FqjMtcqvqtp5lJNslyWuSS0EfZ8WUYxKKTL5mN+1X6K
ZQAV9JB5xyQQjEb5cYZDwWUuzAQBmfQ4n3nOU9j3SOAmFhhOXFjA0hw=
=ecF0
-----END PGP SIGNATURE-----

--3DP0wSpbnTLvHj2FQMjckHvF64rxWTqvH--
