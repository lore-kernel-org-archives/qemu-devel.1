Received: from eggs.gnu.org ([2001:4830:134:3::10]:48885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAK1t-0000jA-KF
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAK1s-0001yb-G8
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:43:33 -0400
References: <20170515140410.14172-1-berrange@redhat.com>
	<20170515140410.14172-5-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e2a74028-c9c0-6b6a-4c13-27fab303a2e1@redhat.com>
Date: Mon, 15 May 2017 19:43:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170515140410.14172-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5oSjNrDpF9TMmst0t5srtwjccgsoPxkeJ"
Subject: Re: [Qemu-devel] [PATCH v9 4/4] qemu-img: copy *key-secret opts
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
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5oSjNrDpF9TMmst0t5srtwjccgsoPxkeJ
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <e2a74028-c9c0-6b6a-4c13-27fab303a2e1@redhat.com>
Subject: Re: [PATCH v9 4/4] qemu-img: copy *key-secret opts when opening newly
 created files
References: <20170515140410.14172-1-berrange@redhat.com>
 <20170515140410.14172-5-berrange@redhat.com>
In-Reply-To: <20170515140410.14172-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-15 16:04, Daniel P. Berrange wrote:
> The qemu-img dd/convert commands will create an image file and
> then try to open it. Historically it has been possible to open
> new files without passing any options. With encrypted files
> though, the *key-secret options are mandatory, so we need to
> provide those options when opening the newly created file.
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index e0e3d31..dcddded 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -314,15 +314,18 @@ static BlockBackend *img_open_opts(const char *op=
tstr,
>  }
> =20
>  static BlockBackend *img_open_file(const char *filename,
> +                                   QDict *options,
>                                     const char *fmt, int flags,
>                                     bool writethrough, bool quiet,
>                                     bool force_share)
>  {
>      BlockBackend *blk;
>      Error *local_err =3D NULL;
> -    QDict *options =3D qdict_new();
> =20
>      if (fmt) {
> +        if (!options) {
> +            options =3D qdict_new();
> +        }

This is the only place where my attempted rebase and your version
differ. I think this has to be done unconditionally, because otherwise:

$ ./qemu-img info -U null-co://
[1]    16327 segmentation fault (core dumped)  ./qemu-img info -U null-co=
://

Also, I'm not sure the R-bs apply for this patch any longer.

(They do for patch 1 because it's just a contextual difference. For
patch 2, it's a borderline case (I would drop it, but I can understand
keeping it). For patch 3 it's more than just borderline - I would
definitely drop the R-b, but the differences are still rather
mechanical, so it is acceptable to keep it.
But I think there are too many changes here in this patch to keep the
R-bs. In fact, I'm pretty sure none of Eric, Fam and me have given an
R-b to this segfault...)

Max

>          qdict_put_str(options, "driver", fmt);
>      }
> =20
> @@ -344,6 +347,35 @@ static BlockBackend *img_open_file(const char *fil=
ename,
>  }
> =20
> =20
> +static int img_add_key_secrets(void *opaque,
> +                               const char *name, const char *value,
> +                               Error **errp)
> +{
> +    QDict *options =3D opaque;
> +
> +    if (g_str_has_suffix(name, "key-secret")) {
> +        qdict_put(options, name, qstring_from_str(value));
> +    }
> +
> +    return 0;
> +}
> +
> +static BlockBackend *img_open_new_file(const char *filename,
> +                                       QemuOpts *create_opts,
> +                                       const char *fmt, int flags,
> +                                       bool writethrough, bool quiet,
> +                                       bool force_share)
> +{
> +    QDict *options =3D NULL;
> +
> +    options =3D qdict_new();
> +    qemu_opt_foreach(create_opts, img_add_key_secrets, options, &error=
_abort);
> +
> +    return img_open_file(filename, options, fmt, flags, writethrough, =
quiet,
> +                         force_share);
> +}
> +
> +
>  static BlockBackend *img_open(bool image_opts,
>                                const char *filename,
>                                const char *fmt, int flags, bool writeth=
rough,
> @@ -364,7 +396,7 @@ static BlockBackend *img_open(bool image_opts,
>          blk =3D img_open_opts(filename, opts, flags, writethrough, qui=
et,
>                              force_share);
>      } else {
> -        blk =3D img_open_file(filename, fmt, flags, writethrough, quie=
t,
> +        blk =3D img_open_file(filename, NULL, fmt, flags, writethrough=
, quiet,
>                              force_share);
>      }
>      return blk;
> @@ -2286,8 +2318,8 @@ static int img_convert(int argc, char **argv)
>           * That has to wait for bdrv_create to be improved
>           * to allow filenames in option syntax
>           */
> -        s.target =3D img_open_file(out_filename, out_fmt, flags,
> -                                 writethrough, quiet, false);
> +        s.target =3D img_open_new_file(out_filename, opts, out_fmt,
> +                                     flags, writethrough, quiet, false=
);
>      }
>      if (!s.target) {
>          ret =3D -1;
> @@ -4351,7 +4383,7 @@ static int img_dd(int argc, char **argv)
>       * with the bdrv_create() call above which does not
>       * support image-opts style.
>       */
> -    blk2 =3D img_open_file(out.filename, out_fmt, BDRV_O_RDWR,
> +    blk2 =3D img_open_file(out.filename, NULL, out_fmt, BDRV_O_RDWR,
>                           false, false, false);
> =20
>      if (!blk2) {
>=20



--5oSjNrDpF9TMmst0t5srtwjccgsoPxkeJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZGeizEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJ04
B/9af+5Ym1Zl+U4Ug3UY0Px7G//mmIf6Ij+PikEhE0tYkqEvOnkeUpQNYTExt0p8
/kqlPky37QD9J+i19uwpvk/qVnHcAHnjmNH70HShrFk/Wm9QJpQQOZ3y5e67lG6B
5pngoCkIB7V7f5hWPT+oAeepgXdz4QwHDLevRoHPrfVZpeBpqwAB+Pp8aN/atXZk
unJmWmtvkbqRD+U9iTFTXLVB9G1USWLIjhywP51rs+iZUgPjzpTFsWC8PwDWba2R
EvM90iesl0F9tFw3PGiCpgJOkSyD5N9C6WUV1ji+mfFeuycTkQ39KM+up6S6UJe+
4lpngcDUxieuFxqwAbjl97TT
=fY37
-----END PGP SIGNATURE-----

--5oSjNrDpF9TMmst0t5srtwjccgsoPxkeJ--
