Received: from eggs.gnu.org ([2001:4830:134:3::10]:43464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d60Ih-0003w3-Uz
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d60Ig-0005UB-Vc
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:51:04 -0400
References: <20170502144744.26815-1-berrange@redhat.com>
	<20170502144744.26815-4-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2f99bd19-4a9d-850e-ed56-7b998797c6a6@redhat.com>
Date: Wed, 3 May 2017 21:50:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170502144744.26815-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MUxq0woJM9qrGcgsaM5wrij7jhgNCrqTE"
Subject: Re: [Qemu-devel] [PATCH v7 3/4] qemu-img: introduce
 --target-image-opts for 'convert' command
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
--MUxq0woJM9qrGcgsaM5wrij7jhgNCrqTE
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <2f99bd19-4a9d-850e-ed56-7b998797c6a6@redhat.com>
Subject: Re: [PATCH v7 3/4] qemu-img: introduce --target-image-opts for
 'convert' command
References: <20170502144744.26815-1-berrange@redhat.com>
 <20170502144744.26815-4-berrange@redhat.com>
In-Reply-To: <20170502144744.26815-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.05.2017 16:47, Daniel P. Berrange wrote:
> The '--image-opts' flag indicates whether the source filename
> includes options. The target filename has to remain in the
> plain filename format though, since it needs to be passed to
> bdrv_create().  When using --skip-create though, it would be
> possible to use image-opts syntax. This adds --target-image-opts
> to indicate that the target filename includes options. Currently
> this mandates use of the --skip-create flag too.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Sure you want to keep this, considering that there are quite some
changes since v5?

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img-cmds.hx |  4 +--
>  qemu-img.c       | 77 +++++++++++++++++++++++++++++++++++++-----------=
--------
>  qemu-img.texi    | 12 +++++++--
>  3 files changed, 63 insertions(+), 30 deletions(-)

[...]

> diff --git a/qemu-img.c b/qemu-img.c
> index d8fdcb1..94c8cea 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -1900,7 +1901,7 @@ static int img_convert(int argc, char **argv)
>      char *options =3D NULL;
>      Error *local_err =3D NULL;
>      bool writethrough, src_writethrough, quiet =3D false, image_opts =3D=
 false,
> -         skip_create =3D false, progress =3D false;
> +        skip_create =3D false, progress =3D false, tgt_image_opts =3D =
false;

Not sure about the indentation here. (I personally don't like spanning
the declaration over multiple lines in the first place, but that's a
different topic.) Indenting consecutive lines by four spaces is
standard, but the indentation by five spaces had a reason.

I guess I'd personally rather keep the five-space indentation...

>      int64_t ret =3D -EINVAL;
> =20
>      ImgConvertState s =3D (ImgConvertState) {

[...]

> @@ -2047,12 +2056,22 @@ static int img_convert(int argc, char **argv)
>          goto fail_getopt;
>      }
> =20
> +    if (tgt_image_opts && !skip_create) {
> +        error_report("--target-image-opts requires use of -n flag");
> +        goto fail_getopt;
> +    }
> +
>      s.src_num =3D argc - optind - 1;
>      out_filename =3D s.src_num >=3D 1 ? argv[argc - 1] : NULL;
> =20
>      if (options && has_help_option(options)) {
> -        ret =3D print_block_option_help(out_filename, out_fmt);
> -        goto fail_getopt;
> +        if (out_fmt) {
> +            ret =3D print_block_option_help(out_filename, out_fmt);
> +            goto out;

Shouldn't this remain goto fail_getopt;?

> +        } else {
> +            error_report("Option help requires a format be specified")=
;
> +            goto fail_getopt;
> +        }
>      }
> =20
>      if (s.src_num < 1) {

[...]

Why did you remove the compress &&
!out_bs->drv->bdrv_co_pwritev_compressed check? I liked it. :-(

Max


--MUxq0woJM9qrGcgsaM5wrij7jhgNCrqTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkKNJkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9iUIAJOVA5OEA2AA9BEkZu4jm+vw/rQ2VpfQ
/l00j4P4gjeDjLx/l5n5DXwxmEfBcm7yYssLu20KSL/DohYenb9jH4Iw2ne1Y9On
MXh/p/x4Gh2ONUyyiaGt0Cd9Pf1dFfYblJKuQTtVpTzpSOccZOFnWax4CFT4S/06
CMfEakdcQ2q8kf6lRy5qGWzeavKnNRC22yBVOQPZaVymY6peSBgl6kvdF8RytGcZ
jrIZIffF9cXvL4LKxKV7J1UJm8yXUuK3nCCReJFGB6Pcf2cioGYJBVX1tPEibDgG
hnyMZBBZBmfuic5BU3G1wSbCG1dHoYXdlsmHVTUxlrgQlcfVJbUOCKI=
=Fy+v
-----END PGP SIGNATURE-----

--MUxq0woJM9qrGcgsaM5wrij7jhgNCrqTE--
