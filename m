Received: from eggs.gnu.org ([2001:4830:134:3::10]:50827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTGaS-00065g-08
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTGaR-0006mF-0b
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:21:16 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170116204921.31578-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a01b3de1-a92f-098e-8cb4-8203f20e8c25@redhat.com>
Date: Mon, 16 Jan 2017 17:21:06 -0600
MIME-Version: 1.0
In-Reply-To: <20170116204921.31578-6-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mIf2WB7c9XL6l6b9vXL4WiU6CvVR4nc8I"
Subject: Re: [Qemu-devel] [PATCH v4 13/25] block/nbd: Implement
 bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mIf2WB7c9XL6l6b9vXL4WiU6CvVR4nc8I
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <a01b3de1-a92f-098e-8cb4-8203f20e8c25@redhat.com>
Subject: Re: [PATCH v4 13/25] block/nbd: Implement bdrv_dirname()
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170116204921.31578-6-mreitz@redhat.com>
In-Reply-To: <20170116204921.31578-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2017 02:49 PM, Max Reitz wrote:
> The idea behind this implementation is that the export name might be
> interpreted as a path (which is the only apparent interpretation of
> relative filenames for NBD paths).
>=20
> The default implementation of bdrv_dirname() would handle that just fin=
e
> for nbd+tcp, but not for nbd+unix, because in that case, the last
> element of the path is the Unix socket path and not the export name.
> Therefore, we need to implement an own bdrv_dirname() which uses the
> legacy NBD URL which has the export name at the end.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/nbd.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/block/nbd.c b/block/nbd.c
> index 35f24be069..42f0cd638c 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -552,6 +552,34 @@ static void nbd_refresh_filename(BlockDriverState =
*bs, QDict *options)
>      bs->full_open_options =3D opts;
>  }
> =20
> +static char *nbd_dirname(BlockDriverState *bs, Error **errp)
> +{
> +    BDRVNBDState *s =3D bs->opaque;
> +    const char *host =3D NULL, *port =3D NULL, *path =3D NULL;
> +
> +    if (s->saddr->type =3D=3D SOCKET_ADDRESS_KIND_INET) {
> +        const InetSocketAddress *inet =3D s->saddr->u.inet.data;
> +        if (!inet->has_ipv4 && !inet->has_ipv6 && !inet->has_to) {
> +            host =3D inet->host;
> +            port =3D inet->port;
> +        }
> +    } else if (s->saddr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX) {
> +        path =3D s->saddr->u.q_unix.data->path;
> +    }
> +

Should we be catering to SOCKET_ADDRESS_KIND_VSOCK or
SOCKET_ADDRESS_KIND_FD (if only to assert that they aren't possible with
NBD)?

> +    if (path) {
> +        return g_strdup_printf("nbd:unix:%s:exportname=3D%s%s", path,
> +                               s->export ?: "", s->export ? "/" : "");=

> +    } else if (host) {
> +        return g_strdup_printf("nbd://%s:%s/%s%s", host, port,
> +                               s->export ?: "", s->export ? "/" : "");=

> +    }
> +
> +    error_setg(errp, "Cannot generate a base directory for NBD node '%=
s'",
> +               bs->filename);
> +    return NULL;
> +}
> +

The NBD protocol doesn't require the server to support directories, but
also doesn't place any requirements on export names, so this approach
assumes a particular server behavior, but is probably as good as any
other approach.  But I'm still not sold that we need this, vs. just
declaring that NBD has no directory structure and therefore we always
return NULL (even with nbd+tcp, and whether or not the older nbd: URI
was used).  So I'm not quite ready for R-b on this one yet.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--mIf2WB7c9XL6l6b9vXL4WiU6CvVR4nc8I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfVViAAoJEKeha0olJ0NqMUkIAKGIhh612YqoFDxtQvx8XBG9
TbissL3c9zYD8mWLuZZdA0EN2f16Zp8Pg8ySWNTSYYGH15vRzjvrOp1OtRp5lrnK
VSP3lr2kOKw0scad71sCDBqQNOJMqIjqY1+6XpuRPga2+BBMTwI71KVjGkQU3fet
8ALFeSZUwjYoC6dVqyg2qZ8GmeEM6PdQCvB08AdZxYgondRabMjucKzJkh4eL1+N
52oSOmgD0rURAhItgiBNp6Ro56Jjsnr7a4BEaqi8uTnrurV1ej2Noy6z26PTwPLh
0oizCk6MkMo8cSLkExD6vCF0ClC5+Wq5ATKNbrIvXbExYtPKWvpSo2GsEB5dWPE=
=FsgF
-----END PGP SIGNATURE-----

--mIf2WB7c9XL6l6b9vXL4WiU6CvVR4nc8I--
