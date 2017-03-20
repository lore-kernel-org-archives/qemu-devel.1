Received: from eggs.gnu.org ([2001:4830:134:3::10]:47296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvSZ-0000VE-QE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvSY-0002fO-RE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:26:47 -0400
Date: Mon, 20 Mar 2017 11:26:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320112637.GM17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bPrm2PuLP7ysUh6c"
Content-Disposition: inline
In-Reply-To: <20170313214117.27350-4-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 13/16] block/qcow2:
 qcow2_calc_size_usage() for truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--bPrm2PuLP7ysUh6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:41:14PM +0100, Max Reitz wrote:
> This patch extends qcow2_calc_size_usage() so it can calculate the
> additional space needed for preallocating image growth.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 137 +++++++++++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 98 insertions(+), 39 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 21b2b3cd53..80fb815b15 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2101,7 +2101,15 @@ done:
>      return ret;
>  }
> =20
> -static uint64_t qcow2_calc_size_usage(uint64_t new_size,
> +/**
> + * Returns the number of bytes that must be allocated in the underlying =
file
> + * to accomodate an image growth from @current_size to @new_size.
> + *
> + * @current_size must be 0 when creating a new image. In that case, @bs =
is
> + * ignored; otherwise it must be valid.
> + */
> +static uint64_t qcow2_calc_size_usage(BlockDriverState *bs,
> +                                      uint64_t current_size, uint64_t ne=
w_size,
>                                        int cluster_bits, int refcount_ord=
er)
>  {
>      size_t cluster_size =3D 1u << cluster_bits;
> @@ -2122,47 +2130,97 @@ static uint64_t qcow2_calc_size_usage(uint64_t ne=
w_size,
>      refblock_bits =3D cluster_bits - (refcount_order - 3);
>      refblock_size =3D 1 << refblock_bits;
> =20
> -    /* header: 1 cluster */
> -    meta_size +=3D cluster_size;
> -
> -    /* total size of L2 tables */
> -    nl2e =3D aligned_total_size / cluster_size;
> -    nl2e =3D align_offset(nl2e, cluster_size / sizeof(uint64_t));
> -    meta_size +=3D nl2e * sizeof(uint64_t);
> +    if (!current_size) {

This massive if statement effectively makes two functions: the old
qcow2_calc_size_usage() and the new qcow2_calc_size_change(bs) function.

It might be nicer to split the two functions.

--bPrm2PuLP7ysUh6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz7xtAAoJEJykq7OBq3PI7UYIAJQmPerKvVWfK0sN/ltMLKRH
Rt3QzrKJVuVXViOdmddnR3TzZUKUoFor67qvusI/8VawFLHOqTajcZbwXizWzhtQ
Xz4MmZ7aCTFASYjiFlipWGA106xHInj0+wYDkmbcAFm4twzDMlUZ3vfnWsLMBi2w
/SrmeUyfn1LhJJ3H1Z+D6GL1okBfVZJIYuHj9m6tBEIXQX4f1ZCVHD7V7nCX6VX/
5xHBGlIbgDYUFtlFlZLRyi64wBsHeyDQpbDC5lyHwSmZ/RcLV1qT6YGx+7Kdb5xA
fGBil538Sk9Jq5WMjU2dMa1EawH/2yygvoAdbmAY9uCuoUcMKWpigS+rYuJDwnM=
=KSTR
-----END PGP SIGNATURE-----

--bPrm2PuLP7ysUh6c--
