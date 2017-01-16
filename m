Received: from eggs.gnu.org ([2001:4830:134:3::10]:60608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTD9h-0001U9-KA
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTD9g-0004vl-PV
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:41:25 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-5-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a4e16b4-b0a2-b732-cc6d-c61f0842c188@redhat.com>
Date: Mon, 16 Jan 2017 20:41:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UAxgGBntDO7gLjR18vHwpXAkT48JK1mg8"
Subject: Re: [Qemu-devel] [PATCH v1 04/15] qcow: require image size to be >
 1 for new images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UAxgGBntDO7gLjR18vHwpXAkT48JK1mg8
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <3a4e16b4-b0a2-b732-cc6d-c61f0842c188@redhat.com>
Subject: Re: [PATCH v1 04/15] qcow: require image size to be > 1 for new
 images
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-5-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-5-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> The qcow driver refuses to open images which are less than
> 2 bytes in size, but will happily create such images. Add
> a check in the create path to avoid this discrepancy.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/block/qcow.c b/block/qcow.c
> index 7540f43..8133fda 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -799,6 +799,12 @@ static int qcow_create(const char *filename, QemuO=
pts *opts, Error **errp)
>      /* Read out options */
>      total_size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE=
, 0),
>                            BDRV_SECTOR_SIZE);
> +    if (total_size <=3D 1) {
> +        error_setg(errp, "Image size is too small (must be at least 2 =
bytes)");
> +        ret =3D -EINVAL;
> +        goto cleanup;
> +    }
> +

Given the ROUND_UP() before, I can't see how total_size can be 1, but I
can see how it can be 0. Since that is covered by this condition:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>      backing_file =3D qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
>      if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
>          flags |=3D BLOCK_FLAG_ENCRYPT;
>=20



--UAxgGBntDO7gLjR18vHwpXAkT48JK1mg8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh9IdsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANe4H/RMSL9rJyrDsSVlo6qJ66u3Yff6NYCKx
9ovsOjgJa8lwFj5kLHM148TXpDG+Cr3T3M54QGjjzUx8G38Yz+MLakOHR7d+s5Vq
/NuviCtQx7tWd01qBcjt0/DUcFnDs0Qf9bVJIOwNmUhX3l2GZktNXLRdDRjbR3KC
JXr3rDlByCpzIj5b1RAicUc6cx40kdmeufXdnp9CFo07JD8f3q2vyTD2s4MHtDL8
l2TPMFMU2AqSJ+qihNz3hqmIDG+iVw0zTqeZod9F+L0F2vC4e81YLv4jwzulH4Y8
lN82FLLXtwmPU6EVm5cGR3x4vrt6lF7ym/v/8KlwZjtGcKP1QPdfWYg=
=i61m
-----END PGP SIGNATURE-----

--UAxgGBntDO7gLjR18vHwpXAkT48JK1mg8--
