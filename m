Received: from eggs.gnu.org ([2001:4830:134:3::10]:46546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZmW9-00051d-P7
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZmW8-0004FX-Px
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:39:45 -0500
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-7-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2a209a6e-338c-f352-6634-555b36daafb9@redhat.com>
Date: Fri, 3 Feb 2017 23:39:35 +0100
MIME-Version: 1.0
In-Reply-To: <20170203120254.15062-7-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1se68XFloTNdCvEq4bWo4eaH26fjOQOrl"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] qemu-img: copy *key-secret opts
 when opening newly created files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1se68XFloTNdCvEq4bWo4eaH26fjOQOrl
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <2a209a6e-338c-f352-6634-555b36daafb9@redhat.com>
Subject: Re: [PATCH v2 6/6] qemu-img: copy *key-secret opts when opening newly
 created files
References: <20170203120254.15062-1-berrange@redhat.com>
 <20170203120254.15062-7-berrange@redhat.com>
In-Reply-To: <20170203120254.15062-7-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 13:02, Daniel P. Berrange wrote:
> The qemu-img dd/convert commands will create a image file and
> then try to open it. Historically it has been possible to open
> new files without passing any options. With encrypted files
> though, the *key-secret options are mandatory, so we need to
> provide those options when opening the newly created file.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 47 insertions(+), 4 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index dc4c6eb..98522dd 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -319,6 +319,49 @@ static BlockBackend *img_open_file(const char *fil=
ename,
>  }
> =20
> =20
> +static int img_add_key_secrets(void *opaque,
> +                               const char *name, const char *value,
> +                               Error **errp)
> +{
> +    QDict **options =3D opaque;
> +
> +    if (g_str_has_suffix(name, "key-secret")) {
> +        if (!*options) {
> +            *options =3D qdict_new();
> +        }
> +        qdict_put(*options, name, qstring_from_str(value));
> +    }
> +
> +    return 0;
> +}
> +
> +static BlockBackend *img_open_new_file(const char *filename,
> +                                       QemuOpts *create_opts,
> +                                       const char *fmt, int flags,
> +                                       bool writethrough, bool quiet)
> +{
> +    BlockBackend *blk;
> +    Error *local_err =3D NULL;
> +    QDict *options =3D NULL;
> +
> +    if (fmt) {
> +        options =3D qdict_new();
> +        qdict_put(options, "driver", qstring_from_str(fmt));
> +    }
> +
> +    qemu_opt_foreach(create_opts, img_add_key_secrets, &options, NULL)=
;

It would probably be easier to just unconditionally create an options
QDict. It doesn't hurt if it's empty.

Anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +
> +    blk =3D blk_new_open(filename, NULL, options, flags, &local_err);
> +    if (!blk) {
> +        error_reportf_err(local_err, "Could not open '%s': ", filename=
);
> +        return NULL;
> +    }
> +    blk_set_enable_write_cache(blk, !writethrough);
> +
> +    return blk;
> +}
> +
> +
>  static BlockBackend *img_open(bool image_opts,
>                                const char *filename,
>                                const char *fmt, int flags, bool writeth=
rough,
> @@ -2115,8 +2158,8 @@ static int img_convert(int argc, char **argv)
>           * That has to wait for bdrv_create to be improved
>           * to allow filenames in option syntax
>           */
> -        out_blk =3D img_open_file(out_filename, out_fmt,
> -                                flags, writethrough, quiet);
> +        out_blk =3D img_open_new_file(out_filename, opts, out_fmt,
> +                                    flags, writethrough, quiet);
>      }
>      if (!out_blk) {
>          ret =3D -1;
> @@ -4206,8 +4249,8 @@ static int img_dd(int argc, char **argv)
>           * That has to wait for bdrv_create to be improved
>           * to allow filenames in option syntax
>           */
> -        blk2 =3D img_open_file(out.filename, out_fmt,
> -                             BDRV_O_RDWR, false, false);
> +        blk2 =3D img_open_new_file(out.filename, opts, out_fmt,
> +                                 BDRV_O_RDWR, false, false);
>      }
> =20
>      if (!blk2) {
>=20



--1se68XFloTNdCvEq4bWo4eaH26fjOQOrl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliVBqcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AsNIH+wWsUfkFVT+3yNd8g0MgWCeR/HmGp84l
OHyvwIN+Ak5Q7dHrO21eZvlIJsGV6aTGoMwJg0uBWGIgY1gh6QGEwbR/LHt7HO71
ZamuIEuRkOkqks00kLzXSlXOeaoiHd0CCaS4W3nnTU7HxvJYGmiCGo2Xk1cLtetU
FDxDrGKnrOtYhtc1gcJWz+AgefJV1P3YlFrU/47ZMQeBSLAYAw/RhXghvt0SwH+r
Pbj1BUBl9ZR78VkrRU8n49QnQM++/xl5p5RwPAWK3n42bjYCRe6L1Bh6+guto9zr
QthuuI4SXLfNmQ7hXZPu2cp7IooJ6Osv+egxtzJpEmvwZXKWgLL8ctM=
=R5kl
-----END PGP SIGNATURE-----

--1se68XFloTNdCvEq4bWo4eaH26fjOQOrl--
