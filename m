Received: from eggs.gnu.org ([2001:4830:134:3::10]:46754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbXvt-0002dh-0D
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbXvs-000764-1X
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:29:37 -0500
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1cf91704-5c4d-705c-7681-99ec8cc567bd@redhat.com>
Date: Wed, 8 Feb 2017 13:29:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170126101827.22378-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QNAdwNSv4H3DWoPk1pfnJoHDe3Q7PJEWk"
Subject: Re: [Qemu-devel] [PATCH v3 04/18] qcow: require image size to be >
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QNAdwNSv4H3DWoPk1pfnJoHDe3Q7PJEWk
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <1cf91704-5c4d-705c-7681-99ec8cc567bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/18] qcow: require image size to be > 1
 for new images
References: <20170126101827.22378-1-berrange@redhat.com>
 <20170126101827.22378-5-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2017 04:18 AM, Daniel P. Berrange wrote:
> The qcow driver refuses to open images which are less than
> 2 bytes in size, but will happily create such images. Add
> a check in the create path to avoid this discrepancy.

I agree that we have the 2-byte limit:

static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
=2E..
    if (header.size <=3D 1) {
        error_setg(errp, "Image size is too small (must be at least 2
bytes)");
        ret =3D -EINVAL;
        goto fail;
    }

But why 2 bytes? That's a weird limit from history.  Oh well, no one
should be creating many new qcow images when we have qcow2, so I see no
problem with your patch as-is.

>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20

> +++ b/block/qcow.c
> @@ -799,6 +799,12 @@ static int qcow_create(const char *filename, QemuO=
pts *opts, Error **errp)
>      /* Read out options */
>      total_size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE=
, 0),
>                            BDRV_SECTOR_SIZE);
> +    if (total_size <=3D 1) {

It will never be 1 because of the ROUND_UP (it will either be 0 or a
sector size), but your code is defensive to match the open check.

Reviewed-by: Eric Blake <eblake@redhat.com>

> +        error_setg(errp, "Image size is too small, cannot be zero leng=
th");
> +        ret =3D -EINVAL;
> +        goto cleanup;
> +    }
> +
>      backing_file =3D qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
>      if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
>          flags |=3D BLOCK_FLAG_ENCRYPT;
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QNAdwNSv4H3DWoPk1pfnJoHDe3Q7PJEWk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYm3GYAAoJEKeha0olJ0Nq7yMIAIWmaVSg46SYN4PJuhnIuEH1
kSt65bnhSWrk6fiLm7iGMAQGUm/Q18Obg2WFIZs1oGLTDrWUHS+WMuhjb0DYlP9b
6mv4xealN14liCDJdlYG+HRbB+mHhusUs0xAIFN0AKEJKGHNAHdAczpheKGN6yiy
RHIVKXnbH/8CS42MVXHmI4jq8nHHIaWNI699RrD2i3oBZmFTFU6CiRv90+KyDjvc
i1ZOEuYmTfv5Ei/vPmNEDDajhhJGMuHOutbuQacFD9axe037Qjq1iADN8LpLk1rN
1fvgSeHS7RUvyMhVuoE/IbMsX32PO26QlwXw5w9WvVKBAfFmP1Y9K8E5QzGPFNU=
=CIoV
-----END PGP SIGNATURE-----

--QNAdwNSv4H3DWoPk1pfnJoHDe3Q7PJEWk--
